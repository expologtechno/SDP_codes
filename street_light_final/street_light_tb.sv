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
    #5000 clk = ~clk; // 10 ns period (100 MHz clock)
end

// Test sequence
initial begin
    // Initialize signals
    clk = 0;
    light_sensor = 0;
    reset = 1;
    #10000 reset = 0;

    @(posedge clk_out);

    // Test case 1: Daytime, light should be off
    light_sensor = 0;
    
    #4s;
    if (street_light !== 0) $display("Test case 1 failed");

    // Test case 2: Nighttime, light should turn on
    light_sensor = 1;
    #5s;
    if (street_light !== 1) $display("Test case 2 failed");

    #5s;
    // Test case 3: Transition from night to day, light should turn off
    light_sensor = 0;
    #5s;
    if (street_light !== 0) $display("Test case 3 failed");

    #5s;
    // Test case 4: Transition from day to night, light should turn on
    light_sensor = 1;
    #5s;
    if (street_light !== 1) $display("Test case 4 failed");
    #5s;

    $finish;
end
        initial begin
        	$dumpfile("dump.vcd");
          	$dumpvars(1);

		//repeat (10) @(posedge clk_out);
		
		//$finish;
        end
endmodule
