`timescale 1ns / 1ps
module UP_DOWN_CNTR(
input [3:0] D,
input LOAD, UP, E, rst,clk,
output reg [3:0] Q
);
always@(posedge clk, posedge rst)
begin
    if(rst) Q &lt;=0;
    else if(E)
    begin
    if(LOAD)
    begin Q &lt;= D; end
    else if(UP) Q &lt;= Q + 1;
    else Q &lt;= Q - 1;
    end
    else Q &lt;= Q;
end
endmodule