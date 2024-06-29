module evm (
    input clk,
    input rst,
    input button_bjp,
    input button_jdu,
    input button_rjd,
    input button_inc,
    input [3:0] passkey, // 4-bit passkey input
    input result_enable, // New input signal to enable result display
    output reg [7:0] bjp, jdu, rjd, inc,
    output reg led_bjp, led_jdu, led_rjd, led_inc
);
    // Define the correct passkey (adjust as needed)
    parameter correct_passkey = 4'b1010;

    // Initialize all registers to 0
    initial begin
        bjp = 0; jdu = 0; rjd = 0; inc = 0;
        led_bjp = 0; led_jdu = 0; led_rjd = 0; led_inc = 0;
    end

    // Debounce signals
    reg [1:0] db_bjp, db_jdu, db_rjd, db_inc;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            db_bjp <= 2'b00;
            db_jdu <= 2'b00;
            db_rjd <= 2'b00;
            db_inc <= 2'b00;
        end else begin
            db_bjp <= {db_bjp[0], button_bjp};
            db_jdu <= {db_jdu[0], button_jdu};
            db_rjd <= {db_rjd[0], button_rjd};
            db_inc <= {db_inc[0], button_inc};
        end
    end

    // Count votes based on button press
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bjp <= 0;
            jdu <= 0;
            rjd <= 0;
            inc <= 0;
        end else begin
            if (db_bjp == 2'b01) bjp <= bjp + 1;
            if (db_jdu == 2'b01) jdu <= jdu + 1;
            if (db_rjd == 2'b01) rjd <= rjd + 1;
            if (db_inc == 2'b01) inc <= inc + 1;
        end
    end

    // Determine the winner among all parties
    always @* begin
        // Reset all LEDs
        led_bjp = 0;
        led_jdu = 0;
        led_rjd = 0;
        led_inc = 0;

        // Only display the result if the passkey is correct and result_enable is high
        if (passkey == correct_passkey && result_enable) begin
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

