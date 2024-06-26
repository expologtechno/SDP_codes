/***************************************************************************

DESIGN: VENDING MACHINE

***************************************************************************/
module Firstitem (
    five_in, ten_in, clock, reset, dispense, five_out
);                    
// Declared the input and ouput ports.
input five_in, ten_in, clock, reset;
output reg dispense, five_out;
reg [4:0]current_state, next_state;
localparam S0 = 5'b00001,
           S5 = 5'b00010,
           S10 = 5'b00100,
           S15 = 5'b01000,
           S20 = 5'b10000;

always @(posedge clock or reset)begin //The block works when there is a positive edge of clock or module set to reset.
    if(reset)begin
        current_state <= S0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(five_in or ten_in)begin    //The module is used to declare various states and their relations.
    case(current_state)
    S0: if(five_in)begin next_state = S5; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S10; {five_out, dispense} = 2'b00; end
        else begin next_state = S0; {five_out, dispense} = 2'b00; end    
        
     S5: if(five_in)begin next_state = S10; {five_out, dispense} = 2'b00;end
                else if (ten_in)begin next_state = S15; {five_out, dispense} = 2'b01; end
                else begin next_state = S5; {five_out, dispense} = 2'b00; end    
                    
    S10: if(five_in)begin next_state = S15; {five_out, dispense} = 2'b01;end
         else if (ten_in)begin next_state = S20; {five_out, dispense} = 2'b11; end
        else begin next_state = S10; {five_out, dispense} = 2'b00; end    
    
    S15: begin next_state = S0; {five_out,dispense} = 2'b00; end
    
    S20: begin next_state = S0; {five_out, dispense} = 2'b00; end   

    default: begin next_state = S0; {five_out, dispense} = 2'b00; end
    endcase
end
endmodule

module Seconditem (
    five_in, ten_in, clock, reset, dispense, five_out
);
input five_in, ten_in, clock, reset;
output reg dispense, five_out;
reg [6:0]current_state, next_state;
localparam S0 = 7'b0000001,
           S5 = 7'b0000010,
           S10 = 7'b0000100,
           S15 = 7'b0001000,
           S20 = 7'b0010000,
           S25 = 7'b0100000,
           S30 = 7'b1000000;
always @(posedge clock or reset)begin
    if(reset)begin
        current_state <= S0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(five_in or ten_in)begin
    case(current_state)
    S0: if(five_in)begin next_state = S5; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S10; {five_out, dispense} = 2'b00; end
        else begin next_state = S0; {five_out, dispense} = 2'b00; end    
        
    S5: if(five_in)begin next_state = S10; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S15; {five_out, dispense} = 2'b00; end
        else begin next_state = S5; {five_out, dispense} = 2'b00; end    
                    
    S10: if(five_in)begin next_state = S15; {five_out, dispense} = 2'b00;end
         else if (ten_in)begin next_state = S20; {five_out, dispense} = 2'b00; end
         else begin next_state = S10; {five_out, dispense} = 2'b00; end    
    
    S15:if(five_in)begin next_state = S20; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S25; {five_out, dispense} = 2'b01; end
        else begin next_state = S15; {five_out, dispense} = 2'b00; end    
       
    S20: if(five_in)begin next_state = S25; {five_out, dispense} = 2'b01;end
        else if (ten_in)begin next_state = S30; {five_out, dispense} = 2'b11; end
       else begin next_state = S20; {five_out, dispense} = 2'b00; end    
    
    S25: begin next_state = S0; {five_out,dispense} = 2'b00; end

    S30: begin next_state = S0; {five_out, dispense} = 2'b00; end 

    default: begin next_state = S0; {five_out, dispense} = 2'b00; end
    endcase
end
 
endmodule

module Thirditem (
    five_in, ten_in, clock, reset, dispense, five_out
);
input five_in, ten_in, clock, reset;
output reg dispense, five_out;
reg [8:0]current_state, next_state;
localparam S0 = 9'b000000001,
           S5 = 9'b000000010,
           S10 = 9'b000000100,
           S15 = 9'b000001000,
           S20 = 9'b000010000,
           S25 = 9'b000100000,
           S30 = 9'b001000000,
           S35 = 9'b010000000,
           S40 = 9'b100000000;
always @(posedge clock or reset)begin
    if(reset)begin
        current_state <= S0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(five_in or ten_in)begin
    case(current_state)
    S0: if(five_in)begin next_state = S5; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S10; {five_out, dispense} = 2'b00; end
        else begin next_state = S0; {five_out, dispense} = 2'b00; end    
        
    S5: if(five_in)begin next_state = S10; {five_out, dispense} = 2'b00;end
                else if (ten_in)begin next_state = S15; {five_out, dispense} = 2'b00; end
                else begin next_state = S5; {five_out, dispense} = 2'b00; end    
                    
    S10: if(five_in)begin next_state = S15; {five_out, dispense} = 2'b00;end
         else if (ten_in)begin next_state = S20; {five_out, dispense} = 2'b00; end
        else begin next_state = S10; {five_out, dispense} = 2'b00; end    
    
    S15: if(five_in)begin next_state = S20; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S25; {five_out, dispense} = 2'b00; end
       else begin next_state = S15; {five_out, dispense} = 2'b00; end    
       
    S20: if(five_in)begin next_state = S25; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S30; {five_out, dispense} = 2'b00; end
       else begin next_state = S20; {five_out, dispense} = 2'b00; end    
    
    S25: if(five_in)begin next_state = S30; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S35; {five_out, dispense} = 2'b01; end
       else begin next_state = S25; {five_out, dispense} = 2'b00; end

    S30: if(five_in)begin next_state = S35; {five_out, dispense} = 2'b01;end
        else if (ten_in)begin next_state = S40; {five_out, dispense} = 2'b11; end
       else begin next_state = S30; {five_out, dispense} = 2'b00; end
     
    S35: begin next_state = S0; {five_out,dispense} = 2'b00; end

    S40: begin next_state = S0; {five_out, dispense} = 2'b00; end 

    default: begin next_state = S0; {five_out, dispense} = 2'b00; end
    endcase
end
 
endmodule

module Fourthitem (
    five_in, ten_in, clock, reset, dispense, five_out
);
input five_in, ten_in, clock, reset;
output reg dispense, five_out;
reg [10:0]current_state, next_state;
localparam S0 =11'b00000000001,
           S5 =11'b00000000010,
           S10 = 11'b00000000100,
           S15 = 11'b00000001000,
           S20 = 11'b00000010000,
           S25 = 11'b00000100000,
           S30 = 11'b00001000000,
           S35 = 11'b00010000000,
           S40 = 11'b00100000000,
           S45 = 11'b01000000000,
           S50 = 11'b10000000000;
always @(posedge clock or reset)begin
    if(reset)begin
        current_state <= S0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(five_in or ten_in)begin
    case(current_state)
    S0: if(five_in)begin next_state = S5; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S10; {five_out, dispense} = 2'b00; end
        else begin next_state = S0; {five_out, dispense} = 2'b00; end    
        
    S5: if(five_in)begin next_state = S10; {five_out, dispense} = 2'b00;end
                else if (ten_in)begin next_state = S15; {five_out, dispense} = 2'b00; end
                else begin next_state = S5; {five_out, dispense} = 2'b00; end    
                    
    S10: if(five_in)begin next_state = S15; {five_out, dispense} = 2'b00;end
         else if (ten_in)begin next_state = S20; {five_out, dispense} = 2'b00; end
        else begin next_state = S10; {five_out, dispense} = 2'b00; end    
    
    S15: if(five_in)begin next_state = S20; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S25; {five_out, dispense} = 2'b00; end
       else begin next_state = S15; {five_out, dispense} = 2'b00; end    
       
    S20: if(five_in)begin next_state = S25; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S30; {five_out, dispense} = 2'b00; end
       else begin next_state = S20; {five_out, dispense} = 2'b00; end    
    
    S25: if(five_in)begin next_state = S30; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S35; {five_out, dispense} = 2'b00; end
       else begin next_state = S25; {five_out, dispense} = 2'b00; end

    S30: if(five_in)begin next_state = S35; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S40; {five_out, dispense} = 2'b00; end
       else begin next_state = S30; {five_out, dispense} = 2'b00; end
     
    S35: if(five_in)begin next_state = S40; {five_out, dispense} = 2'b00;end
        else if (ten_in)begin next_state = S45; {five_out, dispense} = 2'b01; end
        else begin next_state = S35; {five_out, dispense} = 2'b00; end

    S40: if(five_in)begin next_state = S45; {five_out, dispense} = 2'b01;end
        else if (ten_in)begin next_state = S50; {five_out, dispense} = 2'b11; end
       else begin next_state = S40; {five_out, dispense} = 2'b00; end
    
    S45: begin next_state = S0; {five_out,dispense} = 2'b00; end

    S50: begin next_state = S0; {five_out, dispense} = 2'b00; end 
            
        
    default: begin next_state = S0; {five_out, dispense} = 2'b00; end
    endcase
end
 
endmodule
//This is the main module of the project.
module VendingMachine  (
    item,five_in, ten_in, clock, reset, dispense, five_out
);
input [3:0] item;
input five_in,ten_in,reset,clock;
output reg dispense,five_out;
       wire I1,I2,I3,I4,D1,D2,D3,D4;
//Declaring the ports.
Firstitem  FI(.five_in(five_in), .ten_in(ten_in), .clock(clock), .reset(reset), .five_out(I1), .dispense(D1));
Seconditem SI(.five_in(five_in), .ten_in(ten_in), .clock(clock), .reset(reset), .five_out(I2), .dispense(D2));
Thirditem  TI(.five_in(five_in), .ten_in(ten_in), .clock(clock), .reset(reset), .five_out(I3), .dispense(D3));
Fourthitem FRI(.five_in(five_in), .ten_in(ten_in), .clock(clock), .reset(reset), .five_out(I4), .dispense(D4));

always @(*) begin
    if(item == 4'b0001) begin
        five_out = I1;
        dispense = D1;
        end
    else if(item == 4'b0010) begin
        five_out = I2;
        dispense = D2;
        end
    else if(item == 4'b0100) begin
        five_out = I3;
        dispense = D3;
        end
    else if(item == 4'b1000) begin
        five_out = I4;
        dispense = D4;
    end
end
endmodule
