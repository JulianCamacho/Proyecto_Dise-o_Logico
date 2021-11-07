// Datapath


// Incluir archivos de otros módulos necesarios

`include "Datapath.sv"
`include "Controlador.v"

`timescale 1ns/1ps

module TOP #(parameter BITS=8)(
  	input Start,
  	input clk, rst,
  	input [BITS-1:0] Multiplicando, Multiplicador, //DP_B: multiplicando, DP_Q: multiplicador
  output reg [2*BITS:0] Producto,
  output Ready
);
  
  
  wire Load_Regs, Shift_Regs, Add_Regs, Decr_P, C5, C6, S5, S6, S7, Q0, Zero;
  
  
 
  Datapath #(.BITS(BITS)) DP (.Load_Regs(Load_Regs),
                          .Shift_Regs(Shift_Regs), 
                          .Add_Regs(Add_Regs), 
                          .Decr_P(Decr_P), 
                          .clk(clk), 
                          .rst(rst),         
                          .DP_B(Multiplicando), 
                          .DP_Q(Multiplicador),
                          .Producto(Producto),
                          .Q0(Q0),
                          .Zero(Zero));
  
  Controlador Controller (
                    .clk(clk),
                    .rst(rst),
    				.Condicion1(Start),
                    .Condicion2(Q0),
                    .Condicion3(Zero),
    				.Condicion4(~rst),
                    .Condicion5(C5),
                    .Condicion6(C6),
                    .salida0(Decr_P),
                    .salida1(Add_Regs),
                    .salida2(Shift_Regs),
                    .salida3(Load_Regs),
    				.salida4(Ready),
                    .salida5(S5),
                    .salida6(S6),
                    .salida7(S7)
  );

  
  
endmodule