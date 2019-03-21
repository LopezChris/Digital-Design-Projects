`timescale 1ns / 1ps

module dp_tb();

reg [2:0] in1, in2;
reg [1:0] s1, wa, raa, rab, op;
reg we, rea, reb, s2, clk;
wire [2:0] out;
reg[13:0] ctrl;

DP DUT(.in1(in1), .in2(in2), .s1(s1), .clk(clk), .wa(wa),
.we(we), .raa(raa), .rea(rea), .rab(rab), .reb(reb), .c(op),
.s2(s2), .out(out));

//14'b (s1)_(wa)_(we)_(raa)_(rea)_(rab)_(reb)_(op)_(s2)

parameter

	//s1=2'b01;
	//wa = 0; we = 0; raa = 0; rea = 0; rab = 0; reb = 0;
	//op = 0;
	//s2 = 0;
	Idle = 14'b01_00_0_00_0_00_0_00_0,

	//Write In1 into R1
	//s1 = 2'b11, Load In1 into MUX1
	//wa = 2'b01; we = 1; Write In1 into R1
	//raa = 0; rea = 0; rab = 0; reb = 0;
	//op = 0;
	//s2 = 0; ALUOutput does not leave MUX2
	LoadIn1 = 14'b11_01_1_00_0_00_0_00_0,

	//Write In2 into R2
	//s1 = 2'b10, Load In2 into MUX1
	//wa = 2'b10; we = 1; Write In2 into R2
	//raa = 00; rea = 0; rab = 0; reb = 0;
	//op = 0;
	//s2 = 0; ALUOutput does not leave MUX2
	LoadIn2 = 14'b10_10_1_00_0_00_0_00_0,

	//R3 <- R1 + R2, ALU = 2'b11
	//s1 = 2'b00, Load ALU Output into MUX1
	//wa = 2'b11; we = 1; Write ALU Output into R3
	//raa = 01; rea = 1; rab = 10; reb = 1; Read data in R1, Read data in R2
	//op = 11; Add
	//s2 = 0; ALUOutput does not leave MUX2
	Add = 14'b00_11_1_01_1_10_1_11_0,

	//R3 <- R1 - R2, ALU = 2'b10
	//s1 = 2'b00; Load ALU Output into MUX1
	//wa = 2'b11; we = 1; Write ALU Output into R3
	//raa = 01; rea = 1; rab = 10; reb = 1; Read data in R1, Read data in R2
	//op = 10; Subtract
	//s2 = 0; ALUOutput does not leave MUX2
	Subtract = 14'b00_11_1_01_1_10_1_10_0,

	//R3 <- R1 & R2, ALU = 2'b01
	//s1 = 2'b00; Load ALU Output into MUX1
	//wa = 2'b11; we = 1; Write ALU Output into R3
	//raa = 01; rea = 1; rab = 10; reb = 1; Read data in R1, Read data in R2
	//op = 01; AND
	//s2 = 0; ALUOutput does not leave MUX2
	AND = 14'b00_11_1_01_1_10_1_01_0,

	//R3 <- R1 ^ R2, ALU = 2'b00
	//s1 = 2'b00; Load ALU Output into MUX1
	//wa = 2'b11; we = 1; Write ALU Output into R3
	//raa = 01; rea = 1; rab = 10; reb = 1; Read data in R1, Read data in R2
	//op = 00; XOR
	//s2 = 0; ALUOutput does not leave MUX2
	XOR = 14'b00_11_1_01_1_10_1_00_0,

	//Verify ALU Output was stored in RF
	//s1 = 2'b01; In3 is 0
	//wa = 2'b00; we = 0; raa = 11; rea = 1; rab = 11; reb = 1;  Read Data in R3, Read Data in R3
	//op = 01; R3 & R3 = R3
	//s2 = 1; ALUOutput will leave MUX2
	LoadOutput = 14'b01_00_0_11_1_11_1_01_1;

//update ctrl
always @ (ctrl) begin
	{s1, wa, we, raa, rea, rab, reb, op, s2} = ctrl;
end

integer correct_count, error_count, i, j;

initial begin
	correct_count = 0; error_count = 0; i = 0; j = 0;

	$display("Simulation Beginning:\n");

	for(i = 0; i < 8; i = i+1) begin
	   for(j = 0; j < 8; j = j + 1) begin
	        in1 = i; in2 = j;
            ctrl = Idle; tick();
            ctrl = LoadIn1; tick();
            ctrl = LoadIn2; tick();
            ctrl = Idle; tick();

            ctrl = Add; tick();
            ctrl = LoadOutput; tick();
            if(out != (in1 + in2)) begin
                $display("Error in Add. Input 1: %b Input 2: %b Output: %b\n", in1, in2, out);
            end
            else if(out == (in1+in2)) begin
                $display("ADD: In1: %b In2: %b R3 = %b",in1, in2, out);
            end

            ctrl = Subtract; tick();
            ctrl = LoadOutput; tick();
            if(out != (in1-in2)) begin
                $display("Error in Subtract. Input 1: %b Input 2: %b Output: %b\n", in1, in2, out);
                error_count = error_count + 1;
            end
            else if(out == (in1-in2)) begin
                $display("SUB: In1: %b In2: %b R3 = %b",in1, in2, out);
            end

            ctrl = AND; tick();
            ctrl = LoadOutput; tick();
            if(out != (in1&in2)) begin
                $display("Error in AND. Input 1: %b Input 2: %b Output: %b\n", in1, in2, out);
                error_count = error_count + 1;
            end
            else if(out == (in1&in2)) begin
                $display("AND: In1: %b In2: %b R3 = %b",in1, in2, out);
            end

            ctrl = XOR; tick();
            ctrl = LoadOutput; tick();
            if(out != (in1^in2)) begin
                $display("Error in XOR. Input 1: %b Input 2: %b Output: %b\n", in1, in2, out);
                error_count = error_count + 1;
            end
            else if(out == (in1^in2)) begin
                $display("XOR: In1: %b In2: %b R3 = %b",in1, in2, out);
            end
        end
    end

    if(error_count == 0) begin
        $display("No errors found in simulation.");
    end
    else begin
        $display("%d errors found in simulation.", error_count);
    end

    tick();
	$display("Simulation Finished.\n");
	#10 $finish;
	end

	task tick;
		begin
			clk = 0; #5;
			clk = 1; #5;
		end
	endtask
endmodule
