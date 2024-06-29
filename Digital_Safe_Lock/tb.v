/***************************************************************************

NAME: EXPOLOG TECHNOLOGIES
FILE: TESBENCH FILE

***************************************************************************/
`include "../design/rtl.v"

module tb_Password;
    reg [4:0] in;
    reg clk;
    reg rst;    
    wire led;
    wire [3:0] seg;
    wire [7:0] seg_led;
    integer i;

    Password dut (.in(in), .clk(clk), .rst(rst), .led(led), .seg(seg), .seg_led(seg_led));

// Clock Generation

     initial clk=0;
     always #5 clk = ~clk;

// Reset Generation
    initial begin
        rst=1;
     #10 rst=0;
     end

// Sequence-1

   initial begin
    
        in = 0;
        #10;
        in = 21;
    	#10;
        in = 5;
	#10;
	in = 15;
	#10;
        in = 21;
	#10;
	in = 4;
	#10;
	in = 21;
	#10;
	in = 30;
	#10;

        in = 21;
	#10;
	in = 8;
	#10;
	in = 7;
	#10;
	in = 2;
	#10;
	in = 1;
	#10;
	in = 21;
	#10;
	in = 20;
	#10;
	in = 21;
	#10;




       
	#1000 $finish;
    end

// Sequence-2
       /*  initial begin
          clk=0; 

         for(i=0; i<=32; i=i+1)
	 begin
		 in<=i;
	         #10; 
         end
		 #1000 $finish;
	 end*/

                  
     initial begin
	$monitor("at %t,rst=%b,in=%b,led=%b,seg=%b,seg_led=%b",$time,rst,in,led,seg,seg_led);
     end
 


    endmodule


