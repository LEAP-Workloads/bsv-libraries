`include "asim/provides/plb_driver.bsh"
`include "asim/provides/plb_device.bsh"
`include "asim/provides/plb_common.bsh"

import Connectable::*;

instance Connectable#(PLB_DRIVER,PLB_DEVICE);
  module mkConnection#(PLB_DRIVER driver, PLB_DEVICE device) ();
    (* no_implicit_conditions *)
    rule driveSeperate;
      device.plbMasterWires.mBusy(driver.outPLB_MBusy());
      device.plbMasterWires.mErr(driver.outPLB_MErr());
    endrule

    (* no_implicit_conditions *)
    rule driveWiresDevice;
      device.plbSlaveWires.sABus(driver.outBus2IP_Addr());
      device.plbSlaveWires.sDataIn(driver.outBus2IP_Data());
      device.plbSlaveWires.sBE(driver.outBus2IP_BE);
      device.plbSlaveWires.sCS(driver.outBus2IP_CS);
      device.plbSlaveWires.sRdCE(driver.outBus2IP_RdCE);
      device.plbSlaveWires.sWrCE(driver.outBus2IP_WrCE);
      device.plbSlaveWires.sRdReq(driver.outBus2IP_RdReq);
      device.plbSlaveWires.sWrReq(driver.outBus2IP_WrReq);
      device.plbMasterWires.mAddrAck(driver.outPLB_MAddrAck());
      device.plbMasterWires.mSSize(driver.outPLB_MSSize());
      device.plbMasterWires.mRearbitrate(driver.outPLB_MRearbitrate());
      device.plbMasterWires.mWrDAck(driver.outPLB_MWrDAck());
      device.plbMasterWires.mRdDBus(driver.outPLB_MRdDBus());
      device.plbMasterWires.mRdWdAddr(driver.outPLB_MRdWdAddr());
      device.plbMasterWires.mRdDAck(driver.outPLB_MRdDAck());
      device.plbMasterWires.mRdBTerm(driver.outPLB_MRdBTerm());
      device.plbMasterWires.mWrBTerm(driver.outPLB_MWrBTerm());
    endrule

    (* no_implicit_conditions *)
    rule driveWiresDriver;
      driver.inIP2Bus_IntrEvent(0);
      driver.inIP2Bus_Data(device.plbSlaveWires.sDataOut());
      driver.inIP2Bus_Retry(device.plbSlaveWires.sRetry());
      driver.inIP2Bus_Error(device.plbSlaveWires.sError());
      driver.inIP2Bus_TinSup(device.plbSlaveWires.sToutSup());
      driver.inIP2Bus_RdAck(device.plbSlaveWires.sRdAck());
      driver.inIP2Bus_WrAck(device.plbSlaveWires.sWrAck());
      driver.inM_request(device.plbMasterWires.mRequest());
      driver.inM_priority(device.plbMasterWires.mPriority());
      driver.inM_busLock(device.plbMasterWires.mBusLock());
      driver.inM_RNW(device.plbMasterWires.mRNW());
      driver.inM_BE(device.plbMasterWires.mBE());
      driver.inM_MSize(device.plbMasterWires.mMSize());
      driver.inM_size(device.plbMasterWires.mSize());
      driver.inM_type(device.plbMasterWires.mType());
      driver.inM_compress(device.plbMasterWires.mCompress());
      driver.inM_guarded(device.plbMasterWires.mGuarded());
      driver.inM_ordered(device.plbMasterWires.mOrdered());
      driver.inM_lockErr(device.plbMasterWires.mLockErr());
      driver.inM_abort(device.plbMasterWires.mAbort());
      driver.inM_ABus(device.plbMasterWires.mABus());
      driver.inM_wrDBus(device.plbMasterWires.mWrDBus());
      driver.inM_wrBurst(device.plbMasterWires.mWrBurst());
      driver.inM_rdBurst(device.plbMasterWires.mRdBurst());
    endrule

  endmodule
endinstance
