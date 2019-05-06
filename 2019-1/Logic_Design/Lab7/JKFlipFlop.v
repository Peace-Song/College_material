`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:40:37 05/01/2019 
// Design Name: 
// Module Name:    JKFlipFlop 
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
module JKFlipFlop(
    input CLK,
    input J,
    input K,
    output Q,
    output Q_L
    );

	 wire nand_J, nand_K;
	 
	 assign #10 nand_J = ~(J & Q_L & CLK);
	 assign #10 nand_K = ~(K & Q & CLK);
	 assign #10 Q = ~(nand_J & Q_L);
	 assign #10 Q_L = ~(nand_K & Q);
	 
endmodule
