typedef 32 PLBAddrSize;
typedef Bit#(PLBAddrSize) PLBAddr;
typedef 2 WordsPerBeat;  // PLB bandwidth
typedef 16 BurstSize;  // number of beats per burst
typedef 16 BeatsPerBurst;
typedef Bit#(64) BusWord;
typedef 8 BytesPerBusWord;
typedef TMul#(WordsPerBeat,BeatsPerBurst) WordsPerBurst;

typedef Bit#(5)  PLBLength; // Note Maximum Length is 16, but we'll waste resources for now...
typedef 16 PLBMaxBurst;

typedef Bit#(TSub#(PLBAddrSize, TLog#(TDiv#(SizeOf#(BusWord),8)))) PLBBusWordAddress;
