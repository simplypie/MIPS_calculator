module prog_clk# (parameter N = 17, parameter MAX = 125000) (
    input clk, 
    output reg new_clk);
    
    reg [N-1:0] counter;     // log2(125000)
    always @(posedge clk) begin
        if(counter == MAX)
        begin
            counter <= 0;
            new_clk <= ~new_clk ;
        end
        else
            counter <= counter + 1;
    end
endmodule