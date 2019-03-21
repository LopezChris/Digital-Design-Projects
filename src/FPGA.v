`timescale 1ns / 1ps


module FPGA(input [2:0] In1, In2, //DIP Switches
            input [1:0] Op, //DIP Switches
            input clk100MHz, //Internal Clock
            input rst, reset, buttonGo, buttonBounce, //buttons
            output LEDDone, //LED to display when FSM Done Flag is thrown
            output [7:0] LEDSEL, //Select which 7 seg to display
            output [7:0] LEDOUT,
            output [2:0] LED1, LED2,
            output [1:0] LEDOp); //displays on 7 seg

wire DONTUSE, debounced_button, debounced_reset, clk5KHz;
wire [3:0] CS;
wire [2:0] Out;
wire Done;
wire [3:0] hundreds, tens, ones;
wire [7:0] BCD4, BCD1, BCD0;

supply1 [7:0] vcc;

clk_gen inclk(clk100MHz, rst, DONTUSE, clk5KHz);
button_debouncer deb_buttn(clk5KHz, buttonBounce, debounced_button);
button_debouncer deb_reset(clk5KHz, reset, debounced_reset);
TheSmallCalculator U1(buttonGo, debounced_button, debounced_reset, Op, In1, In2,CS,Out,Done);
assign LEDDone = Done;
assign LED1 = In1;
assign LED2 = In2;
assign LEDOp = Op;

bcd_to_7seg cs(CS, BCD4);
bcd_to_7seg Ones(Out, BCD0);

led_mux display7seg(clk5KHz, reset, vcc, vcc, vcc, BCD4, vcc, vcc, vcc, BCD0, LEDSEL, LEDOUT);


endmodule
