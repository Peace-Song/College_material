`timescale 1ns / 1ps

module freqdiv_test;

	// Inputs
	reg rst;
	reg clkIN;

	// Outputs
	wire clkOUT;

	// Instantiate the Unit Under Test (UUT)
	freqdiv uut (
		.rst(rst), 
		.clkIN(clkIN), 
		.clkOUT(clkOUT)
	);

always #10 clkIN = ~clkIN;

	initial begin
		// Initialize Inputs
		rst = 1;
		clkIN = 0;
		#100;
		
		rst = 0;
		#100;
	end
      
endmodule

