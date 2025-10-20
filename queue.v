module queue(
    input wire[7:0] back,
    input wire[2:0] pos_back,
    input wire extra_out,
    input wire clk,
    input wire rst,
    output reg[15:0] top_conc)

    reg [7:0] arr[0:4];
    integer i;

    always @(posedge clk) begin
        if (rst) begin
            
            for (i = 0; i < 5; i = i + 1)
                arr[i] = 8'b0;
            top_conc = 16'b0;
            ///cicle of reset
        end
        else begin
            if (pos_back < 5) begin  // проверка границ
                arr[pos_back] <= back;
            end


            case(extra_out)
                1'b0: begin
                    top_conc = {arr[0], 8'b0};
                    ///cicle of 1 cell shift
                    
                    for (i = 1; i < 5; i = i + 1)
                        arr[i - 1] <= arr[i];
                    arr[4] = 8'b0; 
                end;
                1'b1: begin
                    top_conc = {arr[0], arr[1]};
                    ///cicle of 2 cell shift
                    
                    for (i = 2; i < 5; i = i + 1)
                        arr[i - 2] <= arr[i];
                    arr[4] = 8'b0;
                    arr[3] = 8'b0;
                end;
            endcase;
        end

        
    end

endmodule