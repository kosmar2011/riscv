module Execute(

	
	
	input logic [31:0]ReadData1in,
	input logic [31:0]ReadData2in,
	input logic [31:0]PCin,
	input logic [31:0]ImmGen,
	input logic RegWriteIn,
	input logic NotZero,
	input logic ALUSrc1,
	input logic ALUSrc2,
	input logic [3:0] ALUCtr,
	input logic PCSrcIn,
	input logic MemWriteIn,
	input logic MemReadIn,
	input logic MemToRegIn,
	input logic J_inst_ctr,
	input logic [4:0]WriteRegIn,
	
	output logic [31:0]ALUOut,
	output logic PCSrcOut,
	output logic [31:0]ReadData2out,
	output logic [31:0]PCDataOut,
	output logic RegWriteOut,
	output logic MemReadOut,
	output logic MemWriteOut,
	output logic MemToRegOut,
	output logic [4:0]WriteRegOut

);


assign WriteRegOut = WriteRegIn;

assign MemToRegOut = MemToRegIn;
assign MemWriteOut = MemWriteIn;
assign MemReadOut = MemReadIn;

assign RegWriteOut = RegWriteIn;
assign ReadData2out = ReadData2in;

logic ZeroOut;

ALU ALU_i(
	.ALUctr(ALUCtr),
	.A(ReadData1in),
	.B(ReadData2in),
	.PCin(PCin),
	.ImmGen(ImmGen),
	.ALUSrcA(ALUSrc1),
	.ALUSrcB(ALUSrc2),
	
	.ALUOut(ALUOut),
	.Zero(ZeroOut)

);

logic [31:0]NewPcAdd;
logic [31:0]PCJIn;

assign PCDataOut = (J_inst_ctr)? PCJIn : NewPcAdd; //epipleon poliplektis gia tis entoles J


shift_ExecuteADD shift_ExecuteADD_i(

	.pcAdd(PCin),
	.ImmGen(ImmGen),
	
	.NewPcAdd(NewPcAdd)

);


J_inst_module J_inst_module_i(

	.imm(ImmGen),
	.rs1(ReadData1in),
	
	.PCJIn(PCJIn)

);

MUX_ZERO MUX_ZERO_i(

	.Mux_ctr(NotZero),
	.Zero(ZeroOut),
	.Branch(PCSrcIn),
	
	.PCSrc(PCSrcOut)
);

endmodule