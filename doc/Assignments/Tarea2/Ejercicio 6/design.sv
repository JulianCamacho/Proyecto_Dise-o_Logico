// Code your design here

`timescale 1ns/1ps


//     ____________       _____________     //
//____/  Mux 2 a 1 \_____/  Secuencial \____//

module mux2a1_sec(
  	input D0, D1, S,
  	output reg Q
);
	always @ (*) begin
      if (!S) Q = D0;
      else Q = D1;
    end
      
endmodule


//     ____________       _________________________     //
//____/  Mux 2 a 1 \_____/  Compuertas primitivas  \____//

module mux2a1_comp(
  	input D0, D1, S,
  	output Q
);
  
  wire Snegado;
  wire n0, n1;
  
  not u0 (Snegado, S);
  and u1 (n0, D0,Snegado);
  and u2 (n1, D1,S);
  or u3 (Q, n0,n1);
  
endmodule


//     ____________       ________________________     //
//____/  Mux 2 a 1 \_____/  Ecuaciones booleanas  \____//

module mux2a1_ec_bool(
  	input D0, D1, S,
  	output Q
);
  
  wire Snegado;
  wire n0, n1;
  
  assign Snegado = ~S;
  assign n0 = D0&Snegado;
  assign n1 = D1&S;
  assign Q = n0|n1;
  
endmodule


//     ____________       ________________________     //
//____/  Mux 2 a 1 \_____/  Operador condicional  \____//
      
module mux2a1_op_cond(
  	input D0, D1, S,
  	output Q
);
  
  assign Q = S?D1:D0;
  
endmodule