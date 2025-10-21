module test_of_queue_controller;  // убраны пустые скобки

    reg [7:0] push_val = 0;
    wire [15:0] get_val;
    wire [2:0] pos;
    reg [1:0] queue_op = 0;  // изменено на reg для тестбенча
    reg clk = 0;
    reg rst = 0;

    queue test_q(.rst(rst),
                .clk(clk),
                .back(push_val),
                .pos_back(pos),
                .opcode(queue_op),
                .top_conc(get_val));

    queue_controller test_q_control(
        .rst(rst),
        .clk(clk),
        .opcode(queue_op),
        .pos_back(pos)
    );

    integer i;

    initial begin
        $dumpfile("dump_queue.vcd");
        $dumpvars(2, test_of_queue_controller);  // исправлено имя модуля
        push_val = 8'b1;
        
        clk = 0;
        rst = 0;
        queue_op = 0;  // инициализация добавлена

        for (i = 0; i < 4; i = i + 1) begin
            #1 
            clk = 1;
            #1
            clk = 0;
            push_val = push_val + 1;
           
            
        end

        #1
        queue_op = 2'b11;
        clk = 1;
        #1
        clk = 0;
        queue_op = 2'b10;
        push_val = 200;
        #1
        clk = 1;
        #1
        clk = 0;


    end

    /*always begin
        #1 clk = !clk;
        if (clk) begin
            if (pos < 4) begin
            pos = pos + 1;
            end 
            push_val = push_val + 1;  // исправлено на push_val
        end
        
    end  // убрана точка с запятой*/

endmodule