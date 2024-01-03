// Code your testbench here
// or browse Examples

`timescale 1ns/1ps 

module TB_RegSerieSerieDerecha;
  
  reg clk, rst, D;
  wire out;
  
  RegSerieSerieDerecha DUT (.clk(clk), .rst(rst), .D(D), .out(out));
  
  initial begin
    $dumpfile ("RegSerieSerieDerecha.vcd");
    $dumpvars(0, TB_RegSerieSerieDerecha);
  end
  
  
  //RELOJ
  always begin
  	#5 clk = ~clk;
  end
  
  initial begin
  	clk = 0;
    rst = 0;
    D = 0;
    @(posedge clk);
    #1
    @(posedge clk);
    rst = 1;
    @(posedge clk); D= 1; //LSB
    @(posedge clk); D= 0;
    @(posedge clk); D= 1;
    @(posedge clk); D= 1;
    @(posedge clk); D= 0;
    @(posedge clk); D= 0;
    @(posedge clk); D= 0;
    @(posedge clk); D= 0;
    @(posedge clk); $finish;
  end
  
endmodule