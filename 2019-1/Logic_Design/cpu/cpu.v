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
	wire [7:0] val_W, val_A, val_B, val_C, val_E, val_offset, curr_PC, next_PC;
	
	//Data memory module in tb.v.
	memory dmem(	.clk(clk), .areset(areset),
			.write(dmem_write), .addr(dmem_addr),
			.write_data(dmem_write_data), .read_data(dmem_read_data)); 

	assign tb_data = dmem_read_data;
	assign dmem_write_data = val_B;
	assign dmem_addr = val_E;
	assign imem_addr = curr_PC;
	//Testbench wiring end.

	//Write your code here.
	
	Control_Logic control_logic(.Mode(imem_data[7:6]), .OpCode(imem_data[5:4]), .ALUSrc(alu_src), .ALUOp(alu_op), 
			.MemWrite(dmem_write), .RegDst(reg_dst), .MemtoReg(mem2reg), .RegWrite(reg_write), .Jump(jump));
	
	Register_File register_file(.clk(clk), .write_enable(reg_write), .areset(areset), .read_reg1(imem_data[3:2]), 
			.read_reg2(src_B), .write_reg(dst_W), .write_data(val_W), .read_data1(val_A), .read_data2(val_B));
	
	ALU alu(.val_A(val_A), .val_B(val_C), .ALUOp(alu_op), .val_E(val_E));
	
	Sign_Ext sign_ext(.in_offset(imem_data[5:0]), .Jump(jump), .out_offset(val_offset));
	
	NextPC nextpc(.Jump(jump), .curr_PC(curr_PC), .offset(val_offset), .next_PC(next_PC));
	
	PC_Control pc_control(.clk(clk), .areset(areset), .next_PC(next_PC), .curr_PC(curr_PC));
	
	MUX_2bit mux_src_B(.ctrl(dmem_write), .in_A(imem_data[1:0]), .in_B(imem_data[5:4]), .out_M(src_B));
	MUX_2bit mux_dst_W(.ctrl(reg_dst), .in_A(imem_data[5:4]), .in_B(imem_data[3:2]), .out_M(dst_W));
	MUX_8bit mux_val_C(.ctrl(alu_src), .in_A(val_offset), .in_B(val_B), .out_M(val_C));
	MUX_8bit mux_val_W(.ctrl(mem2reg), .in_A(val_E), .in_B(dmem_read_data), .out_M(val_W));
	
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
	
	output [7:0] read_data1,
	output [7:0] read_data2
	);
	
	reg [7:0] register[3:0];
	
	initial begin
		register[0] = 8'h00; // r0
		register[1] = 8'h00; // r1
		register[2] = 8'h00; // r2
		register[3] = 8'h00; // r3
	end
	
	assign read_data1 = register[read_reg1];
	assign read_data2 = register[read_reg2];
	
	always @(posedge clk) begin
		if(areset == 1) begin // reset all registers to 0
			register[0] = 8'h00;
			register[1] = 8'h00;
			register[2] = 8'h00;
			register[3] = 8'h00;
		end
		else if(write_enable == 1) 
			register[write_reg] = write_data;
	end // do nothing if neither the case, which is the case of register read
	
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
				if(OpCode == 2'b01) begin // Add: 11 01 [rd] [rs] such that $rd = $rd + $rs
					ALUSrc = 1;			// to feed reg data to ALU
					ALUOp = 0;			// to indicate add operation to ALU
					MemWrite = 0;	// to indicate no write operation on Mem
					RegDst = 1;			// to indicate we are writing on 1st operand reg
					MemtoReg = 0;	// to indicate no load op
					RegWrite = 1;		// to write on reg
					Jump = 0; 				// to indicate no jump
				end
				else if(OpCode == 2'b10) begin // Sub: 11 10 [rd] [rs] such that $rd = $rd - $rs
					ALUSrc = 1;			// to feed reg data to ALU
					ALUOp = 1;			// to indicate sub operation to ALU
					MemWrite = 0;	// to indicate no write operation on Mem
					RegDst = 1;			// to indicate we are writing on 1st operand reg
					MemtoReg = 0;	// to indicate no load op
					RegWrite = 1;		// to write on reg
					Jump = 0;				// to indicate no jump
				end
				else if(OpCode == 2'b00) begin // NOP: 11 00 XX XX
					ALUSrc = 1;			// DC
					ALUOp = 0;			// DC
					MemWrite = 0;	// to indicate no write operation on Mem
					RegDst = 0;			// DC
					MemtoReg = 0;	// to indicate no load op
					RegWrite = 0;		// not to write on reg
					Jump = 0;				// to indicate no jump
				end
				else begin // Addi: 11 11 [rd] [imm] such that $rd = $rd + imm
					ALUSrc = 0;			// to feed offset to ALU
					ALUOp = 0;			// to indicate add operation to ALU
					MemWrite = 0;	// to indicate no write operation on Mem
					RegDst = 1;			// to indicate we are writing on 1st operand reg
					MemtoReg = 0;	// to indicate no load op
					RegWrite = 1;		// to write on reg
					Jump = 0;				// to indicate no jump
				end
			end
			2'b01: begin // Load: 01 [rt] [rs] [off] such that $rt = M[$rs + off]
				ALUSrc = 0;				// to feed offset to ALU
				ALUOp = 0;				// to indicate add operation to ALU
				MemWrite = 0;		// to indicate no write operation on Mem
				RegDst = 0;				// to feed write_reg destination register with OpCode
				MemtoReg = 1;		// to indicate load operation
				RegWrite = 1;			// to write on reg
				Jump = 0;					// to indicate no jump
			end
			2'b10: begin // Store: 10 [rs] [rd] [off] such that M[$rd + off] = $rs
				ALUSrc = 0;				// to feed offset to ALU
				ALUOp = 0;				// to indicate add operation to ALU
				MemWrite = 1;		// to indicate write operation
				RegDst = 0; 				// DC
				MemtoReg = 0;		// to indicate no load op
				RegWrite = 0; 			// not to write on reg
				Jump = 0;					// to indicate no jump
			end
			2'b00: begin // Jump: 00 [off] such that $PC = $PC + off
				ALUSrc = 0;				// DC
				ALUOp = 0;				// DC
				MemWrite = 0;		// to indicate no write operation on Mem
				RegDst = 0;				// DC
				MemtoReg = 0;		// to indicate no load op
				RegWrite = 0;			// not to write on reg
				Jump = 1;					// to indicate jump
			end
		endcase
	end
endmodule


module Sign_Ext // to feed sign-extended value to ALU or PC.
(
	input [5:0] in_offset,
	input Jump,
	
	output [7:0] out_offset
);

	assign out_offset = (Jump == 1 ? {in_offset[5], in_offset[5], in_offset[5:0]} : {in_offset[1], in_offset[1], in_offset[1], in_offset[1], in_offset[1], in_offset[1], in_offset[1:0]});

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


module NextPC // computes next PC dependingon the value of Jump
(
	input Jump,
	input [7:0] curr_PC,
	input [7:0] offset,
	
	output [7:0] next_PC
);

	assign next_PC = curr_PC + (Jump == 1 ? offset : 8'h01);
	
endmodule


module PC_Control // feeds PC to program and determines which PC value should be fed 
(
	input clk,
	input areset,
	input [7:0] next_PC,
	
	output reg [7:0] curr_PC
);
	
	always @(posedge clk) begin
		if(areset == 1) curr_PC = 8'h00;
		else curr_PC = next_PC;
	end
	
endmodule


module MUX_8bit
(
	input ctrl,
	input [7:0] in_A,
	input [7:0] in_B,
	
	output [7:0] out_M
);

	assign out_M = (ctrl == 1 ? in_B : in_A);

endmodule


module MUX_2bit
(
	input ctrl,
	input [1:0] in_A,
	input [1:0] in_B,
	
	output [1:0] out_M
);

	assign out_M = (ctrl == 1 ? in_B : in_A);

endmodule
