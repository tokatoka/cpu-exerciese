`include "Types.v"

module RegisterFile(
    input logic clk,
    input logic rst,

    output `DataPath rdDataA,
    output `DataPath rdDataB,

    input `RegNumPath rdNumA,
    input `RegNumPath rdNumB,

    input `DataPath wrData,
    input `RegNumPath wrNum,

    input logic wrEnable
);
    `DataPath storage[ 0 : `REG_FILE_SIZE - 1 ];

    always_ff @(posedge clk or negedge rst) begin
        if (wrEnable) begin
            storage[wrNum] <= wrData;
        end
        if (!rst) begin
            storage[0] <= `REG_FILE_SIZE'h0;
            storage[1] <= `REG_FILE_SIZE'h0;
            storage[2] <= `REG_FILE_SIZE'h0;
            storage[3] <= `REG_FILE_SIZE'h0;
            storage[4] <= `REG_FILE_SIZE'h0;
            storage[5] <= `REG_FILE_SIZE'h0;
            storage[6] <= `REG_FILE_SIZE'h0;
            storage[7] <= `REG_FILE_SIZE'h0;
            storage[8] <= `REG_FILE_SIZE'h0;
            storage[9] <= `REG_FILE_SIZE'h0;
            storage[10] <= `REG_FILE_SIZE'h0;
            storage[11] <= `REG_FILE_SIZE'h0;
            storage[12] <= `REG_FILE_SIZE'h0;
            storage[13] <= `REG_FILE_SIZE'h0;
            storage[14] <= `REG_FILE_SIZE'h0;
            storage[15] <= `REG_FILE_SIZE'h0;
            storage[16] <= `REG_FILE_SIZE'h0;
            storage[17] <= `REG_FILE_SIZE'h0;
            storage[18] <= `REG_FILE_SIZE'h0;
            storage[19] <= `REG_FILE_SIZE'h0;
            storage[20] <= `REG_FILE_SIZE'h0;
            storage[21] <= `REG_FILE_SIZE'h0;
            storage[22] <= `REG_FILE_SIZE'h0;
            storage[23] <= `REG_FILE_SIZE'h0;
            storage[24] <= `REG_FILE_SIZE'h0;
            storage[25] <= `REG_FILE_SIZE'h0;
            storage[26] <= `REG_FILE_SIZE'h0;
            storage[27] <= `REG_FILE_SIZE'h0;
            storage[28] <= `REG_FILE_SIZE'h0;
            storage[29] <= `REG_FILE_SIZE'h0;
            storage[30] <= `REG_FILE_SIZE'h0;
            storage[31] <= `REG_FILE_SIZE'h0;
        end
        storage[0] = 32'b0;
    end

    always_comb begin
        rdDataA = storage[rdNumA];
        rdDataB = storage[rdNumB];
    end
endmodule