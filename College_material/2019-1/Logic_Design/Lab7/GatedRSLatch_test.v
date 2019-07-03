`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:26:48 05/01/2019
// Design Name:   GatedRSLatch
// Module Name:   /home/peacesong/Documents/Workspace/2019-1/Logic_Design/Lab7/GatedRSLatch_test.v
// Project Name:  Lab7
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: GatedRSLatch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module GatedRSLatch_test;

	// Inputs
	reg ENA;
	reg R;
	reg S;

	// Outputs
	wire Q;
	wire Q_L;

	// Instantiate the Unit Under Test (UUT)
	GatedRSLatch uut (
		.ENA(ENA), 
		.R(R), 
		.S(S), 
		.Q(Q), 
		.Q_L(Q_L)
	);

	initial begin
		// Initialize Inputs
		ENA = 1;
		R = 0;
		S = 1;
		#500;
		
		R = 1;
		S = 0;
		#500;
		
		R = 0;
		S = 0;
		#500;
		
		R = 1;
		S = 1;
		#500;
		
	end
      
	always #95 ENA = ~ENA;
endmodule

