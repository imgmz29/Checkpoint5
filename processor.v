/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
	 
	 // test
//	 immd,
//	 data_operandB,
//	 alu_result,
//	 overflow,
//	 write_data,
//	 counter,
//	 DMwe,
//	 ex_immd, j, bne, jal, jr, blt, bex, setx, sel_1_ctrl, sel_2_ctrl, sel_3_ctrl, sel_1_out, sel_2_out, sel_3_out
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;
	 
	 
	 
	 
	 
	 /* output for test */
	 /*
	 output wire[16:0] immd;
	 output wire[31:0] data_operandB;
	 output wire[31:0] alu_result;
	 output wire overflow;
	 output wire [31:0] write_data;
	 output reg[2:0] counter;
	 output DMwe;
	 output wire[31:0] ex_immd;
	 */
	 /* test */

	 
	 
	 
    /* YOUR CODE STARTS HERE */
	 
	 
	 /* necessary wire definition */
	 reg [31:0] PC;
	 wire processor_clock;
	 
	 // controller
	 wire ALUinB, Rwe, Rwd, R_type, add, addi, sub, and1, or1, sll, sra, sw, j, bne, jal, jr, blt, bex, setx;
	 // mark!!!!!!!
	 //output wire j, bne, jal, jr, blt, bex, setx;
	 
	 // Regfile
	 wire [4:0] temp_ctrl_A, temp_ctrl_B, temp_ctrl_W, temp2_ctrl_W, temp2_ctrl_B;
	 
	 wire [31:0] sel_Rwd_out, sel_setx_out;
	 
	 // Alu
	 wire isNotEqual, isLessThan;
	 wire[4:0] ALUop;
	 wire[4:0] ctrl_shiftamt;
	 
	 // J type
	 wire [16:0] N;
	 wire [31:0] ex_N;
	 wire [26:0] T;
	 wire [31:0] ex_T;
	 // mark!!!!!!!
	 wire sel_1_ctrl, sel_2_ctrl, sel_3_ctrl;
	 wire [31:0] sel_1_out, sel_2_out, sel_3_out;
	 
	 //output wire sel_1_ctrl, sel_2_ctrl, sel_3_ctrl;
	 //output wire [31:0] sel_1_out, sel_2_out, sel_3_out;
	 /* necessary wire definition */
	 
	 
	 
	 
	 /* PC clock update */
	 //module pc (clk, reset, in, out);
	 // initialize my PC = 0
	 
	 initial begin
		PC = 32'd0;
	 end
	 
	 
	 div8 PC_ctrl(reset, clock, processor_clock);
	 
	 always@(posedge processor_clock) begin
		if (reset == 1'b1) begin
			PC = 32'd0;
		end
		else begin
			PC = sel_3_out;
		end
	 end
	 
	 

	 
	 /* Imem */
	 // the next instruction address
	 assign address_imem = PC[11:0];
	 
	
	
	
	 
	 // get control code
	 controller contol_bit(q_imem, ALUinB, DMwe, Rwe, Rwd, R_type, add, addi, sub, and1, or1, sll, sra, sw, j, bne, jal, jr, blt, bex, setx);
	 
	 
	 
	 
	 /* Regfile */
	 
	 // ctrl_readA
	 assign temp_ctrl_A = bex ? 5'd30 : q_imem[21:17];
	 assign ctrl_readRegA = (jr | blt | bne) ? q_imem[26:22] : temp_ctrl_A;
	 
	 // ctrl_readB
	 assign temp_ctrl_B = bex ? 5'd0 : q_imem[16:12];
	 assign temp2_ctrl_B = (blt | bne) ? temp_ctrl_A : temp_ctrl_B;
	 assign ctrl_readRegB = sw ? q_imem[26:22] : temp2_ctrl_B;
	 
	 // ctrl_write
	 assign temp_ctrl_W = setx ? 5'd30 : q_imem[26:22];
	 assign temp2_ctrl_W = jal ? 5'd31 : temp_ctrl_W;
	 /* overflow */
	 assign ctrl_writeReg = (overflow || q_imem == 32'd0) ? 5'b11110 : temp2_ctrl_W;
	 
	 
	 // write_Enable
	 assign ctrl_writeEnable = Rwe;
	 
	 assign write_data = ~overflow ? alu_result : ((add & overflow) ? 32'd1 : ((addi & overflow) ? 32'd2 : 32'd3));
	 // Regfile write
	 assign sel_Rwd_out = Rwd ? q_dmem : write_data;
	 assign sel_setx_out = setx ? ex_T : sel_Rwd_out;
	 // mark
	 assign data_writeReg = jal ? PC + 32'd1 : sel_setx_out;


	 
	 
	 
	 
	 
	 /* ALU */
	 assign immd = q_imem[16:0];
	 //module sign_extend(input data, output extended); 
	 sign_extend extend(immd, ex_immd);
	 assign data_operandB =  ALUinB? ex_immd : data_readRegB;
	 assign ALUop = R_type ? q_imem[6:2] : 5'b0;
	 assign ctrl_shiftamt = R_type ? q_imem[11:7] : 5'b0;
	 alu alu1(data_readRegA, data_operandB, ALUop, ctrl_shiftamt, alu_result, isNotEqual, isLessThan, overflow);
	 
	 
	 
	 
	 /* J type */
	 
	 // N and N extend
	 assign N = q_imem[16:0];
	 assign ex_N = {15'b0, N};
	 // T and T extend
	 assign T = q_imem[26:0];
	 assign ex_T = {5'b0, T};
	 
	 // J type
	 assign sel_1_ctrl = (isNotEqual & bex) | j | jal;
	 assign sel_1_out = sel_1_ctrl ? ex_T : PC + 32'd1;
	 
	 assign sel_2_ctrl = (isLessThan & blt) | (isNotEqual & bne);
	 assign sel_2_out = sel_2_ctrl ? 32'd1 + ex_N + PC : sel_1_out;
	 
	 assign sel_3_ctrl = jr;
	 assign sel_3_out = sel_3_ctrl ? data_readRegA : sel_2_out;
	 
	 
	 
	 
	 
	 // Dmem
	 // use a counter to read and write
	 initial begin
		counter = 3'b000;
	 end
	 always@(posedge clock) begin
		if (counter == 3'b111) begin
			counter = 3'b000;
		end
		else begin
			counter = counter + 3'b001;
		end
	end
	 assign wren = (counter == 3'b111) ? DMwe : 0;
	 assign address_dmem = alu_result;
	 assign data = data_readRegB;
	 
	 
	 

	 
	 
	 
	 
	 


	 
endmodule































