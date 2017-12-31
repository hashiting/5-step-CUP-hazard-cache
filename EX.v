`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:57:45 01/06/2016 
// Design Name: 
// Module Name:    EX 
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

`define haha 16'b0000000000000000

module EX(
input wire clock,reset,state,
input wire[15:0]ex_ir,smdr,reg_A,reg_B,
output reg cf,nf,zf,dw,
output reg[15:0]mem_ir,reg_C,smdr1,ALUo
    );


//reg [15:0]temp = 16'b0000000000000000;
reg CF;
always @(posedge clock or posedge reset)//对flag赋值，
begin
	if (reset)
		begin
		mem_ir <= 16'b0000_0000_0000_0000;
		reg_C <= 16'b0000_0000_0000_0000;
		zf <= 0;
		nf <= 0;
		dw <= 0;
		cf <= 0;
		smdr1 <= 16'b0000_0000_0000_0000;
		end
	else if (state == `exec)
			begin
				mem_ir <= ex_ir;
				cf <= CF;
				reg_C <= ALUo;
				if ((ex_ir[15:11] == `ADD) 
				|| (ex_ir[15:11] == `CMP)
				||(ex_ir[15:11] == `SUB)
				||(ex_ir[15:11] == `ADDI)
				||(ex_ir[15:11] == `ADDC)
				||(ex_ir[15:11] == `SUBC)
				||(ex_ir[15:11] == `LDIH)
				||(ex_ir[15:11] == `SUBI)
				||(ex_ir[15:11] == `OR)
				||(ex_ir[15:11] == `AND)
				||(ex_ir[15:11] == `XOR))
					begin
						if (ALUo == 16'b0000_0000_0000_0000)
							zf <= 1'b1;
						else
							zf <= 1'b0;
						if (ALUo[15] == 1'b1)
							nf <= 1'b1;
						else
							nf <= 1'b0;
					end
				if (ex_ir[15:11] == `STORE)
					begin
						dw <= 1'b1;
						smdr1 <= smdr;
					end
				else
				 begin
					dw <= 1'b0;
				 end
			end
end

wire signed [15:0]temp;
assign temp = reg_A;

always@(*)//组合逻辑，同时对cf赋值
begin
  if(reset)
  begin
  ALUo <= 16'b0000_0000_0000_0000;
  CF <= 1'b0;
  end
  else
   begin
    case(ex_ir[15:11]) 
    `LOAD : ALUo <= reg_A + reg_B;
    `STORE : ALUo<= reg_A + reg_B;
	 `CMP:{CF,ALUo} <= reg_A - reg_B;
    `LDIH :  {CF,ALUo}<= reg_A + reg_B;
    `ADD : {CF,ALUo} <= reg_A + reg_B;
    `ADDI:{CF,ALUo} <= reg_A + reg_B ;
    `ADDC : {CF,ALUo}<= reg_A + reg_B + cf;
    `AND : ALUo <= reg_A&reg_B;
    `SLL : ALUo <= reg_A<<reg_B; 
    `SLA : ALUo <= temp <<< reg_B;
    `JMPR :ALUo <= reg_A + reg_B;
    `BZ :ALUo <= reg_A + reg_B;
    `BNZ :ALUo<= reg_A + reg_B;
    `BN :ALUo <= reg_A + reg_B;
    `BC :ALUo <= reg_A + reg_B;
	 `BNN:ALUo <= reg_A + reg_B;
	 `BNC:ALUo <= reg_A + reg_B;
	 `SUB:{CF,ALUo} <= reg_A - reg_B;
	 `SUBI: {CF,ALUo} <= reg_A - reg_B ;
	 `SUBC: {CF,ALUo}<= reg_A - reg_B - cf;
	 `SRL:ALUo <= reg_A>>reg_B; 
	 `SRA: ALUo <= temp >>> reg_B; 
	 `XOR: ALUo<= reg_A^reg_B;
	 `OR:ALUo<= reg_A|reg_B;
	 `JUMP:ALUo<=reg_B;
	 default:ALUo <= ALUo;
	 endcase
  end
end
endmodule

/*if(reg_A[15] == 1'b1&&reg_B[15:0] != `haha) 
			 begin 
			   if(reg_B[3:0] == 4'b0001) ALUo[15]<=1'b1;
            if(reg_B[3:0] == 4'b0010) ALUo[15:14]<=2'b11;
				if(reg_B[3:0] == 4'b0011) ALUo[15:13]<=3'b111;
				if(reg_B[3:0] == 4'b0100) ALUo[15:12]<=4'b1111;
				if(reg_B[3:0] == 4'b0101) ALUo[15:11]<=5'b11111;
				if(reg_B[3:0] == 4'b0110) ALUo[15:10]<=6'b111111;
				if(reg_B[3:0] == 4'b0111) ALUo[15:9]<=7'b1111111;
				if(reg_B[3:0] == 4'b1000) ALUo[15:8]<=8'b11111111;
				if(reg_B[3:0] == 4'b1001) ALUo[15:7]<=9'b111111111;
				if(reg_B[3:0] == 4'b1010) ALUo[15:6]<=10'b1111111111;
				if(reg_B[3:0] == 4'b1011) ALUo[15:5]<=11'b11111111111;
				if(reg_B[3:0] == 4'b1100) ALUo[15:4]<=12'b111111111111;
				if(reg_B[3:0] == 4'b1101) ALUo[15:3]<=13'b1111111111111;
				if(reg_B[3:0] == 4'b1110) ALUo[15:2]<=14'b11111111111111;
				if(reg_B[3:0] == 4'b1111) ALUo[15:1]<=15'b111111111111111;
			 end */