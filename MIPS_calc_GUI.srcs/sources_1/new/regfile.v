module regfile (input         clk,
                input         we3,
                input  [4:0]  ra1, ra2, wa3,
                input  [31:0] wd3,
                output [31:0] rd1, rd2,
                output [31:0] answer,
                input [31:0]   num1, num2,
                input [1:0]   op,
                output        done);
    reg [31:0] rf[31:0];
    
    assign answer = rf[16];
    assign done = rf[3];
    //
    //
    // assign outputs from reg 16 (s0) and reg 3(v1)
    
    always @(posedge clk)
    begin
          rf[2]  = {30'h0000000, op};
          rf[17] = num1;
          rf[18] = num2;
          if (we3) rf[wa3] <= wd3;
    end
    //
    //
    // added to assign reg from op num1 num2

// three ported register file
// read two ports combinationally
// write third port on rising edge of clock
// register 0 hardwired to 0

//    always @ (posedge clk)
//        if (we3) rf[wa3] <= wd3;
    assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
    assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule