/***************************************************************************

NAME: EXPOLOG TECHNOLOGIES
FILE: TESTBENCH

***************************************************************************/
`include "../rtl/design.sv"

module tbench_top;
  
reg clk, rst, rb;
reg [3:0]sum;
wire roll, win, lose;
wire [2:0] next_state;
integer i;

   //DUT instantiation
    dice_game DUT (
    .clk(clk),
    .rst(rst),
    .rb(rb),
    .sum(sum),
    .roll(roll),
    .win(win),
    .lose(lose),
    .next_state(next_state)
   );

    //clock generation
  initial clk=0;
  always #10 clk = ~clk;
  
  //reset Generation
 initial begin
    rst = 0;
   #5 rst =1;

  end

   initial begin

      sum<=4'b0000;
      rb<=1'b0;
      #5;


      sum<=4'b0111;//7
      rb<=1'b1;
      #5;
     
      sum<=4'b1011;//11
      rb<=1'b1;
      #5;
      
      
      sum<=4'b1100;//12
      rb<=1'b1;
      #5;  

      sum<=4'b0010;//2
      rb<=1'b1;
      #5;
      
        
      sum<=4'b0011;//3
      rb<=1'b1;
      #5;

      sum<=4'b0111;//7
      rb<=1'b1;
      #5;

       
      sum<=4'b0101;//5
      rb<=1'b1;
      #5;

      sum<=4'b1000;//8
      rb<=1'b1;
      #5;
     
      sum<=4'b1111;//15
      rb<=1'b1;
      #5;
      
      
      sum<=4'b1100;//12
      rb<=1'b1;
      #5;  

      sum<=4'b0010;//2
      rb<=1'b1;
      #5;
      
      sum<=4'b0011;//3
      rb<=1'b1;
      #5;

      sum<=4'b0111;//7
      rb<=1'b1;
      #5;

 
         end

//Test Sequence-2


/*initial begin
for (i=0;i<=16;i=i+1)
begin
	sum=i;
	rb=1;
	#5;
end
end*/

 
   initial begin

$monitor("at %t,clk=%d,rst=%d,sum=%d,rb=%d,roll=%d,win=%d,lose=%d,next_state=%d",$time,clk,rst,sum,rb,roll,win,lose,next_state );
#1000 $finish;
   end 
  endmodule

