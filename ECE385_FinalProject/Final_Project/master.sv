module font_master ( input Clk, input[18:0] i,output[18:0] t);
	logic[18:0] m;
	assign m = i + 1;
	always_ff @(posedge Clk)
		begin:yoyo
			if (m == 400001)
				begin
					t <= 0;
				end
		else
		begin
			t <= m;
		end
	end
endmodule
