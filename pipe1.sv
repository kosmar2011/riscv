module pipe1(

	input logic MuxControlEn,
	
	input logic  clk, 
	input logic  rst,
	
	input logic  [31:0]PCDec,
	input logic  [31:0]Instruction,
	input logic ControlHazard,

	output logic [31:0]PCDecPipe,
	output logic [31:0]InstructionPipe
);

always_ff@(posedge clk) begin 
	if(~rst | ControlHazard) begin
		InstructionPipe <= 0;
		PCDecPipe <= 0;
	end else if (MuxControlEn) begin
		PCDecPipe <= PCDecPipe;
		InstructionPipe <= InstructionPipe;
	end else begin
		PCDecPipe <= PCDec;
		InstructionPipe <= Instruction;
	end
end


endmodule