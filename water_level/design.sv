module water_level_indicator (
    input wire sensor_empty,
    input wire sensor_low,
    input wire sensor_medium,
    input wire sensor_high,
    output reg [3:0] indicator,
    output reg pump_on
);

    always @(*) begin
        // Default indicator value
        indicator = 4'b0000;

        // Setting indicator and pump control based on sensor values
        if (sensor_empty) begin
            indicator = 4'b0001; // Empty
            pump_on = 1; // Pump on when empty
        end else if (sensor_low) begin
            indicator = 4'b0010; // Low level
            pump_on = 0; // Pump off when not empty
        end else if (sensor_medium) begin
            indicator = 4'b0100; // Medium level
            pump_on = 0;
        end else if (sensor_high) begin
            indicator = 4'b1000; // High level
            pump_on = 0; // Pump off when high

        end
    end

endmodule
