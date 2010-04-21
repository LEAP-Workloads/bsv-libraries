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
   
  rule getSlaveLoadCommands;
    let nullResp <- server_stub.acceptRequest_getSlaveLoadCommands();
    server_stub.sendResponse_getSlaveLoadCommands(plbSlaveDebug.loadCommandCount()); 
  endrule

  rule getSlaveStoreCommands;
    let nullResp <- server_stub.acceptRequest_getSlaveStoreCommands();
    server_stub.sendResponse_getSlaveStoreCommands(plbSlaveDebug.storeCommandCount()); 
  endrule

  rule getSlaveTotalCommands;
    let nullResp <- server_stub.acceptRequest_getSlaveTotalCommands();
    server_stub.sendResponse_getSlaveTotalCommands(plbSlaveDebug.totalCommandCount()); 
  endrule


  rule getSlaveLoadData;
    let nullResp <- server_stub.acceptRequest_getSlaveLoadData();
    server_stub.sendResponse_getSlaveLoadData(plbSlaveDebug.loadDataCount()); 
  endrule

  rule getSlaveStoreData;
    let nullResp <- server_stub.acceptRequest_getSlaveStoreData();
    server_stub.sendResponse_getSlaveStoreData(plbSlaveDebug.storeDataCount()); 
  endrule

  rule getMasterLoadCommands;
    let nullResp <- server_stub.acceptRequest_getMasterLoadCommands();
    server_stub.sendResponse_getMasterLoadCommands(plbMasterDebug.loadCommandTotal()); 
  endrule
  rule getMasterLoadCommandsCompleted;
    let nullResp <- server_stub.acceptRequest_getMasterLoadCommandsCompleted();
    server_stub.sendResponse_getMasterLoadCommandsCompleted(plbMasterDebug.loadCommandCompletedTotal()); 
  endrule

  rule getMasterStoreCommands;
    let nullResp <- server_stub.acceptRequest_getMasterStoreCommands();
    server_stub.sendResponse_getMasterStoreCommands(plbMasterDebug.storeCommandTotal()); 
  endrule

  rule getMasterStoreCommandsCompleted;
    let nullResp <- server_stub.acceptRequest_getMasterStoreCommandsCompleted();
    server_stub.sendResponse_getMasterStoreCommandsCompleted(plbMasterDebug.storeCommandCompletedTotal()); 
  endrule


  rule getMasterLoadData;
    let nullResp <- server_stub.acceptRequest_getMasterLoadData();
    server_stub.sendResponse_getMasterLoadData(plbMasterDebug.loadDataTotal()); 
  endrule

  rule getMasterStoreData;
    let nullResp <- server_stub.acceptRequest_getMasterStoreData();
    server_stub.sendResponse_getMasterStoreData(plbMasterDebug.storeDataTotal()); 
  endrule

  rule getMasterLoadBufferCount;
    let nullResp <- server_stub.acceptRequest_getMasterLoadBufferCount();
    server_stub.sendResponse_getMasterLoadBufferCount(plbMasterDebug.loadBufferCount()); 
  endrule

  rule getMasterStoreBufferCount;
    let nullResp <- server_stub.acceptRequest_getMasterStoreBufferCount();
    server_stub.sendResponse_getMasterStoreBufferCount(plbMasterDebug.storeBufferCount()); 
  endrule

  rule getMasterStatus;
    let nullResp <- server_stub.acceptRequest_getMasterStatus();
    server_stub.sendResponse_getMasterStatus(zeroExtend({pack(plbMasterDebug.requestState()),pack(plbMasterDebug.loadState()),pack(plbMasterDebug.storeState())}),{plbMasterDebug.storeAAcksCount,plbMasterDebug.storeDAcksCount},plbMasterDebug.errorCount); 
  endrule


endmodule

