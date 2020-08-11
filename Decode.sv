module Decode(

	input logic MuxControlEn,
	
	input logic clk,
	input logic rst,
	
	input logic [1:0] ForwardA,ForwardB,
	input logic [31:0] ForwardMemALU,ForwardWBALU, ForwardExeALU,
	
	
	input logic [31:0]PCin,
	input logic [31:0]Instruction,
	input logic [31:0]WriteData,
	input logic RegWrite,
	input logic [4:0]WriteRegIn,//logo pipeline mazi me writedata
	
	output logic [31:0]Reg1Data,
	output logic [31:0]Reg2Data,
	output logic [31:0]PCout,
	output logic [31:0]ImmGenOut,
	output logic RegWriteOut,
	output logic NotZero,
	output logic ALUSrc1,
	output logic ALUSrc2,
	output logic [3:0] ALUCtr,
	output logic PCSrc,
	output logic MemWrite,
	output logic MemRead,
	output logic MemToReg,
	output logic J_inst_ctr,
	output logic [4:0]WriteRegOut,
	
	output logic [4:0]Reg1,
	output logic [4:0]Reg2
);  

logic HazardRs1,HazardRs2;
logic [2:0] DataType;
logic [31:0]ReadData1, ReadData2;


assign Reg1 = (HazardRs1) ? 0: Instruction[19:15];
assign Reg2 = (HazardRs2) ? 0: Instruction[24:20];

assign Reg1Data = 	(ForwardA==3) ? ForwardExeALU : 
					(ForwardA==2) ? ForwardMemALU :
					(ForwardA==1) ? ForwardWBALU  :
					ReadData1;
					
assign Reg2Data = 	(ForwardB==3) ? ForwardExeALU : 
					(ForwardB==2) ? ForwardMemALU :
					(ForwardB==1) ? ForwardWBALU  :
					ReadData2;

assign WriteRegOut = Instruction[11:7];
assign PCout = PCin;

registers registers_i(

	.clk(clk),
	.rst(rst),
	
	.rd_addr_i1(Instruction[19:15]),
	.rd_data_o1(ReadData1),
	
	.rd_addr_i2(Instruction[24:20]),
	.rd_data_o2(ReadData2),
	
	.wr_en_i(RegWrite), //apo to write back tha mpei
	.wr_addr_i(WriteRegIn),
	.wr_data_i(WriteData)

);

CONTROL CONTROL_i(

	.MuxControlEn(MuxControlEn),



	.opcode(Instruction),
	
	.regWrite(RegWriteOut),
	.PCDataCtr(J_inst_ctr),
	.NotZero(NotZero),
	.ALUSrc1(ALUSrc1),
	.ALUSrc2(ALUSrc2),
	.ALUCtr(ALUCtr),
	.PCSrc(PCSrc),
	.MemWrite(MemWrite),
	.MemRead(MemRead),
	.MemToReg(MemToReg),
	.DataType(DataType),
	.HazardRs1(HazardRs1),
	.HazardRs2(HazardRs2)

);

ImmGen ImmGen_i(

	.clk(clk), 
	.imm_data(Instruction),
	.data_type(DataType),
	
	.imm_command(ImmGenOut)

);

endmodule 