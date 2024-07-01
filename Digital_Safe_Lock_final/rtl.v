/***************************************************************************

DESIGN: DIGITAL SAFE LOCKER	

***************************************************************************/
module Password (
    input clk,
    input rst,
    input [3:0] key,
    input unlock_button,
    output reg led_green,
    output reg led_red,
    output reg led_lock
);

   reg [15:0] count;
   reg [15:0] lock_count;

    
   always @(posedge unlock_button) begin
	   if(rst) begin
		    led_green 	<= 1'b0;
		    led_red 	<= 1'b0;
		    led_lock 	<= 1'b0;
		    count 	<= 1'b0;
	   end

	    if(key == 5'b0101 & led_lock == 0) begin
		    led_green 	<= 1'b1;
		    led_red 	<= 1'b0;
		    led_lock 	<= 1'b0;
		    count 	<= 1'b0;
	    end
	    else begin
		    if(count < 3)   begin
			    count = count + 1;
			    led_red = 1'b1;
		    	    led_green = 1'b0;
		    end
	    	    if(lock_count == 0 & led_lock == 0 & count >3)
			   count = 0; 
	    end
    end
    always @(posedge clk) begin
	    if(rst) lock_count = 0;
	    if(count >= 3 && led_lock == 0) begin
		    led_lock = 1; 
		    lock_count = 10;
	    end
	    if(lock_count == 0) led_lock <= 1'b0;
	    if(led_lock)
		    lock_count = lock_count - 1;
	    if(led_red & unlock_button) 
		    led_red <= 0;
    end
	    
endmodule : Password


