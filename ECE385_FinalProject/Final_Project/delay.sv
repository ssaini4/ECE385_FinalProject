module	delay_1s(output delay,input CLOCK_50);

reg	[20:0] count;
always @(posedge CLOCK_50)
begin
	if(count==21'h1000000)
	begin
		count<=26'd0;
		delay<=1'b1;
	end
	else
	begin
		count<=count+1;
		delay<=1'b0;
	end
end
endmodule

