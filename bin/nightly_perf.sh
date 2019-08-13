if [ -z "$BENCH_HOME" ]
then
      echo "Error: \$BENCH_HOME is empty, set it with the path of the Benchmarks repo"
      exit
fi

cd $BENCH_HOME

#Read only transaction
./_build/default/bin/basho_bench examples/antidote_pb.config.ro
python parse_perf.py 
python parse_perf.py $BENCH_HOME/tests/current ../public/perf_data 1

#Weite only transactions
./_build/default/bin/basho_bench examples/antidote_pb.config.rw
python parse_perf.py 
python parse_perf.py $BENCH_HOME/tests/current ../public/perf_data 2

