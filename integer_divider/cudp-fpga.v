`timescale 1ns / 1ps
module CUDP_FPGA(
input[4:0] in1,
input[4:0] in2,
input clk100MHz, rst, reset, go, clk_man,
output [7:0] LEDOUT,
output [7:0] LEDSEL,
output [4:0] Din1LED,
output [4:0] Din2LED,
output LEDDone,
output LEDError);
supply1[7:0] vcc;
wire [7:0] s0, s1, s4, s5;
wire [3:0] Qout, Rout;
wire clock, reset_db, go, clk_5KHz, DONT_USE;
wire [3:0] Qout_tens, Qout_ones, Rout_tens, Rout_ones;
assign Din1LED = in1;
assign Din2LED = in2;
CU_DP U1(.clk(clock), .rst(reset_db), .go(go), .done(LEDDone),
.X(in2[3:0]), .Y(in1[3:0]), .error_flag(LEDError), .Qout(Qout), .Rout(Rout));
clk_gen u3(.clk100MHz(clk100MHz), .rst(rst), .clk_4sec(DONT_USE), .clk_5KHz(clk_5KHz));
debounce u4(.pb_debounced(clock), .pb(clk_man), .clk(clk_5KHz));
debounce u5(.pb_debounced(reset_db), .pb(reset), .clk(clk_5KHz));
debounce u6(.pb_debounced(go), .pb(go), .clk(clk_5KHz));
bin_to_dec convertQ(.binary(Qout), .Tens(Qout_tens), .Ones(Qout_ones));
bin_to_dec convertR(.binary(Rout), .Tens(Rout_tens), .Ones(Rout_ones));
bcd_to_7seg convert0(Rout_ones, s0);
bcd_to_7seg convert1(Rout_tens, s1);
bcd_to_7seg convert4(Qout_ones, s4);
bcd_to_7seg convert5(Qout_tens, s5);
led_mux u2(clk_5KHz, rst, vcc, vcc, s5, s4, vcc, vcc, s1, s0, LEDOUT, LEDSEL);
endmodule