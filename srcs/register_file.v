module register_file(rst,A1,A2,A3,wd3,rd1,we3,rd2,clk);
input clk,rst,we3;
input [31:0]wd3;
input [4:0]A1,A2,A3;
output [31:0]rd1,rd2;
//register file creation
reg [31:0]registers[31:0]; //32 registers of size 32bit
//reading functionality
assign rd1=(rst==1'b0)? 32'h00000000:registers[A1];
assign rd2=(rst==1'b0)? 32'h00000000:registers[A2];
//write functionality
always @(posedge clk)
begin
if(we3 & (A3 != 5'h00)) //if logic added with (A3 != 5'h00)
registers[A3]<=wd3; //A3 register gets wd3 data which is given as input
end
integer i;

initial begin
    for(i = 0; i < 32; i = i + 1)
        registers[i] = 32'h00000000;
end
//initial begin  //for testing purpose only in testbench for different formats
////registers[11]=32'h00000028;//s format
////registers[12]=32'h00000030;
////registers[6]=32'h00000040;
////registers[9]=32'h00000020; //at register 9 we are giving number 20base16
////registers[5]=32'h00000006;// R format example
////registers[6]=32'h0000000A; //R format example
//registers[0]=32'h00000000;
//end
endmodule