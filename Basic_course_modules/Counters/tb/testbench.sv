// Code your testbench here
// or browse Examples

`timescale 1ns/1ps

module TB_ContadorHaciaArriba_EN_UD_LC;
  
  reg clk, rst, enable, UD, LC;
  reg [3:0] entradaParalela;
  wire [3:0] cuenta;
  
  ContadorHaciaArriba_EN_UD_LC DUT (.clk(clk),
                           .rst(rst),
                           .enable(enable),
                                    .UD(UD),
                                    .LC(LC),
                 .entradaParalela(entradaParalela),
                           .cuenta(cuenta));
  
  initial begin
    $dumpfile("ContadorHaciaArriba_EN_UD_LC.vcd");
    $dumpvars(0, TB_ContadorHaciaArriba_EN_UD_LC);
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
    LC<= 0;
    entradaParalela <= 7;
    @(negedge clk)
    rst<=1;
	LC <= 1;
    entradaParalela <= 5;
   	#100
	LC <= 0;
    #100 $finish;
  end
  
endmodule