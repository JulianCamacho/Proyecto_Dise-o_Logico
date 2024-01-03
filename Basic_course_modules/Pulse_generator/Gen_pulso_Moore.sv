// Code your design here

`timescale 1ns/1ps

module GeneradorPulsosMoore(
	input clk, rst,
  	input btn,
  	output reg pulso
);
  
  //=====  MEMORIA - definición de estados   =====//
  
  //Bits para la codificación de estados
  parameter N_BITS = 2;
  reg [N_BITS-1:0] state, next_state;
  
  //Definir nombres de los estados
  parameter ESPERE_UNO = 2'b00, 
  			GENERE_PULSO = 2'b01, 
  			ESPERE_CERO = 2'b11;
  
  
  always @ (posedge clk) begin
    //Si hay un reset (en 1) ir a ESPERE_UNO
    if (!rst) state <= ESPERE_UNO;
    else state <= next_state;
  end
  
  
  //========  LÓGICA DE SIGUIENTE ESTADO  ===========//
 
  always @ (*) begin
    //Ver diagrama de estados para poner las transiciones
    case(state)
      
      ESPERE_UNO: 
        begin
        	if (btn == 0) next_state = ESPERE_UNO;
        	else next_state = GENERE_PULSO;
      	end
      	
      GENERE_PULSO:
        begin
          	if (btn == 0) next_state = ESPERE_UNO;
        	else next_state = ESPERE_CERO;
      	end
      
      ESPERE_CERO:
        begin
        	if (btn == 0) next_state = ESPERE_UNO;
        	else next_state = ESPERE_CERO;
      	end
      
      //SIEMPRE
      //Para regresar a algún estado 
      //si se llega a un estado inválido por ejemplo
      default:
        next_state = ESPERE_UNO;
      
    endcase
  end
  
  
  //========  LÓGICA DE SALIDA  ===========//
 
  always @ (*) begin
    pulso = 0;
    
    case(state)
         GENERE_PULSO: pulso = 1;
      
      //Los otros no aparecen porque en esos la salida
      //(pulso) se mantiene en 0, y se pone en cero cada
      //vez que entra al always
      
      default pulso = 0; //Redundante, pero por si acaso 
    endcase
  end
  
endmodule