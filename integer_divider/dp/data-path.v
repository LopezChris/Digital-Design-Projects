`timescale 1ns / 1ps
module DATA_PATH(
clk, rst, X, Y, n,
sel1, sel2, sel3,
LDr, SLr, SRr,
LDx, SLx, SRx, XLin,
LDy, SLy, SRy,
Qout, Rout, cnt_out, R_lt_Y,
error, LOADUD, EUP, CUP
);
input [3:0] X, Y, n;
input clk, rst,
sel1, sel2, sel3,
LDr, SLr, SRr,
LDx, SLx, SRx, XLin,
LDy, SLy, SRy,
LOADUD, EUP, CUP;
output [3:0] Qout, Rout, cnt_out;
output R_lt_Y, error;
wire [3:0] R_mux, subout, Yout, Xout;
wire [4:0] R;
SHIFTER #(.WIDTH(5)) potato0_R(.Din({1&#39;b0, R_mux}), .L_in(Xout[3]), .R_in(1&#39;b0), .clk(clk),
.rst(rst), .sl(SLr), .sr(SRr), .ld(LDr), .Q(R));

SHIFTER potato1_X(.Din(X), .L_in(XLin), .R_in(1&#39;b0), .clk(clk), .rst(rst), .sl(SLx), .sr(SRx),
.ld(LDx), .Q(Xout));
SHIFTER potato2_Y(.Din(Y), .L_in(1&#39;b0), .R_in(1&#39;b0), .clk(clk), .rst(rst), .sl(SLy), .sr(SRy),
.ld(LDy), .Q(Yout));
MUX2 potato3(.sel(sel1), .in1(subout), .in2(4&#39;b0000), .mux2out(R_mux));
MUX2 potato4(.sel(sel2), .in1(R[3:0]), .in2(4&#39;b0000), .mux2out(Rout));
MUX2 potato5(.sel(sel3), .in1(Xout), .in2(4&#39;b0000), .mux2out(Qout));
COMPARATOR potato6(.a(R[3:0]), .b(Yout), .lt(R_lt_Y), .error(error));
SUBTRACTOR potato7(.a(R[3:0]), .b(Yout), .c(subout));
UP_DOWN_CNTR potato8(.D(n), .LOAD(LOADUD), .UP(CUP), .E(EUP), .rst(rst), .clk(clk),
.Q(cnt_out));
endmodule