`include "rtl.v"

module tb_top;
  // Inputs
  reg clk;
  reg reset;
  reg train_detected;

  // Outputs
  wire gate_open;
  wire lights_on;

  // Instantiate the Unit Under Test (UUT)
  rail_track_crossing uut (
    .clk(clk),
    .reset(reset),
    .train_detected(train_detected),
    .gate_open(gate_open),
    .lights_on(lights_on)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize Inputs
    clk = 0;
    reset = 0;
    train_detected = 0;

    // Apply reset
    #10 reset = 1;
    #10 reset = 0;

    // Simulate train detection
    #20 train_detected = 1;
    #100 train_detected = 0;  // Train passed

    // Wait for the gate to open again
    #100;
    
    // Simulate another train detection
    #20 train_detected = 1;
    #100 train_detected = 0;  // Train passed

    // Wait and then finish simulation
    #100;
    $finish;
  end

  // Monitor signals
  initial begin
    $monitor("At time %t, train_detected = %b, gate_open = %b, lights_on = %b", 
             $time, train_detected, gate_open, lights_on);
  end
endmodule

