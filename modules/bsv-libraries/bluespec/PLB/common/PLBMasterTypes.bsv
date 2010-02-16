`include "asim/provides/librl_bsv_base.bsh"

interface PLBMaster;
  interface BURST_MEMORY_IFC#(PLBAddr,BusWord,PLBMaxBurst) burstIfc;
  interface PLBMasterWires   plbMasterWires;
  // Debug interface 
  interface ReadOnly#(Bit#(32)) loadCommandTotal;
  interface ReadOnly#(Bit#(32)) storeCommandTotal;
  interface ReadOnly#(Bit#(32)) loadDataTotal;
  interface ReadOnly#(Bit#(32)) storeDataTotal;
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