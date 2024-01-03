// Code your testbench here (pruebas)

`timescale 1ns/1ps

module demux_tb;
 
  parameter ANCHO = 16;
  reg [1:0] seleccion;
  reg [ANCHO-1:0] dato0_p, dato1_p, dato2_p, dato3_p; 
  wire [ANCHO-1:0] salida_p;
  wire [ANCHO-1:0] salida0_p, salida1_p, salida2_p, salida3_p;
  
  mux4a1BusParam #(.ANCHO(ANCHO)) DUT_MUX (.S(seleccion),
                                           .D0(dato0_p), 
                                           .D1(dato1_p),
                                           .D2(dato2_p),
                                           .D3(dato3_p),
                                           .Q(salida_p)
  );
  
  demux1a4Param #(.ANCHO(ANCHO)) DUT_DEMUX (.S(seleccion),
                                            .D(salida_p),
                                            .out0(salida0_p),
                                            .out1(salida1_p),
                                            .out2(salida2_p),
                                            .out3(salida3_p)
                      
  );
  
  
  initial begin
    $dumpfile("demux_tb.vcd");
    $dumpvars(0,demux_tb);
  end
  
  //Para inicializar variables y valores
  initial begin
    seleccion = 0;
    dato0_p = $random;
    dato1_p = $random;
    dato2_p = $random;
    dato3_p = $random;
    
    repeat(4) begin
      repeat(3) begin
        #5
        dato0_p = $random;
    	dato1_p = $random;
    	dato2_p = $random;
    	dato3_p = $random;
      end
      #5
      seleccion = seleccion+1;
    end
    #5
    $finish;
    
  end
endmodule
