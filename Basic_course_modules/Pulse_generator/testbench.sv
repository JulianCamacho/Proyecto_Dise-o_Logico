// Code your testbench here
// or browse Examples

`timescale 1ns/1ps

module TB_GeneradorPulsosMealy;
  
  reg clk, rst, btn; //Entradas de prueba => reg
  wire pulso;  //Salidas de prueba => wire
  
  GeneradorPulsosMealy FSM(
    .clk(clk), .rst(rst), .btn(btn), .pulso(pulso)
  );
  
  
  //Archivos
  initial begin
    $dumpfile("TB_GeneradorPulsosMealy.vcd");
    $dumpvars(0, TB_GeneradorPulsosMealy);
  end
    
  
  
  //=======  Reloj de 100 MHz  =======//
  initial begin
    clk = 0;
  end
  //Periodo de 10 unidades (5 en alto y 5 en bajo)
  //10*1ns = 10ns => 1/10ns = 100 MHz
  always begin
    #5 clk = ~clk;
  end
  
  
  //Inicializar
  initial begin
    //t = 0;
    btn = 0;
    rst = 0;
    
    //Esperar un flanco negativo del reloj
    @ (negedge clk)
    
    rst = 1;
    #20 btn = 1;
    #50 btn = 0;
    #50 $finish;
    
  end
  
endmodule