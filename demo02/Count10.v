module Adder(
  input  [7:0] io_b,
  output [7:0] io_y
);
  assign io_y = 8'h1 + io_b; // @[Hello.scala 44:18]
endmodule
module Register(
  input        clock,
  input        reset,
  input  [7:0] io_d,
  output [7:0] io_q
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] reg_; // @[Hello.scala 53:22]
  assign io_q = reg_; // @[Hello.scala 55:10]
  always @(posedge clock) begin
    if (reset) begin // @[Hello.scala 53:22]
      reg_ <= 8'h0; // @[Hello.scala 53:22]
    end else begin
      reg_ <= io_d; // @[Hello.scala 54:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Count10(
  input        clock,
  input        reset,
  output [7:0] io_dout
);
  wire [7:0] add_io_b; // @[Hello.scala 65:21]
  wire [7:0] add_io_y; // @[Hello.scala 65:21]
  wire  reg__clock; // @[Hello.scala 66:21]
  wire  reg__reset; // @[Hello.scala 66:21]
  wire [7:0] reg__io_d; // @[Hello.scala 66:21]
  wire [7:0] reg__io_q; // @[Hello.scala 66:21]
  Adder add ( // @[Hello.scala 65:21]
    .io_b(add_io_b),
    .io_y(add_io_y)
  );
  Register reg_ ( // @[Hello.scala 66:21]
    .clock(reg__clock),
    .reset(reg__reset),
    .io_d(reg__io_d),
    .io_q(reg__io_q)
  );
  assign io_dout = reg__io_q; // @[Hello.scala 80:13]
  assign add_io_b = reg__io_q; // @[Hello.scala 73:14]
  assign reg__clock = clock;
  assign reg__reset = reset;
  assign reg__io_d = reg__io_q == 8'h9 ? 8'h0 : add_io_y; // @[Hello.scala 77:19]
endmodule
