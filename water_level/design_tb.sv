// Testbench
module test;
 
  logic clk, rst, a, b, s;
  integer incr, level = 100;
 
  // Instantiate design under test
  tank dut(clk, rst, a, b, s);
  // generate clock
  always begin
    clk = 1; #50; clk = 0; #50;
  end
  always@(negedge clk)
  begin
    incr = $random%15;
    if (incr < 0)
      incr = incr * -1;
    if (s)
      level = level + incr;
    else
      level = level - incr;
  end
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
 
  initial begin
	rst = 1;
    #50 rst = 0;
    #30000 $finish;
  end
  assign b = level > 8'hFF; 
  assign a = level > 8'h1F; 
endmodule
