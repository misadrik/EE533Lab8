/*Control Unit - v2*/
/*v1: used to support R-type, lw, sw
v2: support branch 2/26
changes: 1. change branch control bit to 2 bit CU_Branch
2. Branch to immediate address. connect imme to pc addr
aka CU_MEM_CTRL {[3:2]CU_Branch,[1]CU_Jump,[0]CU_MemWrite};

11 no branch
00 Branch equal
01 Branch not equal
10 Branch less than

/*
Rtype
Instruction[31:25] Offset
Instruction[25:20] Rt
Instruction[19:15] Rs
Instruction[14:12] Funct3
Instruction[11:7] Rd
Instruction[6:0] OP
*/
module ControlUnit(Instr,CU_EX_CTRL,CU_MEM_CTRL,CU_WB_CTRL,CU_IMME,clk);
input clk;
input [31:0] Instr;
output [5:0] CU_EX_CTRL;
output [3:0] CU_MEM_CTRL;
output [1:0] CU_WB_CTRL;
output [11:0] CU_IMME;

reg[11:0] CU_IMM;

//EX_stage control signal - 6bit
reg CU_ALUSrc;
reg [3:0]CU_ALU_OP;
reg CU_RegDst;
//MEM_stage control signal - 3bit
reg [1:0] CU_Branch;
reg CU_Jump;
reg CU_MemWrite;
//WB_stage control signal 
reg CU_MemtoReg, CU_RegWrite;

//control unit control signal
wire[4:0] OP_CODE;
wire[2:0] Funct3;

assign OP_CODE = Instr[6:2];
assign Funct3 = Instr[14:12];

// output signal
assign CU_EX_CTRL = {CU_ALUSrc, CU_ALU_OP, CU_RegDst};

assign CU_MEM_CTRL = {CU_Branch,CU_Jump,CU_MemWrite};

assign CU_WB_CTRL = {CU_MemtoReg, CU_RegWrite};

assign CU_IMME = CU_IMM;

always @(*)

begin
  case(OP_CODE)
  5'b00000: //LW neglect Funct3, do load double
  begin
    CU_IMM = Instr[31:20];
    CU_ALUSrc = 1; //Rs+IMME
    CU_ALU_OP = 4'b0000; //ALU add
    CU_RegDst = 1;
    CU_MemWrite = 0;
    CU_Branch = 2'b11;
    CU_Jump = 0;
    CU_MemtoReg = 1; //ALU value
    CU_RegWrite = 1;

  end

  5'b01000: //SW neglect Funct3, do store double
  begin
    CU_IMM = {Instr[31:25], Instr[11:7]};
    CU_ALUSrc = 1; //Rs+IME    
    CU_ALU_OP = 4'b0000; //ALU add
    CU_RegDst = 0;
    CU_MemWrite = 1;
    CU_Branch = 2'b11;
    CU_Jump = 0;
    CU_MemtoReg = 0; //ALU value
    CU_RegWrite = 0;
  end

  5'b00100: //I-type ADDI
  begin
    CU_IMM = Instr[31:20];
    CU_ALUSrc = 1;
    CU_ALU_OP = 4'b0000; //ALU add
    CU_RegDst = 1;
    CU_MemWrite = 0;
    CU_Branch = 2'b11;
    CU_Jump = 0;
    CU_MemtoReg = 0; //ALU value
    CU_RegWrite = 1;
  end

  5'b01100://R_type
  begin
    CU_IMM = 12'b0000_0000_0000; 
    CU_ALUSrc = 0; //Rs+Rt
    CU_ALU_OP = {Instr[30],Instr[14:12]};
    CU_RegDst = 1;
    CU_MemWrite = 0;
    CU_Branch = 2'b11;
    CU_Jump = 0;
    CU_MemtoReg = 0; //ALU value
    CU_RegWrite = 1;
  end
  5'b01101:
  begin
    
  end

  5'b11000://BEQ BNE BLT
  begin
    CU_IMM = {Instr[31],Instr[7],Instr[10:5],Instr[11:8]};
    CU_ALUSrc = 0; //rs rt
    CU_ALU_OP = 4'b1000; //---
    CU_RegDst = 1; //---
    CU_MemWrite = 0;
    CU_Branch = {Instr[14],Instr[12]};
    CU_Jump = 0;
    CU_MemtoReg = 0; //ALU value
    CU_RegWrite = 0;
  end

  5'b11011://JUMP
  begin
  //only use lower 12 bit
    CU_IMM = {Instr[12],Instr[20],Instr[30:21]};// Instr[31],Instr[19:12],Instr[20],Instr[30:21]  [20:1]
    CU_ALUSrc = 1;
    CU_ALU_OP = 4'b0000;
    CU_RegDst = 1;
    CU_MemWrite = 0;
    CU_Branch = 2'b11;
    CU_Jump = 1;
    CU_MemtoReg = 0; //ALU value
    CU_RegWrite = 0;
  end

  default:
  begin
    CU_IMM = 12'b0000_0000_0000;// Instr[31],Instr[19:12],Instr[20],Instr[30:21]  [20:1]
    CU_ALUSrc = 1;
    CU_ALU_OP = 4'b0000;
    CU_RegDst = 1;
    CU_MemWrite = 0;
    CU_Branch = 2'b11;
    CU_Jump = 0;
    CU_MemtoReg = 0; //ALU value
    CU_RegWrite = 0;
  
  end

endcase

end
endmodule

