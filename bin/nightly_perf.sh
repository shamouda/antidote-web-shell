if [ -z "$BENCH_HOME" ]
then
    echo "Error: \$BENCH_HOME is empty, set it with the path of the Benchmarks repo"
    exit
fi

SRC=$(pwd)

#Weite only transactions
$BENCH_HOME/_build/default/bin/basho_bench $BENCH_HOME/examples/antidote_pb.config.wo
python $SRC/parse_perf.py $BENCH_HOME/tests/current 3

#Read only transaction
cd $BENCH_HOME
echo "starting read-only transactions"
$BENCH_HOME/_build/default/bin/basho_bench $BENCH_HOME/examples/antidote_pb.config.ro
python $SRC/parse_perf.py $BENCH_HOME/tests/current 1

