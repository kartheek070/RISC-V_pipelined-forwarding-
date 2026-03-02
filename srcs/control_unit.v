`include "ALU_decoder.v"
`include "main_decoder.v"

module control_unit(OP,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,fn3,fn7,ALUControl);

input [6:0]OP,fn7;
input [2:0]fn3;
output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
output [1:0]ImmSrc;
output [2:0]ALUControl;

wire [1:0]ALUOP;

main_decoder main_decoder(.zero(1'b0),
                          .ResultSrc(ResultSrc),
                          .MemWrite(MemWrite),
                          .ALUSrc(ALUSrc),
                          .RegWrite(RegWrite),
                          .Branch(Branch),
                          .Op(OP),
                          .ImmSrc(ImmSrc),
                          .ALUOp(ALUOP)
                          );
ALU_decoder ALU_decoder(
                         .fn7(fn7),
                         .op(OP),
                         .ALUop(ALUOP),
                         .fn3(fn3),
                         .ALU_control(ALUControl));
endmodule