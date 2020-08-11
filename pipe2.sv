module pipe2(

	input logic  clk, 
	input logic  rst,
	
	input logic [31:0]ReadData1inPipeIn,
	input logic [31:0]ReadData2inPipeIn,
	input logic [31:0]PCinPipeIn,
	input logic [31:0]ImmGenPipeIn,
	input logic RegWriteInPipeIn,
	input logic NotZeroPipeIn,
	input logic ALUSrc1PipeIn,
	input logic ALUSrc2PipeIn,
	input logic [3:0] ALUCtrPipeIn,
	input logic PCSrcInPipeIn,
	input logic MemWriteInPipeIn,
	input logic MemReadInPipeIn,
	input logic MemToRegInPipeIn,
	input logic J_inst_ctrPipeIn,
	input logic [4:0]WriteRegInPipeIn,
	input logic ControlHazard,
	
	
	output logic [31:0]ReadData1inPipeOut, 
	output logic [31:0]ReadData2inPipeOut,
	output logic [31:0]PCinPipeOut,
	output logic [31:0]ImmGenPipeOut,
	output logic RegWriteInPipeOut,
	output logic NotZeroPipeOut,
	output logic ALUSrc1PipeOut,
	output logic ALUSrc2PipeOut,
	output logic [3:0] ALUCtrPipeOut,
	output logic PCSrcInPipeOut,
	output logic MemWriteInPipeOut,
	output logic MemReadInPipeOut,
	output logic MemToRegInPipeOut,
	output logic J_inst_ctrPipeOut,
	output logic [4:0]WriteRegInPipeOut

);


always_ff@(posedge clk) begin 
	if(~rst | ControlHazard) begin 
		
		
		ReadData1inPipeOut    <= 0;
		ReadData2inPipeOut    <= 0;
		PCinPipeOut           <= 0;
		ImmGenPipeOut         <= 0;
		RegWriteInPipeOut     <= 0;
		NotZeroPipeOut        <= 0;
		ALUSrc1PipeOut        <= 0;
		ALUSrc2PipeOut        <= 0;
		ALUCtrPipeOut         <= 0;
		PCSrcInPipeOut        <= 0;
		MemWriteInPipeOut     <= 0;
		MemReadInPipeOut      <= 0;
		MemToRegInPipeOut     <= 0;
		J_inst_ctrPipeOut     <= 0;
		WriteRegInPipeOut     <= 0;
		
		
	end else begin 
		
		
		ReadData1inPipeOut    <= ReadData1inPipeIn;
		ReadData2inPipeOut    <= ReadData2inPipeIn;
		PCinPipeOut           <= PCinPipeIn;
		ImmGenPipeOut         <= ImmGenPipeIn;
		RegWriteInPipeOut     <= RegWriteInPipeIn;
		NotZeroPipeOut        <= NotZeroPipeIn;
		ALUSrc1PipeOut        <= ALUSrc1PipeIn;
		ALUSrc2PipeOut        <= ALUSrc2PipeIn;
		ALUCtrPipeOut         <= ALUCtrPipeIn;
		PCSrcInPipeOut        <= PCSrcInPipeIn;
		MemWriteInPipeOut     <= MemWriteInPipeIn;
		MemReadInPipeOut      <= MemReadInPipeIn;
		MemToRegInPipeOut     <= MemToRegInPipeIn;
		J_inst_ctrPipeOut     <= J_inst_ctrPipeIn;
		WriteRegInPipeOut     <= WriteRegInPipeIn;		
		
	end
end



endmodule