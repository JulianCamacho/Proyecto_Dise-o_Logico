// Code your design here

`timescale 1ns/1ps

module ContadorHaciaArriba_EN_UD_LC(
	input clk, rst, enable, UD, LC,
  	input [3:0] entradaParalela,
  	output reg [3:0] cuenta
);
  
  //LC: Carga o cuenta
  //LC = 0: cuenta, LC = 1: carga

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
      if(LC ==0) begin //Modo cuenta
        if(UD == 0) begin //Modo hacia arriba
          next_state = state+1;
        end
        else begin //Modo hacia abajo
          next_state = state-1;
        end
      end
      else begin //Modo carga
        next_state <= entradaParalela;
      end
    end
      
  end
  
  //Lógica Salida
  always @ (*) begin
    cuenta = state;
  end  
  
endmodule


/*
module ContadorHaciaArriba_EN_UD_LC(
	input clk, rst, enable, UD, LC,
    input [3:0] entradaParalela,
  	output reg [3:0] cuenta
);

  //======== Sumando a la cuenta cada clk =========/
  always @ (negedge clk) begin
    if (!rst) cuenta <= 0;
    else begin
    	if (enable==1) begin
            if(LC ==0) begin
                if (UD == 0) begin
                    cuenta <= cuenta+1;
                end
                else begin
                    cuenta <= cuenta-1;
                end
            end
            else begin
            	cuenta = entradaParalela;
            end
        end
        
    end
    
    //NO hace falta el else porque ya se está generando memoria (no es combinacional como en el caso de arriba), pero se puede poner por si acaso
    
  end
  
endmodule
*/