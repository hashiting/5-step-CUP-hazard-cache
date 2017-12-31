`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:14:07 01/06/2016 
// Design Name: 
// Module Name:    WB 
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
module WB(
input wire clock,reset,state,
input wire[15:0]wb_ir,reg_C1,
output reg[15:0]gr0,gr1,gr2,gr3,gr4,gr5,gr6,gr7
    );
	 
reg [15:0]gr[7:0];
always@(*)
begin
 gr0 <= gr[0];
 gr1 <= gr[1];
 gr2 <= gr[2];
 gr3 <= gr[3];
 gr4 <= gr[4];
 gr5 <= gr[5];
 gr6 <= gr[6];
 gr7 <= gr[7];
end

always@(posedge clock or posedge reset)//ÊÇ·ñÐ´»Ø¼Ä´æÆ÷
begin
	if (reset)
		begin
		 gr[0] <= 16'b0000_0000_0000_0000;
		 gr[1] <= 16'b0000_0000_0000_0000;
		 gr[2] <= 16'b0000_0000_0000_0000;
		 gr[3] <= 16'b0000_0000_0000_0000;
		 gr[4] <= 16'b0000_0000_0000_0000;
		 gr[5] <= 16'b0000_0000_0000_0000;
		 gr[6] <= 16'b0000_0000_0000_0000;
		 gr[7] <= 16'b0000_0000_0000_0000;
		end
		else if (state == `exec)
			begin
				if ((wb_ir[15:11] == `LOAD)
				|| (wb_ir[15:11] == `ADD)
				|| (wb_ir[15:11] == `ADDI)
				|| (wb_ir[15:11] == `LDIH)
				|| (wb_ir[15:11] == `ADDC)
				|| (wb_ir[15:11] == `SUBC)
				|| (wb_ir[15:11] == `AND)
				|| (wb_ir[15:11] == `SLL)
				|| (wb_ir[15:11] == `SLA)
				||(wb_ir[15:11] == `SUB)
				||(wb_ir[15:11] == `SRL)
				||(wb_ir[15:11] == `SRA)
				|| (wb_ir[15:11] == `OR)
				|| (wb_ir[15:11] == `XOR)
				|| (wb_ir[15:11] == `SUBI))
					gr[wb_ir[10:8]] <= reg_C1;
			end
end
endmodule
