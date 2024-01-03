// Code your testbench here
// or browse Examples

`timescale 1ns/1ps 

module TB_RegistroBidireccional;
  
  reg clk, rst, Direccion, InMSB, InLSB;
  wire QMSB, QLSB;
  
  RegistroBidireccional DUT (.clk(clk), .rst(rst),
                                .Direccion(Direccion), 
                                .InMSB(InMSB), 	.InLSB(InLSB),								.QMSB(QMSB), .QLSB(QLSB));
  
  initial begin
    $dumpfile ("RegistroBidireccional.vcd");
    $dumpvars(0, TB_RegistroBidireccional);
  end
  
  
  //RELOJ
  always begin
    //Ciclo cada 10 unidades de tiempo
  	#5 clk = ~clk;
  end
  
  initial begin
    //Usando NONBLOCKING para evitar condiciones de carrera (?)	de temporización (no lo hemos visto)
    rst <= 0;
    Direccion <= 0;
    InLSB <= 0;
    InMSB <= 0;
    
    //Esperar dos flancos de reloj
    @ (posedge clk);
    @ (posedge clk);

    rst <= 1;
    
    @ (posedge clk);
    
    InMSB <= 1;

    @ (posedge clk);
    
    InMSB <= 0;
    
    @ (posedge clk);
    
    InLSB <= 1;
    
    #20 $finish;
  end
  
endmodule