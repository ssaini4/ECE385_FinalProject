module font_player ( 
						input Reset, frame_clk, input  [7:0] keycode,
               output [9:0]  playerX, playerY
					 );
	

	logic [9:0] player_X_Pos, player_X_Motion, player_Y_Pos, player_Y_Motion, player_Size;
    parameter [9:0] player_X_Center=320;  // Center position on the X axis
    parameter [9:0] player_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] player_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] player_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] player_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] player_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] player_X_Step=1;      // Step size on the X axis
    parameter [9:0] player_Y_Step=1;      // Step size on the Y axis
    assign player_Size = 7;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_player
        if (Reset)  // Asynchronous Reset
        begin 
            player_Y_Motion <= 10'd0; //player_Y_Step;
				player_X_Motion <= 10'd0; //player_X_Step;
				player_Y_Pos <= player_Y_Center;
				player_X_Pos <= player_X_Center;
        end
           
        else 
        begin
		  if ( (player_Y_Pos + player_Size) >= player_Y_Max 
					)  // player is at the top edge, BOUNCE!
				 begin
					  player_Y_Motion <= (~ (player_Y_Step) + 1'b1);  // 2's complement.
					  player_X_Motion <= 10'b0;
					  end
				else if (((player_Y_Pos+ player_Size+8 + player_Y_Step)>=60 && (player_Y_Pos - player_Size + 3 -player_Y_Step)<79&& (player_X_Pos+3 + player_X_Step)  >=0 && (player_X_Pos  - player_X_Step) <400 )||
							((player_Y_Pos + player_Size+8+ player_Y_Step)>=200 && (player_Y_Pos-player_Size+ 3-player_Y_Step)<219 && (player_X_Pos+3 + player_X_Step) >=500 && (player_X_Pos- player_X_Step)	<640) ||
							((player_Y_Pos + player_Size+8+ player_Y_Step) >= 300 && (player_Y_Pos-player_Size+ 3-player_Y_Step)<319 && (player_X_Pos+3 + player_X_Step) >= 0 && (player_X_Pos- player_X_Step) <300) ||
							((player_Y_Pos+player_Size+8+ player_Y_Step) >= 340 &&(player_Y_Pos-player_Size+ 3-player_Y_Step)< 399 && (player_X_Pos+3 + player_X_Step) >=  440 && (player_X_Pos- player_X_Step) < 459) ||
							((player_Y_Pos+player_Size+8+ player_Y_Step) >= 399 && (player_Y_Pos-player_Size+ 3-player_Y_Step)<419 && (player_X_Pos+3 + player_X_Step) >= 440 &&(player_X_Pos- player_X_Step) < 640))
					begin
					
							player_Y_Motion <= 10'b0;
							player_X_Motion <= 10'b0;				
					end
				 else if((player_Y_Pos - player_Size) <= player_Y_Min) 
				 begin
					  player_Y_Motion <= player_Y_Step;
					  player_X_Motion <= 10'b0;
					  end
				else if ( (player_X_Pos + player_Size) >= player_X_Max )  // player is at the rightmost edge, BOUNCE!
					  begin
					  player_X_Motion <= (~ (player_X_Step) + 1'b1);  // 2's complement.
					  player_Y_Motion <= 10'b0;
					  end
				 else if ( (player_X_Pos - player_Size) <= player_X_Min )  // player is at the leftmost edge, BOUNCE!
				 begin
					  player_X_Motion <= player_X_Step;
						player_Y_Motion <= 10'b0;
				 end
				 else 
					begin
				   player_Y_Motion <= player_Y_Motion;  // player is somewhere in the middle, don't bounce, just keep moving
					  player_X_Motion <= player_X_Motion;  // player is somewhere in the middle, don't bounce, just keep moving
					  
						case (keycode)
							8'h001A : 
								begin
								 player_Y_Motion <= (~ (player_Y_Step) + 1'b1);	//W
								 player_X_Motion <= 10'b0;
								end 
							8'h0004 :
								 begin
								 player_X_Motion <= (~ (player_X_Step) + 1'b1); // A
								 player_Y_Motion <=10'b0;
								 
								 end
							8'h0016 : 
								begin
								 player_Y_Motion <= player_Y_Step ;// S
								 player_X_Motion <= 10'b0; 
								end
							8'h0007 :
								begin
								player_X_Motion <= player_X_Step;// D
								player_Y_Motion <=10'b0;
								 end
							default : 
								begin
								player_Y_Motion <= 10'b0 ;// do nothing
								player_X_Motion <= 10'b0;
								end
						endcase
					  end
					  
		 
				 player_Y_Pos <= (player_Y_Pos + player_Y_Motion);  // Update player position
				 player_X_Pos <= (player_X_Pos + player_X_Motion);
			
			
		end  
    end
       
    assign playerX = player_X_Pos;
   
    assign playerY = player_Y_Pos;
   
    

endmodule
