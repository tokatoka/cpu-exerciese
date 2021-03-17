`include "Types.v"

module IFID(
    input logic clk,
    input logic rst,
    input logic cHazard,

    input `InsnAddrPath PCAddrIn,
    input `InsnPath InsnIn,

    output `InsnAddrPath PCAddrOut,
    output `InsnPath InsnOut
);

    always_ff @(posedge clk or negedge rst) begin
        if(cHazard || !rst) begin
            PCAddrOut <= `INSN_ADDR_WIDTH'h0;
            InsnOut <= `INSN_WIDTH'h0;
        end
        else begin
            PCAddrOut <= PCAddrIn;
            InsnOut <= InsnIn;
        end
    end


endmodule