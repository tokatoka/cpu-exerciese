`include "Types.v"

module PCAdder(
    output `InsnAddrPath addrOut,
    input `InsnAddrPath addrIn
);
    always_latch begin
        addrOut = addrIn + `INSN_PC_INC;
    end
endmodule
