`include "asim/provides/plb_master.bsh"
`include "asim/provides/plb_slave.bsh"
`include "asim/provides/plb_common.bsh"
`include "asim/provides/soft_connections.bsh"

import Vector::*;
import Connectable::*;
import ClientServer::*;
import GetPut::*;


module [CONNECTED_MODULE]  mkConnectPLBDebugger#(PLBMasterDebug plbMasterDebug, PLBSlaveDebug plbSlaveDebug) (Empty);

endmodule

