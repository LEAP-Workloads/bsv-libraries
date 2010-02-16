

import Connectable::*;

interface PLB_DRIVER;
  
endinterface


module mkPLBDRIVER#(Clock rawClock, Reset rawReset) (GORDON_FTL_DEVICE);
  
  GORDON_FTL_PRIMITIVE ftl <- mkGordonFTLImport(clocked_by rawClock, reset_by rawReset);

  interface GORDON_FTL_DRIVER driver;

     // Wires for hookout up the bus-based controller
     // hook the wires in reverse, as the names have already changed
     method outBus2IP_Addr = ftl.outBus2IP_Addr;
     method outBus2IP_Data = ftl.outBus2IP_Data;
     method outBus2IP_BE = ftl.outBus2IP_BE;
     method outBus2IP_CS = ftl.outBus2IP_CS;
     method outBus2IP_RdCE = ftl.outBus2IP_RdCE;
     method outBus2IP_WrCE = ftl.outBus2IP_WrCE;
     method outBus2IP_RdReq = ftl.outBus2IP_RdReq;
     method outBus2IP_WrReq = ftl.outBus2IP_WrReq;
     method inIP2Bus_IntrEvent = ftl.inIP2Bus_IntrEvent;
     method inIP2Bus_Data = ftl.inIP2Bus_Data;
     method  inIP2Bus_Retry = ftl.inIP2Bus_Retry;
     method  inIP2Bus_Error = ftl.inIP2Bus_Error;
     method  inIP2Bus_TinSup = ftl.inIP2Bus_TinSup;
     method  inIP2Bus_RdAck = ftl.inIP2Bus_RdAck;
     method  inIP2Bus_WrAck = ftl.inIP2Bus_WrAck;

     method outPLB_MAddrAck = ftl.outPLB_MAddrAck;
     method outPLB_MSSize = ftl.outPLB_MSSize;
     method outPLB_MRearbitrate = ftl.outPLB_MRearbitrate;
     method outPLB_MBusy = ftl.outPLB_MBusy;
     method outPLB_MErr = ftl.outPLB_MErr;
     method outPLB_MWrDAck = ftl.outPLB_MWrDAck;
     method outPLB_MRdDBus = ftl.outPLB_MRdDBus;
     method outPLB_MRdWdAddr = ftl.outPLB_MRdWdAddr;
     method outPLB_MRdDAck = ftl.outPLB_MRdDAck;
     method outPLB_MRdBTerm = ftl.outPLB_MRdBTerm;
     method outPLB_MWrBTerm = ftl.outPLB_MWrBTerm;

     method  inM_request = ftl.inM_request;
     method  inM_priority = ftl.inM_priority;
     method  inM_busLock = ftl.inM_busLock;
     method  inM_RNW = ftl.inM_RNW;
     method  inM_BE = ftl.inM_BE;
     method  inM_MSize = ftl.inM_MSize;
     method  inM_size = ftl.inM_size;
     method  inM_type = ftl.inM_type;
     method  inM_compress = ftl.inM_compress;
     method  inM_guarded = ftl.inM_guarded;
     method  inM_ordered = ftl.inM_ordered;
     method  inM_lockErr = ftl.inM_lockErr;
     method  inM_abort = ftl.inM_abort;
     method  inM_ABus = ftl.inM_ABus;
     method  inM_wrDBus = ftl.inM_wrDBus;
     method  inM_wrBurst = ftl.inM_wrBurst;
     method  inM_rdBurst = ftl.inM_rdBurst;

     // Output Clock
    interface Clock ip_clk = ftl.ip_clk;
    interface Reset ip_rst = ftl.ip_rst;
  endinterface
  

  interface GORDON_FTL_WIRES wires;

     // Wires needed to drive ethernet, etc.
     // RGMII
     method outMAC_slew1 = ftl.outMAC_slew1;
     method outMAC_slew2 = ftl.outMAC_slew2;
     method outMAC_PHY_rst_n = ftl.outMAC_PHY_rst_n ;
     method inMAC_PHY_crs = ftl.inMAC_PHY_crs;
     method inMAC_PHY_col = ftl.inMAC_PHY_col;
     method outMAC_PHY_tx_data = ftl.outMAC_PHY_tx_data;
     method outMAC_PHY_tx_en = ftl.outMAC_PHY_tx_en;
     method outMAC_PHY_tx_er = ftl.outMAC_PHY_tx_er;
     method inMAC_PHY_tx_clk = ftl.inMAC_PHY_tx_clk;
     method inMAC_PHY_rx_er = ftl.inMAC_PHY_rx_er;
     method inMAC_PHY_rx_clk = ftl.inMAC_PHY_rx_clk;
     method inMAC_PHY_dv = ftl.inMAC_PHY_dv;
     method inMAC_PHY_rx_data = ftl.inMAC_PHY_rx_data;
     interface inoutMAC_PHY_Mii_clk = ftl.inoutMAC_PHY_Mii_clk;
     interface inoutMAC_PHY_Mii_data = ftl.inoutMAC_PHY_Mii_data;

     // Compact flash
     method inSysACE_CLK = ftl.inSysACE_CLK;     
     method outSysACE_MPA = ftl.outSysACE_MPA;     
     interface inoutSysACE_MPD = ftl.inoutSysACE_MPD;     
     method outSysACE_CEN = ftl.outSysACE_CEN;     
     method outSysACE_OEN = ftl.outSysACE_OEN;     
     method outSysACE_WEN = ftl.outSysACE_WEN;     
     method inSysACE_MPIRQ = ftl.inSysACE_MPIRQ;  

     // DDR

     method outDDRAddr = ftl.outDDRAddr;
     method outDDRBankAddr = ftl.outDDRBankAddr;
     method outDDRCASn = ftl.outDDRCASn;
     method outDDRCKE = ftl.outDDRCKE;
     method outDDRCSn = ftl.outDDRCSn;
     method outDDRRASn = ftl.outDDRRASn;
     method outDDRWEn = ftl.outDDRWEn;
     method outDDRDM = ftl.outDDRDM;
     interface inoutDDRDQS = ftl.inoutDDRDQS;
     interface inoutDDRDQ = ftl.inoutDDRDQ;
     method outDDRClk = ftl.outDDRClk;
     method outDDRClkn = ftl.outDDRClkn;
     method outDDRCLK_FB_OUT = ftl.outDDRCLK_FB_OUT;
     method outDDRCLK_FB = ftl.outDDRCLK_FB;


  endinterface  

endmodule