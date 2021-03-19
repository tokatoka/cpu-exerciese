`include "Types.v"

module EXMEM(
    input logic clk,
    input logic rst,
    input logic cHazard,

    input `InsnAddrPath PCAddrIn,
    input `DataPath ALUOutIn,
    input `BrCodePath BrCodeIn,

    input logic RfWrEnableIn,
    input logic IsStoreInsnIn,
    input logic IsLoadInsnIn,
    input logic PcWrEnableIn,

    input `DataPath RdDataAIn,
    input `DataPath RdDataBIn,
    input `ConstantPath ConstantIn,

    input `RegNumPath WrNumIn,
    input `RegNumPath RSIn,
    input `RegNumPath RTIn,
    input `RegNumPath RDIn,


    output `InsnAddrPath PCAddrOut,
    output `DataPath ALUOutOut,
    output `BrCodePath BrCodeOut,

    output logic RfWrEnableOut,
    output logic IsStoreInsnOut,
    output logic IsLoadInsnOut,
    output logic PcWrEnableOut,

    output `DataPath RdDataAOut,
    output `DataPath RdDataBOut,
    output `ConstantPath ConstantOut,

    output `RegNumPath WrNumOut,
    output `RegNumPath RSOut,
    output `RegNumPath RTOut,
    output `RegNumPath RDOut
);

    always_ff @(posedge clk or negedge rst) begin
        if(cHazard || !rst) begin
            PCAddrOut <= `INSN_ADDR_WIDTH'h0;
            ALUOutOut <= `DATA_WIDTH'h0;
            BrCodeOut <= `BR_CODE_WIDTH'h0;
            RfWrEnableOut <= `FALSE;
            IsStoreInsnOut <= `FALSE;
            IsLoadInsnOut <= `FALSE;
            PcWrEnableOut <= `FALSE;

            RdDataAOut <= `DATA_WIDTH'h0;
            RdDataBOut <= `DATA_WIDTH'h0;
            ConstantOut <= `CONSTANT_WIDTH'h0;

            WrNumOut <= `REG_NUM_WIDTH'h0;
            RSOut <= `REG_NUM_WIDTH'h0;
            RTOut <= `REG_NUM_WIDTH'h0;
            RDOut <= `REG_NUM_WIDTH'h0;
        end
        else begin
            PCAddrOut <= PCAddrIn;
            ALUOutOut <= ALUOutIn;
            BrCodeOut <= BrCodeIn;
            RfWrEnableOut <= RfWrEnableIn;
            IsStoreInsnOut <= IsStoreInsnIn;
            IsLoadInsnOut <= IsLoadInsnIn;
            PcWrEnableOut <= PcWrEnableIn;

            RdDataAOut <= RdDataAIn;
            RdDataBOut <= RdDataBIn;
            ConstantOut <= ConstantIn;

            WrNumOut <= WrNumIn;
            RSOut <= RSIn;
            RTOut <= RTIn;
            RDOut <= RDIn;
        end
    end



endmodule