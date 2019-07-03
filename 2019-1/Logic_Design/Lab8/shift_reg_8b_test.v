`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:43:44 05/07/2019
// Design Name:   shift_reg_8b
// Module Name:   /home/peacesong/Documents/Workspace/2019-1/Logic_Design/Lab8/shift_reg_8b_test.v
// Project Name:  Lab8
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: shift_reg_8b
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module shift_reg_8b_test;

	// Inputs
	reg CLRb;
	reg [1:0] s;
	reg CLK;
	reg SDL;
	reg SDR;
	reg [7:0] D;

	// Outputs
	wire [7:0] Q;

	// Instantiate the Unit Under Test (UUT)
	shift_reg_8b uut (
		.CLRb(CLRb), 
		.s(s), 
		.CLK(CLK), 
		.SDL(SDL), 
		.SDR(SDR), 
		.D(D), 
		.Q(Q)
	);

	always #10 CLK = ~CLK;

	initial begin
		// Initialize Inputs
		CLRb = 0;
		s = 2'b00;
		CLK = 0;
		SDL = 0;
		SDR = 0;
		D = 8'b00000000;
		#100;
        
		CLRb = 0;
		s = 2'b11;
		D = 8'b10111001;
		#85;
		
		CLRb = 1;
		#115;
		
		s = 2'b10;
		#100;
		
		SDL = 1;
		#100;
		
		SDL = 0;
		s = 2'b01;
		#100;
		
		SDR = 1;
		#100;
		
		SDR = 0;
		s = 2'b00;
		#105;
		
		CLRb = 0;
		#100;
	end
      
endmodule

