`include "fetch_cycle.v"
`include "decode_cycle.v"
`include "execute_cycle.v"
`include "memory_cycle.v"
`include "write_back_cycle.v"  
module pipeline_top(rst,clk);
input clk,rst;

wire PCsrcE,RegWriteW,RegWriteE,ResultSrcE,ALUSrcE,MemWriteE,BranchE,PCSrcE,RegWriteM;
wire MemWriteM,ResultSrcM,ResultSrcW;
wire [31:0] PCTargetE,InstrD,PCD,PCplus4D,ResultW,RD1E,RD2E,ImmextE,PCE,PCplus4E;
wire [31:0] ALUResultM,WriteDataM,PCplus4M,ALUResultW,ReadDataW,PCplus4W;
wire [4:0]RdW,Rs1E,Rs2E,RdE,RdM;
wire [2:0]ALUControlE;
wire [1:0]ForwardA_E,ForwardB_E;

fetch_cycle FC(.clk(clk),
               .rst(rst),
               .PCtargetE(PCTargetE),
               .PCsrcE(PCsrcE),
               .InstrD(InstrD),
               .PCD(PCD),
               .PCplus4D(PCplus4D));
               
decode_cycle DC(.clk(clk),
                .rst(rst),
                .RegWriteW(RegWriteW),
                .InstrD(InstrD),
                .PCD(PCD),
                .PCplus4D(PCplus4D),
                .RdW(RdW),
                .ResultW(ResultW),
                .RegWriteE(RegWriteE),
                .ResultSrcE(ResultSrcE),
                .MemWriteE(MemWriteE),
                .BranchE(BranchE),
                .ALUControlE(ALUControlE),
                .ALUSrcE(ALUSrcE),
                .RD1E(RD1E),
                .RD2E(RD2E),
                .PCE(PCE),
                .ImmextE(ImmextE),
                .PCplus4E(PCplus4E),
                .Rs1E(Rs1E),
                .Rs2E(Rs2E),
                .RdE(RdE));
                
execute_cycle EC(.clk(clk),
                 .rst(rst),
                 .RegWriteE(RegWriteE),
                 .ResultSrcE(ResultSrcE),
                 .MemWriteE(MemWriteE),
                 .BranchE(BranchE),
                 .ALUControlE(ALUControlE),
                 .ALUSrcE(ALUSrcE),
                 .RD1E(RD1E),
                 .RD2E(RD2E),
                 .PCE(PCE),
                 .RdE(RdE),
                 .ImmextE(ImmextE),
                 .PCplus4E(PCplus4E),
                 .PCsrcE(PCsrcE),
                 .PCTargetE(PCTargetE),
                 .RegWriteM(RegWriteM),
                 .MemWriteM(MemWriteM),
                 .ResultSrcM(ResultSrcM),
                 .ALUResultM(ALUResultM),
                 .WriteDataM(WriteDataM),
                 .RdM(RdM),
                 .PCplus4M(PCplus4M),
                 .ForwardA_E(ForwardA_E),
                 .ForwardB_E(ForwardB_E),
                 .ResultW(ResultW));
                   
memory_cycle MC(.clk(clk),
                .rst(rst),
                .RegWriteM(RegWriteM),
                .ResultSrcM(ResultSrcM),
                .MemWriteM(MemWriteM),
                .ALUResultM(ALUResultM),
                .WriteDataM(WriteDataM),
                .RdM(RdM),
                .PCplus4M(PCplus4M),
                .RegWriteW(RegWriteW),
                .ResultSrcW(ResultSrcW),
                .ReadDataW(ReadDataW),
                .RdW(RdW),
                .PCplus4W(PCplus4W),
                .ALUResultW(ALUResultW));
                
write_back_cycle WC(
                    .clk(clk),
                    .rst(rst),
                    .ResultSrcW(ResultSrcW),
                    .ReadDataW(ReadDataW),
                    .ALUResultW(ALUResultW),
                    //.PCplus4W(PCplus4W),
                    .ResultW(ResultW));
 
hazard_unit HU(.rst(rst),
               .Rs1E(Rs1E),
               .Rs2E(Rs2E),
               .ForwardA_E(ForwardA_E),
               .ForwardB_E(ForwardB_E),
               .RdM(RdM),
               .RdW(RdW),
               .RegWriteM(RegWriteM),
               .RegWriteW(RegWriteW));


endmodule
