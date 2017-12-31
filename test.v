`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:58:39 01/03/2016
// Design Name:   haha
// Module Name:   E:/lab/CPU/twst.v
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

module test;

	// Inputs
	reg clock;
	reg reset;
	reg [15:0] i_datain;
	reg [15:0] d_datain;
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
		.reset(reset), 
		.i_datain(i_datain), 
		.d_datain(d_datain), 
		.enable(enable), 
		.start(start), 
		.d_addr(d_addr), 
		.i_addr(i_addr), 
		.d_we(d_we), 
		.d_dataout(d_dataout)
	);
always#5
begin
clock = ~clock;
end
	initial begin
		// Initialize Inputs
		clock = 0;
		reset = 0;
		i_datain = 0;
		d_datain = 0;
		enable = 0;
		start = 0;

		// Wait 100 ns for global reset to finish
		#100;
      $display("pc:     id_ir      :reg_A:reg_B:reg_C:da:dd:  :w:reC1:gr0 :gr1 : gr2 : gr3 : gr4 : gr5 : gr6 : gr7 : zf : nf : cf");
    $monitor("%h:%b:%h:%h:%h:%h:%h:%b:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h", 
	uut.pc, uut.id_ir, uut.reg_A, uut.reg_B, uut.reg_C,
   	d_addr, d_dataout, d_we, uut.reg_C1, uut.gr[0],uut.gr[1], uut.gr[2], uut.gr[3],uut.gr[4],uut.gr[5],uut.gr[6],uut.gr[7],uut.zf,uut.nf,uut.cf);
	
enable <= 1; start <= 0; i_datain <= 0; d_datain <= 0; 

#10 reset <= 1;
#10 reset <= 0;
#10 enable <= 1;
#10 start <=1;
#10 start <=0;
	i_datain<= {`LOAD,`gr1,1'b0,`gr0,4'b0000};//01
#10	i_datain<= {`LOAD,`gr2,1'b0,`gr0,4'b0001};//02
#10	i_datain <= {`LOAD,`gr3,1'b0,`gr0,4'b0010};//03
#10	i_datain<= {`NOP,11'b000_0000_0000};
d_datain<=16'h13ab;
#10	i_datain<= {`NOP,11'b000_0000_0000};
d_datain<=16'h14cc;
#10	i_datain<= {`NOP,11'b000_0000_0000};
d_datain<=16'h00cc;
#10	i_datain<= {`AND,`gr4,1'b0,`gr1,1'b0,`gr2}; //13ab and 14cc = 1088//07
#10 	i_datain<= {`OR,` gr5,1'b0,`gr1,1'b0,`gr2}; //13ab or 14cc = 17ef//08
#10 	i_datain<= {`XOR,` gr6,1'b0,`gr1,1'b0,`gr2}; //13ab xor 14cc = 0767//09
#10	i_datain<= {`NOP,11'b000_0000_0000};

#10	i_datain<= {`SLL,`gr7,1'b0,`gr4,4'b0010}; //1088 <<2 = 4220//0b
#10	i_datain<= {`SRL,`gr6,1'b0,`gr4,4'b0010}; //1088 >>2 = 0422//0c
#10	i_datain<= {`NOP,11'b000_0000_0000};
#10	i_datain<= {`NOP,11'b000_0000_0000};
#10	i_datain<= {`NOP,11'b000_0000_0000};
#10	i_datain<= {`SLA,`gr7,1'b0,`gr5,4'b0010}; //17ef <<<2 = 5fbc//10
#10	i_datain<= {`SRA,`gr6,1'b0,`gr5,4'b0010}; //17ef >>>2 = 05fb//11
#10	i_datain<= {`SUBI,`gr2,4'b1101,4'b1111}; //14cc-df = 13ed//12
#10	i_datain<= {`NOP,11'b000_0000_0000};
#10	i_datain<= {`NOP,11'b000_0000_0000};
#10	i_datain<= {`NOP,11'b000_0000_0000};

#10	i_datain<= {`CMP,3'b000,1'b0,`gr2,1'b0,`gr1};  // 13ed - 13ab = '0042 zf = 0//16

#10 i_datain<= {`LDIH,`gr5,4'b1111,4'b1111};//17ef + ff00 =  116ef cf = 1//17
#10	i_datain<= {`NOP,11'b000_0000_0000};
#10	i_datain<= {`NOP,11'b000_0000_0000};
#10  i_datain<= {`NOP,11'b000_0000_0000};
#10	i_datain<= {`ADDC,`gr3,1'b0,`gr1,1'b0,`gr2};  //13ab + 13ED + 1 = 2799//1b
#10	i_datain<= {`NOP,11'b000_0000_0000};
#10	i_datain<= {`NOP,11'b000_0000_0000};
#10  i_datain<= {`NOP,11'b000_0000_0000};
#10   i_datain<={`JUMP,8'b00000000,3'b001};//jumo to pc = 1;//1f
#10	i_datain<= {`NOP,11'b000_0000_0000};
#10	i_datain<= {`NOP,11'b000_0000_0000};
#10  i_datain<= {`NOP,11'b000_0000_0000};
#10 	i_datain <= {`HALT,11'b000_0000_0000};
	end
      
endmodule
