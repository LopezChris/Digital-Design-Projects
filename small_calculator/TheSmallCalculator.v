`timescale 1ns / 1ps

module TheSmallCalculator   (input Go, clk, reset,
							 input [1:0] Op,
							 input [2:0] In1, In2,
							 output [3:0] CS,
							 output [2:0] Out,
							 output Done);

	wire [1:0] s1, wa, raa, rab, c;
	wire we, rea, reb, s2;

	FSM U1(.Go(Go), .Op(Op), .clk(clk), .reset(reset), .s1_mux(s1), .wa(wa), .we(we),
			.raa(raa), .rea(rea), .rab(rab), .reb(reb), .c(c), .s2_mux(s2), .Done(Done), .CS(CS));

	DP DUT(.in1(In1), .in2(In2), .s1(s1), .clk(clk), .wa(wa),
			.we(we), .raa(raa), .rea(rea), .rab(rab), .reb(reb), .c(c),
			.s2(s2), .out(Out));
endmodule
