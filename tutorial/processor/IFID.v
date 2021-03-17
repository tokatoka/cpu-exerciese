`include "Types.h"

module IFED(
    input logic clk,
    input logic rst,
    input logic cHazard;

    
    input `InsnAddrPath PCAddrIn,
    input `InsnPath InsnIn,

    output `InsnAddrPath PCAddrOut,
    output `InsnPath InsnOut,
)

    always_ff @(posedge clk or negedge rst) begin
        if(cHazard) begin
            PCAddrOut = `InsnAddrPath'h0;
            InsnOut = `InsnPath'h0;
        end
        else begin
            PCInsnOut = PCAddrIn;
            InsnOut = InsnIn;
        end
    end


endmodule