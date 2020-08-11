module MUX_ZERO(

	input logic Mux_ctr,
	input logic Zero,
	input logic Branch, // PCSrc apo controller
	output logic PCSrc

);

logic dump;
assign dump = (Mux_ctr)? ~Zero : Zero;

assign PCSrc = dump & Branch ;

endmodule