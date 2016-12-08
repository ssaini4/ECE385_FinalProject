module Reg4(I, Q, clk, reset);
input clk, reset;
input [3:0] I;
output [3:0] Q;
reg [3:0] Q;


wire clk_1Hz;
slowClock clock_generator(clk, reset, clk_1Hz);

always@(posedge clk_1Hz) begin      
    if (reset == 1)
        Q <= 4'b0000;   
    else
        Q <= I;

end
endmodule
