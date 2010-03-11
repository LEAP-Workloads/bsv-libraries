
interface PLB_DEVICE;
  interface PLBMasterWires plbMasterWires;
  interface PLBSlaveWires#(32,64) plbSlaveWires;  
  method Bit#(1) outIP2Bus_IntrEvent();
endinterface
