`timescale 1ns / 1ps
module pipeline_tb;
reg clk=0,rst;


always #50 clk=~clk;

initial 
begin
rst<=1'b0;
#200;
rst<=1'b1;
#1000;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
end
pipeline_top dut(.clk(clk),.rst(rst));
endmodule
