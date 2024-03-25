// ALU  MODULE
// INPUTS: EQA [32B], B [32B], ELAUC [4B]
// OUTPUTS: R [32B]
//
// FOR LAB 4 AND 5, ONLY NEEDS ADD FUNCTIONALITY
// SEE CONTROL UNIT FOR ALUC VALUES THAT CORRESPOND TO OPERATIONS
//
// FOR FINAL PROJECT ADD SUB, AND, OR, XOR


module ALU(
    input [31:0] eqa, // input a, from ID/EXE reg via reg_file
    input [31:0] b, // input b from ALU mux
    input [3:0] ealuc, // ALU control bits from ID/EXE reg via Control Unit
    
    output reg [31:0] r // result word from ALU
    );
    
    always @(*)
    begin
        case (ealuc)
            4'b0010: // ADD
            begin
                r <= eqa + b;
            end
            // add cases for other ALU ops below
            // ADDED AS OF FINAL PROJECT
            4'b0001: // SUB
            begin
                r <= eqa - b;
            end
            4'b0100: // AND
            begin
                r <= eqa & b;
            end
            4'b1000: // OR
            begin
                r <= eqa | b;
            end
            4'b0100: // XOR
            begin
                r <= eqa ^ b;
            end
        endcase
    end
endmodule
