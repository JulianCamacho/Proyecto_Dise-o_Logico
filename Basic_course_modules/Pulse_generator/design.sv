// Code your design here

`timescale 1ns/1ps

module GeneradorPulsosMealy( //Todo es casi igual
	input clk, rst,
  	input btn,
  	output reg pulso
);
  
  //=====  MEMORIA - definición de estados   =====//
  
  //Bits para la codificación de estados
  parameter N_BITS = 2;
  reg [N_BITS-1:0] state, next_state;
  
  //Definir nombres de los estados   //Cambiar estados
  parameter ESPERE_UNO = 1'b0, 
  			ESPERE_CERO = 1'b1;
  
  
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
  // Depende de la entrada
 
  always @ (*) begin
    pulso = 0;
    
    case(state)
      //Poner ifs por la dependencia de las entradas (btn)
    	ESPERE_UNO: 
          begin
            if(btn == 0) pulso = 0;
            else pulso = 1;
          end

      ESPERE_CERO: pulso = 0; //Redundante (no hace falta porque se puso al principio del always)
      
      default pulso = 0; //Redundante (no hace falta porque se puso al principio del always)
      
    endcase
  end
  
endmodule