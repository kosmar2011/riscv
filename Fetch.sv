module Fetch (

	input logic MuxControlEn,



	input logic clk,
	input logic rst,
	
	input logic [31:0] NewPcAdd,
	input logic PCSrc,//controller
	
	output logic [31:0] PC
	
);


PC PC_i(

	.MuxControlEn(MuxControlEn),
	
	
	
	.clk(clk),
	.rst(rst),
	
	.PCSrc(PCSrc),//controller
	
	.NewPcAdd(NewPcAdd),
	
	.PC(PC)
	 
);

endmodule