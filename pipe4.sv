module pipe4(

	input logic  clk, 
	input logic  rst,
	
	
	input logic [31:0]ReadDataPipeIn,
	input logic [31:0]ALUOutPipeIn,
	input logic RegWriteOutPipeIn,
	input logic MemToRegOutPipeIn,
	input logic [4:0]WriteRegOutPipeIn,
	
	output logic [31:0]ReadDataPipeOut,
	output logic [31:0]ALUOutPipeOut,
	output logic RegWriteOutPipeOut,
	output logic MemToRegOutPipeOut,
	output logic [4:0]WriteRegOutPipeOut

);


always_ff@(posedge clk) begin 
	if(~rst) begin 
		ReadDataPipeOut    <= 0;
		ALUOutPipeOut      <= 0;
		RegWriteOutPipeOut <= 0;
		MemToRegOutPipeOut <= 0;
		WriteRegOutPipeOut <= 0;
		
		
	end else begin 
		
		ReadDataPipeOut    <= ReadDataPipeIn;
		ALUOutPipeOut      <= ALUOutPipeIn;
		RegWriteOutPipeOut <= RegWriteOutPipeIn;
		MemToRegOutPipeOut <= MemToRegOutPipeIn;
		WriteRegOutPipeOut <= WriteRegOutPipeIn;
		
	end
end

endmodule