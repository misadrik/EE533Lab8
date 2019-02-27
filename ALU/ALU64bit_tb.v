`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:43:54 02/13/2019
// Design Name:   ALU64bit
// Module Name:   C:/Users/benne/Documents/Xilinx/EE533Lab7/ALU64bit_tb.v
// Project Name:  EE533Lab7
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU64bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU64bit_tb;

	//Inputs
	reg [63:0] A, B;
	reg [3:0] opcode;
	reg clk, rst;
	//Outputs
	wire [63:0] Z;
	wire carry, overflow;

	// Instantiate the Unit Under Test (UUT)
	ALU64bit uut (
		.A(A), 
		.B(B), 
		.opcode(opcode),
		.clk(clk),
		.rst(rst),
		.Z(Z),
		.carry(carry),
		.overflow(overflow)
	);

	initial
	begin
		// Initialize Inputs
		A = 0;
		B = 0;
		opcode = 4'b0000;
		clk = 0;
		rst = 1;
		// Wait 100 ns for global reset to finish
		#100;
		rst = 0;
        
		// Add stimulus here
		opcode = 4'b0000; //bitwise AND
		#10;
		A = 64'h7FFFFFFFFFFFFFFF;
		B = 64'h123456789ABCDEF0;
		#10;
		A = 64'hFFFFFFFFFFFFFFFF;
		B = 64'hFFFFFFFFFFFFFFFF;
		#10;
		opcode = 4'b0001; //bitwise OR
		#10;
		A = 64'h7FFFFFFFFFFFFFFF;
		B = 64'h123456789ABCDEF0;
		#10;
		A = 0;
		B = 0;
		#10;
		opcode = 4'b0010; //bitwise XNOR
		#10;
		A = 64'hDEADBEEF12345678;
		B = 64'hDEADBEEF12345678;
		#10;
		B = 64'hDEADBEEF22345678;
		#10;
		A = 64'hFFFFFFFFFFFFFFFF;
		B = 64'hFFFFFFFFFFFFFFFF;
		#10;
		opcode = 4'b0100; //Left shift 
		#10;
		A = 64'h0000000000000001;
		#10;
		A = 64'h0000000000000000;
		#10;
		opcode = 4'b0101; //Right Logical Shift
		#10;
		A = 64'h8000000000000000;
		#10;
		A = 64'hFFFFFFFFFFFFFFFF;
		#10;
		opcode = 4'b1000; //Add
		A = 0;
		B = 0;
		#10;
		A = 64'h23456789ABCDEF01;
		B = 64'h3456789ABCDEF012;
		#10;
		A = 64'hFEDCBA0987654321;
		B = 64'h76543210FEDCBA98;
		#10;
		A = 64'h4000000000000000;
		B = 64'h4000000000000000;
		#10;
		A = 64'h8000000000000000;
		B = 64'h8000000000000000;
		#10;
		opcode = 4'b1001; //Subtract
		A = 64'h4000000000000000;
		B = 64'h4000000000000000;
		#10;
		A = 64'h876543210FEDCBA9;
		B = 64'h76543210FEDCBA98;
		#10;
		A = 64'h23456789ABCDEF01;
		B = 64'h3456789ABCDEF012;
		#10;
		A = 0;
		B = 0;
		#10;
		opcode = 4'b1010; //Less than
		#10;
		A = 1;
		B = 0;
		#10;
		A = 0;
		B = 1;
		#10;
		A = 64'h8000000000000000;
		#10;
		A = 64'h8000000000000001;
		#10;
		A = 64'h789ABCDEF0123456;
		B = 64'h89ABCDEF01234567;
		#10;
		opcode = 4'b1011; //less than or equal to
		A = 0;
		B = 0;
		#10;
		A = 1;
		B = 0;
		#10;
		A = 0;
		B = 1;
		#10;
		A = 64'h8000000000000000;
		#10;
		A = 64'h8000000000000001;
		#10;
		A = 64'h789ABCDEF0123456;
		B = 64'h89ABCDEF01234567;
		#10;
		opcode = 4'b1100; //greater than
		A = 0;
		B = 0;
		#10;
		A = 1;
		B = 0;
		#10;
		A = 0;
		B = 1;
		#10;
		A = 64'h8000000000000000;
		#10;
		A = 64'h8000000000000001;
		#10;
		A = 64'h789ABCDEF0123456;
		B = 64'h89ABCDEF01234567;
		#10;
		opcode = 4'b1101; //greater than or equal to
		A = 0;
		B = 0;
		#10;
		A = 1;
		B = 0;
		#10;
		A = 0;
		B = 1;
		#10;
		A = 64'h8000000000000000;
		#10;
		A = 64'h8000000000000001;
		#10;
		A = 64'h789ABCDEF0123456;
		B = 64'h89ABCDEF01234567;
		#10;
		opcode = 4'b1110; //equal to
		A = 0;
		B = 0;
		#10;
		A = 1;
		B = 0;
		#10;
		A = 0;
		B = 1;
		#10;
		A = 64'hFFFFFFFFFFFFFFFF;
		B = 64'hFFFFFFFFFFFFFFFF;
		#10;
		A = 64'hFEFFFFFFFFFFFFFF;
		#10;
		B = 64'hFEFFFFFFFFEFFFFF;
		#10;
		opcode = 4'b1111; //not equal to
		A = 0;
		B = 0;
		#10;
		A = 1;
		B = 0;
		#10;
		A = 0;
		B = 1;
		#10;
		A = 64'hFFFFFFFFFFFFFFFF;
		B = 64'hFFFFFFFFFFFFFFFF;
		#10;
		A = 64'hFEFFFFFFFFFFFFFF;
		#10;
		B = 64'hFEFFFFFFFFEFFFFF;
		#10;
		opcode = 4'b0000;
		A = 0;
		B = 0;

	end
	
	always
	begin
		#5 clk = ~clk;
	end
      
endmodule

