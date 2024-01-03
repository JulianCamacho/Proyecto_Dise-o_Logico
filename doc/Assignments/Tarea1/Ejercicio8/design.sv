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


//=========== Ejercicio 6b ===========//

module sol6b(
  	input A, B, C, D,
  	output reg H
);

  wire Dneg, Bneg, n0, n1;
  
  assign Dneg = ~D;
  assign Bneg = ~B;
  assign n0 = Dneg & Bneg;
  assign n1 = n0 | C;
  
  mux m1 (.S(A), 
           .D0(n1), 
           .D1(Bneg), 
          .Q(H)
  );
   
endmodule














