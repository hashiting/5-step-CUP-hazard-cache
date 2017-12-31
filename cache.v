`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:35:40 05/30/2016 
// Design Name: 
// Module Name:    cache 
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
module cache(
input wire [15:0]d_addr,mem_ir,smdr1,
input wire [63:0]tocache,
input wire clock1,reset,
output reg [15:0]cachedata,
output reg [31:0]miss,
output reg hit
    );

reg hit0;
reg hit1;
reg [147:0]cache[63:0];
integer i;
always@(posedge clock1 or posedge reset)
begin
if(reset)
	begin
		for(i = 0;i < 64;i = i+1)
			begin
			cache[i] <= 0;
			end
		cachedata <= 0;
		hit0 <= 0;
		hit1 <= 0;
		hit <= 0;
		miss <= 0;
		//all <= 0;
	end
else
	begin
		if(mem_ir[15:11] == `STORE)
			begin
				if(cache[d_addr[7:2]][73] == 1'b1&&cache[d_addr[7:2]][71:64] == d_addr[15:8])
					begin	
						if(d_addr[1:0] == 2'b00)
						cache[d_addr[7:2]][63:48] <= smdr1;
						else if(d_addr[1:0] == 2'b01)
						cache[d_addr[7:2]][47:32] <= smdr1;
						else if(d_addr[1:0] == 2'b10)
						cache[d_addr[7:2]][31:16] <= smdr1;
						else
						cache[d_addr[7:2]][15:0] <= smdr1;				
					end
				else if(cache[d_addr[7:2]][147] == 1'b1&&cache[d_addr[7:2]][145:138] == d_addr[15:8])
					begin	
						if(d_addr[1:0] == 2'b00)
						cache[d_addr[7:2]][137:122] <= smdr1;
						else if(d_addr[1:0] == 2'b01)
						cache[d_addr[7:2]][121:106] <= smdr1;
						else if(d_addr[1:0] == 2'b10)
						cache[d_addr[7:2]][105:90] <= smdr1;
						else
						cache[d_addr[7:2]][89:74] <= smdr1;				
					end
				else
					begin 
					//cache[d_addr[7:2]] <= cache[d_addr[7:2]];
					end
			end
		else if(mem_ir[15:11] == `LOAD)
		   begin
			//all <= all + 1;
				if(cache[d_addr[7:2]][73] == 1'b1&&cache[d_addr[7:2]][71:64] == d_addr[15:8])
					begin
					hit <= 1'b1;
					hit0 <= 1'b1;
					hit1 <= 1'b0;
					//cache[d_addr[7:2]][73:0] <= {1'b1,1'b1,d_addr[15:8],tocache};
					cache[d_addr[7:2]][72] <= 1'b1;
					cache[d_addr[7:2]][146] <= 1'b0;
					if(d_addr[1:0] == 2'b00)
						cachedata <= cache[d_addr[7:2]][63:48];
						else if(d_addr[1:0] == 2'b01)
						cachedata <= cache[d_addr[7:2]][47:32];
						else if(d_addr[1:0] == 2'b10)
						cachedata <= cache[d_addr[7:2]][31:16];
						else
						cachedata <= cache[d_addr[7:2]][15:0];
					end
				else if(cache[d_addr[7:2]][147] == 1'b1&&cache[d_addr[7:2]][145:138] == d_addr[15:8])
					begin
					hit <= 1'b1;
					hit1 <= 1'b1;
					hit0 <= 1'b0;
					//cache[d_addr[7:2]][147:74] <= {1'b1,1'b1,d_addr[15:8],tocache};
					cache[d_addr[7:2]][146] <= 1'b1;
					cache[d_addr[7:2]][72] <= 1'b0;
					if(d_addr[1:0] == 2'b00)
						cachedata <= cache[d_addr[7:2]][137:122];
						else if(d_addr[1:0] == 2'b01)
						cachedata <= cache[d_addr[7:2]][121:106];
						else if(d_addr[1:0] == 2'b10)
						cachedata <= cache[d_addr[7:2]][105:90];
						else
						cachedata <= cache[d_addr[7:2]][89:74];
					end
				else if(cache[d_addr[7:2]][73] == 1'b0)
				   begin
					hit <= 1'b0;
					hit0 <= 1'b0;
					hit1 <= 1'b0;
					miss <= miss + 1;
					cache[d_addr[7:2]][73:0] <= {1'b1,1'b1,d_addr[15:8],tocache};
					cache[d_addr[7:2]][146] <= 1'b0;
					end	
				else if(cache[d_addr[7:2]][147] == 1'b0)
					begin
					hit <= 1'b0;
					hit0 <= 1'b0;
					hit1 <= 1'b0;
					miss <= miss + 1;
					cache[d_addr[7:2]][147:74] <= {1'b1,1'b1,d_addr[15:8],tocache};
					cache[d_addr[7:2]][72] <= 1'b0;
 					end	
				else
					begin
					hit <= 1'b0;
					hit0 <= 1'b0;
					hit1 <= 1'b0;
					miss <= miss + 1;
					if(cache[d_addr[7:2]][146] == 1'b0)
						begin
						cache[d_addr[7:2]][147:74] <= {1'b1,1'b1,d_addr[15:8],tocache};
						cache[d_addr[7:2]][72] <= 1'b0;
						end
					else
						begin
						cache[d_addr[7:2]][73:0] <= {1'b1,1'b1,d_addr[15:8],tocache};
					   cache[d_addr[7:2]][146] <= 1'b0;
						end
					end
			end
	end	
end
endmodule
