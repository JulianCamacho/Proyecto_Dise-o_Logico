// Contador hacia abajo con enable

`timescale 1ns/1ps

module ContadorAbajo_EN #(parameter BITS=3)(
	input clk, rst, EN,
  	output reg [BITS-1:0] cuenta
);

  reg [BITS-1:0] state, next_state;
  
  //Memoria
  always @ (posedge clk) begin
    if (!rst) state <= 7;
	else state <= next_state;
  end
  
  //Lógica Siguiente Estado
  always @ (*) begin
    if (EN == 0) begin //No seguir contando
        next_state = state;
    end
    else begin //Seguir contando
        next_state = state-1;
    end
  end
  
  //Lógica Salida
  always @ (*) begin
    cuenta = state;
  end  
  
endmodule