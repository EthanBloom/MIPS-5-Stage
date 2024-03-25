// 16 TO 32 BIT IMMEDIATE SIGN EXTENSION MODULE
// NOTE: MUST SIGN EXTEND NOT ZERO EXTEND
// USE CASES OF MSB OF IMM?

module Immediate_Extender(
    input [15:0] imm,
    
    output reg [31:0] imm32
);

    always @(*)
    begin
        case (imm[15])
            1'b1:
            begin
                imm32[31:16] <= 16'b1111111111111111;
                imm32[15:0] <= imm;
            end
            1'b0:
            begin
                imm32[31:16] <= 16'b0000000000000000;
                imm32[15:0] <= imm;                
            end
        endcase
    end
endmodule