module top (input clk, reset, en, 
            input [1:0] op,
            input [31:0] num1, num2,
            
//            output [31:0] writedata, dataadr,
//            output memwrite,
            
            output [31:0] answer,
            output done);
            //
            //
            // added op num1 num2 answer done
    wire [31:0] writedata, dataadr;
    wire memwrite;
    
    wire [31:0] answer32;
    
//    assign answer = dataadr[7:0];
    
    assign answer = answer32;
            
    wire [31:0] pc, instr, readdata;
    
    // instantiate processor and memories
    mips mips (clk, reset, pc, instr, memwrite, dataadr,
               writedata, readdata, answer32, en, num1, num2, op, done);
               //
               //
               // added en num1 num2 op done
    imem imem (pc[7:2], instr);
    dmem dmem (clk, memwrite, dataadr, writedata,
               readdata);
               
//    wire clk1Hz;
//    prog_clk #(.N(26), .MAX(50000000)) clk1
//     (.clk(clk), .new_clk(clk1Hz));
endmodule