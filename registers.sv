module registers #(
  parameter int DW    = 32,            
  parameter int WORDS = 32,            
  parameter int ADDRW = 5  
) ( 
  input  logic            clk, rst,
  
  input  logic[ADDRW-1:0] rd_addr_i1,
  output logic[DW-1:0]    rd_data_o1,
  
  input  logic[ADDRW-1:0] rd_addr_i2,
  output logic[DW-1:0]    rd_data_o2,
  
  input  logic            wr_en_i,
  input  logic[ADDRW-1:0] wr_addr_i,
  input  logic[DW-1:0]    wr_data_i
);
	
	logic[DW-1:0] mem[0:WORDS-1];
	//initial $readmemh("my_init.txt", mem);
	
	assign rd_data_o1 = mem[rd_addr_i1];
	assign rd_data_o2 = mem[rd_addr_i2];
	
	//assign mem[0] = 0;
	
	integer j;
	always_ff @(posedge clk) begin
		if (~rst) begin 
			for (j=0; j < WORDS; j=j+1) begin
            mem[j] <= 32'b0; //reset array
			end
		end else if(wr_en_i && wr_addr_i!=0) mem[wr_addr_i] <= wr_data_i;
		else mem[wr_addr_i] <= mem[wr_addr_i];
	end
	
endmodule