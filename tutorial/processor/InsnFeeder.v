`include "Types.v"
module InsnFeeder(
    output `InsnAddrPath addrOut,
    input `InsnAddrPath addrIn,
    input dHazard,

    input `InsnAddrPath branchOut,
    input logic wrEnable
);
    always_comb begin
        if(wrEnable) begin
            addrOut = branchOut;
        end
        else if (!dHazard) begin
            addrOut = addrIn + `INSN_PC_INC;
        end
        else begin
            addrOut = addrIn;
        end
    end
endmodule
