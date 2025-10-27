module queue_with_controller(
    (
    input wire [7:0] back,
    input wire [2:0] pos_back,
    input wire [1:0] opcode,

    input wire clk,
    input wire rst,

    output wire  [15:0] top_conc,
    output reg[2:0] pos_back
    
);

    initial begin
        pos_back = 0;
    end

    
    reg [7:0] arr [0:4];
    integer i;

    initial begin
        ///$dumpfile("queue.vcd");
        ///$dumpvars(2, queue); 
        for (i = 0; i < 5; i = i + 1)
                arr[i] <= 8'b0;  
            ///top_conc <= 16'b0;   
        
    end

    wire[39:0] debug_reg;

    
    assign debug_reg = {arr[0], arr[1], arr[2], arr[3], arr[4]};


    ///всегда на алу уходят две первых ячейки для того чтоб можно было сразу делать предподсчет
    
    assign top_conc = {arr[0], arr[1]};
    
    

    always @(posedge clk) begin
        if (rst) begin
            // Сброс
            for (i = 0; i < 5; i = i + 1)
                arr[i] <= 8'b0;  
            pos_back <= 0; 
        end
        else begin
            


            case(opcode)
                2'b0: begin ///push
                    arr[pos_back] = back;
                    pos_back = pos_back + 1;
                end
                2'b1: begin ///get_first and push
                    
                    // Сдвиг на 1 ячейку
                    for (i = 1; i < 5; i = i + 1)
                        arr[i - 1] = arr[i];
                    arr[pos_back] = back;  // исправлено на <=
                end
                2'b10: begin ///get first pair and push res
                    
                    
                    // Сдвиг на 2 ячейки
                    for (i = 2; i < 5; i = i + 1)
                        arr[i - 2] = arr[i];
                    pos_back = pos_back - 1;
                    arr[pos_back - 1] = back;
                    
                end
                2'b11: begin // pop front
                   
                    for (i = 1; i < 5; i = i + 1)
                        arr[i - 1] = arr[i];
                    pos_back = pos_back - 1;
                end
            endcase  
        end
    end
)

endmodule;