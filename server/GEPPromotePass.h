#include "llvm/IR/PassManager.h"

namespace llvm{

class Function;

class GEPPromotePass : public PassInfoMixin<GEPPromotePass>{
    public:
    PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
    };
}
