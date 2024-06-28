`include "design.sv"
module tb_top;
    // Inputs
    reg [3:0] button;
    reg en;
    // Outputs
    wire [7:0] bjp, jdu, rjd, bsp, inc, sp, inp, ncp, nota;
    wire led_bjp, led_jdu, led_rjd, led_bsp, led_inc, led_sp, led_inp, led_ncp, led_nota;

    // Instantiate the Unit Under Test (UUT)
    evm uut (
        .button(button),
        .en(en),
        .bjp(bjp),
        .jdu(jdu),
        .rjd(rjd),
        .bsp(bsp),
        .inc(inc),
        .sp(sp),
        .inp(inp),
        .ncp(ncp),
        .nota(nota),
        .led_bjp(led_bjp),
        .led_jdu(led_jdu),
        .led_rjd(led_rjd),
        .led_bsp(led_bsp),
        .led_inc(led_inc),
        .led_sp(led_sp),
        .led_inp(led_inp),
        .led_ncp(led_ncp),
        .led_nota(led_nota)
    );

    initial begin
        // Initialize Inputs
        button = 0;
        en = 0;

        // Simulate voting
        #10 button = 4'b0001; en = 1;  // Vote for BJP
        #10 en = 0;

        #10 button = 4'b0010; en = 1;  // Vote for INC
        #10 en = 0;

        #10 button = 4'b0011; en = 1;  // Vote for RJD
        #10 en = 0;

        #10 button = 4'b0100; en = 1;  // Vote for JDU
        #10 en = 0;

        #10 button = 4'b0001; en = 1;  // Vote for BJP
        #10 en = 0;

        // Continue simulating votes as needed...

        // Check LEDs
        #10 $display("LEDs: BJP=%b, JDU=%b, RJD=%b, BSP=%b, INC=%b, SP=%b, INP=%b, NCP=%b, NOTA=%b",
                     led_bjp, led_jdu, led_rjd, led_bsp, led_inc, led_sp, led_inp, led_ncp, led_nota);

        // Finalize simulation
        #50 $finish;
    end
endmodule

