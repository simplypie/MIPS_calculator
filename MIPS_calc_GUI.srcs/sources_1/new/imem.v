//module imem (input [5:0] a,
//             output [31:0] rd);
             
//    reg [31:0] RAM[0:63];

//    initial
//        begin
//            $readmemh ("memfile.dat",RAM);
//        end
//    assign rd = RAM[a]; // word aligned
//endmodule

module imem (input [5:0] a,
             output [31:0] rd);
             
    reg [31:0] RAM[0:63];
    
//    initial RAM[0] = 32'h20130001;
//    initial RAM[1] = 32'h20100000;
//    initial RAM[2] = 32'h20110008;
//    initial RAM[3] = 32'h20120002;
//    initial RAM[4] = 32'h02328822;
//    initial RAM[5] = 32'h22100001;
//    initial RAM[6] = 32'h0220402A;
//    initial RAM[7] = 32'h11130001;
//    initial RAM[8] = 32'h08000004;
//    initial RAM[9] = 32'h02138022;

    initial
        begin
            $readmemh ("memfile.dat",RAM);
        end
    assign rd = RAM[a]; // word aligned
endmodule