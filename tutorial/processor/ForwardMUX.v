`include "Types.v"

module ForwardMUX(
    input `DataPath idexData,
    input `DataPath exmemData,
    input `DataPath memwbData,
    input `ForwardCodePath forwardCode,
    output `DataPath selectedData
);

    always_comb begin
        case (forwardCode)
            `EXMEM_FORWARD: selectedData = exmemData;
            `MEMWB_FORWARD: selectedData = memwbData;
            default: selectedData = idexData;
        endcase
    end
endmodule