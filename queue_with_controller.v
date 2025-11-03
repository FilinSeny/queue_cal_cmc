module queue_with_controller(
    input wire [7:0] back,
    input wire [1:0] opcode,

    input wire clk,
    input wire rst,

    output wire  [15:0] top_conc, 
    output reg[7:0] tail,
    output wire is_empty,
    output reg is_err

    
);
    reg[2:0] pos_back = 0;

    
    reg [7:0] calced_back = 0;
    assign is_empty = pos_back == 0;

    
    reg [7:0] arr [0:4];
    integer i;

    
    wire[39:0] debug_reg;

    
    assign debug_reg = {arr[0], arr[1], arr[2], arr[3], arr[4]};


    ///всегда на алу уходят две первых ячейки для того чтоб можно было сразу делать предподсчет
    

    assign top_conc = {(pos_back == 3'b001) ? 8'hFF : arr[1], arr[0]};
    
    always @* begin
        tail = arr[pos_back - 1];
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Сброс
            for (i = 0; i < 5; i = i + 1)
                arr[i] <= 8'b0;  
            pos_back <= 0; 
            is_err <= 0;
            calced_back <= back;
        end
        
        else begin
            calced_back <= back;


            case(opcode)
                2'b0: begin ///push
                    if (pos_back == 5) begin
                        is_err <= 1;
                    end
                    else begin
                        arr[pos_back] <= back;
                        pos_back <= pos_back + 1;
                    end
                end
                2'b10: begin ///get first pair and push res
                    
                    
                    // Сдвиг на 2 ячейки
                    if (pos_back < 2) begin
                        is_err <= 1;
                    end
                    else begin
                        for (i = 2; i < 5; i = i + 1)
                            arr[i - 2] = arr[i];
                        pos_back <= pos_back - 1;
                        arr[pos_back - 2] <= back;
                        if (pos_back == 2) begin
                            arr[pos_back - 1] = 8'hFF;
                        end
                        arr[pos_back] <= 0;
                    end
                    
                end
                2'b11: begin // pop front
                    if (pos_back == 0) begin
                        is_err <= 1;
                    end
                    else begin
                        for (i = 1; i < 5; i = i + 1)
                            arr[i - 1] <= arr[i];
                        pos_back <= pos_back - 1;
                    end
                end
            endcase  
        end
    end


endmodule;