; ModuleID = 'mod'
source_filename = "mod"

@instrew_baseaddr = external global i64, !absolute_symbol !0
@llvm.used = appending global [3 x ptr] [ptr @instrew_baseaddr, ptr @syscall, ptr @cpuid], section "llvm.metadata"

declare void @syscall(ptr addrspace(1))

declare { i64, i64 } @cpuid(i32, i32)

; Function Attrs: null_pointer_is_valid
define { i64, i64, i64, i64, i64, i64, i64, i64 } @S0_aapcsx(i64 %0, i64 %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, i64 %7, ptr addrspace(1) noalias nocapture swiftself align 16 dereferenceable(400) %8) #0 {
  %10 = getelementptr i8, ptr addrspace(1) %8, i64 48
  %11 = getelementptr i8, ptr addrspace(1) %8, i64 136
  %12 = getelementptr i8, ptr addrspace(1) %8, i64 137
  %13 = getelementptr i8, ptr addrspace(1) %8, i64 138
  %14 = getelementptr i8, ptr addrspace(1) %8, i64 139
  %15 = getelementptr i8, ptr addrspace(1) %8, i64 140
  %16 = getelementptr i8, ptr addrspace(1) %8, i64 141
  %17 = load i64, ptr addrspace(1) %10, align 4
  %18 = inttoptr i64 %5 to ptr
  %19 = getelementptr i64, ptr %18, i64 -1
  store i64 %17, ptr %19, align 4
  %20 = trunc i64 %7 to i32
  %21 = getelementptr i8, ptr %19, i64 -4
  store i32 %20, ptr %21, align 1
  %22 = getelementptr i8, ptr %19, i64 -16
  store i64 %6, ptr %22, align 1
  %23 = getelementptr i8, ptr %19, i64 -28
  store i32 0, ptr %23, align 1
  br label %24

24:                                               ; preds = %65, %9
  %.pre37 = phi i32 [ %20, %9 ], [ %.pre38, %65 ]
  %25 = phi i32 [ %20, %9 ], [ %54, %65 ]
  %26 = phi i32 [ 0, %9 ], [ %67, %65 ]
  %27 = phi i64 [ %6, %9 ], [ %56, %65 ]
  %28 = phi i64 [ %3, %9 ], [ %57, %65 ]
  %29 = phi i64 [ %2, %9 ], [ %58, %65 ]
  %30 = zext i32 %26 to i64
  %31 = sub i32 %26, %25
  %32 = icmp slt i32 %31, 0
  %33 = icmp slt i32 %26, %25
  %34 = icmp ne i1 %32, %33
  %35 = icmp ne i1 %32, %34
  %36 = xor i1 %35, true
  br i1 %36, label %37, label %51

37:                                               ; preds = %24
  %38 = getelementptr i64, ptr %19, i64 1
  %39 = load i64, ptr %19, align 4
  %40 = getelementptr i64, ptr %38, i64 1
  %41 = ptrtoint ptr %40 to i64
  %42 = load i64, ptr %38, align 4
  store i64 %39, ptr addrspace(1) %10, align 4
  store i1 undef, ptr addrspace(1) %11, align 1
  store i1 undef, ptr addrspace(1) %12, align 1
  store i8 undef, ptr addrspace(1) %13, align 1
  store i1 undef, ptr addrspace(1) %14, align 1
  store i1 undef, ptr addrspace(1) %15, align 1
  store i1 undef, ptr addrspace(1) %16, align 1
  %43 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } undef, i64 %42, 0
  %44 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %43, i64 %30, 1
  %45 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %44, i64 %29, 2
  %46 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %45, i64 %28, 3
  %47 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %46, i64 %4, 4
  %48 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %47, i64 %41, 5
  %49 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %48, i64 %27, 6
  %50 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %49, i64 %7, 7
  ret { i64, i64, i64, i64, i64, i64, i64, i64 } %50

51:                                               ; preds = %24
  %52 = getelementptr i8, ptr %19, i64 -20
  store i32 0, ptr %52, align 1
  br label %53

53:                                               ; preds = %82, %51
  %.pre38 = phi i32 [ %.pre37, %51 ], [ %.pre3, %82 ]
  %54 = phi i32 [ %25, %51 ], [ %.pre3, %82 ]
  %55 = phi i32 [ 0, %51 ], [ %84, %82 ]
  %56 = phi i64 [ %27, %51 ], [ %73, %82 ]
  %57 = phi i64 [ %28, %51 ], [ %74, %82 ]
  %58 = phi i64 [ %29, %51 ], [ %75, %82 ]
  %59 = sub i32 %55, %54
  %60 = icmp slt i32 %59, 0
  %61 = icmp slt i32 %55, %54
  %62 = icmp ne i1 %60, %61
  %63 = icmp ne i1 %60, %62
  %64 = xor i1 %63, true
  br i1 %64, label %65, label %68

65:                                               ; preds = %53
  %66 = load i32, ptr %23, align 1
  %67 = add i32 %66, 1
  store i32 %67, ptr %23, align 1
  br label %24

68:                                               ; preds = %53
  %69 = getelementptr i8, ptr %19, i64 -24
  store i32 0, ptr %69, align 1
  br label %70

70:                                               ; preds = %68, %113
  %.pre3 = phi i32 [ %.pre5, %113 ], [ %.pre38, %68 ]
  %71 = phi i32 [ %.pre5, %113 ], [ %54, %68 ]
  %72 = phi i32 [ %117, %113 ], [ 0, %68 ]
  %73 = phi i64 [ %91, %113 ], [ %56, %68 ]
  %74 = phi i64 [ %115, %113 ], [ %57, %68 ]
  %75 = phi i64 [ %91, %113 ], [ %58, %68 ]
  %76 = sub i32 %72, %71
  %77 = icmp slt i32 %76, 0
  %78 = icmp slt i32 %72, %71
  %79 = icmp ne i1 %77, %78
  %80 = icmp ne i1 %77, %79
  %81 = xor i1 %80, true
  br i1 %81, label %82, label %85

82:                                               ; preds = %70
  %83 = load i32, ptr %52, align 1
  %84 = add i32 %83, 1
  store i32 %84, ptr %52, align 1
  br label %53

85:                                               ; preds = %70
  %86 = load i64, ptr %22, align 1
  %87 = load i32, ptr %52, align 1
  %88 = sext i32 %87 to i64
  %89 = mul i64 %88, 720
  %90 = add i64 %86, %89
  %91 = sext i32 %72 to i64
  %92 = inttoptr i64 %90 to ptr
  %93 = getelementptr i32, ptr %92, i64 %91
  %94 = load i32, ptr %93, align 1
  %95 = load i32, ptr %23, align 1
  %96 = sext i32 %95 to i64
  %97 = getelementptr i32, ptr %92, i64 %96
  %98 = load i32, ptr %97, align 1
  %99 = mul i64 %96, 720
  %100 = add i64 %86, %99
  %101 = inttoptr i64 %100 to ptr
  %102 = getelementptr i32, ptr %101, i64 %91
  %103 = load i32, ptr %102, align 1
  %104 = add i32 %98, %103
  %105 = sub i32 %94, %104
  %106 = icmp slt i32 %105, 0
  %107 = icmp slt i32 %94, %104
  %108 = icmp ne i1 %106, %107
  %109 = icmp ne i1 %106, %108
  %110 = xor i1 %109, true
  br i1 %110, label %111, label %118

111:                                              ; preds = %85
  %112 = getelementptr i8, ptr %19, i64 -32
  store i32 %104, ptr %112, align 1
  br label %113

113:                                              ; preds = %111, %118
  %114 = phi i32 [ %104, %111 ], [ %94, %118 ]
  %115 = zext i32 %114 to i64
  store i32 %114, ptr %93, align 1
  %116 = load i32, ptr %69, align 1
  %117 = add i32 %116, 1
  store i32 %117, ptr %69, align 1
  %.pre5 = load i32, ptr %21, align 1
  br label %70

118:                                              ; preds = %85
  %119 = getelementptr i8, ptr %19, i64 -32
  store i32 %94, ptr %119, align 1
  br label %113
}

attributes #0 = { null_pointer_is_valid }

!0 = !{i64 -1, i64 -1}
