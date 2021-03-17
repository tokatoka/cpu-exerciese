`include "Types.h"

module PC(
    input logic clk,
    input logic rst,
    input logic cHazard,

    input `InsnAddrPath idexPCAddrIn;

    input logic idexIsDstRtIn,
    input logic idexPcWrEnableIn,
    input logic idexIsLoadInsnIn,
    input logic idexIsStoreInsnIn,
    input logic idexIsSrcA_RtIn,
    input logic idexRfWrEnableIn,
    input logic idexIsALUInConstantIn,
    input `BrCodePath idexBrCodeIn,
    input `ALUCodePath idexAluCodeIn,

    input `ShamtPath idexShamtIn,
    input `FunctPath idexFunctIn,

    input `DataPath idexRdDataAIn,
    input `DataPath idexRdDataBIn,
    input `ConstantPath idexConstantIn,

    input `RegNumPath idexRSIn,
    input `RegNumPath idexRTIn,
    input `RegNumPath idexRDIn,

    output `InsnAddrPath idexPCAddrOut;
    output logic idexIsDstRtOut,
    output logic idexPcWrEnableOut,
    output logic idexIsLoadInsnOut,
    output logic idexIsStoreInsnOut,
    output logic idexIsSrcA_RtOut,
    output logic idexRfWrEnableOut,
    output logic idexIsALUInConstantOut,
    output `BrCodePath idexBrCodeOut,
    output `ALUCodePath idexAluCodeOut,

    output `ShamtPath idexShamtOut,
    output `FunctPath idexFunctOut,

    output `DataPath idexRdDataAOut,
    output `DataPath idexRdDataBOut,
    output `ConstantPath idexConstantOut,

    output `RegNumPath idexRSOut,
    output `RegNumPath idexRTOut,
    output `RegNumPath idexRDOut,
)

    always_ff @(posedge clk or negedge rst) begin
        if(cHazard) begin
            idexPCAddrIn <= `InsnAddrPath'h0;

            idexIsDstRtOut <= `FALSE;
            idexPcWrEnableOut <= `FALSE;
            idexIsLoadInsnOut <= `FALSE;
            idexIsStoreInsnOut <= `FALSE;
            idexIsSrcA_RtOut <= `FALSE;
            idexRfWrEnableOut <= `FALSE;
            idexIsALUInConstantOut <= `FALSE;

            idexBrCodeOut <= `BrCodePath'h0;
            idexAluCodeOut <= `ALUCodePath'h0;
            idexShamtOut <= `ShamtPath'h0;
            idexFunctOut <= `FunctPath'h0;
            idexRdDataAOut <= `DataPath'h0;
            idexRdDataBOut <= `DataPath'h0;
            idexConstantOut <= `ConstantPath'h0;
            idexRSOut <= `RegNumPath'h0;
            idexRTOut <= `RegNumPath'h0;
            idexRDOut <= `RegNumPath'h0;
        end
        else begin
            idexPCAddrOut <= idexPCAddrIn;

            idexIsDstRtOut <= idexIsDstRtIn;
            idexPcWrEnableOut <= idexPcWrEnableIn;
            idexIsLoadInsnOut <= idexIsLoadInsnIn;
            idexIsStoreInsnOut <= idexIsStoreInsnIn;
            idexIsSrcA_RtOut <= idexIsSrcA_RtIn;
            idexRfWrEnableOut <= idexRfWrEnableIn;
            idexIsALUInConstantOut <= idexIsALUInConstantIn;

            idexBrCodeOut <= idexBrCodeIn;
            idexAluCodeOut <= idexAluCodeIn;
            idexShamtOut <= idexShamtIn;
            idexFunctOut <= idexFunctIn;
            idexRdDataAOut <= idexRdDataAIn;
            idexRdDataBOut <= idexRdDataBIn;
            idexConstantOut <= idexConstantIn;
            idexRSOut <= idexRSIn;
            idexRTOut <= idexRTIn;
            idexRDOut <= idexRDIn;
        end
    end
endmodule