typedef Bit#(32) PLBAddr;
typedef Bit#(5)  PLBLength; // Note Maximum Length is 16, but we'll waste resources for now...

interface PLBMaster;
  interface Put#(BusWord) wordInput;
  interface Get#(BusWord) wordOutput;
  interface Put#(PLBMasterCommand) plbMasterCommandInput;
  interface PLBMasterWires   plbMasterWires;
endinterface
 
typedef struct {
  PLBAddr addr;
  PLBLength length;
} PLBBurst deriving (Bits,Eq);

typedef union tagged
{
  PLBBurst Load;
  PLBBurst Store;
} 
  PLBMasterCommand
    deriving(Bits,Eq);