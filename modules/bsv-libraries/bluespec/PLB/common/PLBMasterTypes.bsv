`include "asim/provides/librl_bsv_base.bsh"

interface PLBMaster;
  interface BURST_MEMORY_IFC#(PLBAddr,BusWord,PLBMaxBurst) burstIfc;
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