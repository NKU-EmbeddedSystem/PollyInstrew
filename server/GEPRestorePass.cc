#include "GEPRestorePass.h"
#include "CodeGen/IslAst.h"
#include "ScopDetectionDiagnostic.h"
#include "ScopInfo.h"
#include <cassert>
#include <cstdio>
#include <llvm/ADT/APInt.h>
#include <llvm/ADT/ArrayRef.h>
#include <llvm/ADT/BitmaskEnum.h>
#include <llvm/ADT/StringExtras.h>
#include <llvm/ADT/iterator.h>
#include <llvm/Analysis/ScalarEvolution.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Constant.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Dominators.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/GlobalVariable.h>
#include <llvm/IR/InstIterator.h>
#include <llvm/IR/InstrTypes.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/IntrinsicInst.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Metadata.h>
#include <llvm/IR/PassManager.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/Value.h>
#include <llvm/Support/Casting.h>
#include <llvm/Support/PointerLikeTypeTraits.h>
#include <llvm/Support/TypeSize.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Transforms/Utils/LoopUtils.h>
#include <polly/CodeGen/IslAst.h>
#include <polly/CodePreparation.h>
#include <polly/DependenceInfo.h>
#include <polly/ScopPass.h>
#include <unistd.h>
#include <vector>
#include <string>
#include <stack>

using namespace llvm;

struct RestoreGEP{
  GetElementPtrInst* GEP = nullptr;  //相关的GEP指令
  IntToPtrInst* ComputeITP= nullptr; //相关inttoptr指令
  Value* baseAddr = nullptr;   //数组基地址
  Type* elementType = nullptr;       //元素类型
  std::vector<unsigned> dimSize;     //获取到的维度大小
  std::vector<Value*> index;         //数组各维度索引，目前实际值均为PHINode*，但是也有可能是常数 FIXME
  RestoreGEP(GetElementPtrInst* gep, IntToPtrInst* ITP,Type* type):GEP(gep),ComputeITP(ITP),elementType(type){};
};

std::vector<RestoreGEP*> RestoreGEPs;
std::map<ConstantInt*,GlobalVariable*> AddrGV;
std::set<Instruction*> EraseInsts;
std::vector<InsertValueInst*> InsertValInsts; 
std::map<Value*,Value*> Stores;
BasicBlock* RestoreExitBlock;

void analyzeAddrIndex(RestoreGEP *RG, ScalarEvolution &SE);
void insertNewGEP(RestoreGEP *RG, LLVMContext &Ctx);
bool isArg(Function* F,Value* v);

bool isArg(Function* F,Value* v){
  Function::arg_iterator i = F->arg_begin();
  Function::arg_iterator e = F->arg_end();
  while(i!=e){
    if(i == v){
      return true;
    }
    i++;
  }
  return false;
}
void insertNewGEP(RestoreGEP *RG,LLVMContext &Ctx){
  //构建GEP数组类型
  //目前仅实现整数数组
  Type* EleType = nullptr;
  if(RG->elementType->getTypeID()==Type::TypeID::IntegerTyID){
    switch(RG->elementType->getIntegerBitWidth()){
    case 8:
      EleType = Type::getInt32Ty(Ctx);
      break;
    case 16:
      EleType = Type::getInt16Ty(Ctx);
      break;
    case 32:
      EleType = Type::getInt32Ty(Ctx);
      break;    
    case 64:
      EleType = Type::getInt64Ty(Ctx);
      break;
    case 128:
      EleType = Type::getInt128Ty(Ctx);
    default:
      EleType = Type::getInt64Ty(Ctx);
    }
  }
  else{
    //FIXME
    assert("unsupported Type\n");
  }

  llvm::Type *ty;
  if(RG->dimSize.empty()){
      ty=EleType;
  }
  else{
    ty = llvm::ArrayType::get(EleType,RG->dimSize[0]);
  //构建数组类型
    for(int i=1;i<RG->dimSize.size();i++){
        ty = llvm::ArrayType::get(ty,RG->dimSize[i]);
    }
  }
  //创建全局指针变量
  /**
  if(AddrGV.count(RG->baseAddr)==0){
 GlobalVariable* arrayBase= new GlobalVariable(*(RG->GEP->getParent()->getParent()->getParent()),Type::getInt64Ty(Ctx),false,GlobalVariable::LinkageTypes::ExternalLinkage,RG->baseAddr);

//    GlobalVariable* arrayBase= new GlobalVariable(Type::getInt64Ty(Ctx),false,GlobalVariable::LinkageTypes::ExternalLinkage);
    llvm::Metadata* lim = llvm::ConstantAsMetadata::get(RG->baseAddr);
    llvm::MDNode* node = llvm::MDNode::get(Ctx,{lim,lim});
    arrayBase->setMetadata("absolute_symbol",node);

    std::string arrName = "arr" + itostr(AddrGV.size());
    arrayBase->setName(arrName);
    AddrGV[RG->baseAddr] = arrayBase;
  }
**/
  Value* ptr = nullptr;
  Type* i64 = llvm::Type::getInt64Ty(Ctx);
  PointerType* ptrTy = PointerType::get(i64,64); 
  if(ConstantInt* cst = dyn_cast<ConstantInt>(RG->baseAddr)){
  Constant* intVal = ConstantInt::get(i64,cst->getZExtValue());
  ptr = ConstantExpr::getIntToPtr(intVal,ptrTy);
  }
  else{
    ptr = ConstantExpr::getIntToPtr((ConstantInt*)RG->baseAddr,ptrTy);
  }
  //assert(0);
  //根据指针、索引、类型插入GEP指令i
  //而且需要replace
  std::vector<Value*> GEPindex;
  //GEPindex.push_back(ConstantInt::get(Type::getInt64Ty(Ctx),0));
  for(int i=RG->index.size()-1;i>=0;i--){
    GEPindex.push_back(RG->index[i]);
  }
  ArrayRef<Value*> idXList(GEPindex);

  //创建新的GEP
  GetElementPtrInst* newGEP = GetElementPtrInst::CreateInBounds(ty,ptr,idXList,"",RG->GEP);
  //更换之前GEP所有的Use
  RG->GEP->replaceAllUsesWith(newGEP);
}

void analyzeAddrIndex(RestoreGEP *RG, ScalarEvolution &SE){
  std::queue<Value*> values;
  values.push(RG->ComputeITP);

  //先写入最低维度索引值，不过实际上这里可以不是zext，而是一个固定的值
  //因为常常有计算向某个特定位置写入值 FIXME
  Value* Index = nullptr;
  if(ZExtInst* zext = dyn_cast<ZExtInst>(RG->GEP->getOperand(1))){
    Index = zext;
    PHINode* phi = dyn_cast<PHINode>(zext->getOperand(0));
    assert(phi!=nullptr && "Not Phi");
    RG->index.push_back(zext);
  }
  else if(SExtInst* sext = dyn_cast<SExtInst>(RG->GEP->getOperand(1))){
    Index = sext;
    PHINode* phi = dyn_cast<PHINode>(sext->getOperand(0));
    //assert(phi!=nullptr && "Not Phi");
    RG->index.push_back(sext);
  }
  else if( ConstantInt* constantIndex = dyn_cast<ConstantInt>(RG->GEP->getOperand(1))){
    Index = constantIndex;
    RG->index.push_back(constantIndex);
  }
  else if(PHINode* phi = dyn_cast<PHINode>(RG->GEP->getOperand(1))){
    Index = phi;
    RG->index.push_back(phi);
  }
  else{
    llvm::errs()<<*RG->GEP->getOperand(1)<<"\n";
    assert("unkown");
    //RG->index.push_back(RG->GEP->getOperand(1));
}
    ////assert(Index!=nullptr && "Not ZExt");

 
  while(1){
    Value* I = values.front();
    values.pop();
    if(IntToPtrInst* i2p = dyn_cast<IntToPtrInst>(I)){
        if(isArg(RG->GEP->getParent()->getParent(),i2p->getOperand(0))){
        //if(false){
           RG->baseAddr = i2p->getOperand(0);
           break;
        }
        else{
           values.push(i2p->getOperand(0));
        }
    }
    else if(BinaryOperator* b = dyn_cast<BinaryOperator>(I)){
      //判断oprand是否是常数，如果是不用push，记录到index或者baseAddr中
      //如果不是，就需要push到队列里面，根据不同的计算类型来判断是基地址还是偏移量
      if(b->getOpcode()!=BinaryOperator::Add && b->getOpcode()!=BinaryOperator::Mul){
        assert("Wrong BinaryOperator Expr\n");
      }
      bool isAdd = (b->getOpcode()==BinaryOperator::Add)?true:false;

      values.push(b->getOperand(0));

      if(ConstantInt* cst = dyn_cast<ConstantInt>(b->getOperand(1))){
        if(isAdd){
          RG->baseAddr = cst;
        }
        else{
          RG->dimSize.push_back(cst->getZExtValue());
        }
      }
      else if(isArg(b->getParent()->getParent(),b->getOperand(1))&&isAdd){
        RG->baseAddr = b->getOperand(1);
      }
      else{
        values.push(b->getOperand(1));
      }
      EraseInsts.insert(b);
    }
    else if(ZExtInst* zt = dyn_cast<ZExtInst>(I)){
      RG->index.push_back(zt);
      if(values.empty()) break;
    }
    else if(SExtInst* st = dyn_cast<SExtInst>(I)){
      RG->index.push_back(st);
      if(values.empty()) break;
    }
    else if(LoadInst* load = dyn_cast<LoadInst>(I)){
      RG->baseAddr = load;
    }
    else{
        llvm::errs()<<*I<<"\n";
      //只可能出现以上三种情况，如果出现其他情况，需要更新代码，或者说程序出现了错误
      assert(0 && "Wrong Expr\n");
    }
  }

  //根据获取到的信息分析索引值
  assert(RG->baseAddr!=nullptr && "baseAddr Analysis failed\n");
  //assert(!RG->dimSize.empty() && "index Analysis failed\n");
  assert(!RG->index.empty() && "phi index analysis failed\n");
  assert(RG->dimSize.size()+1==RG->index.size() && "Unmatch index & dimSize size");

  //目前只有整数部分可以进行分析
  if((!RG->dimSize.empty()) && RG->elementType->getTypeID()==Type::TypeID::IntegerTyID){
    //根据元素类型分析对应维度大小（第一维度除外的其他维度）
    unsigned bitWidth = RG->elementType->getIntegerBitWidth();
    assert(bitWidth%8==0);

    unsigned ByteSize = bitWidth/8;
    assert(ByteSize != 0);
    RG->dimSize[0]/=ByteSize;
    for(int i = 1;i<RG->dimSize.size();i++){
      RG->dimSize[i]/=RG->dimSize[i-1]*ByteSize;
    }
  }
  else{
    //FIXME:实现其他元素类型
    assert("Unsupported Element Type\n");
  }
}


PreservedAnalyses GEPRestorePass::run(Function &F, FunctionAnalysisManager &AM){
  auto &SE = AM.getResult<ScalarEvolutionAnalysis>(F);
  auto I = llvm::inst_begin(F);
  auto E = llvm::inst_end(F);
  while(I!=E){
    Instruction* inst = &(*I);
    if(GetElementPtrInst* i = dyn_cast<GetElementPtrInst>(inst)){
      if(I->getPrevNode()==nullptr){
        I++;
        continue;
      }
      if(IntToPtrInst* pi = dyn_cast<IntToPtrInst>(i->getOperand(0))){
        if(dyn_cast<BinaryOperator>(pi->getOperand(0))){
          RestoreGEP* newRestoreGEP= new RestoreGEP(i,pi,i->getResultElementType());
          RestoreGEPs.push_back(newRestoreGEP);
        }
        else if(isArg(&F,pi->getOperand(0))&&(pi->getOperand(0)!=F.getArg(5))){
            RestoreGEP* newRestoreGEP = new RestoreGEP(i,pi,i->getResultElementType());
            RestoreGEPs.push_back(newRestoreGEP);
        }
      }
    }
    else if(InsertValueInst* iv = dyn_cast<InsertValueInst>(inst)){
      InsertValInsts.push_back(iv);
    }
    else if(inst->getOpcode()==Instruction::Ret){
      RestoreExitBlock=inst->getParent();
    }
I++;
  }
  for(auto item: RestoreGEPs){
    GetElementPtrInst* GEP = item->GEP;
    IntToPtrInst* ITP = item->ComputeITP;
    EraseInsts.insert(GEP);
    EraseInsts.insert(ITP);

    //分析GEP数组基地址、索引对应变量以及各维度大小
    analyzeAddrIndex(item,SE);

    //插入构建好的GEP指令
    insertNewGEP(item,F.getContext());
  }

  // 删除原有冗余的指令
  for(auto &inst:EraseInsts){
    if(inst->use_empty()){
    inst->eraseFromParent();
  }
  }
  for(auto item: RestoreGEPs){
    delete item;
  }

  I = llvm::inst_begin(F);
  E = llvm::inst_end(F);
  while(I!=E){
    Instruction* inst = &(*I);
    if(StoreInst* s = dyn_cast<StoreInst>(inst)){
      Stores[s->getOperand(0)]=s->getOperand(1);
    }
    I++;
  }
 // 恢复非参数最终的返回指令
  for(InsertValueInst* iv : InsertValInsts){
    Value* operand = iv->getOperand(1);
    Instruction* i=dyn_cast<Instruction>(operand);
    if(i==nullptr)continue;
Type* i_64 = Type::getInt64Ty(F.getContext());
    Constant* zero = ConstantInt::get(i_64,0);
    iv->replaceUsesOfWith(iv->getOperand(1),zero);
  }
  PreservedAnalyses PA = PreservedAnalyses::none();
  return PA;
}


