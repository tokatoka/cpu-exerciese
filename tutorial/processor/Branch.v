`include "Types.v"

module BranchUnit(
    output `InsnAddrPath pcOut,
    output logic brTaken,
    output logic pcWrEnableOut,

    input `InsnAddrPath pcIn,
    input `BrCodePath brCode,
    input `DataPath regRS,
    input `DataPath regRT,
    input `ConstantPath constant,
    input logic pcWrEnableIn
);
    `InsnAddrPath disp;

    always_comb begin
        case (brCode)
            `BR_CODE_EQ: brTaken = (regRS == regRT) ? `TRUE : `FALSE;
            `BR_CODE_NE: brTaken = (regRS != regRT) ? `TRUE : `FALSE;
            `BR_CODE_TAKEN: brTaken = `TRUE;
            default: brTaken = `FALSE;
        endcase

        pcWrEnableOut = pcWrEnableIn;
        disp = `EXPAND_BR_DISPLACEMENT(constant);
        pcOut = pcIn + `INSN_PC_INC + (brTaken ? disp : `INSN_ADDR_WIDTH'h0 );
    end

endmodule