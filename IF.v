`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:43:56 01/06/2016 
// Design Name: 
// Module Name:    IF 
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

module IF(
input wire state,cf,nf,zf,
input wire clock,reset,
input wire[15:0]i_datain,reg_C,ALUo,
output reg[7:0]pc,
input wire[15:0]mem_ir,ex_ir,
output reg[15:0]id_ir,
output reg[2:0]bug
    );
	 

//reg [2:0]bug;

always @(posedge clock or posedge reset)//从指令内存中获取指令，pc为指令地址；
begin
	if (reset)
		begin
				id_ir <= 16'b0000_0000_0000_0000;
				bug <= 3'b0;
				pc <= 8'b0000_0000;
		end
	else if(state ==`exec)
	begin
		//id_ir <= i_datain;
		 if(((ex_ir[15:11] == `BZ)&& (zf == 1'b1)) 
			|| ((ex_ir[15:11] == `BN)&& (nf == 1'b1))
			|| ((ex_ir[15:11] == `BNN)&& (nf == 1'b0))
					||((ex_ir[15:11] == `BNZ)&& (zf == 1'b0))
					||((ex_ir[15:11] == `BC)&& (cf == 1'b1))
					||((ex_ir[15:11] == `BNC)&& (cf == 1'b0))
					||ex_ir[15:11] ==`JMPR)
		begin
		pc <= ALUo[7:0];
		bug <= 3'b011;
		id_ir <= 16'bx;
		end
		else if(id_ir[15:11] == `JUMP)
		begin
		pc <= id_ir[7:0];
		id_ir <= 16'b0;
		end
		else if(id_ir[15:11] == `LOAD&&
		(((i_datain[15:11] == `ADD||i_datain[15:11] == `SUB||i_datain[15:11] == `CMP||i_datain[15:11] == `ADDC||i_datain[15:11] == `SUBC||i_datain[15:11] == `AND||i_datain[15:11] == `OR)&&(id_ir[10:8] == i_datain[2:0]||id_ir[10:8] == i_datain[6:4]))
		||((i_datain[15:11] == `ADDI||i_datain[15:11] == `SUBI||i_datain[15:11] == `LDIH||i_datain[15:11] == `JMPR||i_datain[15:11] ==`BZ||i_datain[15:11] ==`BNZ||i_datain[15:11] ==`BN||i_datain[15:11] ==`BNN||i_datain[15:11] ==`BC||i_datain[15:11] ==`BNC)&&i_datain[10:8] == id_ir[10:8])
		||((i_datain[15:11] == `SLL||i_datain[15:11] == `SRL||i_datain[15:11] == `SLA||i_datain[15:11] == `SRA||i_datain[15:11] == `LOAD)&&(i_datain[6:4] == id_ir[10:8]))
		||((i_datain[15:11] == `STORE)&&(i_datain[10:8] == id_ir[10:8]||i_datain[6:4] == id_ir[10:8]))))
		begin
		id_ir <= 16'bx;
		bug <= 3'b100;
		pc <= pc;
		end
		else if(id_ir[15:11] == `HALT)
		begin
		pc <= pc;
		id_ir <= id_ir;
		end
		else
				begin
					pc <= pc + 1;
					bug <= 3'b101;
					id_ir <= i_datain;
			   end
	end
end

endmodule
