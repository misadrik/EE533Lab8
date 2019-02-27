`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:22:11 02/18/2019 
// Design Name: 
// Module Name:    RegFile 
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
module RegFile(
	 input [4:0] r0addr,
    input [4:0] r1addr,
    input [63:0] wdata,
    input [4:0] waddr,
    input wena,
    output [63:0] r0data,
    output [63:0] r1data,
	 
	 input  [4:0] swaddr,
	 input [63:0] swdata,
	 input swena,
	 
	 output [63:0] dff,
	 input clk
    );
	reg [63:0] DFF[0:31];
	
	assign r0data = DFF[r0addr];
	assign r1data = DFF[r1addr];
	
	assign dff = DFF[swaddr];

	initial
	begin
		DFF[0] = 0;
		DFF[1] = 1;
		DFF[2] = 2;
		DFF[3] = 3;
		DFF[4] = 4;
		DFF[5] = 5;
		DFF[12] = 12;
		DFF[13] = 12;
	end

	always @(posedge clk)
	begin
		if(wena)
		begin
			DFF[waddr] <= wdata;
			DFF[0] <= 0;
		end
		if(swena)
		begin
			DFF[swaddr] <= swdata;
			DFF[0] <= 0;
		end
	end

endmodule
