//00000 :  ADD
//00001 :  SUBTRACT
//00010 :  AND
//00011 :  OR
//00100 :  SLL
//00101 :  SRA
//wire [31:0] q_imem;

module controller(q_imem, ALUinB, DMwe, Rwe, Rwd, R_type, add, addi, sub, and1, or1, sll, sra, sw, j, bne, jal, jr, blt, bex, setx);
	input wire [31:0] q_imem;
	output wire ALUinB, DMwe, Rwe, Rwd, R_type, add, addi, sub, and1, or1, sll, sra, sw;
	output wire j, bne, jal, jr, blt, bex, setx;
	
	wire[4:0] op_code;
	assign op_code= q_imem[31:27];
	
	wire[4:0] alu_op;
	assign alu_op = q_imem[6:2];

	// R type
	assign R_type = ~op_code[4] & ~op_code[3] & ~op_code[2] & ~op_code[1] & ~op_code[0];
	assign add = R_type & ~alu_op[4] & ~alu_op[3] & ~alu_op[2] & ~alu_op[1] & ~alu_op[0];
	assign sub = R_type & ~alu_op[4] & ~alu_op[3] & ~alu_op[2] & ~alu_op[1] & alu_op[0];
	assign and1 = R_type & ~alu_op[4] & ~alu_op[3] & ~alu_op[2] & alu_op[1] & ~alu_op[0];
	assign or1 = R_type & ~alu_op[4] & ~alu_op[3] & ~alu_op[2] & alu_op[1] & alu_op[0];
	assign sll = R_type & ~alu_op[4] & ~alu_op[3] & alu_op[2] & ~alu_op[1] & ~alu_op[0];
	assign sra = R_type & ~alu_op[4] & ~alu_op[3] & alu_op[2] & ~alu_op[1] & alu_op[0];
	
	// I type
	assign addi = ~op_code[4] & ~op_code[3] & op_code[2] & ~op_code[1] & op_code[0];
	assign lw = ~op_code[4] & op_code[3] & ~op_code[2] & ~op_code[1] & ~op_code[0];
	assign sw = ~op_code[4] & ~op_code[3] & op_code[2] & op_code[1] & op_code[0];
	
	// I type j
	assign bne = ~op_code[4] & ~op_code[3] & ~op_code[2] & op_code[1] & ~op_code[0];
	assign blt = ~op_code[4] & ~op_code[3] & op_code[2] & op_code[1] & ~op_code[0];
	
	
	// J type
	assign j = ~op_code[4] & ~op_code[3] & ~op_code[2] & ~op_code[1] & op_code[0];
	assign jal = ~op_code[4] & ~op_code[3] & ~op_code[2] & op_code[1] & op_code[0];
	assign jr = ~op_code[4] & ~op_code[3] & op_code[2] & ~op_code[1] & ~op_code[0];
	assign bex = op_code[4] & ~op_code[3] & op_code[2] & op_code[1] & ~op_code[0];
	assign setx = op_code[4] & ~op_code[3] & op_code[2] & ~op_code[1] & op_code[0];
	
	
	// Controller
	assign DMwe = sw;
	assign Rwe = add | sub | and1 | or1 | sll | sra | addi | lw | setx | jal;
	assign Rwd = lw;
	assign ALUinB = addi | lw | sw;
	
endmodule
