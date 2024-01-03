// Code your design here

`timescale 1ns/1ps

module ContadorHaciaArriba_EN(
	input clk, rst, enable,
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
    if (enable == 0) begin //No seguir contando
        next_state = state;
    end
    else begin //Seguir contando
    	next_state = state+1;
    end
  end
  
  //Lógica Salida
  always @ (*) begin
    cuenta = state;
  end  
  
endmodule


/*
module ContadorHaciaArriba_EN(
	input clk, rst, enable
  	output reg [3:0] cuenta
);

  //======== Sumando a la cuenta cada clk =========/
  always @ (negedge clk) begin
    if (!rst) cuenta <= 0;
    else begin
    	if (enable==1) cuenta <= cuenta+1;
    end
    
    //NO hace falta el else porque ya se está generando memoria (no es combinacional como en el caso de arriba), pero se puede poner por si acaso
    
  end
  
endmodule
*/