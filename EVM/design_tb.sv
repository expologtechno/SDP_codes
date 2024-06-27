`include "design.sv"
module tb_top;
 reg [3:0] button;
 reg en=1'b0; 
 wire [7:0] bjp, jdu, rjd, bsp, inc, sp, inp, ncp, nota;
 // Instantiate the module
 evm dut(
 .button(button),
 .en(en),
 .bjp(bjp),
 .jdu(jdu),
 .rjd(rjd),
 .bsp(bsp),
 .inc(inc),
 .sp(sp),
 .inp(inp),
 .ncp(ncp),
 .nota(nota) );
 always #5 en = ~en;
 // Stimulus
 initial begin
 button = 4'b0001; // Increment bjp vote
 #10;
 button = 4'b0010; // Increment inc vote
 #10;
 button = 4'b0001; // Increment bjp vote
 #10;
 button = 4'b0010; // Increment inc vote
 #10;
 button = 4'b0001; // Increment bjp vote again
 #10;
 button = 4'b0001; // Increment bjp vote again
 #10;
 button = 4'b1000; // Increment inp vote
 #10;
 button = 4'b0001; // Increment bjp vote again
 #10;;
 button = 4'b0110; // Increment sp vote
 #10;
 button = 4'b0001; // Increment bjp vote again
 #10;
 button = 4'b0000; //nota
 #10; $stop;
 end
always@* begin
 
$monitor("bjp=%0d,jdu=%0d,rjd=%0d,bsp=%0d,inc=%0d,sp=%0d,inp=%0d,ncp=%0d,nota=%0d",bjp,jdu,rjd,bsp,inc,sp,inp,ncp,nota);
end
endmodule

