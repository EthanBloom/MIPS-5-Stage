// CONTROL UNIT MODULE
// ON ANY SIGNAL CHANGE: ALL OUTPUTS ARE ASSIGNED BASED ON THE VALUES OF op AND func (BITS FROM INSTRUCTION)
//
// NEW INPUTS/OUTPUTS/REGISTERS AS OF FINAL PROJECT
// ALUC SIGNALS: 0010 = ADD, 0001 = SUB, 0100 = AND, 1000 = OR, 1001 = XOR

module ControlUnit(
    input [5:0] op, // bits 31:26 of dinstOut
    input [5:0] func, // bits 5:0 of dinstOut
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] mdestReg,
    input mm2reg,
    input mwreg,
    input [4:0] edestReg,
    input em2reg,
    input ewreg,
    
    output reg wreg, // when 1, indicates writing to 32 general purpose registers in regfile
    output reg m2reg, // when 1, indicates loading a value from memory into registers
    output reg wmem, // when 1, indicates we are writing to data memory
    output reg [3:0] aluc, // array of four bits indicates operation that we intend to execute on ALU
    output reg aluimm, // when 1, indicates that we want to use the value of sign extended immediate instead of value of qb in our ALU
    output reg regrt, // when 1, indicates that when writing to regfile, we want to write address in rt rather than to address in rd
    output reg [1:0] fwda,  // to fwdingMuxA
    output reg [1:0] fwdb,  // to fwdingMuxB
    output reg wpcir        // (write program counter instruction read) stall signal; active low
);
    
    reg regUsage;   // set to 1 if rs/rt is being read;

    initial
    begin
        // for this implementation, regUsage is always 1
        regUsage <= 1'b1;
    end
    always @(*)
    begin
        case (op)
            6'b000000: // r-type instructions
            begin
                case (func)
                    6'b100000: // ADD instruction
                    begin
                        // setting values of control signals for ADD instruction
                        wreg <= 1'b1;
                        m2reg <= 1'b0;
                        wmem <= 1'b0;
                        aluc <= 4'b0010;    // 0010 = ADD
                        aluimm <= 1'b0;
                        regrt <= 1'b1;
                    end
                    // add other ALU operations below
                    6'b100010: // SUB instruction
                    begin
                        // setting values of control signals for SUB instruction
                        wreg <= 1'b1;
                        m2reg <= 1'b0;
                        wmem <= 1'b0;
                        aluc <= 4'b0001;    // 0001 = SUB
                        aluimm <= 1'b0;
                        regrt <= 1'b1;
                    end
                    6'b100100: // AND instruction
                    begin
                        // setting values of control signals for AND instruction
                        wreg <= 1'b1;
                        m2reg <= 1'b0;
                        wmem <= 1'b0;
                        aluc <= 4'b0100;    // 0100 = AND
                        aluimm <= 1'b0;
                        regrt <= 1'b1;
                    end
                    6'b100101: // OR instruction
                    begin
                        // setting values of control signals for 0R instruction
                        wreg <= 1'b1;
                        m2reg <= 1'b0;
                        wmem <= 1'b0;
                        aluc <= 4'b1000;    // 1000 = OR
                        aluimm <= 1'b0;
                        regrt <= 1'b1;
                    end
                    6'b100110: // XOR instruction
                    begin
                        // setting values of control signals for XOR instruction
                        wreg <= 1'b1;
                        m2reg <= 1'b0;
                        wmem <= 1'b0;
                        aluc <= 4'b1001;    // 1001 = XOR
                        aluimm <= 1'b0;
                        regrt <= 1'b1;
                    end
                endcase
            end
            6'b100011: // LW instruction
            begin
                // setting values of control signals for LW instruction
                wreg <= 1'b1;
                m2reg <= 1'b1;
                wmem <= 1'b0;
                aluc <= 4'b0010;
                aluimm <= 1'b1;
                regrt <= 1'b1;
                
            end
        endcase
        
        // stalling control:
        if (
            ewreg == 1'b1 &&
            em2reg == 1'b1 &&
            edestReg != 5'b0 &&
            regUsage == 1'b1 &&
            (edestReg == rs || edestReg == rt)
            )
        begin
            wreg <= 1'b0;
            wmem <= 1'b0;
            wpcir <= 1'b0;
        end else begin
            wpcir <= 1'b1;
            // wreg and wmem are not set
        end
        
        // for forwarding A
        if (
            ewreg == 1'b1 &&
            edestReg != 5'b0 &&
            edestReg == rs &&
            em2reg == 1'b0
            )
        begin
            fwda <= 2'd1;
        end
        else if (
            mwreg == 1'b1 &&
            mdestReg != 5'b0 &&
            mdestReg == rs &&
            mm2reg == 1'b0
            )
        begin
            fwda <= 2'd2;
        end
        else if (
            mwreg == 1'b1 &&
            mdestReg != 5'b0 &&
            mdestReg == rs &&
            mm2reg == 1'b1
            )
        begin
            fwda <= 2'd3;
        end
        else
        begin
            fwda <= 2'd0;
        end
           
        // for forwarding B
        if (
            ewreg == 1'b1 &&
            edestReg != 5'b0 &&
            edestReg == rt &&
            em2reg == 1'b0
            )
        begin
            fwdb <= 2'd1;
        end
        else if (
            mwreg == 1'b1 &&
            mdestReg != 5'b0 &&
            mdestReg == rt &&
            mm2reg == 1'b0
            )
        begin
            fwdb <= 2'd2;
        end
        else if (
            mwreg == 1'b1 &&
            mdestReg != 5'b0 &&
            mdestReg == rt &&
            mm2reg == 1'b1
            )
        begin
            fwdb <= 2'd3;
        end
        else
        begin
            fwdb <= 2'd0;
        end
    end
endmodule





