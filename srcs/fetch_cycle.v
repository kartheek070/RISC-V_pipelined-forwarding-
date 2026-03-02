module fetch_cycle(clk,rst,PCtargetE,PCsrcE,InstrD,PCD,PCplus4D );
input clk,rst,PCsrcE;
input [31:0]PCtargetE;

output [31:0] InstrD,PCD,PCplus4D;

wire [31:0]PC_F,PCF,PCplus4F,InstrF;

reg [31:0]PCF_reg,PCplus4F_reg,InstrF_reg;

mux mux(.a(PCplus4F),
         .b(PCtargetE),
         .s(PCsrcE),
         .c(PC_F));

program_cntr PC(.pc_next(PC_F),
                .pc(PCF),
                .rst(rst),
                .clk(clk));

ins_mem IM(.A(PCF),
           .rst(rst),
           .RD(InstrF));

PC_adder PCA(.a(PCF),
             .b(32'd4),
             .c(PCplus4F));

always@(posedge clk or negedge rst)
begin
if(!rst)
begin
PCF_reg<=32'd0;
PCplus4F_reg<=32'd0;
InstrF_reg<=32'd0;
end
else
begin
PCF_reg<=PCF;
PCplus4F_reg<=PCplus4F;
InstrF_reg<=InstrF;
end
end

assign PCD=(rst==0) ? 32'd0:PCF_reg;
assign PCplus4D=(rst==0) ? 32'd0:PCplus4F_reg;
assign InstrD=(rst==0) ? 32'd0:InstrF_reg;


endmodule
