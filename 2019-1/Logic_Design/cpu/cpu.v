`timescale 1ns/1ps

//Machine code layout

/*
Jump:	00 [offset 6b]
Load:	01 [rt] [rs] [off] -> rt = rs[off]
Loading to any register should update tb_data of TB wiring (Handled by TA).

Store: 	10 [rs] [rd] [off] -> rd[off] = rs

Arith:	11 [op] [rd] [rs]
	11 00 NOP
	11 01 ADD	rd += rs
	11 10 SUB	rd -= rs
	11 11 NOP
*/


module cpu	//Do not change top module name or ports.
(
	input	clk,
	input	areset,

	output	[7:0] imem_addr,	//Request instruction memory
	input	[7:0] imem_data,	//Returns 

	output	[7:0] tb_data		//Testbench wiring.
);

	//Data memory and testbench wiring. you may rename them if you like.
	wire dmem_write; // read if 0, write if 1
	wire [7:0] dmem_addr, dmem_write_data, dmem_read_data; // addr: 0~31, data: 1byte
	
	//Data memory module in tb.v.
	memory dmem(	.clk(clk), .areset(areset),
			.write(dmem_write), .addr(dmem_addr),
			.write_data(dmem_write_data), .read_data(dmem_read_data)); 

	assign tb_data = dmem_read_data;
	//Testbench wiring end.

	//Write your code here.

endmodule

module PC
(
	input clk,
	input [7:0] nextPC,
	
	output [7:0] PC
);

	reg [7:0] PC;
	
	always @(posedge clk)
		PC = nextPC;

endmodule

module Register_File
(
	input clk,
	input write_enable,
	input areset,
	
	input [1:0] read_reg1,
	input [1:0] read_reg2,
	input [1:0] write_reg,
	input [1:0] write_data,
	
	output [7:0] read_data1,
	output [7:0] read_data2
	);
	
	reg [7:0] al; // 00
	reg [7:0] cl; // 01
	reg [7:0] dl; // 10
	reg [7:0] bl; // 11
	
endmodule

module Control_Logic
(
	input [1:0] Mode,
	input [1:0] OpCode,
	
	output ALUSrc,
	output ALUOp,
	output MemWrite,
	output RegDst,
	output MemtoReg,
	output RegWrite
);

endmodule

module Sign_Ext // used for sign extension of [off] field in load, store, and jump instructions.
(
	input [5:0] in_offset,
	input Jump,
	
	output [7:0] out_offset
);

endmodule

module ALU
(
	input [7:0] val_A,
	input [7:0] val_B,
	input ALUOp,
	
	output [7:0] val_E
);

endmodule

module PC_incr
(
	input [7:0] PC_now,
	input [7:0] PC_off,
	
	output [7:0] val_P
);

endmodule

module MUX
(
	input ctrl,
	input [7:0] in_A,
	input [7:0] in_B,
	
	output [7:0] out
);

endmodule
