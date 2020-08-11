module DataPath_tb;

	parameter WIDTH = 2;
	logic clk, rst;
	
	
always begin //generate clock
	clk = 1;
	#50ns;
	clk = 0;
	#50ns;
end


DataPath DataPath_i(
	.clk (clk),
	.rst (rst)

);



initial begin

	rst <= 1;
	@(posedge clk); //First posedge occurred(10ns)
	rst <= 0;
	@(posedge clk); //Second posedge occurred(20ns)
	rst <= 1;
	
	@(posedge clk); //And so on...
	//rst <= 0;
	
	$display("Finished");

end
endmodule 