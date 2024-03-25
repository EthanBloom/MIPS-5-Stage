// CMPEN 331 - VIVADO XILINX MIPS CPU
// ETHAN BLOOM
//
// DATAPATH MODULE
// MAIN MODULE
// AS OF LAB 6; 8/9/23
// 
// INPUT CLOCK ONLY
// 
// OUTPUTS: PC, ALL OUTPUTS FROM IFID AND IDEXE REGISTERS, AS WELL AS OUTPUTS FROM EXEMEM AND MEMWB REGISTERS
//          NOTE: ALL OUTPUTS IN THE DATAPATH WILL BE WIRES INSTEAD OF REGISTERS. THIS IS BECAUSE THEIR VALUES
//                ARE DRIVEN BY THE MODULES THEY ARE CONNECTED TO, AND THE MODULES HANDLE SETTING THE VALUES AT THE PROPER
//                TIMES WHEN THEY NEED TO BE SET
//
// INTERNAL PARTS:
//
// DATAPATH SHOULD ISNTANTIATE AN INSTANCE OF ALL MODULES SO FAR IN DATAPATH, AS WELL AS USE WIRES TO CONNECT THEM TOGETHER
//
// DATAPATH WILL NOT HAVE AN ALWAYS BLOCK, IT SIMPLY CONTAINS ALL OF THE MODULES NEEDED FOR THE CPU AND CONNECTS THEM
// TOGETHER, AS WELL AS EXPOSES PARTS OF THE MODULE OUTPUTS FOR THE TESTBENCH
//
//

module Datapath(
    input clk,
    
    output wire [31:0] pc,
    
    // FROM IFID
    output wire [31:0] dinstOut,
    
    // FROM IDEXE
    output wire ewreg,
    output wire em2reg,
    output wire ewmem,
    output wire [3:0] ealuc,
    output wire ealuimm,
    output wire [4:0] edestReg,
    output wire [31:0] eqa,
    output wire [31:0] eqb,
    output wire [31:0] eimm32,
    
    // FROM EXEMEM
    output wire mwreg,
    output wire mm2reg,
    output wire mwmem,
    output wire [4:0] mdestReg,
    output wire [31:0] mr,
    output wire [31:0] mqb,
    
    // FROM MEMWB
    output wire wwreg,
    output wire wm2reg,
    output wire [4:0] wdestReg,
    output wire [31:0] wr,
    output wire [31:0] wdo
);

// Instantiate PC Adder
wire [31:0] pc_plus4;
PC_adder pc_inc(pc, pc_plus4);

// Instantiate PC Module (Register)
ProgramCounter pc_reg(pc_plus4, clk, wpcir, pc);

// Instantiate Instruction Memory
wire [31:0] instruction;
InstructionMemory inst_mem(pc, instruction);

// Instantiate IF / ID Pipeline Register
IFID_PipelineReg inst_fetch_decode(instruction, clk, wpcir, dinstOut);

// Instantiate Control Unit
wire [5:0] op_bits = dinstOut[31:26];
wire [5:0] func_bits = dinstOut[5:0];

wire wreg;
wire m2reg;
wire wmem;
wire [3:0] aluc;
wire aluimm;
wire regrt;

wire wpcir;

ControlUnit control(op_bits, func_bits, rs, rt, mdestReg, mm2reg, mwreg, edestReg, em2reg, ewreg, wreg, m2reg, wmem, aluc, aluimm, regrt, fwda, fwdb, wpcir);

// Instantiate regrt Mux
wire [4:0] rt = dinstOut[20:16];
wire [4:0] rd = dinstOut[15:11];
wire [4:0] destReg;
RegRtMux Reg_rt_Mux(rt, rd, regrt, destReg);

// Instantiate Register File
// NOTE: ADDITIONAL INPUTS PASSED DURING LAB5
wire [4:0] rs = dinstOut[25:21];
wire [31:0] ra;
wire [31:0] rb;
RegisterFile reg_file(rs, rt, wdestReg, wbData, wwreg, clk, ra, rb);

// Instantiate Immediate Extender
wire [15:0] imm = dinstOut[15:0];
wire [31:0] imm32;
Immediate_Extender imm_ext(imm, imm32);

// Instantiate ID / EXE Pipeline Register
IDEXE_PipelineReg IDEXE(wreg, m2reg, wmem, aluc, aluimm, destReg, qa, qb, imm32, clk, ewreg, em2reg, ewmem, ealuc, ealuimm, edestReg, eqa, eqb, eimm32);

// Instantiate ALU Mux
wire [31:0] b; // wire for output of ALU Mux (becomes input for ALU)
ALUMux ALUMux(eqb, eimm32, ealuimm, b);

// Instantiate ALU Module
wire [31:0] r; // result (output) of ALU (goes into EXEMEMReg
ALU ALU(eqa, b, ealuc, r);

// Instantiate EXE / MEM Pipeline Register
EXEMEMReg EXEMEMReg(ewreg, em2reg, ewmem, edestReg, r, eqb, clk, mwreg, mm2reg, mwmem, mdestReg, mr, mqb);

// Instantiate Data Memory Module
wire [31:0] mdo; // Memory Data Out, will go to MEMWB Reg
DataMem DataMem(mr, mqb, mwmem, clk, mdo);

// Instantiate MEM / WB Pipeline Register
MEMWBReg MEMWBReg(mwreg, mm2reg, mdestReg, mr, mdo, clk, wwreg, wm2reg, wdestReg, wr, wdo);

// Instantiate WB Mux Module 
wire [31:0] wbData;
wbMux wbMux(wr, wdo, wm2reg, wbData);

// Instantiate fwding mux A
wire [1:0] fwda;
wire [31:0] qa;
FwdingMux fwdmuxA(ra, r, mr, mdo, fwda, qa);

// Instantiate fwding mux B
wire [1:0] fwdb;
wire [31:0] qb;
FwdingMux fwdmuxB(rb, r, mr, mdo, fwdb, qb);

endmodule














