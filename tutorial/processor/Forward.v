`include "Types.v"

//forwarding unit
module Forward(



    input logic exmemRfWrEnableOut,
    input `RegNumPath exmemRDOut,
    input `RegNumPath idexRSOut,
    input `RegNumPath idexRTOut,

    input logic memwbRfWrEnableOut,
    input `RegNumPath memwbRDOut,
    input `RegNumPath memwbRSOut,
    input `RegNumPath memwbRTOut,

    output `ForwardCodePath forwardA,
    output `ForwardCodePath forwardB
);

    always_comb begin
        if(exmemRfWrEnableOut && exmemRDOut != 0 && exmemRDOut == idexRSOut) begin
            forwardA = `MEMWB_FORWARD;
        end 
        else if(memwbRfWrEnableOut && !(exmemRfWrEnableOut && exmemRDOut != 0 && exmemRDOut != idexRSOut) && memwbRDOut == idexRSOut) begin
            forwardA = `EXMEM_FORWARD;
        end
        else begin
            forwardA = `NO_FORWARD;
        end

        if(exmemRfWrEnableOut && exmemRDOut != 0 && exmemRDOut == idexRTOut) begin
            forwardB = `MEMWB_FORWARD;
        end 
        else if(memwbRfWrEnableOut && !(exmemRfWrEnableOut && exmemRDOut != 0 && exmemRDOut != idexRTOut) && memwbRDOut == idexRTOut) begin
            forwardB = `EXMEM_FORWARD;
        end
        else begin
            forwardB = `NO_FORWARD;
        end
    end


endmodule