// Code your design here

`timescale 1ns/1ps 

module RegistroBidireccional (
	input clk, rst, Direccion, InMSB, InLSB,
  	output reg QMSB, QLSB
);
  
  //Es como tener un FF por cada bit del registro
  //Ese bit es el que se guarda en ese FF
  reg [3:0] state, next_state;
  
  //Memoria
  always @ (posedge clk) begin
    //Puede ser cero o cualquier estado que sea el inicial con el rst
    if (!rst) state <= 0; 
    else state <= next_state;
  end
  
  //Siguiente estado
  //Direccion = 0: Corrimiento derecha
  //Direccion = 1: Corrimiento izquierda
  //La direccion cambia con el flanco de reloj
  always @ (*) begin
    //Igual que Direccion == 0:
    if (~Direccion) next_state = {InMSB, state[3:1]};
    else next_state = {state[2:0], InLSB};
  end
  
  //Salida 
  always @ (*) begin
    //Las salidas se leen siempre
    QMSB = state[3];
    QLSB = state[0];
  end
  
endmodule