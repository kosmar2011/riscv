module HazardDetection(

	input logic clk, rst,
	input logic MemReadExePipe, 
	input logic [4:0]Reg1, Reg2, WriteBackRegExePipe,
	input logic PCSrc,
	
	output logic MuxControlEn
	
);


always_comb 
begin 
	
	if (MemReadExePipe & ((WriteBackRegExePipe == Reg1) | (WriteBackRegExePipe == Reg2))) MuxControlEn = 1; 
	else MuxControlEn = 0;

end


endmodule