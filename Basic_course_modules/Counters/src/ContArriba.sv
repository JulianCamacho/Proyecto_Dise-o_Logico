
`timescale 1ns/1ps

module ContadorHaciaArriba(
	input clk, rst,
  	output reg [3:0] cuenta
);

  //======== Sumando a la cuenta cada clk =========/
  always @ (negedge clk) begin
    if (!rst) cuenta <= 0;
	else cuenta <= cuenta+1;
  end
  
endmodule


/*
module ContadorHaciaArriba(
	input clk, rst,
  	output reg [3:0] cuenta
);

	reg [3:0] state, next_state;
    
  //======== Con Máquinas de Estado =========/
  //Memoria
  always @ (negedge clk) begin
    if (!rst) state <= 0;
	else state <= next_state;
  end
  
  //Lógica Siguiente Estado
  always @ (*) begin
  	next_state = state+1;
  end
  
  //Lógica Salida
  always @ (*) begin
    cuenta = state;
  end  
  
endmodule
*/