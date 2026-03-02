//module single_cycle_top_tb();
//reg clk=1'b1,rst;
//single_cycle_top single_cycle_top(
//                                  .clk(clk),
//                                  .rst(rst));
//initial begin
//    $dumpfile("single_cycle.vcd"); //values stored in that file
//    $dumpvars(0);
//    end
//always
//begin 
//clk = ~clk; //stting clock
//#50;
//end

//initial 
//begin
//rst=1'b0; //initially no results
//#100;

//rst=1'b1; //after 150ms we get results
//#300;
//$finish;
//end
//endmodule