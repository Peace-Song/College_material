`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:34:18 05/01/2019
// Design Name:   MSFlipFlop
// Module Name:   /home/peacesong/Documents/Workspace/2019-1/Logic_Design/Lab7/MSFlipFlop_test.v
// Project Name:  Lab7
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MSFlipFlop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MSFlipFlop_test;

	// Inputs
	reg CLK;
	reg R;
	reg S;

	// Outputs
	wire Q;
	wire Q_L;

	// Instantiate the Unit Under Test (UUT)
	MSFlipFlop uut (
		.CLK(CLK), 
		.R(R), 
		.S(S), 
		.Q(Q), 
		.Q_L(Q_L)
	);

	initial begin
		// Initialize Inputs
		CLK = 1;
		R = 0;
		S = 1;
		#500;
		
		R = 1;
		S = 0;
		#500;
		
		R = 0;
		S = 0;
		#200;
		S = 1;
		#50;
		S = 0;
		#250;
		
		R = 1;
		S = 1;
		#500;
	end
      
	always #95 CLK = ~CLK;
endmodule

