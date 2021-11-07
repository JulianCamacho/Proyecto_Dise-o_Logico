// Code your testbench here
// or browse Examples



`timescale 1ns/1ps

module testbench;
  
  parameter BITS = 8;
  
  reg Load_Regs, Shift_Regs, Add_Regs, Decr_P, Start;
  reg clk, rst;
  reg [BITS-1:0] Multiplicando, Multiplicador;
  reg C5,C6;
  
  wire [2*BITS:0] Producto;
  wire Q0, Zero, Ready, S5, S6, S7;
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
  
  Controlador DUT2 (
                    .clk(clk),
                    .rst(rst),
    				.Condicion1(Start),
                    .Condicion2(Q0),
                    .Condicion3(Zero),
    				.Condicion4(~rst),
                    .Condicion5(C5),
                    .Condicion6(C6),
                    .salida0(Decr_P),
                    .salida1(Add_Regs),
                    .salida2(Shift_Regs),
                    .salida3(Load_Regs),
    				.salida4(Ready),
                    .salida5(S5),
                    .salida6(S6),
                    .salida7(S7)
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
    C5 <= 0; 
    C6 <= 0;
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
    $monitor("Producto=%b, Cuenta=%b, Q[0]=%b, Zero=%b, Ready=%b", Producto, cuenta, Q0, Zero, Ready);
  end


    
endmodule
