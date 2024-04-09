module Buffer(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  fullReg; // @[Hello.scala 23:30]
  reg [7:0] dataReg; // @[Hello.scala 24:26]
  wire  _GEN_1 = io_enq_valid | fullReg; // @[Hello.scala 31:33 32:25 23:30]
  assign io_enq_ready = ~fullReg; // @[Hello.scala 37:25]
  assign io_deq_valid = fullReg; // @[Hello.scala 38:22]
  assign io_deq_bits = dataReg; // @[Hello.scala 39:21]
  always @(posedge clock) begin
    if (reset) begin // @[Hello.scala 23:30]
      fullReg <= 1'h0; // @[Hello.scala 23:30]
    end else if (fullReg) begin // @[Hello.scala 26:24]
      if (io_deq_ready) begin // @[Hello.scala 27:33]
        fullReg <= 1'h0; // @[Hello.scala 28:25]
      end
    end else begin
      fullReg <= _GEN_1;
    end
    if (!(fullReg)) begin // @[Hello.scala 26:24]
      if (io_enq_valid) begin // @[Hello.scala 31:33]
        dataReg <= io_enq_bits; // @[Hello.scala 33:25]
      end
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
  fullReg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BubbleFifo(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
  wire  Buffer_clock; // @[Hello.scala 44:15]
  wire  Buffer_reset; // @[Hello.scala 44:15]
  wire  Buffer_io_enq_ready; // @[Hello.scala 44:15]
  wire  Buffer_io_enq_valid; // @[Hello.scala 44:15]
  wire [7:0] Buffer_io_enq_bits; // @[Hello.scala 44:15]
  wire  Buffer_io_deq_ready; // @[Hello.scala 44:15]
  wire  Buffer_io_deq_valid; // @[Hello.scala 44:15]
  wire [7:0] Buffer_io_deq_bits; // @[Hello.scala 44:15]
  wire  Buffer_1_clock; // @[Hello.scala 44:15]
  wire  Buffer_1_reset; // @[Hello.scala 44:15]
  wire  Buffer_1_io_enq_ready; // @[Hello.scala 44:15]
  wire  Buffer_1_io_enq_valid; // @[Hello.scala 44:15]
  wire [7:0] Buffer_1_io_enq_bits; // @[Hello.scala 44:15]
  wire  Buffer_1_io_deq_ready; // @[Hello.scala 44:15]
  wire  Buffer_1_io_deq_valid; // @[Hello.scala 44:15]
  wire [7:0] Buffer_1_io_deq_bits; // @[Hello.scala 44:15]
  wire  Buffer_2_clock; // @[Hello.scala 44:15]
  wire  Buffer_2_reset; // @[Hello.scala 44:15]
  wire  Buffer_2_io_enq_ready; // @[Hello.scala 44:15]
  wire  Buffer_2_io_enq_valid; // @[Hello.scala 44:15]
  wire [7:0] Buffer_2_io_enq_bits; // @[Hello.scala 44:15]
  wire  Buffer_2_io_deq_ready; // @[Hello.scala 44:15]
  wire  Buffer_2_io_deq_valid; // @[Hello.scala 44:15]
  wire [7:0] Buffer_2_io_deq_bits; // @[Hello.scala 44:15]
  Buffer Buffer ( // @[Hello.scala 44:15]
    .clock(Buffer_clock),
    .reset(Buffer_reset),
    .io_enq_ready(Buffer_io_enq_ready),
    .io_enq_valid(Buffer_io_enq_valid),
    .io_enq_bits(Buffer_io_enq_bits),
    .io_deq_ready(Buffer_io_deq_ready),
    .io_deq_valid(Buffer_io_deq_valid),
    .io_deq_bits(Buffer_io_deq_bits)
  );
  Buffer Buffer_1 ( // @[Hello.scala 44:15]
    .clock(Buffer_1_clock),
    .reset(Buffer_1_reset),
    .io_enq_ready(Buffer_1_io_enq_ready),
    .io_enq_valid(Buffer_1_io_enq_valid),
    .io_enq_bits(Buffer_1_io_enq_bits),
    .io_deq_ready(Buffer_1_io_deq_ready),
    .io_deq_valid(Buffer_1_io_deq_valid),
    .io_deq_bits(Buffer_1_io_deq_bits)
  );
  Buffer Buffer_2 ( // @[Hello.scala 44:15]
    .clock(Buffer_2_clock),
    .reset(Buffer_2_reset),
    .io_enq_ready(Buffer_2_io_enq_ready),
    .io_enq_valid(Buffer_2_io_enq_valid),
    .io_enq_bits(Buffer_2_io_enq_bits),
    .io_deq_ready(Buffer_2_io_deq_ready),
    .io_deq_valid(Buffer_2_io_deq_valid),
    .io_deq_bits(Buffer_2_io_deq_bits)
  );
  assign io_enq_ready = Buffer_io_enq_ready; // @[Hello.scala 50:12]
  assign io_deq_valid = Buffer_2_io_deq_valid; // @[Hello.scala 51:12]
  assign io_deq_bits = Buffer_2_io_deq_bits; // @[Hello.scala 51:12]
  assign Buffer_clock = clock;
  assign Buffer_reset = reset;
  assign Buffer_io_enq_valid = io_enq_valid; // @[Hello.scala 50:12]
  assign Buffer_io_enq_bits = io_enq_bits; // @[Hello.scala 50:12]
  assign Buffer_io_deq_ready = Buffer_1_io_enq_ready; // @[Hello.scala 47:31]
  assign Buffer_1_clock = clock;
  assign Buffer_1_reset = reset;
  assign Buffer_1_io_enq_valid = Buffer_io_deq_valid; // @[Hello.scala 47:31]
  assign Buffer_1_io_enq_bits = Buffer_io_deq_bits; // @[Hello.scala 47:31]
  assign Buffer_1_io_deq_ready = Buffer_2_io_enq_ready; // @[Hello.scala 47:31]
  assign Buffer_2_clock = clock;
  assign Buffer_2_reset = reset;
  assign Buffer_2_io_enq_valid = Buffer_1_io_deq_valid; // @[Hello.scala 47:31]
  assign Buffer_2_io_enq_bits = Buffer_1_io_deq_bits; // @[Hello.scala 47:31]
  assign Buffer_2_io_deq_ready = io_deq_ready; // @[Hello.scala 51:12]
endmodule
