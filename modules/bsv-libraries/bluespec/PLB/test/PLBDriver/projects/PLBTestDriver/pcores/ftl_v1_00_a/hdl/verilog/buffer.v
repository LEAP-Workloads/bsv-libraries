


module buffer(
	clk,
	plbin,
	plbwe,
	plbwrite,
	plbout,
	plbaddr,
	
	bus0in,
	bus0we,
	bus0out,
	bus0addr,
	
	bus1in,
	bus1we,
	bus1out,
	bus1addr,
	
	bus2in,
	bus2we,
	bus2out,
	bus2addr,
	
	bus3in,
	bus3we,
	bus3out,
	bus3addr);
	
input clk;
input [0:63] plbin;
input [0:7] plbwe;
input plbwrite;
output [0:63] plbout;
input [0:15] plbaddr;

input [0:7] bus0in,bus1in,bus2in,bus3in;
input bus0we,bus1we,bus2we,bus3we;
output [0:7] bus0out,bus1out,bus2out,bus3out;
input [0:13] bus0addr,bus1addr,bus2addr,bus3addr;

wire [0:7] outa00,outa01,outa02,outa03,outa04,outa05,outa06,outa07;
wire [0:7] outb00,outb01,outb02,outb03,outb04,outb05,outb06,outb07;
wire [0:7] outa10,outa11,outa12,outa13,outa14,outa15,outa16,outa17;
wire [0:7] outb10,outb11,outb12,outb13,outb14,outb15,outb16,outb17;
wire [0:7] outa20,outa21,outa22,outa23,outa24,outa25,outa26,outa27;
wire [0:7] outb20,outb21,outb22,outb23,outb24,outb25,outb26,outb27;
wire [0:7] outa30,outa31,outa32,outa33,outa34,outa35,outa36,outa37;
wire [0:7] outb30,outb31,outb32,outb33,outb34,outb35,outb36,outb37;

reg [0:7] bus0sel, bus1sel,bus2sel,bus3sel;
reg [0:63] plbsel;

assign plbout = plbsel;
assign bus0out = bus0sel;
assign bus1out = bus1sel;
assign bus2out = bus2sel;
assign bus3out = bus3sel;

always @(*) begin
	case (bus0addr[11:13])
	0: bus0sel <= outb00;
	1: bus0sel <= outb01;
	2: bus0sel <= outb02;
	3: bus0sel <= outb03;
	4: bus0sel <= outb04;
	5: bus0sel <= outb05;
	6: bus0sel <= outb06;
	7: bus0sel <= outb07;
	endcase
	
	case (bus1addr[11:13])
	0: bus1sel <= outb10;
	1: bus1sel <= outb11;
	2: bus1sel <= outb12;
	3: bus1sel <= outb13;
	4: bus1sel <= outb14;
	5: bus1sel <= outb15;
	6: bus1sel <= outb16;
	7: bus1sel <= outb17;	
	endcase

	case (bus2addr[11:13])
	0: bus2sel <= outb20;
	1: bus2sel <= outb21;
	2: bus2sel <= outb22;
	3: bus2sel <= outb23;
	4: bus2sel <= outb24;
	5: bus2sel <= outb25;
	6: bus2sel <= outb26;
	7: bus2sel <= outb27;	
	endcase
	
	case (bus3addr[11:13])
	0: bus3sel <= outb30;
	1: bus3sel <= outb31;
	2: bus3sel <= outb32;
	3: bus3sel <= outb33;
	4: bus3sel <= outb34;
	5: bus3sel <= outb35;
	6: bus3sel <= outb36;
	7: bus3sel <= outb37;
	endcase

	case (plbaddr[0:1])
	0: plbsel <= {outa00, outa01, outa02, outa03, outa04, outa05, outa06, outa07 };
	1: plbsel <= {outa10, outa11, outa12, outa13, outa14, outa15, outa16, outa17 };
	2: plbsel <= {outa20, outa21, outa22, outa23, outa24, outa25, outa26, outa27 };
	3: plbsel <= {outa30, outa31, outa32, outa33, outa34, outa35, outa36, outa37 };
	endcase


end


RAMB16_S9_S9 bram00 (
		.DOA (outa00), 
		.DOB (outb00), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus0addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[0:7]), 
		.DIB (bus0in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==0) && plbwe[0] && plbwrite), 
		.WEB ((bus0addr[11:13]==0) && bus0we));
RAMB16_S9_S9 bram01 (
		.DOA (outa01), 
		.DOB (outb01), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus0addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[8:15]), 
		.DIB (bus0in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==0) && plbwe[1] && plbwrite), 
		.WEB ((bus0addr[11:13]==1) && bus0we));
RAMB16_S9_S9 bram02 (
		.DOA (outa02), 
		.DOB (outb02), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus0addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[16:23]), 
		.DIB (bus0in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==0) && plbwe[2] && plbwrite), 
		.WEB ((bus0addr[11:13]==2) && bus0we));
RAMB16_S9_S9 bram03 (
		.DOA (outa03), 
		.DOB (outb03), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus0addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[24:31]), 
		.DIB (bus0in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==0) && plbwe[3] && plbwrite), 
		.WEB ((bus0addr[11:13]==3) && bus0we));
RAMB16_S9_S9 bram04 (
		.DOA (outa04), 
		.DOB (outb04), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus0addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[32:39]), 
		.DIB (bus0in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==0) && plbwe[4] && plbwrite), 
		.WEB ((bus0addr[11:13]==4) && bus0we));
RAMB16_S9_S9 bram05 (
		.DOA (outa05), 
		.DOB (outb05), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus0addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[40:47]), 
		.DIB (bus0in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==0) && plbwe[5] && plbwrite), 
		.WEB ((bus0addr[11:13]==5) && bus0we));
RAMB16_S9_S9 bram06 (
		.DOA (outa06), 
		.DOB (outb06), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus0addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[48:55]), 
		.DIB (bus0in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==0) && plbwe[6] && plbwrite), 
		.WEB ((bus0addr[11:13]==6) && bus0we));
RAMB16_S9_S9 bram07 (
		.DOA (outa07), 
		.DOB (outb07), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus0addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[56:63]), 
		.DIB (bus0in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==0) && plbwe[7] && plbwrite), 
		.WEB ((bus0addr[11:13]==7) && bus0we));




//BUS1
RAMB16_S9_S9 bram10 (
		.DOA (outa10), 
		.DOB (outb10), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus1addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[0:7]), 
		.DIB (bus1in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==1) && plbwe[0] && plbwrite), 
		.WEB ((bus1addr[11:13]==0) && bus1we));
RAMB16_S9_S9 bram11 (
		.DOA (outa11), 
		.DOB (outb11), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus1addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[8:15]), 
		.DIB (bus1in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==1) && plbwe[1] && plbwrite), 
		.WEB ((bus1addr[11:13]==1) && bus1we));
RAMB16_S9_S9 bram12 (
		.DOA (outa12), 
		.DOB (outb12), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus1addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[16:23]), 
		.DIB (bus1in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==1) && plbwe[2] && plbwrite), 
		.WEB ((bus1addr[11:13]==2) && bus1we));
RAMB16_S9_S9 bram13 (
		.DOA (outa13), 
		.DOB (outb13), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus1addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[24:31]), 
		.DIB (bus1in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==1) && plbwe[3] && plbwrite), 
		.WEB ((bus1addr[11:13]==3) && bus1we));
RAMB16_S9_S9 bram14 (
		.DOA (outa14), 
		.DOB (outb14), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus1addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[32:39]), 
		.DIB (bus1in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==1) && plbwe[4] && plbwrite), 
		.WEB ((bus1addr[11:13]==4) && bus1we));
RAMB16_S9_S9 bram15 (
		.DOA (outa15), 
		.DOB (outb15), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus1addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[40:47]), 
		.DIB (bus1in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==1) && plbwe[5] && plbwrite), 
		.WEB ((bus1addr[11:13]==5) && bus1we));
RAMB16_S9_S9 bram16 (
		.DOA (outa16), 
		.DOB (outb16), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus1addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[48:55]), 
		.DIB (bus1in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==1) && plbwe[6] && plbwrite), 
		.WEB ((bus1addr[11:13]==6) && bus1we));
RAMB16_S9_S9 bram17 (
		.DOA (outa17), 
		.DOB (outb17), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus1addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[56:63]), 
		.DIB (bus1in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==1) && plbwe[7] && plbwrite), 
		.WEB ((bus1addr[11:13]==7) && bus1we));





//BUS2
RAMB16_S9_S9 bram20 (
		.DOA (outa20), 
		.DOB (outb20), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus2addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[0:7]), 
		.DIB (bus2in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==2) && plbwe[0] && plbwrite), 
		.WEB ((bus2addr[11:13]==0) && bus2we));
RAMB16_S9_S9 bram21 (
		.DOA (outa21), 
		.DOB (outb21), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus2addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[8:15]), 
		.DIB (bus2in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==2) && plbwe[1] && plbwrite), 
		.WEB ((bus2addr[11:13]==1) && bus2we));
RAMB16_S9_S9 bram22 (
		.DOA (outa22), 
		.DOB (outb22), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus2addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[16:23]), 
		.DIB (bus2in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==2) && plbwe[2] && plbwrite), 
		.WEB ((bus2addr[11:13]==2) && bus2we));
RAMB16_S9_S9 bram23 (
		.DOA (outa23), 
		.DOB (outb23), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus2addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[24:31]), 
		.DIB (bus2in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==2) && plbwe[3] && plbwrite), 
		.WEB ((bus2addr[11:13]==3) && bus2we));
RAMB16_S9_S9 bram24 (
		.DOA (outa24), 
		.DOB (outb24), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus2addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[32:39]), 
		.DIB (bus2in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==2) && plbwe[4] && plbwrite), 
		.WEB ((bus2addr[11:13]==4) && bus2we));
RAMB16_S9_S9 bram25 (
		.DOA (outa25), 
		.DOB (outb25), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus2addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[40:47]), 
		.DIB (bus2in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==2) && plbwe[5] && plbwrite), 
		.WEB ((bus2addr[11:13]==5) && bus2we));
RAMB16_S9_S9 bram26 (
		.DOA (outa26), 
		.DOB (outb26), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus2addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.DIA (plbin[48:55]), 
		.DIB (bus2in), 
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==2) && plbwe[6] && plbwrite), 
		.WEB ((bus2addr[11:13]==6) && bus2we));
RAMB16_S9_S9 bram27 (
		.DOA (outa27), 
		.DOB (outb27), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus2addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[56:63]), 
		.DIB (bus2in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==2) && plbwe[7] && plbwrite), 
		.WEB ((bus2addr[11:13]==7) && bus2we));


//BUS3
RAMB16_S9_S9 bram30 (
		.DOA (outa30), 
		.DOB (outb30), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus3addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[0:7]), 
		.DIB (bus3in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==3) && plbwe[0] && plbwrite), 
		.WEB ((bus3addr[11:13]==0) && bus3we));
RAMB16_S9_S9 bram31 (
		.DOA (outa31), 
		.DOB (outb31), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus3addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[8:15]), 
		.DIB (bus3in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==3) && plbwe[1] && plbwrite), 
		.WEB ((bus3addr[11:13]==1) && bus3we));
RAMB16_S9_S9 bram32 (
		.DOA (outa32), 
		.DOB (outb32), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus3addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[16:23]), 
		.DIB (bus3in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==3) && plbwe[2] && plbwrite), 
		.WEB ((bus3addr[11:13]==2) && bus3we));
RAMB16_S9_S9 bram33 (
		.DOA (outa33), 
		.DOB (outb33), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus3addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[24:31]), 
		.DIB (bus3in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==3) && plbwe[3] && plbwrite), 
		.WEB ((bus3addr[11:13]==3) && bus3we));
RAMB16_S9_S9 bram34 (
		.DOA (outa34), 
		.DOB (outb34), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus3addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[32:39]), 
		.DIB (bus3in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==3) && plbwe[4] && plbwrite), 
		.WEB ((bus3addr[11:13]==4) && bus3we));
RAMB16_S9_S9 bram35 (
		.DOA (outa35), 
		.DOB (outb35), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus3addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[40:47]), 
		.DIB (bus3in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==3) && plbwe[5] && plbwrite), 
		.WEB ((bus3addr[11:13]==5) && bus3we));
RAMB16_S9_S9 bram36 (
		.DOA (outa36), 
		.DOB (outb36), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus3addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[48:55]), 
		.DIB (bus3in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==3) && plbwe[6] && plbwrite), 
		.WEB ((bus3addr[11:13]==6) && bus3we));
RAMB16_S9_S9 bram37 (
		.DOA (outa37), 
		.DOB (outb37), 
		.ADDRA (plbaddr[2:12]), 
		.ADDRB (bus3addr[0:10]), 
		.CLKA (clk), 
		.CLKB (clk), 
		.DIA (plbin[56:63]), 
		.DIB (bus3in), 
		.DIPA(1'b0),
		.DIPB(1'b0),
		.ENA (1'b1), 
		.ENB (1'b1), 
		.SSRA (1'b0), 
		.SSRB (1'b0), 
		.WEA ((plbaddr[0:1]==3) && plbwe[7] && plbwrite), 
		.WEB ((bus3addr[11:13]==7) && bus3we));






endmodule

