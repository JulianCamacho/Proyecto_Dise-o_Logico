`include "Base.sv"
`include "Maq_estados.sv"
`timescale 1ns/1ps
module General(
input clk, rst, q,Zero,
input [7:0] DP_B, DP_Q, //DP_B: multiplicando, DP_Q: multiplicador
  output reg [16:0] Producto,
  output reg [2:0] ready);
  
  wire Q0, zero;
  wire [2:0] cuenta;
  wire [2:0] salida_estados;
  reg Load_Regs, Shift_Regs, Add_Regs, Decr_P;
  
  parameter Load=3'b000,Shift=3'b001, Add=3'b010,Decr=3'b011,Ready=3'b100;
  
  
  GeneradorMoore FSM(.clk(clk),.rst(rst),.pulso(q), .zero(Zero),.salida(salida_estados));
  
TOP #(.BITS(8)) DUT (.Load_Regs(Load_Regs),
                          .Shift_Regs(Shift_Regs), 
                          .Add_Regs(Add_Regs), 
                          .Decr_P(Decr_P), 
                         .clk(clk), 
                          .rst(rst),         
                          .DP_B(DP_B), 
                          .DP_Q(DP_Q),
                          .Producto(Producto),
                          .Q0(Q0),
                      .Zero(zero),
                         .P(cuenta));  
  


  always @ (*) begin
    ready = salida_estados;
    case(salida_estados)
	Load:begin
		Load_Regs =1;
      	Shift_Regs =0;
      	Add_Regs =0;
      	Decr_P=0;
		end
	Shift:begin 
      	Load_Regs =0;
      	Shift_Regs =1;
      	Add_Regs =0;
      	Decr_P=0;
		end
	Add:begin 
      Load_Regs =0;
      	Shift_Regs =0;
      	Add_Regs =1;
      	Decr_P=0;
		end
	Decr:begin 
      Load_Regs =0;
      	Shift_Regs =0;
      	Add_Regs =0;
      	Decr_P=1;
		end
    default:
      begin
        Load_Regs =1;
      	Shift_Regs =0;
      	Add_Regs =0;
      	Decr_P=0;
      end
	endcase
  
  
  end

endmodule