//Pruebas MUX

`timescale 1ns/1ps

module mux_tb;
  
  reg dato0, dato1, seleccion;
  wire salida;
  
  /*mux2a1_sec DUT1 (.S(seleccion), 
           .D0(dato0), 
           .D1(dato1), 
           .Q(salida)
                  );*/  
  
  mux2a1_op_cond DUT2 (.S(seleccion), 
           .D0(dato0), 
           .D1(dato1), 
           .Q(salida)
  ); 
 
  initial begin
    dato0=0;
   	dato1=0;
    seleccion=0;
    repeat (7) begin
      #10
      {seleccion,dato1,dato0} = {seleccion,dato1,dato0}+1;
    end
    #10
    $finish;
  end
  
  initial begin 
    $display("S D1 D0 | Q");
    $monitor("%b %b %b | %b",seleccion,dato1,dato0,salida);
  end
  
endmodule