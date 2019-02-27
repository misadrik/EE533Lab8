`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:39:59 02/25/2019 
// Design Name: 
// Module Name:    ALU64bit 
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
module ALU64bit(
	input [63:0]A,
	input [63:0]B,
	input [3:0]Opcode,
	
	output [63:0]ALUoutput,
	output Carry,
	output Overflow,
	input clk
    );
	wire [63:0]ALU63output;
	ALU63bit alu63(.A(A[62:0]),.B(B[62:0]),.Opcode(Opcode),.ALUoutput(ALU63output),.clk(clk));
	
	wire [1:0]ALU1output;
	ALU1bit alu1(.A(A[63]),.B(B[63]),.Cin(ALU63output[63]),.Opcode(Opcode),.ALUoutput(ALU1output),.clk(clk));
	
	assign Carry = ALU1output[1];
	assign Overflow = ALU63output[63] ^ ALU1output[1];
	
	reg [63:0]aluoutput;
	assign ALUoutput = aluoutput;
	
	always @(*)
	begin
		case(Opcode)
		4'b0000: aluoutput <= {ALU1output[0],ALU63output[62:0]};
		4'b1000: aluoutput <= {ALU1output[0],ALU63output[62:0]};
		4'b0001: aluoutput <= A << 1;
		4'b0100: aluoutput <= A ^ B;
		4'b0101: aluoutput <= A >> 1;
		4'b0110: aluoutput <= A | B;
		4'b0111: aluoutput <= A & B;
		default: aluoutput <= 0;
		endcase
	end

endmodule
