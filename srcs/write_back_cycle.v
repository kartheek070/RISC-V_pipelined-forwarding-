module write_back_cycle(
clk,rst,ResultSrcW,ReadDataW,ALUResultW,
//PCplus4W,
ResultW);

input clk,rst,ResultSrcW;
input [31:0]ReadDataW,ALUResultW;//PCplus4W;

output [31:0]ResultW;

//mux_3_by_1 mux(.a(ALUResultW), //in video taken 2X1 mux but as per the diagram i took 3X1 mux
//                .b(ReadDataW), //so it may affect result
//                .c(PCplus4W),
//                .d(ResultW),
//                .s(ResultSrcW));
assign ResultW = (ResultSrcW == 1'b0) ? ALUResultW :  //remove PCplus4
                                        ReadDataW;

endmodule
