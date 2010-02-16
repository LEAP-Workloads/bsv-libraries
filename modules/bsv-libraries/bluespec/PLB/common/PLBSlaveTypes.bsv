import ClientServer::*;

typedef enum {
  PLBRead,
  PLBWrite
} PLBCommand deriving (Bits,Eq);

typedef struct {
  Bit#(address_width)  addr;
  Bit#(data_width)     data;
  PLBCommand        command;
  Bit#(TDiv#(data_width,8)) be;
} PLBRequest#(numeric type address_width, 
              numeric type data_width) deriving (Bits,Eq);


interface PLBSlave#(numeric type address_width, numeric type data_width);
  interface Client#(PLBRequest#(address_width, data_width),Bit#(data_width)) busClient;
  interface PLBSlaveWires#(address_width,data_width)   plbSlaveWires;
  interface ReadOnly#(Bit#(32)) loadCommandCount;
  interface ReadOnly#(Bit#(32)) storeCommandCount;
  interface ReadOnly#(Bit#(32)) loadDataCount;
  interface ReadOnly#(Bit#(32)) storeDataCount;
endinterface
 
