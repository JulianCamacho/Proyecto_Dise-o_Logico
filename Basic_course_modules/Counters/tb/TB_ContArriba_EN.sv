// Code your testbench here
// or browse Examples

`timescale 1ns/1ps

module TB_ContadorHaciaArriba_EN;
  
	reg clk, rst, enable;
  wire [3:0] cuenta;
  
  ContadorHaciaArriba_EN DUT (.clk(clk),
                           .rst(rst),
                           .enable(enable),
                           .cuenta(cuenta));
  
  initial begin
    $dumpfile("ContadorHaciaArriba_EN.vcd");
    $dumpvars(0, TB_ContadorHaciaArriba_EN);
  end
  
  initial begin
    clk=0;
  end
  
  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    rst=0;
    enable=0;
    #5
    rst=1;
    enable=1;
    #50
    enable=0;
    #50
    enable=1;
    #200 $finish;
  end
  
endmodule