`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:52 02/25/2019 
// Design Name: 
// Module Name:    ALU63bit 
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
module ALU63bit(
	input [62:0]A,
	input [62:0]B,
	input [3:0]Opcode,
	
	output [63:0]ALUoutput,
	input clk
    );
	reg [63:0] aluoutput;
	assign ALUoutput = aluoutput;
	
	always @(*)
	begin
		case(Opcode)
		4'b0000: aluoutput <= A + B;
		4'b1000: aluoutput <= A - B;
		default: aluoutput <= 0;
		endcase
	end

endmodule
