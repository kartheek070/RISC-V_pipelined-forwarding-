`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.02.2026 11:51:57
// Design Name: 
// Module Name: mux_3_by_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_3_by_1(
    input  [31:0] a, b, c,
    input  [1:0]  s,
    output [31:0] d
);

assign d = (s == 2'b00) ? a :
           (s == 2'b01) ? b :
           (s == 2'b10) ? c :
           32'd0;

endmodule