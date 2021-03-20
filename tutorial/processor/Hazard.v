`include "Types.v"

module Hazard(
    input logic clk,
    input logic rst,

    input `RegNumPath ifidRSOut,
    input `RegNumPath ifidRTOut,
    input `RegNumPath idexRTOut,
    input logic idexIsLoadInsnIn,
    input logic brTaken,
    output logic cHazard,
    output logic dHazard
);


    always_ff @(posedge clk or negedge rst) begin
        if(rst && brTaken) begin
            cHazard <= `TRUE;
        end else begin
            cHazard <= `FALSE;
        end

        if(rst && idexIsLoadInsnIn && ((idexRTOut == ifidRSOut) || (idexRTOut == ifidRTOut))) begin
            dHazard <= `TRUE;
        end else begin
            dHazard <= `FALSE;
        end
    end

endmodule