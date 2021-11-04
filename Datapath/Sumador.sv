//================  Sumador de n bits ================//


`timescale 1ns/1ps

module sumador #(parameter BITS=8)(
  input [BITS-1:0] A, B, 
  input Cin, 
  output reg [BITS-1:0] S, 
  output reg Cout
);
  
  always @ (*) begin
    {Cout,S} = A+B+Cin;
  end
  
endmodule