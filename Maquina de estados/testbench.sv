// Code your testbench here
// or browse Examples

//`include "Maq_estados.sv"
`timescale 1ns/1ps



module testbench;
  
  
  reg clk,rst,q,zero;
  reg  [2:0] salida_estados;
  reg  [7:0] multiplicador, multiplicando;
  wire [2:0] ready;
  wire [16:0] producto;

  General Estados(.clk(clk),
                  .rst(rst),
                  .DP_B(multiplicador),
                  .DP_Q(multiplicando),
                  .ready(ready),
                  .Producto(producto));
  
//  GeneradorMoore FSM(.clk(clk),.rst(rst),.pulso(q), .zero(zero),.salida(ready));  
  
initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0,testbench);
  end
  
  initial begin
    clk = 0;
  end
  
  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    rst<=0;
    @(posedge clk) 
    rst<=1;
    multiplicador = 8'b00010111;
    multiplicando = 8'b00010011;
    
    //while(ready != 3'b100) begin
      //@(posedge clk);
    
  	//end
    
    repeat(50)begin
      @(posedge clk);
    end

    $finish;
  end
  
  
  
  initial begin
    
    $monitor("ready=%b, producto=%b", ready, producto);
  end


    
endmodule