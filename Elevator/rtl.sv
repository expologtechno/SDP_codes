/***************************************************************************

DESIGN:ELEVATOR CONTROLLER 

***************************************************************************/
module elevator (
    input clk,
    input reset,
    input up_request,
    input down_request,
    input [1:0] floor_request,
    output reg [1:0] current_floor,
    output reg led_floor_0,
    output reg led_floor_1,
    output reg led_floor_2,
    output reg led_floor_3
);

    // Initialize the current floor to 0 and LEDs to 0
    initial begin
        current_floor = 2'b00;
        led_floor_0 = 1;
        led_floor_1 = 0;
        led_floor_2 = 0;
        led_floor_3 = 0;
    end

    // Elevator operation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_floor <= 2'b00;
        end else begin
            if (up_request && current_floor < 2'b11) begin
                current_floor <= current_floor + 1;
            end else if (down_request && current_floor > 2'b00) begin
                current_floor <= current_floor - 1;
            end else if (floor_request != current_floor) begin
                if (floor_request > current_floor) begin
                    current_floor <= current_floor + 1;
                end else if (floor_request < current_floor) begin
                    current_floor <= current_floor - 1;
                end
            end
        end
    end

    // LED indication for current floor
    always @* begin
        led_floor_0 = (current_floor == 2'b00);
        led_floor_1 = (current_floor == 2'b01);
        led_floor_2 = (current_floor == 2'b10);
        led_floor_3 = (current_floor == 2'b11);
    end
endmodule

