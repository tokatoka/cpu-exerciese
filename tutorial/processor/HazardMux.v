`include "Types.v"

module HazardMux(
    input logic IsDstRtIn,
    input logic PcWrEnableIn,
    input logic IsLoadInsnIn,
    input logic IsStoreInsnIn,
    input logic IsSrcA_RtIn,
    input logic RfWrEnableIn,
    input logic IsALUInConstantIn,
    input logic dHazard,

    output logic IsDstRtOut,
    output logic PcWrEnableOut,
    output logic IsLoadInsnOut,
    output logic IsStoreInsnOut,
    output logic IsSrcA_RtOut,
    output logic RfWrEnableOut,
    output logic IsALUInConstantOut
);
    always_comb begin
        IsDstRtOut = dHazard ? `FALSE : IsDstRtIn;
        PcWrEnableOut = dHazard ? `FALSE : PcWrEnableIn;
        IsLoadInsnOut = dHazard ? `FALSE : IsLoadInsnIn;
        IsStoreInsnOut = dHazard ? `FALSE : IsStoreInsnIn;
        IsSrcA_RtOut = dHazard ? `FALSE : IsSrcA_RtIn;
        RfWrEnableOut = dHazard ? `FALSE : RfWrEnableIn;
        IsALUInConstantOut = dHazard ? `FALSE : IsALUInConstantIn;
    end
endmodule