`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:06:58 02/18/2019 
// Design Name: 
// Module Name:    EX_MEMreg 
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
module EX_MEMreg(
    input [4:0] EX_WReg1,
	 input [63:0] EX_ALUoutput,
	 input [63:0] EX_R2out,
	 input [3:0] EX_MEM_CTRL,
	 input [1:0] EX_WB_CTRL,
	 input [8:0] EX_IMM,

    output [4:0] MEM_WReg1,
	 output [63:0] MEM_ALUoutput,
	 output [63:0]MEM_R2out,
	 output [3:0] MEM_MEM_CTRL,
	 output [1:0] MEM_WB_CTRL,
	 output [8:0] MEM_IMM,
	 
    input clk,
	 input reset
    );
	reg [4:0]WReg1;
	reg [63:0]ALUoutput;
	reg [63:0]R2out;
	reg [3:0]MEM_CTRL;
	reg [1:0]WB_CTRL;
	reg [8:0]IMM;
	
	assign MEM_WReg1 = WReg1;
	assign MEM_ALUoutput = ALUoutput;
	assign MEM_R2out = R2out;
	assign MEM_MEM_CTRL = MEM_CTRL;
	assign MEM_WB_CTRL = WB_CTRL;
	assign MEM_IMM = IMM;
	
	always @(posedge clk,negedge reset)
	begin
		if(!reset)
		begin
			WReg1 <= 0;
			ALUoutput <= 0;
			R2out <= 0;
			MEM_CTRL <= 0;
			WB_CTRL <= 0;
			IMM <= 0;
		end
		else
		begin
			WReg1 <= EX_WReg1;
			ALUoutput <= EX_ALUoutput;
			R2out <= EX_R2out;
			MEM_CTRL <= EX_MEM_CTRL;
			WB_CTRL <= EX_WB_CTRL;
			IMM <= EX_IMM;
		end
	end

endmodule
