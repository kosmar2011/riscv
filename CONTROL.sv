module CONTROL(
	input logic MuxControlEn,


	input logic [31:0] opcode,
	
	output logic regWrite,
	
	output logic PCDataCtr,

	output logic NotZero,
	
	output logic ALUSrc1,
	output logic ALUSrc2,
	output logic [3:0]ALUCtr,
	
	output logic PCSrc,
	output logic MemWrite,
	output logic MemRead,
	output logic MemToReg,
	output logic [2:0]DataType,
	output logic HazardRs1, HazardRs2
);

typedef enum logic [5:0]{ADD, SUB, AND, OR, XOR, SLT, SLTU, SRA,
 SLL, MUL, ADDI, ANDI, ORI, XORI, SLTI, SLTIU, SRAI, SRLI, SRL,
 SLLI, LUI, AUIPC, LW, SW, JAL, JALR, BEQ, BNE, BLT,
 BGE, BLTU, BGEU, nop, ERROR
} state;

state op;

always_comb
begin
	if (MuxControlEn) begin
		op = nop;
	end
	else begin
		if (opcode[6:0] == 51) begin
			if (opcode[14:12] == 0) begin
				if (opcode[31:25] == 0) op = ADD;
				else if (opcode[31:25] == 32) op = SUB;
				else if (opcode[31:25] == 1) op = MUL;
				else op = ERROR;
			end
			else if (opcode[14:12] == 1) op = SLL;
			else if (opcode[14:12] == 7) op = AND;
			else if (opcode[14:12] == 6) op = OR;
			else if (opcode[14:12] == 4) op = XOR;
			else if (opcode[14:12] == 2) op = SLT;
			else if (opcode[14:12] == 3) op = SLTU;
			else if (opcode[14:12] == 5) begin 
				if(opcode[30])	op = SRA;
				else op = SRL;
			end
			else op = ERROR;
		end	
		else if (opcode[6:0] == 3) op = LW;
		else if (opcode[6:0] == 35) op = SW;
		else if (opcode[6:0] == 111) op = JAL; 
		else if (opcode[6:0] == 55) op = LUI;
		else if (opcode[6:0] == 23) op = AUIPC;
		
		else if (opcode[6:0] == 103) op = JALR;
		
		else if (opcode[6:0] == 99) begin
			if (opcode[14:12] == 0) op = BEQ;
			else if (opcode[14:12] == 1) op = BNE;
			else if (opcode[14:12] == 4) op = BLT;
			else if (opcode[14:12] == 5) op = BGE;
			else if (opcode[14:12] == 6) op = BLTU;
			else if (opcode[14:12] == 7) op = BGEU;
			else op = ERROR;
		end
		
		else if (opcode [6:0] == 19) begin
				if (opcode[14:12] == 0) op = ADDI;
				else if (opcode[14:12] == 7) op = ANDI;
				else if (opcode[14:12] == 6) op = ORI;
				else if (opcode[14:12] == 4) op = XORI;
				else if (opcode[14:12] == 2) op = SLTI;
				else if (opcode[14:12] == 3) op = SLTIU;
				else if (opcode[14:12] == 1) op = SLLI;
				else if (opcode[14:12] == 5) begin 
					if (opcode[31:25] == 32) op = SRAI;
					else if (opcode[31:25] == 0) op = SRLI;
					else op = ERROR;
				end
				else op = ERROR;
		end
		else op = ERROR;
	end
end

always_comb 
begin 

	case(op)
		ADD: 	begin 
					HazardRs1 = 0; 
					HazardRs2 = 0; 
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 0;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		SUB: 	begin 
					HazardRs1 = 0; 
					HazardRs2 = 0; 
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 1;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		AND: 	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 2;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		OR:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 3;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		XOR:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 4;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		SLT:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 5;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		SLTU:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =0;
					PCDataCtr = 0; 
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 6;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		SRA:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 7;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		SRL:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 8;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		SLL:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 9;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		MUL:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 10;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		ADDI: 	begin 
					HazardRs1 = 0;
					HazardRs2 = 1;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 1;
					ALUCtr = 0;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		ANDI: 	begin 
					HazardRs1 = 0;
					HazardRs2 = 1;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 1;
					ALUCtr = 2;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		ORI:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 1;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 1;
					ALUCtr = 3;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		XORI:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 1;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 1;
					ALUCtr = 4;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		SLTI:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 1;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 1;
					ALUCtr = 5;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		SLTIU:  begin 
					HazardRs1 = 0;
					HazardRs2 = 1;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 1;
					ALUCtr = 6;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		SRAI:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 1;
					DataType =6;
					PCDataCtr = 0;
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 1;
					ALUCtr = 7;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		SRLI:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 1;
					DataType =6;
					PCDataCtr = 0;					
					NotZero = 0; 
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 1;
					ALUCtr = 8;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		SLLI:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 1;
					DataType =6;
					PCDataCtr = 0; 
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 1;
					ALUCtr = 9;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		LUI:  	begin 
					HazardRs1 = 1;
					HazardRs2 = 1;
					DataType =5;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 1;
					ALUSrc1 = 0; //X
					ALUSrc2 = 1;
					ALUCtr = 11;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		AUIPC:  begin 
					HazardRs1 = 1;
					HazardRs2 = 1;
					DataType =5;
					PCDataCtr = 0;
					NotZero = 0;
					regWrite = 1;
					ALUSrc1 = 1;
					ALUSrc2 = 1;
					ALUCtr = 12;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		LW:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 1;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 1;
					ALUSrc1 = 0;
					ALUSrc2 = 1;
					ALUCtr = 0;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 1;
					MemToReg = 1;
				end 
		SW:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =1;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 0;
					ALUSrc1 = 0;
					ALUSrc2 = 1;
					ALUCtr = 0;
					PCSrc = 0;
					MemWrite = 1;
					MemRead = 0;
					MemToReg = 0;
				end 
		JAL:  	begin 
					HazardRs1 = 1;
					HazardRs2 = 1;
					DataType =4;
					PCDataCtr = 0; //pigeni kai afti apo to add ton B
					NotZero = 1; 
					regWrite = 1;
					ALUSrc1 = 1;
					ALUSrc2 = 0; //X
					ALUCtr = 13;
					PCSrc = 1;
					MemWrite =0; 
					MemRead = 0;
					MemToReg = 0;
				end 
		JALR:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 1;
					DataType =0;
					PCDataCtr = 1; // h moni entoli pou xrisimopii to J_inst
					NotZero = 1; 
					regWrite = 1;
					ALUSrc1 = 1;
					ALUSrc2 = 0;
					ALUCtr = 13;
					PCSrc = 1;
					MemWrite =0; 
					MemRead = 0;
					MemToReg = 0;
				end 
		BEQ:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =2;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 0;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 1;
					PCSrc = 1;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		BNE:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =2;
					PCDataCtr = 0;
					NotZero = 1; 
					regWrite = 0;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 1;
					PCSrc = 1;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		BLT: 	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =2;
					PCDataCtr = 0;
					NotZero = 1;
					regWrite = 0;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 5;
					PCSrc = 1;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		BGE: 	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =2;
					PCDataCtr = 0; 
					NotZero = 0; 
					regWrite = 0;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 5;
					PCSrc = 1;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		BLTU:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =2;
					PCDataCtr = 0;
					NotZero = 1; 
					regWrite = 0;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 6;
					PCSrc = 1;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
				end 
		BGEU:  	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =2;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 0;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 6;
					PCSrc = 1;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
			  end 
		ERROR: 	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 0;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 0;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
			  end
		nop: 	begin 
					HazardRs1 = 0;
					HazardRs2 = 0;
					DataType =0;
					PCDataCtr = 0;
					NotZero = 0; 
					regWrite = 0;
					ALUSrc1 = 0;
					ALUSrc2 = 0;
					ALUCtr = 0;
					PCSrc = 0;
					MemWrite = 0;
					MemRead = 0;
					MemToReg = 0;
			  end 			  
	endcase
end
endmodule 