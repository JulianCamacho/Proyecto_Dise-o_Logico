// Para registro Q

// Register Q: mantiene el multiplicador y hace corrimientos hacia la derecha

// Características:
// Entrada paralela - salida serie - Corrimiento derecha - EN


`timescale 1ns/1ps 

module RegSerieCargaParalela_EN #(parameter BITS=8) (
	input clk, rst, LS, EN, D, 
  	//D va a ser cero para reg
  	input [BITS-1:0] DP,
  	output reg out
);
  
  //LS --> load/shift: Carga con 0, corrimiento con 1
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
    if(EN == 1) begin
        // Cargar datos de DP
        if (LS == 0) next_state = DP;

        // Hacer corrimiento derecha
        else next_state = {D, state[BITS-1:1]};
    end
    //No hace nada
    else next_state = state;
  end
  
  //Salida
  always @ (*) begin
    out = state[0];
  end
  
endmodule