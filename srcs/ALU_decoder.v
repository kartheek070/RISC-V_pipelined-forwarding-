//module ALU_decoder(
//input [6:0]fn7,op,
//input [1:0] ALUop,
//input [2:0] fn3,
//output [2:0]ALU_control
// );
// wire [1:0]concatenation;
//// assign concatenation={op,fn7};
// //truth table for ALU decoder
// assign ALU_control=(ALUop==2'b00)? 3'b000:
//                     (ALUop==2'b01)? 3'b001:
//                     ((ALUop==2'b10) & (fn3==3'b111))? 3'b010:
//                     ((ALUop==2'b10) & (fn3==3'b110))? 3'b011:
//                     ((ALUop==2'b10) & (fn3==3'b010))? 3'b101:
//                     ((ALUop==2'b10) & (fn3==3'b000)&({op[5],fn7[5]}==2'b11))? 3'b010:
//                     ((ALUop==2'b10) & (fn3==3'b000)&({op[5],fn7[5]}!=2'b11))? 3'b000:3'b000;
//endmodule
module ALU_decoder(
input [6:0]fn7,op,
input [1:0] ALUop,
input [2:0] fn3,
output reg [2:0]ALU_control
 );

always @(*)
begin
    case(ALUop)

        2'b00: ALU_control = 3'b000; // ADD (load/store)

        2'b01: ALU_control = 3'b001; // SUB (branch)

        2'b10: begin
            case(fn3)

                3'b000: begin
                    if(op == 7'b0110011 && fn7 == 7'b0100000)
                        ALU_control = 3'b001; // SUB
                    else
                        ALU_control = 3'b000; // ADD
                end

                3'b111: ALU_control = 3'b010; // AND
                3'b110: ALU_control = 3'b011; // OR
                3'b010: ALU_control = 3'b101; // SLT

                default: ALU_control = 3'b000;
            endcase
        end

        default: ALU_control = 3'b000;

    endcase
end

endmodule