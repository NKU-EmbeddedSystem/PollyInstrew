; ModuleID = 'mod'
source_filename = "mod"

@instrew_baseaddr = external global i64, !absolute_symbol !0
@llvm.used = appending global [3 x ptr] [ptr @instrew_baseaddr, ptr @syscall, ptr @cpuid], section "llvm.metadata"

declare void @syscall(ptr addrspace(1))

declare { i64, i64 } @cpuid(i32, i32)

; Function Attrs: null_pointer_is_valid
define { i64, i64, i64, i64, i64, i64, i64, i64 } @S0_aapcsx(i64 %0, i64 %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, i64 %7, ptr addrspace(1) noalias nocapture swiftself align 16 dereferenceable(400) %8) #0 {
  %10 = getelementptr i8, ptr addrspace(1) %8, i64 48
  %11 = getelementptr i8, ptr addrspace(1) %8, i64 72
  %12 = getelementptr i8, ptr addrspace(1) %8, i64 80
  %13 = load i64, ptr addrspace(1) %10, align 16
  %14 = load i64, ptr addrspace(1) %11, align 8
  %15 = load i64, ptr addrspace(1) %12, align 16
  %16 = inttoptr i64 %5 to ptr
  %17 = getelementptr i64, ptr %16, i64 -1
  store i64 %13, ptr %17, align 4
  %18 = trunc i64 %7 to i32
  %19 = getelementptr i8, ptr %16, i64 -12
  store i32 %18, ptr %19, align 1
  %20 = trunc i64 %6 to i32
  %21 = getelementptr i64, ptr %16, i64 -2
  store i32 %20, ptr %21, align 1
  %22 = trunc i64 %3 to i32
  %23 = getelementptr i8, ptr %16, i64 -20
  store i32 %22, ptr %23, align 1
  %24 = getelementptr i64, ptr %16, i64 -4
  store i64 %2, ptr %24, align 1
  %25 = getelementptr i64, ptr %16, i64 -5
  store i64 %14, ptr %25, align 1
  %26 = getelementptr i64, ptr %16, i64 -6
  store i64 %15, ptr %26, align 1
  %.not47 = icmp sgt i32 %18, 0
  br i1 %.not47, label %.preheader18.lr.ph, label %30

.preheader18.lr.ph:                               ; preds = %9
  br label %.preheader18

.preheader18:                                     ; preds = %.preheader18.lr.ph, %42
  %27 = phi i64 [ %2, %.preheader18.lr.ph ], [ %.lcssa24, %42 ]
  %28 = phi i64 [ %3, %.preheader18.lr.ph ], [ %.lcssa25, %42 ]
  %29 = phi i32 [ 0, %.preheader18.lr.ph ], [ %43, %42 ]
  %.not1342 = icmp sgt i32 %20, 0
  br i1 %.not1342, label %.preheader17.lr.ph, label %42

.preheader17.lr.ph:                               ; preds = %.preheader18
  br label %.preheader17

._crit_edge48:                                    ; preds = %42
  br label %30

30:                                               ; preds = %._crit_edge48, %9
  %31 = load i64, ptr %17, align 4
  store i64 %31, ptr addrspace(1) %10, align 16
  %32 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } undef, i64 0, 0
  %33 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %32, i64 0, 1
  %34 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %33, i64 0, 2
  %35 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %34, i64 0, 3
  %36 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %35, i64 %4, 4
  %37 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %36, i64 0, 5
  %38 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %37, i64 %6, 6
  %39 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %38, i64 %7, 7
  ret { i64, i64, i64, i64, i64, i64, i64, i64 } %39

.preheader17:                                     ; preds = %.preheader17.lr.ph, %51
  %40 = phi i64 [ %27, %.preheader17.lr.ph ], [ %.lcssa22, %51 ]
  %41 = phi i64 [ %28, %.preheader17.lr.ph ], [ %.lcssa23, %51 ]
  %.01043 = phi i32 [ 0, %.preheader17.lr.ph ], [ %52, %51 ]
  %.not1432 = icmp sgt i32 %22, 0
  br i1 %.not1432, label %.lr.ph33, label %.preheader

.lr.ph33:                                         ; preds = %.preheader17
  br label %44

._crit_edge44:                                    ; preds = %51
  br label %42

42:                                               ; preds = %._crit_edge44, %.preheader18
  %.lcssa25 = phi i64 [ %.lcssa23, %._crit_edge44 ], [ %28, %.preheader18 ]
  %.lcssa24 = phi i64 [ %.lcssa22, %._crit_edge44 ], [ %27, %.preheader18 ]
  %43 = add nuw nsw i32 %29, 1
  %.not = icmp slt i32 %43, %18
  br i1 %.not, label %.preheader18, label %._crit_edge48

..preheader_crit_edge:                            ; preds = %63
  br label %.preheader

.preheader:                                       ; preds = %..preheader_crit_edge, %.preheader17
  %.lcssa21 = phi i64 [ %.lcssa19, %..preheader_crit_edge ], [ %41, %.preheader17 ]
  %.lcssa20 = phi i64 [ %.lcssa, %..preheader_crit_edge ], [ %40, %.preheader17 ]
  %.not1636 = icmp sgt i32 %22, 0
  br i1 %.not1636, label %.lr.ph38, label %51

.lr.ph38:                                         ; preds = %.preheader
  br label %53

44:                                               ; preds = %.lr.ph33, %63
  %45 = phi i64 [ %41, %.lr.ph33 ], [ %.lcssa19, %63 ]
  %46 = phi i32 [ 0, %.lr.ph33 ], [ %64, %63 ]
  %47 = zext i32 %46 to i64
  %48 = inttoptr i64 %15 to ptr
  %49 = getelementptr i32, ptr %48, i64 %47
  store i32 0, ptr %49, align 1
  %.not1529 = icmp sgt i32 %22, 0
  br i1 %.not1529, label %.lr.ph, label %63

.lr.ph:                                           ; preds = %44
  br label %65

._crit_edge39:                                    ; preds = %53
  %50 = zext i32 %57 to i64
  br label %51

51:                                               ; preds = %._crit_edge39, %.preheader
  %.lcssa23 = phi i64 [ %50, %._crit_edge39 ], [ %.lcssa21, %.preheader ]
  %.lcssa22 = phi i64 [ %54, %._crit_edge39 ], [ %.lcssa20, %.preheader ]
  %52 = add nuw nsw i32 %.01043, 1
  %.not13 = icmp slt i32 %52, %20
  br i1 %.not13, label %.preheader17, label %._crit_edge44

53:                                               ; preds = %.lr.ph38, %53
  %.137 = phi i32 [ 0, %.lr.ph38 ], [ %61, %53 ]
  %54 = zext i32 %.137 to i64
  %55 = inttoptr i64 %15 to ptr
  %56 = getelementptr i32, ptr %55, i64 %54
  %57 = load i32, ptr %56, align 1
  %58 = zext i32 %29 to i64
  %59 = zext i32 %.01043 to i64
  %60 = getelementptr inbounds [220 x [270 x i32]], ptr addrspace(64) inttoptr (i64 %2 to ptr addrspace(64)), i64 %58, i64 %59, i64 %54
  store i32 %57, ptr addrspace(64) %60, align 1
  %61 = add nuw nsw i32 %.137, 1
  %.not16 = icmp slt i32 %61, %22
  br i1 %.not16, label %53, label %._crit_edge39

._crit_edge:                                      ; preds = %65
  %62 = zext i32 %77 to i64
  br label %63

63:                                               ; preds = %._crit_edge, %44
  %.lcssa19 = phi i64 [ %62, %._crit_edge ], [ %45, %44 ]
  %.lcssa = phi i64 [ %71, %._crit_edge ], [ %47, %44 ]
  %64 = add nuw nsw i32 %46, 1
  %.not14 = icmp slt i32 %64, %22
  br i1 %.not14, label %44, label %..preheader_crit_edge

65:                                               ; preds = %.lr.ph, %65
  %.01230 = phi i32 [ 0, %.lr.ph ], [ %78, %65 ]
  %66 = zext i32 %29 to i64
  %67 = zext i32 %.01043 to i64
  %68 = zext i32 %.01230 to i64
  %69 = getelementptr inbounds [220 x [270 x i32]], ptr addrspace(64) inttoptr (i64 %2 to ptr addrspace(64)), i64 %66, i64 %67, i64 %68
  %70 = load i32, ptr addrspace(64) %69, align 1
  %71 = zext i32 %46 to i64
  %72 = getelementptr inbounds [270 x i32], ptr addrspace(64) inttoptr (i64 %14 to ptr addrspace(64)), i64 %68, i64 %71
  %73 = load i32, ptr addrspace(64) %72, align 1
  %74 = mul i32 %73, %70
  %75 = getelementptr i32, ptr %48, i64 %71
  %76 = load i32, ptr %75, align 1
  %77 = add i32 %74, %76
  store i32 %77, ptr %75, align 1
  %78 = add nuw nsw i32 %.01230, 1
  %.not15 = icmp slt i32 %78, %22
  br i1 %.not15, label %65, label %._crit_edge
}

attributes #0 = { null_pointer_is_valid }

!0 = !{i64 -1, i64 -1}
