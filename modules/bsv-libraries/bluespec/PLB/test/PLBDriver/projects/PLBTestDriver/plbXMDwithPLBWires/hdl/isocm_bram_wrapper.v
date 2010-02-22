//-----------------------------------------------------------------------------
// isocm_bram_wrapper.v
//-----------------------------------------------------------------------------

module isocm_bram_wrapper
  (
    BRAM_Rst_A,
    BRAM_Clk_A,
    BRAM_EN_A,
    BRAM_WEN_A,
    BRAM_Addr_A,
    BRAM_Din_A,
    BRAM_Dout_A,
    BRAM_Rst_B,
    BRAM_Clk_B,
    BRAM_EN_B,
    BRAM_WEN_B,
    BRAM_Addr_B,
    BRAM_Din_B,
    BRAM_Dout_B
  );
  input BRAM_Rst_A;
  input BRAM_Clk_A;
  input BRAM_EN_A;
  input [0:1] BRAM_WEN_A;
  input [0:31] BRAM_Addr_A;
  output [0:63] BRAM_Din_A;
  input [0:63] BRAM_Dout_A;
  input BRAM_Rst_B;
  input BRAM_Clk_B;
  input BRAM_EN_B;
  input [0:1] BRAM_WEN_B;
  input [0:31] BRAM_Addr_B;
  output [0:63] BRAM_Din_B;
  input [0:63] BRAM_Dout_B;

  isocm_bram_elaborate
    #(
      .C_MEMSIZE ( 'h4000 ),
      .C_PORT_DWIDTH ( 64 ),
      .C_PORT_AWIDTH ( 32 ),
      .C_NUM_WE ( 2 ),
      .C_FAMILY ( "virtex2p" )
    )
    isocm_bram (
      .BRAM_Rst_A ( BRAM_Rst_A ),
      .BRAM_Clk_A ( BRAM_Clk_A ),
      .BRAM_EN_A ( BRAM_EN_A ),
      .BRAM_WEN_A ( BRAM_WEN_A ),
      .BRAM_Addr_A ( BRAM_Addr_A ),
      .BRAM_Din_A ( BRAM_Din_A ),
      .BRAM_Dout_A ( BRAM_Dout_A ),
      .BRAM_Rst_B ( BRAM_Rst_B ),
      .BRAM_Clk_B ( BRAM_Clk_B ),
      .BRAM_EN_B ( BRAM_EN_B ),
      .BRAM_WEN_B ( BRAM_WEN_B ),
      .BRAM_Addr_B ( BRAM_Addr_B ),
      .BRAM_Din_B ( BRAM_Din_B ),
      .BRAM_Dout_B ( BRAM_Dout_B )
    );

endmodule

// synthesis attribute x_core_info of isocm_bram_wrapper is isocm_bram_elaborate_v1_00_a;
// synthesis attribute keep_hierarchy of isocm_bram_wrapper is yes;

