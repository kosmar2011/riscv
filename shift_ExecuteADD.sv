module shift_ExecuteADD #(

	parameter int DW = 32 

)
(
	input logic [DW-1:0] pcAdd,
	input logic [DW-1:0] ImmGen,
	output logic [DW-1:0] NewPcAdd
);

logic [DW-1:0] shiftLeft;
//assign shiftLeft = ImmGen << 1; // shiftLeft1


assign NewPcAdd = ImmGen + pcAdd;

endmodule