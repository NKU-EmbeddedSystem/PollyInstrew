; ModuleID = 'mod'
source_filename = "mod"

@instrew_baseaddr = external global i64, !absolute_symbol !0
@llvm.used = appending global [3 x ptr] [ptr @instrew_baseaddr, ptr @syscall, ptr @cpuid], section "llvm.metadata"

declare void @syscall(ptr addrspace(1))

declare { i64, i64 } @cpuid(i32, i32)

; Function Attrs: null_pointer_is_valid
define { i64, i64, i64, i64, i64, i64, i64, i64 } @S0_aapcsx(i64 %0, i64 %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, i64 %7, ptr addrspace(1) noalias nocapture swiftself align 16 dereferenceable(400) %8) #0 {
.split:
  %9 = getelementptr i8, ptr addrspace(1) %8, i64 48
  %10 = load i64, ptr addrspace(1) %9, align 16
  %11 = inttoptr i64 %5 to ptr
  %12 = getelementptr i64, ptr %11, i64 -1
  store i64 %10, ptr %12, align 4
  %13 = trunc i64 %7 to i32
  %14 = getelementptr i8, ptr %11, i64 -12
  store i32 %13, ptr %14, align 1
  %15 = getelementptr i64, ptr %11, i64 -3
  store i64 %6, ptr %15, align 1
  %.not34 = icmp sgt i32 %13, 0
  br i1 %.not34, label %.preheader.lr.ph.preheader, label %._crit_edge35

.preheader.lr.ph.preheader:                       ; preds = %.split
  %16 = getelementptr i64, ptr %11, i64 -5
  br label %.preheader.lr.ph

.preheader.lr.ph:                                 ; preds = %.preheader.lr.ph.preheader, %._crit_edge30
  %17 = phi i32 [ %27, %._crit_edge30 ], [ 0, %.preheader.lr.ph.preheader ]
  %18 = zext i32 %17 to i64
  br label %.lr.ph

._crit_edge35.loopexit:                           ; preds = %._crit_edge30
  %.pre = load i64, ptr %12, align 4
  br label %._crit_edge35

._crit_edge35:                                    ; preds = %._crit_edge35.loopexit, %.split
  %19 = phi i64 [ %.pre, %._crit_edge35.loopexit ], [ %10, %.split ]
  store i64 %19, ptr addrspace(1) %9, align 16
  %20 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 0, i64 0, i64 0, i64 0, i64 undef, i64 undef, i64 undef, i64 undef }, i64 %4, 4
  %21 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %20, i64 0, 5
  %22 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %21, i64 0, 6
  %23 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %22, i64 %7, 7
  ret { i64, i64, i64, i64, i64, i64, i64, i64 } %23

.lr.ph:                                           ; preds = %28, %.preheader.lr.ph
  %24 = phi i32 [ 0, %.preheader.lr.ph ], [ %29, %28 ]
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds [180 x i32], ptr addrspace(64) inttoptr (i64 %6 to ptr addrspace(64)), i64 %25, i64 %18
  br label %30

._crit_edge30:                                    ; preds = %28
  %27 = add nuw nsw i32 %17, 1
  %.not = icmp slt i32 %27, %13
  br i1 %.not, label %.preheader.lr.ph, label %._crit_edge35.loopexit

28:                                               ; preds = %30
  %29 = add nuw nsw i32 %24, 1
  %.not12 = icmp slt i32 %29, %13
  br i1 %.not12, label %.lr.ph, label %._crit_edge30

30:                                               ; preds = %.lr.ph, %30
  %.01126 = phi i32 [ 0, %.lr.ph ], [ %39, %30 ]
  %31 = zext i32 %.01126 to i64
  %32 = getelementptr inbounds [180 x i32], ptr addrspace(64) inttoptr (i64 %6 to ptr addrspace(64)), i64 %25, i64 %31
  %33 = load i32, ptr addrspace(64) %32, align 1
  %34 = load i32, ptr addrspace(64) %26, align 1
  %35 = getelementptr inbounds [180 x i32], ptr addrspace(64) inttoptr (i64 %6 to ptr addrspace(64)), i64 %18, i64 %31
  %36 = load i32, ptr addrspace(64) %35, align 1
  %37 = add i32 %36, %34
  %38 = call i32 @llvm.smin.i32(i32 %33, i32 %37)
  store i32 %38, ptr %16, align 1
  store i32 %38, ptr addrspace(64) %32, align 1
  %39 = add nuw nsw i32 %.01126, 1
  %.not13 = icmp slt i32 %39, %13
  br i1 %.not13, label %30, label %28
}

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.smin.i32(i32, i32) #1

attributes #0 = { null_pointer_is_valid }
attributes #1 = { nocallback nofree nosync nounwind readnone speculatable willreturn }

!0 = !{i64 -1, i64 -1}
instrew: ../server/rewriteserver.cc:500: void IWState::Translate(uintptr_t): Assertion `0' failed.
error resolving address 401a80: 5
