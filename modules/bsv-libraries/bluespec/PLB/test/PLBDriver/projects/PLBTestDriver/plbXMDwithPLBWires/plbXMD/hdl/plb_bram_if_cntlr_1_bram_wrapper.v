//-----------------------------------------------------------------------------
// plb_bram_if_cntlr_1_bram_wrapper.v
//-----------------------------------------------------------------------------

module plb_bram_if_cntlr_1_bram_wrapper
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
  input [0:7] BRAM_WEN_A;
  input [0:31] BRAM_Addr_A;
  output [0:63] BRAM_Din_A;
  input [0:63] BRAM_Dout_A;
  input BRAM_Rst_B;
  input BRAM_Clk_B;
  input BRAM_EN_B;
  input [0:7] BRAM_WEN_B;
  input [0:31] BRAM_Addr_B;
  output [0:63] BRAM_Din_B;
  input [0:63] BRAM_Dout_B;

  plb_bram_if_cntlr_1_bram_elaborate
    #(
      .C_MEMSIZE ( 'h4000 ),
      .C_PORT_DWIDTH ( 64 ),
      .C_PORT_AWIDTH ( 32 ),
      .C_NUM_WE ( 8 ),
      .C_FAMILY ( "virtex2p" )
    )
    plb_bram_if_cntlr_1_bram (
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

// synthesis attribute x_core_info of plb_bram_if_cntlr_1_bram_wrapper is plb_bram_if_cntlr_1_bram_elaborate_v1_00_a;
// synthesis attribute keep_hierarchy of plb_bram_if_cntlr_1_bram_wrapper is yes;

