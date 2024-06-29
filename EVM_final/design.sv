/*module evm (
    input [3:0] button,
    input en,
    output reg [7:0] bjp, jdu, rjd, bsp, inc, sp, inp, ncp, nota,
    output reg led_bjp, led_jdu, led_rjd, led_bsp, led_inc, led_sp, led_inp, led_ncp, led_nota
);
    // Initialize all registers to 0
    initial begin
        bjp = 0; jdu = 0; rjd = 0; bsp = 0;
        inc = 0; sp = 0; inp = 0; ncp = 0;
        nota = 0;
        led_bjp = 0; led_jdu = 0; led_rjd = 0; led_bsp = 0;
        led_inc = 0; led_sp = 0; led_inp = 0; led_ncp = 0;
        led_nota = 0;
    end

    // Count votes based on button press
    always @(posedge en) begin
        case(button)
            4'b0001: bjp <= bjp + 1;
            4'b0010: inc <= inc + 1;
            4'b0011: rjd <= rjd + 1;
            4'b0100: jdu <= jdu + 1;
            4'b0101: bsp <= bsp + 1;
            4'b0110: sp <= sp + 1;
            4'b0111: ncp <= ncp + 1;
            4'b1000: inp <= inp + 1;
            default: nota <= nota + 1;
        endcase
    end

    // Determine the winner among all parties
    always @* begin
        // Reset all LEDs
        led_bjp = 0; led_jdu = 0; led_rjd = 0; led_bsp = 0;
        led_inc = 0; led_sp = 0; led_inp = 0; led_ncp = 0;
        led_nota = 0;
        
        if (bjp > jdu && bjp > rjd && bjp > bsp && bjp > inc && bjp > sp && bjp > ncp && bjp > inp && bjp > nota) begin
            led_bjp = 1;
        end else if (jdu > rjd && jdu > bsp && jdu > inc && jdu > sp && jdu > ncp && jdu > inp && jdu > nota) begin
            led_jdu = 1;
        end else if (rjd > bsp && rjd > inc && rjd > sp && rjd > ncp && rjd > inp && rjd > nota) begin
            led_rjd = 1;
        end else if (bsp > inc && bsp > sp && bsp > ncp && bsp > inp && bsp > nota) begin
            led_bsp = 1;
        end else if (inc > sp && inc > ncp && inc > inp && inc > nota) begin
            led_inc = 1;
        end else if (sp > ncp && sp > inp && sp > nota) begin
            led_sp = 1;
        end else if (ncp > inp && ncp > nota) begin
            led_ncp = 1;
        end else if (inp > nota) begin
            led_inp = 1;
        end else begin
            led_nota = 1;
        end
    end
endmodule
*/

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

