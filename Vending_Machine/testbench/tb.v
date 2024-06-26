/***************************************************************************

NAME: EXPOLOG TECHNOLOGIES
FILE: TESTBENCH

***************************************************************************/
`include "../design/rtl.v"

`define clock_period 10 // predefined the clock period
// module for test bench 
module VendingMachinetest();

reg [3:0]item;
reg five_in, ten_in, reset, clock;
wire dispense,five_out;
//call the module
VendingMachine VM(.item(item), .five_in(five_in), .ten_in(ten_in), .clock(clock), .reset(reset), .five_out(five_out), .dispense(dispense));
//Initialise the clock to start
initial clock = 1;
// Update the clock value to start at regular intervals
always #(`clock_period/2) clock = (~clock);
//Initialise the inputs
initial begin
    item = 4'b0100;
    five_in = 0;
    ten_in = 0;
    reset = 0;
// Giving new Inputs at each interval
    #(`clock_period);
    reset = 1;
    #(`clock_period);
    reset = 0;
    #(`clock_period);
    five_in = 1;
    ten_in = 0;
    #(`clock_period);
    five_in = 0;
    ten_in = 1;
    #(`clock_period);
    five_in = 0;
    ten_in = 0;
    #(`clock_period);
    five_in = 1;
    ten_in = 0;
    #(`clock_period);
    five_in = 0;
    ten_in = 1;
    #(`clock_period);
    five_in = 1;
    ten_in = 0;
    #(`clock_period);
    five_in = 0;
    ten_in = 0;
   #(`clock_period);
   //ending the input
   #(`clock_period*5);
    $finish;
    
end
endmodule
