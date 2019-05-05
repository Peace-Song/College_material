`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:22:49 05/01/2019 
// Design Name: 
// Module Name:    RSLatch 
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
module RSLatch(
    input R,
    input S,
    output Q,
    output Q_L
    );

	 assign #10 Q = ~(Q_L | R);
	 assign #10 Q_L = ~(Q | S);
	 
endmodule
