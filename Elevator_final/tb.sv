/***************************************************************************

NAME: EXPOLOG TECHNOLOGIES
FILE: TESTBENCH

***************************************************************************/
`include "rtl.sv"
module tb_top;
    // Inputs
    reg clk;
    reg reset;
    reg up_request;
    reg down_request;
    reg [1:0] floor_request;
    // Outputs
    wire [1:0] current_floor;
    wire led_floor_0;
    wire led_floor_1;
    wire led_floor_2;
    wire led_floor_3;

    // Instantiate the Unit Under Test (UUT)
    elevator uut (
        .clk(clk),
        .reset(reset),
        .up_request(up_request),
        .down_request(down_request),
        .floor_request(floor_request),
        .current_floor(current_floor),
        .led_floor_0(led_floor_0),
        .led_floor_1(led_floor_1),
        .led_floor_2(led_floor_2),
        .led_floor_3(led_floor_3)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 0;
        up_request = 0;
        down_request = 0;
        floor_request = 2'b00;

        // Reset the system
        #5 reset = 1;
        #10 reset = 0;

        // Request to move to floor 1
        #10 floor_request = 2'b01;
        #10 up_request = 1;
        #10 up_request = 0;

        // Request to move to floor 2
        #10 floor_request = 2'b10;
        #10 up_request = 1;
        #10 up_request = 0;

        // Request to move to floor 3
        #10 floor_request = 2'b11;
        #10 up_request = 1;
        #10 up_request = 0;

        // Request to move to floor 0
        #10 floor_request = 2'b00;
        #10 down_request = 1;
        #10 down_request = 0;

        // Check LEDs
        #10 $display("LEDs: Floor 0=%b, Floor 1=%b, Floor 2=%b, Floor 3=%b",
                     led_floor_0, led_floor_1, led_floor_2, led_floor_3);

        // Finalize simulation
        #50 $finish;
    end

    // Clock generation
    always #5 clk = ~clk;
endmodule

