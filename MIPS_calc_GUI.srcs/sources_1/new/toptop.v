`timescale 1ns / 1ps

module toptop(
  input wire        clk,
  input wire        reset, 
  input wire  [31:0] num1,
  input wire  [31:0] num2,
  input wire  [1:0] op,
  input wire        en,
  output wire [31:0] answer,
  output wire       done
  );


//module toptop(
//  input wire        clk,
//  input wire        reset, 
//  input wire  [3:0] num1sw,
//  input wire  [3:0] num2sw,
//  input wire  [1:0] op,
//  //input wire        en,
//  output wire [7:0] answerled,
//  output wire       done
//  );
  
  
//  wire [31:0] num1, num2, answer;
//  assign num1 = {28'd0, num1sw};
//  assign num2 = {28'd0, num2sw};
//  assign answerled = answer[7:0];
  
  
  
  
  reg [31:0] dig0_reg, dig1_reg;
////  reg en_reg;
  
//  wire [31:0] dig0, dig1;
  
//  assign dig0 = dig0_reg;
//  assign dig1 = dig1_reg;
  
//  top top (clk, reset, en, dig0, dig1, op, answer);

    top top (clk, reset, en, op, dig0_reg, dig1_reg, answer, done);

  always @(posedge en) begin
      dig0_reg = num1;
      dig1_reg = num2;
// //     en_reg = 1'b1;
  end
  
endmodule