`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:54:54 02/12/2019 
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
	input [63:0] A,
	input [63:0] B,
	input [3:0] opcode,
	input clk,
	input rst,
	output reg [63:0] Z,
	output reg carry,
	output reg overflow);
	 
	reg [63:0] comp_result, A_s, B_s;
	reg [3:0] opcode_s;
	
	wire [65:0] padded_A;
	wire [64:0] carry_internal;
	wire [63:0] Z_raw, and_out, or_out, xnor_out, sum_diff, bitwise_result;
	wire sub, carry_raw, overflow_raw, result_select;
	wire less_than, less_than_equal, greater_than, greater_than_equal, equal, not_equal;
	
	//opcodes:
	//0000 - bitwise AND
	//0001 - bitwise OR
	//0010 - bitwise XNOR
	//0100 - shift left
	//0101 - logical shift right
	//1000 - add
	//1001 - subtract
	//1010 - less than
	//1011 - less than or equal to
	//1100 - greater than
	//1101 - greater than or equal to
	//1110 - equal to
	//1111 - not equal to
	
	//(sub == true) has adder perform subtraction, used in subtract and comparison operations
	assign sub = opcode_s[2] || opcode_s[1] || opcode_s[0];
	assign carry_internal[0] = sub; //Set the first full adder's Cin if subtracting
	//Pad the A input with zeros at the beginning and end for use when shifting
	assign padded_A[0] = 1'b0;
	assign padded_A[64:1] = A_s;
	assign padded_A[65] = 1'b0;
	//bitwise logic operations
	assign and_out = A_s & B_s;
	assign or_out = A_s | B_s;
	assign xnor_out = A_s ~^ B_s;
	 
	//Create 64 instances of 1-bit ALU's and connect them
	generate
		genvar i;
		for(i = 0; i < 64; i = i + 1)
		begin : alu_1bit
			wire b_in;
			//XOR the B input with the subtraction control value and perform the bitwise add/subtract
			assign b_in = B_s[i] ^ sub;
			fullAdder FA(.A(A_s[i]), .B(b_in), .Cin(carry_internal[i]),
				.Cout(carry_internal[i+1]), .S(sum_diff[i]));
			//Mux the outputs of the bitwise operations (uses no gates above 4-input)
			ALU_6to1mux mux(.and_in(and_out[i]), .or_in(or_out[i]),
				.xnor_in(xnor_out[i]), .shift_l(padded_A[i]), .shift_r(padded_A[i+2]),
				.add_sub(sum_diff[i]), .select(opcode_s), .result(bitwise_result[i]));		
		end
	endgenerate

	//carry is the Cout of an add/subtract or shift operation
	assign carry_raw = opcode_s[3] ? carry_internal[64] : (opcode_s[0] ? 1'b0 : A_s[63]); 
	assign overflow_raw = carry_internal[64] ^ carry_internal[63]; //Overflow is the two highest carries XORed
	assign equal = &xnor_out; //If all of the bitwise XNOR values are true, the two inputs are equal
	assign not_equal = ~equal;
	//A < B if the difference is negative with no overflow or positive with overflow
	assign less_than = sum_diff[63] ^ overflow_raw;
	assign less_than_equal = less_than | equal;
	assign greater_than_equal = ~less_than;
	assign greater_than = greater_than_equal && not_equal;
	
	//Mux values of comparison to lowest bit of comp_result
	always@(*)
	begin
		comp_result[63:1] = 0;
		case(opcode_s[2:0])
			3'b000,3'b001,3'b010: comp_result[0] = less_than;
			3'b011: comp_result[0] = less_than_equal;
			3'b100: comp_result[0] = greater_than;
			3'b101: comp_result[0] = greater_than_equal;
			3'b110: comp_result[0] = equal;
			3'b111: comp_result[0] = not_equal;
			default: comp_result[0] = 1'bX;
		endcase
	end
	
	//Select either the comparison or bitwise result based on opcode (64 bit mux)
	assign result_select = opcode_s[3] & (opcode_s[2] | opcode_s[1]);
	assign Z_raw = result_select ? comp_result : bitwise_result;
	
	//Output Registers to synchronize value
	always@(posedge clk, posedge rst)
	begin
		if(rst)
		begin
			A_s <= 0;
			B_s <= 0;
			opcode_s <= 0;
			Z <= 0;
			carry <= 1'b0;
			overflow <= 1'b0;
		end
		else
		begin
			A_s <= A;
			B_s <= B;
			opcode_s <= opcode;
			Z <= Z_raw;
			carry <= carry_raw;
			overflow <= overflow_raw;
		end
	end
endmodule
