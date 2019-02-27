`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:00:46 02/18/2019 
// Design Name: 
// Module Name:    ID_EXreg 
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
module ID_EXreg(
    input [63:0] ID_R1out,
    input [63:0] ID_R2out,
    input [4:0] ID_WReg1,
	 input [4:0] ID_rs2,
	 input [5:0]ID_EX_CTRL,
	 input [3:0]ID_MEM_CTRL,
	 input [1:0]ID_WB_CTRL,
	 input [11:0]ID_IMM,
	 
    output [63:0] EX_R1out,
    output [63:0] EX_R2out,
    output [4:0] EX_WReg1,
	 output [4:0] EX_rs2,
	 output [5:0]EX_EX_CTRL,
	 output [3:0]EX_MEM_CTRL,
	 output [1:0]EX_WB_CTRL,
	 output [11:0]EX_IMM,
	 
    input clk,
	 input reset
    );
	reg [63:0]R1out;
	reg [63:0]R2out;
	reg [4:0]WReg1;
	reg [4:0]rs2;
	reg [5:0]EX_CTRL;
	reg [3:0]MEM_CTRL;
	reg [1:0]WB_CTRL;
	reg [11:0]IMM;
	
	assign EX_R1out = R1out;
	assign EX_R2out = R2out;
	assign EX_WReg1 = WReg1;
	assign EX_rs2 = rs2;
	assign EX_EX_CTRL = EX_CTRL;
	assign EX_MEM_CTRL = MEM_CTRL;
	assign EX_WB_CTRL = WB_CTRL;
	assign EX_IMM = IMM;
	
	always @(posedge clk,negedge reset)
	begin
		if(!reset)
		begin
			R1out <= 0;
			R2out <= 0;
			WReg1 <= 0;
			rs2 <= 0;
			EX_CTRL <= 0;
			MEM_CTRL <= 0;
			WB_CTRL <= 0;
			IMM <= 0;
		end
		else
		begin
			R1out <= ID_R1out;
			R2out <= ID_R2out;
			WReg1 <= ID_WReg1;
			rs2 <= ID_rs2;
			EX_CTRL <= ID_EX_CTRL;
			MEM_CTRL <= ID_MEM_CTRL;
			WB_CTRL <= ID_WB_CTRL;
			IMM <= ID_IMM;
		end
	end

endmodule
