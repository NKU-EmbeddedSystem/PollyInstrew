dst_file = open('/home/zby/test202412/PollyInstrew/generate/PollyInstrew_doitgen.ll', 'w')

instrew_file = '/home/zby/test202412/PollyInstrew/Instrew_doitgen.ll'


mv_start = False
mv_end = False
has_mv = False

def exclude(line):
    res = False
    if line.startswith('  %') and (line.split()[0][1:]=='.pre'):
            res = True
    if line.startswith('  %') and not line.startswith('  %.'):
        if (int(line.split()[0][1:]) <= 28) or ((int(line.split()[0][1:])>=31) and (int(line.split()[0][1:])<=39)) or (int(line.split()[0][1:]) == 48) or (int(line.split()[0][1:]) == 55) :
            res = True
    if line.find('store i64 %13, ptr %17, align 4')>=0 or line.find('store i32 %18, ptr %19, align 1')>=0 or line.find('store i32 %20, ptr %21, align 1')>=0 or line.find('store i32 %22, ptr %23, align 1')>=0 or line.find('store i64 %2, ptr %24, align 1')>=0  or line.find('store i64 %14, ptr %25, align 1')>=0  or line.find('store i64 %15, ptr %26, align 1')>=0 or line.find('store i64 %31, ptr addrspace(1) %10, align 16')>=0:
            res = True
    if line.find('lcssa')>=0:
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
            if line.split(':')[0].isdigit():
                line = '_' + line
            elif line.startswith('}'):
                end = True
                res += '}\n'
            if start == False or end == True or exclude(line):
                continue
            res += line
    return res

kernel_func=get_kernel_func(instrew_file)

kernel_func=kernel_func.replace('%', '%_')
kernel_func=kernel_func.replace('%_.', '%.')
kernel_func=kernel_func.replace('%_18', '%0')
kernel_func=kernel_func.replace('%_20', '%1')
kernel_func=kernel_func.replace('%_22', '%2')
kernel_func=kernel_func.replace('%_48', '%5')
kernel_func=kernel_func.replace('%_55', '%5')
kernel_func=kernel_func.replace(' addrspace(64) ', ' ')
kernel_func=kernel_func.replace('inttoptr (i64 %_2 to ptr addrspace(64))', '%3')
kernel_func=kernel_func.replace('inttoptr (i64 %_14 to ptr addrspace(64))', '%4')

with open('/home/zby/test202412/PolyBenchC-4.2.1/linear-algebra/kernels/doitgen/doitgen-arm.ll', 'r') as src_file: 
    lines = src_file.readlines() 
    for line in lines:
        if line.find("define dso_local void @kernel_doitgen") >= 0:
            mv_start = True
            dst_file.write(line)
        elif line.find("define dso_local i32 @main") >=0:
            mv_end = True
        elif line.find('attributes #0') >= 0:
            line = line.replace(' noinline','')
            line = line.replace(' optnone','')
        if mv_start==True and mv_end == False:
            if has_mv == False:
                dst_file.write(kernel_func)
                has_mv = True
            else:
                continue
        elif mv_start == False or mv_end == True:
            dst_file.write(line)