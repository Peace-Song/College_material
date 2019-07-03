`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:30:32 05/01/2019 
// Design Name: 
// Module Name:    MSFlipFlop
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
module MSFlipFlop(
    input CLK,
    input R,
    input S,
    output Q,
    output Q_L
    );

	 wire CLK_L;
	 assign #10 CLK_L = ~CLK;
	 
	 wire P, P_L;
	 GatedRSLatch GRS_0(.ENA(CLK), .R(R), .S(S), .Q(P), .Q_L(P_L));
	 GatedRSLatch GRS_1(.ENA(CLK_L), .R(P_L), .S(P), .Q(Q), .Q_L(Q_L));

endmodule
