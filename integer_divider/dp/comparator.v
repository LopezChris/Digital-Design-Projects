`timescale 1ns / 1ps
module COMPARATOR(
input[3:0] a,b,
output reg lt, error
);

always@(a,b)
begin
    if(a &lt; b) lt = 1;
    else lt = 0;
    if(b == 4&#39;b0000) error = 1;
    else error = 0;
end
endmodule