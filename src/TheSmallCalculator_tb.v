`timescale 1ns / 1ps

module TheSmallCalculator_tb();
//inputs
   reg go, clk, rst;
   reg [2:0] op;
   reg [3:0] in1, in2;
//outputs
   wire done;
   wire [3:0] CS;
   wire [2:0] out;
//FSM stuff
reg [2:0] state_counter;
reg [2:0] hold;
reg [3:0] CS_test;
reg [2:0] out_test;

TheSmallCalculator DUT(.Go(go), .clk(clk), .reset(rst), .Op(op[1:0]),
.In1(in1[2:0]), .In2(in2[2:0]), .Done(done), .CS(CS), .Out(out));

initial begin
clk = 1; go = 1; in1 = 3'b110; in2 = 3'b001;
 $display("Test begin");

 rst = 0;
 #1 rst = ~rst;
 #1 rst = ~rst;

 for(op = 0; op < 3'b100; op = op + 1)
    begin
        for(state_counter = 0; state_counter < 3'b110; state_counter = state_counter + 1)
            begin

            if(state_counter == 3'b100) begin
            hold = state_counter + (~{1'b1,(op[1:0])}); CS_test = hold; end//state is operation
            else if(state_counter == 3'b101) CS_test = 4'b1000; //done state
            else CS_test = {1'b0, state_counter[2:0]};

            #1 clk = ~clk;
            case(CS_test)
            4'b0000:
                begin
                    if(done != 1'b0)begin $display("Done is not 0"); $stop; end
                    out_test = 3'b000;
                    if(out_test != out) begin $display("Error at state %d, Expected out %d, Actual %d", CS_test, out_test, out); $stop; end
                    if(CS_test != CS) begin $display("Error at CS Expected %d, Actual %d", CS_test, CS); $stop; end
                end

           4'b0001:
                begin
                    if(done != 1'b0)begin $display("Done is not 0"); $stop; end
                    out_test = 3'b000;
                    if(out_test != out) begin $display("Error at state %d, Expected out %d, Actual %d", CS_test, out_test, out); $stop; end
                    if(CS_test != CS) begin $display("Error at CS Expected %d, Actual %d", CS_test, CS); $stop; end
                end
            4'b0010:
                begin
                    if(done != 1'b0)begin $display("Done is not 0"); $stop; end
                    out_test = 3'b000;
                    if(out_test != out) begin $display("Error at state %d, Expected out %d, Actual %d", CS_test, out_test, out); $stop; end
                    if(CS_test != CS) begin $display("Error at CS Expected %d, Actual %d", CS_test, CS); $stop; end
                end
            4'b0011:
                begin
                    if(done != 1'b0)begin $display("Done is not 0"); $stop; end
                    out_test = 3'b000;
                    if(out_test != out) begin $display("Error at state %d, Expected out %d, Actual %d", CS_test, out_test, out); $stop; end
                    if(CS_test != CS) begin $display("Error at CS Expected %d, Actual %d", CS_test, CS); $stop; end
                end
            4'b0100:
                begin
                    if(done != 1'b0)begin $display("Done is not 0"); $stop; end
                    out_test = 3'b000;
                    if(out_test != out) begin $display("Error at state %d, Expected out %d, Actual %d", CS_test, out_test, out); $stop; end
                    if(CS_test != CS) begin $display("Error at CS Expected %d, Actual %d", CS_test, CS); $stop; end
                end
            4'b0101:
                begin
                    if(done != 1'b0)begin $display("Done is not 0"); $stop; end
                    out_test = 3'b000;
                    if(out_test != out) begin $display("Error at state %d, Expected out %d, Actual %d", CS_test, out_test, out); $stop; end
                    if(CS_test != CS) begin $display("Error at CS Expected %d, Actual %d", CS_test, CS); $stop; end
                end
            4'b0110:
                begin
                    if(done != 1'b0)begin $display("Done is not 0"); $stop; end
                    out_test = 3'b000;
                    if(out_test != out) begin $display("Error at state %d, Expected out %d, Actual %d", CS_test, out_test, out); $stop; end
                    if(CS_test != CS) begin $display("Error at CS Expected %d, Actual %d", CS_test, CS); $stop; end
                end
            4'b0111:
                begin
                    if(done != 1'b0)begin $display("Done is not 0"); $stop; end
                    out_test = 3'b000;
                    if(out_test != out) begin $display("Error at state %d, Expected out %d, Actual %d", CS_test, out_test, out); $stop; end
                    if(CS_test != CS) begin $display("Error at CS Expected %d, Actual %d", CS_test, CS); $stop; end
                end
            4'b1000:
                begin
                    if(done != 1'b1)begin $display("Done is not 1"); $stop; end

                    if(op == 3'b011) out_test = in1 + in2;
                    else if(op == 3'b010) out_test = in1 - in2;
                    else if(op == 3'b001) out_test = in1 & in2;
                    else out_test = in1 ^ in2;

                    if(out_test != out) begin $display("Error at state %d, Expected out %d, Actual %d", CS_test, out_test, out); $stop; end
                    if(CS_test != CS) begin $display("Error at CS Expected %d, Actual %d", CS_test, CS); $stop; end
                end


            endcase
            tick();

            end

    end
$display("Test finished");
end

task tick;
begin
    clk = 0; #1; clk = 1; #1;
end
endtask
endmodule
