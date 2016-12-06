module font_paper ( input [9:0] addr, output [7:0] data);
					 
parameter DATA_WIDTH = 8;

parameter [0:399][DATA_WIDTH-1:0] paper = {8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h1b,8'h1b,8'h1b,8'h1b,8'h1b,8'h1b,8'h1b,8'h1a,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h2b,8'h16,8'h21,8'h1b,8'h1b,8'h21,8'h1b,8'h21,8'h1b,8'h1b,8'h21,8'h1b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h1b,8'h1a,8'h1b,8'h21,8'h1b,8'h21,8'h1b,8'h21,8'h1b,8'h2b,8'h1b,8'h1a,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h21,8'h21,8'h1a,8'h1a,8'h1b,8'h21,8'h21,8'h21,8'h21,8'h1a,8'h2b,8'h1b,8'h1b,8'h2b,8'h1a,8'h2b,8'h2b,8'h2b,8'h1a,8'h1b,8'h1b,8'h1b,8'h1b,8'h1b,8'h1a,8'h1a,8'h1a,8'h1a,8'h1a,8'h16,8'h1b,8'h21,8'h1b,8'h2b,8'h1a,8'h2b,8'h2b,8'h2b,8'h1a,8'h1b,8'h1b,8'h21,8'h16,8'h16,8'h1b,8'h1b,8'h1b,8'h1b,8'h1b,8'h1b,8'h16,8'h21,8'h1b,8'h2b,8'h1a,8'h2b,8'h1a,8'h2b,8'h1b,8'h1b,8'h1b,8'h21,8'h1a,8'h1a,8'h1f,8'h2b,8'h1f,8'h2b,8'h1f,8'h16,8'h1a,8'h21,8'h1b,8'h2b,8'h1a,8'h1a,8'h2b,8'h2b,8'h1b,8'h1a,8'h1b,8'h1b,8'h2b,8'h1a,8'h1a,8'h1a,8'h1a,8'h1a,8'h1a,8'h1a,8'h1a,8'h1b,8'h1b,8'h2b,8'h1a,8'h2b,8'h2b,8'h1b,8'h1b,8'h2b,8'h1b,8'h1b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h1a,8'h1b,8'h1b,8'h2b,8'h1a,8'h1b,8'h21,8'h1b,8'h2b,8'h1a,8'h1b,8'h1b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h1a,8'h1b,8'h1b,8'h2b,8'h1a,8'h21,8'h1a,8'h2b,8'h2b,8'h2b,8'h1b,8'h1b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h1a,8'h1b,8'h1b,8'h2b,8'h1a,8'h16,8'h1b,8'h1a,8'h2b,8'h2b,8'h1b,8'h1b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h1a,8'h1b,8'h1b,8'h2b,8'h1a,8'h1a,8'h1b,8'h2b,8'h1a,8'h2b,8'h1b,8'h1b,8'h2b,8'h1a,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h1a,8'h1b,8'h1b,8'h2b,8'h1a,8'h1a,8'h21,8'h1a,8'h1a,8'h1a,8'h21,8'h1b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h21,8'h1a,8'h2b,8'h2b,8'h2b,8'h1b,8'h1b,8'h2b,8'h1b,8'h16,8'h1b,8'h21,8'h1a,8'h1a,8'h2b,8'h2b,8'h2b,8'h1a,8'h16,8'h21,8'h16,8'h2b,8'h2b,8'h2b,8'h2b,8'h16,8'h1b,8'h2b,8'h1b,8'h1a,8'h2b,8'h1a,8'h1b,8'h21,8'h21,8'h21,8'h21,8'h21,8'h1b,8'h1a,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h1b,8'h1a,8'h1b,8'h1a,8'h1a,8'h2b,8'h2b,8'h1a,8'h1a,8'h1a,8'h1a,8'h1a,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1b,8'h1b,8'h1b,8'h1a,8'h2b,8'h2b,8'h2b,8'h1a,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h1a,8'h21,8'h1a,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b,8'h2b
};
assign data = paper[addr];

endmodule
