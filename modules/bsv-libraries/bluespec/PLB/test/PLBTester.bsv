`include "asim/provides/plb_driver.bsh"
`include "asim/provides/plb_device.bsh"
`include "asim/provides/soft_connections.bsh"

module [CONNECTED_MODULE] mkConnectedApplication();
  
  PLB_DRIVER driver <- mkPLBDriver(); 
  PLB_DEVICE device <- mkPLBDevice(driver.ip_clk, driver.ip_rst);

  mkConnection(driver,device);

endmodule