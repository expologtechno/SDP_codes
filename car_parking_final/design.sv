
module ParkingSystem(
    input wire clk_in, 
    input wire reset, 
    input wire car_enter, 
    input wire car_exit, 
    output reg [3:0] spots,
    output clk_out
);

wire clk;
  
  clk_div u_clk_div(.clk_in(clk_in),
    	      .clk(clk),
	      .reset(reset)
  );
  assign clk_out = clk;
    // Total number of parking spots
    parameter TOTAL_SPOTS = 8'd8;
    reg [7:0] occupied_spots;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            occupied_spots <= 8'd0;
        end
        else begin
            if (car_enter && occupied_spots < TOTAL_SPOTS) begin
                occupied_spots <= occupied_spots + 1;
            end
            if (car_exit && occupied_spots > 0) begin
                occupied_spots <= occupied_spots - 1;
            end
        end
    end

    // Update the output signals based on the number of occupied spots
    always @(*) begin
        spots[0] = (occupied_spots >= 1);
        spots[1] = (occupied_spots >= 2);
        spots[2] = (occupied_spots >= 3);
        spots[3] = (occupied_spots >= 4);
    end
endmodule



module clk_div( input clk_in,reset,
  		output reg clk);
        
        parameter 	 DIV_VAL = 200000;
   reg[19:0] div;
        
  //clk division
  always @(posedge clk_in) begin
    if(reset) begin div = 0; clk = 0; end
    if(div == DIV_VAL) div = 0;
    else div = div+1;
  end
  
  always@(*) begin
    if(div==DIV_VAL) clk = ~clk;
    //if(div==0)	clk = 0;
  end
endmodule
