 module queue_controller(
    output reg[2:0] pos_back,
    input wire [1:0] opcode,
    input wire rst;
    input wire clk;
 )

 

 always @(posedge clk) begin 
    if (!rst) begin
        pos_back <= 0;
    end
    else begin
        case(opcode)
                2'b0: begin ///push
                    pos_back <= pos_back + 1
                end
                2'b10: begin ///get first pair and push res
                    pos_back <= pos_back - 1;
                end
                2'b11: begin // pop front
                    pos_back <= pos_back - 1;
                     
                end
            endcase  //
    end
 end


 endmodule;