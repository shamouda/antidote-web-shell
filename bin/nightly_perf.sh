if [ -z "$BENCH_HOME" ]
then
    echo "Error: \$BENCH_HOME is empty, set it with the path of the Benchmarks repo"
    exit
fi

SRC=$(pwd)

#Write only transactions
cd $BENCH_HOME
echo "starting write-only transactions"
$BENCH_HOME/_build/default/bin/basho_bench $BENCH_HOME/examples/antidote_pb.config.wo
if [ ! -f $BENCH_HOME/tests/current ]; then
	echo "WARNING: Benchmarking output folder does not exist"
fi
python $SRC/parse_perf.py $BENCH_HOME/tests/current 3

#Read only transaction
cd $BENCH_HOME
echo "starting read-only transactions"
$BENCH_HOME/_build/default/bin/basho_bench $BENCH_HOME/examples/antidote_pb.config.ro
if [ ! -f $BENCH_HOME/tests/current ]; then
	echo "WARNING: Benchmarking output folder does not exist"
fi
python $SRC/parse_perf.py $BENCH_HOME/tests/current 1

