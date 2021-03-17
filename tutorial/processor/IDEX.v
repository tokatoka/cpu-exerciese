`include "Types.h"

module PC(
    input logic clk,
    input logic rst,
    input logic cHazard,

    input `InsnAddrPath PCAddrIn;

    input logic IsDstRtIn,
    input logic PcWrEnableIn,
    input logic IsLoadInsnIn,
    input logic IsStoreInsnIn,
    input logic IsSrcA_RtIn,
    input logic RfWrEnableIn,
    input logic IsALUInConstantIn,
    input `BrCodePath BrCodeIn,
    input `ALUCodePath AluCodeIn,

    input `ShamtPath ShamtIn,
    input `FunctPath FunctIn,

    input `DataPath RdDataAIn,
    input `DataPath RdDataBIn,
    input `ConstantPath ConstantIn,

    input `RegNumPath RSIn,
    input `RegNumPath RTIn,
    input `RegNumPath RDIn,

    output `InsnAddrPath PCAddrOut,
    output logic IsDstRtOut,
    output logic PcWrEnableOut,
    output logic IsLoadInsnOut,
    output logic IsStoreInsnOut,
    output logic IsSrcA_RtOut,
    output logic RfWrEnableOut,
    output logic IsALUInConstantOut,
    output `BrCodePath BrCodeOut,
    output `ALUCodePath AluCodeOut,

    output `ShamtPath ShamtOut,
    output `FunctPath FunctOut,

    output `DataPath RdDataAOut,
    output `DataPath RdDataBOut,
    output `ConstantPath ConstantOut,

    output `RegNumPath RSOut,
    output `RegNumPath RTOut,
    output `RegNumPath RDOut,
)

    always_ff @(posedge clk or negedge rst) begin
        if(cHazard) begin
            PCAddrIn <= `InsnAddrPath'h0;

            IsDstRtOut <= `FALSE;
            PcWrEnableOut <= `FALSE;
            IsLoadInsnOut <= `FALSE;
            IsStoreInsnOut <= `FALSE;
            IsSrcA_RtOut <= `FALSE;
            RfWrEnableOut <= `FALSE;
            IsALUInConstantOut <= `FALSE;

            BrCodeOut <= `BrCodePath'h0;
            AluCodeOut <= `ALUCodePath'h0;
            ShamtOut <= `ShamtPath'h0;
            FunctOut <= `FunctPath'h0;
            RdDataAOut <= `DataPath'h0;
            RdDataBOut <= `DataPath'h0;
            ConstantOut <= `ConstantPath'h0;
            RSOut <= `RegNumPath'h0;
            RTOut <= `RegNumPath'h0;
            RDOut <= `RegNumPath'h0;
        end
        else begin
            PCAddrOut <= PCAddrIn;

            IsDstRtOut <= IsDstRtIn;
            PcWrEnableOut <= PcWrEnableIn;
            IsLoadInsnOut <= IsLoadInsnIn;
            IsStoreInsnOut <= IsStoreInsnIn;
            IsSrcA_RtOut <= IsSrcA_RtIn;
            RfWrEnableOut <= RfWrEnableIn;
            IsALUInConstantOut <= IsALUInConstantIn;

            BrCodeOut <= BrCodeIn;
            AluCodeOut <= AluCodeIn;
            ShamtOut <= ShamtIn;
            FunctOut <= FunctIn;
            RdDataAOut <= RdDataAIn;
            RdDataBOut <= RdDataBIn;
            ConstantOut <= ConstantIn;
            RSOut <= RSIn;
            RTOut <= RTIn;
            RDOut <= RDIn;
        end
    end
endmodule