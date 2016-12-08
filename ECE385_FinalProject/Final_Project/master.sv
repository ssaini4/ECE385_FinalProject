module font_master ( input Clk, input[12:0] i,output[12:0] t);
	logic[12:0] m;
	assign m = i + 1;
	always_ff @(posedge Clk)
		begin:yoyo
			if (m == 5050)
		begin
			t <= 0;
		end
		else
		begin
			t <= m;
		end
	end
endmodule
