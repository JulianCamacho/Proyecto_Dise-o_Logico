// Code your design here

`timescale 1ns/1ps 

module RegSerieSerieIzquierda(
	input clk, rst, D, 
  	output  reg out
);
  
  //Una forma más compacta de modelarlo:
  
  reg [3:0]RegistroInterno;
  
  always @ (posedge clk) begin 
    if (!rst) RegistroInterno <= 0; 
    
    //Se descarta el bit en [3], y en su lugar entra D
    else RegistroInterno <= {RegistroInterno[2:0], D};
  end
  
  always @ (*) begin
  	//Out es de lógica combinacional, por eso hay que ponerlo aparte
    //Si se pone en el otro always, se actualizaría un ciclo de 
    //reloj después
    out = RegistroInterno[3];
  end
  
endmodule