// REQUIRED FOR IMPLEMENTATION

module TopModule(
    input clk,
    
    output wire [31:0] eqa,
    output wire [31:0] eqb,
    output wire [31:0] mr
    );
    
    Datapath datapath(.clk(clk), .eqa(eqa), .eqb(eqb), .mr(mr));
endmodule
