`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:53 02/25/2019 
// Design Name: 
// Module Name:    ALU1bit 
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
module ALU1bit(
	input A,
	input B,
	input Cin,
	input [3:0]Opcode,
	
	output [1:0]ALUoutput,
	input clk
    );
	reg [1:0]aluoutput;
	assign ALUoutput = aluoutput;
	
	always@(*)
	begin
		case(Opcode)
		4'b0000: aluoutput <= A + B + Cin;
		4'b1000: aluoutput <= A - B - Cin;
		default: aluoutput <= 0;
		endcase
	end

endmodule
