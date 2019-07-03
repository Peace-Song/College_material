`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:55:43 05/07/2019
// Design Name:   TDC
// Module Name:   /csehome/zoov0716/Downloads/TDC/TDC_test.v
// Project Name:  TDC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TDC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TDC_test;

	// Inputs
	reg CLK;
	reg RST;

	// Outputs
	wire [6:0] seg_1;
	wire [6:0] seg_10;

	// Instantiate the Unit Under Test (UUT)
	TDC uut(
		.CLK(CLK), 
		.RST(RST), 
		.seg_1(seg_1), 
		.seg_10(seg_10)
	);


	always #10 CLK = ~CLK;
	
	initial begin
		// Initialize Inputs
	CLK = 0;
	RST = 1;
	#5000
	
	RST = 0;
	#200000
	
	RST= 1;
	#20000
	RST = 0;
        
		// Add stimulus here

	end
      
endmodule

