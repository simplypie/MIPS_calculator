module mips (input          clk, reset,
             output [31:0]  pc,
             input  [31:0]  instr,
             output         memwrite,
             output [31:0]  aluout, writedata,
             input  [31:0]  readdata,
             output [31:0]  answer,
             input en,
             input [31:0]   num1, num2,
             input [1:0]   op,
             output        done);
             //
             //
             // added en num1 num2 op done
             
  wire        memtoreg, branch,
              alusrc, regdst, regwrite, jump;
              
  wire [2:0]  alucontrol;
  
  controller c(instr[31:26], instr[5:0], zero,
                memtoreg, memwrite, pcsrc,
                alusrc, regdst, regwrite, jump,
                alucontrol);
                
  datapath dp(clk, reset, memtoreg, pcsrc,
              alusrc, regdst, regwrite, jump,
              alucontrol,
              zero, pc, instr,
              aluout, writedata, readdata, answer, en, num1, num2, op, done);
              //
              //
              // added en num1 num2 op done
              
endmodule