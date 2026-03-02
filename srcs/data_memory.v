module data_memory(A,WD,RD,WE,rst,clk);

input clk,rst,WE;
input [31:0]A,WD;
output [31:0]RD;

reg [31:0] mem [0:1023];
integer i;

always @(posedge clk)
begin
    if(!rst)
        for(i=0;i<1024;i=i+1)
            mem[i] <= 32'd0;
    else if(WE)
        mem[A[11:2]] <= WD;   // ? word addressing
end

assign RD = (!rst) ? 32'd0 : mem[A[11:2]];   // ? word addressing

initial begin
    mem[7]  = 32'h00000020;  // 28/4
    mem[10] = 32'h00000002;  // 40/4
end

endmodule
/*module data_memory(A,WD,RD,WE,rst,clk);
/*input [31:0]A,WD;
input clk,WE;

output [31:0]RD;
reg [31:0]data_mem[1023:0] ;//1024 32-bit data memories
//read functionality
assign RD=(WE==1'b0) ? data_mem[A]:32'h00000000;
//write functionality
always @(posedge clk)
begin
if(WE)
data_mem[A]<=WD;
end

initial begin //for test bench purpose ,we are giving 20hex value at data memory 28
 data_mem[28]=32'h00000020; 
end

    input clk,rst,WE;
    input [31:0]A,WD;
    output [31:0]RD;

    reg [31:0] mem [1023:0];

    always @ (posedge clk)
    begin
        if(WE)
            mem[A] <= WD;
    end

    assign RD = (~rst) ? 32'd0 : mem[A];

    initial begin
        mem[28] = 32'h00000020;
        mem[40] = 32'h00000002;
    end



endmodule*/