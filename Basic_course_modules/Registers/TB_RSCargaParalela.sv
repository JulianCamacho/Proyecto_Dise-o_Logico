// Code your testbench here
// or browse Examples

`timescale 1ns/1ps 

module TB_RegSerieConCargaParalela;
  
  reg clk, rst, D, LS;
  reg [3:0] datos;
  wire out;
  
  RegSerieConCargaParalela DUT (.clk(clk), .rst(rst), .LS(LS), .D(D), 									.DP(datos), .out(out));
  
  initial begin
    $dumpfile ("RegSerieConCargaParalela.vcd");
    $dumpvars(0, TB_RegSerieConCargaParalela);
  end
  
  
  //RELOJ
  always begin
  	#5 clk = ~clk;
  end
  
  initial begin
  	clk = 0;
    rst = 0;
    datos = 5;
	D = 0;
    LS = 0;
    #11 rst = 1;
    #10 datos = 8;
    #10 datos = 11;
    //A partir de aquí se van corriendo los bits que tenía
    #10 LS = 1;
    #50 $finish;
  end
  
endmodule