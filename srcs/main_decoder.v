module main_decoder(
  input zero,
  input[6:0]Op,
  output ResultSrc,MemWrite,ALUSrc,RegWrite,
  output [1:0] ImmSrc,ALUOp,
  output Branch
 );
// wire branch;  
 //truth table for main decoder
//assign Regwrite=((op==7'b0000011)|(op==7'b0110011))?1'b1:1'b0;
//assign ALUsrc=((op==7'b0000011)|(op==7'b0100011))?1'b1:1'b0;
//assign mem_write=(op==7'b0100011)?1'b1:1'b0;
//assign result_src=(op==7'b0000011)?1'b1:1'b0;
//assign branch=(op==7'b1100011)?1'b1:1'b0;
//assign imm_src=(op==7'b0100011)?2'b01:(op==7'b1100011)?2'b10:2'b00;
//assign ALUop=(op==7'b0110011)?2'b10:(op==7'b1100011)?2'b01:2'b00;
//assign Pcsrc=zero&branch;

//new table for pipeline
assign RegWrite = (Op == 7'b0000011 || Op == 7'b0110011 || Op == 7'b0010011 ) ? 1'b1 :
                                                              1'b0 ;
    assign ImmSrc = (Op == 7'b0100011) ? 2'b01 : 
                    (Op == 7'b1100011) ? 2'b10 :    
                                         2'b00 ;
    assign ALUSrc = (Op == 7'b0000011 || Op == 7'b0100011 || Op == 7'b0010011) ? 1'b1 :
                                                            1'b0 ;
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 :
                                           1'b0 ;
    assign ResultSrc = (Op == 7'b0000011) ? 1'b1 :
                                            1'b0 ;
    assign Branch = (Op == 7'b1100011) ? 1'b1 :
                                         1'b0 ;
    assign ALUOp = (Op == 7'b0110011) ? 2'b10 :
                   (Op == 7'b1100011) ? 2'b01 :
                                        2'b00 ;
   
endmodule
