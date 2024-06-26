=
`include "design.sv"
module tb_top;

    reg sensor_empty;
    reg sensor_low;
    reg sensor_medium;
    reg sensor_high;
    wire [3:0] indicator;
    wire pump_on;

    // Instantiate the water level indicator module
    water_level_indicator dut (
        .sensor_empty(sensor_empty),
        .sensor_low(sensor_low),
        .sensor_medium(sensor_medium),
        .sensor_high(sensor_high),
        .indicator(indicator),
        .pump_on(pump_on)
    );


    // Test procedure
    initial begin
        // Initialize sensors
        sensor_empty = 0;
        sensor_low = 0;
        sensor_medium = 0;
        sensor_high = 0;

        // Apply test cases
        repeat (4) begin
            #10 sensor_empty = 1; sensor_low = 0; sensor_medium = 0; sensor_high = 0;
            #20 $display("Sensor states: empty=%b, low=%b, medium=%b, high=%b | Indicator: %b | Pump: %b", 
                         sensor_empty, sensor_low, sensor_medium, sensor_high, indicator, pump_on);
            
            #10 sensor_empty = 0; sensor_low = 1; sensor_medium = 0; sensor_high = 0;
            #20 $display("Sensor states: empty=%b, low=%b, medium=%b, high=%b | Indicator: %b | Pump: %b", 
                         sensor_empty, sensor_low, sensor_medium, sensor_high, indicator, pump_on);
            
            #10 sensor_empty = 0; sensor_low = 0; sensor_medium = 1; sensor_high = 0;
            #20 $display("Sensor states: empty=%b, low=%b, medium=%b, high=%b | Indicator: %b | Pump: %b", 
                         sensor_empty, sensor_low, sensor_medium, sensor_high, indicator, pump_on);
            
            #10 sensor_empty = 0; sensor_low = 0; sensor_medium = 0; sensor_high = 1;
            #20 $display("Sensor states: empty=%b, low=%b, medium=%b, high=%b | Indicator: %b | Pump: %b", 
                         sensor_empty, sensor_low, sensor_medium, sensor_high, indicator, pump_on);
        end

        // End of test
        #10 $finish;
    end
//  initial begin
  //   $dumpfile("dump.vcd");
   // $dumpvars(1);
  //end
  
endmodule

