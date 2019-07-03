`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:52:55 05/01/2019 
// Design Name: 
// Module Name:    DFlipFlop 
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
module DFlipFlop(
    input CLK,
    input D,
    output Q,
    output Q_L
    );

	 MSFlipFlop MSF_0(.CLK(CLK), .S(D), .R(~D), .Q(Q), .Q_L(Q_L));

endmodule
