`include "asim/provides/librl_bsv_base.bsh"

interface PLBMaster;
  interface BURST_MEMORY_IFC#(PLBAddr,BusWord,PLBMaxBurst) burstIfc;
  interface PLBMasterWires   plbMasterWires;
  // Debug interface 
  interface ReadOnly#(Bit#(32)) loadCommandTotal;
  interface ReadOnly#(Bit#(32)) storeCommandTotal;
  interface ReadOnly#(Bit#(32)) loadCommandCompletedTotal;
  interface ReadOnly#(Bit#(32)) storeCommandCompletedTotal;
  interface ReadOnly#(Bit#(32)) loadDataTotal;
  interface ReadOnly#(Bit#(32)) storeDataTotal;  
  interface ReadOnly#(Bit#(16)) storeAAcksCount;
  interface ReadOnly#(Bit#(16)) storeDAcksCount;
  interface ReadOnly#(Bit#(32)) storeBufferCount;
  interface ReadOnly#(Bit#(32)) loadBufferCount;
  interface ReadOnly#(Bit#(32)) errorCount;
  interface ReadOnly#(StateRequest)  requestState;
  interface ReadOnly#(StateTransfer) loadState;
  interface ReadOnly#(StateTransfer) storeState;
  
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

typedef enum {   
  Idle = 0,
  Data = 1,
  WaitForBusy = 2
} StateTransfer 
    deriving(Bits, Eq);
  
typedef enum {   
  Idle = 0,
  RequestingLoad = 1,
  RequestingStore = 2
} StateRequest 
    deriving(Bits, Eq);

typedef TMul#(4,BeatsPerBurst) OutputBufferSize;
