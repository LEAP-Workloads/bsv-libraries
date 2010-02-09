import ClientServer::*;

import I2C::*;

interface I2CSlaveWires;
  (* always_ready, always_enabled *)
  method Inout(Bit#(1)) slaveClock;     
  (* always_ready, always_enabled *)
  method Inout(Bit#(1)) slaveData;     
endinterface;

interface I2CSlave;
  interface I2CSlaveWires i2cSlaveWires;
  // Need a server interface.  
  interface Client#(AvalonRequest#(I2C,data_width), Bit#(data_width)) busClient;
endinterface

typedef enum {
   Idle;
   

}  SlaveState;
 
module mkI2CSlave (I2CSlave);
  
  interface I2CSlaveWires;  
     method Inout(Bit#(1)) slaveClock;     
  (* always_ready, always_enabled *)
  method Inout(Bit#(1)) slaveData;     
  endinterface 

  interface Client busClient;

  endinterface
endmodule

