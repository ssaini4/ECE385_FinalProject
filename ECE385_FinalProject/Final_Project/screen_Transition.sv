module transition( output [1:0] screen, input [7:0]keycode, input Clk, input [1:0] curr_scene);

always_ff @(posedge Clk)
begin:Screen_transit
	if(keycode == 8'h28 && (curr_scene == 2'b00 || curr_scene == 2'b10))
		screen =2'b01;
end
endmodule
