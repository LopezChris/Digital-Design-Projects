

`timescale 1ns / 1ps

module FSM_tb();

	reg Go_tb, clk_tb, reset_tb;
	reg [1:0] Op_tb;
	wire [3:0] CS_tb;
	wire [1:0] s1_tb, wa_tb, raa_tb, rab_tb, c_tb;
	wire we_tb, rea_tb, reb_tb, s2_tb, Done_tb;

	FSM DUT(
		.Go(Go_tb), .clk(clk_tb), .reset(reset_tb), .Op(Op_tb),
		.CS(CS_tb), .s1_mux(s1_tb), .wa(wa_tb), .raa(raa_tb), .rab(rab_tb), .c(c_tb),
		.we(we_tb), .rea(rea_tb), .reb(reb_tb), .s2_mux(s2_tb), .Done(Done_tb)
		);


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

	//Operation
	parameter
		ADD_OP = 2'b11,
		SUBTRACT_OP = 2'b10,
		AND_OP = 2'b01,
		XOR_OP = 2'b00;

	//reg [14:0] OpCode;
	parameter
		//15'(s1)_(wa)_(we)_(raa)_(rea)_(rab)_(reb)_(c)_(s2)_(done)
		Wait = 15'b01_00_0_00_0_00_0_00_0_0,
		LoadIn1 = 15'b11_01_1_00_0_00_0_00_0_0,
		LoadIn2 = 15'b10_10_1_00_0_00_0_00_0_0,
		Add = 15'b00_11_1_01_1_10_1_11_0_0,
		Subtract = 15'b00_11_1_01_1_10_1_10_0_0,
		AND = 15'b00_11_1_01_1_10_1_01_0_0,
		XOR = 15'b00_11_1_01_1_10_1_00_0_0,
		LoadOutput = 15'b01_00_0_11_1_11_1_01_1_1;



	integer error_count; //integer opcount;

	initial begin
		error_count = 0; clk_tb = 0; reset_tb = 0;//opcount = 0;
		$display("FSM Simulation beginning.");
		#1 reset_tb = ~reset_tb;
		#1 reset_tb = ~reset_tb;

		Go_tb = 0;
		tick();
		$display("Starting at s%d", CS_tb);
		if(CS_tb != s0) begin
			$display("State Transistion Error, CS: %b, Go = 0, CS != s0", CS_tb);
			error_count = error_count + 1;
		end


		Go_tb = 1;

		Op_tb = ADD_OP;
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s1) begin
				$display("State Transistion Error, CS: %b, Go = 1, CS != s1", CS_tb);
				error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s2) begin
					$display("State Transistion Error, CS: %b, CS != s2", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s3) begin
					$display("State Transistion Error, CS: %b, CS != s3", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s4) begin
					$display("State Transistion Error, CS: %b, CS != s4", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s8) begin
					$display("State Transistion Error, CS: %b, CS != s8", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s0) begin
					$display("State Transistion Error, CS: %b, CS != s0", CS_tb);
					error_count = error_count + 1;
			end

		Op_tb = SUBTRACT_OP;
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s1) begin
				$display("State Transistion Error, CS: %b, Go = 1, CS != s1", CS_tb);
				error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s2) begin
					$display("State Transistion Error, CS: %b, CS != s2", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s3) begin
					$display("State Transistion Error, CS: %b, CS != s3", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s5) begin
					$display("State Transistion Error, CS: %b, CS != s5", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s8) begin
					$display("State Transistion Error, CS: %b, CS != s8", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s0) begin
					$display("State Transistion Error, CS: %b, CS != s0", CS_tb);
					error_count = error_count + 1;
			end

		Op_tb = AND_OP;
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s1) begin
				$display("State Transistion Error, CS: %b, Go = 1, CS != s1", CS_tb);
				error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s2) begin
					$display("State Transistion Error, CS: %b, CS != s2", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s3) begin
					$display("State Transistion Error, CS: %b, CS != s3", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s6) begin
					$display("State Transistion Error, CS: %b, CS != s6", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s8) begin
					$display("State Transistion Error, CS: %b, CS != s8", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s0) begin
					$display("State Transistion Error, CS: %b, CS != s0", CS_tb);
					error_count = error_count + 1;
			end

		Op_tb = XOR_OP;
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s1) begin
				$display("State Transistion Error, CS: %b, Go = 1, CS != s1", CS_tb);
				error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s2) begin
					$display("State Transistion Error, CS: %b, CS != s2", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s3) begin
					$display("State Transistion Error, CS: %b, CS != s3", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s7) begin
					$display("State Transistion Error, CS: %b, CS != s7", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s8) begin
					$display("State Transistion Error, CS: %b, CS != s8", CS_tb);
					error_count = error_count + 1;
			end
		tick();
		$display("Transistioning to s%d", CS_tb);
			if(CS_tb != s0) begin
					$display("State Transistion Error, CS: %b, CS != s0", CS_tb);
					error_count = error_count + 1;
			end


		if(error_count == 0) begin
			$display("No errors found in simulation");
		end
		else begin
			$display("%d errors found in simulation", error_count);
		end
		$display("Simulation Finished.");
		$finish;
	end

	//checking output logic for each state
	always @ (CS_tb) begin
		case(CS_tb)
			s0:
				begin
					if({s1_tb, wa_tb, we_tb, raa_tb, rea_tb, rab_tb, reb_tb, c_tb, s2_tb, Done_tb} != Wait) begin
						$display("OpCode Idle Error");
						error_count = error_count + 1;
					end
				end
			s1:
				begin
					if({s1_tb, wa_tb, we_tb, raa_tb, rea_tb, rab_tb, reb_tb, c_tb, s2_tb, Done_tb} != LoadIn1) begin
						$display("OpCode Load Input 1 Error");
						error_count = error_count + 1;
					end
				end
			s2:
				begin
					if({s1_tb, wa_tb, we_tb, raa_tb, rea_tb, rab_tb, reb_tb, c_tb, s2_tb, Done_tb} != LoadIn2) begin
						$display("OpCode Load Input 2 Error");
						error_count = error_count + 1;
					end
				end
			s3:
				begin
					if({s1_tb, wa_tb, we_tb, raa_tb, rea_tb, rab_tb, reb_tb, c_tb, s2_tb, Done_tb} != Wait) begin
						$display("OpCode Wait Error");
						error_count = error_count + 1;
					end
				end
			s4:
				begin
					if({s1_tb, wa_tb, we_tb, raa_tb, rea_tb, rab_tb, reb_tb, c_tb, s2_tb, Done_tb} != Add) begin
						$display("OpCode Add Error");
						error_count = error_count + 1;
					end
				end
			s5:
				begin
					if({s1_tb, wa_tb, we_tb, raa_tb, rea_tb, rab_tb, reb_tb, c_tb, s2_tb, Done_tb} != Subtract) begin
						$display("OpCode Subtract Error");
						error_count = error_count + 1;
					end
				end
			s6:
				begin
					if({s1_tb, wa_tb, we_tb, raa_tb, rea_tb, rab_tb, reb_tb, c_tb, s2_tb, Done_tb} != AND) begin
						$display("OpCode AND Error");
						error_count = error_count + 1;
					end
				end
			s7:
				begin
					if({s1_tb, wa_tb, we_tb, raa_tb, rea_tb, rab_tb, reb_tb, c_tb, s2_tb, Done_tb} != XOR) begin
						$display("OpCode XOR Error");
						error_count = error_count + 1;
					end
				end
			s8:
				begin
					if({s1_tb, wa_tb, we_tb, raa_tb, rea_tb, rab_tb, reb_tb, c_tb, s2_tb, Done_tb} != LoadOutput) begin
						$display("OpCode Load Output Error");
						error_count = error_count + 1;
					end
				end
		endcase
	end

	task tick;
		begin
			clk_tb = 0; #5; clk_tb = 1; #5;
		end
	endtask
endmodule
