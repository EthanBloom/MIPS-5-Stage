// PROGRAM COUNTER MODULE
// INITIALIZES PC TO 100 AND SETS PC TO NEXTPC ON EVERY POSITIVE CLOCK EDGE
//
// ADDED WPCIR INPUT AS WRITE-ENABLE

module ProgramCounter(
    input [31:0] nextPC,
    input clk,
    input wpcir, // from control unit (acts as write enable)
    
    output reg [31:0] pc
    );
    
    initial
    begin
        pc <= 32'd100;
    end
    
    always @(posedge clk)
    begin
        if (wpcir != 1'b0)
        begin
            pc <= nextPC;
        end
    end
        
endmodule
   