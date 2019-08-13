if [ -z "$BENCH_HOME" ]
then
    echo "Error: \$BENCH_HOME is empty, set it with the path of the Benchmarks repo"
    exit
fi

home=$(pwd)

#Weite only transactions
cd $BENCH_HOME
./_build/default/bin/basho_bench examples/antidote_pb.config.wo
cd $home
python parse_perf.py $BENCH_HOME/tests/current ../public/perf_data 3

#Read only transaction
cd $BENCH_HOME
echo "starting read-only transactions"
./_build/default/bin/basho_bench examples/antidote_pb.config.ro
cd $home
python parse_perf.py $BENCH_HOME/tests/current ../public/perf_data 1

