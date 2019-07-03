`timescale 1ns/1ps

module tb();

reg [0:31] sequence, answer;
reg [7:0] counter, err_counter;


reg clk, rst;
wire opt;

initial
begin
	sequence = 32'h3927FA61;
	answer = 32'h00900100;

	counter = 8'hff;
	err_counter = 8'h00;

	clk = 0;
	rst = 1;
	#23;

	rst = 0;
end

always #5 clk = ~clk;

always @(posedge clk)
begin
	if(!rst)
	begin
		if(counter == 31)
		begin
			$display("Test end. # of Incorrect results: %d", err_counter);
			$finish;
		end
		counter <= counter + 1;
	end
end

always @(negedge clk)
begin
	if(!rst)
	begin
		if(answer[counter] != opt)
		begin
			err_counter <= err_counter + 1;
			$display("Data miscompare at seq %d! Answer: %d, Output: %d", counter, answer[counter], opt);
		end
	end

end

	seq_detector UUT(.clk(clk), .areset(rst), .seq(sequence[counter]), .detected(opt));

endmodule
