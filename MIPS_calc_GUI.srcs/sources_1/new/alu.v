module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] F,
    output reg [31:0] Y,
    output reg zero);
    
    always @(A, B, F, Y) begin
        case (F)
            3'b000 : Y <= A & B;    // A AND B
            3'b001 : Y <= A | B;    // A OR B
            3'b010 : Y <= A + B;    // A + B
            3'b100 : Y <= A & ~B;   // A AND !B
            3'b101 : Y <= A | ~B;   // A OR !B
            3'b110 : Y <= A - B; // A - B
            3'b111 : begin // SLT
                        if (A[31] != B[31]) begin
                            if (A[31] > B[31]) begin
                                Y <= 1;
                            end else begin
                                Y <= 0;
                            end
                        end else if (A[31] == 1) begin
                            if (A > B)
                            begin
                                Y <= 1;
                            end
                            else
                            begin
                                Y <= 0;
                            end
                        end else
                            if (A < B)
                            begin
                                Y <= 1;
                            end
                            else
                            begin
                                Y <= 0;
                            end
                     end
            default : Y <= Y;
        endcase
    end
    
    always @(Y) begin
            if (Y == 0) begin
                zero <= 1;
            end else begin
                zero <= 0;
            end
    end
endmodule