// FORWARDING MULTIPLEXER MODULE
//
// CASES FOR FWD:
// 0: Q = REGOUT
// 1: Q == R
// 2: Q == MR
// 3: Q == MDO

module FwdingMux(
    input [31:0] regOut,    // from register file (eitehr ra or rb)
    input [31:0] r,         // from ALU
    input [31:0] mr,        // from EXE/MEM reg
    input [31:0] mdo,       // from data memory
    input [1:0] fwd,    // forwarding control signal from Control Unit
    
    output reg [31:0] q // output to ID/EXE reg
    );
    
    
    always @(*)
    begin
        case (fwd)
            2'd0:
            begin
                q <= regOut;
            end
            2'd1:
            begin
                q <= r;
            end
            2'd2:
            begin
                q <= mr;
            end
            2'd3:
            begin
                q <= mdo;
            end
        endcase
    end
endmodule
