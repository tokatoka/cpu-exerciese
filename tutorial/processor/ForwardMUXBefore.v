`include "Types.v"

module ForwardMUXBefore(
    input `DataPath ifidData,
    input `DataPath memwbData,
    input `ForwardCodePath forwardCode,
    output `DataPath selectedData
);

    always_comb begin
        case (forwardCode)
            `MEMWB_TOIDEXIN: selectedData = memwbData;
            default: selectedData = ifidData;
        endcase
    end
endmodule