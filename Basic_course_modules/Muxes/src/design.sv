// Code your design here


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
    //else Q = D1;
  //end
  
  
  //O con case
  //always @ (*) begin
    //case(S)
      //0: Q = D0;
      //1: Q = D1;
    //endcase
  //end
  
  
endmodule


//===================== Mux 4 a 1 =======================//

`timescale 1ns/1ps

//Forma estructural
/*module mux4a1( input D0, D1, D2, D3, S0, S1, output Q);
  
  wire n0, n1;
  mux m1 (.D0(D0), .D1(D1), .S(S0), .Q(n0));
  mux m2 (.D0(D2), .D1(D3), .S(S0), .Q(n1));
  mux m3 (.D0(n0), .D1(n1), .S(S1), .Q(Q));
  
endmodule*/

//Otra forma de más alto nivel
/*module mux4a1( input D0, D1, D2, D3, S0, S1, output reg Q); //Ojo al reg
  
  always @ (*) begin
    //Concatenar S1 y S0
    case({S1,S0})
      2'b00: Q = D0;
      2'b01: Q = D1;
      2'b10: Q = D2;
      2'b11: Q = D3;
    endcase
  end
  
endmodule*/


//Otra forma de dos bits
module mux4a1(input D0, D1, D2, D3, input[1:0] S, output Q);
  
  wire n0, n1;
  mux m1 (.D0(D0), .D1(D1), .S(S[0]), .Q(n0));
  mux m2 (.D0(D2), .D1(D3), .S(S[0]), .Q(n1));
  mux m3 (.D0(n0), .D1(n1), .S(S[1]), .Q(Q));
  
endmodule



//===================== Mux 4 a 1 Bus =======================//

module mux4a1bus(input [3:0] D0, D1, D2, D3, //Ahora cada una es de 4 bits
              	input[1:0] S, 
              	output reg [3:0] Q); //Ojo al reg
  
  always @ (*) begin
    case(S)
      2'b00: Q = D0;
      2'b01: Q = D1;
      2'b10: Q = D2;
      2'b11: Q = D3;
    endcase
  end
  
endmodule


//===================== Mux 4 a 1 Bus =======================//

//#(parameter nombre = valorxDefecto)
module mux4a1BusParam #(parameter ANCHO = 8)
  (input [ANCHO-1:0] D0, D1, D2, D3,
     input[1:0] S, 
     output reg [ANCHO-1:0] Q
  );
  
  always @ (*) begin
    case(S)
      2'b00: Q = D0;
      2'b01: Q = D1;
      2'b10: Q = D2;
      2'b11: Q = D3;
    endcase
  end
  
endmodule


//===================== DeMux 1 a 4 Bus =======================//

module demux1a4Param #(parameter ANCHO = 8)
  	(input [1:0] S,
     input [ANCHO-1:0] D, 
     output reg [ANCHO-1:0] out0, out1, out2, out3
  );
  
  /*always @ (*) begin
    case(S)
      //Error lógico porque guardaría el último valor que tuvo
      //Es combinacional: solo debe depender de las entradas actuales
      //Además no se inicializan por lo que empiezan con X
      0: out0 = D;
      1: out1 = D;
      2: out2 = D;
      3: out3 = D;
    endcase
  end*/
  
  //Manera larga
  /*always @ (*) begin
    case(S)
      0: begin
        out0 = D;
        out1 = 0;
      	out2 = 0;
      	out3 = 0;
      end
      1: begin
        out0 = 0;
        out1 = D;
      	out2 = 0;
      	out3 = 0;
      end
      2: begin
        out0 = 0;
        out1 = 0;
      	out2 = D;
      	out3 = 0;
      end
      3: begin
        out0 = 0;
        out1 = 0;
      	out2 = 0;
      	out3 = D;
      end
    endcase
  end*/
  
  //Manera corta
  //Funciona porque se ejecuta cada vez que cambia una variable
  always @ (*) begin
    out0 = 0;
    out1 = 0;
    out2 = 0;
    out3 = 0;
    case(S)
      0: out0 = D;
      1: out1 = D;
      2: out2 = D;
      3: out3 = D;
    endcase
  end
  
endmodule


//===================== Mux 3 a 1 Bus =======================//

module mux3a1BusParam #(parameter ANCHO = 8)
  (input [ANCHO-1:0] D0, D1, D2,
     input[1:0] S, 
     output reg [ANCHO-1:0] Q
  );
  
  /*always @ (*) begin
    //Como no se tiene caso para 11 (3), se guarda el último valor
    //Se crea memoria! => error lógico
    case(S)
      2'b00: Q = D0;
      2'b01: Q = D1;
      2'b10: Q = D2;
    endcase
  end*/
  
  always @ (*) begin
    //Q = 0;  una opción
    case(S)
      2'b00: Q = D0;
      2'b01: Q = D1;
      2'b10: Q = D2;
      default: Q = 0; //Otra solución
      //2'b10: Q = 0;  Otra solución, larga si hay que poner muchos
    endcase
  end
  
  //======= Con if else
  /*always @ (*) begin
    if(S==0) Q=D0;
    else if (S==1) Q=D1;
    else if (S==2) Q=D2;

    //Mismo error se generaría si no se pusiera el else
    else Q=0;
  end*/
  
endmodule
