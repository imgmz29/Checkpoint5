module sign_extend(data, extended);
	input wire[16:0] data;
	output wire[31:0] extended;
	
	assign extended =  data[16]? {15'b1111_1111_1111_111,data} : {15'b0,data};

endmodule

