`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:42:37 05/01/2019
// Design Name:   JKFlipFlop
// Module Name:   /home/peacesong/Documents/Workspace/2019-1/Logic_Design/Lab7/JKFlipFlop_test.v
// Project Name:  Lab7
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: JKFlipFlop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module JKFlipFlop_test;

	// Inputs
	reg CLK;
	reg J;
	reg K;

	// Outputs
	wire Q;
	wire Q_L;

	// Instantiate the Unit Under Test (UUT)
	JKFlipFlop uut (
		.CLK(CLK), 
		.J(J), 
		.K(K), 
		.Q(Q), 
		.Q_L(Q_L)
	);

	initial begin
		// Initialize Inputs
		CLK = 1;
		K = 0;
		J = 1;
		force Q = 1;
		#200;
		release Q;
		#300;
		
		K = 1;
		J = 0;
		#500;
		
		K = 0;
		J = 0;
		#500;
		
		K = 1;
		J = 1;
		#500;
	end
      
	always #95 CLK = ~CLK;
endmodule

