module ALU
#(
    parameter PUSH_CODE = 4'b0000,
    parameter POP_CODE  = 4'b0001,
    parameter ADD_CODE  = 4'b0010,
    parameter MULL_CODE = 4'b0011,
    parameter SUB_CODE  = 4'b0100,
    parameter DIV_CODE  = 4'b0101,
    parameter REM_CODE  = 4'b0110,

    parameter Q_PUSH    = 2'b0,
    parameter Q_SLEEP   = 2'b01,
    parameter Q_POP     = 2'b11,
    parameter Q_GET_AND_PUSH    = 2'b10

)
(
    input wire[15:0] operands,
    input wire [3:0] opcode, ///first bit indicates error
    input wire [7:0] push_val,
    
    input wire clk,
    input wire rst,

    output reg [7:0] result,
    output reg [1:0] queue_op,
    output reg has_calc_err

);

/*always @(posedge rst) begin
    result <= 0;
end*/

always @* begin
    if (rst) begin 
        has_calc_err = 0;
        result = 0;
        queue_op = 1;
    end
    else begin
		  has_calc_err = 1'b0;
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
                if (operands[15:8] == 8'b0) begin
                    has_calc_err = 1;
                end 
                    result = operands[7:0] / operands[15:8];
                    queue_op = Q_GET_AND_PUSH;
                
				end
            REM_CODE: begin
                if (operands[15:8] == 8'b0) begin
                    has_calc_err = 1; 
                end 
                    result = operands[7:0] % operands[15:8];
                    queue_op = Q_GET_AND_PUSH;
            end

            default: begin
                if (!opcode[3]) begin
                    has_calc_err = 1;
                end

                result = 0;
                queue_op = Q_SLEEP;
            end
        endcase
    end;

    
end



endmodule