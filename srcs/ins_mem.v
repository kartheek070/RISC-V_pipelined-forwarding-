module ins_mem(A,rst,RD);
input [31:0]A;
input rst;
output  [31:0]RD;
//creation of memory
reg [31:0]mem[1023:0]; //1024 memories of 32bit sized
//the data inside A(A is address here) is read to RD
assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]];//memory is word(8bits)aligned and each instr is 32bits
                                             //so we jump by (32/8)4 bytes for each instruction 

//always @(posedge clk)
//begin
//if(!rst)
// RD<=32'd0;
// else
// RD<=mem[A[31:2]];
//end

/*initial begin //automates memory reading automatically from file
    $readmemh("memfile.h",mem); //readmemh means read memory in hexadecimal 
                                //reads input from memfile.h into mem
end*/

initial begin //for each memory location we manually specify values
//mem[0]=32'hFFC4A303; //for load format instructions examples
//mem[1]=32'h00832383; //for load format instructions examples
//mem[0]=32'h0064A423;  //for s format instructions examples
//mem[1]=32'h00B62423;//for s format
//mem[0]=32'h0062E233; // for R format
mem[0]=32'h00500293;
mem[1]=32'h00300313;
mem[2]=32'h006283B3;
mem[3]=32'h00002403;
mem[4]=32'h00100493;
mem[5]=32'h00940533;
end
endmodule