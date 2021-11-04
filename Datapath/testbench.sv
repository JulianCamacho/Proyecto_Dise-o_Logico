// Code your testbench here
// or browse Examples


`timescale 1ns/1ps

module testbench;
  
  parameter BITS = 8;
  
  reg Load_Regs, Shift_Regs, Add_Regs, Decr_P;
  reg clk, rst;
  reg [BITS-1:0] Multiplicando, Multiplicador;
  
  wire [2*BITS:0] Producto;
  wire Q0, Zero;
  wire [2:0] cuenta;
  
  TOP #(.BITS(BITS)) DUT (.Load_Regs(Load_Regs),
                          .Shift_Regs(Shift_Regs), 
                          .Add_Regs(Add_Regs), 
                          .Decr_P(Decr_P), 
                          .clk(clk), 
                          .rst(rst),         
                          .DP_B(Multiplicando), 
                          .DP_Q(Multiplicador),
                          .Producto(Producto),
                          .Q0(Q0),
                          .Zero(Zero),
                          .P(cuenta));

  initial begin
    clk = 0;
  end
  
  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    rst <= 0;
    @(posedge clk)
    rst<=1;
    Multiplicando = 8'b00010111;
    Multiplicador = 8'b00010011;
    Add_Regs <= 0;
    Shift_Regs <= 0;
    Decr_P <= 0;
    Load_Regs <= 1;
    @(posedge clk)
    Load_Regs <= 0;
    @(posedge clk)
    
    
    while(Zero < 1) begin      
      
      if (Q0 == 1) begin
        Add_Regs = 1;
        @(posedge clk)
        Shift_Regs = 1;
        @(posedge clk)
        Add_Regs = 0;
        Shift_Regs = 0;
        Decr_P = 1;
        @(posedge clk)
        Decr_P = 0;
      end
      else begin
        Shift_Regs = 1;
        @(posedge clk)
        Shift_Regs = 0;
        Decr_P = 1;
        @(posedge clk)
        Decr_P = 0;
      end
      
      
    end
    $finish;
  end
  
  initial begin
    $monitor("Producto=%b, Cuenta=%b, Zero=%b", Producto, cuenta, Zero);
  end


    
endmodule