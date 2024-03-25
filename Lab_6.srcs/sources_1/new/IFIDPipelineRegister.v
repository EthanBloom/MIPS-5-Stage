// IFID PIPELINE REGISTER (instruction fetch and instruction decode)
// ON POSEDGE OF CLOCK, SET dinstOut TO instOut
//
// ADDED WPCIR INPUT AS WRITE-ENABLE


module IFID_PipelineReg(
    input [31:0] instOut,
    input clk,
    input wpcir, // from control unit (acts as write enable)
      
    output reg [31:0] dinstOut
);

    always @(posedge clk)
    begin
        if (wpcir != 1'b0)
        begin
            dinstOut <= instOut;
        end
    end
endmodule

