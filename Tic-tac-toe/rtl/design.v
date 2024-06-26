`timescale 1ns / 1ps
module tic_tac_toe(
  input play, rst, clk, 
  input [3:0] comp_pos, player_pos,
  output who1
);
  
  parameter[1:0] IDLE=00, PLAYER=01, COMPUTER=10, GAME_OVER=11;
  
  integer i, j;
  reg[1:0] pos[0:8];
  reg no_space, win, who;
  reg illegal_move_p, illegal_move_c;
  reg[1:0] present_state, next_state;
  reg[3:0] cnt;
  
  assign who1 = who;
  
  always @(*)
    begin
      if (pos[player_pos-1] == 2'b00)
        illegal_move_p = 1'b0;
      else
        illegal_move_p = 1'b1;
      
      if (pos[comp_pos-1] == 2'b00)
        illegal_move_c = 1'b0;
      else
        illegal_move_c = 1'b1;
    end
    
  //assign illegal_move_p = (pos[player_pos-1] == 2'b00)?1'b0:1'b1;
  //assign illegal_move_c = (pos[comp_pos-1] == 2'b00)?1'b0:1'b1;
  
  /*initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1,tic_tac_toe);
      //$monitor("%0d %0d %0d %0d %0d %0d %0d %0d %0d ", pos[0], pos[1], pos[2], pos[3], pos[4], pos[5], pos[6], pos[7], pos[8]);
    end */
  
  always @(posedge rst)
    begin
      no_space = 1'b0;
      present_state = IDLE;
      cnt = 4'b0000;
      for(i=0;i<9;i=i+1)
        pos[i] = 2'b00;
    end
  
  always @(next_state)
    begin
      for(i=0;i<=2;i=i+1)
        begin
          for(j=0;j<=2;j=j+1)
            begin
              case(pos[3*i+j])
                2'b00:
                  $write("_ ");
                 
                2'b01:
                  $write("0 ");
                
                2'b10:
                  $write("x ");
                
                default:
                  $write("_ ");
              endcase
            end
          $display("");
        end
      $display("");
      if(win && ~who)
        $display("PLAYER WINS!!!");
      else if(win && who)
        $display("COMPUTER WINS!!!");
      else if(no_space)
        $display("DRAW!!!");
                
    end
  
  always @(posedge clk)
    begin
      present_state = next_state;
//      $write("present");
//      $display(present_state);
    end
  
  always @(negedge clk)
    begin
      case(present_state)
        IDLE:
          begin
            if (play && ~rst)
              next_state = PLAYER;
            else
              next_state = present_state;
          end

        PLAYER:
          begin
            $display("Player's Turn");
            if (~illegal_move_p)
              begin
              	next_state = COMPUTER;
//                $write("next");
//                $display(next_state);
                pos[player_pos-1] = 2'b01;
                cnt = cnt + 1;
              end
            
            else if(no_space || win)
              next_state = GAME_OVER;
            
            else if (illegal_move_p)
              begin
              	next_state = present_state;
                $display("Invalid Move, Please try again");
              end
            else
              next_state = present_state;
          end
        
        COMPUTER:
          begin
            $display("Computer's Turn");
            if (~illegal_move_c)
              begin
              	next_state = PLAYER;
                
                pos[comp_pos-1] = 2'b10;
                cnt = cnt + 1;
              end
            
            else if(no_space || win)
              next_state = GAME_OVER;
            
            else if(illegal_move_c)
              begin
              	next_state = present_state;
                $display("Invalid Move, Please try again");
              end
            else
              next_state = present_state;
            
          end
        
        GAME_OVER:
          begin
            if (~rst)
              next_state = present_state;
            else
              next_state = IDLE;
          end
      endcase
    end
  
  always @(present_state)
    begin
      if(cnt == 9)
        no_space = 1'b1;
      else
        no_space = 1'b0;
    end
  
  always @(present_state)
    begin
      if(pos[0] == 2'b01 && pos[1] == 2'b01 && pos[2] == 2'b01)
        begin
          win = 1'b1;
          who = 1'b0;
        end
      
      else if(pos[0] == 2'b01 && pos[3] == 2'b01 && pos[6] == 2'b01)
        begin
          win = 1'b1;
          who = 1'b0;
        end
      
      else if(pos[0] == 2'b01 && pos[4] == 2'b01 && pos[8] == 2'b01)
        begin
          win = 1'b1;
          who = 1'b0;
        end
      
      else if(pos[1] == 2'b01 && pos[4] == 2'b01 && pos[7] == 2'b01)
        begin
          win = 1'b1;
          who = 1'b0;
        end
      
      else if(pos[2] == 2'b01 && pos[5] == 2'b01 && pos[8] == 2'b01)
        begin
          win = 1'b1;
          who = 1'b0;
        end
      
      else if(pos[3] == 2'b01 && pos[4] == 2'b01 && pos[5] == 2'b01)
        begin
          win = 1'b1;
          who = 1'b0;
        end
      
      else if(pos[6] == 2'b01 && pos[7] == 2'b01 && pos[8] == 2'b01)
        begin
          win = 1'b1;
          who = 1'b0;
        end
      
      else if(pos[2] == 2'b01 && pos[4] == 2'b01 && pos[6] == 2'b01)
        begin
          win = 1'b1;
          who = 1'b0;
        end

      
      if(pos[0] == 2'b10 && pos[1] == 2'b10 && pos[2] == 2'b10)
        begin
          win = 1'b1;
          who = 1'b1;
        end
      
      else if(pos[0] == 2'b10 && pos[3] == 2'b10 && pos[6] == 2'b10)
        begin
          win = 1'b1;
          who = 1'b1;
        end
      
      else if(pos[0] == 2'b10 && pos[4] == 2'b10 && pos[8] == 2'b10)
        begin
          win = 1'b1;
          who = 1'b1;
        end
      
      else if(pos[1] == 2'b10 && pos[4] == 2'b10 && pos[7] == 2'b10)
        begin
          win = 1'b1;
          who = 1'b1;
        end
      
      else if(pos[2] == 2'b10 && pos[5] == 2'b10 && pos[8] == 2'b10)
        begin
          win = 1'b1;
          who = 1'b1;
        end
      
      else if(pos[3] == 2'b10 && pos[4] == 2'b10 && pos[5] == 2'b10)
        begin
          win = 1'b1;
          who = 1'b1;
        end
      
      else if(pos[6] == 2'b10 && pos[7] == 2'b10 && pos[8] == 2'b10)
        begin
          win = 1'b1;
          who = 1'b1;
        end
      
      else if(pos[2] == 2'b10 && pos[4] == 2'b10 && pos[6] == 2'b10)
        begin
          win = 1'b1;
          who = 1'b1;
        end
      
    end
endmodule
  
  

