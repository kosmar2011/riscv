module ForwardingUnit(
	input logic	RegWriteMemPipe, RegWriteWBPipe,RegWriteExePipe,
	input logic [4:0]Reg1Pipe, Reg2Pipe,
	input logic [4:0] WriteBackRegMemPipe,WriteBackRegWBPipe,WriteBackRegExePipe,
	
	output logic [1:0] ForwardA, ForwardB

);

always_comb 
begin 

	if (RegWriteExePipe & (WriteBackRegExePipe != 0) & (WriteBackRegExePipe == Reg1Pipe)) ForwardA = 3; 
	else if(RegWriteMemPipe & (WriteBackRegMemPipe != 0) & (WriteBackRegMemPipe == Reg1Pipe)) ForwardA = 2;
	else if(RegWriteWBPipe & (WriteBackRegWBPipe != 0) & (WriteBackRegWBPipe == Reg1Pipe)) ForwardA = 1;
	else ForwardA = 0;
	
	if (RegWriteExePipe & (WriteBackRegExePipe != 0) & (WriteBackRegExePipe == Reg2Pipe)) ForwardB = 3; 
	else if (RegWriteMemPipe & (WriteBackRegMemPipe != 0) & (WriteBackRegMemPipe == Reg2Pipe)) ForwardB = 2;
	else if (RegWriteWBPipe & (WriteBackRegWBPipe != 0) & (WriteBackRegWBPipe == Reg2Pipe)) ForwardB = 1;
	else ForwardB = 0;
end


endmodule