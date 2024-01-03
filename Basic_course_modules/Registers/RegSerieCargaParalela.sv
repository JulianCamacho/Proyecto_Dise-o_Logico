// Code your design here

`timescale 1ns/1ps 

module RegSerieConCargaParalela #(parameter BITS=4) (
	input clk, rst, LS, D,
  	input [BITS-1:0] DP,
  	output reg out
);
  
  //LS --> load/shift: Carga con 0, corrimiento con 1
  
  reg [BITS-1:0] state, next_state;
  
  //Memoria
  always @ (posedge clk) begin 
    if (!rst) state <= 0; 
    else state <= next_state;
  end
  
  //Siguiente estado
  always @ (*) begin
    if (LS == 0) next_state = DP;
    else next_state = {D, state[BITS-1:1]};
  end
  
  //Salida
  always @ (*) begin
    out = state[0];
  end
  
endmodule