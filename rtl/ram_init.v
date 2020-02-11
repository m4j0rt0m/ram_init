module ram_init
(
  clk_i, addr_i, data_o
);

  localparam CACHE_LINE   = 128;
  localparam CACHE_DEPTH  = 32;
  localparam DATA_WIDTH   = 32;
  localparam ADDR_WIDTH   = $clog2(CACHE_DEPTH);
  localparam N_DATA_LINE  = CACHE_LINE / DATA_WIDTH;

  input                         clk_i;
  input       [ADDR_WIDTH-1:0]  addr_i;
  output reg  [CACHE_LINE-1:0]  data_o;

  integer i, j;

  reg [CACHE_LINE-1:0]  cache_mem [CACHE_DEPTH-1:0];

  initial begin
    for(i=0; i<CACHE_DEPTH; i=i+1) begin
      for(j=0; j<N_DATA_LINE; j=j+1) begin
        cache_mem[i][(j*DATA_WIDTH)+:DATA_WIDTH] = (i*N_DATA_LINE) + j;
      end
    end
  end

  always @ (posedge clk_i) begin
    data_o  <= cache_mem[addr_i];
  end

endmodule // ram_init
