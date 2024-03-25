`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 07/04/2023 08:02:30 PM
// Design Name: Lab4 Testbench
// Module Name: testbench
// Project Name: Lab4
// Revision 2 - Lab4 Tests
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench();
    reg clk;
    
    wire [31:0] pc;
    wire [31:0] dinstOut;
    
    wire ewreg;
    wire em2reg;
    wire ewmem;
    wire [3:0] ealuc;
    wire elauimm;
    wire [4:0] edestReg;
    wire [31:0] eqa;
    wire [31:0] eqb;
    wire [31:0] eimm32;
    
    wire mwreg;
    wire mm2reg;
    wire mwmem;
    wire [4:0] mdestReg;
    wire [31:0] mr;
    wire [31:0] mqb;
    
    wire wwreg;
    wire wm2reg;
    wire [4:0] wdestReg;
    wire [31:0] wr;
    wire [31:0] wdo;
    


    Datapath datapath_tb(clk, pc, dinstOut, ewreg, em2reg, ewmem, ealuc, elauimm, edestReg, eqa, eqb, eimm32, mwreg, mm2reg, mwmem, mdestReg, mr, mqb, wwreg, wm2reg, wdestReg, wr, wdo);
        initial
        begin
            clk = 0;
        end

    always begin
        #5;
        clk = ~clk;
    end
endmodule
