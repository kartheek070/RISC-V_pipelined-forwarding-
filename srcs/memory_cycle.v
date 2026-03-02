module memory_cycle(
clk,rst,RegWriteM,ResultSrcM,MemWriteM,ALUResultM,WriteDataM,RdM,PCplus4M,
RegWriteW,ResultSrcW,ReadDataW,RdW,PCplus4W,ALUResultW);

input clk,rst,RegWriteM,ResultSrcM,MemWriteM;
input [31:0] ALUResultM,WriteDataM,PCplus4M;
input [4:0]RdM;

output RegWriteW,ResultSrcW;
output [4:0]RdW;
output [31:0]ALUResultW,ReadDataW,PCplus4W;

wire [31:0]ReadDataM;

reg RegWriteM_r,ResultSrcM_r;
reg [4:0]RdM_r;
reg [31:0]ALUResultM_r,ReadDataM_r,PCplus4M_r;

data_memory DM(
               .A(ALUResultM),
               .WD(WriteDataM),
               .RD(ReadDataM),
               .WE(MemWriteM),
               .rst(rst),
               .clk(clk));

always@(posedge clk or negedge rst)
begin
     if(!rst)
       begin
         RegWriteM_r<=1'b0;
         ResultSrcM_r<=1'b0;
         RdM_r<=5'b0;
         ALUResultM_r<=32'h00000000;
         ReadDataM_r<=32'h00000000;
         PCplus4M_r<=32'h00000000;
       end
       else
         begin
         RegWriteM_r<=RegWriteM;
         ResultSrcM_r<=ResultSrcM;
         RdM_r<=RdM;
         ALUResultM_r<=ALUResultM;
         ReadDataM_r<=ReadDataM;
         PCplus4M_r<=PCplus4M;
         end

end

assign RegWriteW=RegWriteM_r;
assign ResultSrcW=ResultSrcM_r;
assign RdW=RdM_r;
assign ALUResultW=ALUResultM_r;
assign ReadDataW=ReadDataM_r;
assign PCplus4W=PCplus4M_r;

endmodule
