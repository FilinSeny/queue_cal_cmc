module ALU
#(
    parameter PUSH_CODE = 0,
    parameter POP_CODE  = 1,
    parameter ADD_CODE  = 2,
    parameter MULL_CODE = 3,
    parameter SUB_CODE  = 4,
    parameter DIV_CODE  = 5,
    parameter REM_CODE  = 6,

    parameter Q_PUSH    = 2'b0,
    parameter Q_SLEEP   = 2'b01,
    parameter Q_POP     = 2'b11,
    parameter Q_GET_AND_PUSH    = 2'b10

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

/*always @(posedge rst) begin
    result <= 0;
end*/

always @* begin
    if (1) begin
        case(opcode) 
            PUSH_CODE: begin
                result = push_val;
                queue_op = Q_PUSH;
            end
            POP_CODE: begin
                queue_op = Q_POP;
                result = 8'b0; 
            end
            ADD_CODE: begin 
                result = operands[15:8] + operands[7:0];
                queue_op = Q_GET_AND_PUSH;
            end
            MULL_CODE: begin
                result = operands[15:8] * operands[7:0];
                queue_op = Q_GET_AND_PUSH;
            end
            SUB_CODE: begin
                result = operands[7:0] - operands[15:8];
                queue_op = Q_GET_AND_PUSH;
            end
            DIV_CODE: begin
                result = operands[7:0] / operands[15:8];
                queue_op = Q_GET_AND_PUSH;
            end
            REM_CODE: begin
                result = operands[7:0] % operands[15:0];
                queue_op = Q_GET_AND_PUSH;
            end

            default: begin
                result = 0;
                queue_op = Q_SLEEP;
            end
        endcase
    end;

    
end



endmodule