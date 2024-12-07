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
  br label %24

24:                                               ; preds = %65, %9
  %.0 = phi i32 [ 0, %9 ], [ %66, %65 ]
  %.pre37 = phi i32 [ %20, %9 ], [ %.pre38, %65 ]
  %25 = phi i32 [ %20, %9 ], [ %54, %65 ]
  %26 = phi i32 [ 0, %9 ], [ %66, %65 ]
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
  br label %53

53:                                               ; preds = %81, %51
  %.010 = phi i32 [ 0, %51 ], [ %82, %81 ]
  %.pre38 = phi i32 [ %.pre37, %51 ], [ %.pre3, %81 ]
  %54 = phi i32 [ %25, %51 ], [ %.pre3, %81 ]
  %55 = phi i32 [ 0, %51 ], [ %82, %81 ]
  %56 = phi i64 [ %27, %51 ], [ %72, %81 ]
  %57 = phi i64 [ %28, %51 ], [ %73, %81 ]
  %58 = phi i64 [ %29, %51 ], [ %74, %81 ]
  %59 = sub i32 %55, %54
  %60 = icmp slt i32 %59, 0
  %61 = icmp slt i32 %55, %54
  %62 = icmp ne i1 %60, %61
  %63 = icmp ne i1 %60, %62
  %64 = xor i1 %63, true
  br i1 %64, label %65, label %67

65:                                               ; preds = %53
  %66 = add i32 %.0, 1
  br label %24

67:                                               ; preds = %53
  %68 = getelementptr i8, ptr %19, i64 -24
  br label %69

69:                                               ; preds = %67, %108
  %.011 = phi i32 [ 0, %67 ], [ %111, %108 ]
  %.pre3 = phi i32 [ %20, %108 ], [ %.pre38, %67 ]
  %70 = phi i32 [ %20, %108 ], [ %54, %67 ]
  %71 = phi i32 [ %111, %108 ], [ 0, %67 ]
  %72 = phi i64 [ %87, %108 ], [ %56, %67 ]
  %73 = phi i64 [ %110, %108 ], [ %57, %67 ]
  %74 = phi i64 [ %87, %108 ], [ %58, %67 ]
  %75 = sub i32 %71, %70
  %76 = icmp slt i32 %75, 0
  %77 = icmp slt i32 %71, %70
  %78 = icmp ne i1 %76, %77
  %79 = icmp ne i1 %76, %78
  %80 = xor i1 %79, true
  br i1 %80, label %81, label %83

81:                                               ; preds = %69
  %82 = add i32 %.010, 1
  br label %53

83:                                               ; preds = %69
  %84 = sext i32 %.010 to i64
  %85 = mul i64 %84, 720
  %86 = add i64 %6, %85
  %87 = sext i32 %71 to i64
  %88 = inttoptr i64 %86 to ptr
  %89 = getelementptr i32, ptr %88, i64 %87
  %90 = load i32, ptr %89, align 1
  %91 = sext i32 %.0 to i64
  %92 = getelementptr i32, ptr %88, i64 %91
  %93 = load i32, ptr %92, align 1
  %94 = mul i64 %91, 720
  %95 = add i64 %6, %94
  %96 = inttoptr i64 %95 to ptr
  %97 = getelementptr i32, ptr %96, i64 %87
  %98 = load i32, ptr %97, align 1
  %99 = add i32 %93, %98
  %100 = sub i32 %90, %99
  %101 = icmp slt i32 %100, 0
  %102 = icmp slt i32 %90, %99
  %103 = icmp ne i1 %101, %102
  %104 = icmp ne i1 %101, %103
  %105 = xor i1 %104, true
  br i1 %105, label %106, label %112

106:                                              ; preds = %83
  %107 = getelementptr i8, ptr %19, i64 -32
  store i32 %99, ptr %107, align 1
  br label %108

108:                                              ; preds = %106, %112
  %109 = phi i32 [ %99, %106 ], [ %90, %112 ]
  %110 = zext i32 %109 to i64
  store i32 %109, ptr %89, align 1
  %111 = add i32 %.011, 1
  br label %69

112:                                              ; preds = %83
  %113 = getelementptr i8, ptr %19, i64 -32
  store i32 %90, ptr %113, align 1
  br label %108
}

attributes #0 = { null_pointer_is_valid }

!0 = !{i64 -1, i64 -1}
