// ALU MUX MODULE
// INPUTS: EQB [32B], EIMM32 [32B], EALUIMM
// OUTPUTS: B [32B]
//
// IF EALUIMM IS 0, SET TO VALUE OF EQB
// IF EALUIMM IS 1, SET TO VALUE OF EIMM32



module ALUMux(
    input [31:0] eqb, // eqb bits from ID/EXE reg
    input [31:0] eimm32, // eimm32 bits from ID/EXE reg
    input ealuimm,    // MUX selector bit, from ID/EXE reg via Control Unit
    
    output reg [31:0] b // output to b-input of ALU
);

    always @(*)
    begin
        case (ealuimm)
            1'b0:
            begin
                b <= eqb;
            end
            1'b1:
            begin
                b <= eimm32;
            end
        endcase
    end
endmodule
