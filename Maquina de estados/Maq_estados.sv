`timescale 1ns/1ps

module GeneradorMoore(
input clk, rst,pulso,
input  zero,
output reg [2:0] salida);

reg [2:0] state,next_state;


parameter Load=3'b000,Shift=3'b001, Add=3'b010,Decr=3'b011,Ready=3'b100;
  
always@ (posedge clk) begin
  if(!rst) state<=Ready;
	else state<=next_state;
end

always@ (*) begin
 
	case(state)
	Load:begin
		if(pulso==0) next_state= Shift;
		else next_state=Add;
		end
	Shift:begin 
      if(pulso==0) next_state= Decr;
		else next_state=3'b011;
		end
	Add:begin 
      if(pulso==0) next_state= Shift;
		else next_state=Shift;
		end
	Decr:begin 
      if((pulso==0) && (zero==1'b1)) next_state= Ready ;
		else next_state= Load ;
		end
    Ready:begin
      	next_state= Ready ;
    end
    default:next_state= Load; 
      
	endcase
  salida=state;
end
endmodule