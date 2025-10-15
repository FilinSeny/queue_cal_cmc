///мультиплесор с 2мя 8битными входами 
module commutator(
    input wire[7:0] push;
    input wire[7:0] one_shift;
    input wire[7:0] two_shift;
    input wire [1:0]s;

    output reg[7:0] y; 
);

always begin
    case (s)
        2`b00 : y = push;
        2`b01 : y = one_shift;
        2`b10 : y = two_shift;
    endcase
end

endmodule