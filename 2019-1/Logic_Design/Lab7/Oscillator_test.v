`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:20:09 05/01/2019
// Design Name:   Oscillator
// Module Name:   /home/peacesong/Documents/Workspace/2019-1/Logic_Design/Lab7/Oscillator_test.v
// Project Name:  Lab7
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Oscillator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Oscillator_test;

	// Inputs
	reg ENA;

	// Outputs
	wire CLK;

	// Instantiate the Unit Under Test (UUT)
	Oscillator uut (
		.ENA(ENA), 
		.CLK(CLK)
	);

	initial begin
		// Initialize Inputs
		ENA = 0;
		#100;
      ENA = 1;
		// Add stimulus here

	end
      
endmodule

