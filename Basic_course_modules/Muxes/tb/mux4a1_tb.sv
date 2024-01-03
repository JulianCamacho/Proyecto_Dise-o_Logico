//Testbench para Mux 4 a 1

`timescale 1ns/1ps

module mux4a1_tb;
  
  reg dato0, dato1, dato2, dato3, seleccion1, seleccion2;
  wire salida;

  mux4a1 DUT (.S0(seleccion1),
              .S1(seleccion2),
              //Si se hace con el arreglo
              //.S({seleccion2, seleccion1})  el orden importa, ojo!
              .D0(dato0), 
              .D1(dato1),
              .D2(dato2),
              .D3(dato3),
              .Q(salida)
  );
  
  
  initial begin
    $dumpfile("mux4a1_tb.vcd");
    $dumpvars(0,mux4a1_tb);
  end
  
  //Para inicializar variables y valores
  initial begin
    dato0 = 0;
    dato1 = 0;
    dato2 = 0;
    seleccion1 = 0;
    #5
    dato3 = 0;
    #5
    seleccion2 = 0;
    #10
    dato0=1;
    #5
    dato0=0;
    #5
    dato0=1;
    #5
    dato0=0;
    #5
    dato0=1;
    #5
    dato0=0;
    #5
    dato0=1;
    #5
    seleccion2=1;
    #5
    dato0=1;
    #5
    dato0=0;
    #5
    dato1=1;
    #5
    dato1=0;
    #5
    dato2=1;
    #5
    dato2=0;
    #5
    
    $finish;
    
  end
endmodule