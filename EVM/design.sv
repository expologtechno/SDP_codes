module evm (
 input [3:0] button,
 input en,
 output reg [7:0] bjp, jdu, rjd, bsp, inc, sp, inp, ncp, nota );

 
 // Initialize all registers to 0
 initial begin
 {bjp, jdu, rjd, bsp, inc, sp, inp, ncp, nota} = 64'b0;
 end
 
 // Count votes based on button press
 always @(posedge en) begin
 case(button)
 4'b0001 : bjp = bjp + 1;
 4'b0010 : inc = inc + 1;
 4'b0011 : rjd = rjd + 1;
 4'b0100 : jdu = jdu + 1;
 4'b0101 : bsp = bsp + 1;
 4'b0110 : sp = sp + 1;
 4'b0111 : ncp = ncp + 1;
 4'b1000 : inp = inp + 1;
 default : nota = nota + 1;
 endcase
 end
 
 // Determine the winner among all parties
 always @* begin 
 if (bjp > jdu && bjp > rjd && bjp > bsp && bjp > inc && bjp > sp && bjp >
ncp && bjp > inp && bjp > nota) begin
 $display("Winner is bjp");
 end
 else if (jdu > rjd && jdu > bsp && jdu > inc && jdu > sp && jdu > ncp && jdu
> inp && jdu > nota) begin
 $display("Winner is jdu");
 end
 else if (rjd > bsp && rjd > inc && rjd > sp && rjd > ncp && rjd > inp && rjd
> nota) begin
 $display("Winner is rjd");
 end
 else if (bsp > inc && bsp > sp && bsp > ncp && bsp > inp && bsp > nota )
begin
 $display("Winner is bsp");
 end
 else if (inc > sp && inc > ncp && inc > inp && inc > nota) begin
 $display("Winner is inc");
 end
 else if (sp > ncp && sp > inp && sp > nota) begin
 $display("Winner is sp");
 end
 else if (ncp > inp && ncp > nota) begin
 $display("Winner is ncp");
 end
 else if (inp > nota) begin
 $display("Winner is inp");
 end
 end
endmodule

