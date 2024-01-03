//Pruebas Ejercicio 6

`timescale 1ns/1ps

module sol6b_tb;
  
  reg dato0, dato1, dato2, seleccion;
  wire salida;
  
  sol6b DUT (.A(seleccion), 
           .B(dato0), 
           .C(dato1), 
           .D(dato2), 
           .H(salida)
  );
  
  initial begin
    $dumpfile("sol6b_tb.vcd");
    $dumpvars(0,sol6b_tb);
  end
  
  initial begin
    //Combinación 0000 ==> H = 1
    seleccion = 0;
    dato0 = 0;
    dato1 = 0;
    dato2 = 0;
    #10
    //Combinación 0001 ==> H = 0
    dato2 = 1;
    #10
    //Combinación 0010 ==> H = 1
    dato1 = 1;
    dato2 = 0;
    #10
    //Combinación 1010 ==> H = 1
    seleccion = 1;
	#10
    //Combinación 1110 ==> H = 0
    dato0 = 1;
    #10
    
    $finish;
    
  end
endmodule