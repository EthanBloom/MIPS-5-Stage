// WRITEBACK MULTIPLEXER MODULE
// 
// CASES FOR WM2REG:
// 0: WBDATA = WR
// 1: WBDATA = WDO
// ACT ON ANY SIGNAL CHANGE


module wbMux(
    input [31:0] wr,    // value calculated from ALU, from MEM/WB reg
    input [31:0] wdo,   // value from data memory, from MEM/WB reg
    input wm2reg,       // control signal for Mux, from MEM/WB via Control Unit
    
    output reg [31:0] wbData    // output data to be written back in register file
    );
    
    always @(*)
    begin
        case (wm2reg)
            1'b0:
            begin
                wbData <= wr;
            end
            1'b1:
            begin
                wbData <= wdo;
            end
        endcase
    end
endmodule
