module pipe3(

	input logic  clk, 
	input logic  rst,


	input logic [31:0]ALUInPipeIn,
	input logic PCSrcInPipeIn,
	input logic [31:0]WriteData2InPipeIn,
	input logic [31:0]PCDataInPipeIn,
	input logic RegWriteInPipeIn,
	input logic MemReadInPipeIn,
	input logic MemWriteInPipeIn,
	input logic MemToRegInPipeIn,
	input logic [4:0]WriteRegInPipeIn,
	input logic ControlHazard,
	
	output logic [31:0]ALUInPipeOut,
	output logic PCSrcInPipeOut,
	output logic [31:0]WriteData2InPipeOut,
	output logic [31:0]PCDataInPipeOut,
	output logic RegWriteInPipeOut,
	output logic MemReadInPipeOut,
	output logic MemWriteInPipeOut,
	output logic MemToRegInPipeOut,
	output logic [4:0]WriteRegInPipeOut
);


always_ff@(posedge clk) begin 
	if(~rst) begin 
	
		ALUInPipeOut         <= 0;
		PCSrcInPipeOut       <= 0;
		WriteData2InPipeOut  <= 0;
		PCDataInPipeOut      <= 0;
		RegWriteInPipeOut    <= 0;
		MemReadInPipeOut     <= 0;
		MemWriteInPipeOut    <= 0;
		MemToRegInPipeOut    <= 0;
		WriteRegInPipeOut    <= 0;		
		
	end else begin 
	
		ALUInPipeOut         <= ALUInPipeIn;
		PCSrcInPipeOut       <= PCSrcInPipeIn;
		WriteData2InPipeOut  <= WriteData2InPipeIn;
		PCDataInPipeOut      <= PCDataInPipeIn;
		RegWriteInPipeOut    <= RegWriteInPipeIn;
		MemReadInPipeOut     <= MemReadInPipeIn;
		MemWriteInPipeOut    <= MemWriteInPipeIn;
		MemToRegInPipeOut    <= MemToRegInPipeIn;
		WriteRegInPipeOut    <= WriteRegInPipeIn;
		
	end
end



endmodule