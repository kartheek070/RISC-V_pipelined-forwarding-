module execute_cycle(
clk,rst,RegWriteE,ResultSrcE,MemWriteE,BranchE,ALUControlE,ALUSrcE,RD1E,RD2E,PCE,RdE,ImmextE,PCplus4E,
PCsrcE,PCTargetE,RegWriteM,MemWriteM,ResultSrcM,ALUResultM,WriteDataM,RdM,PCplus4M,ForwardA_E,ForwardB_E,ResultW
  );

input clk,rst,RegWriteE,ResultSrcE,MemWriteE,BranchE,ALUSrcE;
input [2:0]ALUControlE;
input [31:0]RD1E,RD2E,ImmextE,PCE,PCplus4E,ResultW;
input [4:0]RdE;
input [1:0]ForwardA_E,ForwardB_E; //hazard unit o/ps

output PCsrcE,RegWriteM,MemWriteM,ResultSrcM;
output [31:0]PCTargetE,ALUResultM,WriteDataM,PCplus4M;
output [4:0]RdM;

reg RegWriteE_r,MemWriteE_r,ResultSrcE_r;
reg [31:0]ALUResultE_r,RD2_r,PCplus4E_r,RD2E_r;
reg [4:0]RdE_r;

wire [31:0]SrcA,SrcB,SrcB_interm;
wire ZeroE;
wire [31:0]ALUResultE;

mux_3_by_1  srcA_mux(.a(RD1E),
        .b(ResultW),
        .s(ForwardA_E),
        .c(ALUResultM),
        .d(SrcA));
        
mux_3_by_1  srcB_mux(.a(RD2E),
        .b(ResultW),
        .s(ForwardB_E),
        .c(ALUResultM),
        .d(SrcB_interm));
        
mux srcB_mux_2x1(
                 .a(SrcB_interm),
                 .b(ImmextE),
                 .s(ALUSrcE),
                 .c(SrcB));
 ALU ALU_1(.A(SrcA),
           .B(SrcB),
           .Result(ALUResultE),
           .ALUControl(ALUControlE),
           .OverFlow(),
           .Carry(),
           .Zero(ZeroE),
           .Negative());
PC_adder PC_a(.a(PCE),
               .b(ImmextE),
               .c(PCTargetE));
always@(posedge clk or negedge rst)
begin
   if(!rst)
     begin
        RegWriteE_r<=1'b0;
        MemWriteE_r<=1'b0;
        ResultSrcE_r<=1'b0;
        ALUResultE_r<=32'h00000000;
        RD2E_r <= 32'h00000000; 
        PCplus4E_r<=32'h00000000;;
        RdE_r<=5'b00000;
      end

   else
      begin
        RegWriteE_r<=RegWriteE;
        MemWriteE_r<=MemWriteE;
        ResultSrcE_r<=ResultSrcE;
        ALUResultE_r<=ALUResultE;
         RD2E_r <= SrcB_interm; 
        PCplus4E_r<=PCplus4E;
        RdE_r<=RdE; 
      end
end

assign PCsrcE=(rst==1'b0)?1'b0: ZeroE & BranchE;
assign  RegWriteM=RegWriteE_r;
assign  MemWriteM=MemWriteE_r;
assign  ResultSrcM=ResultSrcE_r;
assign  ALUResultM=ALUResultE_r;
assign  WriteDataM=RD2E_r;
assign  PCplus4M=PCplus4E_r;
assign  RdM=RdE_r;
endmodule
