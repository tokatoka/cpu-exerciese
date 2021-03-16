`include "Types.h"

module IFED(
    input logic clk,
    input logic rst,
    input logic cHazard;

    input `InsnAddrPath ifidInsnIn,
    output `InsnAddrPath ifidInsnOut,
)

    always_ff @(posedge clk or negedge rst) begin
        if(cHazard) begin
            ifidInsnOut = `InsnAddrPath'h0;
        end
        else begin
            ifidInsnOut = ifidInsnIn;
        end
    end


endmodule