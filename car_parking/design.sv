module ParkingSystem(
 input wire clk, 
 input wire reset, 
 input wire car_enter, 
 input wire car_exit, 
 output reg [7:0] parking_spots );
 // Total number of parking spots
 parameter TOTAL_SPOTS = 8'd8;
 // Initial block
 initial begin
 parking_spots = TOTAL_SPOTS;
 end
 
 always @(posedge clk or posedge reset) begin
 if (reset) begin
 parking_spots <= TOTAL_SPOTS;
 end else begin
 // Car entering logic
 if (car_enter && (parking_spots > 0)) begin
 parking_spots <= parking_spots - 1;
 end
 // Car exiting logic
 if (car_exit && (parking_spots <
TOTAL_SPOTS)) begin
 parking_spots <= parking_spots + 1;
 end
 end
 end
endmodule

