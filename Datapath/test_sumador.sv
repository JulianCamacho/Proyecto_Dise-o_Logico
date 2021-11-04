// Code your testbench here
// or browse Examples

`include "Sumador.sv"


`timescale 1ns/1ps

module testbench;
  
  reg [7:0] A, B;
  reg Cin;
  
  wire [7:0] resultado;
  wire cout;
  
  sumador DUT (.A(A),
               .B(B),
               .Cin(Cin),
               .S(resultado),
               .Cout(cout));

  initial begin
    A=8'b11111111; B=8'b11111111; Cin=0;
 
  end
  
  initial begin
    //print
    $monitor("Cout=%b, Res=%b", cout, resultado);

  end


    
endmodule