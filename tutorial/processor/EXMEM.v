include "Types.h"

module EXMEM(
    input logic clk,
    input logic rst,
    input logic cHazard,

    input `InsnAddrPath PCAddrIn,
    input `DataPath ALUOutIn,
    input `BrCodePath BrCodeIn,

    input logic IsDstRtIn,    
    input logic RdWrEnableIn,
    input logic IsStoreInsnIn,
    input logic IsLoadInsnIn,
    input logic PcWrEnableIn,

    input `DataPath RdDataBIn,
    input `ConstantPath ConstantIn,

    input `RegNumPath RSIn,
    input `RegNumPath RTIn,
    input `RegNumPath RDIn,


    output `InsnAddrPath PCAddrOut,
    output `DataPath ALUOutOut,
    output `BrCodePath BrCodeOut,

    output logic IsDstRtOut,    
    output logic RdWrEnableOut,
    output logic IsStoreInsnOut,
    output logic IsLoadInsnOut,
    output logic PcWrEnableOut,

    output `DataPath RdDataBOut,
    output `ConstantPath ConstantOut,

    output `RegNumPath RSOut,
    output `RegNumPath RTOut,
    output `RegNumPath RDOut,
)

    always_ff @(posedge clk or negedge rst) begin
        if(cHazard) begin
         PCAddrOut <= `InsnAddrPath'h0;
         ALUOutOut <= `DataPath'h0;
         BrCodeOut <= `BrCodePath'h0;
         IsDstRtOut <= `FALSE;
         RdWrEnableOut <= `FALSE;
         IsStoreInsnOut <= `FALSE;
         IsLoadInsnOut <= `FALSE;
         PcWrEnableOut <= `FALSE;

         RdDataBOut <= `DataPath'h0;
         ConstantOut <= `ConstantPath'h0;
         RSOut <= `RegNumPath'h0;
         RTOut <= `RegNumPath'h0;
         RDOut <= `RegNumPath'h0;
        end
        else begin
         PCAddrOut <= PCAddrIn;
         ALUOutOut <= PCAddrIn;
         BrCodeOut <= BrCodeIn;
         IsDstRtOut <= IsDstRtIn;
         RdWrEnableOut <= RdWrEnableIn;
         IsStoreInsnOut <= IsStoreInsnIn;
         IsLoadInsnOut <= IsLoadInsnIn;
         PcWrEnableOut <= PcWrEnableIn;

         RdDataBOut <= RdDataBIn;
         ConstantOut <= ConstantIn;
         RSOut <= RSIn;
         RTOut <= RTIn;
         RDOut <= RDIn;
        end
    end



endmodule