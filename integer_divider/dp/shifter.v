`timescale 1ns / 1ps
module SHIFTER #(parameter WIDTH = 4)(
input[WIDTH-1:0] Din,
input L_in, R_in, clk, rst, sl, sr, ld,
output reg[WIDTH - 1:0] Q
);
always@(posedge clk, posedge rst)
    begin
        if(rst) Q &lt;= 0;
        else begin
        if(ld) Q &lt;= Din;
        else if(sl) Q &lt;= {Q[WIDTH-2:0], L_in};
        else if(sr) Q &lt;= {R_in, Q[WIDTH-1:1]};
        end
    end
endmodule