module evm (
    input clk,
    input rst,
    input button_bjp,
    input button_jdu,
    input button_rjd,
    input button_inc,
    input [3:0] passkey, // 4-bit passkey input
    input result_enable, // New input signal to enable result display
    //output reg [7:0] bjp, jdu, rjd, inc,
    output reg led_bjp, led_jdu, led_rjd, led_inc
);
    // Define the correct passkey (adjust as needed)
    parameter correct_passkey = 4'b1010;

    reg [7:0] bjp, jdu, rjd, inc;

    // Count votes based on button press
    always @(posedge rst, posedge button_bjp, posedge button_jdu, posedge button_inc, posedge button_rjd) begin
        if (rst) begin
            bjp <= 0;
            jdu <= 0;
            rjd <= 0;
            inc <= 0;
        end else begin
    		if(button_bjp && bjp!=8'hFF) bjp <= bjp + 1;
    		if(button_jdu && jdu!=8'hFF) jdu <= jdu + 1;
    		if(button_rjd && rjd!=8'hFF) rjd <= rjd + 1;
    		if(button_inc && inc!=8'hFF) inc <= inc + 1;
        end
    end

    // Determine the winner among all parties
    always @(posedge result_enable) begin
        // Reset all LEDs
        led_bjp = 0;
        led_jdu = 0;
        led_rjd = 0;
        led_inc = 0;

        // Only display the result if the passkey is correct and result_enable is high
        if (passkey == correct_passkey ) begin
            if (bjp > jdu && bjp > rjd && bjp > inc) begin
                led_bjp = 1;
            end else if (jdu > rjd && jdu > inc) begin
                led_jdu = 1;
            end else if (rjd > inc) begin
                led_rjd = 1;
            end else begin
                led_inc = 1;
            end
        end
    end
endmodule

