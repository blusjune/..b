module test;
  reg reset = 0;
  initial begin
     # 17 reset = 1;
     # 11 reset = 0;
     # 29 reset = 1;
     # 11 reset = 0;
     # 1000 $stop;
  end
  reg value = 0;
  initial begin
    forever begin
      # 10 $display("value: %h   reset: %h", value, reset);
      value = value + 1;
    end
  end
endmodule
