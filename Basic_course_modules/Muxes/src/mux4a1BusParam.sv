// Code your testbench here (pruebas)

`timescale 1ns/1ps

module mux4a1BusParam_tb;
 
  reg [7:0] dato0, dato1, dato2, dato3; 
  reg [1:0] seleccion;
  wire [7:0] salida;

  //Sin parámetro porque por defecto es de 8 y matchea con las variables
  mux4a1BusParam DUT (.S(seleccion),
              .D0(dato0), 
              .D1(dato1),
              .D2(dato2),
              .D3(dato3),
              .Q(salida)
  );
  
  reg [3:0] dato0_4, dato1_4, dato2_4, dato3_4; 
  wire [3:0] salida_4;
  
  //Mux 4a1 con parámetros
  mux4a1BusParam #(.ANCHO(4)) DUT_B (.S(seleccion),
                      .D0(dato0_4), 
                      .D1(dato1_4),
                      .D2(dato2_4),
                      .D3(dato3_4),
                      .Q(salida_4)
  );
  
  //Se pueden crear parámetros acá
  parameter ANCHO = 16;
  reg [ANCHO-1:0] dato0_p, dato1_p, dato2_p, dato3_p; 
  wire [ANCHO-1:0] salida_p;
  
  mux4a1BusParam #(.ANCHO(ANCHO)) DUT_C (.S(seleccion),
                                         .D0(dato0_p), 
                                         .D1(dato1_p),
                                         .D2(dato2_p),
                                         .D3(dato3_p),
                                         .Q(salida_p)
  );
  
  initial begin
    $dumpfile("mux4a1BusParam_tb.vcd");
    $dumpvars(0,mux4a1BusParam_tb);
  end
  
  //Para inicializar variables y valores
  initial begin
    seleccion = 0;
    dato0 = 10;
    dato1 = 20;
    dato2 = 30;
    dato3 = 40;
    dato0_4 = 0;
    dato1_4 = 1;
    dato2_4 = 5;
    dato3_4 = 6;
    dato0_p = $random;
    dato1_p = $random;
    dato2_p = $random;
    dato3_p = $random;
    
    repeat(4) begin
      repeat(3) begin
        #5
        dato0 = dato0+1;
        dato1 = dato1+1;
        dato2 = dato2+1;
        dato3 = dato3+1;
        dato0_4 = dato0_4+1;
        dato1_4 = dato1_4+1;
        dato2_4 = dato2_4+1;
        dato3_4 = dato3_4+1;
      end
      #5
      seleccion = seleccion+1;
    end
    #5
    $finish;
    
  end
endmodule
