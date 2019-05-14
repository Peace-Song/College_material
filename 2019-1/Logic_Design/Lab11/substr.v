`timescale 1ns/1ps			

module seq_detector
(
	//Control signals
	input clk,	//Positive edge triggered.
	input areset,	//Reset all in 1

	//Data signals
	input seq,
	output detected
);
	//Declare your variables here.

	always @(posedge clk)
	begin
		//Write your code here.

	end

	//You may write some wiring code here.

endmodule
