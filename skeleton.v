module skeleton(clock, reset, imem_clock, dmem_clock, processor_clock, regfile_clock
//	 ctrl_writeEnable,               
//    ctrl_writeReg,                  
//    ctrl_readRegA,    
//    ctrl_readRegB,              
//    data_writeReg,                  
//    data_readRegA,               
//    data_readRegB,
//	 q_imem,
//	 immd,
//	 data_operandB,
//	 alu_result,
//	 overflow,
//	 write_data,
//	 address_imem,
//	 address_dmem,
//	 data, 
//	 q_dmem,
//	 wren,
//	 
//	 counter,
//	 DMwe,
//	 
//	 ex_immd,
//	 j, bne, jal, jr, blt, bex, setx, sel_1_ctrl, sel_2_ctrl, sel_3_ctrl, sel_1_out, sel_2_out, sel_3_out
	 );
	 
	 
    input clock, reset;

    output imem_clock, dmem_clock, processor_clock, regfile_clock;
	 
	 /*
	 output wire ctrl_writeEnable;
    output wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output wire [31:0] data_writeReg;
    output wire [31:0] data_readRegA, data_readRegB;
	 output wire[31:0] q_imem;
	 */
	 // mark!!!!!!!!
	 /*
	 output wire j, bne, jal, jr, blt, bex, setx;
	 output wire sel_1_ctrl, sel_2_ctrl, sel_3_ctrl;
	 output wire [31:0] sel_1_out, sel_2_out, sel_3_out;
	 */
	 
	 wire ctrl_writeEnable;
    wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    wire [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;
	 wire[31:0] q_imem;
	 
	 
	 /* test */
	 /*
	 output wire[16:0] immd;
	 output wire[31:0] data_operandB;
	 output wire[31:0] alu_result;
	 output wire overflow;
	 output wire [31:0] write_data;
	 output wire [2:0] counter;
	 output wire DMwe;
	 
	 output wire[31:0] ex_immd;
	 */
	 /* test */
	 /*
	 output wire [11:0] address_imem;
	 output wire [11:0] address_dmem;
    output wire [31:0] data;
    output wire  wren;
    output wire [31:0] q_dmem;
	 */
	 
	 wire [11:0] address_imem;
	 wire [11:0] address_dmem;
    wire [31:0] data;
    wire  wren;
    wire [31:0] q_dmem;
	 
	 
	 
	
	 /** clock **/
	 
	 //process
	 //div8 PC_ctrl(reset, clock, processor_clock);
	 assign processor_clock = clock;
	 //imem
	 //div_1_ctrl imem_ctrl(clock, 3'b001, reset, imem_clock);
	 //Register
	 div_1_ctrl Reg_ctrl(clock, 3'b000, reset, regfile_clock);
	 //dmem_clock
	 //div_2_ctrl dmem_ctrl(clock, 3'b101, 3'b000, reset, dmem_clock);
	 assign dmem_clock = clock;
	 
	 assign imem_clock = ~clock;  
	 //assign dmem_clock = ~clock; 

    /** IMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!

    imem my_imem(
        .address    (address_imem),            // address of data
        .clock      (imem_clock),                  // you may need to invert the clock
        .q          (q_imem)                   // the raw instruction
    );

    /** DMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
//    wire [11:0] address_dmem;
//    wire [31:0] data;
//    wire wren;
//    wire [31:0] q_dmem;
    dmem my_dmem(
        .address    (address_dmem),       // address of data
        .clock      (dmem_clock),              // may need to invert the clock
        .data	    (data),     // data you want to write
        .wren	    (wren),       // write enable
        .q          (q_dmem)   // data from dmem
    );

    /** REGFILE **/
    // Instantiate your regfile
//    wire ctrl_writeEnable;
//    wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
//    wire [31:0] data_writeReg;
//    wire [31:0] data_readRegA, data_readRegB;
    regfile my_regfile(
        regfile_clock,
        ctrl_writeEnable,
        reset,
        ctrl_writeReg,
        ctrl_readRegA,
        ctrl_readRegB,
        data_writeReg,
        data_readRegA,
        data_readRegB
    );

    /** PROCESSOR **/
    processor my_processor(
        // Control signals
        processor_clock,                // I: The master clock
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
//		 immd,
//		 data_operandB,
//		 alu_result,
//		 overflow,
//		 write_data,
//		 
//		 counter,
//		 DMwe,
//		 
//		 ex_immd,
//		 j, bne, jal, jr, blt, bex, setx, sel_1_ctrl, sel_2_ctrl, sel_3_ctrl, sel_1_out, sel_2_out, sel_3_out
				  
			 );

endmodule