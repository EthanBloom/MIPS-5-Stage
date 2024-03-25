// PROGRAM COUNTER ADDER
// INCREASES PC BY 4 (SETS NEXTPC TO PC + 4)

module PC_adder(
    input [31:0] pc,
    
    output reg [31:0] nextPc
    );
    
    parameter INCREMENT_AMOUNT = 32'd4;
    
    always @(*)
    begin
        nextPc <= pc + INCREMENT_AMOUNT;
    end
endmodule