`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:11:13 01/06/2016 
// Design Name: 
// Module Name:    MEM 
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
module MEM(
input wire clock,reset,state,cf,hit,
input wire[15:0]mem_ir,d_datain,reg_C,cachedata,
output reg[15:0]wb_ir,reg_C1,
output reg[127:0]all
    );

//reg [15:0]pastmiss;
//reg flag;
//reg bg;
always@(posedge clock or posedge reset)//判断要不要读从内存中来的值
begin
	if (reset)
		begin
		 wb_ir <= 16'b0000_0000_0000_0000;
		 reg_C1 <= 16'b0000_0000_0000_0000;
		 all <= 0;
		 //pastmiss <= 0;
		 //flag <= 0;
		 //bg <= 0;
		 //miss <= 0;
		end
	else if (state == `exec)
			begin
				wb_ir <= mem_ir;
				if (mem_ir[15:11] == `LOAD&&hit)
				begin
				reg_C1 <= cachedata;
				//flag <= 0;
				all <= all + 1;
				//bg <= 0;
				//miss <= miss + 1;
				end
				else if(mem_ir[15:11] == `LOAD)
				begin
					reg_C1 <= d_datain;
					all <= all + 1;
					//flag <= 0;
					//pastmiss <= miss;
					//bg <= 1;
					//miss <= miss + 1;
				end
				else
					reg_C1 <= reg_C;
			end
end

endmodule
