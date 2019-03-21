`timescale 1ns / 1ps
module CU(clk, rst, go, done,
R_lt_Y, CNT,
LDr, SLr, SRr,
xLin, LDx, SLx, SRx,
LDy, SLy, SRy,
sel1, sel2, sel3,
LDud, UDud, CEud, CS);
input clk, rst, go;
output reg done;
input R_lt_Y;
input [3:0] CNT;
output reg LDr, SLr, SRr,
xLin, LDx, SLx, SRx,
LDy, SLy, SRy,
sel1, sel2, sel3,
LDud, UDud, CEud;
reg[2:0] NS; //Next State
output reg [2:0] CS; //Current State
always@(CS, go, R_lt_Y, CNT)
begin
case(CS)
3&#39;b000: if(go) NS = 3&#39;b001;
else NS = 3&#39;b000;
3&#39;b001: NS = 3&#39;b010;
3&#39;b010: NS = 3&#39;b011;
3&#39;b011: begin
if(R_lt_Y) NS = 3&#39;b101;
else NS = 3&#39;b100;
end
3&#39;b100: begin
if(CNT == 0) NS = 3&#39;b110;
else NS = 3&#39;b011;
end

3&#39;b101: begin
if(CNT == 0) NS = 3&#39;b110;
else NS = 3&#39;b011;
end
3&#39;b110: NS = 3&#39;b111;
3&#39;b111: NS = 3&#39;b000;
default: NS = 3&#39;b000;
endcase
end
//State Register
always@(posedge clk, posedge rst)
begin
if(rst) CS &lt;= 3&#39;b000;
else CS &lt;= NS;
end
//Output Logic
always@(*)
begin
case(CS)
3&#39;b000: begin //good
LDr =0; SLr = 0; SRr = 0;
xLin = 0; LDx = 0; SLx = 0; SRx = 0;
LDy = 0; SLy = 0; SRy = 0;
sel1 = 0; sel2 = 0; sel3 = 0;
LDud = 0; UDud = 0; CEud = 0;
done = 0;
end
3&#39;b001: begin //good
LDr = 1; SLr = 0; SRr = 0;
xLin = 0; LDx = 1; SLx = 0; SRx = 0;
LDy = 1; SLy = 0; SRy = 0;
sel1 = 0; sel2 = 0; sel3 = 0;
LDud = 1; UDud = 0; CEud = 1;
done = 0;
end
3&#39;b010: begin //good
LDr =0; SLr = 1; SRr = 0;
xLin = 0; LDx = 0; SLx = 1; SRx = 0;
LDy = 0; SLy = 0; SRy = 0;
sel1 = 1; sel2 = 0; sel3 = 0;
LDud = 0; UDud = 0; CEud = 0;
done = 0;
end
3&#39;b011: begin //Maybe.
if(R_lt_Y) begin LDr =0; end
else begin LDr = 1; end
SLr = 0; SRr = 0;
xLin = 0; LDx = 0; SLx = 0; SRx = 0;
LDy = 0; SLy = 0; SRy = 0;
sel1 = 1; sel2 = 0; sel3 = 0;
LDud = 0; UDud = 0; CEud = 1;
done = 0;
end
3&#39;b100: begin //Good
LDr =0; SLr = 1; SRr = 0;
xLin = 1; LDx = 0; SLx = 1; SRx = 0;
LDy = 0; SLy = 0; SRy = 0;
sel1 = 1; sel2 = 0; sel3 = 0;
LDud = 0; UDud = 0; CEud = 0;
done = 0;
end
3&#39;b101: begin //Good
LDr =0; SLr = 1; SRr = 0;
xLin = 0; LDx = 0; SLx = 1; SRx = 0;
LDy = 0; SLy = 0; SRy = 0;
sel1 = 1; sel2 = 0; sel3 = 0;
LDud = 0; UDud = 0; CEud = 0;
done = 0;
end

3&#39;b110: begin //Good
LDr =0; SLr = 0; SRr = 1;
xLin = 0; LDx = 0; SLx = 0; SRx = 0;
LDy = 0; SLy = 0; SRy = 0;
sel1 = 0; sel2 = 1; sel3 = 1;
LDud = 0; UDud = 0; CEud = 0;
done = 0;
end
3&#39;b111: begin //Good
LDr =0; SLr = 0; SRr = 0;
xLin = 0; LDx = 0; SLx = 0; SRx = 0;
LDy = 0; SLy = 0; SRy = 0;
sel1 = 0; sel2 = 1; sel3 = 1;
LDud = 0; UDud = 0; CEud = 0;
done = 1;
end
endcase
end
endmodule