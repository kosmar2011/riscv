module J_inst_module #(

	parameter int Data_width    = 32

)(

	input logic [Data_width-1:0]imm,
	input logic [Data_width-1:0]rs1,
	
	output logic [Data_width-1:0]PCJIn

);

	logic [Data_width:0]PCJInDump;

	assign PCJInDump = (rs1 + imm) & 32'hfffffffe;
	assign PCJIn = PCJInDump[Data_width-1:0];
	

endmodule