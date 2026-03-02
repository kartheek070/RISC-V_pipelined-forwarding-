module program_cntr(pc_next,pc,rst,clk);
input [31:0]pc_next;
input rst;
input clk;
output reg [31:0]pc;

always @(posedge clk) //since it is a single cycle processor
                     //it performs change in PC for every cycle
begin
if(rst==1'b0)
pc<=32'h00000000;

else
pc<= pc_next;
end
endmodule