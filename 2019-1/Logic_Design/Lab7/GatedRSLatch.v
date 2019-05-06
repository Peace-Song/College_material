`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:25:42 05/01/2019 
// Design Name: 
// Module Name:    GatedRSLatch 
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
module GatedRSLatch(
    input ENA,
    input R,
    input S,
    output Q,
    output Q_L
    );

	 wire r_tmp, s_tmp;
	 
	 assign #10 r_tmp = R & ENA;
	 assign #10 s_tmp = S & ENA;
	 
	 RSLatch RS_0(.R(r_tmp), .S(s_tmp), .Q(Q), .Q_L(Q_L));
	 
endmodule
