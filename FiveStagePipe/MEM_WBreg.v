`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:09:05 02/18/2019 
// Design Name: 
// Module Name:    MEM_WBreg 
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
module MEM_WBreg(
    input [4:0] MEM_WReg1,
	 input [63:0] MEM_ALUoutput,
	 input [1:0] MEM_WB_CTRL,

	 output [4:0]WB_WReg1,
	 output [63:0]WB_ALUoutput,
	 output [1:0]WB_WB_CTRL,
	 
    input clk,
	 input reset
    );
	 
	reg [4:0] WReg1;
	reg [63:0]ALUoutput;
	reg [1:0]WB_CTRL;
	
	assign WB_WReg1 = WReg1;
	assign WB_ALUoutput = ALUoutput;
	assign WB_WB_CTRL = WB_CTRL;
	
	always @(posedge clk,negedge reset)
	begin
		if(!reset)
		begin
			WReg1 <= 0;
			ALUoutput <= 0;
			WB_CTRL <= 0;
		end
		else
		begin
			WReg1 <= MEM_WReg1;
			ALUoutput <= MEM_ALUoutput;
			WB_CTRL <= MEM_WB_CTRL;
		end
	end

endmodule
