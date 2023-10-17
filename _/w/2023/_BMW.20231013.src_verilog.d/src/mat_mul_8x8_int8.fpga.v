module int8_8x8_matrix_multiplication (
  input clk,
  input reset,
  input [7:0] a_matrix[7:0],
  input [7:0] b_matrix[7:0],
  output [7:0] c_matrix[7:0]
);

  // Registers to store the input matrices
  reg [7:0] a_reg[7:0];
  reg [7:0] b_reg[7:0];

  // Registers to store the intermediate product
  reg [15:0] product_reg[7:0];

  // Registers to store the output matrix
  reg [7:0] c_reg[7:0];

  // Always block to store the input matrices in registers
  always @(posedge clk) begin
    if (reset) begin
      for (integer i = 0; i < 8; i = i + 1) begin
        a_reg[i] <= 0;
        b_reg[i] <= 0;
      end
    end else begin
      for (integer i = 0; i < 8; i = i + 1) begin
        a_reg[i] <= a_matrix[i];
        b_reg[i] <= b_matrix[i];
      end
    end
  end

  // Always block to calculate the intermediate product
  always @(posedge clk) begin
    if (reset) begin
      for (integer i = 0; i < 8; i = i + 1) begin
        product_reg[i] <= 0;
      end
    end else begin
      for (integer i = 0; i < 8; i = i + 1) begin
        product_reg[i] <= a_reg[i] * b_reg[i];
      end
    end
  end

  // Always block to calculate the output matrix
  always @(posedge clk) begin
    if (reset) begin
      for (integer i = 0; i < 8; i = i + 1) begin
        c_reg[i] <= 0;
      end
    end else begin
      for (integer i = 0; i < 8; i = i + 1) begin
        c_reg[i] <= product_reg[i][15:8];
      end
    end
  end

  // Assign the output matrix to the output pins
  assign c_matrix = c_reg;

endmodule
