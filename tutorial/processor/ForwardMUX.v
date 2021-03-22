`include "Types.v"

module ForwardMUXAfter(
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

module ForwardMuxBranch(
    input `DataPath dcData,
    input `DataPath exmemData,
    input `DataPath memwbData,

    input `ForwardCodePath forwardCode,
    output `DataPath selectedData
);

    always_comb begin
        case (forwardCode)
            `EXMEM_TOBR: selectedData = exmemData;
            `MEMWB_TOBR: selectedData = memwbData;
            default: selectedData = dcData;
        endcase
    end
endmodule