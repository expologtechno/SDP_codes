  module street_light_controller (
    input wire clk_in,       // Clock signal
    input wire reset,     // Reset signal
    input wire light_sensor, // Light sensor input (0 = daylight, 1 = night)
    output reg street_light, // Street light control output (0 = off, 1 = on)
     output clk_out
);
  

wire clk;
  
  clk_div u_clk_div(.clk_in(clk_in),
    	      .clk(clk),
	      .reset(reset)
  );

parameter    DAY = 2'b00;     // Day state
parameter    NIGHT = 2'b01 ;   // Night state

  
  assign clk_out = clk;

  reg[1:0] current_state;
  reg[1:0] next_state;

 
// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= DAY;
    end else begin
        current_state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        DAY: begin
            if (light_sensor == 1) // Night detected
                next_state = NIGHT;
            else
                next_state = DAY;
        end
        NIGHT: begin
            if (light_sensor == 0) // Day detected
                next_state = DAY;
            else
                next_state = NIGHT;
        end
        default: begin
            next_state = DAY; // Default state
        end
    endcase
end

// Output logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        street_light <= 0; // Light off
    end else begin
        case (current_state)
            DAY: begin
                street_light <= 0; // Light off during the day
            end
            NIGHT: begin
                street_light <= 1; // Light on during the night
            end
            default: begin
                street_light <= 0; // Default to light off
            end
        endcase
    end
end

endmodule


module clk_div( input clk_in,reset,
  		output reg clk);
        
        parameter 	 DIV_VAL = 200000;
   reg[19:0] div;
        
  //clk division
  always @(posedge clk_in) begin
    if(reset) div = 0;
    if(div == DIV_VAL) div = 0;
    else div = div+1;
  end
  
  always@(*) begin
    if(div==DIV_VAL) clk = ~clk;
    //if(div==0)	clk = 0;
  end
endmodule
