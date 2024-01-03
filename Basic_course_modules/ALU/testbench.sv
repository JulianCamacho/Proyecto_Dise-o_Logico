// Code your testbench here
// or browse Examples

`timescale 1ns/1ps

module testbench;
  
  reg A, B, Ainv, Binv, Cin;
  reg [1:0] operacion;
  
  wire resultado, Cout;
  
  ALU DUT (.A(A), 
           .B(B), 
           .Ainv(Ainv), 
           .Binv(Binv), 
           .Cin(Cin), 
           .operacion(operacion), 
           .resultado(resultado), 
           .Cout(Cout));
  
  integer i;
  
  initial begin
    A=0; B=0; Ainv=0; Binv=0; Cin=0; operacion=0;
  

  
    for(i=0; i<128; i=i+1) begin
      #5
      //Se generan todas las combinaciones
      {operacion, Cin, Ainv, Binv, A, B} = i;
    end
  end
  
  initial begin
    //print
    $monitor("Op=%d, Cin=%b, Ainv=%b, Binv=%b, A=%b, B=%b, Res=%b,Cout=%b", 
             operacion, Cin, Ainv, Binv, 
             A, B, resultado,Cout);
  end
    
endmodule

  //Maneras de iterar
  //Repeat
  /*
  repeat (4) begin
    #5
    repeat (2) begin
      repeat (2) begin
        Ainv = ~Ainv
        	//.... Hacer repeats para cada uno 
        		//... Para ir generando todas las combinaciones
      end
      	Cin = ~Cin
    end
  end
  */
  