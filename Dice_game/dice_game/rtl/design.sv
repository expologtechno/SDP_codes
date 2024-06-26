/***************************************************************************

DESIGN:DICE_GAME 

***************************************************************************/
module dice_game(roll,win,lose,next_state,sum,rb,rst,clk );
input clk, rst, rb;
input[3:0]sum;
output reg roll, win, lose;
reg[2:0] state;
output reg[2:0] next_state;
parameter s0= 3'b000;
parameter s1= 3'b001;
parameter s2= 3'b010;
parameter s3= 3'b011;
parameter s4= 3'b100;
parameter s5= 3'b101; 
initial 
	@(rb or rst or sum or state)
begin
	roll=0;
	win=0;
	lose=0;
	next_state=s0;
	end
	always@(rb or rst or sum or state)
		begin
			case(state)
				s0:
					if(rb==1)
						next_state = s1;
					else
						next_state = s0;
					s1:
					       	begin 
						if(rb==1)
							roll=1;
						if(roll==1)
							begin
								if(sum == 7 || sum == 11)
									begin
										next_state = s2;
										win=1;
										end
else
	if(sum == 2 || sum == 3 || sum == 12)
next_state = s3;
else
	next_state = s4;
end
end
s4:
	begin
		win = 1;
		if(rst == 1)
			next_state = s0;
		end
		s3:
			begin
				lose=1;
				if(rst == 1)
					next_state=s0;
				end
				s4:
					if(rb == 1)
						next_state = s5;
					s5:
						begin
							if(rb==1)
								roll=1;
							if(roll==1)
								begin
									if(sum == 7 )
										next_state= s3;
									else
										next_state= s4;
									end
									end
									endcase
									end
									always@(posedge clk)
										state = next_state;
									endmodule


