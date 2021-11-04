// Para registro B
// Register B: mantiene el multiplicando

// Características:
// Entrada paralela - salida paralela - EN


`timescale 1ns/1ps 

module RegParalelaParalela_EN #(parameter BITS=8) (
	input clk, rst, EN, 
  	input [BITS-1:0] DP,
  	output reg [BITS-1:0] out
);
  
  //EN --> enable: no hace nada con 0, funciona con 1 
  
  reg [BITS-1:0] state, next_state;
  
  //Memoria
  always @ (posedge clk) begin 
    if (!rst) state <= 0; 
    else state <= next_state;
  end
  
  //Siguiente estado
  always @ (*) begin
    //Funciona
    if(EN == 1) next_state = DP;
    //No hace nada
    else next_state = state;
  end
  
  //Salida
  always @ (*) begin
    out = state;
  end
  
endmodule