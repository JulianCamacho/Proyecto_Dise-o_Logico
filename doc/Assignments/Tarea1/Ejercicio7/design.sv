// Code your design here


//=========== Mux 2 a 1 ===========//

`timescale 1ns/1ps

module mux(
  	input D0, D1, S,
  	output reg Q
);

  always @ (*) begin
    case(S)
      0: Q = D0;
      1: Q = D1;
    endcase
  end 
  
endmodule



