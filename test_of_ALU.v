module test_of_ALU#(
    parameter PUSH_CODE = 0,
    parameter POP_CODE  = 1,
    parameter ADD_CODE  = 2,
    parameter MULL_CODE = 3,
    parameter SUB_CODE  = 4,
    parameter DIV_CODE  = 5,
    parameter REM_CODE  = 6,

    parameter Q_PUSH    = 0,
    parameter Q_SLEEP   = 1,
    parameter Q_POP     = 3,
    parameter Q_GET_AND_PUSH    = 2
)();

    reg [7:0] push_val = 0;
    wire [7:0] count_val;
    wire [15:0] get_val;
    wire [2:0] pos;
    wire [1:0] queue_op;  
    reg [2:0] ALU_op = 0;
    reg clk = 0;
    reg rst = 0;
    reg [2:0] opcode = 0;
    wire ALU_sync;
    wire [7:0] queue_in;

    queue_with_controller test_q(
        .rst(rst),
        .clk(clk),
        .back(queue_in),
        .opcode(queue_op),
        .top_conc(get_val),
        .pos_back(pos)
    );


    ALU test_ALU(
        ///.clk(clk),
        .rst(rst),
        .sync(ALU_sync),
        .clk(clk),
        .operands(get_val),
        .opcode(opcode),
        .result(count_val),
        .queue_op(queue_op),
        .push_val(push_val)
    );

    assign queue_in = count_val | push_val;

    integer i;

    initial begin
        $dumpfile("dump_ALU.vcd");
        $dumpvars(0, test_of_ALU);
        #1
        rst = 0;
        #1
        rst = 1;
        #1
        rst = 0;
        #1
          // исправлено имя модуля
        push_val = 8'b1;
        
        clk = 0;
        rst = 0;
        push_val = 1;
        opcode = PUSH_CODE;

        #1
        clk = 1;

        #1
        clk = 0;
        rst = 0;
        push_val = 2;
        opcode = PUSH_CODE;

        #1
        clk = 1;

        #1
        clk = 0;
        rst = 0;
        push_val = 3;
        opcode = PUSH_CODE;

        #1
        clk = 1;

        #1
        clk = 0;
        rst = 0;
        push_val = 4;
        opcode = PUSH_CODE;

        #1
        clk = 1;

        #1
        clk = 0;
        rst = 0;
        opcode = ADD_CODE;

        #1
        clk = 1;

        #1
        clk = 0;
        rst = 0;
        opcode = MULL_CODE;

        #1
        clk = 1;

        #1
        clk = 0;
        rst = 0;
        opcode = POP_CODE;

        #1
        clk = 1;

        #1
        clk = 0;
        rst = 0;
        opcode = POP_CODE;

        #1
        clk = 1;

        #1
        clk = 0;
        #1
        clk = 1;


    end


endmodule