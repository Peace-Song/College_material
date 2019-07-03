`timescale 1ns / 1ps

module TDC(
    input CLK,
    input RST,
	 input TGL,
    output  [6:0] seg_1,
    output  [6:0] seg_10
    );
	 
	 wire clk;
	 wire [3:0] BCD_0;
	 wire [3:0] BCD_1;
	 
	 freqdiv freqdiv(.rst(RST), .clkIN(CLK), .clkOUT(clk));
	 b7counter counter(.CLK(clk), .RST(RST), .TGL(TGL), .bcd_0(BCD_0), .bcd_1(BCD_1));
	 bcd_7decoder bcd7_1(.I(BCD_0), .O(seg_1));
	 bcd_7decoder bcd7_10(.I(BCD_1), .O(seg_10));

endmodule