// Code your testbench here (pruebas)

`timescale 1ns/1ps

module mux3a1BusParam_tb;
 
  parameter ANCHO = 16;
  reg [1:0] seleccion;
  reg [ANCHO-1:0] dato0_p, dato1_p, dato2_p; 
  wire [ANCHO-1:0] salida_p;
  
  mux3a1BusParam #(.ANCHO(ANCHO)) DUT_MUX (.S(seleccion),
                                           .D0(dato0_p), 
                                           .D1(dato1_p),
                                           .D2(dato2_p),
                                           .Q(salida_p)
  );
  
  initial begin
    $dumpfile("mux3a1BusParam_tb.vcd");
    $dumpvars(0,mux3a1BusParam_tb);
  end
  
  //Para inicializar variables y valores
  initial begin
    seleccion = 0;
    dato0_p = $random;
    dato1_p = $random;
    dato2_p = $random;   
    repeat(8) begin
      repeat(3) begin
        #5
        dato0_p = $random;
    	dato1_p = $random;
    	dato2_p = $random;
      end
      #5
      seleccion = seleccion+1;
    end
    #5
    $finish;
    
  end
endmodule

