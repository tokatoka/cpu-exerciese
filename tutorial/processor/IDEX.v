`include "Types.v"

module IDEX(
    input logic clk,
    input logic rst,
    input logic cHazard,

    input `InsnAddrPath PCAddrIn,

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
    output `RegNumPath RDOut
);

    always_ff @(posedge clk or negedge rst) begin
        if(cHazard || !rst) begin
            PCAddrOut <= `INSN_ADDR_WIDTH'h0;

            IsDstRtOut <= `FALSE;
            PcWrEnableOut <= `FALSE;
            IsLoadInsnOut <= `FALSE;
            IsStoreInsnOut <= `FALSE;
            IsSrcA_RtOut <= `FALSE;
            RfWrEnableOut <= `FALSE;
            IsALUInConstantOut <= `FALSE;

            BrCodeOut <= `BR_CODE_WIDTH'h0;
            AluCodeOut <= `ALU_CODE_WIDTH'h0;
            ShamtOut <= `SHAMT_WIDTH'h0;
            FunctOut <= `FUNCT_WIDTH'h0;
            RdDataAOut <= `DATA_WIDTH'h0;
            RdDataBOut <= `DATA_WIDTH'h0;
            ConstantOut <= `CONSTANT_WIDTH'h0;
            RSOut <= `REG_NUM_WIDTH'h0;
            RTOut <= `REG_NUM_WIDTH'h0;
            RDOut <= `REG_NUM_WIDTH'h0;
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