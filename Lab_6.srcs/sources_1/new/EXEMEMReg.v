// EXE / MEM PIPELINE REGISTER MODULE
// INPUTS: EWREG, EM2REG, EWMEM, EDESTREG [5B], R [32B], EQB [32B], CLOCK
// OUTPUTS: MWREG, MM2REG, MWMEM, MDESTREG [5B], MR [32B], MQB [32B]
//
// ON POSEDGE CLOCK:
// SET VALUES


module EXEMEMReg(
    input ewreg, // from ID/EXE Reg via Control Unit
    input em2reg, // from ID/EXE Reg via Control Unit
    input ewmem, // from ID/EXE Reg via Control Unit
    input [4:0] edestReg, // from ID/EXE Reg via Control Unit
    input [31:0] r, // from ALU output
    input [31:0] eqb, // from ID/EXE Reg via Reg_file
    input clk,
    
    output reg mwreg, // to MEM/WB Reg
    output reg mm2reg, // to MEM/WB Reg
    output reg mwmem, // to Memory Write Enable
    output reg [4:0] mdestReg, // to MEM/WB Reg
    output reg [31:0] mr, // to MEM/WB Reg / Data Mem Address
    output reg [31:0] mqb // to Data Mem 
    );
    
    always @(posedge clk)
    begin
        mwreg <= ewreg;
        mm2reg <= em2reg;
        mwmem <= ewmem;
        mdestReg <= edestReg;
        mr <= r;
        mqb <= eqb;
    end
endmodule



