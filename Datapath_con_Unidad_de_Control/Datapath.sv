// Datapath


// Incluir archivos de otros módulos necesarios

`include "RegParalelaParalela_EN.sv"
`include "RegSalidaSerieYParalela_EN.sv"
`include "Contador.sv"
`include "Sumador.sv"

`timescale 1ns/1ps

module Datapath #(parameter BITS=8)(
  	input Load_Regs, Shift_Regs, Add_Regs, Decr_P,
  	input clk, rst,
	input [BITS-1:0] DP_B, DP_Q, //DP_B: multiplicando, DP_Q: multiplicador
  output reg [2*BITS:0] Producto,
  	output reg Q0, Zero
  	
  	//Zero es 1 si el contador llegó a cero
  	//Zero es 0 si el contador no ha llegado a cero
);
  
  wire [BITS-1:0] salidaRegB, salidaParalelaA, salidaParalelaQ, resultadoSum;
  wire salidaSerieA, salidaSerieQ, salidaSerieC, salidaParalelaC, cout;
  wire [2:0] cuenta;
  reg LS_A, LS_Q, EN_A, EN_C, EN_Q;
  
  //Registro B
  RegParalelaParalela_EN #(.BITS(BITS)) RegisterB (.clk(clk), 
                                      .rst(rst), 
                                      .EN(Load_Regs),
                                      .DP(DP_B), 
                                      .out(salidaRegB));
  
  //Registro C
  RegSalidaSerieYParalela_EN #(.BITS(1)) RegisterC (.clk(clk), 
                                      .rst(rst),
                                      .LS(Shift_Regs),
                                   	  .EN(EN_C),
                                      .D(0),
                                      .DP(cout),                                                .outSerie(salidaSerieC),                                      .outParalela(salidaParalelaC));
  
  //Registro A
  RegSalidaSerieYParalela_EN #(.BITS(BITS)) RegisterA (.clk(clk), 
                                      .rst(rst), 
                                      .LS(LS_A),
                                      .EN(EN_A),
                                      .D(salidaSerieC),
                                      .DP(resultadoSum), 
                                      .outSerie(salidaSerieA),                                      .outParalela(salidaParalelaA));
  
  //Registro Q
  RegSalidaSerieYParalela_EN #(.BITS(BITS)) RegisterQ (.clk(clk), 
                                      .rst(rst), 
                                      .LS(LS_Q),
                                      .EN(EN_Q),   
                                      .D(salidaSerieA),
                                      .DP(DP_Q),
                                      .outSerie(salidaSerieQ),                                      .outParalela(salidaParalelaQ));

  
  sumador #(.BITS(BITS)) sum (.A(salidaParalelaA),
                               .B(salidaRegB),
                              .Cin(salidaSerieC),
                               .S(resultadoSum),
                               .Cout(cout));
  
  
  ContadorAbajo_EN #(.BITS(3)) RegisterP (.clk(clk), 
                              .rst(rst), 
                              .EN(Decr_P),
                              .cuenta(cuenta));
  
  
  //VERIFICAR CONDICIONES QUE VIENEN DEL CONTROLADOR
  always @ (*) begin
    if (Load_Regs == 1) begin
    	//EN_B = 1; //B en modo carga
      	EN_Q = 1;
      	LS_Q = 0; //Q en modo carga
    end
    else begin
        //EN_B = 0; //B en modo hold
        LS_Q = 1; //Q en modo contar
      	EN_Q = 0;
    end
  end
  
  always @ (*) begin
    if (Add_Regs == 1) begin
    	EN_A = 1;	
      	LS_A = 0;
    end
    else begin
       LS_A = 1;
       EN_A = 0;	
    end
    
  end
  
  always @ (*) begin
    if (Shift_Regs == 1) begin
    	EN_C = 1;
      	EN_A = 1;
      	EN_Q = 1;
      	LS_A = 1;
      	LS_Q = 1;
    end
    else begin
       	LS_A = 1;
     	EN_C = 0;
      	EN_A = 0;
      	EN_Q = 0;
     	//LS_A = 0;
      	//LS_Q = 0;
    end
    
  end
  
  // SALIDAS
  always @ (*) begin
    
    Producto = {salidaSerieC, salidaParalelaA, salidaParalelaQ};
    Q0 = salidaSerieQ;
    
    if(cuenta == 0) begin
    	Zero = 1;
    end
    else Zero = 0;
    
  end

  
  
endmodule