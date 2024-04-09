module SingleFIFO(
  input        clock,
  input        reset,
  input        io_write_write,
  output       io_write_full,
  input  [7:0] io_write_din,
  input        io_read_read,
  output       io_read_empty,
  output [7:0] io_read_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[Hello.scala 30:27]
  reg [7:0] dataReg; // @[Hello.scala 31:26]
  wire  _GEN_0 = io_write_write | stateReg; // @[Hello.scala 34:30 35:22 30:27]
  assign io_write_full = stateReg; // @[Hello.scala 46:32]
  assign io_read_empty = ~stateReg; // @[Hello.scala 47:32]
  assign io_read_dout = dataReg; // @[Hello.scala 48:18]
  always @(posedge clock) begin
    if (reset) begin // @[Hello.scala 30:27]
      stateReg <= 1'h0; // @[Hello.scala 30:27]
    end else if (~stateReg) begin // @[Hello.scala 33:30]
      stateReg <= _GEN_0;
    end else if (stateReg) begin // @[Hello.scala 38:35]
      if (io_read_read) begin // @[Hello.scala 39:28]
        stateReg <= 1'h0; // @[Hello.scala 40:22]
      end
    end
    if (reset) begin // @[Hello.scala 31:26]
      dataReg <= 8'h0; // @[Hello.scala 31:26]
    end else if (~stateReg) begin // @[Hello.scala 33:30]
      if (io_write_write) begin // @[Hello.scala 34:30]
        dataReg <= io_write_din; // @[Hello.scala 36:21]
      end
    end else if (stateReg) begin // @[Hello.scala 38:35]
      if (io_read_read) begin // @[Hello.scala 39:28]
        dataReg <= 8'h0; // @[Hello.scala 41:21]
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
  stateReg = _RAND_0[0:0];
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
module BubbleFIFO(
  input        clock,
  input        reset,
  input        io_write_write,
  output       io_write_full,
  input  [7:0] io_write_din,
  input        io_read_read,
  output       io_read_empty,
  output [7:0] io_read_dout
);
  wire  SingleFIFO_clock; // @[Hello.scala 59:15]
  wire  SingleFIFO_reset; // @[Hello.scala 59:15]
  wire  SingleFIFO_io_write_write; // @[Hello.scala 59:15]
  wire  SingleFIFO_io_write_full; // @[Hello.scala 59:15]
  wire [7:0] SingleFIFO_io_write_din; // @[Hello.scala 59:15]
  wire  SingleFIFO_io_read_read; // @[Hello.scala 59:15]
  wire  SingleFIFO_io_read_empty; // @[Hello.scala 59:15]
  wire [7:0] SingleFIFO_io_read_dout; // @[Hello.scala 59:15]
  wire  SingleFIFO_1_clock; // @[Hello.scala 59:15]
  wire  SingleFIFO_1_reset; // @[Hello.scala 59:15]
  wire  SingleFIFO_1_io_write_write; // @[Hello.scala 59:15]
  wire  SingleFIFO_1_io_write_full; // @[Hello.scala 59:15]
  wire [7:0] SingleFIFO_1_io_write_din; // @[Hello.scala 59:15]
  wire  SingleFIFO_1_io_read_read; // @[Hello.scala 59:15]
  wire  SingleFIFO_1_io_read_empty; // @[Hello.scala 59:15]
  wire [7:0] SingleFIFO_1_io_read_dout; // @[Hello.scala 59:15]
  wire  SingleFIFO_2_clock; // @[Hello.scala 59:15]
  wire  SingleFIFO_2_reset; // @[Hello.scala 59:15]
  wire  SingleFIFO_2_io_write_write; // @[Hello.scala 59:15]
  wire  SingleFIFO_2_io_write_full; // @[Hello.scala 59:15]
  wire [7:0] SingleFIFO_2_io_write_din; // @[Hello.scala 59:15]
  wire  SingleFIFO_2_io_read_read; // @[Hello.scala 59:15]
  wire  SingleFIFO_2_io_read_empty; // @[Hello.scala 59:15]
  wire [7:0] SingleFIFO_2_io_read_dout; // @[Hello.scala 59:15]
  wire  SingleFIFO_3_clock; // @[Hello.scala 59:15]
  wire  SingleFIFO_3_reset; // @[Hello.scala 59:15]
  wire  SingleFIFO_3_io_write_write; // @[Hello.scala 59:15]
  wire  SingleFIFO_3_io_write_full; // @[Hello.scala 59:15]
  wire [7:0] SingleFIFO_3_io_write_din; // @[Hello.scala 59:15]
  wire  SingleFIFO_3_io_read_read; // @[Hello.scala 59:15]
  wire  SingleFIFO_3_io_read_empty; // @[Hello.scala 59:15]
  wire [7:0] SingleFIFO_3_io_read_dout; // @[Hello.scala 59:15]
  wire  SingleFIFO_4_clock; // @[Hello.scala 59:15]
  wire  SingleFIFO_4_reset; // @[Hello.scala 59:15]
  wire  SingleFIFO_4_io_write_write; // @[Hello.scala 59:15]
  wire  SingleFIFO_4_io_write_full; // @[Hello.scala 59:15]
  wire [7:0] SingleFIFO_4_io_write_din; // @[Hello.scala 59:15]
  wire  SingleFIFO_4_io_read_read; // @[Hello.scala 59:15]
  wire  SingleFIFO_4_io_read_empty; // @[Hello.scala 59:15]
  wire [7:0] SingleFIFO_4_io_read_dout; // @[Hello.scala 59:15]
  SingleFIFO SingleFIFO ( // @[Hello.scala 59:15]
    .clock(SingleFIFO_clock),
    .reset(SingleFIFO_reset),
    .io_write_write(SingleFIFO_io_write_write),
    .io_write_full(SingleFIFO_io_write_full),
    .io_write_din(SingleFIFO_io_write_din),
    .io_read_read(SingleFIFO_io_read_read),
    .io_read_empty(SingleFIFO_io_read_empty),
    .io_read_dout(SingleFIFO_io_read_dout)
  );
  SingleFIFO SingleFIFO_1 ( // @[Hello.scala 59:15]
    .clock(SingleFIFO_1_clock),
    .reset(SingleFIFO_1_reset),
    .io_write_write(SingleFIFO_1_io_write_write),
    .io_write_full(SingleFIFO_1_io_write_full),
    .io_write_din(SingleFIFO_1_io_write_din),
    .io_read_read(SingleFIFO_1_io_read_read),
    .io_read_empty(SingleFIFO_1_io_read_empty),
    .io_read_dout(SingleFIFO_1_io_read_dout)
  );
  SingleFIFO SingleFIFO_2 ( // @[Hello.scala 59:15]
    .clock(SingleFIFO_2_clock),
    .reset(SingleFIFO_2_reset),
    .io_write_write(SingleFIFO_2_io_write_write),
    .io_write_full(SingleFIFO_2_io_write_full),
    .io_write_din(SingleFIFO_2_io_write_din),
    .io_read_read(SingleFIFO_2_io_read_read),
    .io_read_empty(SingleFIFO_2_io_read_empty),
    .io_read_dout(SingleFIFO_2_io_read_dout)
  );
  SingleFIFO SingleFIFO_3 ( // @[Hello.scala 59:15]
    .clock(SingleFIFO_3_clock),
    .reset(SingleFIFO_3_reset),
    .io_write_write(SingleFIFO_3_io_write_write),
    .io_write_full(SingleFIFO_3_io_write_full),
    .io_write_din(SingleFIFO_3_io_write_din),
    .io_read_read(SingleFIFO_3_io_read_read),
    .io_read_empty(SingleFIFO_3_io_read_empty),
    .io_read_dout(SingleFIFO_3_io_read_dout)
  );
  SingleFIFO SingleFIFO_4 ( // @[Hello.scala 59:15]
    .clock(SingleFIFO_4_clock),
    .reset(SingleFIFO_4_reset),
    .io_write_write(SingleFIFO_4_io_write_write),
    .io_write_full(SingleFIFO_4_io_write_full),
    .io_write_din(SingleFIFO_4_io_write_din),
    .io_read_read(SingleFIFO_4_io_read_read),
    .io_read_empty(SingleFIFO_4_io_read_empty),
    .io_read_dout(SingleFIFO_4_io_read_dout)
  );
  assign io_write_full = SingleFIFO_io_write_full; // @[Hello.scala 68:14]
  assign io_read_empty = SingleFIFO_4_io_read_empty; // @[Hello.scala 69:13]
  assign io_read_dout = SingleFIFO_4_io_read_dout; // @[Hello.scala 69:13]
  assign SingleFIFO_clock = clock;
  assign SingleFIFO_reset = reset;
  assign SingleFIFO_io_write_write = io_write_write; // @[Hello.scala 68:14]
  assign SingleFIFO_io_write_din = io_write_din; // @[Hello.scala 68:14]
  assign SingleFIFO_io_read_read = ~SingleFIFO_1_io_write_full; // @[Hello.scala 65:36]
  assign SingleFIFO_1_clock = clock;
  assign SingleFIFO_1_reset = reset;
  assign SingleFIFO_1_io_write_write = SingleFIFO_io_read_read; // @[Hello.scala 64:39]
  assign SingleFIFO_1_io_write_din = SingleFIFO_io_read_dout; // @[Hello.scala 63:37]
  assign SingleFIFO_1_io_read_read = ~SingleFIFO_2_io_write_full; // @[Hello.scala 65:36]
  assign SingleFIFO_2_clock = clock;
  assign SingleFIFO_2_reset = reset;
  assign SingleFIFO_2_io_write_write = SingleFIFO_1_io_read_read; // @[Hello.scala 64:39]
  assign SingleFIFO_2_io_write_din = SingleFIFO_1_io_read_dout; // @[Hello.scala 63:37]
  assign SingleFIFO_2_io_read_read = ~SingleFIFO_3_io_write_full; // @[Hello.scala 65:36]
  assign SingleFIFO_3_clock = clock;
  assign SingleFIFO_3_reset = reset;
  assign SingleFIFO_3_io_write_write = SingleFIFO_2_io_read_read; // @[Hello.scala 64:39]
  assign SingleFIFO_3_io_write_din = SingleFIFO_2_io_read_dout; // @[Hello.scala 63:37]
  assign SingleFIFO_3_io_read_read = ~SingleFIFO_4_io_write_full; // @[Hello.scala 65:36]
  assign SingleFIFO_4_clock = clock;
  assign SingleFIFO_4_reset = reset;
  assign SingleFIFO_4_io_write_write = SingleFIFO_3_io_read_read; // @[Hello.scala 64:39]
  assign SingleFIFO_4_io_write_din = SingleFIFO_3_io_read_dout; // @[Hello.scala 63:37]
  assign SingleFIFO_4_io_read_read = io_read_read; // @[Hello.scala 69:13]
endmodule
