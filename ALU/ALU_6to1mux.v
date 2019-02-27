`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:16 02/13/2019 
// Design Name: 
// Module Name:    ALU_6to1mux 
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
module ALU_6to1mux(
   input and_in,
	input or_in,
	input xnor_in,
	input shift_l,
	input shift_r,
	input add_sub,
	input [3:0] select,
	output result);

	wire inter_result;
	
	//Select between bitwise operations
	assign inter_result = (and_in && ~select[1] && ~select[0]) ||
		(or_in && ~select[1] && select[0]) || (xnor_in && select[1]);
	//Select between add_sub result, left shift, right shift, and bitwise operations
	assign result = (add_sub && select[3]) ||
		(shift_l && ~select[3] && select[2] && ~select[0]) ||
		(shift_r && ~select[3] && select[2] && select[0]) ||
		(inter_result && ~select[3] && ~select[2]);

endmodule
