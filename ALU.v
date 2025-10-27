module ALU
#(
    parameter PUSH_CODE = 0,
    parameter POP_CODE  = 1,
    parameter ADD_CODE  = 2,
    parameter MULL_CODE = 3,
    parameter SUB_CODE  = 4,
    parameter DIV_CODE  = 5,
    parameter REM_CODE  = 6,

    parameter Q_PUSH    = 0,
    parameter Q_SLEEP   = 1,
    parameter Q_POP     = 3,
    parameter Q_GET_AND_PUSH    = 2

)
(
    input wire[15:0] operands,
    input wire [2:0] opcode,
    input wire [7:0] push_val,
    output reg [7:0] result,
    output reg [1:0] queue_op,

    input wire clk,
    input wire rst,
    output reg sync

);

always @(posedge rst) begin
    result <= 0;
end

always @(posedge clk) begin
    case(opcode) 
        PUSH_CODE: begin
            result = push_val;
            queue_op = Q_PUSH;
        end
        POP_CODE: begin
            queue_op = Q_POP;
        end
        ADD_CODE: begin //сложение
            result = operands[15:8] + operands[7:0];
            queue_op = Q_GET_AND_PUSH;
        end
        MULL_CODE: begin
            result = operands[15:8] * operands[7:0];
            queue_op = Q_GET_AND_PUSH;
        end

        default: begin
            result = 0;
            queue = Q_SLEEP;
        end
    endcase

    sync = 1;
end

always @(negedge clk) begin
    sync = 0;
end

endmodule