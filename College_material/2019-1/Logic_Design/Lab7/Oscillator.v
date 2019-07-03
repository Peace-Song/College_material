`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:19:04 05/01/2019 
// Design Name: 
// Module Name:    Oscillator 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Oscillator(
    input ENA,
    output CLK
    );
	
	 wire tmp[1:0];
	 
	 assign #10 CLK = ~(ENA & tmp[1]);
	 assign #10 tmp[0] = ~CLK;
	 assign #10 tmp[1] = ~tmp[0];

endmodule
