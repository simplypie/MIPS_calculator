module sl2 (input [31:0] a,
            output [31:0] y);
    // shift left by 2
    assign y = {a[29:0], 2'b00};
    // original code ad a[29:01] which doesnt truncate the
    // first bit (the amount of lines to skip) to be multiplied by 4
endmodule