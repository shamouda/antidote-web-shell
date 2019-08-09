const THR_RO_FILE = '/perf_data/throughput_readonly.csv';
const THR_WO_FILE = '/perf_data/throughput_writeonly.csv';
const THR_RW_FILE = '/perf_data/throughput_readwrite.csv';

const LATE_RO_FILE = '/perf_data/latency_readonly.csv';
const LATE_WO_FILE = '/perf_data/latency_writeonly.csv';
const LATE_RW_FILE = '/perf_data/latency_readwrite.csv';

g1 = new Dygraph(document.getElementById("throughput-ro"), 
		THR_RO_FILE, 
		{customBars: true, ylabel: 'Op/sec'} );

g2 = new Dygraph(document.getElementById("latency-ro"), 
		LATE_RO_FILE, 
		{customBars: true, ylabel: 'Latency(ms)'} );

g3 = new Dygraph(document.getElementById("throughput-wo"), 
		THR_WO_FILE, 
		{customBars: true, ylabel: 'Op/sec'} );

g4 = new Dygraph(document.getElementById("latency-wo"), 
		LATE_WO_FILE, 
		{customBars: true, ylabel: 'Latency(ms)'} );

g5 = new Dygraph(document.getElementById("throughput-rw"), 
		THR_RW_FILE, 
		{customBars: true, ylabel: 'Op/sec'} );

g6 = new Dygraph(document.getElementById("latency-rw"), 
		LATE_RW_FILE, 
		{customBars: true, ylabel: 'Latency(ms)'} );
