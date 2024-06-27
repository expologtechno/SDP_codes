`include "design.sv"
module tb_top;
    // Inputs
    reg clk;
    reg reset;
    reg car_enter;
    reg car_exit;
    wire clk_out;
    // Outputs
    wire [3:0] spots;

    // Instantiate the Unit Under Test (UUT)
    ParkingSystem dut (
        .clk_in(clk), 
        .reset(reset), 
        .car_enter(car_enter), 
        .car_exit(car_exit), 
        .spots(spots),
	.clk_out(clk_out)

    );

    // Clock generation
    always begin
	    #5000 clk = ~clk;
    end

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        car_enter = 0;
        car_exit = 0;
        
        // Reset sequence
        #10s reset = 0;  // Release reset after 10 time units

        // Simulate car enter
        #10s car_enter = 1;
        #10s car_enter = 0;

        // Simulate another car enter
        #20s car_enter = 1;
        #10s car_enter = 0;

        // Simulate car exit
        #20s car_exit = 1;
        #10s car_exit = 0;

        // Simulate another car exit
        #20s car_exit = 1;
        #10s car_exit = 0;

        // Simulate more car enters
        #20s car_enter = 1;
        #10s car_enter = 0;
        #10s car_enter = 1;
        #10s car_enter = 0;
        #10s car_enter = 1;
        #10s car_enter = 0;

        // Finalize simulation
        #50s $finish;
    end
// initial begin
//
// $dumpfile("car_parking.vcd");
// $dumpvars(1);
// $monitor("Time = %0d, parking_spots = %0d", $time,parking_spots);
// end
endmodule
