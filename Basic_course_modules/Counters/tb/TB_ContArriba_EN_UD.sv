// Code your testbench here
// or browse Examples

`timescale 1ns/1ps

module TB_ContadorHaciaArriba_EN_UD;
  
	reg clk, rst, enable, UD;
  wire [3:0] cuenta;
  
  ContadorHaciaArriba_EN_UD DUT (.clk(clk),
                           .rst(rst),
                           .enable(enable),
                                 .UD(UD),
                           .cuenta(cuenta));
  
  initial begin
    $dumpfile("ContadorHaciaArriba_EN_UD.vcd");
    $dumpvars(0, TB_ContadorHaciaArriba_EN_UD);
  end
  
  initial begin
    clk=0;
  end
  
  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    rst<=0;
    enable<=1;
    UD <= 0;
    @(negedge clk)
    rst<=1;
	UD <= 1;
   	#100
	UD <= 0;
    #100 $finish;
  end
  
endmodule