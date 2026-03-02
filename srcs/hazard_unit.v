module hazard_unit(rst,Rs1E,Rs2E,ForwardA_E,ForwardB_E,RdM,RdW,RegWriteM,RegWriteW);
input rst,RegWriteM,RegWriteW;
input [4:0]Rs1E,Rs2E,RdM,RdW;
output [1:0]ForwardA_E,ForwardB_E;

assign ForwardA_E=(rst==1'b0)?2'b00:
                   ((RegWriteM==1'b1) &(RdM!=5'h00)&(RdM==Rs1E))?2'b10:
                   ((RegWriteW==1'b1) &(RdW!=5'h00)&(RdW==Rs1E))?2'b01:2'b00;

assign ForwardB_E=(rst==1'b0)?2'b00:
                   ((RegWriteM==1'b1) &(RdM!=5'h00)&(RdM==Rs2E))?2'b10:
                   ((RegWriteW==1'b1) &(RdW!=5'h00)&(RdW==Rs2E))?2'b01:2'b00;                   
endmodule
