// Code your design here

`timescale 1ns/1ps 

module RegSerieSerieDerecha(
	input clk, rst, D, 
  	output  reg out
);
  
  reg [3:0]state, next_state;
  
  always @ (posedge clk) begin 
    if (!rst) state <= 0; 
    else state <= next_state;
  end
  
  always @ (*) begin
    //Actualizar el corrimiento con concatenación
    //Ojo que el último bit (state[0]) se corre y ya no se toma en cuenta
    
    next_state = {D,state[3:1]};
    
    //next_state = {D,state[3], state[2], state[1]};
    
    //Todas son equivalentes
    /*next_state[3] = D;
    next_state[2] = state[3];
    next_state[1] = state[2];
    next_state[0] = state[1];*/
    
  end
  
  
  always @ (*) begin
    out = state[0];
  end
  
endmodule