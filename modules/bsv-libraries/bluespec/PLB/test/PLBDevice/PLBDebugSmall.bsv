`include "asim/provides/plb_master.bsh"
`include "asim/provides/plb_slave.bsh"
`include "asim/provides/plb_common.bsh"
`include "asim/provides/soft_connections.bsh"

`include "asim/rrr/remote_server_stub_PLBDEBUGRRR.bsh"

import Vector::*;
import Connectable::*;
import ClientServer::*;
import GetPut::*;


module [CONNECTED_MODULE]  mkConnectPLBDebugger#( ServerStub_PLBDEBUGRRR server_stub, PLBMasterDebug plbMasterDebug, PLBSlaveDebug plbSlaveDebug) (Empty);

endmodule

