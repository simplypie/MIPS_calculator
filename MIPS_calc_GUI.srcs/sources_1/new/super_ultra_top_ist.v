module super_ultra_top_ist(
    input clk,
    input reset,
    input [4:0] button,
    output [11:0] COLOR_OUT,
    output HS,
    output VS
    );
    
    wire done ,enable;
    wire [31:0] answer, digit1, digit2;
    wire [1:0] operation;
    MainActivity GUI (.CLK(clk), .button(button), .done(done), .answer(answer), .COLOR_OUT(COLOR_OUT), .HS(HS), .VS(VS), 
                      .operation(operation),.digit1(digit1),.digit2(digit2) ,.enable(enable));
                        
    toptop PROCESSOR (.clk(clk), .reset(reset), .num1(digit1), .num2(digit2), .op(operation), .en(enable),
                      .answer(answer), .done(done));
endmodule
