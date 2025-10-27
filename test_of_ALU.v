module test_of_ALU();
    reg [7:0] push_val = 0;
    wire [7:0] count_val;
    wire [15:0] get_val;
    wire [2:0] pos;
    reg [1:0] queue_op = 0;  
    reg [2:0] ALU_op = 0;
    reg clk = 0;
    reg rst = 0;
    wire ALU_sync;
    wire [7:0] queue_in;

    queue_with_controller test_q(.rst(rst),
                .clk(ALU_sync),
                .back(queue_in),
                .opcode(queue_op),
                .top_conc(get_val),
                .pos_back(pos)
                );


    ALU test_ALU(
        .clk(clk),
        .rst(rst),
        .operands(get_val),
        .opcode(ALU_op),
        .result(count_val),
        .sync(ALU_sync)
    );

    assign queue_in = count_val | push_val;

    integer i;

    initial begin
        $dumpfile("dump_ALU.vcd");
        $dumpvars(0, test_of_ALU);  // исправлено имя модуля
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

        #3
        queue_op = 2'b11;
        clk = 1;
        push_val = 0;
        #1
        clk = 0;
        ALU_op = 2;
        queue_op = 2'b10;
        #1
        clk = 1;
        #1
        clk = 0;


    end


endmodule