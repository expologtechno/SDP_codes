/***************************************************************************

NAME: EXPOLOG TECHNOLOGIES
FILE: TESBENCH FILE

***************************************************************************/
`include "rtl.v"

module tb_top;

    // Inputs
    reg clk;
    reg rst;
  reg [3:0] key;
    reg unlock_button;

    // Outputs
    wire led_green;
    wire led_red;
  //  wire led_lock;

    // Instantiate the Unit Under Test (UUT)
    Password dut (
        .clk(clk), 
        .rst(rst), 
        .key(key), 
        .unlock_button(unlock_button), 
        .led_green(led_green), 
        .led_red(led_red) 
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        key = 0;
        unlock_button = 0;

        #100;
        
        // Apply reset
        rst = 1;
        #10;
        rst = 0;

     
        key = 4'b0101;
        unlock_button = 1;
        #10;
        unlock_button = 0;
        #100;

   
        key = 4'b0000;
        unlock_button = 1;
        #10;
        unlock_button = 0;
        #100;
        unlock_button = 1;
        #10;
        unlock_button = 0;
        #100;
        unlock_button = 1;
        #10;
        unlock_button = 0;
        #100;

         
        key = 4'b0101;
        unlock_button = 1;
        #10;
        unlock_button = 0;
        #100;
       
        key = 4'b0001;
        unlock_button = 1;
        #10;
        unlock_button = 0;
        #100;

    end

    always #5 clk = ~clk; 
  
          initial begin
        $dumpfile("dump.vcd");
            $dumpvars(1);
# 1500 $finish;
        end
endmodule

