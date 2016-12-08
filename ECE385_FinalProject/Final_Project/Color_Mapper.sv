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
parameter [0:43][23:0] palette_hex = {24'h8DC43E,24'h83C141,24'h5BA344,24'h5DA344,24'h62A643,24'hFF0000,24'h2F0200,24'h3A0300,24'h4C0300,24'h5E3017,24'hA15622,24'h98531A,24'h97490C,24'h904709,24'h8E4008,24'h632300,24'h672600,24'h943908,24'hBD6116,24'h8C4505,24'h963C01, 24'hF83800, 24'hF0D0B0, 24'h503000, 24'hFFE0A8, 24'h0058F8, 24'hFCFCFC, 24'hBCBCBC, 24'hA40000, 24'hD82800, 24'hFC7460, 24'hFCBCB0, 24'hF0BC3C, 24'hAEACAE, 24'h363301, 24'h6C6C01, 24'hBBBD00, 24'h88D500, 24'h398802, 24'h65B0FF, 24'h155ED8, 24'h800080, 24'h24188A,24'hFFFFFF
};


	logic player_on;
	logic[1:0] scene=2'b10;

	logic boulder_on;

	 logic[8:0] player_size_x = 14;
	 logic[8:0] player_size_y = 20;
	
	 logic [11:0] player_addr;
	 logic [23:0] player_data_24bit;
	 
	 logic[8:0] boulder_addr;
	 logic[7:0] boulder_data;

	 logic[8:0] grass_size_x = 20;
	 logic[8:0] grass_size_y = 20;
	 logic[8:0] grass_addr;
	 logic[7:0] grass_data;

	 logic[8:0] poke_addr;
	 logic[7:0] poke_data;
 	 logic[7:0] pokeB_data;

	 
	 
	 logic pokemonA_on;
	 logic pokemonB_on;
	 logic[8:0] pokemon_size_x = 30;
	 logic[8:0] pokemon_size_y = 30;
	 logic[8:0] pokemonA_addr;
	 logic[8:0] pokemonB_addr;
	 
	
	logic[9:0] RockAX, RockAY, RockBX, RockBY, PokeAX,PokeAY, PokeBX, PokeBY, paperAX, paperAY, paperBX, paperBY, cutAX, cutAY, cutBX, cutBY, runAX, runAY, runBX, runBY, executeX, executeY;
	logic[8:0] rock_size_x = 20;
	logic[8:0] rock_size_y = 20;
	logic[8:0] rock_addr;
	logic[7:0] rock_data;
	assign PokeAX = 90;
	assign PokeAY = 210;
	assign PokeBX = 510;
	assign PokeBY = 210;
	logic rock_on;
	assign RockAX = 200;
	assign RockAY = 100;
	assign RockBX = 400;
	assign RockBY = 100;
	
	logic[8:0] cut_size_x = 20;
	logic[8:0] cut_size_y = 20;
	logic[8:0] cut_addr;
	logic[7:0] cut_data;
	logic cut_on;
	assign cutAX = 200;
	assign cutAY = 200;
	assign cutBX = 400;
	assign cutBY = 200;
	
	logic[8:0] paper_size_x = 20;
	logic[8:0] paper_size_y = 20;
	logic[8:0] paper_addr;
	logic[7:0] paper_data;
	logic paper_on;
	assign paperAX = 200;
	assign paperAY = 300;
	assign paperBX = 400;
	assign paperBY = 300;
	
	logic[8:0] run_size_x = 20;
	logic[8:0] run_size_y = 20;
	logic[8:0] run_addr;
	logic[7:0] run_data;
	logic run_on;
	assign runAX = 200;
	assign runAY = 400;
	assign runBX = 400;
	assign runBY = 400;

	
	logic[8:0] execute_size_x = 60;
	logic[8:0] execute_size_y = 20;
	logic[11:0] execute_addr;
	logic[7:0] execute_data;
	logic execute_on;
	assign executeX = 280;
	assign executeY = 250;
	
	logic [18:0] start_addr;
	logic start_data;
	logic start_on;
	
	logic [1:0] winner = 2'b10;
	logic [9:0] i = 0;

	font_winner(.Clk(Clk),.keycode(keycode),.winner(winner));
	font_master(.Clk(Clk),.i(i),.t(i));
	font_rock (.addr(rock_addr), .data(rock_data));
	font_cut (.addr(cut_addr), .data(cut_data));
	font_paper (.addr(paper_addr), .data(paper_data));
	font_run (.addr(run_addr), .data(run_data));
	font_execute (.addr(execute_addr), .data(execute_data));
	font_pokeA (.addr(pokemonA_addr), .data(poke_data));	
	font_pokeB (.addr(pokemonB_addr), .data(pokeB_data));
	
	font_grass (.addr(grass_addr), .data(grass_data)); 
	font_player_image (.addr(player_addr), .data(player_data_24bit), .keycode(keycode[7:0]));
		
	font_boulder (.addr(boulder_addr), .data(boulder_data));
	font_start (.addr(start_addr), .data(start_data));
	

	always_ff @(posedge Clk)
	begin:Game_scene
		case (scene)
			2'b00:
					begin
						if( DrawX>= 100 && DrawX < 531 && DrawY >=80 && DrawY < 293)
						begin
							start_addr = ((DrawY-80)*431+(DrawX-100));
							start_on = 1'b1;
						end
						else
							start_on = 1'b0;
						if(keycode == 8'h28)
							scene = 2'b01;
					end
			
			2'b01:
				begin
					if (DrawX >= BallX && DrawX < BallX + player_size_x && DrawY >= BallY && DrawY < BallY + player_size_y)
					begin
						player_on = 1'b1;
						player_addr = ((DrawY-BallY)*14 + DrawX-BallX+1);
						grass_addr = ((DrawY%grass_size_y*grass_size_y + DrawX%grass_size_x) % 399);
					end
					else if ((DrawX >= 0 && DrawX < 400 && DrawY >= 60 && DrawY <79) || (DrawX >=500 && DrawX <640 && DrawY >=200 && DrawY <219)
								|| (DrawX>=0 && DrawX <300 && DrawY>= 300 && DrawY < 319) || (DrawX>=440&& DrawX<459 && DrawY >=340 && DrawY<399)
								|| (DrawX>=440 && DrawX< 640 && DrawY >=399 &&DrawY <419) 
								)
					begin
						boulder_on = 1'b1;
						boulder_addr = ((DrawY%20*20) + DrawX%20)%399;
						grass_addr = ((DrawY%grass_size_y*grass_size_y + DrawX%grass_size_x)%399);
					end
					else
					begin
						player_on = 1'b0;
						boulder_on = 1'b0;
						player_addr = 9'b0;
						grass_addr = ((DrawY%grass_size_y*grass_size_y + DrawX%grass_size_x)%399);
					end
				end
			2'b10:
				begin
						cut_on <= 1'b0;
						rock_on <= 1'b0;
						paper_on <= 1'b0;
						run_on <= 1'b0;
						execute_on <= 1'b0;
						pokemonA_on <= 1'b0;
						pokemonB_on <= 1'b0;
					if (DrawX >= PokeAX && DrawX < (PokeAX + pokemon_size_x )&& DrawY >= PokeAY && DrawY < (PokeAY + pokemon_size_y))
					begin
						pokemonA_on <= 1'b1;
						pokemonA_addr <= (DrawY%30)*30 + DrawX%30;
					end
					if (DrawX >= PokeBX && DrawX < (PokeBX + pokemon_size_x) && DrawY >= PokeBY && DrawY < (PokeBY + pokemon_size_y))
					begin
						pokemonB_on <= 1'b1;
						pokemonB_addr <= ((DrawY%30*30) + DrawX%20)%899;
					end
					if (DrawX >=RockAX && DrawX < (RockAX + rock_size_x) && DrawY >= RockAY && DrawY < (RockAY + rock_size_y))
					begin
						rock_on <= 1'b1;
						rock_addr <= ((DrawY-RockAY)*20 + (DrawX-RockAX));
					end
					if (DrawX >=RockBX && DrawX < (RockBX + rock_size_x) && DrawY >= RockBY && DrawY < (RockBY + rock_size_y))
					begin
						rock_on <= 1'b1;
						rock_addr <= ((DrawY-RockBY)*20 + (DrawX-RockBX));
					end
					
					if (DrawX >=cutAX && DrawX < (cutAX + cut_size_x) && DrawY >= cutAY && DrawY < (cutAY + rock_size_y))
					begin
						cut_on <= 1'b1;
						cut_addr <= ((DrawY-cutAY)*20 + (DrawX-cutAX));
					end
					if (DrawX >=cutBX && DrawX < (cutBX + cut_size_x) && DrawY >= cutBY && DrawY < (cutBY + cut_size_y))
					begin
						cut_on <= 1'b1;
						cut_addr <= ((DrawY-cutBY)*20 + (DrawX-cutBX));
					end
					
					if (DrawX >=paperAX && DrawX < (paperAX + paper_size_x) && DrawY >= paperAY && DrawY < (paperAY + paper_size_y))
					begin
						paper_on <= 1'b1;
						paper_addr <= ((DrawY-paperAY)*20 + DrawX-paperAX);
					end
					if (DrawX >=paperBX && DrawX < (paperBX + paper_size_x) && DrawY >= paperBY && DrawY < (paperBY + paper_size_y))
					begin
						paper_on <= 1'b1;
						paper_addr <= ((DrawY-paperBY)*20 + DrawX-paperBX);
					end
					if (DrawX >=runAX && DrawX < (runAX + run_size_x) && DrawY >= runAY && DrawY < (runAY + run_size_y))
					begin
						run_on <= 1'b1;
						run_addr <= (DrawY-runAY)*20 + DrawX-runAX;
					end
					if (DrawX >=runBX && DrawX < (runBX + run_size_x) && DrawY >= runBY && DrawY < (runBY + run_size_y))
					begin
						run_on <= 1'b1;
						run_addr <= (DrawY-runBY)*20 + DrawX-runBX;
					end
					if (DrawX >=executeX && DrawX < (executeX + execute_size_x )&& DrawY >=executeY && DrawY < (executeY + execute_size_y))
					begin
						execute_on <= 1'b1;
						execute_addr <= ((DrawY-executeY)*20 + DrawX-executeX);
					end
					if(keycode == 8'h28)
							scene = 2'b10;
				end	
	endcase
	case(keycode)
			8'h1e:
				scene = 2'b00;
			8'h1f:
				scene = 2'b01;
			8'h20:
				scene = 2'b10;
	endcase
	end
       
    always_ff @ (posedge Clk)
    begin:RGB_Display
		case(scene)
			2'b00:
					begin

							if(start_on==1'b1)
							begin
								if( start_data == 1'b0)
									begin
										Red <= 8'h00;
										Green <= 8'h00;
										Blue <= 8'h00;
									end
								else
									begin
										Red <= 8'hff;
										Green <= 8'hff;
										Blue <= 8'hff;
									end
							end
							else
							begin
								Red <= 8'hff;
								Green <= 8'hff;
								Blue <= 8'hff;
							end
					end
			2'b01: 
				  begin
	
						if(player_on == 1'b1 && player_data_24bit != 24'hff260 && player_data_24bit !=  24'hff00)
						begin
							Red <= player_data_24bit[23:16];
							Green <=  player_data_24bit[15:8];
							Blue <=  player_data_24bit[7:0];
						end
						else if(boulder_on == 1'b1 && boulder_data !=  24'hff00)
						begin
							Red <= palette_hex[boulder_data][23:16];
							Green <= palette_hex[boulder_data][15:8];
							Blue <= palette_hex[boulder_data][7:0];
						end
						else
						begin 
							Red <= palette_hex[grass_data][23:16];
							Green <= palette_hex[grass_data][15:8];
							Blue <= palette_hex[grass_data][7:0];
						end
				  end      
			2'b10:
			  begin

					Red <= 8'hff;
					Green<= 8'hff;
					Blue <= 8'hff;
					if (rock_on == 1'b1)
					begin
						Red <= palette_hex[rock_data][23:16];
						Green<= palette_hex[rock_data][15:8];
						Blue <= palette_hex[rock_data][7:0];
					end
					if(cut_on == 1'b1)
					begin
						Red <= palette_hex[cut_data][23:16];
						Green<= palette_hex[cut_data][15:8];
						Blue <= palette_hex[cut_data][7:0];
					end
					if(paper_on == 1'b1)
					begin
						Red <= palette_hex[paper_data][23:16];
						Green <= palette_hex[paper_data][15:8];
						Blue <= palette_hex[paper_data][7:0];
					end
					if(run_on == 1'b1)
					begin
						Red <= palette_hex[run_data][23:16];
						Green<= palette_hex[run_data][15:8];
						Blue <= palette_hex[run_data][7:0];
					end
					if(execute_on == 1'b1)
					begin
						Red <= palette_hex[execute_data][23:16];
						Green <= palette_hex[execute_data][15:8];
						Blue<= palette_hex[execute_data][7:0];
					end
					if(pokemonA_on == 1'b1)
					begin
						Red <= palette_hex[poke_data][23:16];
						Green <= palette_hex[poke_data][15:8];
						Blue<= palette_hex[poke_data][7:0];
					end
					if(pokemonB_on == 1'b1)
					begin
						Red <= palette_hex[poke_data][23:16];
						Green <= palette_hex[poke_data][15:8];
						Blue<= palette_hex[poke_data][7:0];
					end
					if (winner == 2'b00 && keycode == 8'h2c)
					begin
						Red <= 8'hff;
						Green <= 8'h00;
						Blue<= 8'h00;
						if (i == 5000)
						begin
						scene <= 2'b10;
						end
					end
					if (winner == 2'b01 && keycode == 8'h2c)
					begin
						Red <= 8'h00;
						Green <= 8'h00;
						Blue<= 8'hff;
						if (i == 5000)
						begin
						scene <= 2'b10;
						end
					end
					if (winner == 2'b11 && keycode == 8'h2c)
					begin
						Red <= 8'h00;
						Green <= 8'hff;
						Blue<= 8'h00;
						if (i == 5000)
						begin
						scene <= 2'b10;
						end
					end
			  end
		endcase
    end 
    
endmodule
