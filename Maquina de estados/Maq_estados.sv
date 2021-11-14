
`timescale 1ns/1ps
module GeneradorMoore(
input clk, rst,pulso,
input  zero,
output reg Load_regs,Add_regs,Shift_regs,Decre_P,ready,flag,
output reg [2:0] salida);

reg [2:0] state,next_state;


parameter Load=3'b000,Shift=3'b001, Add=3'b010,Decr=3'b011,Ready=3'b100,nulo=3'b111;
  
always@ (posedge clk) begin
  if(!rst) state<=Ready;
	else state<=next_state;
end

always@ (*) begin
 	Load_regs <= 0;
    Add_regs <= 0;
    Shift_regs <= 0;
    Decre_P <= 0;
    ready <= 0;
	case(state)
	Load:begin
          next_state= nulo;
 
		end
	Shift:begin 
       next_state= Decr;
      	Decre_P <= 1;
		end
	Add:begin 
      next_state= Shift;
      Shift_regs <= 1;
		
		end
	Decr:begin 
      if( zero==1) begin
        next_state= Ready ;
        ready <= 1;
        
      end
		else begin
            //next_state= nulo ;
          	if(pulso==0) begin
          		next_state= Shift;
 
      			Shift_regs <= 1;
      		end
			else begin
         		 next_state=Add;
      			Add_regs <= 1;
        		end
        
		end
    	end
    nulo:begin
      if(pulso==0) begin
          next_state= Shift;
 
      	Shift_regs <= 1;
      end
		else begin
          next_state=Add;
      		Add_regs <= 1;
        end
		end
    //Ready:begin
    //  	next_state= Ready ;
    //  ready <= 1;
    //end
    default:begin
      next_state= Load; 
      Load_regs <= 1;
    end
	endcase
  salida=state;
end
endmodule