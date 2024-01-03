`timescale 1ns/1ps

module mux4a1bus_tb;
  
  reg [3:0] dato0, dato1, dato2, dato3; 
  reg [1:0] seleccion;
  //Cuidado con el tamaño de bits de la salida
  wire [3:0] salida;

  mux4a1bus DUT (.S(seleccion),
              .D0(dato0), 
              .D1(dato1),
              .D2(dato2),
              .D3(dato3),
              .Q(salida)
  );
  
  initial begin
    $dumpfile("mux4a1bus_tb.vcd");
    $dumpvars(0,mux4a1bus_tb);
  end
  
  //Para inicializar variables y valores
  initial begin
    //Se pueden poner más que 0 o 1 porque son de 4 bits
    dato0 = 0;
    dato1 = 1;
    dato2 = 5;
    seleccion = 4;
    #5
    dato3 = 6;
    #5
    seleccion = 2;
    #10
    dato0=1;
    #5
    dato0=8;
    #5
    dato0=1;
    #5
    dato0=9;
    #5
    dato0=13;
    #5
    dato0=10;
    #5
    dato0=1;
    #5
    seleccion=26;
    #5
    dato0=15;
    #5
    dato0=12;
    #5
    dato1=1;
    #5
    dato1=7;
    #5
    dato2=0;
    #5
    dato2=3;
    #5
    $finish;
    
  end
endmodule
