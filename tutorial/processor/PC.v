`include "Types.v"

module PC(
    input logic clk,
    input logic rst,
    input logic dHazard,
    output `InsnAddrPath addrOut,

    input `InsnAddrPath branchOut,
    input logic wrEnable
);

    `InsnAddrPath pc;
    always_ff @(posedge clk or negedge rst) begin
        if(!rst) begin
            pc <= `INSN_RESET_VECTOR;
        end
        else if (wrEnable) begin
            pc <= branchOut;
        end
        else if (!dHazard) begin
            pc <= pc + `INSN_PC_INC;
        end
    end

    assign addrOut = pc;
endmodule