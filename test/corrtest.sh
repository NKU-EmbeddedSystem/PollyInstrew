PROG=""
NUMTHREAD=""


while getopts "p:n:" opt; do
    case $opt in
        p) PROG="$OPTARG" ;; 
        n) NUMTHREAD="$OPTARG" ;;
        *) echo "invalid arg" ;;
    esac
done

if [ $PROG = "blackscholes" ]; then
	echo "=====testing parsec.blackscholes====="
	INPUT=parsec-benchmark/pkgs/apps/blackscholes/run/in_64K.txt 
	OUTPUT=parsec-benchmark/pkgs/apps/blackscholes/run/prices.txt
	tar -xvf $PWD/parsec-benchmark/pkgs/apps/blackscholes/inputs/input_simlarge.tar -C $PWD/parsec-benchmark/pkgs/apps/blackscholes/run
	qemu-x86_64 $PWD/parsec-benchmark/pkgs/apps/blackscholes/inst/amd64-linux.gcc/bin/blackscholes $NUMTHREAD $PWD/$INPUT $PWD/$OUTPUT
elif [ $PROG = "radix" ]; then
        qemu-x86_64 $PWD/parsec-benchmark/ext/splash2x/kernels/radix/inst/amd64-linux.gcc/bin/radix -p$NUMTHREAD -r4096 -n67108864 -m2147483647	-t
elif [ $PROG = "lu_ncb" ]; then
	qemu-x86_64 $PWD/parsec-benchmark/ext/splash2x/kernels/lu_ncb/inst/amd64-linux.gcc/bin/lu_ncb -p$NUMTHREAD -n2048 -b16 -t
else
	echo "unkown program " $PROG
fi


