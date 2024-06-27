/***************************************************************************

NAME: EXPOLOG TECHNOLOGIES
FILE: TESTBENCH

***************************************************************************/
`include "traffic_light_design.sv"

//module traffic_control_tb;
module tb_top;

//inputs

 reg      clk;
 reg      rst_a;
 wire 	clk_out;

 //outputs
 
wire [2:0] n_lights,s_lights,e_lights,w_lights; 

//DUT instantiation


traffic_control dut (n_lights,s_lights,e_lights,w_lights,clk,rst_a, clk_out);

// Clock generation

  initial clk=0;
  always #5000 clk = ~clk;
  
//Reset Generation


  initial begin
    rst_a = 1;
    #10000 rst_a =0;
  end

  always@(posedge clk_out or negedge clk_out) begin
  $display("%t,clk=%d,rst_a=%d,n_lights=%d,s_lights=%d,e_lights=%d,w_lights=%d",$time,clk,rst_a,n_lights,s_lights,e_lights,w_lights);
  end

  initial begin 
  repeat (50) @(posedge clk_out); 
  
  $finish;
  end

  endmodule

