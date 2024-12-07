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
  br label %19

19:                                               ; preds = %48, %9
  %20 = phi i32 [ %18, %9 ], [ %49, %48 ]
  %21 = phi i64 [ %7, %9 ], [ %41, %48 ]
  %22 = phi i64 [ %6, %9 ], [ %42, %48 ]
  %23 = phi i64 [ %3, %9 ], [ %43, %48 ]
  %24 = phi i64 [ %2, %9 ], [ %44, %48 ]
  %.in = phi i32 [ %18, %9 ], [ %.03, %48 ]
  %25 = icmp sgt i32 %20, -1
  br i1 %25, label %40, label %26

26:                                               ; preds = %19
  %27 = zext i32 %.in to i64
  %28 = load i64, ptr %13, align 4
  %29 = getelementptr i64, ptr %12, i64 1
  %30 = ptrtoint ptr %29 to i64
  %31 = load i64, ptr %12, align 4
  store i64 %28, ptr addrspace(1) %10, align 16
  %32 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } undef, i64 %31, 0
  %33 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %32, i64 %27, 1
  %34 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %33, i64 %24, 2
  %35 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %34, i64 %23, 3
  %36 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %35, i64 %4, 4
  %37 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %36, i64 %30, 5
  %38 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %37, i64 %22, 6
  %39 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %38, i64 %21, 7
  ret { i64, i64, i64, i64, i64, i64, i64, i64 } %39

40:                                               ; preds = %94, %19
  %.03.in = phi i32 [ %20, %19 ], [ %.03, %94 ]
  %41 = phi i64 [ %21, %19 ], [ %90, %94 ]
  %42 = phi i64 [ %22, %19 ], [ %95, %94 ]
  %43 = phi i64 [ %23, %19 ], [ %96, %94 ]
  %44 = phi i64 [ %24, %19 ], [ %97, %94 ]
  %.03 = add i32 %.03.in, 1
  %45 = icmp slt i32 %.03, %14
  br i1 %45, label %46, label %48

46:                                               ; preds = %40
  %47 = icmp ugt i32 %.03.in, 2147483646
  br i1 %47, label %50, label %55

48:                                               ; preds = %40
  %49 = add i32 %20, -1
  br label %19

50:                                               ; preds = %55, %46
  %51 = phi i64 [ %42, %46 ], [ %57, %55 ]
  %52 = phi i64 [ %43, %46 ], [ %67, %55 ]
  %53 = phi i64 [ %44, %46 ], [ %58, %55 ]
  %54 = add i32 %20, 1
  %.not = icmp slt i32 %54, %14
  br i1 %.not, label %73, label %68

55:                                               ; preds = %46
  %56 = sext i32 %20 to i64
  %57 = mul nsw i64 %56, 720
  %58 = add i64 %57, %3
  %59 = sext i32 %.03 to i64
  %60 = inttoptr i64 %58 to ptr
  %61 = getelementptr i32, ptr %60, i64 %59
  %62 = load i32, ptr %61, align 1
  %63 = sext i32 %.03.in to i64
  %64 = getelementptr i32, ptr %60, i64 %63
  %65 = load i32, ptr %64, align 1
  %66 = tail call i32 @llvm.smax.i32(i32 %62, i32 %65)
  %67 = zext i32 %66 to i64
  store i32 %66, ptr %61, align 1
  br label %50

68:                                               ; preds = %73, %50
  %69 = phi i64 [ %51, %50 ], [ %75, %73 ]
  %70 = phi i64 [ %52, %50 ], [ %88, %73 ]
  %71 = phi i64 [ %53, %50 ], [ %76, %73 ]
  %72 = icmp ule i32 %.03.in, 2147483646
  %.not5 = icmp slt i32 %54, %14
  %or.cond = select i1 %72, i1 %.not5, i1 false
  br i1 %or.cond, label %99, label %89

73:                                               ; preds = %50
  %74 = sext i32 %20 to i64
  %75 = mul nsw i64 %74, 720
  %76 = add i64 %75, %3
  %77 = sext i32 %.03 to i64
  %78 = inttoptr i64 %76 to ptr
  %79 = getelementptr i32, ptr %78, i64 %77
  %80 = load i32, ptr %79, align 1
  %81 = mul nsw i64 %74, 720
  %82 = add i64 %3, 720
  %83 = add i64 %82, %81
  %84 = inttoptr i64 %83 to ptr
  %85 = getelementptr i32, ptr %84, i64 %77
  %86 = load i32, ptr %85, align 1
  %87 = tail call i32 @llvm.smax.i32(i32 %80, i32 %86)
  %88 = zext i32 %87 to i64
  store i32 %87, ptr %79, align 1
  br label %68

89:                                               ; preds = %68, %138, %121
  %90 = phi i64 [ %41, %121 ], [ %142, %138 ], [ %41, %68 ]
  %91 = phi i64 [ %123, %121 ], [ %140, %138 ], [ %69, %68 ]
  %92 = phi i64 [ %137, %121 ], [ %166, %138 ], [ %70, %68 ]
  %93 = phi i64 [ %124, %121 ], [ %141, %138 ], [ %71, %68 ]
  br label %94

94:                                               ; preds = %89, %100
  %.04 = phi i32 [ %54, %89 ], [ %120, %100 ]
  %95 = phi i64 [ %91, %89 ], [ %102, %100 ]
  %96 = phi i64 [ %92, %89 ], [ %119, %100 ]
  %97 = phi i64 [ %93, %89 ], [ %103, %100 ]
  %98 = icmp slt i32 %.04, %.03
  br i1 %98, label %100, label %40

99:                                               ; preds = %68
  %.not6 = icmp slt i32 %20, %.03.in
  br i1 %.not6, label %138, label %121

100:                                              ; preds = %94
  %101 = sext i32 %20 to i64
  %102 = mul nsw i64 %101, 720
  %103 = add i64 %102, %3
  %104 = sext i32 %.03 to i64
  %105 = inttoptr i64 %103 to ptr
  %106 = getelementptr i32, ptr %105, i64 %104
  %107 = load i32, ptr %106, align 1
  %108 = sext i32 %.04 to i64
  %109 = getelementptr i32, ptr %105, i64 %108
  %110 = load i32, ptr %109, align 1
  %111 = mul nsw i64 %108, 720
  %112 = add i64 %3, 720
  %113 = add i64 %112, %111
  %114 = inttoptr i64 %113 to ptr
  %115 = getelementptr i32, ptr %114, i64 %104
  %116 = load i32, ptr %115, align 1
  %117 = add i32 %116, %110
  %118 = tail call i32 @llvm.smax.i32(i32 %107, i32 %117)
  %119 = zext i32 %118 to i64
  store i32 %118, ptr %106, align 1
  %120 = add i32 %.04, 1
  br label %94

121:                                              ; preds = %99
  %122 = sext i32 %20 to i64
  %123 = mul nsw i64 %122, 720
  %124 = add i64 %123, %3
  %125 = sext i32 %.03 to i64
  %126 = inttoptr i64 %124 to ptr
  %127 = getelementptr i32, ptr %126, i64 %125
  %128 = load i32, ptr %127, align 1
  %129 = mul nsw i64 %122, 720
  %130 = add i64 %3, 720
  %131 = add i64 %130, %129
  %132 = sext i32 %.03.in to i64
  %133 = inttoptr i64 %131 to ptr
  %134 = getelementptr i32, ptr %133, i64 %132
  %135 = load i32, ptr %134, align 1
  %136 = tail call i32 @llvm.smax.i32(i32 %128, i32 %135)
  %137 = zext i32 %136 to i64
  store i32 %136, ptr %127, align 1
  br label %89

138:                                              ; preds = %99
  %139 = sext i32 %20 to i64
  %140 = mul nsw i64 %139, 720
  %141 = add i64 %140, %3
  %142 = sext i32 %.03 to i64
  %143 = inttoptr i64 %141 to ptr
  %144 = getelementptr i32, ptr %143, i64 %142
  %145 = load i32, ptr %144, align 1
  %146 = mul nsw i64 %139, 720
  %147 = add i64 %3, 720
  %148 = add i64 %147, %146
  %149 = sext i32 %.03.in to i64
  %150 = inttoptr i64 %148 to ptr
  %151 = getelementptr i32, ptr %150, i64 %149
  %152 = load i32, ptr %151, align 1
  %153 = add i64 %139, %6
  %154 = inttoptr i64 %153 to ptr
  %155 = load i8, ptr %154, align 1
  %156 = sext i8 %155 to i32
  %157 = add i64 %142, %6
  %158 = inttoptr i64 %157 to ptr
  %159 = load i8, ptr %158, align 1
  %160 = sext i8 %159 to i32
  %161 = add nsw i32 %160, %156
  %162 = icmp eq i32 %161, 3
  %163 = zext i1 %162 to i32
  %164 = add i32 %163, %152
  %165 = tail call i32 @llvm.smax.i32(i32 %145, i32 %164)
  %166 = zext i32 %165 to i64
  store i32 %165, ptr %144, align 1
  br label %89
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.smax.i32(i32, i32) #1

attributes #0 = { null_pointer_is_valid }
attributes #1 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!0 = !{i64 -1, i64 -1}
