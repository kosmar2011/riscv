module InstructionMem #(
	
	parameter int numofinst = 120, // o arithmos ton entolon
	parameter int Data_cell = 8,
	parameter int DW    = 32,            // Data Width
	parameter int WORDS = numofinst*4,   // RAM Depth isos prepei diplasio
	// prepei na psakso posa addresses xriazome.
	parameter int ADDRW = $clog2(WORDS)  // Auto-Calculated Address Width
	
)(

	input logic [DW-1:0]PC,
	
	output logic [DW-1:0]Instruction

);

logic [Data_cell-1:0] mem [WORDS-1:0];

initial	$readmemh("test-hex.dat",mem);

always_comb
begin
	Instruction = {mem[PC+0],mem[PC+1],mem[PC+2],mem[PC+3]};
end

endmodule