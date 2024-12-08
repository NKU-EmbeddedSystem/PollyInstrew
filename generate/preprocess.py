dst_file = open('/home/zby/PollyInstrew/generate/PollyInstrew_floyd_warshall.ll', 'w')

instrew_file = '/home/zby/PollyInstrew/Instrew_floyd_warshall.ll'


mv_start = False
mv_end = False
has_mv = False

def exclude(line):
    res = False
    if line.startswith('  %') and (line.split()[0][1:]=='.pre'):
            res = True
    if line.startswith('  %') and not line.startswith('  %.'):
        if (line.split()[0][1:]=='.pre') or (int(line.split()[0][1:]) <= 16) or ((int(line.split()[0][1:])>=19) and (int(line.split()[0][1:])<=23)):
            res = True
    if line.find('store i64 %6, ptr %15, align 1')>=0 or line.find('store i64 %10, ptr %12, align 4')>=0 or line.find('store i32 %13, ptr %14, align 1')>=0 or line.find('store i64 %19, ptr addrspace(1) %9, align 16')>=0 or line.find('store i32 %38, ptr %16, align 1')>=0:
            res = True
    return res


def get_kernel_func(src):
    start = False
    end = False
    res = ''
    with open(src,'r') as src_file:
        lines = src_file.readlines() 
        for line in lines:
            if line.startswith('define'):
                start = True
                continue
            if line.startswith('  ret'):
                res += '  ret void\n'
                continue
            elif line.startswith('}'):
                end = True
                res += '}\n'
            if start == False or end == True or exclude(line):
                continue
            res += line
    return res

kernel_func=get_kernel_func(instrew_file)

kernel_func=kernel_func.replace('28', '_28')
kernel_func=kernel_func.replace('30', '_30')
kernel_func=kernel_func.replace('%', '%_')
kernel_func=kernel_func.replace('%_13', '%0')
kernel_func=kernel_func.replace('%__', '%_')
kernel_func=kernel_func.replace('%_.', '%.')
kernel_func=kernel_func.replace(' addrspace(64) ', ' ')
kernel_func=kernel_func.replace('inttoptr (i64 %_6 to ptr addrspace(64))', '%1')

print(kernel_func)

with open('/home/zby/PolyBenchC-4.2.1/medley/floyd-warshall/floyd-warshall-arm-ori.ll', 'r') as src_file: 
    lines = src_file.readlines() 
    for line in lines:
        if line.find("define internal void @kernel_floyd_warshall") >= 0:
            mv_start = True
            dst_file.write(line)
        elif line.find("declare void @polybench_timer_stop(...) #1") >=0:
            mv_end = True
        if line.startswith('declare i32 @fprintf'):
            dst_file.write('declare i32 @llvm.smin.i32(i32, i32) #6\n')
        if line.startswith('attributes #5'):
            dst_file.write(line)
            dst_file.write('attributes #6 = { nocallback nofree nosync nounwind readnone speculatable willreturn }\n')
            continue
        if mv_start==True and mv_end == False:
            if has_mv == False:
                dst_file.write(kernel_func)
                has_mv = True
            else:
                continue
        elif mv_start == False or mv_end == True:
            dst_file.write(line)