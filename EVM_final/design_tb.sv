`include "design.sv"
module tb_top;

    // Inputs
    reg clk;
    reg rst;
    reg button_bjp;
    reg button_jdu;
    reg button_rjd;
    reg button_inc;
    reg [3:0] passkey;
    reg result_enable;

    // Outputs
    wire [7:0] bjp;
    wire [7:0] jdu;
    wire [7:0] rjd;
    wire [7:0] inc;
    wire led_bjp;
    wire led_jdu;
    wire led_rjd;
    wire led_inc;

    // Instantiate the EVM module
    evm dut (
        .clk(clk),
        .rst(rst),
        .button_bjp(button_bjp),
        .button_jdu(button_jdu),
        .button_rjd(button_rjd),
        .button_inc(button_inc),
        .passkey(passkey),
        .result_enable(result_enable),
        //.bjp(bjp),
        //.jdu(jdu),
        //.rjd(rjd),
        //.inc(inc),
        .led_bjp(led_bjp),
        .led_jdu(led_jdu),
        .led_rjd(led_rjd),
        .led_inc(led_inc)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        button_bjp = 0;
        button_jdu = 0;
        button_rjd = 0;
        button_inc = 0;
        passkey = 4'b0000;
        result_enable = 0;

        // Wait for global reset
        #10;
        rst = 0;

        // Simulate button presses
        #10 button_bjp = 1; #10 button_bjp = 0; // BJP gets 1 vote
        #10 button_jdu = 1; #10 button_jdu = 0; // JDU gets 1 vote
        #10 button_jdu = 1; #10 button_jdu = 0; // JDU gets 1 vote
        #10 button_jdu = 1; #10 button_jdu = 0; // JDU gets 1 vote
        #10 button_jdu = 1; #10 button_jdu = 0; // JDU gets 1 vote
        #10 button_jdu = 1; #10 button_jdu = 0; // JDU gets 1 vote
        #10 button_rjd = 1; #10 button_rjd = 0; // RJD gets 1 vote
        #10 button_inc = 1; #10 button_inc = 0; // INC gets 1 vote
        #10 button_bjp = 1; #10 button_bjp = 0; // BJP gets another vote

        // Check votes without passkey
        passkey = 4'b0000;
        result_enable = 1;
        #10;
        //$display("Without correct passkey: BJP=%d, JDU=%d, RJD=%d, INC=%d, LED_BJP=%b, LED_JDU=%b, LED_RJD=%b, LED_INC=%b",
                 //bjp, jdu, rjd, inc, led_bjp, led_jdu, led_rjd, led_inc);

        // Check votes with correct passkey
        result_enable = 0;
        passkey = 4'b1010;
	#10;
        result_enable = 1;
        #10;
        $display("With correct passkey: BJP=%d, JDU=%d, RJD=%d, INC=%d, LED_BJP=%b, LED_JDU=%b, LED_RJD=%b, LED_INC=%b",
                 bjp, jdu, rjd, inc, led_bjp, led_jdu, led_rjd, led_inc);

        // Disable result enable and check
        result_enable = 0;
        #10;
      //  $display("With correct passkey but result enable off: BJP=%d, JDU=%d, RJD=%d, INC=%d, LED_BJP=%b, LED_JDU=%b, LED_RJD=%b, LED_INC=%b",
                 //bjp, jdu, rjd, inc, led_bjp, led_jdu, led_rjd, led_inc);

        // End simulation
        $stop;
    end
          initial begin
        $dumpfile("dump.vcd");
$dumpvars;
# 10000 $finish;
        end
endmodule
