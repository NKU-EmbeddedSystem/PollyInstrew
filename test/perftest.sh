# single-thread multi-threads

CHOICE=""


while getopts "c:" opt; do
    case $opt in
        c) CHOICE="$OPTARG" ;; 
        *) echo "invalid arg" ;;
    esac
done

export OMP_NUM_THREADS=48 

cd $PWD/PollyInstrew/generate
meson build
ninja -C build
cd ../..

cd PolyBenchC-4.2.1
clang -I ./utilities -I ./linear-algebra/kernels/doitgen  linear-algebra/kernels/doitgen/doitgen.c -static -S -emit-llvm -O0 -o linear-algebra/kernels/doitgen/doitgen-arm.ll
cd ..

if [ $CHOICE = "single" ]; then
    $PWD/PollyInstrew/build/server/instrew $PWD/PolyBenchC-4.2.1/doitgen
    python3 $PWD/PollyInstrew/generate/preprocess.py
    cd PolyBenchC-4.2.1
    clang -I ./utilities -I ./linear-algebra/kernels/doitgen  utilities/polybench.c  /home/zby/test202412/PollyInstrew/generate/PollyInstrew_doitgen.ll -o doitgen_single_thread
    cd ..
    time PolyBenchC-4.2.1/doitgen_single_thread
elif [ $CHOICE = "multi" ]; then
    $PWD/PollyInstrew/build/server/instrew $PWD/PolyBenchC-4.2.1/doitgen
    python3 $PWD/PollyInstrew/generate/preprocess.py
    $PWD/PollyInstrew/generate/build/generate
    cd PolyBenchC-4.2.1
    clang -I ./utilities -I ./linear-algebra/kernels/doitgen  utilities/polybench.c  /home/zby/test202412/PollyInstrew/generate/PollyInstrew_doitgen_multi.ll -lgomp -o doitgen_multi_threads
    cd ..
    time PolyBenchC-4.2.1/doitgen_multi_threads
else
	echo "unkown args:" $CHOICE
fi
