module calculator_test #(
    parameter PUSH_CODE = 0,
    parameter POP_CODE  = 1,
    parameter ADD_CODE  = 2,
    parameter MULL_CODE = 3,
    parameter SUB_CODE  = 4,
    parameter DIV_CODE  = 5,
    parameter REM_CODE  = 6

)();

    reg clk;
    reg rst;

    reg[7:0] in;
    reg[2:0] op;
    reg apply;

    wire [7:0] tail;
    wire empty;
    wire valid;


    calculator calc(
        .clk(clk),
        .rst(rst),

        .in(in),
        .op(op),
        .apply(apply),

        .tail(tail),
        .empty(empty),
        .valid(valid)
    );

    initial begin
        $dumpfile("dump_calc.vcd");
        $dumpvars(0, calculator_test);
        ///тест на корректную работу
        clk = 0;
        rst = 1;
        
        #1
        clk = 1;
        rst = 0;

        #1 clk = 0;
        in = 1;
        op = PUSH_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 2;
        op = PUSH_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 3;
        op = PUSH_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = POP_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = ADD_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 4;
        op = PUSH_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = MULL_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 10;
        op = PUSH_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = SUB_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 3;
        op = PUSH_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = DIV_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 17;
        op = PUSH_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = ADD_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 3;
        op = PUSH_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = REM_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        apply = 0;
        
        #1 clk = 1;   
        ///тест на деление на 0
        #3 
        clk = 0;
        rst = 1;
        
        #1
        clk = 1;
        rst = 0;

        #1 clk = 0;
        in = 1;
        op = PUSH_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 0;
        op = PUSH_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 2;
        op = PUSH_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = MULL_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = DIV_CODE;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = PUSH_CODE;
        in = 10;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        apply = 0;
        
        #1 clk = 1;        

        ///тест на недобор в очереди
        #3 
        clk = 0;
        rst = 1;
        
        #1
        clk = 1;
        rst = 0;

        #1 clk = 0;
        in = 1;
        op = 0;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 1;
        op = 0;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 3;
        op = 0;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = 2;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = 2;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        op = 2;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        apply = 0;
        
        #1 clk = 1;


        ///тест на перебор в очереди
        #3 
        clk = 0;
        rst = 1;
        
        #1
        clk = 1;
        rst = 0;

        #1 clk = 0;
        in = 1;
        op = 0;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 2;
        op = 0;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 3;
        op = 0;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 4;
        op = 0;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 5;
        op = 0;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 6;
        op = 0;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 7;
        op = 0;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        apply = 0;
        
        #1 clk = 1;
        


        ///проверка на работу apply

        #3 
        clk = 0;
        rst = 1;
        
        #1
        clk = 1;
        rst = 0;

        #1 clk = 0;
        in = 1;
        op = 0;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        in = 2;
        op = 0;
        apply = 0;
        #1 clk = 1;

        #1 clk = 0;
        in = 3;
        op = 0;
        apply = 1;
        #1 clk = 1;

        #1 clk = 0;
        apply = 0;
        
        #1 clk = 1;
    end

endmodule