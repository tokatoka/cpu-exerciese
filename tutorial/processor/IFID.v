`include "Types.v"

module IFID(
    input logic clk,
    input logic rst,
    input logic cHazard,
    input logic dHazard,

    input `InsnAddrPath PCAddrIn,
    input `InsnPath InsnIn,
    input `RegNumPath RSIn,
    input `RegNumPath RTIn,

    output `InsnAddrPath PCAddrOut,
    output `InsnPath InsnOut,

    //we need to decode these two before decoder does for hazard detection
    output `RegNumPath RSOut,
    output `RegNumPath RTOut
);

    always_ff @(posedge clk or negedge rst) begin
        if(cHazard || !rst) begin
            PCAddrOut <= `INSN_ADDR_WIDTH'h0;
            InsnOut <= `INSN_WIDTH'h0;
            RSOut <= `REG_NUM_WIDTH'h0;
            RTOut <= `REG_NUM_WIDTH'h0;
        end
        
        if(!dHazard) begin
            PCAddrOut <= PCAddrIn;
            InsnOut <= InsnIn;
            RSOut <= RSIn;
            RTOut <= RTIn;
        end
    end
endmodule