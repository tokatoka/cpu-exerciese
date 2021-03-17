`include "Types.h"

module IFED(
    input logic clk,
    input logic rst,
    input logic cHazard;

    
    input `InsnAddrPath ifidPCAddrIn,
    input `InsnPath ifidInsnIn,

    output `InsnAddrPath ifidPCAddrOut,
    output `InsnPath ifidInsnOut,
)

    always_ff @(posedge clk or negedge rst) begin
        if(cHazard) begin
            ifidPCAddrOut = `InsnAddrPath'h0;
            ifidInsnOut = `InsnPath'h0;
        end
        else begin
            ifidPCInsnOut = ifidPCAddrIn;
            ifidInsnOut = ifidInsnIn;
        end
    end


endmodule