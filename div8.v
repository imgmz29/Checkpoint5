module div8(reset, clk, q8);

 input reset, clk;
 output reg q8;
 reg q2, q4;
 
 initial begin
  q2 <= 1'b0;
 end
 
 always @(posedge clk or posedge reset) begin
  if (reset) begin
   q2 <= 1'b0;
  end
  else begin
   q2 <= ~q2;
  end
 end
 
 initial begin
  q4 <= 1'b0;
 end
 always @(posedge q2 or posedge reset ) begin
  if (reset) begin
   q4 <= 1'b0;
  end
  else begin
   q4 <= ~q4;
  end
 end
 
 initial begin
  q8 <= 1'b0;
 end
 always @(posedge q4 or posedge reset ) begin
  if (reset) begin
   q8 <= 1'b0;
  end
  else begin
   q8 <= ~q8;
  end
 end
 
endmodule