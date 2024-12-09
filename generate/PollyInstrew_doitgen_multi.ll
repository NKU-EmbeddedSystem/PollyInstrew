; ModuleID = '/home/zby/test202412/PollyInstrew/generate/PollyInstrew_doitgen.ll'
source_filename = "linear-algebra/kernels/doitgen/doitgen.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

@.str = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@stderr = external global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"A\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @kernel_doitgen(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5) #0 {
polly.split_new_and_old:
  %polly.par.userContext155 = alloca { i32, i32, i32, i64, i64, ptr, ptr }, align 8
  %polly.par.userContext145 = alloca { i32, i32, i32, i64, i64, ptr, ptr, ptr }, align 8
  %polly.par.userContext = alloca { i32, i32, i32, i64, i64, ptr }, align 8
  %6 = sext i32 %1 to i64
  %7 = icmp slt i32 %1, 221
  %8 = sext i32 %2 to i64
  %9 = icmp slt i32 %2, 271
  %10 = and i1 %7, %9
  %polly.access. = getelementptr i32, ptr %5, i64 %8
  %11 = icmp ule ptr %polly.access., %3
  %12 = sext i32 %0 to i64
  %13 = mul nsw i64 %12, 220
  %14 = add nsw i64 %13, %6
  %15 = mul nsw i64 %14, 270
  %polly.access.mul.39165 = add nsw i64 %8, -59670
  %polly.access.add.43166 = add nsw i64 %polly.access.mul.39165, %15
  %polly.access.47 = getelementptr i32, ptr %3, i64 %polly.access.add.43166
  %16 = icmp ule ptr %polly.access.47, %5
  %17 = or i1 %11, %16
  %18 = and i1 %10, %17
  %19 = mul nsw i64 %8, 270
  %polly.access.mul.52167 = add nsw i64 %8, -270
  %polly.access.add.56168 = add nsw i64 %polly.access.mul.52167, %19
  %polly.access.60 = getelementptr i32, ptr %4, i64 %polly.access.add.56168
  %20 = icmp ule ptr %polly.access.60, %3
  %21 = icmp ule ptr %polly.access.47, %4
  %22 = or i1 %20, %21
  %23 = and i1 %22, %18
  %24 = icmp ule ptr %polly.access.60, %5
  %25 = icmp ule ptr %polly.access., %4
  %26 = or i1 %25, %24
  %27 = and i1 %26, %23
  %polly.loop_guard = icmp sgt i32 %0, 0
  br i1 %27, label %polly.loop_if, label %.split

.split:                                           ; preds = %polly.split_new_and_old
  br i1 %polly.loop_guard, label %.preheader18.preheader, label %_30

.preheader18.preheader:                           ; preds = %.split
  %wide.trip.count15 = zext i32 %0 to i64
  %.not1342 = icmp sgt i32 %1, 0
  %wide.trip.count11 = zext i32 %1 to i64
  %wide.trip.count3 = zext i32 %2 to i64
  %.not1432 = icmp sgt i32 %2, 0
  %or.cond = and i1 %.not1342, %.not1432
  br i1 %or.cond, label %.preheader18.us.us, label %_30

.preheader18.us.us:                               ; preds = %.preheader18.preheader, %_42.loopexit.split.us.us.us
  %indvars.iv13.us.us = phi i64 [ %indvars.iv.next14.us.us, %_42.loopexit.split.us.us.us ], [ 0, %.preheader18.preheader ]
  br label %.preheader17.us.us.us

.preheader17.us.us.us:                            ; preds = %_51.loopexit.us.us.us, %.preheader18.us.us
  %indvars.iv9.us.us.us = phi i64 [ 0, %.preheader18.us.us ], [ %indvars.iv.next10.us.us.us, %_51.loopexit.us.us.us ]
  br label %_44.us.us.us

_44.us.us.us:                                     ; preds = %_63.us.us.us, %.preheader17.us.us.us
  %indvars.iv1.us.us.us = phi i64 [ 0, %.preheader17.us.us.us ], [ %indvars.iv.next2.us.us.us, %_63.us.us.us ]
  %_49.us.us.us = getelementptr i32, ptr %5, i64 %indvars.iv1.us.us.us
  store i32 0, ptr %_49.us.us.us, align 1
  br label %_65.us.us.us

_65.us.us.us:                                     ; preds = %_65.us.us.us, %_44.us.us.us
  %_76.us.us.us = phi i32 [ %_77.us.us.us, %_65.us.us.us ], [ 0, %_44.us.us.us ]
  %indvars.iv.us.us.us = phi i64 [ %indvars.iv.next.us.us.us, %_65.us.us.us ], [ 0, %_44.us.us.us ]
  %_69.us.us.us = getelementptr inbounds [220 x [270 x i32]], ptr %3, i64 %indvars.iv13.us.us, i64 %indvars.iv9.us.us.us, i64 %indvars.iv.us.us.us
  %_70.us.us.us = load i32, ptr %_69.us.us.us, align 1
  %_72.us.us.us = getelementptr inbounds [270 x i32], ptr %4, i64 %indvars.iv.us.us.us, i64 %indvars.iv1.us.us.us
  %_73.us.us.us = load i32, ptr %_72.us.us.us, align 1
  %_74.us.us.us = mul i32 %_73.us.us.us, %_70.us.us.us
  %_77.us.us.us = add i32 %_74.us.us.us, %_76.us.us.us
  store i32 %_77.us.us.us, ptr %_49.us.us.us, align 1
  %indvars.iv.next.us.us.us = add nuw nsw i64 %indvars.iv.us.us.us, 1
  %exitcond.not.us.us.us = icmp eq i64 %indvars.iv.next.us.us.us, %wide.trip.count3
  br i1 %exitcond.not.us.us.us, label %_63.us.us.us, label %_65.us.us.us

_63.us.us.us:                                     ; preds = %_65.us.us.us
  %indvars.iv.next2.us.us.us = add nuw nsw i64 %indvars.iv1.us.us.us, 1
  %exitcond4.not.us.us.us = icmp eq i64 %indvars.iv.next2.us.us.us, %wide.trip.count3
  br i1 %exitcond4.not.us.us.us, label %_53.us.us.us, label %_44.us.us.us

_53.us.us.us:                                     ; preds = %_63.us.us.us, %_53.us.us.us
  %indvars.iv5.us.us.us = phi i64 [ %indvars.iv.next6.us.us.us, %_53.us.us.us ], [ 0, %_63.us.us.us ]
  %_56.us.us.us = getelementptr i32, ptr %5, i64 %indvars.iv5.us.us.us
  %_57.us.us.us = load i32, ptr %_56.us.us.us, align 1
  %_60.us.us.us = getelementptr inbounds [220 x [270 x i32]], ptr %3, i64 %indvars.iv13.us.us, i64 %indvars.iv9.us.us.us, i64 %indvars.iv5.us.us.us
  store i32 %_57.us.us.us, ptr %_60.us.us.us, align 1
  %indvars.iv.next6.us.us.us = add nuw nsw i64 %indvars.iv5.us.us.us, 1
  %exitcond8.not.us.us.us = icmp eq i64 %indvars.iv.next6.us.us.us, %wide.trip.count3
  br i1 %exitcond8.not.us.us.us, label %_51.loopexit.us.us.us, label %_53.us.us.us

_51.loopexit.us.us.us:                            ; preds = %_53.us.us.us
  %indvars.iv.next10.us.us.us = add nuw nsw i64 %indvars.iv9.us.us.us, 1
  %exitcond12.not.us.us.us = icmp eq i64 %indvars.iv.next10.us.us.us, %wide.trip.count11
  br i1 %exitcond12.not.us.us.us, label %_42.loopexit.split.us.us.us, label %.preheader17.us.us.us

_42.loopexit.split.us.us.us:                      ; preds = %_51.loopexit.us.us.us
  %indvars.iv.next14.us.us = add nuw nsw i64 %indvars.iv13.us.us, 1
  %exitcond16.not.us.us = icmp eq i64 %indvars.iv.next14.us.us, %wide.trip.count15
  br i1 %exitcond16.not.us.us, label %_30, label %.preheader18.us.us

_30:                                              ; preds = %_42.loopexit.split.us.us.us, %polly.loop_exit136.loopexit.us, %polly.loop_if133.preheader, %.preheader18.preheader, %polly.loop_if, %.split
  ret void

polly.loop_if:                                    ; preds = %polly.split_new_and_old
  br i1 %polly.loop_guard, label %polly.loop_if133.preheader, label %_30

polly.loop_if133.preheader:                       ; preds = %polly.loop_if
  %polly.loop_guard137 = icmp sgt i32 %1, 0
  %28 = add i32 %2, -1
  %29 = sext i32 %28 to i64
  %polly.subfn.storeaddr.141 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr }, ptr %polly.par.userContext, i64 0, i32 1
  %polly.subfn.storeaddr.142 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr }, ptr %polly.par.userContext, i64 0, i32 2
  %polly.subfn.storeaddr.polly.indvar = getelementptr inbounds { i32, i32, i32, i64, i64, ptr }, ptr %polly.par.userContext, i64 0, i32 3
  %polly.subfn.storeaddr.polly.indvar138 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr }, ptr %polly.par.userContext, i64 0, i32 4
  %polly.subfn.storeaddr.143 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr }, ptr %polly.par.userContext, i64 0, i32 5
  %30 = add nsw i64 %29, 1
  %31 = add nsw i64 %8, -1
  %polly.fdiv_q.shr = ashr i64 %31, 5
  %polly.subfn.storeaddr.147 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext145, i64 0, i32 1
  %polly.subfn.storeaddr.148 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext145, i64 0, i32 2
  %polly.subfn.storeaddr.polly.indvar149 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext145, i64 0, i32 3
  %polly.subfn.storeaddr.polly.indvar138150 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext145, i64 0, i32 4
  %polly.subfn.storeaddr.151 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext145, i64 0, i32 5
  %polly.subfn.storeaddr.152 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext145, i64 0, i32 6
  %polly.subfn.storeaddr.153 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext145, i64 0, i32 7
  %32 = add nsw i64 %polly.fdiv_q.shr, 1
  %polly.subfn.storeaddr.157 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr }, ptr %polly.par.userContext155, i64 0, i32 1
  %polly.subfn.storeaddr.158 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr }, ptr %polly.par.userContext155, i64 0, i32 2
  %polly.subfn.storeaddr.polly.indvar159 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr }, ptr %polly.par.userContext155, i64 0, i32 3
  %polly.subfn.storeaddr.polly.indvar138160 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr }, ptr %polly.par.userContext155, i64 0, i32 4
  %polly.subfn.storeaddr.161 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr }, ptr %polly.par.userContext155, i64 0, i32 5
  %polly.subfn.storeaddr.162 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr }, ptr %polly.par.userContext155, i64 0, i32 6
  br i1 %polly.loop_guard137, label %polly.loop_if133.us, label %_30

polly.loop_if133.us:                              ; preds = %polly.loop_if133.preheader, %polly.loop_exit136.loopexit.us
  %polly.indvar.us = phi i64 [ %polly.indvar_next.us, %polly.loop_exit136.loopexit.us ], [ 0, %polly.loop_if133.preheader ]
  br label %polly.parallel.for154.us

polly.parallel.for154.us:                         ; preds = %polly.loop_if133.us, %polly.parallel.for154.us
  %polly.indvar138.us = phi i64 [ %polly.indvar_next139.us, %polly.parallel.for154.us ], [ 0, %polly.loop_if133.us ]
  store i32 %0, ptr %polly.par.userContext, align 8
  store i32 %1, ptr %polly.subfn.storeaddr.141, align 4
  store i32 %2, ptr %polly.subfn.storeaddr.142, align 8
  store i64 %polly.indvar.us, ptr %polly.subfn.storeaddr.polly.indvar, align 8
  store i64 %polly.indvar138.us, ptr %polly.subfn.storeaddr.polly.indvar138, align 8
  store ptr %5, ptr %polly.subfn.storeaddr.143, align 8
  call void @GOMP_parallel_loop_runtime_start(ptr nonnull @kernel_doitgen_polly_subfn, ptr nonnull %polly.par.userContext, i32 0, i64 0, i64 %30, i64 1) #9
  call void @kernel_doitgen_polly_subfn(ptr nonnull %polly.par.userContext) #9
  call void @GOMP_parallel_end() #9
  store i32 %0, ptr %polly.par.userContext145, align 8
  store i32 %1, ptr %polly.subfn.storeaddr.147, align 4
  store i32 %2, ptr %polly.subfn.storeaddr.148, align 8
  store i64 %polly.indvar.us, ptr %polly.subfn.storeaddr.polly.indvar149, align 8
  store i64 %polly.indvar138.us, ptr %polly.subfn.storeaddr.polly.indvar138150, align 8
  store ptr %3, ptr %polly.subfn.storeaddr.151, align 8
  store ptr %4, ptr %polly.subfn.storeaddr.152, align 8
  store ptr %5, ptr %polly.subfn.storeaddr.153, align 8
  call void @GOMP_parallel_loop_runtime_start(ptr nonnull @kernel_doitgen_polly_subfn_1, ptr nonnull %polly.par.userContext145, i32 0, i64 0, i64 %32, i64 1) #9
  call void @kernel_doitgen_polly_subfn_1(ptr nonnull %polly.par.userContext145) #9
  call void @GOMP_parallel_end() #9
  store i32 %0, ptr %polly.par.userContext155, align 8
  store i32 %1, ptr %polly.subfn.storeaddr.157, align 4
  store i32 %2, ptr %polly.subfn.storeaddr.158, align 8
  store i64 %polly.indvar.us, ptr %polly.subfn.storeaddr.polly.indvar159, align 8
  store i64 %polly.indvar138.us, ptr %polly.subfn.storeaddr.polly.indvar138160, align 8
  store ptr %5, ptr %polly.subfn.storeaddr.161, align 8
  store ptr %3, ptr %polly.subfn.storeaddr.162, align 8
  call void @GOMP_parallel_loop_runtime_start(ptr nonnull @kernel_doitgen_polly_subfn_2, ptr nonnull %polly.par.userContext155, i32 0, i64 0, i64 %30, i64 1) #9
  call void @kernel_doitgen_polly_subfn_2(ptr nonnull %polly.par.userContext155) #9
  call void @GOMP_parallel_end() #9
  %polly.indvar_next139.us = add nuw nsw i64 %polly.indvar138.us, 1
  %exitcond.not = icmp eq i64 %polly.indvar_next139.us, %6
  br i1 %exitcond.not, label %polly.loop_exit136.loopexit.us, label %polly.parallel.for154.us

polly.loop_exit136.loopexit.us:                   ; preds = %polly.parallel.for154.us
  %polly.indvar_next.us = add nuw nsw i64 %polly.indvar.us, 1
  %exitcond182.not = icmp eq i64 %polly.indvar_next.us, %12
  br i1 %exitcond182.not, label %_30, label %polly.loop_if133.us
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #1 {
.split:
  %2 = tail call ptr @polybench_alloc_data(i64 noundef 14850000, i32 noundef 4) #9
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 270, i32 noundef 4) #9
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 72900, i32 noundef 4) #9
  tail call void @init_array(i32 noundef 250, i32 noundef 220, i32 noundef 270, ptr noundef %2, ptr noundef %4)
  tail call void @kernel_doitgen(i32 noundef 250, i32 noundef 220, i32 noundef 270, ptr noundef %2, ptr noundef %4, ptr noundef %3)
  %5 = icmp sgt i32 %0, 42
  br i1 %5, label %6, label %9

6:                                                ; preds = %.split
  %7 = load ptr, ptr %1, align 8
  %strcmpload = load i8, ptr %7, align 1
  %.not = icmp eq i8 %strcmpload, 0
  br i1 %.not, label %8, label %9

8:                                                ; preds = %6
  tail call void @print_array(i32 noundef 250, i32 noundef 220, i32 noundef 270, ptr noundef %2)
  br label %9

9:                                                ; preds = %8, %6, %.split
  tail call void @free(ptr noundef %2) #9
  tail call void @free(ptr noundef %3) #9
  tail call void @free(ptr noundef %4) #9
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #2

; Function Attrs: nounwind uwtable
define internal void @init_array(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, ptr noundef %4) #1 {
.split:
  %5 = icmp sgt i32 %0, 0
  br i1 %5, label %.preheader6.lr.ph, label %.preheader4

.preheader6.lr.ph:                                ; preds = %.split
  %wide.trip.count22 = zext i32 %0 to i64
  %6 = icmp sgt i32 %1, 0
  %wide.trip.count18 = zext i32 %1 to i64
  %wide.trip.count = zext i32 %2 to i64
  br i1 %6, label %.preheader6.lr.ph.split.us, label %.preheader4

.preheader6.lr.ph.split.us:                       ; preds = %.preheader6.lr.ph
  %7 = icmp sgt i32 %2, 0
  br i1 %7, label %.preheader6.us.us.preheader, label %._crit_edge15

.preheader6.us.us.preheader:                      ; preds = %.preheader6.lr.ph.split.us
  %8 = shl nuw nsw i64 %wide.trip.count, 2
  br label %.preheader6.us.us

.preheader6.us.us:                                ; preds = %.preheader6.us.us.preheader, %._crit_edge9.loopexit.split.us.us.us
  %indvars.iv20.us.us = phi i64 [ %indvars.iv.next21.us.us, %._crit_edge9.loopexit.split.us.us.us ], [ 0, %.preheader6.us.us.preheader ]
  %9 = mul nuw nsw i64 %indvars.iv20.us.us, 237600
  br label %.preheader5.us.us.us

.preheader5.us.us.us:                             ; preds = %.preheader5.us.us.us, %.preheader6.us.us
  %indvars.iv16.us.us.us = phi i64 [ 0, %.preheader6.us.us ], [ %indvars.iv.next17.us.us.us, %.preheader5.us.us.us ]
  %10 = mul nuw nsw i64 %indvars.iv16.us.us.us, 1080
  %11 = add nuw nsw i64 %9, %10
  %uglygep = getelementptr i8, ptr %3, i64 %11
  call void @llvm.memset.p0.i64(ptr align 4 %uglygep, i8 0, i64 %8, i1 false)
  %indvars.iv.next17.us.us.us = add nuw nsw i64 %indvars.iv16.us.us.us, 1
  %exitcond19.not.us.us.us = icmp eq i64 %indvars.iv.next17.us.us.us, %wide.trip.count18
  br i1 %exitcond19.not.us.us.us, label %._crit_edge9.loopexit.split.us.us.us, label %.preheader5.us.us.us, !llvm.loop !6

._crit_edge9.loopexit.split.us.us.us:             ; preds = %.preheader5.us.us.us
  %indvars.iv.next21.us.us = add nuw nsw i64 %indvars.iv20.us.us, 1
  %exitcond23.not.us.us = icmp eq i64 %indvars.iv.next21.us.us, %wide.trip.count22
  br i1 %exitcond23.not.us.us, label %.preheader4, label %.preheader6.us.us, !llvm.loop !8

.preheader4:                                      ; preds = %._crit_edge9.loopexit.split.us.us.us, %.preheader6.lr.ph, %.split
  %12 = icmp sgt i32 %2, 0
  br i1 %12, label %.preheader.lr.ph, label %._crit_edge15

.preheader.lr.ph:                                 ; preds = %.preheader4
  %wide.trip.count30 = zext i32 %2 to i64
  %13 = shl nuw nsw i64 %wide.trip.count30, 2
  br label %.lr.ph12

.lr.ph12:                                         ; preds = %.lr.ph12, %.preheader.lr.ph
  %indvars.iv28 = phi i64 [ 0, %.preheader.lr.ph ], [ %indvars.iv.next29, %.lr.ph12 ]
  %14 = mul nuw nsw i64 %indvars.iv28, 1080
  %uglygep40 = getelementptr i8, ptr %4, i64 %14
  call void @llvm.memset.p0.i64(ptr align 4 %uglygep40, i8 0, i64 %13, i1 false)
  %indvars.iv.next29 = add nuw nsw i64 %indvars.iv28, 1
  %exitcond31.not = icmp eq i64 %indvars.iv.next29, %wide.trip.count30
  br i1 %exitcond31.not, label %._crit_edge15, label %.lr.ph12, !llvm.loop !9

._crit_edge15:                                    ; preds = %.lr.ph12, %.preheader6.lr.ph.split.us, %.preheader4
  ret void
}

; Function Attrs: nounwind readonly willreturn
declare i32 @strcmp(ptr noundef, ptr noundef) #3

; Function Attrs: nounwind uwtable
define internal void @print_array(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3) #1 {
.split:
  %4 = load ptr, ptr @stderr, align 8
  %5 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %4) #10
  %6 = load ptr, ptr @stderr, align 8
  %7 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %6, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #11
  %8 = icmp sgt i32 %0, 0
  br i1 %8, label %.preheader3.lr.ph, label %._crit_edge8

.preheader3.lr.ph:                                ; preds = %.split
  %wide.trip.count15 = zext i32 %0 to i64
  %9 = icmp sgt i32 %1, 0
  %wide.trip.count11 = zext i32 %1 to i64
  %wide.trip.count = zext i32 %2 to i64
  %10 = icmp sgt i32 %2, 0
  %or.cond = and i1 %9, %10
  br i1 %or.cond, label %.preheader3.us.us, label %._crit_edge8

.preheader3.us.us:                                ; preds = %.preheader3.lr.ph, %._crit_edge6.loopexit.split.us.us.us
  %indvars.iv13.us.us = phi i64 [ %indvars.iv.next14.us.us, %._crit_edge6.loopexit.split.us.us.us ], [ 0, %.preheader3.lr.ph ]
  %11 = trunc i64 %indvars.iv13.us.us to i32
  %12 = mul nsw i32 %11, %1
  br label %.preheader.us.us.us

.preheader.us.us.us:                              ; preds = %._crit_edge.loopexit.us.us.us, %.preheader3.us.us
  %indvars.iv9.us.us.us = phi i64 [ 0, %.preheader3.us.us ], [ %indvars.iv.next10.us.us.us, %._crit_edge.loopexit.us.us.us ]
  %13 = trunc i64 %indvars.iv9.us.us.us to i32
  %14 = add i32 %12, %13
  %15 = mul i32 %14, %2
  br label %16

16:                                               ; preds = %23, %.preheader.us.us.us
  %indvars.iv.us.us.us = phi i64 [ 0, %.preheader.us.us.us ], [ %indvars.iv.next.us.us.us, %23 ]
  %17 = trunc i64 %indvars.iv.us.us.us to i32
  %18 = add i32 %15, %17
  %19 = srem i32 %18, 20
  %20 = icmp eq i32 %19, 0
  br i1 %20, label %21, label %23

21:                                               ; preds = %16
  %22 = load ptr, ptr @stderr, align 8
  %fputc.us.us.us = tail call i32 @fputc(i32 10, ptr %22)
  br label %23

23:                                               ; preds = %21, %16
  %24 = load ptr, ptr @stderr, align 8
  %25 = getelementptr inbounds [220 x [270 x i32]], ptr %3, i64 %indvars.iv13.us.us, i64 %indvars.iv9.us.us.us, i64 %indvars.iv.us.us.us
  %26 = load i32, ptr %25, align 4
  %27 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %24, ptr noundef nonnull @.str.5, i32 noundef %26) #11
  %indvars.iv.next.us.us.us = add nuw nsw i64 %indvars.iv.us.us.us, 1
  %exitcond.not.us.us.us = icmp eq i64 %indvars.iv.next.us.us.us, %wide.trip.count
  br i1 %exitcond.not.us.us.us, label %._crit_edge.loopexit.us.us.us, label %16, !llvm.loop !10

._crit_edge.loopexit.us.us.us:                    ; preds = %23
  %indvars.iv.next10.us.us.us = add nuw nsw i64 %indvars.iv9.us.us.us, 1
  %exitcond12.not.us.us.us = icmp eq i64 %indvars.iv.next10.us.us.us, %wide.trip.count11
  br i1 %exitcond12.not.us.us.us, label %._crit_edge6.loopexit.split.us.us.us, label %.preheader.us.us.us, !llvm.loop !11

._crit_edge6.loopexit.split.us.us.us:             ; preds = %._crit_edge.loopexit.us.us.us
  %indvars.iv.next14.us.us = add nuw nsw i64 %indvars.iv13.us.us, 1
  %exitcond16.not.us.us = icmp eq i64 %indvars.iv.next14.us.us, %wide.trip.count15
  br i1 %exitcond16.not.us.us, label %._crit_edge8, label %.preheader3.us.us, !llvm.loop !12

._crit_edge8:                                     ; preds = %._crit_edge6.loopexit.split.us.us.us, %.preheader3.lr.ph, %.split
  %28 = load ptr, ptr @stderr, align 8
  %29 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %28, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #11
  %30 = load ptr, ptr @stderr, align 8
  %31 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %30) #10
  ret void
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #4

declare i32 @fprintf(ptr noundef, ptr noundef, ...) #2

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.smul.with.overflow.i64(i64, i64) #5

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.sadd.with.overflow.i64(i64, i64) #5

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.ssub.with.overflow.i64(i64, i64) #5

define internal void @kernel_doitgen_polly_subfn(ptr %polly.par.userContext) #6 {
polly.par.setup.split:
  %polly.par.LBPtr = alloca i64, align 8
  %polly.par.UBPtr = alloca i64, align 8
  %0 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr }, ptr %polly.par.userContext, i64 0, i32 5
  %polly.subfunc.arg.3 = load ptr, ptr %0, align 8
  %1 = call i8 @GOMP_loop_runtime_next(ptr nonnull %polly.par.LBPtr, ptr nonnull %polly.par.UBPtr)
  %.not4 = icmp eq i8 %1, 0
  br i1 %.not4, label %polly.par.exit, label %polly.par.loadIVBounds

polly.par.exit:                                   ; preds = %polly.par.loadIVBounds, %polly.par.setup.split
  call void @GOMP_loop_end_nowait()
  ret void

polly.par.loadIVBounds:                           ; preds = %polly.par.setup.split, %polly.par.loadIVBounds
  %polly.par.UB = load i64, ptr %polly.par.UBPtr, align 8
  %polly.par.UBAdjusted = add i64 %polly.par.UB, -1
  %polly.par.LB = load i64, ptr %polly.par.LBPtr, align 8
  %smax = call i64 @llvm.smax.i64(i64 %polly.par.LB, i64 %polly.par.UBAdjusted)
  %2 = shl i64 %polly.par.LB, 2
  %uglygep5 = getelementptr i8, ptr %polly.subfunc.arg.3, i64 %2
  %3 = add i64 %smax, 1
  %4 = sub i64 %3, %polly.par.LB
  %5 = shl nuw i64 %4, 2
  call void @llvm.memset.p0.i64(ptr align 1 %uglygep5, i8 0, i64 %5, i1 false), !alias.scope !13, !noalias !16
  %6 = call i8 @GOMP_loop_runtime_next(ptr nonnull %polly.par.LBPtr, ptr nonnull %polly.par.UBPtr)
  %.not = icmp eq i8 %6, 0
  br i1 %.not, label %polly.par.exit, label %polly.par.loadIVBounds
}

declare i8 @GOMP_loop_runtime_next(ptr, ptr)

declare void @GOMP_loop_end_nowait()

declare void @GOMP_parallel_loop_runtime_start(ptr, ptr, i32, i64, i64, i64)

declare void @GOMP_parallel_end()

define internal void @kernel_doitgen_polly_subfn_1(ptr %polly.par.userContext) #6 {
polly.par.setup.split:
  %polly.par.LBPtr = alloca i64, align 8
  %polly.par.UBPtr = alloca i64, align 8
  %0 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext, i64 0, i32 2
  %polly.subfunc.arg.2 = load i32, ptr %0, align 4
  %1 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext, i64 0, i32 3
  %polly.subfunc.arg.polly.indvar = load i64, ptr %1, align 8
  %2 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext, i64 0, i32 4
  %polly.subfunc.arg.polly.indvar138 = load i64, ptr %2, align 8
  %3 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext, i64 0, i32 5
  %polly.subfunc.arg.3 = load ptr, ptr %3, align 8
  %4 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext, i64 0, i32 6
  %polly.subfunc.arg.4 = load ptr, ptr %4, align 8
  %5 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr, ptr }, ptr %polly.par.userContext, i64 0, i32 7
  %polly.subfunc.arg.5 = load ptr, ptr %5, align 8
  %6 = call i8 @GOMP_loop_runtime_next(ptr nonnull %polly.par.LBPtr, ptr nonnull %polly.par.UBPtr)
  %.not30 = icmp eq i8 %6, 0
  br i1 %.not30, label %polly.par.exit, label %polly.par.loadIVBounds.lr.ph

polly.par.loadIVBounds.lr.ph:                     ; preds = %polly.par.setup.split
  %7 = sext i32 %polly.subfunc.arg.2 to i64
  %8 = add nsw i64 %7, -1
  %9 = lshr i64 %8, 5
  %10 = mul i64 %polly.subfunc.arg.polly.indvar, 237600
  %11 = mul i64 %polly.subfunc.arg.polly.indvar138, 1080
  %12 = add i64 %11, %10
  %uglygep = getelementptr i8, ptr %polly.subfunc.arg.3, i64 %12
  br label %polly.par.loadIVBounds

polly.par.exit:                                   ; preds = %polly.par.checkNext.loopexit, %polly.par.setup.split
  call void @GOMP_loop_end_nowait()
  ret void

polly.par.checkNext.loopexit:                     ; preds = %polly.loop_exit8
  %13 = call i8 @GOMP_loop_runtime_next(ptr nonnull %polly.par.LBPtr, ptr nonnull %polly.par.UBPtr)
  %.not = icmp eq i8 %13, 0
  br i1 %.not, label %polly.par.exit, label %polly.par.loadIVBounds

polly.par.loadIVBounds:                           ; preds = %polly.par.loadIVBounds.lr.ph, %polly.par.checkNext.loopexit
  %polly.par.UB = load i64, ptr %polly.par.UBPtr, align 8
  %polly.par.UBAdjusted = add i64 %polly.par.UB, -1
  %polly.par.LB = load i64, ptr %polly.par.LBPtr, align 8
  %.neg = mul i64 %polly.par.LB, -32
  %14 = add i64 %.neg, %8
  %smax = call i64 @llvm.smax.i64(i64 %polly.par.LB, i64 %polly.par.UBAdjusted)
  br label %polly.loop_header

polly.loop_header:                                ; preds = %polly.loop_exit8, %polly.par.loadIVBounds
  %indvars.iv31 = phi i64 [ %indvars.iv.next32, %polly.loop_exit8 ], [ %14, %polly.par.loadIVBounds ]
  %polly.indvar = phi i64 [ %polly.indvar_next, %polly.loop_exit8 ], [ %polly.par.LB, %polly.par.loadIVBounds ]
  %smin33 = call i64 @llvm.smin.i64(i64 %indvars.iv31, i64 31)
  %15 = shl nsw i64 %polly.indvar, 5
  %16 = xor i64 %15, -1
  %17 = add i64 %16, %7
  %18 = call i64 @llvm.smin.i64(i64 %17, i64 31)
  %polly.loop_guard = icmp sgt i64 %18, -1
  br i1 %polly.loop_guard, label %polly.loop_header6.us, label %polly.loop_exit8

polly.loop_header6.us:                            ; preds = %polly.loop_header, %polly.loop_exit14.loopexit.us
  %indvars.iv.us = phi i64 [ %indvars.iv.next.us, %polly.loop_exit14.loopexit.us ], [ %8, %polly.loop_header ]
  %polly.indvar9.us = phi i64 [ %polly.indvar_next10.us, %polly.loop_exit14.loopexit.us ], [ 0, %polly.loop_header ]
  %smin.us = call i64 @llvm.smin.i64(i64 %indvars.iv.us, i64 31)
  %19 = shl nsw i64 %polly.indvar9.us, 5
  %20 = xor i64 %19, -1
  %21 = add i64 %20, %7
  %22 = call i64 @llvm.smin.i64(i64 %21, i64 31)
  %polly.loop_guard22.us = icmp sgt i64 %22, -1
  br i1 %polly.loop_guard22.us, label %polly.loop_header12.us.us, label %polly.loop_exit14.loopexit.us

polly.loop_exit14.loopexit.us:                    ; preds = %polly.loop_exit21.loopexit.us.us, %polly.loop_header6.us
  %polly.indvar_next10.us = add nuw nsw i64 %polly.indvar9.us, 1
  %indvars.iv.next.us = add i64 %indvars.iv.us, -32
  %exitcond35.not.us = icmp eq i64 %polly.indvar9.us, %9
  br i1 %exitcond35.not.us, label %polly.loop_exit8, label %polly.loop_header6.us

polly.loop_header12.us.us:                        ; preds = %polly.loop_header6.us, %polly.loop_exit21.loopexit.us.us
  %polly.indvar15.us.us = phi i64 [ %polly.indvar_next16.us.us, %polly.loop_exit21.loopexit.us.us ], [ 0, %polly.loop_header6.us ]
  %23 = add nsw i64 %polly.indvar15.us.us, %15
  %24 = shl i64 %23, 2
  %uglygep28.us.us = getelementptr i8, ptr %polly.subfunc.arg.5, i64 %24
  %uglygep28.promoted.us.us = load i32, ptr %uglygep28.us.us, align 1, !alias.scope !13, !noalias !16
  br label %polly.loop_header19.us.us

polly.loop_header19.us.us:                        ; preds = %polly.loop_header19.us.us, %polly.loop_header12.us.us
  %p__7737.us.us = phi i32 [ %p__77.us.us, %polly.loop_header19.us.us ], [ %uglygep28.promoted.us.us, %polly.loop_header12.us.us ]
  %polly.indvar23.us.us = phi i64 [ %polly.indvar_next24.us.us, %polly.loop_header19.us.us ], [ 0, %polly.loop_header12.us.us ]
  %25 = add nuw nsw i64 %polly.indvar23.us.us, %19
  %26 = shl i64 %25, 2
  %uglygep26.us.us = getelementptr i8, ptr %uglygep, i64 %26
  %_70_p_scalar_.us.us = load i32, ptr %uglygep26.us.us, align 1, !alias.scope !19, !noalias !20
  %27 = mul i64 %25, 1080
  %28 = add i64 %27, %24
  %uglygep27.us.us = getelementptr i8, ptr %polly.subfunc.arg.4, i64 %28
  %_73_p_scalar_.us.us = load i32, ptr %uglygep27.us.us, align 1, !alias.scope !21, !noalias !22
  %p__74.us.us = mul i32 %_73_p_scalar_.us.us, %_70_p_scalar_.us.us
  %p__77.us.us = add i32 %p__74.us.us, %p__7737.us.us
  %polly.indvar_next24.us.us = add nuw nsw i64 %polly.indvar23.us.us, 1
  %exitcond.not.us.us = icmp eq i64 %polly.indvar23.us.us, %smin.us
  br i1 %exitcond.not.us.us, label %polly.loop_exit21.loopexit.us.us, label %polly.loop_header19.us.us

polly.loop_exit21.loopexit.us.us:                 ; preds = %polly.loop_header19.us.us
  store i32 %p__77.us.us, ptr %uglygep28.us.us, align 1, !alias.scope !13, !noalias !16
  %polly.indvar_next16.us.us = add nuw nsw i64 %polly.indvar15.us.us, 1
  %exitcond34.not.us.us = icmp eq i64 %polly.indvar15.us.us, %smin33
  br i1 %exitcond34.not.us.us, label %polly.loop_exit14.loopexit.us, label %polly.loop_header12.us.us

polly.loop_exit8:                                 ; preds = %polly.loop_exit14.loopexit.us, %polly.loop_header
  %polly.indvar_next = add i64 %polly.indvar, 1
  %indvars.iv.next32 = add i64 %indvars.iv31, -32
  %exitcond36.not = icmp eq i64 %polly.indvar, %smax
  br i1 %exitcond36.not, label %polly.par.checkNext.loopexit, label %polly.loop_header
}

define internal void @kernel_doitgen_polly_subfn_2(ptr %polly.par.userContext) #6 {
polly.par.setup.split:
  %polly.par.LBPtr = alloca i64, align 8
  %polly.par.UBPtr = alloca i64, align 8
  %0 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr }, ptr %polly.par.userContext, i64 0, i32 3
  %polly.subfunc.arg.polly.indvar = load i64, ptr %0, align 8
  %1 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr }, ptr %polly.par.userContext, i64 0, i32 4
  %polly.subfunc.arg.polly.indvar138 = load i64, ptr %1, align 8
  %2 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr }, ptr %polly.par.userContext, i64 0, i32 5
  %polly.subfunc.arg.3 = load ptr, ptr %2, align 8
  %3 = getelementptr inbounds { i32, i32, i32, i64, i64, ptr, ptr }, ptr %polly.par.userContext, i64 0, i32 6
  %polly.subfunc.arg.4 = load ptr, ptr %3, align 8
  %4 = call i8 @GOMP_loop_runtime_next(ptr nonnull %polly.par.LBPtr, ptr nonnull %polly.par.UBPtr)
  %.not7 = icmp eq i8 %4, 0
  br i1 %.not7, label %polly.par.exit, label %polly.par.loadIVBounds.preheader

polly.par.loadIVBounds.preheader:                 ; preds = %polly.par.setup.split
  %5 = mul i64 %polly.subfunc.arg.polly.indvar, 237600
  %6 = mul i64 %polly.subfunc.arg.polly.indvar138, 1080
  %7 = add i64 %6, %5
  %uglygep5 = getelementptr i8, ptr %polly.subfunc.arg.4, i64 %7
  br label %polly.par.loadIVBounds

polly.par.exit:                                   ; preds = %polly.par.checkNext.loopexit, %polly.par.setup.split
  call void @GOMP_loop_end_nowait()
  ret void

polly.par.checkNext.loopexit:                     ; preds = %polly.loop_header
  %8 = call i8 @GOMP_loop_runtime_next(ptr nonnull %polly.par.LBPtr, ptr nonnull %polly.par.UBPtr)
  %.not = icmp eq i8 %8, 0
  br i1 %.not, label %polly.par.exit, label %polly.par.loadIVBounds

polly.par.loadIVBounds:                           ; preds = %polly.par.loadIVBounds.preheader, %polly.par.checkNext.loopexit
  %polly.par.UB = load i64, ptr %polly.par.UBPtr, align 8
  %polly.par.UBAdjusted = add i64 %polly.par.UB, -1
  %polly.par.LB = load i64, ptr %polly.par.LBPtr, align 8
  %smax = call i64 @llvm.smax.i64(i64 %polly.par.LB, i64 %polly.par.UBAdjusted)
  br label %polly.loop_header

polly.loop_header:                                ; preds = %polly.loop_header, %polly.par.loadIVBounds
  %polly.indvar = phi i64 [ %polly.par.LB, %polly.par.loadIVBounds ], [ %polly.indvar_next, %polly.loop_header ]
  %9 = shl i64 %polly.indvar, 2
  %uglygep = getelementptr i8, ptr %polly.subfunc.arg.3, i64 %9
  %_57_p_scalar_ = load i32, ptr %uglygep, align 1, !alias.scope !13, !noalias !16
  %uglygep6 = getelementptr i8, ptr %uglygep5, i64 %9
  store i32 %_57_p_scalar_, ptr %uglygep6, align 1, !alias.scope !19, !noalias !20
  %polly.indvar_next = add i64 %polly.indvar, 1
  %exitcond.not = icmp eq i64 %polly.indvar, %smax
  br i1 %exitcond.not, label %polly.par.checkNext.loopexit, label %polly.loop_header
}

; Function Attrs: argmemonly nocallback nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #7

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) #8

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr nocapture noundef) #8

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.smax.i64(i64, i64) #5

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.smin.i64(i64, i64) #5

attributes #0 = { nounwind uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "polly-optimized" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #1 = { nounwind uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #3 = { nounwind readonly willreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #4 = { nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #5 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #6 = { "polly.skip.fn" }
attributes #7 = { argmemonly nocallback nofree nounwind willreturn writeonly }
attributes #8 = { nofree nounwind }
attributes #9 = { nounwind }
attributes #10 = { cold }
attributes #11 = { cold nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"clang version 15.0.7"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = !{!14}
!14 = distinct !{!14, !15, !"polly.alias.scope.MemRef0"}
!15 = distinct !{!15, !"polly.alias.scope.domain"}
!16 = !{!17, !18}
!17 = distinct !{!17, !15, !"polly.alias.scope.MemRef1"}
!18 = distinct !{!18, !15, !"polly.alias.scope.MemRef2"}
!19 = !{!17}
!20 = !{!14, !18}
!21 = !{!18}
!22 = !{!14, !17}
