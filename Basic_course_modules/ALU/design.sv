// Code your design here

`timescale 1ns/1ps


//================  ALU Paramétrica  ================//

module ALU (input A, B, Ainv, Binv, Cin, 
            input [1:0] operacion, 
            output reg resultado, 
            output Cout); //Por defecto los inputs y outputs son wires
  //Las salidas solo pueden ser wires, por eso no se le pone reg al Cout
  
  wire salidaMux1, salidaMux2, salidaSuma; 
  
  mux21 M1 (.D0(A), .D1(~A), .S(Ainv), .Q(salidaMux1));
  mux21 M2 (.D0(B), .D1(~B), .S(Binv), .Q(salidaMux2));
  
  sumador suma (.A(salidaMux1), 
                .B(salidaMux2), 
                .Cin(Cin), 
                .S(salidaSuma), 
                .Cout(Cout));
  
  //Como hacer otro módulo
  always @ (*) begin
    case(operacion)
      
      //Estos TIENEN que ser reg = estos pueden ser wires
      0: resultado = salidaMux1 & salidaMux2;
      1: resultado = salidaMux1 | salidaMux2;
      2: resultado = salidaSuma;
      
      //3: resultado = 0; o
      default resultado = 0;
    endcase
  end
  
endmodule


//================  Sumador  ================//

module sumador(input A, B, Cin, output reg S, Cout);
  
  always @ (*) begin
    //Con las expresiones lógicas
    //S = (A^B)^Cin;
    //Cout = (A&B)|(A^B)&Cin;
    {Cout,S} = A+B+Cin;
  end
  
endmodule

//================  Mux 2 a 1  ================//

module mux21(input D0, D1, S, output reg Q);
  
   always @ (*) begin
     if(!S) Q = D0;
     else Q = D1;
  end
  
endmodule

