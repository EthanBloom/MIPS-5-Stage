// REGRT MUX MODULE
// DETERMINE DESTINATION REGISTER FOR DATA
// IF REGRT 0, SET TO RD. IF REGRT 1, SET TO RT

module RegRtMux(
    input [4:0] rt, // bits 20:16 of dinstOut
    input [4:0] rd, // bits 15:11 of dinstOut
    input regrt,    // from control unit
    
    output reg [4:0] destReg
);

    always @(*)
    begin
        case (regrt)
            1'b0:
            begin
                destReg <= rd;
            end
            1'b1:
            begin
                destReg <= rt;
            end
        endcase
    end
endmodule
