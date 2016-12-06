//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------




module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
								input Clk,
								input [7:0] keycode,
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on;
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
parameter [0:42][23:0] palette_hex = {24'h8DC43E,24'h83C141,24'h5BA344,24'h5DA344,24'h62A643,24'hFF0000,24'h2F0200,24'h3A0300,24'h4C0300,24'h5E3017,24'hA15622,24'h98531A,24'h97490C,24'h904709,24'h8E4008,24'h632300,24'h672600,24'h943908,24'hBD6116,24'h8C4505,24'h963C01, 24'hF83800, 24'hF0D0B0, 24'h503000, 24'hFFE0A8, 24'h0058F8, 24'hFCFCFC, 24'hBCBCBC, 24'hA40000, 24'hD82800, 24'hFC7460, 24'hFCBCB0, 24'hF0BC3C, 24'hAEACAE, 24'h363301, 24'h6C6C01, 24'hBBBD00, 24'h88D500, 24'h398802, 24'h65B0FF, 24'h155ED8, 24'h800080, 24'h24188A
};

    int DistX, DistY, Size;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = 20;
	logic player_on;
	logic screen;
	logic boulder_on;
	 logic[8:0] player_x = 300;
	 logic[8:0] player_y = 200;
	 logic[8:0] player_size_x = 14;
	 logic[8:0] player_size_y = 20;
	
	 logic [11:0] player_addr;
	 logic [23:0] player_data_24bit;
	 
	 logic[8:0] boulder_addr;
	 logic[7:0] boulder_data;
	 logic[8:0] grass_x = 200;
	 logic[8:0] grass_y = 200;
	 logic[8:0] grass_size_x = 20;
	 logic[8:0] grass_size_y = 20;
	 logic[8:0] grass_addr;
	 logic[7:0] grass_data;
	 
	 logic[8:0] poke_x = 200;
	 logic[8:0] poke_y = 200;
	 logic[8:0] poke_size_x = 30;
	 logic[8:0] poke_size_y = 30;
	 logic[8:0] poke_addr;
	 logic[23:0] poke_data;
	 
	 font_pokemon (.addr(poke_addr), .data(poke_data));				
	 assign screen = 1'b0;
	 
	 font_grass (.addr(grass_addr), .data(grass_data));
	 
	 font_player_image (.addr(player_addr), .data(player_data_24bit), .keycode(keycode[7:0]));
		
	 font_boulder (.addr(boulder_addr), .data(boulder_data));
	
	always_ff @(posedge Clk)
	begin:Game_scene
		if (scene == 2'b00)
		begin
		end
		else if (scene == 2'b01)
		begin
			if (DrawX >= BallX && DrawX < BallX + player_size_x && DrawY >= BallY && DrawY < BallY + player_size_y)
			begin
				player_on = 1'b1;
				player_addr = ((DrawY-BallY)*14 + DrawX-BallX+1);
				grass_addr = ((DrawY%grass_size_y*grass_size_y + Draw%grass_size_x) % 399);
			end
			else if ((DrawX >= 0 && DrawX < 400 && DrawY >= 60 && DrawY <79) || (DrawX >=500 && DrawX <640 && DrawY >=200 && DrawY <219)
						|| (DrawX>=0 && DrawX <300 && DrawY>= 300 && DrawY < 319) || (DrawX>=440&& DrawX<459 && DrawY >=340 && DrawY<399)
						|| (DrawX>=440 && DrawX< 640 && DrawY >=399 &&DrawY <419) 
						)
			begin
				boulder_on = 1'b1;
				boulder_addr = ((DrawY%400) + DrawX%20)%399;
				grass_addr = ((Draw%grass_size_y*grass_size_y + DrawX%grass_size_x)%399);
			end
			else
			begin
				player_on = 1'b0;
				boulder_on = 1'b0;
				player_addr = 9'b0;
				grass_addr = ((DrawY%grass_size_y*grass_size_y + DrawX%grass_size_x)%399);
			end
		end
		else if (scene == 2'b10)
		begin
			if (DrawX >= PokeAX && DrawX < PokeAX + pokemon_size_x && DrawY >= PokeAY && DrawY < PokeAY + pokemon_size_y)
			begin
				pokemonA_on = 1'b1;
				pokemonA_addr = ((DrawY%400) + DrawX%30)%899;
			end
			else if (DrawX >= PokeBX && DrawX < PokeBX + pokemon_size_x && DrawY >= PokeBY && DrawY < PokeBY + pokemon_size_y)
			begin
				pokemonB_on = 1'b1;
				pokemonB_addr = ((DrawY%400) + DrawX%30)%899;
			end
			else if (DrawX >=RockAX && DrawX < RockAX + rock_size_x && DrawY >= RockAY && DrawY < RockAY + rock_size_y)
			begin
				rock_on = 1'b1;
				rock_addr = ((DrawY%400) + DrawX%30)%899;
			end
			else if (DrawX >=RockBX && DrawX < RockBX + rock_size_x && DrawY >= RockBY && DrawY < RockBY + rock_size_y)
			begin
				rock_on = 1'b1;
				rock_addr = ((DrawY%400) + DrawX%30)%899;
			end
			
			else if (DrawX >=CutAX && DrawX < CutAX + cut_size_x && DrawY >= CutAY && DrawY < CutAY + rock_size_y)
			begin
				cut_on = 1'b1;
				cut_addr = ((DrawY%400) + DrawX%30)%899;
			end
			else if (DrawX >=CutBX && DrawX < CutBX + cut_size_x && DrawY >= CutBY && DrawY < CutBY + cut_size_y)
			begin
				cut_on = 1'b1;
				cut_addr = ((DrawY%400) + DrawX%30)%899;
			end
			
			else if (DrawX >=PaperAX && DrawX < PaperAX + paper_size_x && DrawY >= PaperAY && DrawY < PaperAY + paper_size_y)
			begin
				paper_on = 1'b1;
				paper_addr = ((DrawY%400) + DrawX%30)%899;
			end
			else if (DrawX >=PaperBX && DrawX < PaperBX + paper_size_x && DrawY >= PaperBY && DrawY < PaperBY + paper_size_y)
			begin
				paper_on = 1'b1;
				paper_addr = ((DrawY%400) + DrawX%30)%899;
			end
			else if (DrawX >=RunAX && DrawX < RunAX + run_size_x && DrawY >= RunAY && DrawY < RunAY + run_size_y)
			begin
				run_on = 1'b1;
				run_addr = ((DrawY%400) + DrawX%30)%899;
			end
			else if (DrawX >=RunBX && DrawX < RunBX + run_size_x && DrawY >= RunBY && DrawY < RunBY + run_size_y)
			begin
				run_on = 1'b1;
				run_addr = ((DrawY%400) + DrawX%30)%899;
			end
			else if (DrawX >=executeX && DrawX < executeX + execute_size_x && DrawY >=executeY && DrawY < executeY + execute_size_y)
			begin
				execute_on = 1'b1;
				execute = ((DrawY%400) + DrawX%30)%899;
			else
			begin
			end
		end
		else
		begin
		end
       
    always_ff @ (posedge Clk)
    begin:RGB_Display
		if (screen == 1'b1 && player_on == 1'b1 && player_data_24bit != 24'hff260 && player_data_24bit !=  24'hff00) 
        begin
            Red = player_data_24bit[23:16];
            Green =  player_data_24bit[15:8];
            Blue =  player_data_24bit[7:0];
        end       
		else if (screen == 1'b1 && boulder_on == 1'b1 && boulder_data !=  24'hff00) 
			begin
				Red = palette_hex[boulder_data][23:16];
            Green = palette_hex[boulder_data][15:8];
            Blue = palette_hex[boulder_data][7:0];
			end
		else if (screen == 1'b0)
        begin 
				Red = poke_data[23:16];
            Green = poke_data[15:8];
            Blue = poke_data[7:0];
        end
		else
		 begin
			Red = 0;
			Green = 0;
			Blue = 0;
		end
    end 
    
endmodule
