`timescale 1ns / 1ps

module bcd_7decoder(
    input [3:0] I,
    output reg [6:0] O
    );

always @(*) begin
    case(I)
    	4'd0:  O = 7'b1111110;
    	4'd1:  O = 7'b0110000;
    	4'd2:  O = 7'b1101101;
    	4'd3:  O = 7'b1111001;
    	4'd4:  O = 7'b0110011;
    	4'd5:  O = 7'b1011011;
    	4'd6:  O = 7'b1011111;
    	4'd7:  O = 7'b1110000;
    	4'd8:  O = 7'b1111111;
    	4'd9:  O = 7'b1110011;
    	4'd10: O = 7'b1110111;
    	4'd11: O = 7'b0011111;
    	4'd12: O = 7'b1001110;
    	4'd13: O = 7'b0111101;
    	4'd14: O = 7'b1001111;
	    4'd15: O = 7'b1000111;
	endcase
end
endmodule
