module ALU #(

	parameter int WORDS = 32,
	parameter int CTRLBITS = 4

)(
	input logic [3:0] ALUctr,
	input logic [WORDS-1:0] A,B, PCin,
	input logic [WORDS-1:0] ImmGen,
	
	//einai to sima apo to control gia na di pio sima perni gia isodo i alu
	input logic ALUSrcA,
	input logic ALUSrcB,
	
	output logic [WORDS-1:0] ALUOut,
	output logic Zero
);

assign Zero = (ALUOut == 0); // to zero ginete 1 otan to apotelesma tis alu einai 0

logic [31:0]MUXAin;
logic [31:0]MUXBin;


// an to ALUSrc einai 1 tote mpeni to B allios to ImmGen
assign MUXBin = (ALUSrcB) ? ImmGen : B ;
assign MUXAin = (ALUSrcA) ? PCin : A ;//gia tin entoli AUIPC


always_comb  begin
	case(ALUctr)
		0: ALUOut = MUXAin + MUXBin;
		1: ALUOut = MUXAin - MUXBin;
		2: ALUOut = MUXAin & MUXBin;
		3: ALUOut = MUXAin | MUXBin;
		4: ALUOut = MUXAin ^ MUXBin;
	    5: ALUOut = ($signed(MUXAin) < $signed(MUXBin))? 1:0;
		6: ALUOut = (MUXAin < MUXBin) ? 1:0;
		7: ALUOut = ($signed(MUXAin)) >>> MUXBin[4:0];
		8: ALUOut = MUXAin >> MUXBin[4:0];
		9: ALUOut = MUXAin << MUXBin[4:0];
		10: ALUOut = $signed(MUXAin) * $signed(MUXBin);
		11: ALUOut = MUXBin << 12; // na to doume gia to shift 
		12: ALUOut = MUXAin + ( MUXBin << 12 );
		13: ALUOut = MUXAin + 4;
		
		//0: ALUOut = MUXAin;
		//0: ALUOut = MUXBin;
		//0: ALUOut = ~(MUXAin | MUXBin); // result is nor
		default: ALUOut = 0;
	endcase
end


endmodule