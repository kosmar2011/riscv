module WriteBack(

	input logic [31:0]ReadData,
	input logic [31:0]ALUIn,
	input logic RegWriteIn,
	input logic MemToRegIn,
	input logic [4:0]WriteRegIn,

	output logic RegWriteOut,
	output logic[4:0]WriteRegOut, 
	output logic[31:0] WriteData
	
);

assign RegWriteOut = RegWriteIn;
assign WriteRegOut = WriteRegIn;

assign WriteData = (MemToRegIn) ? ReadData : ALUIn;

endmodule