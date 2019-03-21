`timescale 1ns / 1ps
module CU_tb();
reg clk_tb, rst_tb, go_tb;
reg [3:0] CNT_tb;
reg R_lt_Y_tb;
wire done_tb, LDr_tb, SLr_tb, SRr_tb,
xLin_tb, LDx_tb, SLx_tb, SRx_tb,
LDy_tb, SLy_tb, SRy_tb,
sel1_tb, sel2_tb, sel3_tb,
LDud_tb, UDud_tb, CEud_tb;

wire[2:0] CS_tb; //Current State
CU DUT(.clk(clk_tb), .rst(rst_tb), .go(go_tb), .done(done_tb),
.R_lt_Y(R_lt_Y_tb), .CNT(CNT_tb),
.LDr(LDr_tb), .SLr(SLr_tb), .SRr(SRr_tb),
.xLin(xLin_tb), .LDx(LDx_tb), .SLx(SLx_tb), .SRx(SRx_tb),
.LDy(LDy_tb), .SLy(SLy_tb), .SRy(SRy_tb),
.sel1(sel1_tb), .sel2(sel2_tb), .sel3(sel3_tb),
.LDud(LDud_tb), .UDud(UDud_tb), .CEud(CEud_tb), .CS(CS_tb));
initial begin
clk_tb = 0; rst_tb = 0; go_tb = 0; //error_count = 0;
#1 rst_tb = ~rst_tb;
#1 rst_tb = ~rst_tb;
tick();
tick();
if(CS_tb != 3&#39;b000) begin
$display(&quot;S0 Error: %d&quot;, CS_tb);
end
go_tb = 1;
tick();
if(CS_tb != 3&#39;b001) begin
$display(&quot;S1 Error: %d&quot;, CS_tb);
end
tick();

if(CS_tb != 3&#39;b010) begin
$display(&quot;S2 Error: %d&quot;, CS_tb);
end
tick();
if(CS_tb != 3&#39;b011) begin
$display(&quot;S3 Error: %d&quot;, CS_tb);
end
R_lt_Y_tb = 0;
tick();
if(CS_tb != 3&#39;b100) begin
$display(&quot;S5 Error: %d&quot;, CS_tb);
end
CNT_tb = 1;
tick();
if(CS_tb != 3&#39;b011) begin
$display(&quot;S3 Error: %d&quot;, CS_tb);
end
R_lt_Y_tb = 1;
tick();
if(CS_tb != 3&#39;b101) begin
$display(&quot;S4 Error: %d&quot;, CS_tb);
end
CNT_tb = 0;
tick();
if(CS_tb != 3&#39;b100) begin
$display(&quot;S6 Error: %d&quot;, CS_tb);
end
tick();
if(CS_tb != 3&#39;b111) begin
$display(&quot;S7 Error: %d&quot;, CS_tb);
end
tick();
if(CS_tb != 3&#39;b000) begin
$display(&quot;S0 Error: %d \n\n\n\n\n&quot;, CS_tb);
end
//if(error_count != 0) begin
//$display(&quot;%d errors found&quot;, error_count);
//end
tick();
$display(&quot;Simulation Finished.\n&quot;);
$finish;
end
//(LDr_tb, SLr_tb, SRr_tb, xLin_tb, LDx_tb, SLx_tb, SRx_tb, LDy_tb, SLy_tb, SRy_tb, sel1_tb,
sel2_tb, sel3_tb, LDud_tb, UDud_tb, CEud_tb, done_tb);
parameter
s0out = 17&#39;b000_0000_000_000_000_0,
s1out = 17&#39;b100_0100_100_000_101_0,
s2out = 17&#39;b010_0010_000_100_000_0,
s3outR_lt_Y = 17&#39;b000_0000_000_100_001_0,
s3outNR_lt_Y = 17&#39;b100_0000_000_100_001_0,
s4out = 17&#39;b010_1010_000_100_000_0,
s5out = 17&#39;b010_0010_000_100_000_0,
s6out = 17&#39;b001_0000_000_011_000_0,
s7out = 17&#39;b000_0000_000_011_000_1;
//Output Logic
always@(CS_tb)
begin
case(CS_tb)

3&#39;b000: begin //good

if({LDr_tb, SLr_tb, SRr_tb, xLin_tb, LDx_tb, SLx_tb, SRx_tb, LDy_tb, SLy_tb,
SRy_tb, sel1_tb, sel2_tb, sel3_tb, LDud_tb, UDud_tb, CEud_tb, done_tb}!= s0out) begin

$display(&quot;S0 Error&quot;);
end
end
3&#39;b001: begin //good

if({LDr_tb, SLr_tb, SRr_tb, xLin_tb, LDx_tb, SLx_tb, SRx_tb, LDy_tb, SLy_tb,
SRy_tb, sel1_tb, sel2_tb, sel3_tb, LDud_tb, UDud_tb, CEud_tb, done_tb}!= s1out) begin

$display(&quot;S1 Error&quot;);
end

end
3&#39;b010: begin //good

if({LDr_tb, SLr_tb, SRr_tb, xLin_tb, LDx_tb, SLx_tb, SRx_tb, LDy_tb, SLy_tb,
SRy_tb, sel1_tb, sel2_tb, sel3_tb, LDud_tb, UDud_tb, CEud_tb, done_tb}!= s2out) begin

$display(&quot;S2 Error&quot;);
end

end
3&#39;b011: begin //Maybe.
if(R_lt_Y_tb) begin

if({LDr_tb, SLr_tb, SRr_tb, xLin_tb, LDx_tb, SLx_tb, SRx_tb, LDy_tb, SLy_tb,
SRy_tb, sel1_tb, sel2_tb, sel3_tb, LDud_tb, UDud_tb, CEud_tb, done_tb}!= s3outR_lt_Y) begin

$display(&quot;S3 Error&quot;);
end
end
else begin

if({LDr_tb, SLr_tb, SRr_tb, xLin_tb, LDx_tb, SLx_tb, SRx_tb, LDy_tb, SLy_tb,
SRy_tb, sel1_tb, sel2_tb, sel3_tb, LDud_tb, UDud_tb, CEud_tb, done_tb}!= s3outNR_lt_Y) begin

$display(&quot;S3 Error&quot;);
end
end
end
3&#39;b100: begin //Good

if({LDr_tb, SLr_tb, SRr_tb, xLin_tb, LDx_tb, SLx_tb, SRx_tb, LDy_tb, SLy_tb,
SRy_tb, sel1_tb, sel2_tb, sel3_tb, LDud_tb, UDud_tb, CEud_tb, done_tb}!= s4out) begin

$display(&quot;S Error&quot;);
end

end
3&#39;b101: begin //Good

if({LDr_tb, SLr_tb, SRr_tb, xLin_tb, LDx_tb, SLx_tb, SRx_tb, LDy_tb, SLy_tb,
SRy_tb, sel1_tb, sel2_tb, sel3_tb, LDud_tb, UDud_tb, CEud_tb, done_tb}!= s5out) begin

$display(&quot;S Error&quot;);
end

end
3&#39;b110: begin //Good

if({LDr_tb, SLr_tb, SRr_tb, xLin_tb, LDx_tb, SLx_tb, SRx_tb, LDy_tb, SLy_tb,
SRy_tb, sel1_tb, sel2_tb, sel3_tb, LDud_tb, UDud_tb, CEud_tb, done_tb}!= s6out) begin

$display(&quot;S Error&quot;);
end

end
3&#39;b111: begin //Good

if({LDr_tb, SLr_tb, SRr_tb, xLin_tb, LDx_tb, SLx_tb, SRx_tb, LDy_tb, SLy_tb,
SRy_tb, sel1_tb, sel2_tb, sel3_tb, LDud_tb, UDud_tb, CEud_tb, done_tb}!= s7out) begin

$display(&quot;S Error&quot;);
end

end
endcase
end
task tick;
begin
clk_tb = 1; #1; clk_tb = 0; #1;
end
endtask
endmodule