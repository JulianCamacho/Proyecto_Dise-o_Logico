//Mux 4 a 1

`timescale 1ns/1ps

module mux4a1( input D0, D1, D2, D3, S0, S1, output Q);
  
  wire n0, n1;
  mux m1 (.D0(D0), .D1(D1), .S(S0), .Q(n0));
  mux m2 (.D0(D2), .D1(D3), .S(S0), .Q(n1));
  mux m3 (.D0(n0), .D1(n1), .S(S1), .Q(Q));
  
endmodule

  
