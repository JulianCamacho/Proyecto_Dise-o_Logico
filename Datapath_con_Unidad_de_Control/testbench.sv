// Testbench de TOP


`timescale 1ns/1ps

module testbench;
  
  parameter BITS = 8;

  reg clk, rst, Start;
  reg [BITS-1:0] Multiplicando, Multiplicador;
  
  wire [2*BITS:0] Producto;
  wire Ready;

  
  TOP #(.BITS(BITS)) DUT (.Start(Start),
                          .clk(clk),
                          .rst(rst),
                          .Multiplicando(Multiplicando), 
                          .Multiplicador(Multiplicador),
                          .Producto(Producto),
                          .Ready(Ready)
                         
                         );
                          
  
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
    rst <= 0;
    Start <= 0;
    @(posedge clk)
    rst<=1;
    Start <= 1;

    Multiplicando = 8'b00010111;
    Multiplicador = 8'b00010011;

    repeat(100)begin
      @(posedge clk);
      if (Ready) $finish;
    end

    
    $finish;
  end
  
  initial begin
    $monitor("Producto=%b, Ready=%b", Producto, Ready);
  end


    
endmodule