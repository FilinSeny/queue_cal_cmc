module queue(
    input wire [7:0] back,
    input wire [2:0] pos_back,
    input wire [1:0] opcode,
    input wire clk,
    input wire rst,
    output reg [15:0] top_conc
);

    reg [7:0] arr [0:4];
    integer i;

    initial begin
        ///$dumpfile("queue.vcd");
        ///$dumpvars(2, queue); 
        for (i = 0; i < 5; i = i + 1)
                arr[i] <= 8'b0;  // исправлено на <=
            top_conc <= 16'b0;   // исправлено на <=
        
    end

    wire[39:0] debug_reg;

    
    assign debug_reg = {arr[0], arr[1], arr[2], arr[3], arr[4]};
    

    always @(posedge clk) begin
        if (rst) begin
            // Сброс - используем блокирующие или неблокирующие, но последовательно
            for (i = 0; i < 5; i = i + 1)
                arr[i] <= 8'b0;  // исправлено на <=
            top_conc <= 16'b0;   // исправлено на <=
        end
        else begin
            /*if (pos_back < 3'b101) begin
                arr[3] <= 8'b1111;
            end else begin
                arr[2] <= 8'b1110;
            end;*/


            case(opcode)
                2'b0: begin ///push
                    arr[pos_back] <= back;
                    top_conc <= 16'h0;
                end
                2'b1: begin ///get_first and push
                    top_conc <= {arr[0], 8'h0};  // исправлено на <=
                    
                    // Сдвиг на 1 ячейку
                    for (i = 1; i < 5; i = i + 1)
                        arr[i - 1] <= arr[i];
                    arr[pos_back] <= back;  // исправлено на <=
                end
                2'b10: begin ///get first pair and push res
                    top_conc <= {arr[0], arr[1]};  // исправлено на <=
                    
                    // Сдвиг на 2 ячейки
                    for (i = 2; i < 5; i = i + 1)
                        arr[i - 2] <= arr[i];
                    arr[pos_back] <= back;
                end
                2'b11: begin // pop front
                    top_conc <= {arr[0], 8'h0};
                    for (i = 1; i < 5; i = i + 1)
                        arr[i - 1] <= arr[i];
                     
                end
            endcase  // убрана точка с запятой
        end
    end

endmodule