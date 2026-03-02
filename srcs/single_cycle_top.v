`include "program_cntr.v"
`include "ins_mem.v"
`include "register_file.v"
`include "extender_top.v"
`include "ALU.v"
`include "control_unit.v"
`include "data_memory.v"
`include "PC_adder.v"
`include "mux.v"

module single_cycle_top(clk,rst);
input clk,rst;

wire [31:0]pc_top,Rd_instr,RD1_top,imm_ext_top,ALUResult,readdata,PC_plus_four,RD2_top,srcB,R_type_result;
wire RegWrite,memwrite,ALUSrc,ResultSrc;
wire [1:0]ImmSrc;
wire [2:0]ALUControl_top;

//step 1
program_cntr program_cntr(      //program counter is named again as program counter on single top module
              .pc_next(PC_plus_four),  //pc_next is linked with
              .pc(pc_top),    //pc is linker with pc_top
              .rst(rst),
              .clk(clk));
ins_mem ins_mem(
                .A(pc_top),  //A is linked with pc_top
                .rst(rst),  
                .RD(Rd_instr));  
//step 2
register_file register_file(
                             .rst(rst),
                             .A1(Rd_instr[19:15]), //15 t0 19 bits of rd instr is linked with A1
                             .A2(Rd_instr[24:20]),// 20-24 if rd_instr is loaded to ressgister file
                             .A3(Rd_instr[11:7]),
                             .wd3(R_type_result), //wd3=read daata for s-type,wd3=R_type_result for Rtype
                             .rd1(RD1_top),
                             .we3(RegWrite),
                             .rd2(RD2_top),
                             .clk(clk));    
//step 3 
extender_top extender(.in(Rd_instr),
                  .imm_ext(imm_ext_top),
                  .immsrc(ImmSrc[0])
                   );
//lec 9 for R format first mux
mux mux_register_to_ALU(.a(RD2_top) , .b(imm_ext_top),
                          .s(ALUSrc), .c(srcB)
                          );
           
//step 4
ALU ALU( .A(RD1_top),
         .B(srcB), //b= imm_ext_top for I,s type, for r type b=srcB
         .ALUControl(ALUControl_top),
         .Result(ALUResult),
         .Carry(),
         .Negative(),
         .Zero(),
         .OverFlow());
//ALUcontrol from control Unit
control_unit control_unit(
                          .OP(Rd_instr[6:0]),  //RD insructions 7 bits are taken for OPcode,
                          .RegWrite(RegWrite),
                          .ImmSrc(ImmSrc),
                          .ALUSrc(ALUSrc),
                          .MemWrite(memwrite),
                          .ResultSrc(ResultSrc),
                          .Branch(),
                          .fn3(Rd_instr[14:12]),
                          .fn7(Rd_instr[31:25]),//31:25 for R type,
                          .ALUControl(ALUControl_top));
                          
//step5

data_memory data_memory(.rst(rst),
                        .A(ALUResult),
                        .WD(RD2_top),
                        .RD(readdata),
                        .WE(memwrite),
                        .clk(clk));
                        
 //second mux of Rtype lec 9
 mux mux_datamemory_to_registerfile(.a(ALUResult) , .b(readdata),
                          .s(ResultSrc), .c(R_type_result)
                          );
           
 
 PC_adder PC_adder(
                   .a(pc_top),
                   .b(32'd4),   //4 is added to the pc for next instructions ,coz we process 32 bits(8x4)
                   .c(PC_plus_four)); //32bit decimal 4

endmodule
