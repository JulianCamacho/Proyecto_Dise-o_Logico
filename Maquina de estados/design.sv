`include "Base.sv"
`include "Maq_estados.sv"
`timescale 1ns/1ps
module General(
input clk, rst,
input [7:0] DP_B, DP_Q, //DP_B: multiplicando, DP_Q: multiplicador
output reg [16:0] Producto,
output reg [2:0] ready);
  
  wire Q0, zero;
  wire [2:0] cuenta;
  wire [2:0] salida_estados;
  wire LOAD,ADD,SHIFT,DECR,READY;
  

 
  
  GeneradorMoore dux (.clk(clk),
                      .rst(rst),
                      .pulso(Q0),
                      .zero(zero),
                      .Load_regs(LOAD),
                      .Add_regs(ADD),
                      .Shift_regs(SHIFT),
                      .Decre_P(DECR),
                      .ready(READY),
                      .salida(ready));
  
  
  TOP #(.BITS(8)) DUT (.Load_Regs(LOAD),
                       .Shift_Regs(SHIFT), 
                       .Add_Regs(ADD), 
                       .Decr_P(DECR), 
                         .clk(clk), 
                          .rst(rst),         
                          .DP_B(DP_B), 
                          .DP_Q(DP_Q),
                          .Producto(Producto),
                          .Q0(Q0),
                      .Zero(zero),
                         .P(cuenta));  
  



endmodule