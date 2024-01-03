// Code your testbench here
// or browse Examples

`timescale 1ns/1ps

module TB_ContadorHaciaArriba;
  
	reg clk, rst;
  wire [3:0] cuenta;
  
  ContadorHaciaArriba DUT (.clk(clk),
                           .rst(rst),
                           .cuenta(cuenta));
  
  initial begin
    $dumpfile("ContadorHaciaArriba.vcd");
    $dumpvars(0, TB_ContadorHaciaArriba);
  end
  
  initial begin
    clk=0;
    
  end
  
  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    rst=0;
    #5
    rst=1;
    #200 $finish;
  end
  
endmodule