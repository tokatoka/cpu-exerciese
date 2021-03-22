`include "Types.v"

//forwarding unit
module Forward(
    input logic exmemRfWrEnableOut,
    input logic exmemIsLoadInsnOut,
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
    output `ForwardCodePath forwardD,
    output `ForwardCodePath forwardE,
    output `ForwardCodePath forwardF
);

    always_comb begin
        //exmem or memwb to ALU
        if(exmemRfWrEnableOut && exmemWrNumOut != 0 && exmemWrNumOut == idexRSOut && !exmemIsLoadInsnOut) begin
            forwardA = `EXMEM_FORWARD;
        end 
        else if(memwbRfWrEnableOut && memwbWrNumOut != 0 &&!(exmemRfWrEnableOut && exmemWrNumOut != 0 && exmemWrNumOut == idexRSOut && !exmemIsLoadInsnOut) && memwbWrNumOut == idexRSOut) begin
            forwardA = `MEMWB_FORWARD;
        end
        else begin
            forwardA = `NO_FORWARD;
        end

        if(exmemRfWrEnableOut && exmemWrNumOut != 0 && exmemWrNumOut == idexRTOut && !exmemIsLoadInsnOut) begin
            forwardB = `EXMEM_FORWARD;
        end 
        else if(memwbRfWrEnableOut && memwbWrNumOut != 0 && !(exmemRfWrEnableOut && exmemWrNumOut != 0 && exmemWrNumOut == idexRTOut && !exmemIsLoadInsnOut) && memwbWrNumOut == idexRTOut) begin
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

        //memwb to ifid
        if(memwbRfWrEnableOut && memwbWrNumOut != 0 && memwbWrNumOut == ifidRTOut) begin
            forwardD = `MEMWB_TOIDEXIN;
        end
        else begin
            forwardD = `NO_FORWARD;
        end

        if(exmemRfWrEnableOut && exmemWrNumOut != 0 && exmemWrNumOut == idexRSOut && !exmemIsLoadInsnOut) begin
            forwardE = `EXMEM_TOBR;
        end 
        else if(memwbRfWrEnableOut && memwbWrNumOut != 0 &&!(exmemRfWrEnableOut && exmemWrNumOut != 0 && exmemWrNumOut == idexRSOut && !exmemIsLoadInsnOut) && memwbWrNumOut == idexRSOut) begin
            forwardE = `MEMWB_TOBR;
        end
        else begin
            forwardE = `NO_FORWARD;
        end

        if(exmemRfWrEnableOut && exmemWrNumOut != 0 && exmemWrNumOut == idexRTOut && !exmemIsLoadInsnOut) begin
            forwardF = `EXMEM_TOBR;
        end 
        else if(memwbRfWrEnableOut && memwbWrNumOut != 0 && !(exmemRfWrEnableOut && exmemWrNumOut != 0 && exmemWrNumOut == idexRTOut && !exmemIsLoadInsnOut) && memwbWrNumOut == idexRTOut) begin
            forwardF = `MEMWB_TOBR;
        end
        else begin
            forwardF = `NO_FORWARD;
        end

        //exmem or memwb to branch
    end


endmodule