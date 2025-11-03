module calculator(
    input wire clk,
    input wire rst,

    input wire[7:0] in,
    input wire[2:0] op,
    input wire apply,

    output wire[7:0] tail,
    output wire empty,
    output wire valid
);

    wire invalid;
    wire [7:0] count_val;
    wire [15:0] get_val;
    wire [1:0] queue_op;  
    wire [2:0] pos_back;

    wire empty_err; ///ошибка внутри очереди
    wire alu_err; /// ошибка вида деления на 0


    wire [3:0] opcode;
    assign invalid = alu_err | empty_err;
    assign valid = !invalid;
    assign opcode = {invalid | !apply, op};
    

   
    queue_with_controller queue(
        .rst(rst),
        .clk(clk),

        .back(count_val),
        .opcode(queue_op),

        .top_conc(get_val),
        .is_err(empty_err),
        .is_empty(empty),
        .tail(tail)
    );


    ALU alu(
        
        .rst(rst),
        .clk(clk),

        .operands(get_val),
        .opcode(opcode),
        .push_val(in),
        

        .result(count_val),
        .queue_op(queue_op),
        .has_calc_err(alu_err)

    );

endmodule