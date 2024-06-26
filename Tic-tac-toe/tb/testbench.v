
`include "../rtl/design.v"
`timescale 1ns / 1ps

module tb;
  reg play, rst, clk;
  reg [3:0] comp_pos, player_pos;
  wire who;
  
  tic_tac_toe ins1(
    play, rst, clk, 
    comp_pos, player_pos, 
    who
  );
  
  always #5 clk = ~clk;


// Test sequence-1: When both player and computer turns to draw 
 /* initial
    begin
      rst = 1'b0;
      #10;
      rst = 1'b1;
      clk = 1'b0;
      #50;
      
      rst = 1'b0;
      #30
      play = 1'b1;
      #10;
      
      play = 1'b0;
      player_pos = 5;
      #10
      
      comp_pos = 1;
      #10
      
      player_pos = 7;
      #10
      
      comp_pos = 3;
      #10;
      
      player_pos = 2;
      #10;
      
      comp_pos = 8;
      #10
      
      player_pos = 9;
      #10
      
      comp_pos = 4;
      #10
      
      player_pos = 6;
      #10

      comp_pos = 3;
      #10
      
      player_pos = 6;
      #10

      comp_pos = 1;
      #10
      
      player_pos = 6;
      #10

      comp_pos = 4;
      #10
      
      player_pos = 6;
      #10*/

// Test sequence-2: When computer wins the game


  /* initial
    begin
      rst = 1'b0;
      #10;
      rst = 1'b1;
      clk = 1'b0;
      #50;
      
      rst = 1'b0;
      #30
      play = 1'b1;
      #10;
      
      play = 1'b0;
      player_pos = 5;
      #10
      
      comp_pos = 1;
      #10
      
      player_pos = 7;
      #10
      
      comp_pos = 2;
      #10;
      
      player_pos = 2;
      #10;
      
      comp_pos = 3;
      #10
      
      player_pos = 9;
      #10
      
      comp_pos = 1;
      #10
      
      player_pos = 6;
      #10

      comp_pos = 2;
      #10
      
      player_pos = 6;
      #10

      comp_pos = 3;
      #10
      
      player_pos = 5;
      #10

      comp_pos = 9;
      #10
      
      player_pos = 6;
      #10
*/

// Test sequence-3: When player wins the game
  initial
    begin
      rst = 1'b0;
      #10;
      rst = 1'b1;
      clk = 1'b0;
      #50;
      
      rst = 1'b0;
      #30
      play = 1'b1;
      #10;
      
      play = 1'b0;
      player_pos = 4;
      #10
      
      comp_pos = 1;
      #10
      
      player_pos = 5;
      #10
      
      comp_pos = 3;
      #10;
      
      player_pos = 6;
      #10;
      
      comp_pos = 8;
      #10
      
      player_pos = 4;
      #10
      
      comp_pos = 4;
      #10
      
      player_pos = 5;
      #10

      comp_pos = 3;
      #10
      
      player_pos = 6;
      #10

      comp_pos = 1;
      #10
      
      player_pos = 6;
      #10

      comp_pos = 4;
      #10
      
      player_pos = 6;
      #10


      $finish;
    end
  
endmodule
