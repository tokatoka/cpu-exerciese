include "Types.h"

module EXMEM(
    input logic clk,
    input logic rst,
    input logic cHazard,

    input `InsnAddrPath exmemPCAddrIn,
    input `DataPath exmemALUOutIn,
    input `BrCodePath exmemBrCodeIn,

    input logic exmemIsDstRtIn,    
    input logic exmemRdWrEnableIn,
    input logic exmemIsStoreInsnIn,
    input logic exmemIsLoadInsnIn,
    input logic exmemPcWrEnableIn,

    input `DataPath exmemRdDataBIn,
    input `ConstantPath exmemConstantIn,

    input `RegNumPath exmemRSIn,
    input `RegNumPath exmemRTIn,
    input `RegNumPath exmemRDIn,


    output `InsnAddrPath exmemPCAddrOut,
    output `DataPath exmemALUOutOut,
    output `BrCodePath exmemBrCodeOut,

    output logic exmemIsDstRtOut,    
    output logic exmemRdWrEnableOut,
    output logic exmemIsStoreInsnOut,
    output logic exmemIsLoadInsnOut,
    output logic exmemPcWrEnableOut,

    output `DataPath exmemRdDataBOut,
    output `ConstantPath exmemConstantOut,

    output `RegNumPath exmemRSOut,
    output `RegNumPath exmemRTOut,
    output `RegNumPath exmemRDOut,
)

    always_ff @(posedge clk or negedge rst) begin
        if(cHazard) begin
            exmemPCAddrOut <= `InsnAddrPath'h0;
            exmemALUOutOut <= `DataPath'h0;
            exmemBrCodeOut <= `BrCodePath'h0;
            exmemIsDstRtOut <= `FALSE;
            exmemRdWrEnableOut <= `FALSE;
            exmemIsStoreInsnOut <= `FALSE;
            exmemIsLoadInsnOut <= `FALSE;
            exmemPcWrEnableOut <= `FALSE;

            exmemRdDataBOut <= `DataPath'h0;
            exmemConstantOut <= `ConstantPath'h0;
            exmemRSOut <= `RegNumPath'h0;
            exmemRTOut <= `RegNumPath'h0;
            exmemRDOut <= `RegNumPath'h0;
        end
        else begin
            exmemPCAddrOut <= exmemPCAddrIn;
            exmemALUOutOut <= exmemPCAddrIn;
            exmemBrCodeOut <= exmemBrCodeIn;
            exmemIsDstRtOut <= exmemIsDstRtIn;
            exmemRdWrEnableOut <= exmemRdWrEnableIn;
            exmemIsStoreInsnOut <= exmemIsStoreInsnIn;
            exmemIsLoadInsnOut <= exmemIsLoadInsnIn;
            exmemPcWrEnableOut <= exmemPcWrEnableIn;

            exmemRdDataBOut <= exmemRdDataBIn;
            exmemConstantOut <= exmemConstantIn;
            exmemRSOut <= exmemRSIn;
            exmemRTOut <= exmemRTIn;
            exmemRDOut <= exmemRDIn;
        end
    end



endmodule