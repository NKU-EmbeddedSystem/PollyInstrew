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
  %21 = getelementptr i8, ptr %19, i64 -20
  store i32 %20, ptr %21, align 1
  %22 = getelementptr i8, ptr %19, i64 -32
  store i64 %6, ptr %22, align 1
  %23 = getelementptr i8, ptr %19, i64 -40
  store i64 %3, ptr %23, align 1
  %24 = sub i32 %20, 1
  %25 = zext i32 %24 to i64
  %26 = getelementptr i8, ptr %19, i64 -12
  store i32 %24, ptr %26, align 1
  br label %27

27:                                               ; preds = %71, %9
  %28 = phi i32 [ %20, %9 ], [ %55, %71 ]
  %29 = phi i32 [ %24, %9 ], [ %73, %71 ]
  %30 = phi i64 [ %7, %9 ], [ %57, %71 ]
  %31 = phi i64 [ %6, %9 ], [ %58, %71 ]
  %32 = phi i64 [ %3, %9 ], [ %59, %71 ]
  %33 = phi i64 [ %2, %9 ], [ %60, %71 ]
  %34 = phi i64 [ %25, %9 ], [ %61, %71 ]
  %35 = icmp slt i32 %29, 0
  %36 = xor i1 %35, true
  br i1 %36, label %37, label %40

37:                                               ; preds = %27
  %38 = add i32 %29, 1
  %39 = getelementptr i8, ptr %19, i64 -8
  store i32 %38, ptr %39, align 1
  br label %54

40:                                               ; preds = %27
  %41 = getelementptr i64, ptr %19, i64 1
  %42 = load i64, ptr %19, align 4
  %43 = getelementptr i64, ptr %41, i64 1
  %44 = ptrtoint ptr %43 to i64
  %45 = load i64, ptr %41, align 4
  store i64 %42, ptr addrspace(1) %10, align 4
  store i1 undef, ptr addrspace(1) %11, align 1
  store i1 undef, ptr addrspace(1) %12, align 1
  store i8 undef, ptr addrspace(1) %13, align 1
  store i1 undef, ptr addrspace(1) %14, align 1
  store i1 undef, ptr addrspace(1) %15, align 1
  store i1 undef, ptr addrspace(1) %16, align 1
  %46 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } undef, i64 %45, 0
  %47 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %46, i64 %34, 1
  %48 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %47, i64 %33, 2
  %49 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %48, i64 %32, 3
  %50 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %49, i64 %4, 4
  %51 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %50, i64 %44, 5
  %52 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %51, i64 %31, 6
  %53 = insertvalue { i64, i64, i64, i64, i64, i64, i64, i64 } %52, i64 %30, 7
  ret { i64, i64, i64, i64, i64, i64, i64, i64 } %53

54:                                               ; preds = %37, %208
  %55 = phi i32 [ %.pre, %208 ], [ %28, %37 ]
  %56 = phi i32 [ %209, %208 ], [ %38, %37 ]
  %57 = phi i64 [ %141, %208 ], [ %30, %37 ]
  %58 = phi i64 [ %161, %208 ], [ %31, %37 ]
  %59 = phi i64 [ %162, %208 ], [ %32, %37 ]
  %60 = phi i64 [ %163, %208 ], [ %33, %37 ]
  %61 = zext i32 %56 to i64
  %62 = sub i32 %56, %55
  %63 = icmp slt i32 %62, 0
  %64 = icmp slt i32 %56, %55
  %65 = icmp ne i1 %63, %64
  %66 = icmp ne i1 %63, %65
  br i1 %66, label %67, label %71

67:                                               ; preds = %54
  %68 = icmp slt i32 %56, 0
  %69 = icmp eq i32 %56, 0
  %70 = or i1 %69, %68
  br i1 %70, label %74, label %88

71:                                               ; preds = %54
  %72 = load i32, ptr %26, align 1
  %73 = sub i32 %72, 1
  store i32 %73, ptr %26, align 1
  br label %27

74:                                               ; preds = %88, %67
  %75 = phi i32 [ %55, %67 ], [ %.pre2, %88 ]
  %76 = phi i64 [ %58, %67 ], [ %91, %88 ]
  %77 = phi i64 [ %59, %67 ], [ %108, %88 ]
  %78 = phi i64 [ %60, %67 ], [ %93, %88 ]
  %79 = load i32, ptr %26, align 1
  %80 = add i32 %79, 1
  %81 = sub i32 %75, %80
  %82 = icmp slt i32 %81, 0
  %83 = icmp eq i32 %75, %80
  %84 = icmp slt i32 %75, %80
  %85 = icmp ne i1 %82, %84
  %86 = icmp ne i1 %82, %85
  %87 = or i1 %83, %86
  br i1 %87, label %109, label %117

88:                                               ; preds = %67
  %89 = load i32, ptr %26, align 1
  %90 = sext i32 %89 to i64
  %91 = mul i64 %90, 720
  %92 = load i64, ptr %23, align 1
  %93 = add i64 %91, %92
  %94 = sext i32 %56 to i64
  %95 = inttoptr i64 %93 to ptr
  %96 = getelementptr i32, ptr %95, i64 %94
  %97 = load i32, ptr %96, align 1
  %98 = sub i32 %56, 1
  %99 = sext i32 %98 to i64
  %100 = getelementptr i32, ptr %95, i64 %99
  %101 = load i32, ptr %100, align 1
  %102 = sub i32 %97, %101
  %103 = icmp slt i32 %102, 0
  %104 = icmp slt i32 %97, %101
  %105 = icmp ne i1 %103, %104
  %106 = icmp ne i1 %103, %105
  %107 = select i1 %106, i32 %101, i32 %97
  %108 = zext i32 %107 to i64
  store i32 %107, ptr %96, align 1
  %.pre2 = load i32, ptr %21, align 1
  br label %74

109:                                              ; preds = %117, %74
  %110 = phi i64 [ %76, %74 ], [ %119, %117 ]
  %111 = phi i64 [ %77, %74 ], [ %139, %117 ]
  %112 = phi i64 [ %78, %74 ], [ %121, %117 ]
  %113 = load i32, ptr %39, align 1
  %114 = icmp slt i32 %113, 0
  %115 = icmp eq i32 %113, 0
  %116 = or i1 %115, %114
  br i1 %116, label %140, label %148

117:                                              ; preds = %74
  %118 = sext i32 %79 to i64
  %119 = mul i64 %118, 720
  %120 = load i64, ptr %23, align 1
  %121 = add i64 %119, %120
  %122 = load i32, ptr %39, align 1
  %123 = sext i32 %122 to i64
  %124 = inttoptr i64 %121 to ptr
  %125 = getelementptr i32, ptr %124, i64 %123
  %126 = load i32, ptr %125, align 1
  %127 = add i64 %118, 1
  %128 = mul i64 %127, 720
  %129 = add i64 %128, %120
  %130 = inttoptr i64 %129 to ptr
  %131 = getelementptr i32, ptr %130, i64 %123
  %132 = load i32, ptr %131, align 1
  %133 = sub i32 %126, %132
  %134 = icmp slt i32 %133, 0
  %135 = icmp slt i32 %126, %132
  %136 = icmp ne i1 %134, %135
  %137 = icmp ne i1 %134, %136
  %138 = select i1 %137, i32 %132, i32 %126
  %139 = zext i32 %138 to i64
  store i32 %138, ptr %125, align 1
  br label %109

140:                                              ; preds = %109, %233, %148, %210
  %141 = phi i64 [ %57, %210 ], [ %57, %148 ], [ %238, %233 ], [ %57, %109 ]
  %142 = phi i64 [ %212, %210 ], [ %110, %148 ], [ %235, %233 ], [ %110, %109 ]
  %143 = phi i64 [ %232, %210 ], [ %111, %148 ], [ %276, %233 ], [ %111, %109 ]
  %144 = phi i64 [ %214, %210 ], [ %112, %148 ], [ %237, %233 ], [ %112, %109 ]
  %145 = load i32, ptr %26, align 1
  %146 = add i32 %145, 1
  %147 = getelementptr i8, ptr %19, i64 -4
  store i32 %146, ptr %147, align 1
  br label %159

148:                                              ; preds = %109
  %149 = load i32, ptr %26, align 1
  %150 = add i32 %149, 1
  %151 = load i32, ptr %21, align 1
  %152 = sub i32 %151, %150
  %153 = icmp slt i32 %152, 0
  %154 = icmp eq i32 %151, %150
  %155 = icmp slt i32 %151, %150
  %156 = icmp ne i1 %153, %155
  %157 = icmp ne i1 %153, %156
  %158 = or i1 %154, %157
  br i1 %158, label %140, label %170

159:                                              ; preds = %140, %178
  %160 = phi i32 [ %207, %178 ], [ %146, %140 ]
  %161 = phi i64 [ %181, %178 ], [ %142, %140 ]
  %162 = phi i64 [ %205, %178 ], [ %143, %140 ]
  %163 = phi i64 [ %183, %178 ], [ %144, %140 ]
  %164 = load i32, ptr %39, align 1
  %165 = sub i32 %160, %164
  %166 = icmp slt i32 %165, 0
  %167 = icmp slt i32 %160, %164
  %168 = icmp ne i1 %166, %167
  %169 = icmp ne i1 %166, %168
  br i1 %169, label %178, label %208

170:                                              ; preds = %148
  %171 = sub i32 %113, 1
  %172 = sub i32 %149, %171
  %173 = icmp slt i32 %172, 0
  %174 = icmp slt i32 %149, %171
  %175 = icmp ne i1 %173, %174
  %176 = icmp ne i1 %173, %175
  %177 = xor i1 %176, true
  br i1 %177, label %210, label %233

178:                                              ; preds = %159
  %179 = load i32, ptr %26, align 1
  %180 = sext i32 %179 to i64
  %181 = mul i64 %180, 720
  %182 = load i64, ptr %23, align 1
  %183 = add i64 %181, %182
  %184 = sext i32 %164 to i64
  %185 = inttoptr i64 %183 to ptr
  %186 = getelementptr i32, ptr %185, i64 %184
  %187 = load i32, ptr %186, align 1
  %188 = sext i32 %160 to i64
  %189 = getelementptr i32, ptr %185, i64 %188
  %190 = load i32, ptr %189, align 1
  %191 = add i64 %188, 1
  %192 = mul i64 %191, 720
  %193 = add i64 %192, %182
  %194 = inttoptr i64 %193 to ptr
  %195 = getelementptr i32, ptr %194, i64 %184
  %196 = load i32, ptr %195, align 1
  %197 = add i32 %196, %190
  %198 = sub i32 %187, %197
  %199 = icmp slt i32 %198, 0
  %200 = icmp slt i32 %187, %197
  %201 = icmp ne i1 %199, %200
  %202 = icmp ne i1 %199, %201
  %203 = xor i1 %202, true
  %204 = select i1 %203, i32 %187, i32 %197
  %205 = zext i32 %204 to i64
  store i32 %204, ptr %186, align 1
  %206 = load i32, ptr %147, align 1
  %207 = add i32 %206, 1
  store i32 %207, ptr %147, align 1
  br label %159

208:                                              ; preds = %159
  %209 = add i32 %164, 1
  store i32 %209, ptr %39, align 1
  %.pre = load i32, ptr %21, align 1
  br label %54

210:                                              ; preds = %170
  %211 = sext i32 %149 to i64
  %212 = mul i64 %211, 720
  %213 = load i64, ptr %23, align 1
  %214 = add i64 %212, %213
  %215 = sext i32 %113 to i64
  %216 = inttoptr i64 %214 to ptr
  %217 = getelementptr i32, ptr %216, i64 %215
  %218 = load i32, ptr %217, align 1
  %219 = add i64 %211, 1
  %220 = mul i64 %219, 720
  %221 = add i64 %220, %213
  %222 = sext i32 %171 to i64
  %223 = inttoptr i64 %221 to ptr
  %224 = getelementptr i32, ptr %223, i64 %222
  %225 = load i32, ptr %224, align 1
  %226 = sub i32 %218, %225
  %227 = icmp slt i32 %226, 0
  %228 = icmp slt i32 %218, %225
  %229 = icmp ne i1 %227, %228
  %230 = icmp ne i1 %227, %229
  %231 = select i1 %230, i32 %225, i32 %218
  %232 = zext i32 %231 to i64
  store i32 %231, ptr %217, align 1
  br label %140

233:                                              ; preds = %170
  %234 = sext i32 %149 to i64
  %235 = mul i64 %234, 720
  %236 = load i64, ptr %23, align 1
  %237 = add i64 %235, %236
  %238 = sext i32 %113 to i64
  %239 = inttoptr i64 %237 to ptr
  %240 = getelementptr i32, ptr %239, i64 %238
  %241 = load i32, ptr %240, align 1
  %242 = add i64 %234, 1
  %243 = mul i64 %242, 720
  %244 = add i64 %243, %236
  %245 = sext i32 %171 to i64
  %246 = inttoptr i64 %244 to ptr
  %247 = getelementptr i32, ptr %246, i64 %245
  %248 = load i32, ptr %247, align 1
  %249 = load i64, ptr %22, align 1
  %250 = add i64 %249, %234
  %251 = inttoptr i64 %250 to ptr
  %252 = load i8, ptr %251, align 1
  %253 = zext i8 %252 to i32
  %254 = zext i32 %253 to i64
  %255 = trunc i64 %254 to i8
  %256 = sext i8 %255 to i32
  %257 = add i64 %249, %238
  %258 = inttoptr i64 %257 to ptr
  %259 = load i8, ptr %258, align 1
  %260 = zext i8 %259 to i32
  %261 = zext i32 %260 to i64
  %262 = trunc i64 %261 to i8
  %263 = sext i8 %262 to i32
  %264 = add i32 %263, %256
  %265 = icmp eq i32 %264, 3
  %266 = zext i1 %265 to i8
  %267 = zext i8 %266 to i32
  %268 = add i32 %267, %248
  %269 = sub i32 %241, %268
  %270 = icmp slt i32 %269, 0
  %271 = icmp slt i32 %241, %268
  %272 = icmp ne i1 %270, %271
  %273 = icmp ne i1 %270, %272
  %274 = xor i1 %273, true
  %275 = select i1 %274, i32 %241, i32 %268
  %276 = zext i32 %275 to i64
  store i32 %275, ptr %240, align 1
  br label %140
}

attributes #0 = { null_pointer_is_valid }

!0 = !{i64 -1, i64 -1}
