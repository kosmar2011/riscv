module DataMemory #(
  parameter int Data_cell = 8,
  parameter int DW    = 32,            // Data Width
  parameter int WORDS = 32,//1048576,            // RAM Depth isos prepei diplasio
  // prepei na psakso posa addresses xriazome.
  parameter int ADDRW = 32//$clog2(WORDS)  // Auto-Calculated Address Width
)(
	input logic clk,
	input logic rst,
	
	// tha gini Address kai tha paei ston epomeno Mux Write Back
	input logic [ADDRW-1:0] ALUOut,
	// tha einai ta WriteData
	input logic [DW-1:0] B,
	
	//dio simata gia read kai write apo to controll
	input logic MemWrite,
	input logic MemRead,
	
	output logic [DW-1:0] ReadData

);

logic[Data_cell-1:0] mem[0:WORDS-1];

always_comb begin
	if (MemRead) ReadData = {mem[ALUOut+3],mem[ALUOut+2],mem[ALUOut+1],mem[ALUOut+0]};
	else ReadData = 0;
end
//assign rd_data_o = mem[rd_addr_i];

//little endian
integer j;
always_ff @(posedge clk) begin
	/*if (~rst) begin 
		for (j=0; j < WORDS; j=j+1) begin
          mem[j] <= 8'b00000000; //reset array
      end
	end
	else */if(MemWrite) begin
		mem[ALUOut+3] <= B[Data_cell*4-1:Data_cell*3];
		mem[ALUOut+2] <= B[Data_cell*3-1:Data_cell*2];
		mem[ALUOut+1] <= B[Data_cell*2-1:Data_cell*1];
		mem[ALUOut+0] <= B[Data_cell*1-1:Data_cell*0];
	end
end

endmodule