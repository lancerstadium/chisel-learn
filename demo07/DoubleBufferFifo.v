module DoubleBuffer(
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
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] stateReg; // @[Hello.scala 60:31]
  reg [7:0] dataReg; // @[Hello.scala 61:26]
  reg [7:0] shadowReg; // @[Hello.scala 62:28]
  wire  _T_3 = io_deq_ready & ~io_enq_valid; // @[Hello.scala 72:35]
  wire [1:0] _GEN_2 = io_deq_ready & ~io_enq_valid ? 2'h0 : stateReg; // @[Hello.scala 72:53 73:30 60:31]
  wire [1:0] _GEN_3 = io_deq_ready & io_enq_valid ? 2'h1 : _GEN_2; // @[Hello.scala 75:52 76:30]
  wire [1:0] _GEN_7 = _T_3 ? 2'h1 : stateReg; // @[Hello.scala 85:53 86:30 60:31]
  wire  _io_enq_ready_T_1 = stateReg == 2'h1; // @[Hello.scala 92:57]
  assign io_enq_ready = stateReg == 2'h0 | stateReg == 2'h1; // @[Hello.scala 92:45]
  assign io_deq_valid = _io_enq_ready_T_1 | stateReg == 2'h2; // @[Hello.scala 93:43]
  assign io_deq_bits = dataReg; // @[Hello.scala 94:21]
  always @(posedge clock) begin
    if (reset) begin // @[Hello.scala 60:31]
      stateReg <= 2'h0; // @[Hello.scala 60:31]
    end else if (2'h0 == stateReg) begin // @[Hello.scala 64:27]
      if (io_enq_valid) begin // @[Hello.scala 66:36]
        stateReg <= 2'h1; // @[Hello.scala 67:30]
      end
    end else if (2'h1 == stateReg) begin // @[Hello.scala 64:27]
      if (~io_deq_ready & io_enq_valid) begin // @[Hello.scala 79:53]
        stateReg <= 2'h2; // @[Hello.scala 80:30]
      end else begin
        stateReg <= _GEN_3;
      end
    end else if (2'h2 == stateReg) begin // @[Hello.scala 64:27]
      stateReg <= _GEN_7;
    end
    if (2'h0 == stateReg) begin // @[Hello.scala 64:27]
      if (io_enq_valid) begin // @[Hello.scala 66:36]
        dataReg <= io_enq_bits; // @[Hello.scala 68:29]
      end
    end else if (2'h1 == stateReg) begin // @[Hello.scala 64:27]
      if (io_deq_ready & io_enq_valid) begin // @[Hello.scala 75:52]
        dataReg <= io_enq_bits; // @[Hello.scala 77:29]
      end
    end else if (2'h2 == stateReg) begin // @[Hello.scala 64:27]
      if (_T_3) begin // @[Hello.scala 85:53]
        dataReg <= shadowReg; // @[Hello.scala 87:29]
      end
    end
    if (!(2'h0 == stateReg)) begin // @[Hello.scala 64:27]
      if (2'h1 == stateReg) begin // @[Hello.scala 64:27]
        if (~io_deq_ready & io_enq_valid) begin // @[Hello.scala 79:53]
          shadowReg <= io_enq_bits; // @[Hello.scala 81:31]
        end
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
  stateReg = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  shadowReg = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DoubleBufferFifo(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
  wire  DoubleBuffer_clock; // @[Hello.scala 98:15]
  wire  DoubleBuffer_reset; // @[Hello.scala 98:15]
  wire  DoubleBuffer_io_enq_ready; // @[Hello.scala 98:15]
  wire  DoubleBuffer_io_enq_valid; // @[Hello.scala 98:15]
  wire [7:0] DoubleBuffer_io_enq_bits; // @[Hello.scala 98:15]
  wire  DoubleBuffer_io_deq_ready; // @[Hello.scala 98:15]
  wire  DoubleBuffer_io_deq_valid; // @[Hello.scala 98:15]
  wire [7:0] DoubleBuffer_io_deq_bits; // @[Hello.scala 98:15]
  wire  DoubleBuffer_1_clock; // @[Hello.scala 98:15]
  wire  DoubleBuffer_1_reset; // @[Hello.scala 98:15]
  wire  DoubleBuffer_1_io_enq_ready; // @[Hello.scala 98:15]
  wire  DoubleBuffer_1_io_enq_valid; // @[Hello.scala 98:15]
  wire [7:0] DoubleBuffer_1_io_enq_bits; // @[Hello.scala 98:15]
  wire  DoubleBuffer_1_io_deq_ready; // @[Hello.scala 98:15]
  wire  DoubleBuffer_1_io_deq_valid; // @[Hello.scala 98:15]
  wire [7:0] DoubleBuffer_1_io_deq_bits; // @[Hello.scala 98:15]
  DoubleBuffer DoubleBuffer ( // @[Hello.scala 98:15]
    .clock(DoubleBuffer_clock),
    .reset(DoubleBuffer_reset),
    .io_enq_ready(DoubleBuffer_io_enq_ready),
    .io_enq_valid(DoubleBuffer_io_enq_valid),
    .io_enq_bits(DoubleBuffer_io_enq_bits),
    .io_deq_ready(DoubleBuffer_io_deq_ready),
    .io_deq_valid(DoubleBuffer_io_deq_valid),
    .io_deq_bits(DoubleBuffer_io_deq_bits)
  );
  DoubleBuffer DoubleBuffer_1 ( // @[Hello.scala 98:15]
    .clock(DoubleBuffer_1_clock),
    .reset(DoubleBuffer_1_reset),
    .io_enq_ready(DoubleBuffer_1_io_enq_ready),
    .io_enq_valid(DoubleBuffer_1_io_enq_valid),
    .io_enq_bits(DoubleBuffer_1_io_enq_bits),
    .io_deq_ready(DoubleBuffer_1_io_deq_ready),
    .io_deq_valid(DoubleBuffer_1_io_deq_valid),
    .io_deq_bits(DoubleBuffer_1_io_deq_bits)
  );
  assign io_enq_ready = DoubleBuffer_io_enq_ready; // @[Hello.scala 104:12]
  assign io_deq_valid = DoubleBuffer_1_io_deq_valid; // @[Hello.scala 105:12]
  assign io_deq_bits = DoubleBuffer_1_io_deq_bits; // @[Hello.scala 105:12]
  assign DoubleBuffer_clock = clock;
  assign DoubleBuffer_reset = reset;
  assign DoubleBuffer_io_enq_valid = io_enq_valid; // @[Hello.scala 104:12]
  assign DoubleBuffer_io_enq_bits = io_enq_bits; // @[Hello.scala 104:12]
  assign DoubleBuffer_io_deq_ready = DoubleBuffer_1_io_enq_ready; // @[Hello.scala 101:31]
  assign DoubleBuffer_1_clock = clock;
  assign DoubleBuffer_1_reset = reset;
  assign DoubleBuffer_1_io_enq_valid = DoubleBuffer_io_deq_valid; // @[Hello.scala 101:31]
  assign DoubleBuffer_1_io_enq_bits = DoubleBuffer_io_deq_bits; // @[Hello.scala 101:31]
  assign DoubleBuffer_1_io_deq_ready = io_deq_ready; // @[Hello.scala 105:12]
endmodule
