`timescale 1ns / 1ps
module shift_reg_8b(
		input CLRb,
		input [1:0] s,
		input CLK,
		input SDL,
		input SDR,
		input [7:0] D,
		output [7:0] Q
    );

reg [7:0] Q;

always @ (posedge CLK or negedge CLRb) begin
	if(CLRb == 0) Q = 0;
	else begin
		case(s)
			2'b11: Q = D;
			2'b10: Q = {Q[6:0], SDL};
			2'b01: Q = {SDR, Q[7:1]};
			default: Q = Q;
		endcase
	end
end	  
endmodule