`timescale 1ns / 1ps
module FSM(input Go, clk, reset,
			input [1:0] Op,
			output reg [3:0] CS,
			output reg [1:0] s1_mux, wa, raa, rab, c,
			output reg we, rea, reb, s2_mux, Done);


	reg [3:0] NS; //Next State Register

	parameter
		s0 = 4'b0000, //Idle, If Go = 0, then s0; if Go = 1, then s1;
		s1 = 4'b0001, //Load Input 1 into Register 1, go to s2;
		s2 = 4'b0010, //Load Input 2 into Register 2, go to s3;
		s3 = 4'b0011, //Wait for Operation
		s4 = 4'b0100, //Addition, ALU Operation = 11, go to s8;
		s5 = 4'b0101, //Subtraction, ALU Operation = 10, go to s8;
		s6 = 4'b0110, //AND, ALU Operation = 01, go to s8;
		s7 = 4'b0111, //XOR, ALU Operation = 00, go to s8;
		s8 = 4'b1000; //Load Output, Done = 1, go to S0;

						  ////////////
						  //NS Logic//
						  ///////////
	always @ (CS, Go, Op) begin
		case(CS)
			s0:begin NS = (Go) ? s1:s0; end
			s1:      NS = s2;
			s2:      NS = s3;
			s3:
			begin
				case(Op)
				    2'b11:
					     NS = s4;
				    2'b10:
						 NS = s5;
				    2'b01:
						 NS = s6;
				    default:
						 NS = s7;
				endcase
			end
			s4:      NS = s8;
			s5:      NS = s8;
			s6:      NS = s8;
			s7:      NS = s8;
			s8:      NS = s0;
			default: NS = s0;
		endcase
	end

						///////////////////////////////
						//State Register (Sequential)//
						///////////////////////////////
	always @(posedge clk, posedge reset) begin
		if(reset)
		      CS <= s0;
		else
		      CS <= NS;
	end


	reg [14:0] Opcode;

	//15'b (s1)_(wa)_(we)_(raa)_(rea)_(rab)_(reb)_(c)_(s2)_(Done)

	parameter
		Idle = 15'b01_00_0_00_0_00_0_00_0_0,
		LoadIn1 = 15'b11_01_1_00_0_00_0_00_0_0,
		LoadIn2 = 15'b10_10_1_00_0_00_0_00_0_0,
		Add = 15'b00_11_1_01_1_10_1_11_0_0,
		Subtract = 15'b00_11_1_01_1_10_1_10_0_0,
		AND = 15'b00_11_1_01_1_10_1_01_0_0,
		XOR = 15'b00_11_1_01_1_10_1_00_0_0,
		LoadOutput = 15'b01_00_0_11_1_11_1_01_1_1;

	always @ (Opcode) begin
		{s1_mux, wa, we, raa, rea, rab, reb, c, s2_mux, Done} = Opcode;
	end

						//////////////////////////////
						//Output Combinational Logic//
						//////////////////////////////
	always @ (CS) begin
		case (CS)
			s0:
				Opcode = Idle; //Idle
			s1:
				Opcode = LoadIn1; //Load Input 1 into R1
			s2:
				Opcode = LoadIn2; //Load Input 2 into R2
			s3:
				Opcode = Idle; //Wait
			s4:
				Opcode = Add; //R1 + R2
			s5:
				Opcode = Subtract; //R1 - R2
			s6:
				Opcode = AND; //R1 & R2
			s7:
				Opcode = XOR; //R1 ^ R2
			s8:
				Opcode = LoadOutput; //Out = R3, Done = 1
		endcase
	end
endmodule
