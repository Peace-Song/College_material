`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:54:36 05/01/2019
// Design Name:   DFlipFlop
// Module Name:   /home/peacesong/Documents/Workspace/2019-1/Logic_Design/Lab7/DFlipFlop_test.v
// Project Name:  Lab7
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DFlipFlop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DFlipFlop_test;

	// Inputs
	reg CLK;
	reg D;

	// Outputs
	wire Q;
	wire Q_L;

	// Instantiate the Unit Under Test (UUT)
	DFlipFlop uut (
		.CLK(CLK), 
		.D(D), 
		.Q(Q), 
		.Q_L(Q_L)
	);

	initial begin
		CLK = 1;
		D = 0;
		#500;
		
		D = 1;
		#500;
		
		D = 0;
		#500;
		
		D = 1;
		#500;
		
		D = 0;
		#500;
		
		D = 1;
	end
      
	always #95 CLK = ~CLK;
endmodule

