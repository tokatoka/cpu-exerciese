`include "Types.v"

module PCAdder(
    output `InsnAddrPath addrOut,
    input `InsnAddrPath addrIn,
    input dHazard
);
    always_comb begin
        if(!dHazard) begin
            addrOut = addrIn + `INSN_PC_INC;
        end
        else begin
            addrOut = addrIn;
        end
    end
endmodule
