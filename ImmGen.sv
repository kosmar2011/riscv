module ImmGen (
	input logic clk, 
	input logic [31:0]imm_data,
	input logic [2:0] data_type,
	output logic [31:0]imm_command
);

	
	always_comb begin
		case(data_type)
			0://I_imm
				begin 
					imm_command[0] = imm_data[20];
					imm_command[4:1] = imm_data[24:21];
					imm_command[10:5] =imm_data[30:25];
					imm_command[31:11] = imm_data[31];
				end
			1://S_imm
				begin 
					imm_command[0] = imm_data[7];
					imm_command[4:1] = imm_data[11:8];
					imm_command[10:5] =imm_data[30:25];
					imm_command[31:11] = imm_data[31];
				end 
			2://B_imm
				begin 
					imm_command[0] = 0;
					imm_command[4:1] = imm_data[11:8];
					imm_command[10:5] =imm_data[30:25];
					imm_command[11] = imm_data[7];
					imm_command[31:12] = imm_data[31];
				end
			3://U_imm
				begin 
					imm_command[11:0] = 0;
					imm_command[19:12] = imm_data[19:12];
					imm_command[30:20] =imm_data[30:20];
					imm_command[31] = imm_data[31];
				end 
			4://J_imm
				begin 
					imm_command[0] = 0;
					imm_command[4:1] = imm_data[24:21];
					imm_command[10:5] =imm_data[30:25];
					imm_command[11] = imm_data[20];
					imm_command[19:12] =imm_data[19:12];
					imm_command[31:20] =imm_data[31];
				end
			5://imm1 LUI kai AUIPC
				begin 
					imm_command[31:20] = 0;
					imm_command[19:0] = imm_data[31:12];
				end
			6://imm2 SRAI SRLI SLLI
				begin 
					imm_command[31:5] = 0;
					imm_command[4:0] = imm_data[24:20];
				end
			7: //error
				begin 
					imm_command = 0;
				end
		endcase
	end
endmodule