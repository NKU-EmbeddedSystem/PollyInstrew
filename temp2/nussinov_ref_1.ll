; ModuleID = 'mod'
source_filename = "mod"

@instrew_baseaddr = external global i64, !absolute_symbol !0
@llvm.used = appending global [3 x ptr] [ptr @instrew_baseaddr, ptr @syscall, ptr @cpuid], section "llvm.metadata"

declare void @syscall(ptr addrspace(1))

declare { i64, i64 } @cpuid(i32, i32)

; Function Attrs: null_pointer_is_valid
define { i64, i64, i64, i64, i64, i64, i64, i64 } @S0_aapcsx(i64 %0, i64 %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, i64 %7, ptr addrspace(1) noalias nocapture swiftself align 16 dereferenceable(400) %8) #0 {
  %10 = getelementptr i8, ptr addrspace(1) %8, i64 48
  %11 = load i64, ptr addrspace(1) %10, align 16
  %12 = inttoptr i64 %5 to ptr
  %13 = getelementptr i64, ptr %12, i64 -1
  store i64 %11, ptr %13, align 4
  %14 = trunc i64 %7 to i32
  %15 = getelementptr i8, ptr %12, i64 -28
  store i32 %14, ptr %15, align 1
  %16 = getelementptr i64, ptr %12, i64 -5
  store i64 %6, ptr %16, align 1
  %17 = getelementptr i64, ptr %12, i64 -6
  store i64 %3, ptr %17, align 1
  %18 = add i32 %14, -1
  %19 = icmp sgt i32 %18, -1
  br i1 %19, label %.preheader.lr.ph, label %26

.preheader.lr.ph:                                 ; preds = %9
  br label %.preheader

.preheader:                                       ; preds = %.preheader.lr.ph, %48
  %20 = phi i64 [ %2, %.preheader.lr.ph ], [ %.lcssa11, %48 ]
  %21 = phi i64 [ %3, %.preheader.lr.ph ], [ %.lcssa12, %48 ]
  %22 = phi i64 [ %6, %.preheader.lr.ph ], [ %.lcssa13, %48 ]
  %23 = phi i64 [ %7, %.preheader.lr.ph ], [ %.lcssa14, %48 ]
  %24 = phi i32 [ %18, %.preheader.lr.ph ], [ %49, %48 ]
  %.0322 = add i32 %24, 1
  %25 = icmp slt i32 %.0322, %14
  br i1 %25, label %.lr.ph25, label %48

.lr.ph25:                                         ; preds = %.preheader
  br label %42

._crit_edge31:                                    ; preds = %48
  br label %26

26:                                               ; preds = %._crit_edge31, %9
  %.lcssa18 = phi i64 [ %.lcssa14, %._crit_edge31 ], [ %7, %9 ]
  %.lcssa17 = phi i64 [ %.lcssa13, %._crit_edge31 ], [ %6, %9 ]
  %.lcssa16 = phi i64 [ %.lcssa12, %._crit_edge31 ], [ %3, %9 ]
  %.lcssa15 = phi i64 [ %.lcssa11, %._crit_edge31 ], [ %2, %9 ]
  %.in.lcssa = phi i32 [ %.03.lcssa, %._crit_edge31 ], [ %18, %9 ]
  %27 = zext i32 %.in.lcssa to i64
  %28 = load i64, ptr %13, align 4
  %29 = getelementptr i64, ptr %12, i64 1
  %30 = ptrtoint ptr %29 to i64
  %31 = load i64, ptr %12, align 4
  store i64 %28, ptr addrspace(1) %10, align 16
  %32 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } undef, i64 %31, 0
  %33 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %32, i64 %27, 1
  %34 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %33, i64 %.lcssa15, 2
  %35 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %34, i64 %.lcssa16, 3
  %36 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %35, i64 %4, 4
  %37 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %36, i64 %30, 5
  %38 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %37, i64 %.lcssa17, 6
  %39 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %38, i64 %.lcssa18, 7
  ret { i64, i64, i64, i64, i64, i64, i64, i64 } %39

..loopexit_crit_edge:                             ; preds = %97
  %40 = zext i32 %115 to i64
  br label %.loopexit

.loopexit:                                        ; preds = %..loopexit_crit_edge, %90
  %.lcssa10 = phi i64 [ %99, %..loopexit_crit_edge ], [ %92, %90 ]
  %.lcssa9 = phi i64 [ %40, %..loopexit_crit_edge ], [ %93, %90 ]
  %.lcssa = phi i64 [ %100, %..loopexit_crit_edge ], [ %94, %90 ]
  %.03 = add i32 %.0324, 1
  %41 = icmp slt i32 %.03, %14
  br i1 %41, label %42, label %._crit_edge

42:                                               ; preds = %.lr.ph25, %.loopexit
  %.0324 = phi i32 [ %.0322, %.lr.ph25 ], [ %.03, %.loopexit ]
  %43 = phi i64 [ %20, %.lr.ph25 ], [ %.lcssa, %.loopexit ]
  %44 = phi i64 [ %21, %.lr.ph25 ], [ %.lcssa9, %.loopexit ]
  %45 = phi i64 [ %22, %.lr.ph25 ], [ %.lcssa10, %.loopexit ]
  %46 = phi i64 [ %23, %.lr.ph25 ], [ %91, %.loopexit ]
  %.03.in23 = phi i32 [ %24, %.lr.ph25 ], [ %.0324, %.loopexit ]
  %47 = icmp ugt i32 %.03.in23, 2147483646
  br i1 %47, label %51, label %56

._crit_edge:                                      ; preds = %.loopexit
  br label %48

48:                                               ; preds = %._crit_edge, %.preheader
  %.lcssa14 = phi i64 [ %91, %._crit_edge ], [ %23, %.preheader ]
  %.lcssa13 = phi i64 [ %.lcssa10, %._crit_edge ], [ %22, %.preheader ]
  %.lcssa12 = phi i64 [ %.lcssa9, %._crit_edge ], [ %21, %.preheader ]
  %.lcssa11 = phi i64 [ %.lcssa, %._crit_edge ], [ %20, %.preheader ]
  %.03.lcssa = phi i32 [ %.03, %._crit_edge ], [ %.0322, %.preheader ]
  %49 = add i32 %24, -1
  %50 = icmp sgt i32 %49, -1
  br i1 %50, label %.preheader, label %._crit_edge31

51:                                               ; preds = %56, %42
  %52 = phi i64 [ %45, %42 ], [ %58, %56 ]
  %53 = phi i64 [ %44, %42 ], [ %68, %56 ]
  %54 = phi i64 [ %43, %42 ], [ %59, %56 ]
  %55 = add i32 %24, 1
  %.not = icmp slt i32 %55, %14
  br i1 %.not, label %74, label %69

56:                                               ; preds = %42
  %57 = sext i32 %24 to i64
  %58 = mul nsw i64 %57, 720
  %59 = add i64 %58, %3
  %60 = sext i32 %.0324 to i64
  %61 = inttoptr i64 %59 to ptr
  %62 = getelementptr i32, ptr %61, i64 %60
  %63 = load i32, ptr %62, align 1
  %64 = sext i32 %.03.in23 to i64
  %65 = getelementptr i32, ptr %61, i64 %64
  %66 = load i32, ptr %65, align 1
  %67 = tail call i32 @llvm.smax.i32(i32 %63, i32 %66)
  %68 = zext i32 %67 to i64
  store i32 %67, ptr %62, align 1
  br label %51

69:                                               ; preds = %74, %51
  %70 = phi i64 [ %52, %51 ], [ %76, %74 ]
  %71 = phi i64 [ %53, %51 ], [ %89, %74 ]
  %72 = phi i64 [ %54, %51 ], [ %77, %74 ]
  %73 = icmp ult i32 %.03.in23, 2147483647
  %.not5 = icmp slt i32 %55, %14
  %or.cond = select i1 %73, i1 %.not5, i1 false
  br i1 %or.cond, label %96, label %90

74:                                               ; preds = %51
  %75 = sext i32 %24 to i64
  %76 = mul nsw i64 %75, 720
  %77 = add i64 %76, %3
  %78 = sext i32 %.0324 to i64
  %79 = inttoptr i64 %77 to ptr
  %80 = getelementptr i32, ptr %79, i64 %78
  %81 = load i32, ptr %80, align 1
  %82 = mul nsw i64 %75, 720
  %83 = add i64 %3, 720
  %84 = add i64 %83, %82
  %85 = inttoptr i64 %84 to ptr
  %86 = getelementptr i32, ptr %85, i64 %78
  %87 = load i32, ptr %86, align 1
  %88 = tail call i32 @llvm.smax.i32(i32 %81, i32 %87)
  %89 = zext i32 %88 to i64
  store i32 %88, ptr %80, align 1
  br label %69

90:                                               ; preds = %69, %135, %118
  %91 = phi i64 [ %46, %118 ], [ %139, %135 ], [ %46, %69 ]
  %92 = phi i64 [ %120, %118 ], [ %137, %135 ], [ %70, %69 ]
  %93 = phi i64 [ %134, %118 ], [ %163, %135 ], [ %71, %69 ]
  %94 = phi i64 [ %121, %118 ], [ %138, %135 ], [ %72, %69 ]
  %95 = icmp slt i32 %55, %.0324
  br i1 %95, label %.lr.ph, label %.loopexit

.lr.ph:                                           ; preds = %90
  br label %97

96:                                               ; preds = %69
  %.not6 = icmp slt i32 %24, %.03.in23
  br i1 %.not6, label %135, label %118

97:                                               ; preds = %.lr.ph, %97
  %.0419 = phi i32 [ %55, %.lr.ph ], [ %116, %97 ]
  %98 = sext i32 %24 to i64
  %99 = mul nsw i64 %98, 720
  %100 = add i64 %99, %3
  %101 = sext i32 %.0324 to i64
  %102 = inttoptr i64 %100 to ptr
  %103 = getelementptr i32, ptr %102, i64 %101
  %104 = load i32, ptr %103, align 1
  %105 = sext i32 %.0419 to i64
  %106 = getelementptr i32, ptr %102, i64 %105
  %107 = load i32, ptr %106, align 1
  %108 = mul nsw i64 %105, 720
  %109 = add i64 %3, 720
  %110 = add i64 %109, %108
  %111 = inttoptr i64 %110 to ptr
  %112 = getelementptr i32, ptr %111, i64 %101
  %113 = load i32, ptr %112, align 1
  %114 = add i32 %113, %107
  %115 = tail call i32 @llvm.smax.i32(i32 %104, i32 %114)
  store i32 %115, ptr %103, align 1
  %116 = add i32 %.0419, 1
  %117 = icmp slt i32 %116, %.0324
  br i1 %117, label %97, label %..loopexit_crit_edge

118:                                              ; preds = %96
  %119 = sext i32 %24 to i64
  %120 = mul nsw i64 %119, 720
  %121 = add i64 %120, %3
  %122 = sext i32 %.0324 to i64
  %123 = inttoptr i64 %121 to ptr
  %124 = getelementptr i32, ptr %123, i64 %122
  %125 = load i32, ptr %124, align 1
  %126 = mul nsw i64 %119, 720
  %127 = add i64 %3, 720
  %128 = add i64 %127, %126
  %129 = sext i32 %.03.in23 to i64
  %130 = inttoptr i64 %128 to ptr
  %131 = getelementptr i32, ptr %130, i64 %129
  %132 = load i32, ptr %131, align 1
  %133 = tail call i32 @llvm.smax.i32(i32 %125, i32 %132)
  %134 = zext i32 %133 to i64
  store i32 %133, ptr %124, align 1
  br label %90

135:                                              ; preds = %96
  %136 = sext i32 %24 to i64
  %137 = mul nsw i64 %136, 720
  %138 = add i64 %137, %3
  %139 = sext i32 %.0324 to i64
  %140 = inttoptr i64 %138 to ptr
  %141 = getelementptr i32, ptr %140, i64 %139
  %142 = load i32, ptr %141, align 1
  %143 = mul nsw i64 %136, 720
  %144 = add i64 %3, 720
  %145 = add i64 %144, %143
  %146 = sext i32 %.03.in23 to i64
  %147 = inttoptr i64 %145 to ptr
  %148 = getelementptr i32, ptr %147, i64 %146
  %149 = load i32, ptr %148, align 1
  %150 = add i64 %136, %6
  %151 = inttoptr i64 %150 to ptr
  %152 = load i8, ptr %151, align 1
  %153 = sext i8 %152 to i32
  %154 = add i64 %139, %6
  %155 = inttoptr i64 %154 to ptr
  %156 = load i8, ptr %155, align 1
  %157 = sext i8 %156 to i32
  %158 = add nsw i32 %157, %153
  %159 = icmp eq i32 %158, 3
  %160 = zext i1 %159 to i32
  %161 = add i32 %149, %160
  %162 = tail call i32 @llvm.smax.i32(i32 %142, i32 %161)
  %163 = zext i32 %162 to i64
  store i32 %162, ptr %141, align 1
  br label %90
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.smax.i32(i32, i32) #1

attributes #0 = { null_pointer_is_valid }
attributes #1 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!0 = !{i64 -1, i64 -1}
