module sell (
    input wire[7:0] data_in;
    input wire clk;
    input wire enable;
    input wire rst;

    output reg[7:0] data_out;
);

always @(posedge res) begin
    data_out = 8`b0;
end

always @(posedge clk) begin
    data_out = data_in;
end
    
endmodule