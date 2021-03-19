`include "Types.v"

module Hazard(
    input `RegNumPath ifidRSOut,
    input `RegNumPath ifidRTOut,
    input logic idexIsLoadInsnIn,
    input logic brTaken,
    output logic cHazard,
    output logic dHazard,
);


    always_ff @(posedge clk or nedgede rst) begin
        if(rst && brTaken) begin
            cHazard <= `TRUE;
        else begin
            cHazard <= `FALSE;
        end

        if(rst && idexIsLoadInsnIn && ((idexRTOut == ifidRSOut) || (idexRTOut == ifidRTOut))) begin
            dHazard <= `TRUE;
        else begin
            dHazard <= `FALSE;
        end
    end

endmodule