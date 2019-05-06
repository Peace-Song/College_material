`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:23:31 05/01/2019
// Design Name:   RSLatch
// Module Name:   /home/peacesong/Documents/Workspace/2019-1/Logic_Design/Lab7/RSLatch_test.v
// Project Name:  Lab7
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RSLatch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module RSLatch_test;

	// Inputs
	reg R;
	reg S;

	// Outputs
	wire Q;
	wire Q_L;

	// Instantiate the Unit Under Test (UUT)
	RSLatch uut (
		.R(R), 
		.S(S), 
		.Q(Q), 
		.Q_L(Q_L)
	);

	initial begin
		// Initialize Inputs
		R = 0;
		S = 0;
		#100;
		
		R = 0;
		S = 1;
		#100;
		
		R = 1;
		S = 0;
		#100;
		
		R = 1;
		S = 1;
		#100;
		
		R = 0;
		S = 0;
	end
      
endmodule

