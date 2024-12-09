; ModuleID = 'linear-algebra/kernels/doitgen/doitgen.c'
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

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @kernel_doitgen(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5) #0 {
  %.not47 = icmp sgt i32 %0, 0
  br i1 %.not47, label %.preheader18.lr.ph, label %_30

.preheader18.lr.ph:                               ; preds = %_9
  br label %.preheader18

.preheader18:                                     ; preds = %.preheader18.lr.ph, %_42
  %_29 = phi i32 [ 0, %.preheader18.lr.ph ], [ %_43, %_42 ]
  %.not1342 = icmp sgt i32 %1, 0
  br i1 %.not1342, label %.preheader17.lr.ph, label %_42

.preheader17.lr.ph:                               ; preds = %.preheader18
  br label %.preheader17

._crit_edge48:                                    ; preds = %_42
  br label %_30

_30:                                               ; preds = %._crit_edge48, %_9
  ret void

.preheader17:                                     ; preds = %.preheader17.lr.ph, %_51
  %.01043 = phi i32 [ 0, %.preheader17.lr.ph ], [ %_52, %_51 ]
  %.not1432 = icmp sgt i32 %2, 0
  br i1 %.not1432, label %.lr.ph33, label %.preheader

.lr.ph33:                                         ; preds = %.preheader17
  br label %_44

._crit_edge44:                                    ; preds = %_51
  br label %_42

_42:                                               ; preds = %._crit_edge44, %.preheader18
  %_43 = add nuw nsw i32 %_29, 1
  %.not = icmp slt i32 %_43, %0
  br i1 %.not, label %.preheader18, label %._crit_edge48

..preheader_crit_edge:                            ; preds = %_63
  br label %.preheader

.preheader:                                       ; preds = %..preheader_crit_edge, %.preheader17
  %.not1636 = icmp sgt i32 %2, 0
  br i1 %.not1636, label %.lr.ph38, label %_51

.lr.ph38:                                         ; preds = %.preheader
  br label %_53

_44:                                               ; preds = %.lr.ph33, %_63
  %_46 = phi i32 [ 0, %.lr.ph33 ], [ %_64, %_63 ]
  %_47 = zext i32 %_46 to i64
  %_49 = getelementptr i32, ptr %5, i64 %_47
  store i32 0, ptr %_49, align 1
  %.not1529 = icmp sgt i32 %2, 0
  br i1 %.not1529, label %.lr.ph, label %_63

.lr.ph:                                           ; preds = %_44
  br label %_65

._crit_edge39:                                    ; preds = %_53
  %_50 = zext i32 %_57 to i64
  br label %_51

_51:                                               ; preds = %._crit_edge39, %.preheader
  %_52 = add nuw nsw i32 %.01043, 1
  %.not13 = icmp slt i32 %_52, %1
  br i1 %.not13, label %.preheader17, label %._crit_edge44

_53:                                               ; preds = %.lr.ph38, %_53
  %.137 = phi i32 [ 0, %.lr.ph38 ], [ %_61, %_53 ]
  %_54 = zext i32 %.137 to i64
  %_56 = getelementptr i32, ptr %5, i64 %_54
  %_57 = load i32, ptr %_56, align 1
  %_58 = zext i32 %_29 to i64
  %_59 = zext i32 %.01043 to i64
  %_60 = getelementptr inbounds [220 x [270 x i32]], ptr %3, i64 %_58, i64 %_59, i64 %_54
  store i32 %_57, ptr %_60, align 1
  %_61 = add nuw nsw i32 %.137, 1
  %.not16 = icmp slt i32 %_61, %2
  br i1 %.not16, label %_53, label %._crit_edge39

._crit_edge:                                      ; preds = %_65
  %_62 = zext i32 %_77 to i64
  br label %_63

_63:                                               ; preds = %._crit_edge, %_44
  %_64 = add nuw nsw i32 %_46, 1
  %.not14 = icmp slt i32 %_64, %2
  br i1 %.not14, label %_44, label %..preheader_crit_edge

_65:                                               ; preds = %.lr.ph, %_65
  %.01230 = phi i32 [ 0, %.lr.ph ], [ %_78, %_65 ]
  %_66 = zext i32 %_29 to i64
  %_67 = zext i32 %.01043 to i64
  %_68 = zext i32 %.01230 to i64
  %_69 = getelementptr inbounds [220 x [270 x i32]], ptr %3, i64 %_66, i64 %_67, i64 %_68
  %_70 = load i32, ptr %_69, align 1
  %_71 = zext i32 %_46 to i64
  %_72 = getelementptr inbounds [270 x i32], ptr %4, i64 %_68, i64 %_71
  %_73 = load i32, ptr %_72, align 1
  %_74 = mul i32 %_73, %_70
  %_75 = getelementptr i32, ptr %5, i64 %_71
  %_76 = load i32, ptr %_75, align 1
  %_77 = add i32 %_74, %_76
  store i32 %_77, ptr %_75, align 1
  %_78 = add nuw nsw i32 %.01230, 1
  %.not15 = icmp slt i32 %_78, %2
  br i1 %.not15, label %_65, label %._crit_edge
}
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 250, ptr %6, align 4
  store i32 220, ptr %7, align 4
  store i32 270, ptr %8, align 4
  %12 = call ptr @polybench_alloc_data(i64 noundef 14850000, i32 noundef 4)
  store ptr %12, ptr %9, align 8
  %13 = call ptr @polybench_alloc_data(i64 noundef 270, i32 noundef 4)
  store ptr %13, ptr %10, align 8
  %14 = call ptr @polybench_alloc_data(i64 noundef 72900, i32 noundef 4)
  store ptr %14, ptr %11, align 8
  %15 = load i32, ptr %6, align 4
  %16 = load i32, ptr %7, align 4
  %17 = load i32, ptr %8, align 4
  %18 = load ptr, ptr %9, align 8
  %19 = getelementptr inbounds [250 x [220 x [270 x i32]]], ptr %18, i64 0, i64 0
  %20 = load ptr, ptr %11, align 8
  %21 = getelementptr inbounds [270 x [270 x i32]], ptr %20, i64 0, i64 0
  call void @init_array(i32 noundef %15, i32 noundef %16, i32 noundef %17, ptr noundef %19, ptr noundef %21)
  %22 = load i32, ptr %6, align 4
  %23 = load i32, ptr %7, align 4
  %24 = load i32, ptr %8, align 4
  %25 = load ptr, ptr %9, align 8
  %26 = getelementptr inbounds [250 x [220 x [270 x i32]]], ptr %25, i64 0, i64 0
  %27 = load ptr, ptr %11, align 8
  %28 = getelementptr inbounds [270 x [270 x i32]], ptr %27, i64 0, i64 0
  %29 = load ptr, ptr %10, align 8
  %30 = getelementptr inbounds [270 x i32], ptr %29, i64 0, i64 0
  call void @kernel_doitgen(i32 noundef %22, i32 noundef %23, i32 noundef %24, ptr noundef %26, ptr noundef %28, ptr noundef %30)
  %31 = load i32, ptr %4, align 4
  %32 = icmp sgt i32 %31, 42
  br i1 %32, label %33, label %45

33:                                               ; preds = %2
  %34 = load ptr, ptr %5, align 8
  %35 = getelementptr inbounds ptr, ptr %34, i64 0
  %36 = load ptr, ptr %35, align 8
  %37 = call i32 @strcmp(ptr noundef %36, ptr noundef @.str) #4
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %45, label %39

39:                                               ; preds = %33
  %40 = load i32, ptr %6, align 4
  %41 = load i32, ptr %7, align 4
  %42 = load i32, ptr %8, align 4
  %43 = load ptr, ptr %9, align 8
  %44 = getelementptr inbounds [250 x [220 x [270 x i32]]], ptr %43, i64 0, i64 0
  call void @print_array(i32 noundef %40, i32 noundef %41, i32 noundef %42, ptr noundef %44)
  br label %45

45:                                               ; preds = %39, %33, %2
  %46 = load ptr, ptr %9, align 8
  call void @free(ptr noundef %46) #5
  %47 = load ptr, ptr %10, align 8
  call void @free(ptr noundef %47) #5
  %48 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %48) #5
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_array(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3, ptr noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store ptr %3, ptr %9, align 8
  store ptr %4, ptr %10, align 8
  store i32 0, ptr %11, align 4
  br label %14

14:                                               ; preds = %56, %5
  %15 = load i32, ptr %11, align 4
  %16 = load i32, ptr %6, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %59

18:                                               ; preds = %14
  store i32 0, ptr %12, align 4
  br label %19

19:                                               ; preds = %52, %18
  %20 = load i32, ptr %12, align 4
  %21 = load i32, ptr %7, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %55

23:                                               ; preds = %19
  store i32 0, ptr %13, align 4
  br label %24

24:                                               ; preds = %48, %23
  %25 = load i32, ptr %13, align 4
  %26 = load i32, ptr %8, align 4
  %27 = icmp slt i32 %25, %26
  br i1 %27, label %28, label %51

28:                                               ; preds = %24
  %29 = load i32, ptr %11, align 4
  %30 = load i32, ptr %12, align 4
  %31 = mul nsw i32 %29, %30
  %32 = load i32, ptr %13, align 4
  %33 = add nsw i32 %31, %32
  %34 = load i32, ptr %8, align 4
  %35 = srem i32 %33, %34
  %36 = load i32, ptr %8, align 4
  %37 = sdiv i32 %35, %36
  %38 = load ptr, ptr %9, align 8
  %39 = load i32, ptr %11, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [220 x [270 x i32]], ptr %38, i64 %40
  %42 = load i32, ptr %12, align 4
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds [220 x [270 x i32]], ptr %41, i64 0, i64 %43
  %45 = load i32, ptr %13, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [270 x i32], ptr %44, i64 0, i64 %46
  store i32 %37, ptr %47, align 4
  br label %48

48:                                               ; preds = %28
  %49 = load i32, ptr %13, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, ptr %13, align 4
  br label %24, !llvm.loop !12

51:                                               ; preds = %24
  br label %52

52:                                               ; preds = %51
  %53 = load i32, ptr %12, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, ptr %12, align 4
  br label %19, !llvm.loop !13

55:                                               ; preds = %19
  br label %56

56:                                               ; preds = %55
  %57 = load i32, ptr %11, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, ptr %11, align 4
  br label %14, !llvm.loop !14

59:                                               ; preds = %14
  store i32 0, ptr %11, align 4
  br label %60

60:                                               ; preds = %88, %59
  %61 = load i32, ptr %11, align 4
  %62 = load i32, ptr %8, align 4
  %63 = icmp slt i32 %61, %62
  br i1 %63, label %64, label %91

64:                                               ; preds = %60
  store i32 0, ptr %12, align 4
  br label %65

65:                                               ; preds = %84, %64
  %66 = load i32, ptr %12, align 4
  %67 = load i32, ptr %8, align 4
  %68 = icmp slt i32 %66, %67
  br i1 %68, label %69, label %87

69:                                               ; preds = %65
  %70 = load i32, ptr %11, align 4
  %71 = load i32, ptr %12, align 4
  %72 = mul nsw i32 %70, %71
  %73 = load i32, ptr %8, align 4
  %74 = srem i32 %72, %73
  %75 = load i32, ptr %8, align 4
  %76 = sdiv i32 %74, %75
  %77 = load ptr, ptr %10, align 8
  %78 = load i32, ptr %11, align 4
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds [270 x i32], ptr %77, i64 %79
  %81 = load i32, ptr %12, align 4
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds [270 x i32], ptr %80, i64 0, i64 %82
  store i32 %76, ptr %83, align 4
  br label %84

84:                                               ; preds = %69
  %85 = load i32, ptr %12, align 4
  %86 = add nsw i32 %85, 1
  store i32 %86, ptr %12, align 4
  br label %65, !llvm.loop !15

87:                                               ; preds = %65
  br label %88

88:                                               ; preds = %87
  %89 = load i32, ptr %11, align 4
  %90 = add nsw i32 %89, 1
  store i32 %90, ptr %11, align 4
  br label %60, !llvm.loop !16

91:                                               ; preds = %60
  ret void
}

; Function Attrs: nounwind readonly willreturn
declare i32 @strcmp(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @print_array(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store ptr %3, ptr %8, align 8
  %12 = load ptr, ptr @stderr, align 8
  %13 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %12, ptr noundef @.str.1)
  %14 = load ptr, ptr @stderr, align 8
  %15 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %14, ptr noundef @.str.2, ptr noundef @.str.3)
  store i32 0, ptr %9, align 4
  br label %16

16:                                               ; preds = %69, %4
  %17 = load i32, ptr %9, align 4
  %18 = load i32, ptr %5, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %72

20:                                               ; preds = %16
  store i32 0, ptr %10, align 4
  br label %21

21:                                               ; preds = %65, %20
  %22 = load i32, ptr %10, align 4
  %23 = load i32, ptr %6, align 4
  %24 = icmp slt i32 %22, %23
  br i1 %24, label %25, label %68

25:                                               ; preds = %21
  store i32 0, ptr %11, align 4
  br label %26

26:                                               ; preds = %61, %25
  %27 = load i32, ptr %11, align 4
  %28 = load i32, ptr %7, align 4
  %29 = icmp slt i32 %27, %28
  br i1 %29, label %30, label %64

30:                                               ; preds = %26
  %31 = load i32, ptr %9, align 4
  %32 = load i32, ptr %6, align 4
  %33 = mul nsw i32 %31, %32
  %34 = load i32, ptr %7, align 4
  %35 = mul nsw i32 %33, %34
  %36 = load i32, ptr %10, align 4
  %37 = load i32, ptr %7, align 4
  %38 = mul nsw i32 %36, %37
  %39 = add nsw i32 %35, %38
  %40 = load i32, ptr %11, align 4
  %41 = add nsw i32 %39, %40
  %42 = srem i32 %41, 20
  %43 = icmp eq i32 %42, 0
  br i1 %43, label %44, label %47

44:                                               ; preds = %30
  %45 = load ptr, ptr @stderr, align 8
  %46 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %45, ptr noundef @.str.4)
  br label %47

47:                                               ; preds = %44, %30
  %48 = load ptr, ptr @stderr, align 8
  %49 = load ptr, ptr %8, align 8
  %50 = load i32, ptr %9, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds [220 x [270 x i32]], ptr %49, i64 %51
  %53 = load i32, ptr %10, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [220 x [270 x i32]], ptr %52, i64 0, i64 %54
  %56 = load i32, ptr %11, align 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds [270 x i32], ptr %55, i64 0, i64 %57
  %59 = load i32, ptr %58, align 4
  %60 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %48, ptr noundef @.str.5, i32 noundef %59)
  br label %61

61:                                               ; preds = %47
  %62 = load i32, ptr %11, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, ptr %11, align 4
  br label %26, !llvm.loop !17

64:                                               ; preds = %26
  br label %65

65:                                               ; preds = %64
  %66 = load i32, ptr %10, align 4
  %67 = add nsw i32 %66, 1
  store i32 %67, ptr %10, align 4
  br label %21, !llvm.loop !18

68:                                               ; preds = %21
  br label %69

69:                                               ; preds = %68
  %70 = load i32, ptr %9, align 4
  %71 = add nsw i32 %70, 1
  store i32 %71, ptr %9, align 4
  br label %16, !llvm.loop !19

72:                                               ; preds = %16
  %73 = load ptr, ptr @stderr, align 8
  %74 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %73, ptr noundef @.str.6, ptr noundef @.str.3)
  %75 = load ptr, ptr @stderr, align 8
  %76 = call i32 (ptr, ptr, ...) @fprintf(ptr noundef %75, ptr noundef @.str.7)
  ret void
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #3

declare i32 @fprintf(ptr noundef, ptr noundef, ...) #1

attributes #0 = { nounwind uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #2 = { nounwind readonly willreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #3 = { nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+neon,+outline-atomics,+v8a" }
attributes #4 = { nounwind readonly willreturn }
attributes #5 = { nounwind }

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
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
