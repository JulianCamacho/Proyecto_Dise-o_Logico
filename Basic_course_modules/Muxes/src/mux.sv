//===================== Mux 2 a 1 =======================//

`timescale 1ns/1ps

module mux(
  	input D0, D1, S,
  	output Q
);
  
//Otra opción
//module mux(D0,D1,S,Q);
//  input D0,D1,S;
//  output Q;
  
  
  wire Snegado;
  wire n0, n1;
  
  //A nivel de compuertas
  //Tipo nombre (out, in)
  not u0 (Snegado, S);
  and u1 (n0, D0,Snegado);
  and u2 (n1, D1,S);
  or u3 (Q, n0,n1);
  
  //Con la expresión booleana
  //assign Q = (D0&(~S)) | (D1&S);
  
  //Con asignación más alto nivel
  //Assign varSal = expr ? true : false;
  //assign Q = S?D1:D0;

  //Paso a paso
  //assign Snegado = ~S;
  //assign n0 = D0&Snegado;
  //assign n1 = D1&S;
  //assign Q = n0|n1;

  //Always
  //Ejecútese cada vez que haya un cambio en D0, D1 o S
  //always @ (D0 or D1 or S) begin
  // * cada vez que cualquiera de todos cambie
  
  //reg Q;
  //always @ (*) begin
    //Var a la izq => var de salida => reg
    //Q = (D0&(~S)) | (D1&S);
  //end
  
  //Mejor usar always para instrucciones de más alto nivel
  //always @ (*) begin
    //if (!S): Q = D0;
    //else Q = Q1;
  //end
  
  
  //O con case
  //always @ (*) begin
    //case(S)
      //0: Q = D0;
      //1: Q = D1;
    //endcase
  //end
  
  
endmodule