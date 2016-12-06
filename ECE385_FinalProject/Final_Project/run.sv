module font_run ( input [9:0] addr, output [7:0] data);
					 
parameter DATA_WIDTH = 8;

parameter [0:399][DATA_WIDTH-1:0] run = {8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h2b,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h1b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h6,8'h6,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,};
assign data = run[addr];

endmodule
