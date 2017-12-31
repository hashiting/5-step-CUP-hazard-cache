`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:51:25 01/06/2016 
// Design Name: 
// Module Name:    ID 
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

module ID(
input wire clock,reset,state,cf,zf,nf,
input wire[15:0]id_ir,ALUo,mem_ir,wb_ir,reg_C,reg_C1,d_datain,
input wire[15:0]gr0,gr1,gr2,gr3,gr4,gr5,gr6,gr7,
output reg[15:0]ex_ir,reg_A,reg_B,smdr
    );

reg [15:0]gr[7:0];
always@(*)
begin
 gr[0] <= gr0;
 gr[1] <= gr1;
 gr[2] <= gr2;
 gr[3] <= gr3;
 gr[4] <= gr4;
 gr[5] <= gr5;
 gr[6] <= gr6;
 gr[7] <= gr7;
end




always @(posedge clock or posedge reset)//根据不同指令，对reg_A,reg_B赋值
begin
	if (reset)
		begin
		 ex_ir <= 16'b0000_0000_0000_0000;
		 reg_A <= 16'b0000_0000_0000_0000;
		 reg_B <= 16'b0000_0000_0000_0000;
		 smdr <= 16'b0000_0000_0000_0000;
		end
	else if (state == `exec)
			begin
				if ((id_ir[15:11] == `BZ) //yong 1
				|| (id_ir[15:11] == `BN)
				||(id_ir[15:11] == `BNZ)
				||(id_ir[15:11] == `BC)
				||(id_ir[15:11] == `JMPR)
				||(id_ir[15:11] == `ADDI)
				||(id_ir[15:11] == `LDIH)
				||(id_ir[15:11] == `SUBI)
				||(id_ir[15:11] == `BNN)
				||(id_ir[15:11] == `BNC))
				begin
				if(ex_ir[10:8] == id_ir[10:8]&&ex_ir[15:11] != `STORE&&ex_ir[15:11] != `CMP&&ex_ir[15:11]!=`NOP&&ex_ir[15:11]!=`JUMP&&ex_ir[15:11]!=`JMPR&&ex_ir[15:11]!=`BZ&&ex_ir[15:11]!=`BNZ&&ex_ir[15:11]!=`BN&&ex_ir[15:11]!=`BC&&ex_ir[15:11]!=`BNN&&ex_ir[15:11]!=`BNC)
				 reg_A <= ALUo;
				else if(mem_ir[10:8] == id_ir[10:8]&&mem_ir[15:11]!=`STORE&&mem_ir[15:11] != `CMP&&mem_ir[15:11]!= `NOP&&mem_ir[15:11]!=`JUMP&&mem_ir[15:11]!=`JMPR&&mem_ir[15:11]!=`BZ&&mem_ir[15:11]!=`BNZ&&mem_ir[15:11]!=`BN&&mem_ir[15:11]!=`BC&&mem_ir[15:11]!=`BNN&&mem_ir[15:11]!=`BNC)
				begin
				if(mem_ir[15:11] == `LOAD)
				reg_A <= d_datain;
				else
				reg_A <= reg_C;
				end
				else if(id_ir[10:8] == wb_ir[10:8]&&wb_ir[15:11] != `CMP&&wb_ir[15:11]!=`STORE&&wb_ir[15:11]!= `NOP&&wb_ir[15:11]!=`JUMP&&wb_ir[15:11]!=`JMPR&&wb_ir[15:11]!=`BZ&&wb_ir[15:11]!=`BNZ&&wb_ir[15:11]!=`BN&&wb_ir[15:11]!=`BC&&wb_ir[15:11]!=`BNN&&wb_ir[15:11]!=`BNC)
				begin
				reg_A <= reg_C1;
				end
				else
				reg_A <= gr[(id_ir[10:8])];
				end
				
            else// yong 2
            begin
				if(ex_ir[10:8] == id_ir[6:4]&&ex_ir[15:11]!=`STORE&&ex_ir[15:11] != `CMP&&ex_ir[15:11]!=`NOP&&ex_ir[15:11]!=`JUMP&&ex_ir[15:11]!=`JMPR&&ex_ir[15:11]!=`BZ&&ex_ir[15:11]!=`BNZ&&ex_ir[15:11]!=`BN&&ex_ir[15:11]!=`BC&&ex_ir[15:11]!=`BNN&&ex_ir[15:11]!=`BNC)
				 reg_A <= ALUo;
				else if(mem_ir[10:8] == id_ir[6:4]&&mem_ir[15:11]!=`STORE&&mem_ir[15:11] != `CMP&&mem_ir[15:11]!= `NOP&&mem_ir[15:11]!=`JUMP&&mem_ir[15:11]!=`JMPR&&mem_ir[15:11]!=`BZ&&mem_ir[15:11]!=`BNZ&&mem_ir[15:11]!=`BN&&mem_ir[15:11]!=`BC&&mem_ir[15:11]!=`BNN&&mem_ir[15:11]!=`BNC)
				begin
				if(mem_ir[15:11] == `LOAD)
				reg_A <= d_datain;
				else
				reg_A <= reg_C;
				end
				else if(id_ir[6:4] == wb_ir[10:8]&&wb_ir[15:11]!=`STORE&&wb_ir[15:11] != `CMP&&wb_ir[15:11]!= `NOP&&wb_ir[15:11]!=`JUMP&&wb_ir[15:11]!=`JMPR&&wb_ir[15:11]!=`BZ&&wb_ir[15:11]!=`BNZ&&wb_ir[15:11]!=`BN&&wb_ir[15:11]!=`BC&&wb_ir[15:11]!=`BNN&&wb_ir[15:11]!=`BNC)
				reg_A <= reg_C1;
				else
				reg_A <= gr[id_ir[6:4]];
            end
				
				if(id_ir[15:11] == `STORE)
				begin
				if(ex_ir[10:8] == id_ir[10:8]&&ex_ir[15:11] != `STORE&&ex_ir[15:11] != `CMP&&ex_ir[15:11]!=`JUMP&&ex_ir[15:11]!=`JMPR&&ex_ir[15:11]!=`BZ&&ex_ir[15:11]!=`BNZ&&ex_ir[15:11]!=`BN&&ex_ir[15:11]!=`BC&&ex_ir[15:11]!=`BNN&&ex_ir[15:11]!=`BNC)
				 smdr <= ALUo;
				else if(mem_ir[10:8] == id_ir[10:8]&&mem_ir[15:11]!=`STORE&&mem_ir[15:11] != `CMP&&mem_ir[15:11]!=`JUMP&&mem_ir[15:11]!=`JMPR&&mem_ir[15:11]!=`BZ&&mem_ir[15:11]!=`BNZ&&mem_ir[15:11]!=`BN&&mem_ir[15:11]!=`BC&&mem_ir[15:11]!=`BNN&&mem_ir[15:11]!=`BNC)
				begin
				if(mem_ir[15:11] == `LOAD)
				smdr <= d_datain;
				else
				smdr <= reg_C;
				end
				else if(id_ir[10:8] == wb_ir[10:8]&&wb_ir[15:11] != `CMP&&wb_ir[15:11]!=`STORE&&wb_ir[15:11]!=`JUMP&&wb_ir[15:11]!=`JMPR&&wb_ir[15:11]!=`BZ&&wb_ir[15:11]!=`BNZ&&wb_ir[15:11]!=`BN&&wb_ir[15:11]!=`BC&&wb_ir[15:11]!=`BNN&&wb_ir[15:11]!=`BNC)
				smdr <= reg_C1;
				else
				smdr <= gr[(id_ir[10:8])];
				end
				
				if (id_ir[15:11] == `LOAD//cun shu zi
				||(id_ir[15:11] == `SLL)
				||(id_ir[15:11] == `SRL)
				||(id_ir[15:11] == `SLA)
				||(id_ir[15:11] == `SRA))
					reg_B <= {12'b0000_0000_0000, id_ir[3:0]};
				else if (id_ir[15:11] == `STORE)
					begin
						reg_B <= {12'b0000_0000_0000, id_ir[3:0]};
					end
				else if ((id_ir[15:11] == `BZ) 
						|| (id_ir[15:11] == `BN)
						||(id_ir[15:11] == `BNZ)
						||(id_ir[15:11] == `BC)
						||(id_ir[15:11] == `JMPR)
						|| (id_ir[15:11] == `ADDI)
						|| (id_ir[15:11] == `JUMP)
						||(id_ir[15:11] == `SUBI)
						||(id_ir[15:11] == `BNN)
						||(id_ir[15:11] == `BNC))
					reg_B <= {8'b0000_0000, id_ir[7:0]};
				else if( id_ir[15:11] == `LDIH)
				   reg_B <= {id_ir[7:0],8'b0000_0000};
				else
            begin				
				if(id_ir[2:0] == ex_ir[10:8]&&ex_ir[15:11] != `STORE&&ex_ir[15:11] != `CMP&&ex_ir[15:11]!=`NOP&&ex_ir[15:11]!=`JUMP&&ex_ir[15:11]!=`JMPR&&ex_ir[15:11]!=`BZ&&ex_ir[15:11]!=`BNZ&&ex_ir[15:11]!=`BN&&ex_ir[15:11]!=`BC&&ex_ir[15:11]!=`BNN&&ex_ir[15:11]!=`BNC)
				  reg_B <= ALUo;
				else if(id_ir[2:0] == mem_ir[10:8]&&mem_ir[15:11]!=`STORE&&mem_ir[15:11] != `CMP&&mem_ir[15:11]!=`NOP&&mem_ir[15:11]!=`JUMP&&mem_ir[15:11]!=`JMPR&&mem_ir[15:11]!=`BZ&&mem_ir[15:11]!=`BNZ&&mem_ir[15:11]!=`BN&&mem_ir[15:11]!=`BC&&mem_ir[15:11]!=`BNN&&mem_ir[15:11]!=`BNC)
				begin
				if(mem_ir[15:11] == `LOAD)
				reg_B <= d_datain;
				else
				 reg_B <= reg_C;
				 end
				else if(id_ir[2:0] == wb_ir[10:8]&&wb_ir[15:11]!=`STORE&&wb_ir[15:11] != `CMP&&wb_ir[15:11]!=`JUMP&&wb_ir[15:11]!=`JMPR&&wb_ir[15:11]!=`BZ&&wb_ir[15:11]!=`BNZ&&wb_ir[15:11]!=`BN&&wb_ir[15:11]!=`BC&&wb_ir[15:11]!=`BNN&&wb_ir[15:11]!=`BNC)
				begin
				  reg_B <= reg_C1;
				end
				else
					reg_B <= gr[id_ir[2:0]];
				end
				if(((ex_ir[15:11] == `BZ)&& (zf == 1'b1)) 
			|| ((ex_ir[15:11] == `BN)&& (nf == 1'b1))
			|| ((ex_ir[15:11] == `BNN)&& (nf == 1'b0))
					||((ex_ir[15:11] == `BNZ)&& (zf == 1'b0))
					||((ex_ir[15:11] == `BC)&& (cf == 1'b1))
					||((ex_ir[15:11] == `BNC)&& (cf == 1'b0))
					||ex_ir[15:11] ==`JMPR)
		begin
		ex_ir <= 16'b0;
		reg_A <= 16'b0;
		reg_B <= 16'b0;
		smdr <= 16'b0;
		end
		else
		begin
				ex_ir <= id_ir;
		end
			end
		
end

endmodule
