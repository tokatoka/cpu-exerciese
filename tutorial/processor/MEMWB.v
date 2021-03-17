`include "Types.v"

module MEMWB(
    input logic clk,
    input logic rst,

    input `DataPath RdDataMemIn,
    input `DataPath AluOutIn,

    input `RegNumPath WrNumIn,
    input logic IsLoadInsnIn,
    input logic RfWrEnableIn,

    output `DataPath RdDataMemOut,
    output `DataPath AluOutOut,

    output `RegNumPath WrNumOut,
    output logic IsLoadInsnOut,
    output logic RfWrEnableOut
);

    always_ff @(posedge clk or negedge rst) begin
        if(!rst) begin
            RdDataMemOut <= `DATA_WIDTH'h0;
            AluOutOut <= `DATA_WIDTH'h0;
            WrNumOut <= `REG_NUM_WIDTH'h0;

            IsLoadInsnOut <= `FALSE;
            RfWrEnableOut <= `FALSE;
        end
        else begin
            RdDataMemOut <= RdDataMemIn;
            AluOutOut <= AluOutIn;
            WrNumOut <= WrNumIn;

            IsLoadInsnOut <= IsLoadInsnIn;
            RfWrEnableOut <= RfWrEnableIn;
        end
    end

endmodule