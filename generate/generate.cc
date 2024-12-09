#include <cinttypes>
#include <cstdlib>
#include <llvm/ADT/APFloat.h>
#include <llvm/ADT/SmallVector.h>
#include <llvm/Analysis/CGSCCPassManager.h>
#include <llvm/Analysis/InlineCost.h>
#include <llvm/Analysis/LoopInfo.h>
#include <llvm/Analysis/RegionInfo.h>
#include <llvm/Analysis/TargetTransformInfo.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/DiagnosticInfo.h>
#include <llvm/IR/Dominators.h>
#include <llvm/IR/GlobalAlias.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/GlobalVariable.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/InstIterator.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/PassTimingInfo.h>
#include <llvm/IR/ProfileSummary.h>
#include <llvm/IR/Type.h>
#include <llvm/Pass.h>
#include <llvm/Passes/OptimizationLevel.h>
#include <llvm/Support/Casting.h>
#include <llvm/Support/CommandLine.h>

#include <llvm/Support/InitLLVM.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Function.h>

#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/IR/IRPrintingPasses.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/PassManager.h>
#include <llvm/Passes/PassBuilder.h>
#include <llvm/Transforms/AggressiveInstCombine/AggressiveInstCombine.h>
#include <llvm/Transforms/IPO/Inliner.h>
#include <llvm/Transforms/IPO/ModuleInliner.h>
#include <llvm/Transforms/InstCombine/InstCombine.h>
#include <llvm/Transforms/Scalar.h>
#include <llvm/Transforms/Instrumentation.h>
#include <llvm/Transforms/Scalar/ADCE.h>
#include <llvm/Transforms/Scalar/CorrelatedValuePropagation.h>
#include <llvm/Transforms/Scalar/DCE.h>
// #include <llvm/Transforms/Scalar/DeadStoreElimination.h>
#include <llvm/Transforms/Scalar/EarlyCSE.h>
// #include <llvm/Transforms/Scalar/GVN.h>
#include <llvm/Transforms/Scalar/LoopPassManager.h>
#include <llvm/Transforms/Scalar/MemCpyOptimizer.h>
#include <llvm/Transforms/Scalar/MergedLoadStoreMotion.h>
// #include <llvm/Transforms/Scalar/NewGVN.h>
#include <llvm/Transforms/Scalar/Reassociate.h>
#include <llvm/Transforms/Scalar/SCCP.h>
#include <llvm/Transforms/Scalar/SimplifyCFG.h>

#include <polly/ScopPass.h>
#include "llvm/IR/Function.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/Scalar.h"
#include <polly/Simplify.h>
#include "CodePreparation.h"
#include "ScopInfo.h"
#include "polly/RegisterPasses.h"
#include "polly/LinkAllPasses.h"
#include <polly/PolyhedralInfo.h>
#include <polly/ScheduleOptimizer.h>
#include <polly/Options.h>
#include <llvm/Transforms/Utils.h>
#include "llvm/Analysis/ScalarEvolution.h"
#include <polly/Support/ISLTools.h>
#include <polly/ScopDetection.h>
#include <polly/CodeGen/IslAst.h>
#include <polly/ForwardOpTree.h>
#include <polly/DeLICM.h>
#include <polly/DeadCodeElimination.h>
#include <polly/MaximalStaticExpansion.h>
#include <polly/PruneUnprofitable.h>
#include <polly/CodeGen/CodeGeneration.h>
#include <polly/Canonicalization.h>
#include <llvm/Transforms/Utils/Mem2Reg.h>
#include <llvm/Transforms/Scalar/TailRecursionElimination.h>
#include <llvm/Transforms/Scalar/LoopRotation.h>
#include <llvm/Transforms/Scalar/IndVarSimplify.h>
#include <llvm/Analysis/GlobalsModRef.h>
#include <llvm/Analysis/ProfileSummaryInfo.h>
#include <llvm/Transforms/IPO/FunctionAttrs.h>
#include <llvm/Analysis/AssumptionCache.h>
#include <llvm/Analysis/OptimizationRemarkEmitter.h>
#include <polly/DependenceInfo.h>
#include <iostream>
#include <memory>
#include <string>
#include <sys/time.h>


int main(int argc, char **argv) {
  // Step1 : load ll file

  llvm::InitLLVM X(argc, argv);

  // Load the input file
  llvm::SMDiagnostic Err;
  std::unique_ptr<llvm::LLVMContext> Ctx = std::make_unique<llvm::LLVMContext>();
  // std::unique_ptr<llvm::Module> Mod =llvm::parseIRFile("/home/zby/test202412/PolyBenchC-4.2.1/linear-algebra/kernels/doitgen/doitgen.ll",Err,*Ctx);
  std::unique_ptr<llvm::Module> Mod =llvm::parseIRFile("/home/zby/test202412/PollyInstrew/generate/PollyInstrew_doitgen.ll",Err,*Ctx);
   // Step2 : set manager
 llvm::PassBuilder pb;
  llvm::FunctionPassManager fpm;
  llvm::ModulePassManager mpm;
  polly::ScopPassManager spm;
  llvm::LoopPassManager lpm;

  llvm::AAManager am;
  llvm::LoopAnalysisManager lam;
  llvm::FunctionAnalysisManager fam;
  llvm::CGSCCAnalysisManager cgam;
  llvm::ModuleAnalysisManager mam;
  polly::ScopAnalysisManager sam;
  // Step3 : initialze the registerFunctionAnalyses
  // analysis后期添加，如果需要但没有会
  //
  //llvm::PassInstrumentationCallbacks *PIC = pb.getPassInstrumentationCallbacks();
  //pb.registerAnalysisRegistrationCallback([PIC](llvm::FunctionAnalysisManager &FAM){
  //                                        registerFunctionAnalyses(FAM,PIC);
  //                                        });
  am=pb.buildDefaultAAPipeline();
  pb.registerModuleAnalyses(mam);
  pb.registerFunctionAnalyses(fam);
  pb.registerLoopAnalyses(lam);
  pb.registerCGSCCAnalyses(cgam);

  fam.registerPass([&]{return llvm::ScalarEvolutionAnalysis();});
  fam.registerPass([&]{return llvm::RegionInfoAnalysis();});
  fam.registerPass([&]{return llvm::AssumptionAnalysis();});
  fam.registerPass([&]{return llvm::OptimizationRemarkEmitterAnalysis();});
  fam.registerPass([&]{return llvm::DominatorTreeAnalysis();});
  fam.registerPass([&]{return llvm::ScalarEvolutionAnalysis();});
  fam.registerPass([&]{return llvm::LoopAnalysis();});
  fam.registerPass([&]{return llvm::RegionInfoAnalysis();});
  fam.registerPass([&]{return llvm::TargetIRAnalysis();});
  mam.registerPass([&fam]{return llvm::FunctionAnalysisManagerModuleProxy(fam);});

  fam.registerPass([&]{return polly::ScopAnalysis();}); 
  fam.registerPass([&]{return polly::ScopInfoAnalysis();});
  sam.registerPass([&]{return polly::DependenceAnalysis();});
  sam.registerPass([&]{return polly::IslAstAnalysis();});

  mam.registerPass([&]{return llvm::FunctionAnalysisManagerModuleProxy(fam);});
  fam.registerPass([&]{return llvm::ModuleAnalysisManagerFunctionProxy(mam);});

  fam.registerPass([&]{return polly::ScopAnalysisManagerFunctionProxy(sam);});
  sam.registerPass([&]{return polly::FunctionAnalysisManagerScopProxy(fam);});

  mam.registerPass([&]{return llvm::PassInstrumentationAnalysis();});
  fam.registerPass([&]{return llvm::PassInstrumentationAnalysis();});
  sam.registerPass([&]{return llvm::PassInstrumentationAnalysis();});

  pb.crossRegisterProxies(lam,fam,cgam,mam);

  // Step4 : set optimizer (module pass -> function pass -> scoppass)
  // Canonicalization  


  fpm.addPass(llvm::PromotePass());
  fpm.addPass(llvm::EarlyCSEPass(true));
  fpm.addPass(llvm::InstCombinePass());
  fpm.addPass(llvm::SimplifyCFGPass());
  fpm.addPass(llvm::TailCallElimPass());
  fpm.addPass(llvm::SimplifyCFGPass());
  fpm.addPass(llvm::ReassociatePass());


  {
    llvm::LoopPassManager lpm{};
    lpm.addPass(llvm::LoopRotatePass());
    fpm.addPass(llvm::createFunctionToLoopPassAdaptor<llvm::LoopPassManager>(std::move(lpm),false,false));
  }

  fpm.addPass(llvm::InstCombinePass());

  {
    llvm::LoopPassManager lpm{};
    lpm.addPass(llvm::IndVarSimplifyPass());
    fpm.addPass(llvm::createFunctionToLoopPassAdaptor<llvm::LoopPassManager>(std::move(lpm),false,true));
  }


  fpm.addPass(llvm::InstCombinePass());
  fpm.addPass(polly::CodePreparationPass());

  // Polly Optimize
  spm.addPass(polly::SimplifyPass(0));                 // 1
  spm.addPass(polly::ForwardOpTreePass());             // 2
  spm.addPass(polly::DeLICMPass());                    // 3
  spm.addPass(polly::SimplifyPass(1));                 // 4  
  spm.addPass(polly::PruneUnprofitablePass());         // 5 
  spm.addPass(polly::IslScheduleOptimizerPass());      // 6

  spm.addPass(polly::CodeGenerationPass());
  fpm.addPass(polly::createFunctionToScopPassAdaptor(std::move(spm)));
  fpm.addPass(pb.buildFunctionSimplificationPipeline(llvm::OptimizationLevel::O3,llvm::ThinOrFullLTOPhase::None)); // 7

  for(llvm::Function &F : *Mod){
    if(F.isDeclaration()){
      continue;
    }
    //llvm::outs()<<"[pollyOpt]Function:\n"<<F<<"\n";
    fpm.run(F,fam);
    //llvm::outs()<<"[pollyOpt]end\n";
  }

  // std::string filename = "/home/zby/test202412/PollyInstrew/generate/ref_doitgen.ll";
  // std::error_code EC;
  // llvm::raw_fd_ostream dest(filename, EC);
  // Mod->print(dest, nullptr);
  // Mod->print(llvm::outs(), nullptr);

  std::string filename = "/home/zby/test202412/PollyInstrew/generate/PollyInstrew_doitgen_multi.ll";
  std::error_code EC;
  llvm::raw_fd_ostream dest(filename, EC);
  Mod->print(dest, nullptr);
  //Mod->print(llvm::outs(), nullptr);
  // Free the LLVM objects
   Mod.reset();

  return 0;
}
