Introduction
	The purpose of this lab is to design a Small Calculator. In order to design the Small Calculator, a Control Unit and Data Path must also be designed. The Data Path (DP) uses a Register File in order to store two inputs into two registers, and an operation is performed on these two inputs and stored into a third register. The Control Unit (CU) is a finite state machine that controls the Data Path’s operations by sending out the control signals for each state. The Data Path and Control Unit each must be functionally verified before instantiating them in the Small Calculator. Once the Small Calculator is designed and verified, a bitstream will be generated and programmed onto the Nexys4 DDR FPGA Board. The Small Calculator will take four inputs, two 3-Bit Inputs, a 2-Bit input that will set the operation, and a single bit Go input that will start the state machine. The FPGA Board will then display the current state on one 7-Segment Display, and the decimal value of the 3-bit output on another 7-Segment Display.  

Design Methodology
Data Path
	The Data Path is the first task in this lab assignment. The Data Path loads Input 1 into Register 1, then Input 2 into Register 2 through MUX 1. A control signal for the ALU will set what operation the two inputs will enter, and the output of the operation is looped back to MUX 1. MUX 1 will select the result of the operations and it will be written into Register 3 of the Register File. An AND operation from the ALU is chosen so that the data stored in Register 3 can go through MUX 2, and be the output of the Data Path. the purpose of the team’s design is such that a user should only be concerned of choosing the numerical inputs, and operation to be performed. 
 
Table 1. Table of Modules used in the Data Path
Module	Description
MUX1.v	4:1 Multiplexer used to load inputs into the Register File 
RF.v	Register File with one write port and two read ports 
ALU.V	Arithmetic Logic Unit that performs Addition, Subtraction, AND, or XOR, on two inputs
MUX2.v	2:1 Multiplexer used to output the result of the ALU operation
DP.v	Loads two inputs into a register file into two different registers, and performs an operation on the two inputs and stores the result into a third register 
dp_tb.v	Self-Testing Test Bench that verifies that the ALU Operations work for every single input, as well as verifying that result of the operation is stored into a third register

Table 2. Function Table for the ALU
ALU Control	Operation
00	R1 ^ R2
01	R1 & R2
10	R1 - R2
11	R1 + R2

MUX1.v
	This is a 4 to 1 multiplexer that selects either Input 1, Input 2, 0, or the result of the ALU. 

 
Figure 1. Block Diagram of MUX1.v

RF.v
	This is a Register File with 1 Write Port and 2 Read Ports. For each Operation, the RF loads Input 1 into Register 1 and Input 2 into Register 2. The RF then reads the data stored in Register 1 and Register 2 into the ALU. When an operation in the ALU is completed, the result of the operation is looped back to MUX 1 and written into Register 3 of the RF. 
 
Figure 2. Block Diagram of RF.v

ALU.v
	This Arithmetic Logic Unit performs the following operations on two inputs: Addition, Subtraction, AND, and XOR. The ALU takes a 2-bit control input for its four operations.
 
Figure 3. Block Diagram of ALU.v





MUX2.v
	This is a 2 to 1 multiplexer that either selects the result of the ALU or 0.

 
Figure 4. Block Diagram of MUX2.v

DP.v
	The Data Path (DP) instantiates MUX1, RF, ALU, and MUX2 as designed in Lab Assignment 7. 
 
Figure 5. Top Level Block Diagram of DP.v

Figure 6. Full Block Diagram of DP.v

Dp_tb.v
	The test bench functionally verifies the Data Path by ensuring that the operation on every possible input is correct. Verification also needed to cover that the DP was storing the result of the ALU into Register 3. In the testbench, the data path went through the State Machine, using 14-bit control signal parameters for each operation (Figure 7). The Test bench would read for Register 3 when an operation was performed, and compared the result out of the second multiplexer to an inferred operation. If any errors were found, it would be printed on the TCL Console.  
 
Control Unit
	The second task was for the team to design a Control Unit as a Finite State Machine. This CU would control the operation of the DP by outputting the necessary control signals for each state. The state machine generates several outputs that simplify the process of loading an input to a register and perform ALU operations. Rather than spending time choosing the appropriate inputs for the data path a user would only be concerned with choosing the numeric input value and advancing the clock. 

Table 3. Table of Modules and Functionality in the Control Unit
Module	Description
FSM.v	Control Unit that is a Finite State Machine and controls the operations of the Data Path, its only inputs are the clock, reset, and operation to be performed; the FSM then generates the appropriate signals to achieve the operations that the user wants to accomplish, and essentially black boxing the entire process to the user. 
FSM_tb.v	Self-testing test bench that verifies that Control Unit transitions to the correct next state, as well as verifies that each state is outputting the correct control signals

 

Figure 7. Control Unit ASM Chart

Table 4. Table of Control Signals
State Operation	Control Signals
15’b(s1)_(wa)_(we)_(raa)_(rea)_(rab)_(reb)_(c)_(s2)_(done)
Idle	15’b01_00_0_00_0_00_0_00_0_0
LoadIn1	15'b11_01_1_00_0_00_0_00_0_0
LoadIn2	15'b10_10_1_00_0_00_0_00_0_0
Wait	15’b01_00_0_00_0_00_0_00_0_0
Add	15'b00_11_1_01_1_10_1_11_0_0
Subtract	15'b00_11_1_01_1_10_1_10_0_0
AND	15'b00_11_1_01_1_10_1_01_0_0
XOR	15'b00_11_1_01_1_10_1_00_0_0
LoadOutput	15'b01_00_0_11_1_11_1_01_1_1
