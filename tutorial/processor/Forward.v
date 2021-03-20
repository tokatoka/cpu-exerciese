`include "Types.v"

//forwarding unit
module Forward(
    input logic exmemRfWrEnableOut,
    input `RegNumPath exmemWrNumOut,
    input `RegNumPath idexRSOut,
    input `RegNumPath idexRTOut,
    input `RegNumPath ifidRSOut,
    input `RegNumPath ifidRTOut,


    input logic memwbRfWrEnableOut,
    input `RegNumPath memwbWrNumOut,

    output `ForwardCodePath forwardA,
    output `ForwardCodePath forwardB,
    output `ForwardCodePath forwardC,
    output `ForwardCodePath forwardD
);

    always_comb begin
        if(exmemRfWrEnableOut && exmemWrNumOut != 0 && exmemWrNumOut == idexRSOut) begin
            forwardA = `EXMEM_FORWARD;
        end 
        else if(memwbRfWrEnableOut && memwbWrNumOut != 0 &&!(exmemRfWrEnableOut && exmemWrNumOut != 0 && exmemWrNumOut == idexRSOut) && memwbWrNumOut == idexRSOut) begin
            forwardA = `MEMWB_FORWARD;
        end
        else begin
            forwardA = `NO_FORWARD;
        end

        if(exmemRfWrEnableOut && exmemWrNumOut != 0 && exmemWrNumOut == idexRTOut) begin
            forwardB = `EXMEM_FORWARD;
        end 
        else if(memwbRfWrEnableOut && memwbWrNumOut != 0 && !(exmemRfWrEnableOut && exmemWrNumOut != 0 && exmemWrNumOut == idexRTOut) && memwbWrNumOut == idexRTOut) begin
            forwardB = `MEMWB_FORWARD;
        end
        else begin
            forwardB = `NO_FORWARD;
        end

        if(memwbRfWrEnableOut && memwbWrNumOut != 0 && memwbWrNumOut == ifidRSOut) begin
            forwardC = `MEMWB_TOIDEXIN;
        end
        else begin
            forwardC = `NO_FORWARD;
        end

        if(memwbRfWrEnableOut && memwbWrNumOut != 0 && memwbWrNumOut == ifidRTOut) begin
            forwardD = `MEMWB_TOIDEXIN;
        end
        else begin
            forwardD = `NO_FORWARD;
        end
    end


endmodule