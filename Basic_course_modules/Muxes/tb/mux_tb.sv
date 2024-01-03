//Pruebas MUX

`timescale 1ns/1ps

module mux_tb;
  
  //reg para las entradas de un bloque, son de un bit
  reg dato0, dato1, seleccion;
  
  //wire para las salidas de un bloque, son de un bit
  wire salida;
  
  //Asignación implícita (importa el orden)
  //mux DUT (dato0, dato1, seleccion, salida);
  
  //Llamada del bloque principal por probar
  //Asignación explícita (no importa el orden)
  mux DUT (.S(seleccion), 
           .D0(dato0), 
           .D1(dato1), 
           .Q(salida)
  );
  
  //Códigos que se ejecutan una sola vez
  //Todos los initials se ejecutan en paralelo
  initial begin
    //Archivo donde se van a guardar los datos
    $dumpfile("mux_tb.vcd");
    //0 = guardar todas las variables de todos los niveles de jerarquía, 
    //nivel de jerarquía desde donde se quieren guardar las variables
    $dumpvars(0,mux_tb);
  end
  
  //Para inicializar variables y valores
  initial begin
    dato0 = 0;
    dato1 = 1;
    seleccion = 0;

    #10 //Retardo de 10 unidades de tiempo (nanosegundos por el timescale que definimos)
    
    dato0 = 1;
    
    #10 //Como un wait
    
    dato1 = 0;
    #5
    seleccion = 1;
    #2
    dato1 = 1;
    #2
    dato1 = 1;
    
	//Importante poner un retardo antes del finish para ver los últimos cambios    
    #10
    
    $finish;
    
  end
endmodule