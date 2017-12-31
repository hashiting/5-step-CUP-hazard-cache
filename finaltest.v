`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:55:39 03/13/2016
// Design Name:   haha
// Module Name:   E:/lab/CPU/finaltest.v
// Project Name:  CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: haha
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define NOP 5'b00000
`define HALT 5'b00001
`define LOAD 5'b00010
`define STORE 5'b00011
`define LDIH 5'b10000
`define ADD 5'b01000
`define ADDI 5'b01001
`define ADDC 5'b10001
`define CMP 5'b01100
`define AND 5'b01101
`define SLL 5'b00100
`define SRL 5'b00111
`define SLA 5'b00101
`define SRA 5'b10101
`define JUMP 5'b11000
`define JMPR 5'b11001
`define BZ 5'b11010
`define BNZ 5'b11011
`define BN 5'b11100
`define BC 5'b11110
`define SUB 5'b11111
`define XOR 5'b01010
`define OR 5'b10100
`define SUBI 5'b11101

`define idle 1'b0
`define exec 1'b1

`define gr0 3'b000
`define gr1 3'b001
`define gr2 3'b010
`define gr3 3'b011
`define gr4 3'b100
`define gr5 3'b101
`define gr6 3'b110
`define gr7 3'b111

module finaltest;

	// Inputs
	reg clock;
	reg clock1;
	reg [15:0] i_datain;
	reg [15:0] d_datain;
	reg reset;
	reg enable;
	reg start;

	// Outputs
	wire [7:0] d_addr;
	wire [7:0] i_addr;
	wire d_we;
	wire [15:0] d_dataout;

	// Instantiate the Unit Under Test (UUT)
	haha uut (
		.clock(clock), 
		.enable(enable), 
		.i_datain(i_datain), 
		.d_datain(d_datain), 
		.start(start), 
		.d_addr(d_addr), 
		.i_addr(i_addr), 
		.d_we(d_we), 
		.d_dataout(d_dataout)
	);

always#5
clock = ~clock;

always#1
clock1 = ~clock1;

	initial begin
		// Initialize Inputs
		clock = 0;
		clock1 = 0;
		reset = 0;
		enable = 0;
		start = 0;

		// Wait 100 ns for global reset to finish
		#100;
     $display("pc:     id_ir      :reg_A:reg_B:reg_C:da:dd:  :w:reC1:gr0 :gr1 : gr2 : gr3 : gr4 : gr5 : gr6 : gr7 : zf : nf : cf");
    $monitor("%h:%b:%h:%h:%h:%h:%h:%b:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h", 
	uut.pc, uut.id_ir, uut.reg_A, uut.reg_B, uut.reg_C,
   	d_addr, d_dataout, d_we, uut.reg_C1, uut.gr[0],uut.gr[1], uut.gr[2], uut.gr[3],uut.gr[4],uut.gr[5],uut.gr[6],uut.gr[7],uut.zf,uut.nf,uut.cf);
	
enable <= 1; start <= 0; i_datain <= 0;d_datain <= 0;

#10 reset <= 1;
#10 reset <= 0;
#10 start <=1;
#10 start <=0;
	end
      
endmodule

