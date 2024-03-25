// REGISTER FILE MODULE
// NOTE: MORE TO BE ADDED IN LAB 5
//
// ON ANY SIGNAL CHANGE:
// qa SETS TO VALUE OF REGISTER AT ADDRESS rs
// qb IS SET TO VALUE OR REGISTER AT ADDRESS rt
//
// INTERNAL: 32 REGISTER SLOTS EACH 32 BITS WIDE
//
// LAB5 ADDITIONS:
// INPUTS: WDESTREG, WBDATA, WWREG, CLK
// ON NEGEDGE OF CLK:
//     IF WWREG IS 1, REGISTER AT POSITION WDESTREG IS SET TO WBDATA

module RegisterFile(
    input [4:0] rs, // bits 25:21 of dinstOut
    input [4:0] rt, // bits 20:16 of dinstOut
    input [4:0] wdestReg,   // destination register in regfile to write to, from MEM/WB Reg, via regrt Mux
    input [31:0] wbData,    // data to write to register location, from wbMux
    input wwreg,            // write enable, from MEM/WB Reg via Control Unit
    input clk,              // control timing of data write to reg
    
    output reg [31:0] qa,
    output reg [31:0] qb
);

    reg [31:0] registers [0:31];
    
    initial
    begin
        registers[0] = 32'h00000000;
        registers[1] = 32'hA00000AA;
        registers[2] = 32'h10000011;
        registers[3] = 32'h20000022;
        registers[4] = 32'h30000033;
        registers[5] = 32'h40000044;
        registers[6] = 32'h50000055;
        registers[7] = 32'h60000066;
        registers[8] = 32'h70000077;
        registers[9] = 32'h80000088;
        registers[10] = 32'h90000099;
;
    end
    
    always @(*)
    begin
        qa <= registers[rs];
        qb <= registers[rt];
    end
    
    always @(negedge clk)
    begin
        case (wwreg)
            1'b1:
            begin
                registers[wdestReg] <= wbData;
            end
        endcase
    end
endmodule