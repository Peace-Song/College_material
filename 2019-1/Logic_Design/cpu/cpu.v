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
	
	wire alu_src, alu_op, reg_dst, mem2reg, reg_write, jump;
	wire [1:0] src_B, dst_W;
	wire [7:0] val_W, val_A, val_C, val_offset, curr_PC, next_PC;
	
	//Data memory module in tb.v.
	memory dmem(	.clk(clk), .areset(areset),
			.write(dmem_write), .addr(dmem_addr),
			.write_data(dmem_write_data), .read_data(dmem_read_data)); 

	assign tb_data = dmem_read_data;
	//Testbench wiring end.

	//Write your code here.
	
	//CPU_name = "AMD Threadripper 3990WX"

	Control_Logic control_logic(.Mode(imem_data[7:6]), .OpCode(imem_data[5:4]), .ALUSrc(alu_src), .ALUOp(alu_op), 
			.MemWrite(dmem_write), .RegDst(reg_dst), .MemtoReg(mem2reg), .RegWrite(reg_write), .Jump(jump));
	
	Register_File register_file(.clk(clk), .write_enable(reg_write), .areset(areset), .read_reg1(imem_data[3:2]), 
			.read_reg2(src_B), .write_reg(dst_W), .write_data(val_W), .read_data1(val_A), .read_data2(dmem_write_data));
	
	ALU alu(.val_A(val_A), .val_B(val_C), .ALUOp(alu_op), .val_E(dmem_addr));
	
	Sign_Ext sign_ext(.in_offset(imem_data[5:0]), .Jump(jump), .out_offset(val_offset));
	
	NextPC nextpc(.Jump(jump), .curr_PC(imem_addr), .offset(val_offset), .next_PC(next_PC));
	
	PC_Control pc_control(.clk(clk), .areset(areset), .next_PC(next_PC), .curr_PC(imem_addr));
	
	MUX_2bit mux_src_B(.ctrl(dmem_write), .in_A(imem_data[1:0]), .in_B(imem_data[5:4]), .out(src_B));
	MUX_2bit mux_dst_W(.ctrl(reg_dst), .in_A(imem_data[5:4]), .in_B(imem_data[3:2]), .out(dst_W));
	MUX_8bit mux_val_C(.ctrl(alu_src), .in_A(val_offset), .in_B(dmem_write_data), .out(val_C));
	MUX_8bit mux_val_W(.ctrl(mem2reg), .in_A(dmem_addr), .in_B(dmem_read_data), .out(val_W));
	
endmodule

module Register_File
(
	input clk,
	input write_enable,
	input areset,
	
	input [1:0] read_reg1,
	input [1:0] read_reg2,
	input [1:0] write_reg,
	input [7:0] write_data,
	
	output reg [7:0] read_data1,
	output reg [7:0] read_data2
	);
	
	reg [7:0] r0; // 00
	reg [7:0] r1; // 01
	reg [7:0] r2; // 10
	reg [7:0] r3; // 11
	
	always @(posedge clk) begin
		if(areset == 1) begin // reset all registers to 0
			r0 = 8'h00;
			r1 = 8'h00;
			r2 = 8'h00;
			r3 = 8'h00;
		end
		else begin
			if(write_enable == 0) begin // NOP, Store, Jump
				case(read_reg1)
					2'b00: read_data1 = r0;
					2'b01: read_data1 = r1;
					2'b10: read_data1 = r2;
					2'b11: read_data1 = r3;
				endcase
				case(read_reg2)
					2'b00: read_data2 = r0;
					2'b01: read_data2 = r1;
					2'b10: read_data2 = r2;
					2'b11: read_data2 = r3;
				endcase
			end
			else if(write_enable == 1) begin // Add, Sub, Load
				case(read_reg1)
					2'b00: read_data1 = r0;
					2'b01: read_data1 = r1;
					2'b10: read_data1 = r2;
					2'b11: read_data1 = r3;
				endcase
				case(read_reg2)
					2'b00: read_data2 = r0;
					2'b01: read_data2 = r1;
					2'b10: read_data2 = r2;
					2'b11: read_data2 = r3;
				endcase
			
				case(write_reg)
					2'b00: r0 = write_data;
					2'b01: r1 = write_data;
					2'b10: r2 = write_data;
					2'b11: r3 = write_data;
				endcase
			end
		end
	end
	
endmodule

module Control_Logic
(
	input [1:0] Mode,
	input [1:0] OpCode,
	
	output reg ALUSrc,
	output reg ALUOp,
	output reg MemWrite,
	output reg RegDst,
	output reg MemtoReg,
	output reg RegWrite,
	output reg Jump
);

	always @(*) begin
		case(Mode)
			2'b11: begin
				if(OpCode == 2'b01) begin // Add
					ALUSrc = 1;		// to feed reg data to ALU
					ALUOp = 0;		// to indicate add operation to ALU
					MemWrite = 0;	// to indicate no write operation on Mem
					RegDst = 1;		// to indicate we are writing on 1st operand reg
					MemtoReg = 0;	// to indicate no load op
					RegWrite = 1;	// to write on reg
					Jump = 0;		// to indicate no jump
				end
				else if(OpCode == 2'b10) begin // Sub
					ALUSrc = 1;		// to feed reg data to ALU
					ALUOp = 1;		// to indicate sub operation to ALU
					MemWrite = 0;	// to indicate no write operation on Mem
					RegDst = 1;		// to indicate we are writing on 1st operand reg
					MemtoReg = 0;	// to indicate no load op
					RegWrite = 1;	// to write on reg
					Jump = 0;		// to indicate no jump
				end
				else if(OpCode == 2'b00) begin // NOP
					ALUSrc = 0;		// DC?
					ALUOp = 0;		// DC?
					MemWrite = 0;	// to indicate no write operation on Mem
					RegDst = 0;		// DC?
					MemtoReg = 0;	// to indicate no load op
					RegWrite = 0;	// not to write on reg
					Jump = 0;		// to indicate no jump
				end
			end
			2'b01: begin // Load
				ALUSrc = 0;		// to feed offset to ALU
				ALUOp = 0;		// to indicate add operation to ALU
				MemWrite = 0;	// to indicate no write operation on Mem
				RegDst = 0;		// to feed write_reg destination register
				MemtoReg = 1;	// to indicate load operation
				RegWrite = 1;	// to write on reg
				Jump = 0;		// to indicate no jump
			end
			2'b10: begin // Store
				ALUSrc = 0;		// to feed offset to ALU
				ALUOp = 0;		// to indicate add operation to ALU
				MemWrite = 1;	// to indicate write operation
				RegDst = 1; 	// DC?
				MemtoReg = 0;	// to indicate no load op
				RegWrite = 0; 	// not to write on reg
				Jump = 0;		// to indicate no jump
			end
			2'b00: begin // Jump
				ALUSrc = 0;		// DC?
				ALUOp = 0;		// DC?
				MemWrite = 0;	// to indicate no write operation on Mem
				RegDst = 0;		// DC?
				MemtoReg = 0;	// to indicate no load op
				RegWrite = 0;	// not to write on reg
				Jump = 1;		// to indicate jump
			end
		endcase
	end
endmodule

module Sign_Ext // used for sign extension of [off] field in load, store, and jump instructions.
(
	input [5:0] in_offset,
	input Jump,
	
	output [7:0] out_offset
);

	assign out_offset = (Jump == 1 ? {in_offset[5], in_offset[5], in_offset} : 0);

endmodule

module ALU
(
	input [7:0] val_A,
	input [7:0] val_B,
	input ALUOp,
	
	output [7:0] val_E
);

	assign val_E = (ALUOp == 0 ? val_A + val_B : val_A - val_B);

endmodule

module MUX_8bit
(
	input ctrl,
	input [7:0] in_A,
	input [7:0] in_B,
	
	output [7:0] out
);

	assign out = (ctrl == 1 ? in_B : in_A);

endmodule

module MUX_2bit
(
	input ctrl,
	input [1:0] in_A,
	input [1:0] in_B,
	
	output [1:0] out
);

	assign out = (ctrl == 1 ? in_B : in_A);

endmodule

module NextPC
(
	input Jump,
	input [7:0] curr_PC,
	input [7:0] offset,
	
	output [7:0] next_PC
);

	assign next_PC = curr_PC + (Jump == 1 ? offset : 8'b01);
	
endmodule

module PC_Control
(
	input clk,
	input areset,
	input [7:0] next_PC,
	
	output [7:0] curr_PC
);

	reg [7:0] PC;
	
	always @(posedge clk) begin
		if(areset) PC = 8'h00;
		else PC = next_PC;
	end
	
	assign curr_PC = PC;
	
endmodule
