module Memory(
	
	input logic clk,
	input logic rst,
	
	input logic [31:0]ALUIn,
	input logic PCSrcIn,
	input logic [31:0]WriteData2In,
	input logic [31:0]PCDataIn,
	input logic RegWriteIn,
	input logic MemReadIn,
	input logic MemWriteIn,
	input logic MemToRegIn,
	input logic [4:0]WriteRegIn,
	input logic [31:0]ReadDataIn,

	output logic [31:0]ReadDataOut,
	output logic [31:0]ALUOut,
	output logic PCSrcOut,
	output logic RegWriteOut,
	output logic MemToRegOut,
	output logic [31:0]PCDataOut,
	output logic [4:0]WriteRegOut,
	output logic [31:0]WriteData2Out,
	output logic MemReadOut,
	output logic MemWriteOut
	

);

assign MemToRegOut = MemToRegIn;
assign RegWriteOut = RegWriteIn;//ctr gia to reg 
assign WriteRegOut = WriteRegIn;//[address]register pou grafete to data
assign PCDataOut = PCDataIn;
assign PCSrcOut = PCSrcIn;
assign ALUOut = ALUIn;
assign WriteData2Out = WriteData2In;
assign MemReadOut = MemReadIn;
assign MemWriteOut = MemWriteIn;
assign ReadDataOut = ReadDataIn;

endmodule 