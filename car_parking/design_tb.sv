`include "design.sv"
module tb_top;
 
 reg clk, reset, car_enter, car_exit;
 wire [7:0] parking_spots;
 ParkingSystem uut (
 .clk(clk),
 .reset(reset),
 .car_enter(car_enter),
 .car_exit(car_exit),
 .parking_spots(parking_spots) );
 // Clock generation
 initial begin
 clk = 0;
 forever #5 clk = ~clk;
 end
 // Test sequence
 initial begin
 // Initial reset
 reset = 1;
 car_enter = 0;
 car_exit = 0;
 #10;
 reset = 0;
 // Car entering sequence
 #10 car_enter = 1;
 #10 car_enter = 0;
 #10 car_enter = 1;
 #50 car_enter = 0;
 // Car exiting sequence
 #10 car_exit = 1;
 #50 car_exit = 0;
 #10;
 $finish;
 end
 initial begin

 $dumpfile("car_parking.vcd");
 $dumpvars(1);
 $monitor("Time = %0d, parking_spots = %0d", $time,parking_spots);
 end
endmodule
