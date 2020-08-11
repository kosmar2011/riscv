module PC(

	input logic MuxControlEn,

	input logic clk,
	input logic rst,
	input logic PCSrc,
	input logic [31:0]NewPcAdd,
	
	output logic [31:0]PC
	
); 

logic [31:0] in_pcTemp,in_pc;
assign in_pcTemp = (PCSrc) ? NewPcAdd : PC + 4;
	
assign in_pc = (MuxControlEn) ? PC : in_pcTemp;	
	
	always_ff@(posedge clk) begin 
			if(~rst) PC <= 0;
			else PC <= in_pc;
	end

endmodule 