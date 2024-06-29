/***************************************************************************

DESIGN: RAIL TRACK

***************************************************************************/
module rail_track_crossing (
  input clk,
  input reset,
  input train_detected,
  output reg gate_open,
  output reg lights_on
);
  parameter GATE_DELAY = 10;  // Number of clock cycles for gate operation
  
  reg [1:0] state;  // Only 2 bits needed for 4 states
  reg [3:0] count;  // 4-bit counter, enough to count to 10

  // State encoding
  localparam IDLE        = 2'b00,
             LOWERING    = 2'b01,
             LOWERED     = 2'b10,
             RAISING     = 2'b11;

  // State machine for the rail track crossing
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      count <= 0;
    end else begin
      case (state)
        IDLE: begin
          gate_open <= 1;
          lights_on <= 0;
          if (train_detected) begin
            state <= LOWERING;  // Move to the gate lowering state
            count <= 0;  // Reset count
          end
        end
        LOWERING: begin
          gate_open <= 0;
          lights_on <= 1;
          if (count == GATE_DELAY) begin
            state <= LOWERED;  // Move to the gate lowered state
          end else begin
            count <= count + 1;
          end
        end
        LOWERED: begin
          gate_open <= 0;
          lights_on <= 1;
          if (!train_detected) begin
            state <= RAISING;  // Move to the gate raising state
            count <= 0;  // Reset count
          end
        end
        RAISING: begin
          gate_open <= 1;
          lights_on <= 1;
          if (count == GATE_DELAY) begin
            state <= IDLE;  // Move back to idle state
          end else begin
            count <= count + 1;
          end
        end
      endcase
    end
  end

endmodule

