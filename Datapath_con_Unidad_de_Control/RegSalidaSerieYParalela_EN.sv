// Para registro A

// Register A: mantiene la suma parcial con el multiplicando y hace corrimientos hacia la derecha

// Características:
// Entrada paralela - salida serie y paralela - Corrimiento derecha - EN


`timescale 1ns/1ps 

module RegSalidaSerieYParalela_EN #(parameter BITS=8) (
	input clk, rst, LS, EN, D, 
  	//D va a ser cero para reg
  	input [BITS-1:0] DP,
  	output reg outSerie,
 	output reg [BITS-1:0] outParalela
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
      if (BITS == 1) begin
        // Cargar datos de DP
        if (LS == 0) next_state = DP;
        // Hacer corrimiento derecha
        else next_state = D;
      end
      else begin     
        // Cargar datos de DP
        if (LS == 0) next_state = DP;
        // Hacer corrimiento derecha
        else next_state = {D, state[BITS-1:1]};
      end 
        
    end
    //No hace nada
    else next_state = state;
  end
  
  //Salida
  always @ (*) begin
    outSerie = state[0];
    outParalela = state;
  end
  
endmodule