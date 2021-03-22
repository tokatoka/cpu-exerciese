`include "Types.v"

module Hazard(
    input logic clk,
    input logic rst,

    input `RegNumPath ifidRSOut,
    input `RegNumPath ifidRTOut,
    input `RegNumPath idexRDOut,
    input `RegNumPath idexRTOut,
    input `RegNumPath exmemRTOut,

    input `OpPath dcOp,
    input logic idexRfWrEnableOut,
    input logic exmemRfWrEnableOut,
    input logic idexIsLoadInsnOut,
    input logic exmemIsLoadInsnOut,
    input logic brTaken,
    output logic cHazard,
    output logic dHazard
);


    always_comb begin
        if((rst && idexIsLoadInsnOut && ((idexRTOut == ifidRSOut) || (idexRTOut == ifidRTOut))) ||
            (rst && ((idexRDOut == ifidRSOut) || (idexRDOut == ifidRTOut)) && idexRfWrEnableOut && !idexIsLoadInsnOut && (dcOp == `OP_CODE_BEQ || dcOp == `OP_CODE_BNE)) ||
            (rst && ((idexRTOut == ifidRSOut) || (idexRTOut == ifidRTOut)) && idexRfWrEnableOut && idexIsLoadInsnOut && (dcOp == `OP_CODE_BEQ || dcOp == `OP_CODE_BNE)) ||
            (rst && ((exmemRTOut == ifidRSOut) || (exmemRTOut == ifidRTOut)) && exmemRfWrEnableOut && exmemIsLoadInsnOut && (dcOp == `OP_CODE_BEQ || dcOp == `OP_CODE_BNE)))
        begin
            dHazard = `TRUE;
        end else begin
            dHazard = `FALSE;
        end

        if(rst && brTaken && !dHazard) begin
            cHazard = `TRUE;
        end else begin
            cHazard = `FALSE;
        end

    end

endmodule