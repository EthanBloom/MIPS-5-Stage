// MEM WB PIPELINE REGISTER MODULE
// INPUTS: MWREG, MM2REG, MDESTREG [5B], MR [32B], MDO [32B], CLOCK
// OUTPUTS: WWREG, WM2REG, WDESTREG [5B], WR [32B], WDO [32B]
//
// ON POSEDGE CLK:
// SET VALUES


module MEMWBReg(
    input mwreg, // from EXE/MEM Reg via Control Unit
    input mm2reg, // from EXE/MEM Reg via Control Unit
    input [4:0] mdestReg, // from EXE/MEM Reg via Control Unit
    input [31:0] mr, // from EXE/MEM Reg via ALU
    input [31:0] mdo, // from Data Memory File
    input clk,
    
    output reg wwreg, // to Reg_File
    output reg wm2reg, // to WB Mux
    output reg [4:0] wdestReg, // to Reg_File
    output reg [31:0] wr, // to WB Mux
    output reg [31:0] wdo // to WB Mux
    );
    
    always @(posedge clk)
    begin
        wwreg <= mwreg;
        wm2reg <= mm2reg;
        wdestReg <= mdestReg;
        wr <= mr;
        wdo <= mdo;
    end
endmodule