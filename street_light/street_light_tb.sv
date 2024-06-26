`include "street_light_design.sv"

module tb_top;

// Testbench signals
reg clk;
reg reset;
reg light_sensor;
wire street_light;
wire clk_out;

// Instantiate the street light controller
street_light_controller dut (
    .clk_in(clk),
    .reset(reset),
    .light_sensor(light_sensor),
  .street_light(street_light),
  .clk_out(clk_out)
);

// Clock generation
always begin
    #10000 clk = ~clk; // 10 ns period (100 MHz clock)
end

// Test sequence
initial begin
    // Initialize signals
    clk = 0;
    reset = 1;
    light_sensor = 0;

    // Reset the system
  @(posedge clk)
 //   #10;
    reset = 0;

    // Test case 1: Daytime, light should be off
    light_sensor = 0;
    
//    @(posedge clk)
  //  #50;
    if (street_light !== 0) $display("Test case 1 failed");

    // Test case 2: Nighttime, light should turn on
    light_sensor = 1;
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
 //   #50;
    if (street_light !== 1) $display("Test case 2 failed");

    // Test case 3: Transition from night to day, light should turn off
    light_sensor = 0;
  @(posedge clk)
  @(posedge clk)
 // #50;
    if (street_light !== 0) $display("Test case 3 failed");

    // Test case 4: Transition from day to night, light should turn on
    light_sensor = 1;
    @(posedge clk)
    @(posedge clk)
//    #50;
    if (street_light !== 1) $display("Test case 4 failed");

    // Finish the simulation
    //$finish;
end
        initial begin
        	$dumpfile("dump.vcd");
          	$dumpvars(1);

		repeat (10) @(posedge clk_out)
		
		$finish;
        end
endmodule
