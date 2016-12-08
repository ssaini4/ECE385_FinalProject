module font_winner ( input Clk,
					input [7:0]keycode,
					 output [1:0] winner
					 );
				
				
		logic[1:0] p1value = 2'b00;
		logic[1:0] p2value = 2'b00;
					
		always_ff @ (posedge Clk)
		begin:compareLogic
		if (keycode == 24)
		begin
		p1value <= 2'b00;
		end
		if (keycode == 12)
		begin
		p1value <= 2'b01;
		end
		if (keycode == 18)
		begin
		p1value <= 2'b10;
		end
		if (keycode == 19)
		begin
		p1value <= 2'b11;
		end
		if (keycode == 11)
		begin
		p2value <= 2'b00;
		end
		if (keycode == 13)
		begin
		p2value <= 2'b01;
		end
		if (keycode == 14)
		begin
		p2value <= 2'b10;
		end
		if (keycode == 15)
		begin
		p2value <= 2'b11;
		end
		end
		
		always_ff @ (posedge Clk)
		begin:winnerDeclare
		if (p1value == p2value || p1value == 2'b11 || p2value == 2'b11)
		begin
		winner = 2'b11;
		end
		else if (((p1value == 2'b00) && (p2value == 2'b10)) || ((p1value == 2'b01) && (p2value == 2'b00)) || ((p1value == 2'b10) && (p2value == 2'b01)))
		begin
		winner = 2'b00;
		end
		else
		begin
		winner = 2'b01;
		end
		end
		
	
				
endmodule
