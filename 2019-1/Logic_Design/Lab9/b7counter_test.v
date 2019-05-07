`timescale 1ns / 1ps

module b7counter_test;

	// Inputs
	reg CLK;
	reg RST;
	
	// Outputs
	wire [3:0] bcd_0;
	wire [3:0] bcd_1;

	// Instantiate the Unit Under Test (UUT)
	b7counter uut (
		.CLK(CLK),
		.RST(RST),
		.bcd_0(bcd_0),
		.bcd_1(bcd_1)
	);

	always #10 CLK = ~CLK;
	
	initial begin
	CLK = 0;
	RST = 1;
	#50
	
	RST = 0;
	#2000
	
	RST= 1;
	#200
	RST = 0;
		// Initialize Inputs

	end
      
endmodule