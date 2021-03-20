`include "Types.v"

module PCAdder(
    output `InsnAddrPath addrOut,
    input `InsnAddrPath addrIn
);
    always_comb begin
        addrOut = addrIn + `INSN_PC_INC;
    end
endmodule
