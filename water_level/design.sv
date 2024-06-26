// Design
module tank (
  input clk, rst, a, b,
  output s);
  wire activate;
  //module dff(input clk, rst, d, output reg q, nq);
  dff q0 (clk, rst, activate, s);  
  assign activate = ~a | s & ~b;
endmodule
 
// Flip-flop D
module dff(
	input clk, rst, d,
	output reg q, nq);
 
  always@(posedge clk or negedge rst)
      if (rst)
        q = 0;
      else
        q = d;
  assign nq = !q;
endmodule
