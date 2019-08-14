date

if [ -z "$BENCH_HOME" ]
then
    echo "Error: \$BENCH_HOME is empty, set it with the path of the Benchmarks repo"
    exit
fi

#Write only transactions
echo "starting write-only transactions"
$BENCH_HOME/_build/default/bin/basho_bench antidote_pb.config.wo
python parse_perf.py tests/current 3

#Read only transaction
echo "starting read-only transactions"
$BENCH_HOME/_build/default/bin/basho_bench antidote_pb.config.ro
python parse_perf.py tests/current 1

