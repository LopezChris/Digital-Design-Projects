`timescale 1ns / 1ps
module SUBTRACTOR(input[3:0] a,b,output reg [3:0] c);
always@(*) c = a - b;
endmodule