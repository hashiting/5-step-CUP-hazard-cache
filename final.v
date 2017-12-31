`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:09:59 03/14/2016
// Design Name:   haha
// Module Name:   E:/lab/CPU/final.v
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

module final;

	// Inputs
	reg clock;
	reg [2:0]flag;
	reg reset;
	reg clock1;
	//reg [15:0] i_datain;
	//reg [15:0] d_datain;
	reg enable;
	reg start;

	// Outputs
	wire [15:0] d_addr;
	wire [15:0] i_addr;
	wire d_we;
	wire [15:0] d_dataout;
	wire [6:0]a_g;
   wire [3:0]en;
	

	// Instantiate the Unit Under Test (UUT)
	haha uut (
		.clock(clock),
		.clock2(clock2),
      .flag(flag),		
		.reset(reset), 
		.clock1(clock1), 
		//.i_datain(i_datain), 
		//.d_datain(d_datain), 
		.enable(enable), 
		.start(start), 
		.d_addr(d_addr), 
		.i_addr(i_addr), 
		.d_we(d_we), 
		.d_dataout(d_dataout)
	);

always#5  clock = ~clock; 
always#2  clock2 = ~clock2;
always#1  clock1 = ~clock1; 
	initial begin
		// Initialize Inputs
		clock1 = 0;
		clock2 = 0;
		reset = 0;
		clock = 0;
		//i_datain = 0;
		//d_datain = 0;
		enable = 0;
		start = 0;

		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here
 $display("pc:idir:regA:regB:regC:dr:dout:w:reC1:gr0 :gr1 :gr2 :gr3 :gr4 :gr5 :gr6 :gr7 :zf:nf:cf:miss:hit:cachedata:d_in:tocache:");
    $monitor("%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:%h:", 
	uut.pc,uut.id_ir, uut.reg_A, uut.reg_B, uut.reg_C,
   	d_addr, d_dataout,d_we, uut.reg_C1, uut.gr[0],uut.gr[1], uut.gr[2], uut.gr[3],uut.gr[4],uut.gr[5],uut.gr[6],uut.gr[7],uut.zf,uut.nf,uut.cf,uut.miss,uut.hit,uut.cachedata,uut.d_datain,uut.tocache);
	
enable <= 1; 

#10 reset <= 1;start <=1;
#10 reset <= 0;
#10 start <= 0;



	end
      
endmodule

