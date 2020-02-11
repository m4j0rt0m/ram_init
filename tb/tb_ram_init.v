module tb_ram_init ();

  /* local parameters */
  localparam CACHE_LINE   = 128;
  localparam CACHE_DEPTH  = 32;
  localparam ADDR_WIDTH   = $clog2(CACHE_DEPTH);

  /* sim regs n wires */
  reg                     clk_i;
  reg   [ADDR_WIDTH-1:0]  addr_i;
  wire  [CACHE_LINE-1:0]  data_o;

  /* integers */
  integer i;

  /* initial values */
  initial begin
    clk_i   = 0;
    addr_i  = 0;
    $dumpfile("ram_init.vcd");
    $dumpvars();
    for(i=0; i<CACHE_DEPTH; i=i+1) $dumpvars(1, dut.cache_mem[i]);
    #1000 $finish;
  end

  /* clock */
  always begin
    #1  clk_i = ~clk_i;
  end

  /* simulation */
  always @ (negedge clk_i) begin
    addr_i  <=  addr_i + 1;
  end

  /* dut */
  ram_init
    dut (
        .clk_i  (clk_i),
        .addr_i (addr_i),
        .data_o (data_o)
      );

endmodule // tb_ram_init
