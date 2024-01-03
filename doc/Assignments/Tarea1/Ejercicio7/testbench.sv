//Pruebas MUX

`timescale 1ns/1ps

module mux_tb;
  
  reg dato0, dato1, seleccion;
  wire salida;
  
  mux DUT (.S(seleccion), 
           .D0(dato0), 
           .D1(dato1), 
           .Q(salida)
  );
  
  initial begin
    $dumpfile("mux_tb.vcd");
    $dumpvars(0,mux_tb);
  end
  
  initial begin
    dato0 = 0;
    dato1 = 1;
    seleccion = 0;
    #10 //Retardo de 10 unidades de tiempo
    dato0 = 1;
    #10
    dato1 = 0;
    #5
    seleccion = 1;
    #2
    dato0 = 1;
    #10
    dato1 = 0;
    #5
    seleccion = 0;
    #10
    
    $finish;
    
  end
endmodule