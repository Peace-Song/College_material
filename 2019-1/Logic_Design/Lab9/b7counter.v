`timescale 1ns / 1ps

module b7counter(
    input CLK,
	 input RST,
	 input TGL,
    output reg [3:0] bcd_0,
	 output reg [3:0] bcd_1
    );
	 
	 reg [6:0] count;
	 reg [3:0] d10_count;
	 reg reverse;
	 
	 always @ (posedge TGL) begin
		if(reverse == 0) reverse = 1;
		else reverse = 0;
	 end
	 
	 always @(posedge CLK) begin
		if(RST == 1) begin 
			count = 0; 
			d10_count = 0;
			bcd_0 = 0;
			bcd_1 = 0;
		end

		else if(reverse == 0) begin
			bcd_1 = d10_count;
			
			bcd_0 = count - 10 * bcd_1;
			
			if(bcd_0 == 9) d10_count = d10_count + 1;
			
			
			count = count + 1;
			if(count == 100) begin
				count = 0;
				d10_count = 0;
			end
		end
		
		else begin		
			if(count == 0) begin
				count = 100;
				d10_count = 9;
				bcd_0 = 0;
				bcd_1 = 0;
			end

			else begin
				bcd_1 = d10_count;
			
				bcd_0 = count - 10 * bcd_1;
			
				if(bcd_0 == 0) d10_count = d10_count - 1;
			end
			
			count = count - 1;
	 end
	end
endmodule