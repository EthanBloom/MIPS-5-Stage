// INSTRUCTION MEMORY MODULE
// STORES INSTRUCTIONS MEMORY WHEN INSTRUCTIONS ARE TO BE EXECUTED
// instOut SET TO VALUE OF MEMORY ARRAY AT POSITION PC ON ANY SIGNAL CHANGE
//
// AS OF FINAL PROJECT: PRESET INSTRUCTIONS CHANGED

module InstructionMemory(
    input [31:0] pc,
    
    output reg [31:0] instOut // instruction out
    
    );
    
    reg [31:0] memory [0:63]; // 32x64 register array (32 bits wide, 64 words)
    
    initial
    begin
        // for load word: $rt = destination to load into, $rs = location of data to load from
        memory[25] = {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100000};
        memory[26] = {6'b000000, 5'b01001, 5'b00011, 5'b00100, 5'b00000, 6'b100010};
        memory[27] = {6'b000000, 5'b00011, 5'b01001, 5'b00101, 5'b00000, 6'b100101};
        memory[28] = {6'b000000, 5'b00011, 5'b01001, 5'b00110, 5'b00000, 6'b100110};
        memory[29] = {6'b000000, 5'b00011, 5'b01001, 5'b00111, 5'b00000, 6'b100100};
    end
    
    always @(*)
    begin
        instOut <= memory[pc[7:2]];
    end
endmodule
