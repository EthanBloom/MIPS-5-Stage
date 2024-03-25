// DATA MEMORY MODULE
// INPUTS: MR [32B], MQB [32B], MWMEM, CLOCK
// OUTPUTS: MDO [32B]
// INTERNAL PARTS: MEMORY [2D REGISTER ARRAY]
//
// ON ANY SIGNAL CHANGE:
// MDO IS SET TO VALUE OF MEMORY ARRAY AT POSITION MR
//
// ON NEG EDGE OF CLOCK:
// IF MWMEM IS 1, MEMORY ARRAY AT POSITION MR IS SET TO MQB
//
// ** IMPLEMENTED JUST LIKE INSTMEM **


module DataMem(
    input [31:0] mr, // from EXE/MEM Reg via ALU
    input [31:0] mqb, // from EXE/MEM Reg via Reg_File
    input mwmem, // Memory Write Enable from EXE/MEM Reg via Control Unit
    input clk,
    
    output reg [31:0] mdo // Memory Data Oout to MEM/WB Reg
    );
    
    reg [31:0] memory [0:63];
    
    initial
    begin
        // we need to intiailize the following data:
        //
        // A00000AA 10000011 20000022 30000033 40000044 50000055
        // 60000066 70000077 80000088 90000099
        memory[0] = 32'hA00000AA;
        memory[1] = 32'h10000011;
        memory[2] = 32'h20000022;
        memory[3] = 32'h30000033;
        memory[4] = 32'h40000044;
        memory[5] = 32'h50000055;
        memory[6] = 32'h60000066;
        memory[7] = 32'h70000077;
        memory[8] = 32'h80000088;
        memory[9] = 32'h90000099;
    end
    
    always @(*)
    begin
        mdo = memory[mr];
    end
    
    always @(negedge clk)
    begin
        case (mwmem)
            1'b1:
            begin
                memory[mr] <= mqb;
            end
        endcase
    end
endmodule