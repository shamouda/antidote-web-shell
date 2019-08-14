import os
import sys
import statistics
from datetime import date

## Program that parses the output of the Benchmarks repository ##
## Usage: python parse_perf.py <input folder path> <output folder path> <transaction type>

READ_ONLY = 1
READ_WRITE = 2
WRITE_ONLY = 3

today = date.today().strftime("%Y%m%d")

#PWD
dir_path = os.path.dirname(os.path.abspath(__file__))

#input files
in_path = ''
in_summaryfile = ''
in_latecyfile = ''
out_path = os.path.join(dir_path, '../public/perf_data')
out_throughputfile = ''
out_latencyfile = ''


#latencies after 1 minute of execution
latencyrow=7

if len(sys.argv) > 2:
    in_path = sys.argv[1]
    type = int(sys.argv[2])
    in_summaryfile = in_path + '/summary.csv'
    if type == READ_ONLY:
        in_latecyfile = in_path + '/read-only-txn_latencies.csv'
        out_throughputfile = out_path + '/throughput_readonly.csv'
        out_latencyfile = out_path + '/latency_readonly.csv'
        print('Processing read-only results ...')
    elif type == WRITE_ONLY:
        in_latecyfile = in_path + '/update-only-txn_latencies.csv'
        out_throughputfile = out_path + '/throughput_writeonly.csv'
        out_latencyfile = out_path + '/latency_writeonly.csv'
        print('Processing write-only results ...')
    elif type == READ_WRITE:
        in_latecyfile = in_path + '/txn-txn_latencies.csv'
        out_throughputfile = out_path + '/throughput_readwrite.csv'
        out_latencyfile = out_path + '/latency_readwrite.csv'
        print('Processing read-write results ...')
    else:
        print('Error: wrong type value')
        print('Usage: python parse_perf.py <input folder path> <output folder path> <transaction type>')
        sys.exit()
else:
    print('Error: missing parameters')
    print('Usage: python parse_perf.py <input folder path> <output folder path> <transaction type>')
    sys.exit()

#### latency calculations ####
cnt = 1;
_min = 0.0
_median = 0.0
_max = 0.0

with open(in_latecyfile) as in_f:
    for line in in_f:
        if cnt != latencyrow:
            cnt = cnt + 1
            continue
        parts = line.split(',')
        _min = round(float(parts[3].strip()),2)
        _median = round(float(parts[5].strip()),2)
        _max = round(float(parts[9].strip()),2)
        break

print('latency:')
print('%s,%.2f;%.2f;%.2f' % (today, _min, _median, _max))
with open(out_latencyfile, 'a+') as out_f:
    out_f.write('%s,%.2f;%.2f;%.2f\n' % (today, _min, _median, _max))
print('latency saved ...')

#### throughput calculations ####
throughput = []
with open(in_summaryfile) as fp:
    for line in fp:
        parts = line.split(',')
        if parts[0] == 'elapsed':
            continue
        t = float(parts[3].strip())/float(parts[1].strip())
        throughput.append(round(t, 2))
        
_min = min(throughput)
_median = statistics.median(throughput)
_max = max(throughput)
print('throughput:')
print('%s,%.2f;%.2f;%.2f' % (today, _min, _median, _max))
with open(out_throughputfile, 'a+') as out_f:
    out_f.write('%s,%.2f;%.2f;%.2f\n' % (today, _min, _median, _max))

print('throughput saved ...')
print('Processing completed ...')
