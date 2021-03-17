include "Types.h"

module EXMEM(
    input logic clk,
    input logic rst,
    input logic cHazard,

    input `InsnAddrPath PCAddrIn,
    input `DataPath ALUOutIn,
    input `BrCodePath BrCodeIn,

    input logic IsDstRtIn,    
    input logic RfWrEnableIn,
    input logic IsStoreInsnIn,
    input logic IsLoadInsnIn,
    input logic PcWrEnableIn,

    input `DataPath RdDataBIn,
    input `ConstantPath ConstantIn,

    input `RegNumPath WrNumIn,
    input `RegNumPath RSIn,
    input `RegNumPath RTIn,
    input `RegNumPath RDIn,


    output `InsnAddrPath PCAddrOut,
    output `DataPath ALUOutOut,
    output `BrCodePath BrCodeOut,

    output logic IsDstRtOut,    
    output logic RfWrEnableOut,
    output logic IsStoreInsnOut,
    output logic IsLoadInsnOut,
    output logic PcWrEnableOut,

    output `DataPath RdDataBOut,
    output `ConstantPath ConstantOut,

    output `RegNumPath WrNumOut,
    output `RegNumPath RSOut,
    output `RegNumPath RTOut,
    output `RegNumPath RDOut,
)

    always_ff @(posedge clk or negedge rst) begin
        if(cHazard or !rst) begin
         PCAddrOut <= `InsnAddrPath'h0;
         ALUOutOut <= `DataPath'h0;
         BrCodeOut <= `BrCodePath'h0;
         IsDstRtOut <= `FALSE;
         RfWrEnableOut <= `FALSE;
         IsStoreInsnOut <= `FALSE;
         IsLoadInsnOut <= `FALSE;
         PcWrEnableOut <= `FALSE;

         RdDataBOut <= `DataPath'h0;
         ConstantOut <= `ConstantPath'h0;

         WrNumIn <= `RegNumPath'h0;
         RSOut <= `RegNumPath'h0;
         RTOut <= `RegNumPath'h0;
         RDOut <= `RegNumPath'h0;
        end
        else begin
         PCAddrOut <= PCAddrIn;
         ALUOutOut <= PCAddrIn;
         BrCodeOut <= BrCodeIn;
         IsDstRtOut <= IsDstRtIn;
         RfWrEnableOut <= RdWrEnableIn;
         IsStoreInsnOut <= IsStoreInsnIn;
         IsLoadInsnOut <= IsLoadInsnIn;
         PcWrEnableOut <= PcWrEnableIn;

         RdDataBOut <= RdDataBIn;
         ConstantOut <= ConstantIn;

         WrNumOut <= WrNumIn;
         RSOut <= RSIn;
         RTOut <= RTIn;
         RDOut <= RDIn;
        end
    end



endmodule