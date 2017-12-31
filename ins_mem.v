`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:14:35 03/16/2016 
// Design Name: 
// Module Name:    ins_mem 
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

module ins_mem(mem_clk,addr,rdata);
input mem_clk;
input [7:0] addr;
output [15:0] rdata;
reg [15:0] i_mem [255:0];

assign rdata = i_mem[addr];
always @(posedge mem_clk)
	case(addr)
	
	//------------------------------------TA的测试---------------------------------------//
	//最大公因数 最小公倍数：gcm
	/*0: i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
	1: i_mem[addr] <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0010};
	2: i_mem[addr] <= {`ADD, `gr3, 1'b0, `gr0, 1'b0, `gr1};//(1)
	3: i_mem[addr] <= {`SUB, `gr1, 1'b0, `gr1, 1'b0, `gr2};
	4: i_mem[addr] <= {`BZ, `gr0, 8'b0000_1001}; //jump to (2)
	5: i_mem[addr] <= {`BNN, `gr0,  8'b0000_0010}; //jump to (1)
	6: i_mem[addr] <= {`ADD, `gr1, 1'b0, `gr0, 1'b0, `gr2};
	7: i_mem[addr] <= {`ADD, `gr2, 1'b0, `gr0, 1'b0, `gr3};
	8:i_mem[addr] <= {`JUMP, 11'b000_0000_0010};//jump to (1)
	9:i_mem[addr] <= {`STORE, `gr2, 1'b0, `gr0, 4'b0011}; //(2)
	10: i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0001};
	11: i_mem[addr] <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0010};
	12:i_mem[addr] <= {`ADDI, `gr4, 8'h1}; //(3)
	13:i_mem[addr] <= {`SUB, `gr2, 1'b0, `gr2, 1'b0, `gr3};
	14:i_mem[addr] <= {`BZ, `gr0, 8'b0001_0000}; //jump to (4)
	15:i_mem[addr] <= {`JUMP, 11'b000_0000_1100}; //jump to (3)
	16:i_mem[addr] <= {`SUBI, `gr4, 8'h1}; //(4)
	17:i_mem[addr] <= {`BN, `gr0, 8'b0001_0100}; //jump to (5)
	18:i_mem[addr] <= {`ADD, `gr5, 1'b0, `gr5, 1'b0, `gr1};
	19:i_mem[addr] <= {`JUMP, 11'b000_0001_0000}; //jump to (4)
	20:i_mem[addr] <= {`STORE, `gr5, 1'b0, `gr0, 4'b0100}; //(5)
	21:i_mem[addr] <= {`LOAD, `gr1, 1'b0, `gr0, 4'b0011};//最大公因数
	22:i_mem[addr] <= {`LOAD, `gr2, 1'b0, `gr0, 4'b0100};//最小公倍数
	23:i_mem[addr] <= {`HALT, 11'b000_0000_0000};//*/
	
	//冒泡排序
	0: i_mem[addr] <= {`LOAD, `gr3, 1'b0, `gr0, 4'b0000};
	1: i_mem[addr] <= {`SUBI, `gr3, 4'd0, 4'd2};
	2: i_mem[addr] <= {`ADD, `gr1, 1'b0, `gr0, 1'b0, `gr0};
	3: i_mem[addr] <= {`ADD, `gr2, 1'b0, `gr3, 1'b0, `gr0}; // loop1
	4: i_mem[addr] <= {`LOAD, `gr4, 1'b0, `gr2, 4'd1}; // loop2
	5: i_mem[addr] <= {`LOAD, `gr5, 1'b0, `gr2, 4'd2};
	6: i_mem[addr] <= {`CMP, 3'd0, 1'b0, `gr5, 1'b0, `gr4};
	7: i_mem[addr] <= {`BN, `gr0, 4'b0000, 4'b1010};
	8:i_mem[addr] <= {`STORE, `gr4, 1'b0, `gr2, 4'd2};
	9:i_mem[addr] <= {`STORE, `gr5, 1'b0, `gr2, 4'd1};
	10: i_mem[addr] <= {`SUBI, `gr2, 4'd0, 4'd1};
	11: i_mem[addr] <= {`CMP, 3'd0, 1'b0, `gr2, 1'b0, `gr1};
	12:i_mem[addr] <= {`BNN, `gr0, 4'h0, 4'b0100};
	13:i_mem[addr] <= {`ADDI, `gr1, 4'd0, 4'd1};
	14:i_mem[addr] <= {`CMP, 3'd0, 1'b0, `gr3, 1'b0, `gr1};
	15:i_mem[addr] <= {`BNN, `gr0, 4'h0, 4'b0011};
	16:i_mem[addr] <= {`HALT, 11'd0};//*/
	
	//sort
	/*0: i_mem[addr] <= {`ADDI, `gr1, 4'b0000,  4'b1001};
	1: i_mem[addr] <= {`ADDI, `gr2, 4'b0000,  4'b1001};
	2: i_mem[addr] <= {`JUMP, 11'b000_0000_0101};//jump to start
	3: i_mem[addr] <= {`SUBI, `gr1, 4'd0, 4'd1};//new_round
	4: i_mem[addr] <= {`BZ, `gr7, 4'b0001, 4'b0010};//jump to end
	5: i_mem[addr] <= {`LOAD, `gr3, 1'b0, `gr0, 4'd0};//start
	6: i_mem[addr] <= {`LOAD, `gr4, 1'b0, `gr0, 4'd1};
	7: i_mem[addr] <= {`CMP, 3'd0, 1'b0, `gr3, 1'b0, `gr4};
	8:i_mem[addr] <= {`BN, `gr7, 4'h0, 4'b1011};//jump to NO_op
	9:i_mem[addr] <= {`STORE, `gr3, 1'b0, `gr0, 4'd1};
	10: i_mem[addr] <= {`STORE, `gr4, 1'b0, `gr0, 4'd0};
	11: i_mem[addr] <= {`ADDI, `gr0, 4'b0000, 4'b0001};//NO_OP
	12:i_mem[addr] <= {`CMP, 3'd0, 1'b0, `gr0, 1'b0, `gr2};
	13:i_mem[addr] <= {`BN, `gr7, 4'b0001, 4'b0001};//jump to continue 
	14:i_mem[addr] <= {`SUBI, `gr2, 4'd0, 4'd1};
	15:i_mem[addr] <= {`SUB, `gr0, 1'b0,`gr0, 1'b0,`gr0};
	16:i_mem[addr] <= {`JUMP, 11'b000_0000_0011};//jump to new round
	17:i_mem[addr] <= {`JUMP, 11'b000_0000_0101};//jump to start,continue
	18:i_mem[addr] <= {`HALT, 11'd0};//end */
	   
		/*/64位加法:64badder
	   0:i_mem[addr]=16'h4c04 ;
		1:i_mem[addr]=16'h1100 ;
		2:i_mem[addr]=16'h1204 ;
		3:i_mem[addr]=16'h4312 ;
		4:i_mem[addr]=16'hfd06 ;//bnc to 6
		5:i_mem[addr]=16'h4e01 ;
		6:i_mem[addr]=16'h4337 ;	
		7:i_mem[addr]=16'hfd0b ;//bnc to 11
		8:i_mem[addr]=16'h5e00 ;
		9:i_mem[addr]=16'hdd0b ;//bnz to 11
		10:i_mem[addr]=16'h4e01 ;   
		11:i_mem[addr]=16'h5777 ;	
		12:i_mem[addr]=16'h4776 ;  
		13:i_mem[addr]=16'h5666 ;		
		14:i_mem[addr]=16'h1b08 ;
		15:i_mem[addr]=16'h4801 ;		
		16:i_mem[addr]=16'h6004 ;
		17:i_mem[addr]=16'he501 ;//bn to 1
		18:i_mem[addr]=16'h0800 ;//*/
		     	
		//*/	所有指令测一遍：tinit_test
		/*0:i_mem[addr]=16'h4f10 ;//00{`ADDI,`gr7,4'd1,4'd0};              // gr7 <= 16'h10 for store address
		1:i_mem[addr]=16'h81b6 ;//01{`LDIH,`gr1,4'b1011,4'b0110};        // test for LDIH  gr1<="16'hb600"
		2:i_mem[addr]=16'h1970 ;//02{`STORE,`gr1,1'b0,`gr7,4'h0};        ;// store to mem10	
		3:i_mem[addr]=16'h1100 ;//03{`LOAD,`gr1,1'b0,`gr0,4'h0};         ;// gr1 <= fffd 
		4:i_mem[addr]=16'h1201 ;//04{`LOAD,`gr2,1'b0,`gr0,4'h1};         ;// gr2 <= 4
		5:i_mem[addr]=16'h8b12 ;//05{`ADDC,`gr3,1'b0,`gr1,1'b0,`gr2};    ;// gr3 <= fffd + 4 + cf(=0) = 1, cf<=1
		6:i_mem[addr]=16'h1b71 ;//06{`STORE,`gr3,1'b0,`gr7,4'h1};        ;// store to mem11		
		7:i_mem[addr]=16'h8b02 ;//07{`ADDC,`gr3,1'b0,`gr0,1'b0,`gr2};    ;// gr3 <= 0 + 4 + cf(=1) = 5, cf<=0
		8:i_mem[addr]=16'h1b72 ;//08{`STORE,`gr3,1'b0,`gr7,4'h2};        ;// store to mem12
		9:i_mem[addr]=16'h1102 ;//09{`LOAD,`gr1,1'b0,`gr0,4'h2};          ;// gr1 <= 5 
		10:i_mem[addr]=16'h9312 ;//0a{`SUBC,`gr3,1'b0,`gr1,1'b0,`gr2};    ;// gr3 <= 5 - 4 + cf(=0) =1, cf<=0    
		11:i_mem[addr]=16'h1b73 ;//0b{`STORE,`gr3,1'b0,`gr7,4'h3};        ;// store to mem13		
		12:i_mem[addr]=16'h5321 ;//0c{`SUB,`gr3,1'b0,`gr2,1'b0,`gr1};     ;// gr3 <= 4 - 5 = -1, cf<=1    
		13:i_mem[addr]=16'h1b74 ;//0d{`STORE,`gr3,1'b0,`gr7,4'h4};        ;// store to mem14		
		14:i_mem[addr]=16'h9321 ;//0e{`SUBC,`gr3,1'b0,`gr2,1'b0,`gr1};    ;// gr3 <= 5 - 4 - cf(=1) =2, cf<=0 
		15:i_mem[addr]=16'h1b75 ;//0f{`STORE,`gr3,1'b0,`gr7,4'h5};        ;// store to mem15		
		16:i_mem[addr]=16'h1103 ;//10{`LOAD,`gr1,1'b0,`gr0,4'h3};         ;// gr1 <= c369
		17:i_mem[addr]=16'h1204 ;//11{`LOAD,`gr2,1'b0,`gr0,4'h4};         ;// gr2 <= 69c3		
		18:i_mem[addr]=16'h6b12 ;//12{`AND,`gr3,1'b0,`gr1,1'b0,`gr2};     ;// gr3 <= gr1 & gr2 = 4141
		19:i_mem[addr]=16'h1b76 ;//13{`STORE,`gr3,1'b0,`gr7,4'h6};        ;// store to mem16		
		20:i_mem[addr]=16'h7312 ;//14{`OR,`gr3,1'b0,`gr1,1'b0,`gr2};      ;// gr3 <= gr1 | gr2 = ebeb
		21:i_mem[addr]=16'h1b77 ;//15{`STORE,`gr3,1'b0,`gr7,4'h7};        ;// store to mem17		
		22:i_mem[addr]=16'h7b12 ;//16{`XOR,`gr3,1'b0,`gr1,1'b0,`gr2};     ;// gr3 <= gr1 ^ gr2 = aaaa
		23:i_mem[addr]=16'h1b78 ;//17{`STORE,`gr3,1'b0,`gr7,4'h8};        ;// store to mem18
		24:i_mem[addr]=16'h2310 ;//18{`SLL,`gr3,1'b0,`gr1,4'h0};          ;// gr3 <= gr1 < 0 
		25:i_mem[addr]=16'h1b79 ;//19{`STORE,`gr3,1'b0,`gr7,4'h9};        ;// store to mem19		
		26:i_mem[addr]=16'h2311 ;//1a{`SLL,`gr3,1'b0,`gr1,4'h1};          ;// gr3 <= gr1 < 1 
		27:i_mem[addr]=16'h1b7a ;//1b{`STORE,`gr3,1'b0,`gr7,4'ha};        ;// store to mem1a		
		28:i_mem[addr]=16'h2314 ;//1c{`SLL,`gr3,1'b0,`gr1,4'h4};          ;// gr3 <= gr1 < 8 
		29:i_mem[addr]=16'h1b7b ;//1d{`STORE,`gr3,1'b0,`gr7,4'hb};        ;// store to mem1b	
		30:i_mem[addr]=16'h231f ;//1e{`SLL,`gr3,1'b0,`gr1,4'hf};          ;// gr3 <= gr1 < 15 
		31:i_mem[addr]=16'h1b7c ;//1f{`STORE,`gr3,1'b0,`gr7,4'hc};        ;// store to mem1c
		32:i_mem[addr]=16'h3310 ;//20{`SRL,`gr3,1'b0,`gr1,4'h0};          ;// gr3 <= gr1 > 0
		33:i_mem[addr]=16'h1b7d ;//21{`STORE,`gr3,1'b0,`gr7,4'hd};        ;// store to mem1d		
		34:i_mem[addr]=16'h3311 ;//22{`SRL,`gr3,1'b0,`gr1,4'h1};          ;// gr3 <= gr1 > 1
		35:i_mem[addr]=16'h1b7e ;//23{`STORE,`gr3,1'b0,`gr7,4'he};        ;// store to mem1e		
		36:i_mem[addr]=16'h3318 ;//24{`SRL,`gr3,1'b0,`gr1,4'h8};          ;// gr3 <= gr1 > 8
		37:i_mem[addr]=16'h1b7f ;//25{`STORE,`gr3,1'b0,`gr7,4'hf};        ;// store to mem1f		
		38:i_mem[addr]=16'h331f ;//26{`SRL,`gr3,1'b0,`gr1,4'hf};          ;// gr3 <= gr1 > 15
		39:i_mem[addr]=16'h4f10 ;//27{`ADDI,`gr7,4'd1,4'd0};              ;// gr7 <= 16'h20 for store address
		40:i_mem[addr]=16'h1b70 ;//28{`STORE,`gr3,1'b0,`gr7,4'h0};        ;// store to mem20
		41:i_mem[addr]=16'h2b10 ;//29{`SLA,`gr3,1'b0,`gr1,4'h0};          ;// gr3 <= gr1 < 0
		42:i_mem[addr]=16'h1b71 ;//2a{`STORE,`gr3,1'b0,`gr7,4'h1};        ;// store to mem21
		43:i_mem[addr]=16'h2b11 ;//2b{`SLA,`gr3,1'b0,`gr1,4'h1};          ;// gr3 <= gr1 < 1 
		44:i_mem[addr]=16'h1b72 ;//2c{`STORE,`gr3,1'b0,`gr7,4'h2};        ;// store to mem22
		45:i_mem[addr]=16'h2b18 ;//2d{`SLA,`gr3,1'b0,`gr1,4'h8};          ;// gr3 <= gr1 < 8 
		46:i_mem[addr]=16'h1b73 ;//2e{`STORE,`gr3,1'b0,`gr7,4'h3};        ;// store to mem23
		47:i_mem[addr]=16'h2b1f ;//2f{`SLA,`gr3,1'b0,`gr1,4'hf};          ;// gr3 <= gr1 < 15
		48:i_mem[addr]=16'h1b74 ;//30{`STORE,`gr3,1'b0,`gr7,4'h4};        ;// store to mem24
		49:i_mem[addr]=16'h2b20 ;//31{`SLA,`gr3,1'b0,`gr2,4'h0};          ;// gr3 <= gr1 < 0
		50:i_mem[addr]=16'h1b75 ;//32{`STORE,`gr3,1'b0,`gr7,4'h5};        ;// store to mem25
		51:i_mem[addr]=16'h2b21 ;//33{`SLA,`gr3,1'b0,`gr2,4'h1};          ;// gr3 <= gr1 < 1
		52:i_mem[addr]=16'h1b76 ;//34{`STORE,`gr3,1'b0,`gr7,4'h6};        ;// store to mem26
		53:i_mem[addr]=16'h2b28 ;//35{`SLA,`gr3,1'b0,`gr2,4'h8};          ;// gr3 <= gr1 < 8
		54:i_mem[addr]=16'h1b77 ;//36{`STORE,`gr3,1'b0,`gr7,4'h7};        ;// store to mem27
		55:i_mem[addr]=16'h2b2f ;//37{`SLA,`gr3,1'b0,`gr2,4'hf};          ;// gr3 <= gr1 < 15
		56:i_mem[addr]=16'h1b78 ;//38{`STORE,`gr3,1'b0,`gr7,4'h8};        ;// store to mem28
		57:i_mem[addr]=16'h3b10 ;//39{`SRA,`gr3,1'b0,`gr1,4'h0};          ;// gr3 <= gr1 > 0
		58:i_mem[addr]=16'h1b79 ;//3a{`STORE,`gr3,1'b0,`gr7,4'h9};        ;// store to mem29
		59:i_mem[addr]=16'h3b11 ;//3b{`SRA,`gr3,1'b0,`gr1,4'h1};          ;// gr3 <= gr1 > 1!!
		60:i_mem[addr]=16'h1b7a ;//3c{`STORE,`gr3,1'b0,`gr7,4'ha};        ;// store to mem2a
		61:i_mem[addr]=16'h3b18 ;//3d{`SRA,`gr3,1'b0,`gr1,4'h8};          ;// gr3 <= gr1 > 8
		62:i_mem[addr]=16'h1b7b ;//3e{`STORE,`gr3,1'b0,`gr7,4'hb};        ;// store to mem2b
		63:i_mem[addr]=16'h3b1f ;//3f{`SRA,`gr3,1'b0,`gr1,4'hf};          ;// gr3 <= gr1 > 15
		64:i_mem[addr]=16'h1b7c ;//40{`STORE,`gr3,1'b0,`gr7,4'hc};        ;// store to mem2c
		65:i_mem[addr]=16'h3b20 ;//41{`SRA,`gr3,1'b0,`gr2,4'h0};          ;// gr3 <= gr1 > 0
		66:i_mem[addr]=16'h1b7d ;//42{`STORE,`gr3,1'b0,`gr7,4'hd};        ;// store to mem2d
		67:i_mem[addr]=16'h3b21 ;//43{`SRA,`gr3,1'b0,`gr2,4'h1};          ;// gr3 <= gr1 > 1
		68:i_mem[addr]=16'h1b7e ;//44{`STORE,`gr3,1'b0,`gr7,4'he};        ;// store to mem2e
		69:i_mem[addr]=16'h3b28 ;//45{`SRA,`gr3,1'b0,`gr2,4'h8};          ;// gr3 <= gr1 > 8
		70:i_mem[addr]=16'h1b7f ;//46{`STORE,`gr3,1'b0,`gr7,4'hf};        ;// store to mem2f
		71:i_mem[addr]=16'h4f10 ;//47{`ADDI,`gr7,4'd1,4'd0};              ;// gr7 <= 16'h30 for store address
		72:i_mem[addr]=16'h3b2f ;//48{`SRA,`gr3,1'b0,`gr2,4'hf};          ;// gr3 <= gr1 > 15
		73:i_mem[addr]=16'h1b70 ;//49{`STORE,`gr3,1'b0,`gr7,4'h0};        ;// store to mem30		
		74:i_mem[addr]=16'h1105 ;//4a{`LOAD,`gr1,1'b0,`gr0,4'h5};         ;// gr1 <= 41
		75:i_mem[addr]=16'h1206 ;//4b{`LOAD,`gr2,1'b0,`gr0,4'h6};         ;// gr2 <= ffff
		76:i_mem[addr]=16'h1307 ;//4c{`LOAD,`gr3,1'b0,`gr0,4'h7};         ;// gr3 <= 1
		77:i_mem[addr]=16'hc04f ;//4d{`JUMP, 3'd0,8'h4f};                 ;// jump to 4f
		78:i_mem[addr]=16'h1f71 ;//4e{`STORE,`gr7,1'b0,`gr7,4'h1};        ;// store to mem31
		79:i_mem[addr]=16'hc910 ;//4f{`JMPR, `gr1,8'h10};                 ;// jump to 41+10 = 51
		80:i_mem[addr]=16'h1f72 ;//50{`STORE,`gr7,1'b0,`gr7,4'h2};        ;// store to mem32
		81:i_mem[addr]=16'h4423 ;//51{`ADD, `gr4,1'b0,`gr2,1'b0,`gr3};    ;// gr4<= ffff + 1,cf<=1
		82:i_mem[addr]=16'hf928 ;//52{`BNC,`gr1,8'h28};                   ;// if(cf==0) jump to 69
		83:i_mem[addr]=16'hf114 ;//53{`BC,`gr1,8'h14};                    ;// if(cf==1) jump to 55
		84:i_mem[addr]=16'h1f73 ;//54{`STORE,`gr7,1'b0,`gr7,4'h3};        ;// store to mem33
		85:i_mem[addr]=16'h4433 ;//55{`ADD, `gr4,1'b0,`gr3,1'b0,`gr3};    ;// gr4<= 1 + 1 , cf<=0
		86:i_mem[addr]=16'hf128 ;//56{`BC,`gr1,8'h28};                    ;// if(cf==1) jump to 69
		87:i_mem[addr]=16'hf918 ;//57{`BNC,`gr1,8'h18};                   ;// if(cf==0) jump to 59
		88:i_mem[addr]=16'h1f74 ;//58{`STORE,`gr7,1'b0,`gr7,4'h4};        ;// store to mem34
		89:i_mem[addr]=16'h6033 ;//59{`CMP, 3'd0,1'b0,`gr3,1'b0,`gr3};    ;// 1-1=0 , zf<=1,nf<=0
		90:i_mem[addr]=16'hd928 ;//5a{`BNZ,`gr1,8'h28};                   ;// if(zf==0) jump to 69
		91:i_mem[addr]=16'hd11c ;//5b{`BZ,`gr1,8'h1c};                    ;// if(zf==1) jump to 5d
		92:i_mem[addr]=16'h1f75 ;//5c{`STORE,`gr7,1'b0,`gr7,4'h5};        ;// store to mem35
		93:i_mem[addr]=16'h6043 ;//5d{`CMP, 3'd0,1'b0,`gr4,1'b0,`gr3};    ;// 2-1=1 , zf<=0,nf<=0 
		94:i_mem[addr]=16'hd128 ;//5e{`BZ,`gr1,8'h28};                    ;// if(zf==1) jump to 69
		95:i_mem[addr]=16'hd920 ;//5f{`BNZ,`gr1,8'h20};                   ;// if(zf==0) jump to 61
		96:i_mem[addr]=16'h1f76 ;//60{`STORE,`gr7,1'b0,`gr7,4'h6};        ;// store to mem36
		97:i_mem[addr]=16'h6034 ;//61{`CMP, 3'd0,1'b0,`gr3,1'b0,`gr4};    ;// 1-2=-1, nf<=1,zf<=0
		98:i_mem[addr]=16'he928 ;//62{`BNN,`gr1,8'h28};                   ;// if(nf==0) jump to 69
		99:i_mem[addr]=16'he124 ;//63{`BN,`gr1,8'h24};                    ;// if(nf==1) jump to 65 
		100:i_mem[addr]=16'h1f77 ;//64{`STORE,`gr7,1'b0,`gr7,4'h7};        ;// store to mem37
		101:i_mem[addr]=16'h6043 ;//65{`CMP, 3'd0,1'b0,`gr4,1'b0,`gr3};    ;// 2-1=1, nf<=0,zf<=0
		102:i_mem[addr]=16'he128 ;//66{`BN,`gr1,8'h28};                    ;// if(nf==1) jump to 69
		103:i_mem[addr]=16'he927 ;//67{`BNN,`gr1,8'h27};                   ;// if(nf==0) jump to 68
		104:i_mem[addr]=16'h1f78 ;//68{`STORE,`gr7,1'b0,`gr7,4'h8};        ;// store to mem38
		105:i_mem[addr]=16'h0800 ;//69{`HALT, 11'd0};                      // STOP*/
	
	
	default: i_mem[addr] <= {`HALT, 11'b000_0000_0000};
	endcase
endmodule
