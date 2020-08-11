module CPU(

	input logic clk,
	input logic rst,
	input logic [31:0] Instruction,
	input logic [31:0] ReadDataIn,
	
	output logic [31:0] PC,	
	output logic [31:0] WriteData2Out,
	output logic MemWriteOut,
	output logic MemReadOut,
	output logic [31:0]ALUOut
);

logic MuxControlEn;

logic [31:0]PCDataMem, PCDataFetch, PCExe, PCDec;
logic [31:0]Inst, ImmGen;
logic [31:0]ReadDataOut, ReadData1;
logic [31:0]ReadData2Exe, ReadData2Mem;
logic [31:0]ALUOutMem;
logic [4:0]WriteBackRegDec,WriteBackRegExe,WriteBackRegMem,WriteBackRegWB;
logic [3:0]ALUCtr;
logic ALUSrc1, ALUSrc2;
logic NotZero;
logic RegWriteExe, RegWriteMem, RegWriteWB, RegWriteDec;
logic PCSrcDec,PCSrcExe,PCSrcMem;
logic MemWriteExe, MemWriteMem;
logic MemReadExe, MemReadMem;
logic MemToRegExe, MemToRegMem, MemToRegWB; 
logic J_inst_ctr;
logic [31:0]WriteData;
logic [4:0]Reg1,Reg2;

logic [31:0]PCDecPipe, PCExePipe, PCDataMemPipe;
logic [31:0]InstPipe, ImmGenPipe;
logic [31:0]ReadData1Pipe, ReadDataPipe;
logic [31:0]ReadData2ExePipe, ReadData2MemPipe; 
logic [31:0]ALUOutMemPipe, ALUOutWBPipe;
logic [4:0]WriteBackRegExePipe, WriteBackRegMemPipe, WriteBackRegWBPipe;
logic [3:0]ALUCtrPipe;
logic ALUSrc1Pipe, ALUSrc2Pipe;
logic NotZeroPipe;
logic RegWriteExePipe, RegWriteMemPipe, RegWriteWBPipe;
logic PCSrcDecPipe, PCSrcExePipe;
logic MemWriteMemPipe, MemWriteExePipe;
logic MemReadMemPipe, MemReadExePipe;
logic MemToRegWBPipe, MemToRegMemPipe, MemToRegExePipe;
logic J_inst_ctrPipe;
logic [4:0]Reg1Pipe, Reg2Pipe;
logic [1:0]ForwardA, ForwardB;
logic ControlHazard;


ForwardingUnit ForwardingUnit_i(

	.RegWriteMemPipe(RegWriteMemPipe), 
	.RegWriteWBPipe(RegWriteWBPipe),
	.RegWriteExePipe(RegWriteExePipe),
	.Reg1Pipe(Reg1), 
	.Reg2Pipe(Reg2),
	.WriteBackRegMemPipe(WriteBackRegMemPipe),
	.WriteBackRegWBPipe(WriteBackRegWBPipe),
	.WriteBackRegExePipe(WriteBackRegExePipe),
	
	.ForwardA(ForwardA), 
	.ForwardB(ForwardB)

);

HazardDetection HazardDetection_i(

	.clk(clk), 
	.rst(rst),

	.MemReadExePipe(MemReadExePipe), 
	.Reg1(Reg1),
	.Reg2(Reg2), 
	.WriteBackRegExePipe(WriteBackRegExePipe),
	.PCSrc(PCSrcDec),
	
	.MuxControlEn(MuxControlEn)
);


Fetch Fetch_i(
	
	.MuxControlEn(MuxControlEn),


	.clk(clk),
	.rst(rst),
    
	.NewPcAdd(PCDataFetch),
	.PCSrc(PCSrcMem),//controller
	
	.PC(PC)
);

pipe1 pipe1_i(

	.MuxControlEn(MuxControlEn),

	.clk(clk),
	.rst(rst),
	
	.PCDec(PC),
	.Instruction(Instruction),
	.ControlHazard(PCSrcExe | PCSrcExePipe),
	
	.PCDecPipe(PCDecPipe),
	.InstructionPipe(InstPipe)

);

Decode Decode_i(

	.MuxControlEn(MuxControlEn),



	.clk(clk),
	.rst(rst),
	
	.ForwardB(ForwardB),
	.ForwardA(ForwardA),
	.ForwardWBALU(WriteData),
	.ForwardMemALU(ALUOutMemPipe),
	.ForwardExeALU(ALUOutMem),
	
	
	.PCin(PCDecPipe),
	.Instruction(InstPipe),
	.WriteData(WriteData),
	.RegWrite(RegWriteDec),
	.WriteRegIn(WriteBackRegDec),    //logo pipeline mazi me writedata
	
	.Reg1Data(ReadData1),
	.Reg2Data(ReadData2Exe),
	.PCout(PCExe),
	.ImmGenOut(ImmGen),
	.RegWriteOut(RegWriteExe),
	.NotZero(NotZero),
	.ALUSrc1(ALUSrc1),
	.ALUSrc2(ALUSrc2),
	.ALUCtr(ALUCtr),
	.PCSrc(PCSrcDec),
	.MemWrite(MemWriteExe),
	.MemRead(MemReadExe),
	.MemToReg(MemToRegExe),
	.J_inst_ctr(J_inst_ctr),
	.WriteRegOut(WriteBackRegExe),
	.Reg1(Reg1),
	.Reg2(Reg2)
);


pipe2 pipe2_i(

	.clk(clk),
	.rst(rst),
	
	
	.ReadData1inPipeIn(ReadData1),
	.ReadData2inPipeIn(ReadData2Exe),
	.PCinPipeIn(PCExe),
	.ImmGenPipeIn(ImmGen),
	.RegWriteInPipeIn(RegWriteExe),
	.NotZeroPipeIn(NotZero),
	.ALUSrc1PipeIn(ALUSrc1),
	.ALUSrc2PipeIn(ALUSrc2),
	.ALUCtrPipeIn(ALUCtr),
	.PCSrcInPipeIn(PCSrcDec),
	.MemWriteInPipeIn(MemWriteExe),
	.MemReadInPipeIn(MemReadExe),
	.MemToRegInPipeIn(MemToRegExe),
	.J_inst_ctrPipeIn(J_inst_ctr),
	.WriteRegInPipeIn(WriteBackRegExe),
	.ControlHazard(PCSrcExe),
	
	
	
	
	.ReadData1inPipeOut(ReadData1Pipe),
	.ReadData2inPipeOut(ReadData2ExePipe),
	.PCinPipeOut(PCExePipe),
	.ImmGenPipeOut(ImmGenPipe),
	.RegWriteInPipeOut(RegWriteExePipe),
	.NotZeroPipeOut(NotZeroPipe),
	.ALUSrc1PipeOut(ALUSrc1Pipe),
	.ALUSrc2PipeOut(ALUSrc2Pipe),
	.ALUCtrPipeOut(ALUCtrPipe),
	.PCSrcInPipeOut(PCSrcDecPipe),
	.MemWriteInPipeOut(MemWriteExePipe),
	.MemReadInPipeOut(MemReadExePipe),
	.MemToRegInPipeOut(MemToRegExePipe),
    .J_inst_ctrPipeOut(J_inst_ctrPipe),
    .WriteRegInPipeOut(WriteBackRegExePipe)
	
);

Execute Execute_i(

	
	
	
	.ReadData1in(ReadData1Pipe),
	.ReadData2in(ReadData2ExePipe),
	.PCin(PCExePipe),
	.ImmGen(ImmGenPipe),
	.RegWriteIn(RegWriteExePipe),
	.NotZero(NotZeroPipe),
	.ALUSrc1(ALUSrc1Pipe),
	.ALUSrc2(ALUSrc2Pipe),
	.ALUCtr(ALUCtrPipe),
	.PCSrcIn(PCSrcDecPipe),
	.MemWriteIn(MemWriteExePipe),
	.MemReadIn(MemReadExePipe),
	.MemToRegIn(MemToRegExePipe),
	.J_inst_ctr(J_inst_ctrPipe),
	.WriteRegIn(WriteBackRegExePipe),
	
	
	.ALUOut(ALUOutMem),
	.PCSrcOut(PCSrcExe),
	.ReadData2out(ReadData2Mem),
	.PCDataOut(PCDataMem),
	.RegWriteOut(RegWriteMem),
	.MemReadOut(MemReadMem),
	.MemWriteOut(MemWriteMem),
	.MemToRegOut(MemToRegMem),
	.WriteRegOut(WriteBackRegMem)

);


pipe3 pipe3_i(

	.clk(clk), 
	.rst(rst),
	
	
	.ALUInPipeIn(ALUOutMem),
	.PCSrcInPipeIn(PCSrcExe),
	.WriteData2InPipeIn(ReadData2Mem),
	.PCDataInPipeIn(PCDataMem),
	.RegWriteInPipeIn(RegWriteMem),
	.MemReadInPipeIn(MemReadMem),
	.MemWriteInPipeIn(MemWriteMem),
	.MemToRegInPipeIn(MemToRegMem),
	.WriteRegInPipeIn(WriteBackRegMem),
	.ControlHazard(PCSrcExe),
	
	
	
	
	.ALUInPipeOut(ALUOutMemPipe),
	.PCSrcInPipeOut(PCSrcExePipe),
	.WriteData2InPipeOut(ReadData2MemPipe),
	.PCDataInPipeOut(PCDataMemPipe),
	.RegWriteInPipeOut(RegWriteMemPipe),
	.MemReadInPipeOut(MemReadMemPipe),
	.MemWriteInPipeOut(MemWriteMemPipe),
	.MemToRegInPipeOut(MemToRegMemPipe),
	.WriteRegInPipeOut(WriteBackRegMemPipe)

);

Memory Memory_i(
	
	.clk(clk),
	.rst(rst),
	
	.ALUIn(ALUOutMemPipe),
	.PCSrcIn(PCSrcExePipe),
	.WriteData2In(ReadData2MemPipe),
	.PCDataIn(PCDataMemPipe),
	.RegWriteIn(RegWriteMemPipe),
	.MemReadIn(MemReadMemPipe),
	.MemWriteIn(MemWriteMemPipe),
	.MemToRegIn(MemToRegMemPipe),
	.WriteRegIn(WriteBackRegMemPipe),
	.ReadDataIn(ReadDataIn),

	.ReadDataOut(ReadDataOut),
	.ALUOut(ALUOut),
	.PCSrcOut(PCSrcMem),
	.RegWriteOut(RegWriteWB),
	.MemToRegOut(MemToRegWB),
	.PCDataOut(PCDataFetch),
	.WriteRegOut(WriteBackRegWB),
	.WriteData2Out(WriteData2Out),
	.MemReadOut(MemReadOut),
	.MemWriteOut(MemWriteOut)
	
);

pipe4 pipe4_i(

	.clk(clk), 
    .rst(rst),
    
    .ReadDataPipeIn(ReadDataOut),
    .ALUOutPipeIn(ALUOut),
    .RegWriteOutPipeIn(RegWriteWB),
    .MemToRegOutPipeIn(MemToRegWB),
    .WriteRegOutPipeIn(WriteBackRegWB),
    
	
	
	
    .ReadDataPipeOut(ReadDataPipe),
    .ALUOutPipeOut(ALUOutWBPipe),
    .RegWriteOutPipeOut(RegWriteWBPipe),
    .MemToRegOutPipeOut(MemToRegWBPipe),
    .WriteRegOutPipeOut(WriteBackRegWBPipe)

);


WriteBack WriteBack_i(

	.ReadData(ReadDataPipe),
	.ALUIn(ALUOutWBPipe),
	.RegWriteIn(RegWriteWBPipe),
	.MemToRegIn(MemToRegWBPipe),
	.WriteRegIn(WriteBackRegWBPipe),
    
	.RegWriteOut(RegWriteDec),
	.WriteRegOut(WriteBackRegDec), 
	.WriteData(WriteData)
	
);

endmodule


module DataPath(

	input logic clk, rst
	
	
);

logic [31:0] Instruction, PC;
logic [31:0] ALUOut, WriteData2Out;
logic MemWriteOut,MemReadOut;
logic [31:0] ReadData;
logic kb1, kb2,kb3;
logic falling_edge, rising_edge;

always_ff@(posedge clk) 
begin
	kb1 <=(~rst);
	kb2 <=kb1;
	kb3 <=kb2;
	falling_edge <= (kb3 && (~kb2));
	rising_edge <= (kb2 && (~kb3));
end


CPU CPU_i(

	.clk(clk),
	.rst(~rising_edge),
	.Instruction(Instruction),
	.ReadDataIn(ReadData),
	
	.PC(PC),
	.WriteData2Out(WriteData2Out),
	.MemWriteOut(MemWriteOut),
	.MemReadOut(MemReadOut),
	.ALUOut(ALUOut)

);

InstructionMem InstructionMem_i(

	.PC(PC),
	
	.Instruction(Instruction)

);

DataMemory DataMemory_i(

	.clk(clk),
	.rst(~rising_edge),
	
	.ALUOut(ALUOut),
	.B(WriteData2Out),
	.MemWrite(MemWriteOut),
	.MemRead(MemReadOut),
		
	.ReadData(ReadData)

);

endmodule

