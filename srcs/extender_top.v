//module extender_top(In,Immext,ImmSrc);
//input [1:0]ImmSrc; //1 if store word and 0 if load word
//input [31:0]In;  
//output [31:0]Immext;

// assign Immext =  (ImmSrc == 2'b00) ? {{20{In[31]}},In[31:20]} :  
//                     (ImmSrc == 2'b01) ? {{20{In[31]}},In[31:25],In[11:7]} : 32'h00000000;
// endmodule
module extender_top(
    input [31:0] Instr,
    input [1:0] ImmSrc,
    output reg [31:0] Immext
);

always @(*) begin



    case (ImmSrc)

        2'b00:  // I-type (ADDI, LW)
            Immext = {{20{Instr[31]}}, Instr[31:20]};

        2'b01:  // S-type
            Immext = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};

        2'b10:  // B-type
            Immext = {{19{Instr[31]}},
                      Instr[31],
                      Instr[7],
                      Instr[30:25],
                      Instr[11:8],
                      1'b0};

        default:
            Immext = 32'b0;
    endcase
end

endmodule