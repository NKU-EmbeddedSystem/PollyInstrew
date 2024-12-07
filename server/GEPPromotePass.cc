#include "GEPPromotePass.h"
#include "ScopPass.h"
#include <asm-generic/errno-base.h>
#include <cassert>
#include <llvm/ADT/ArrayRef.h>
#include <llvm/ADT/DenseMap.h>
#include <llvm/ADT/DenseMapInfo.h>
#include <llvm/ADT/SmallPtrSet.h>
#include <llvm/ADT/SmallVector.h>
#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/Analysis/AssumptionCache.h>
#include <llvm/Analysis/LoopAnalysisManager.h>
#include <llvm/Analysis/ScalarEvolution.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Dominators.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/InstrTypes.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/IntrinsicInst.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/PassManager.h>
#include <llvm/Support/Casting.h>
#include <llvm/Analysis/ValueTracking.h>
#include <llvm/Analysis/InstructionSimplify.h>
#include <llvm/Analysis//IteratedDominanceFrontier.h>
#include <llvm/Support/raw_ostream.h>
#include <map>
#include <vector>

using namespace llvm;

struct RestoreSI{
  Value* val;
  Value* ptr;
  Instruction* loc;
};

static int NumSingelStoreGEP = 0;//NumSingleStore for GEP
int NumPromoteGEP = 0;
std::map<GetElementPtrInst*,Type*> GEPStoreType;
std::vector<GetElementPtrInst*> LocalGEP;
std::map<GetElementPtrInst*,struct RestoreSI> RestoreSIs;
BasicBlock* ExitBlock;

namespace{

struct GEPInfo{
  SmallVector<BasicBlock *,32> DefiningBlocks;
  SmallVector<BasicBlock *,32> UsingBlocks;

  StoreInst *OnlyStore;
  BasicBlock *OnlyBlock;
  bool OnlyUsedInOneBlock;

  void clear(){
    DefiningBlocks.clear();
    UsingBlocks.clear();
    OnlyStore = nullptr;
    OnlyBlock = nullptr;
    OnlyUsedInOneBlock = true;
  }

  void AnalyzeGEP(GetElementPtrInst *GEP){
    clear();

    // As we scan the uses of the GEP instruction, keep track of stores,
    // and decide whether all of the loads and stores to the alloca are within
    // the same basic block.
    for (User *U : GEP->users()) {
      Instruction *User = cast<Instruction>(U);
      if (StoreInst *SI = dyn_cast<StoreInst>(User)) {
        // Remember the basic blocks which define new values for the alloca
        GEPStoreType[GEP] = SI->getValueOperand()->getType();
        DefiningBlocks.push_back(SI->getParent());
        OnlyStore = SI;
      } else {
        LoadInst *LI = cast<LoadInst>(User);
        // Otherwise it must be a load instruction, keep track of variable
        // reads.
        UsingBlocks.push_back(LI->getParent());
      }
      // 不过实际上GEP指令的user也可能是一个cast相关的，好消息是cast不影响
      // 坏消息是实际上GEP会通过使用PHI阶段传来传去
      // 能够实现PHI节点之间传递的识别吗->已实现

      if (OnlyUsedInOneBlock) {
        if (!OnlyBlock)
          OnlyBlock = User->getParent();
        else if (OnlyBlock != User->getParent())
          OnlyUsedInOneBlock = false;
      }
    }

  }
};

/// This assigns and keeps a per-bb relative ordering of load/store
/// instructions in the block that directly load or store an alloca.
///
/// This functionality is important because it avoids scanning large basic
/// blocks multiple times when promoting many allocas in the same block.
class LargeBlockInfo {
  /// For each instruction that we track, keep the index of the
  /// instruction.
  ///
  /// The index starts out as the number of the instruction from the start of
  /// the block.
  DenseMap<const Instruction *, unsigned> InstNumbers;

public:

  static bool isInterestingInstruction(const Instruction *I) {
    return (isa<LoadInst>(I) && isa<GetElementPtrInst>(I->getOperand(0))) ||
      (isa<StoreInst>(I) && isa<GetElementPtrInst>(I->getOperand(1)));
  }

  /// Get or calculate the index of the specified instruction.
  unsigned getInstructionIndex(const Instruction *I) {
    assert(isInterestingInstruction(I) &&
           "Not a load/store to/from an alloca?");

    // If we already have this instruction number, return it.
    DenseMap<const Instruction *, unsigned>::iterator It = InstNumbers.find(I);
    if (It != InstNumbers.end())
      return It->second;

    // Scan the whole block to get the instruction.  This accumulates
    // information for every interesting instruction in the block, in order to
    // avoid gratuitus rescans.
    const BasicBlock *BB = I->getParent();
    unsigned InstNo = 0;
    for (const Instruction &BBI : *BB)
      if (isInterestingInstruction(&BBI))
        InstNumbers[&BBI] = InstNo++;
    It = InstNumbers.find(I);

    assert(It != InstNumbers.end() && "Didn't insert instruction?");
    return It->second;
  }

  void deleteValue(const Instruction *I) { InstNumbers.erase(I); }

  void clear() { InstNumbers.clear(); }
};

struct RenamePassData {
  using ValVector = std::vector<Value *>;
  using LocationVector = std::vector<DebugLoc>;

  RenamePassData(BasicBlock *B, BasicBlock *P, ValVector V, LocationVector L)
    : BB(B), Pred(P), Values(std::move(V)), Locations(std::move(L)) {}

  BasicBlock *BB;
  BasicBlock *Pred;
  ValVector Values;
  LocationVector Locations;
};

struct GEPpromoteMem2Reg{
  // The GEP Instruction being Promoted
  std::vector<GetElementPtrInst *> GEPs;

  DominatorTree &DT;

  AssumptionCache *AC;

  const SimplifyQuery SQ;//what for??

  DenseMap<GetElementPtrInst*,unsigned> GEPLookup;

  DenseMap<std::pair<unsigned,unsigned>,PHINode*> NewPhiNodes;

  DenseMap<PHINode *,unsigned> PhiToGEPMap;
  SmallPtrSet<BasicBlock*,16> Visited;

  DenseMap<BasicBlock*,unsigned> BBNumbers;

  DenseMap<const BasicBlock*, unsigned> BBNumPreds;

public:
  GEPpromoteMem2Reg(ArrayRef<GetElementPtrInst*> GEPs,DominatorTree &DT, AssumptionCache *AC):
    GEPs(GEPs.begin(),GEPs.end()),DT(DT),AC(AC),SQ(DT.getRoot()->getParent()->getParent()->getDataLayout(),
                                                   nullptr,&DT,AC){}
  void run();

private:
  void RemoveFromGEPsList(unsigned &GEPIdx) {
    GEPs[GEPIdx] = GEPs.back();
    GEPs.pop_back();
    --GEPIdx;
  }

  unsigned getNumPreds(const BasicBlock *BB) {
    unsigned &NP = BBNumPreds[BB];
    if (NP == 0)
      NP = pred_size(BB) + 1;
    return NP - 1;
  }

  void ComputeLiveInBlocks(GetElementPtrInst *GEP, GEPInfo &Info,
                           const SmallPtrSetImpl<BasicBlock *> &DefBlocks,
                           SmallPtrSetImpl<BasicBlock *> &LiveInBlocks);
  void RenamePass(BasicBlock *BB, BasicBlock *Pred,
                  RenamePassData::ValVector &IncVals,
                  RenamePassData::LocationVector &IncLocs,
                  std::vector<RenamePassData> &Worklist);
  bool QueuePhiNode(BasicBlock *BB, unsigned GEPNo, unsigned &Version);

};
}


void analyzeLocalGEP(Function &F);
bool isGEPPromotable(const GetElementPtrInst* GEP);
bool GEPpromoteMemToRegister(Function &F, DominatorTree &DT,AssumptionCache &AC,ScalarEvolution &SE);
void GEPpromoteMemToReg(ArrayRef<GetElementPtrInst*> GEPs,DominatorTree &DT,AssumptionCache *AC);
bool GEPrewriteSingleStore(GetElementPtrInst *GEP, GEPInfo &Info,
                           LargeBlockInfo &LBI, const DataLayout &DL,
                           DominatorTree &DT, AssumptionCache *AC);
void GEPaddAssumeNonNull(AssumptionCache *AC, LoadInst *LI);
bool GEPpromoteSingleBlock(GetElementPtrInst *GEP, const GEPInfo &Info,
                           LargeBlockInfo &LBI,
                           const DataLayout &DL,
                           DominatorTree &DT,
                           AssumptionCache *AC);
void GEPupdateForIncomingValueLocation(PHINode *PN, DebugLoc DL,bool ApplyMergedLoc);
void restoreGEPstore(ScalarEvolution &SE);

void restoreGEPstore(ScalarEvolution &SE){
  for(auto &item:RestoreSIs){
    if(dyn_cast<Constant>(item.second.val)) continue;
    StoreInst* newSI = new StoreInst(item.second.val,item.second.ptr,false,&ExitBlock->front());
}
}

void GEPupdateForIncomingValueLocation(PHINode *PN, DebugLoc DL,bool ApplyMergedLoc) {
  if (ApplyMergedLoc)
    PN->applyMergedLocation(PN->getDebugLoc(), DL);
  else
    PN->setDebugLoc(DL);
}

void GEPpromoteMem2Reg::ComputeLiveInBlocks(GetElementPtrInst *GEP, GEPInfo &Info,
                                            const SmallPtrSetImpl<BasicBlock *> &DefBlocks,
                                            SmallPtrSetImpl<BasicBlock *> &LiveInBlocks){
  // To determine liveness, we must iterate through the predecessors of blocks
  // where the def is live.  Blocks are added to the worklist if we need to
  // check their predecessors.  Start with all the using blocks.
  SmallVector<BasicBlock *, 64> LiveInBlockWorklist(Info.UsingBlocks.begin(),
                                                    Info.UsingBlocks.end());

  // If any of the using blocks is also a definition block, check to see if the
  // definition occurs before or after the use.  If it happens before the use,
  // the value isn't really live-in.
  for (unsigned i = 0, e = LiveInBlockWorklist.size(); i != e; ++i) {
    BasicBlock *BB = LiveInBlockWorklist[i];
    if (!DefBlocks.count(BB))
      continue;

    // Okay, this is a block that both uses and defines the value.  If the first
    // reference to the alloca is a def (store), then we know it isn't live-in.
    for (BasicBlock::iterator I = BB->begin();; ++I) {
      if (StoreInst *SI = dyn_cast<StoreInst>(I)) {
        if (SI->getOperand(1) != GEP)
          continue;

        // We found a store to the alloca before a load.  The alloca is not
        // actually live-in here.
        LiveInBlockWorklist[i] = LiveInBlockWorklist.back();
        LiveInBlockWorklist.pop_back();
        --i;
        --e;
        break;
      }

      if (LoadInst *LI = dyn_cast<LoadInst>(I))
        // Okay, we found a load before a store to the alloca.  It is actually
        // live into this block.
        if (LI->getOperand(0) == GEP)
          break;
    }
  }

  // Now that we have a set of blocks where the phi is live-in, recursively add
  // their predecessors until we find the full region the value is live.
  while (!LiveInBlockWorklist.empty()) {
    BasicBlock *BB = LiveInBlockWorklist.pop_back_val();

    // The block really is live in here, insert it into the set.  If already in
    // the set, then it has already been processed.
    if (!LiveInBlocks.insert(BB).second)
      continue;

    // Since the value is live into BB, it is either defined in a predecessor or
    // live into it to.  Add the preds to the worklist unless they are a
    // defining block.
    for (BasicBlock *P : predecessors(BB)) {
      // The value is not live into a predecessor if it defines the value.
      if (DefBlocks.count(P))
        continue;

      // Otherwise it is, add to the worklist.
      LiveInBlockWorklist.push_back(P);
    }
  }

}
void GEPpromoteMem2Reg::RenamePass(BasicBlock *BB, BasicBlock *Pred,
                                   RenamePassData::ValVector &IncVals,
                                   RenamePassData::LocationVector &IncLocs,
                                   std::vector<RenamePassData> &Worklist){
NextIteration:
  // If we are inserting any phi nodes into this BB, they will already be in the
  // block.
  if (PHINode *APN = dyn_cast<PHINode>(BB->begin())) {
    // If we have PHI nodes to update, compute the number of edges from Pred to
    // BB.
    if (PhiToGEPMap.count(APN)) {
      // We want to be able to distinguish between PHI nodes being inserted by
      // this invocation of mem2reg from those phi nodes that already existed in
      // the IR before mem2reg was run.  We determine that APN is being inserted
      // because it is missing incoming edges.  All other PHI nodes being
      // inserted by this pass of mem2reg will have the same number of incoming
      // operands so far.  Remember this count.
      unsigned NewPHINumOperands = APN->getNumOperands();

      unsigned NumEdges = llvm::count(successors(Pred), BB);
      assert(NumEdges && "Must be at least one edge from Pred to BB!");

      // Add entries for all the phis.
      BasicBlock::iterator PNI = BB->begin();
      do {
        unsigned GEPNo = PhiToGEPMap[APN];

        // Update the location of the phi node.
        GEPupdateForIncomingValueLocation(APN, IncLocs[GEPNo],
                                          APN->getNumIncomingValues() > 0);

        // Add N incoming values to the PHI node.
        for (unsigned i = 0; i != NumEdges; ++i)
          APN->addIncoming(IncVals[GEPNo], Pred);

        // The currently active variable for this block is now the PHI.
        IncVals[GEPNo] = APN;

        // Get the next phi node.
        ++PNI;
        APN = dyn_cast<PHINode>(PNI);
        if (!APN)
          break;

        // Verify that it is missing entries.  If not, it is not being inserted
        // by this mem2reg invocation so we want to ignore it.
      } while (APN->getNumOperands() == NewPHINumOperands);
    }
  }

  // Don't revisit blocks.
  if (!Visited.insert(BB).second)
    return;

  for (BasicBlock::iterator II = BB->begin(); !II->isTerminator();) {
    Instruction *I = &*II++; // get the instruction, increment iterator

    if (LoadInst *LI = dyn_cast<LoadInst>(I)) {
      GetElementPtrInst *Src = dyn_cast<GetElementPtrInst>(LI->getPointerOperand());
      if (!Src)
        continue;

      DenseMap<GetElementPtrInst *, unsigned>::iterator GEP = GEPLookup.find(Src);
      if (GEP ==GEPLookup.end())
        continue;

      Value *V = IncVals[GEP->second];

      // If the load was marked as nonnull we don't want to lose
      // that information when we erase this Load. So we preserve
      // it with an assume.
      if (AC && LI->getMetadata(LLVMContext::MD_nonnull) &&
          !isKnownNonZero(V, SQ.DL, 0, AC, LI, &DT))
        GEPaddAssumeNonNull(AC, LI);

      // Anything using the load now uses the current value.
      LI->replaceAllUsesWith(V);
      BB->getInstList().erase(LI);
    } else if (StoreInst *SI = dyn_cast<StoreInst>(I)) {
      // Delete this instruction and mark the name as the current holder of the
      // value
      GetElementPtrInst *Dest = dyn_cast<GetElementPtrInst>(SI->getPointerOperand());
      if (!Dest)
        continue;

      DenseMap<GetElementPtrInst *, unsigned>::iterator gep = GEPLookup.find(Dest);
      if (gep == GEPLookup.end())
        continue;
      //[By add]
      // what value were we writing?
      RestoreSI newSI;
      newSI.val=SI->getOperand(0);
      newSI.ptr=gep->first;
      newSI.loc=SI->getNextNode();
    RestoreSIs[gep->first]=newSI;

      unsigned GEPNo = gep->second;
      IncVals[GEPNo] = SI->getOperand(0);
      //TODO：这里涉及store指令的删除，可能根据后续需要进行修改
      // Record debuginfo for the store before removing it.
      IncLocs[GEPNo] = SI->getDebugLoc();
      BB->getInstList().erase(SI);
    }
  }

  // 'Recurse' to our successors.
  succ_iterator I = succ_begin(BB), E = succ_end(BB);
  if (I == E)
    return;

  // Keep track of the successors so we don't visit the same successor twice
  SmallPtrSet<BasicBlock *, 8> VisitedSuccs;

  // Handle the first successor without using the worklist.
  VisitedSuccs.insert(*I);
  Pred = BB;
  BB = *I;
  ++I;

  for (; I != E; ++I)
    if (VisitedSuccs.insert(*I).second)
      Worklist.emplace_back(*I, Pred, IncVals, IncLocs);

  goto NextIteration;
}

bool GEPpromoteMem2Reg::QueuePhiNode(BasicBlock *BB, unsigned GEPNo, unsigned &Version){
  // Look up the basic-block in question.
  PHINode *&PN = NewPhiNodes[std::make_pair(BBNumbers[BB], GEPNo)];

  // If the BB already has a phi node added for the i'th alloca then we're done!
  if (PN)
    return false;

  // Create a PhiNode using the dereferenced type... and add the phi-node to the
  // BasicBlock.
  PN = PHINode::Create(GEPStoreType[GEPs[GEPNo]], getNumPreds(BB),
                       GEPs[GEPNo]->getName() + "." + Twine(Version++),
                       &BB->front());
  PhiToGEPMap[PN] = GEPNo;
  return true;

}


bool GEPpromoteSingleBlock(GetElementPtrInst *GEP, const GEPInfo &Info,
                           LargeBlockInfo &LBI,
                           const DataLayout &DL,
                           DominatorTree &DT,
                           AssumptionCache *AC){
  using StoresByIndexTy = SmallVector<std::pair<unsigned, StoreInst *>, 64>;
  StoresByIndexTy StoresByIndex;

  for (User *U : GEP->users())
    if (StoreInst *SI = dyn_cast<StoreInst>(U))
      StoresByIndex.push_back(std::make_pair(LBI.getInstructionIndex(SI), SI));

  // Sort the stores by their index, making it efficient to do a lookup with a
  // binary search.
  llvm::sort(StoresByIndex, less_first());

  // Walk all of the loads from this alloca, replacing them with the nearest
  // store above them, if any.
  for (User *U : make_early_inc_range(GEP->users())) {
    LoadInst *LI = dyn_cast<LoadInst>(U);
    if (!LI)
      continue;

    unsigned LoadIdx = LBI.getInstructionIndex(LI);

    // Find the nearest store that has a lower index than this load.
    StoresByIndexTy::iterator I = llvm::lower_bound(
                                                    StoresByIndex,
                                                    std::make_pair(LoadIdx, static_cast<StoreInst *>(nullptr)),
                                                    less_first());
    Value *ReplVal;
    if (I == StoresByIndex.begin()) {
      if (StoresByIndex.empty())
        // If there are no stores, the load takes the undef value.
        ReplVal = UndefValue::get(LI->getType());
      else
        // There is no store before this load, bail out (load may be affected
        // by the following stores - see main comment).
        return false;
    } else {
      // Otherwise, there was a store before this load, the load takes its
      // value.
      ReplVal = std::prev(I)->second->getOperand(0);
    }

    // Note, if the load was marked as nonnull we don't want to lose that
    // information when we erase it. So we preserve it with an assume.
    if (AC && LI->getMetadata(LLVMContext::MD_nonnull) &&
        !isKnownNonZero(ReplVal, DL, 0, AC, LI, &DT))
      GEPaddAssumeNonNull(AC, LI);

    // If the replacement value is the load, this must occur in unreachable
    // code.
    if (ReplVal == LI)
      ReplVal = PoisonValue::get(LI->getType());

    LI->replaceAllUsesWith(ReplVal);
    LI->eraseFromParent();
    LBI.deleteValue(LI);
  }

  // Remove the (now dead) stores and alloca.alloc（GEP）不删除
  //  while (!GEP->use_empty()) {
  //    StoreInst *SI = cast<StoreInst>(GEP->user_back());
  //    SI->eraseFromParent();
  //    LBI.deleteValue(SI);
  //  }
  //暂时不可以删除GEP
  //TODO
  //暂时删除GEP
  // GEP->eraseFromParent();//！！！暂时删除

  return true;
}



void GEPaddAssumeNonNull(AssumptionCache *AC, LoadInst *LI){
  Function *AssumeIntrinsic =
    Intrinsic::getDeclaration(LI->getModule(), Intrinsic::assume);
  ICmpInst *LoadNotNull = new ICmpInst(ICmpInst::ICMP_NE, LI,
                                       Constant::getNullValue(LI->getType()));
  LoadNotNull->insertAfter(LI);
  CallInst *CI = CallInst::Create(AssumeIntrinsic, {LoadNotNull});
  CI->insertAfter(LoadNotNull);
  AC->registerAssumption(cast<AssumeInst>(CI));
}

bool GEPrewriteSingleStore(GetElementPtrInst *GEP, GEPInfo &Info,
                           LargeBlockInfo &LBI, const DataLayout &DL,
                           DominatorTree &DT, AssumptionCache *AC) {
//  llvm::outs()<<*GEP<<"start\n";
  StoreInst *OnlyStore = Info.OnlyStore;
  bool StoringGlobalVal = !isa<Instruction>(OnlyStore->getOperand(0));
  BasicBlock *StoreBB = OnlyStore->getParent();
  int StoreIndex = -1;

  Info.UsingBlocks.clear();

  for (User *U : make_early_inc_range(GEP->users())) {
    Instruction *UserInst = cast<Instruction>(U);
    if (UserInst == OnlyStore)
      continue;
    LoadInst *LI = cast<LoadInst>(UserInst);

    if (!StoringGlobalVal) { 
      if (LI->getParent() == StoreBB) {
        if (StoreIndex == -1)
          StoreIndex = LBI.getInstructionIndex(OnlyStore);

        if (unsigned(StoreIndex) > LBI.getInstructionIndex(LI)) {
          Info.UsingBlocks.push_back(StoreBB);
          continue;
        }
      } else if (!DT.dominates(StoreBB, LI->getParent())) {
        Info.UsingBlocks.push_back(LI->getParent());
        continue;
      }
    }

    Value *ReplVal = OnlyStore->getOperand(0);

    if (ReplVal == LI)
      ReplVal = PoisonValue::get(LI->getType());

    // If the load was marked as nonnull we don't want to lose
    // that information when we erase this Load. So we preserve
    // it with an assume.
    if (AC && LI->getMetadata(LLVMContext::MD_nonnull) &&
        !isKnownNonZero(ReplVal, DL, 0, AC, LI, &DT))
      GEPaddAssumeNonNull(AC, LI);

    // 这一步是必要的
    LI->replaceAllUsesWith(ReplVal);
    // load也应当被删除
    LI->eraseFromParent();
    LBI.deleteValue(LI);
  }

//  llvm::outs()<<*GEP<<"end\n";
  // Finally, after the scan, check to see if the store is all that is left.
  if (!Info.UsingBlocks.empty()){
    return false; // If not, we'll have to fall back for the remainder.
  }
  // store以及GEP指令暂时不能够删除，留作后续分析
  //  暂时删除store指令，后续分析哪些应该保留，以及怎样保留
  //llvm::outs()<<*Info.OnlyStore<<"\n";
  //  Info.OnlyStore->eraseFromParent();//！！暂时删除
  //  LBI.deleteValue(Info.OnlyStore);//！！！暂时删除
  //llvm::outs()<<*GEP<<"  I have problem\n";
  //  GEP->eraseFromParent();//！！！！暂时删除
  return true;
}

PreservedAnalyses GEPPromotePass::run(Function &F,FunctionAnalysisManager &AM){
//  llvm::outs()<<"[PROMOTE]-start\n";
  auto &DT = AM.getResult<DominatorTreeAnalysis>(F);
  auto &AC = AM.getResult<AssumptionAnalysis>(F);
  auto &SE = AM.getResult<ScalarEvolutionAnalysis>(F);
  if(!GEPpromoteMemToRegister(F,DT,AC,SE)){
    return PreservedAnalyses::all();
  }

  
  return PreservedAnalyses::none();
}

void GEPpromoteMem2Reg::run(){
  Function &F = *DT.getRoot()->getParent();

  GEPInfo Info;
  LargeBlockInfo LBI;
  ForwardIDFCalculator IDF(DT);

//  llvm::outs()<<"GEPpromoteMem2Reg:start\n";
  for(unsigned GEPNum = 0; GEPNum != GEPs.size(); ++GEPNum){
    GetElementPtrInst * GEP = GEPs[GEPNum];

    //TODO:首先完成第一部分，即简单情况下的提升过程
    //原函数中调用这一函数是为了删除Alloc中非load和非store指令
    //因为真正和内存操作相关的是load和store
    //通过暂且的分析来看，这一优化和GEP无关
    //removeIntrinsicUsers(GEP);

    //判断use_empty没有必要
    //因为在目前的优化下GEP仅剩第一次指令
    //不可删除，要用来做函数参数
    if(GEP->use_empty()){
//        GEP->eraseFromParent();//！！！暂时删除
      RemoveFromGEPsList(GEPNum);
      ++NumPromoteGEP;
      continue;
    }

    Info.AnalyzeGEP(GEP);
    // No.1
    if(Info.DefiningBlocks.size() == 1){
      if(GEPrewriteSingleStore(GEP,Info,LBI,SQ.DL,DT,AC)){
        RemoveFromGEPsList(GEPNum);
    //    llvm::outs()<<"[1]"<<*GEP<<"\n";
        ++NumPromoteGEP;
        ++NumSingelStoreGEP;
        continue;
      }
    }

    
    // No.2
    if(Info.OnlyUsedInOneBlock &&
       GEPpromoteSingleBlock(GEP,Info,LBI,SQ.DL,DT,AC)){
      RemoveFromGEPsList(GEPNum);
    //  llvm::outs()<<"[2]"<<*GEP<<"\n";
      ++NumPromoteGEP;
      continue;
    }

    if(BBNumbers.empty()){
      unsigned ID = 0;
      for(auto& BB:F){
        BBNumbers[&BB] = ID++;
      }
    }

    //No.3
    // Keep the reverse mapping of the 'Allocas' array for the rename pass.
    GEPLookup[GEPs[GEPNum]] = GEPNum;

    // Unique the set of defining blocks for efficient lookup.
    SmallPtrSet<BasicBlock *, 32> DefBlocks(Info.DefiningBlocks.begin(),
                                            Info.DefiningBlocks.end());

    // Determine which blocks the value is live in.  These are blocks which lead
    // to uses.
    SmallPtrSet<BasicBlock *, 32> LiveInBlocks;
    ComputeLiveInBlocks(GEP, Info, DefBlocks, LiveInBlocks);

    // At this point, we're committed to promoting the alloca using IDF's, and
    // the standard SSA construction algorithm.  Determine which blocks need phi
    // nodes and see if we can optimize out some work by avoiding insertion of
    // dead phi nodes.
    IDF.setLiveInBlocks(LiveInBlocks);
    IDF.setDefiningBlocks(DefBlocks);
    SmallVector<BasicBlock *, 32> PHIBlocks;
    IDF.calculate(PHIBlocks);
    llvm::sort(PHIBlocks, [this](BasicBlock *A, BasicBlock *B) {
               return BBNumbers.find(A)->second < BBNumbers.find(B)->second;
               });

    unsigned CurrentVersion = 0;
    for (BasicBlock *BB : PHIBlocks)
      QueuePhiNode(BB, GEPNum, CurrentVersion);
  }

  if (GEPs.empty())
    return; // All of the allocas must have been trivial!

  LBI.clear();  
  // Set the incoming values for the basic block to be null values for all of
  // the alloca's.  We do this in case there is a load of a value that has not
  // been stored yet.  In this case, it will get this null value.
  RenamePassData::ValVector Values(GEPs.size());
  for (unsigned i = 0, e = GEPs.size(); i != e; ++i){
 //   llvm::outs()<<"[3]"<<*GEPs[i]<<"\n";
 //   if(GEPStoreType[GEPs[i]]==nullptr){
 //     llvm::outs()<<"nullptr error\n";
 //   } 
  //  for(const User *U : GEPs[i]->users()){
  //    llvm::outs()<<*U<<"\n";
  //  }

    Values[i] = UndefValue::get(GEPStoreType[GEPs[i]]);
  }

  // When handling debug info, treat all incoming values as if they have unknown
  // locations until proven otherwise.
  RenamePassData::LocationVector Locations(GEPs.size());

  // Walks all basic blocks in the function performing the SSA rename algorithm
  // and inserting the phi nodes we marked as necessary
  std::vector<RenamePassData> RenamePassWorkList;
  RenamePassWorkList.emplace_back(&F.front(), nullptr, std::move(Values),
                                  std::move(Locations));
  do {
    RenamePassData RPD = std::move(RenamePassWorkList.back());
    RenamePassWorkList.pop_back();
    // RenamePass may add new worklist entries.
    RenamePass(RPD.BB, RPD.Pred, RPD.Values, RPD.Locations, RenamePassWorkList);
  } while (!RenamePassWorkList.empty());

  // The renamer uses the Visited set to avoid infinite loops.  Clear it now.
  Visited.clear();

  // Remove the allocas themselves from the function.
  for (Instruction *G : GEPs) {
    // If there are any uses of the alloca instructions left, they must be in
    // unreachable basic blocks that were not processed by walking the dominator
    // tree. Just delete the users now.
    if (!G->use_empty())
      G->replaceAllUsesWith(PoisonValue::get(G->getType()));
    //暂时不可以删除哈
  //  G->eraseFromParent();
    //++NumPromoteGEP;
  }

  //llvm::outs()<<"GEPpromoteMem2Reg:temp\n";

  //TODO
  // Loop over all of the PHI nodes and see if there are any that we can get
  // rid of because they merge all of the same incoming values.  This can
  // happen due to undef values coming into the PHI nodes.  This process is
  // iterative, because eliminating one PHI node can cause others to be removed.
  bool EliminatedAPHI = true;
  while (EliminatedAPHI) {
    EliminatedAPHI = false;

    // Iterating over NewPhiNodes is deterministic, so it is safe to try to
    // simplify and RAUW them as we go.  If it was not, we could add uses to
    // the values we replace with in a non-deterministic order, thus creating
    // non-deterministic def->use chains.
    for (DenseMap<std::pair<unsigned, unsigned>, PHINode *>::iterator
         I = NewPhiNodes.begin(),
         E = NewPhiNodes.end();
         I != E;) {
      PHINode *PN = I->second;

      // If this PHI node merges one value and/or undefs, get the value.
      if (Value *V = simplifyInstruction(PN, SQ)) {
        PN->replaceAllUsesWith(V);
        PN->eraseFromParent();
        NewPhiNodes.erase(I++);
        EliminatedAPHI = true;
        continue;
      }
      ++I;
    }
  }

  // At this point, the renamer has added entries to PHI nodes for all reachable
  // code.  Unfortunately, there may be unreachable blocks which the renamer
  // hasn't traversed.  If this is the case, the PHI nodes may not
  // have incoming values for all predecessors.  Loop over all PHI nodes we have
  // created, inserting undef values if they are missing any incoming values.
  for (DenseMap<std::pair<unsigned, unsigned>, PHINode *>::iterator
       I = NewPhiNodes.begin(),
       E = NewPhiNodes.end();
       I != E; ++I) {
    // We want to do this once per basic block.  As such, only process a block
    // when we find the PHI that is the first entry in the block.
    PHINode *SomePHI = I->second;
    BasicBlock *BB = SomePHI->getParent();
    if (&BB->front() != SomePHI)
      continue;

    // Only do work here if there the PHI nodes are missing incoming values.  We
    // know that all PHI nodes that were inserted in a block will have the same
    // number of incoming values, so we can just check any of them.
    if (SomePHI->getNumIncomingValues() == getNumPreds(BB))
      continue;

    // Get the preds for BB.
    SmallVector<BasicBlock *, 16> Preds(predecessors(BB));

    // Ok, now we know that all of the PHI nodes are missing entries for some
    // basic blocks.  Start by sorting the incoming predecessors for efficient
    // access.
    auto CompareBBNumbers = [this](BasicBlock *A, BasicBlock *B) {
      return BBNumbers.find(A)->second < BBNumbers.find(B)->second;
    };
    llvm::sort(Preds, CompareBBNumbers);

    // Now we loop through all BB's which have entries in SomePHI and remove
    // them from the Preds list.
    for (unsigned i = 0, e = SomePHI->getNumIncomingValues(); i != e; ++i) {
      // Do a log(n) search of the Preds list for the entry we want.
      SmallVectorImpl<BasicBlock *>::iterator EntIt = llvm::lower_bound(
                                                                        Preds, SomePHI->getIncomingBlock(i), CompareBBNumbers);
      assert(EntIt != Preds.end() && *EntIt == SomePHI->getIncomingBlock(i) &&
             "PHI node has entry for a block which is not a predecessor!");

      // Remove the entry
      Preds.erase(EntIt);
    }

    // At this point, the blocks left in the preds list must have dummy
    // entries inserted into every PHI nodes for the block.  Update all the phi
    // nodes in this block that we are inserting (there could be phis before
    // mem2reg runs).
    unsigned NumBadPreds = SomePHI->getNumIncomingValues();
    BasicBlock::iterator BBI = BB->begin();
    while ((SomePHI = dyn_cast<PHINode>(BBI++)) &&
           SomePHI->getNumIncomingValues() == NumBadPreds) {
      Value *UndefVal = UndefValue::get(SomePHI->getType());
      for (BasicBlock *Pred : Preds)
        SomePHI->addIncoming(UndefVal, Pred);
    }
  }

  //llvm::outs()<<"over\n";
  NewPhiNodes.clear();
}

void GEPpromoteMemToReg(ArrayRef<GetElementPtrInst*> GEPs, DominatorTree &DT, AssumptionCache *AC){
  if(GEPs.empty())  return;
  GEPpromoteMem2Reg(GEPs,DT,AC).run();
}

bool isLocalGEP(const GetElementPtrInst *GEP){
  if(GetElementPtrInst* G = dyn_cast<GetElementPtrInst>(GEP->getOperand(0))){
    if(IntToPtrInst* iti = dyn_cast<IntToPtrInst>(G->getOperand(0))){
      if(iti->getOperand(0) == GEP->getParent()->getParent()->getArg(5)){
        return true;
      }
    }
  }
  else if(IntToPtrInst* iti = dyn_cast<IntToPtrInst>(GEP->getOperand(0))){
      if(iti->getOperand(0) == GEP->getParent()->getParent()->getArg(5)){
        return true;
      }
    }
    return false;
}

bool GEPpromoteMemToRegister(Function &F, DominatorTree &DT, AssumptionCache &AC,ScalarEvolution &SE){
  std::vector<GetElementPtrInst*> GEPs;
  bool Changed = false;
  // alloc只在入口块中含有，但是GEP并不是，所以需要遍历所有的基本快
  for(auto& BB:F){ 
    while(true){
      GEPs.clear();

      for(BasicBlock::iterator I=BB.begin(),E=BB.end();I!=E;++I){
        if(GetElementPtrInst* GEP = dyn_cast<GetElementPtrInst>(I)){ // Use GEP
                                                                     // But there is a question "Is GEP's situation the same as alloc?"
          if(isGEPPromotable(GEP)){
              llvm::outs()<<"[Instrew]GEP:"<<*GEP<<"\n";
              GEPs.push_back(GEP);
          }
        }
        else if(llvm::ReturnInst* RET = dyn_cast<ReturnInst>(I)){
          ExitBlock = &BB;
        }
      }
      //llvm::outs()<<" NumPromoteGEP:"<<NumPromoteGEP<<" GEPs.size():"<<GEPs.size()<<"\n";
      if(NumPromoteGEP == GEPs.size())  {
        //目前仅仅实现了SingleStore情况
        //所以 + 1临时用于debug
        //后期需要删除
        //临时debug用：
        //llvm::outs()<<"can break\n";
        break;
      }
      NumPromoteGEP = 0;
      //llvm::outs()<<"GEPs size:"<<GEPs.size()<<"\n";//临时加的，后面记得删掉
      GEPpromoteMemToReg(GEPs,DT,&AC);
      //llvm::outs()<<NumPromoteGEP<<"\n";
      //llvm::outs()<<"2GEPs size:"<<GEPs.size()<<"\n";//临时加的，后面记得删掉
      //    break;//临时加的，后面记得删掉
      //忽略NumPromoted
      Changed = true;
    }
    //break;//临时加的，后面记得删掉

  }
//  restoreGEPstore(SE);
  return Changed;
}

bool isGEPPromotable(const GetElementPtrInst *GEP){ 
  if(!isLocalGEP(GEP)){
//      llvm::outs()<<"[Instrew]is not Local GEP:"<<*GEP<<"\n";
    return false;
  }
  //需要区分
  //这里又是一个与alloc的区别之处
  //alloc的store删除只要保证函数功能正常执行，是没有语义上的错误的
  //但是GEP不同，需要识别出来不同的语义才能够确保优化正确
// 只有Load的情况怎么办呢？
  // 这里由于我们限制了GEP的使用场景
  // 仅仅适用于模拟堆栈操作的部分）
  // 所以这里对于load和store类型的判断暂且删除
  // (GEP从栈中拿出来都是i8，存的时候都用i32，但是不影响代码的正确性)
  llvm::outs()<<"[Instrew]GEP:"<<*GEP<<"\n";
  bool hasStore = false;
  for(const User *U : GEP->users()){    
    if (const LoadInst *LI = dyn_cast<LoadInst>(U)) {
      if (LI->isVolatile()){
       llvm::outs()<<"->[Instrew]LI is volatile\n";
          return false;
    }} else if (const StoreInst *SI = dyn_cast<StoreInst>(U)) {
      if (SI->getValueOperand() == GEP){
       llvm::outs()<<"->[Instrew]SI->getValueOperand() == GEP \n";
        return false; 
      }
      if (SI->isVolatile()){
       llvm::outs()<<"->[Instrew]SI is volatile\n";
        return false;
      }
      hasStore = true;
    } else if (const IntrinsicInst *II = dyn_cast<IntrinsicInst>(U)) {
      if (!II->isLifetimeStartOrEnd() && !II->isDroppable())
        return false;
    } else if (const BitCastInst *BCI = dyn_cast<BitCastInst>(U)) {
      if (!onlyUsedByLifetimeMarkersOrDroppableInsts(BCI))
        return false;
    } else if (const GetElementPtrInst *GEPI = dyn_cast<GetElementPtrInst>(U)) {
      if (!GEPI->hasAllZeroIndices())
        return false;
      if (!onlyUsedByLifetimeMarkersOrDroppableInsts(GEPI))
        return false;
    } else if (const AddrSpaceCastInst *ASCI = dyn_cast<AddrSpaceCastInst>(U)) {
      if (!onlyUsedByLifetimeMarkers(ASCI))
        return false;
    } else {
      return false;
    }
  }
  return hasStore;
}


