`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:40:20 01/06/2016 
// Design Name: 
// Module Name:    state 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define idle	1'b0
`define exec	1'b1
// instruction 
`define NOP	5'b00000
`define HALT	5'b00001
`define LOAD	5'b00010
`define STORE	5'b00011
`define SLL	5'b00100
`define SLA	5'b00101
`define SRL	5'b00110
`define SRA	5'b00111
`define ADD	5'b01000
`define ADDI	5'b01001
`define SUB	5'b01010
`define SUBI	5'b01011
`define CMP	5'b01100
`define AND	5'b01101
`define OR	5'b01110
`define XOR	5'b01111
`define LDIH	5'b10000
`define ADDC	5'b10001
`define SUBC	5'b10010
`define JUMP	5'b11000
`define JMPR	5'b11001
`define BZ	5'b11010
`define BNZ	5'b11011
`define BN	5'b11100
`define BNN	5'b11101
`define BC	5'b11110
`define BNC	5'b11111
//register 
`define gr0	3'b000
`define gr1	3'b001
`define gr2	3'b010
`define gr3	3'b011
`define gr4	3'b100
`define gr5	3'b101
`define gr6	3'b110
`define gr7	3'b111



module state(
input wire enable,start,clock,reset,
input wire[15:0]wb_ir,
output reg state
    );
	 
reg next_state;
always @(posedge clock or posedge reset)
begin
	if (reset)
		state <= `idle;
	else
		state <= next_state;
end

always @(*)//一但进入启用状态，enable=0或者有HALT信号才停；
	begin
		case (state)
			`idle : 
				if ((enable == 1'b1) 
				&& (start == 1'b1))
					next_state <= `exec;
				else	
					next_state <= `idle;
			`exec :
				if ((enable == 1'b0) 
				|| (wb_ir[15:11] == `HALT))
					next_state <= `idle;
				else
					next_state <= `exec;
		endcase
	end
	
endmodule
