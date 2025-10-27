module ALU(
    input wire[15:0] operands,
    input wire [2:0] opcode,
    output reg [7:0] result,
    input wire clk,
    input wire rst,
    output reg sync

);

always @(posedge rst) begin
    result <= 0;
end

always @(posedge clk) begin
    case(opcode) 
        3'd2: begin
            result = operands[15:8] + operands[7:0];
        end
        default: begin
            result = 0;
        end
    endcase

    sync = 1;
end

always @(negedge clk) begin
    sync = 0;
end

endmodule