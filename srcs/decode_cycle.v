module decode_cycle(clk,rst,RegWriteW,InstrD,PCD,PCplus4D,RdW,ResultW,RegWriteE,ResultSrcE,
                    MemWriteE,BranchE,ALUControlE,ALUSrcE,RD1E,RD2E,PCE,ImmextE,PCplus4E,
                    Rs1E,Rs2E,RdE);
                    
   input clk,rst,RegWriteW;
   input [4:0]RdW;
   input [31:0] InstrD,PCD,PCplus4D,ResultW;
   
   output RegWriteE,ResultSrcE,ALUSrcE,MemWriteE,BranchE;
   output [2:0]ALUControlE;
   output [31:0] RD1E,RD2E,ImmextE;
   output [4:0]Rs1E,Rs2E,RdE;
   output [31:0]PCE,PCplus4E;
   
   wire RegWriteD,ResultSrcD,ALUSrcD,MemWriteD,BranchD;
   wire [1:0]ImmSrcD;
   wire [2:0]ALUControlD;
   wire [31:0] RD1D,RD2D,ImmextD;
   
   
   
   reg RegWriteD_r,ResultSrcD_r,ALUSrcD_r,MemWriteD_r,BranchD_r;
   reg [2:0]ALUControlD_r;
   reg [31:0] RD1D_r,RD2D_r,ImmextD_r;
   reg [4:0]Rs1D_r,Rs2D_r,RDD_r;
   reg [31:0]PCD_r,PCplus4D_r;
   
   control_unit CU(.OP(InstrD[6:0]),
                  .RegWrite(RegWriteD),
                  .ImmSrc(ImmSrcD),
                  .ALUSrc(ALUSrcD),
                  .MemWrite(MemWriteD),
                  .ResultSrc(ResultSrcD),
                  .Branch(BranchD),
                  .fn3(InstrD[14:12]),
                  .fn7(InstrD[31:25]),
                  .ALUControl(ALUControlD));
                  
   register_file RF(.rst(rst),
                  .A1(InstrD[19:15]),
                  .A2(InstrD[24:20]),
                  .A3(RdW),
                  .wd3(ResultW),
                  .rd1(RD1D),
                  .we3(RegWriteW),
                  .rd2(RD2D),
                  .clk(clk));
                  
   extender_top EXT(.Instr(InstrD), //31:7
                .Immext(ImmextD),
                .ImmSrc(ImmSrcD));
 
 always @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        RegWriteD_r <= 1'b0;
        ALUSrcD_r <= 1'b0;
        MemWriteD_r <= 1'b0;
        ResultSrcD_r <= 1'b0;
        BranchD_r <= 1'b0;
        ALUControlD_r <= 3'b000;
        RD1D_r <= 32'h0;
        RD2D_r <= 32'h0;
        ImmextD_r <= 32'h0;
        RDD_r <= 5'h0;
        PCD_r <= 32'h0;
        PCplus4D_r <= 32'h0;
        Rs1D_r <= 5'h0;
        Rs2D_r <= 5'h0;
    end
    else
    begin
        RegWriteD_r <= RegWriteD;
        ALUSrcD_r <= ALUSrcD;
        MemWriteD_r <= MemWriteD;
        ResultSrcD_r <= ResultSrcD;
        BranchD_r <= BranchD;
        ALUControlD_r <= ALUControlD;
        RD1D_r <= RD1D;
        RD2D_r <= RD2D;
        ImmextD_r <= ImmextD;
        RDD_r <= InstrD[11:7];
        PCD_r <= PCD;
        PCplus4D_r <= PCplus4D;
        Rs1D_r <= InstrD[19:15];
        Rs2D_r <= InstrD[24:20];
    end
end             
  assign RegWriteE=RegWriteD_r;
  assign ResultSrcE=ResultSrcD_r;
  assign ALUSrcE=ALUSrcD_r;
  assign MemWriteE=MemWriteD_r;
  assign BranchE=BranchD_r;
   assign ALUControlE=ALUControlD_r;
   assign RD1E=RD1D_r;
   assign RD2E=RD2D_r;
   assign ImmextE=ImmextD_r;
   assign Rs1E=Rs1D_r;
   assign Rs2E=Rs2D_r;
   assign RdE=RDD_r;
   assign PCE=PCD_r;
   assign PCplus4E=PCplus4D_r;
endmodule
