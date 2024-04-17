module Seg7(
  input        clock,
  input        reset,
  input  [3:0] io_sw,
  output [6:0] io_segOut
);
  wire [6:0] _GEN_0 = 4'hf == io_sw ? 7'he : 7'h7f; // @[Hello.scala 11:15 13:19 29:36]
  wire [6:0] _GEN_1 = 4'he == io_sw ? 7'h6 : _GEN_0; // @[Hello.scala 13:19 28:36]
  wire [6:0] _GEN_2 = 4'hd == io_sw ? 7'h21 : _GEN_1; // @[Hello.scala 13:19 27:36]
  wire [6:0] _GEN_3 = 4'hc == io_sw ? 7'h27 : _GEN_2; // @[Hello.scala 13:19 26:36]
  wire [6:0] _GEN_4 = 4'hb == io_sw ? 7'h3 : _GEN_3; // @[Hello.scala 13:19 25:36]
  wire [6:0] _GEN_5 = 4'ha == io_sw ? 7'h8 : _GEN_4; // @[Hello.scala 13:19 24:36]
  wire [6:0] _GEN_6 = 4'h9 == io_sw ? 7'h10 : _GEN_5; // @[Hello.scala 13:19 23:36]
  wire [6:0] _GEN_7 = 4'h8 == io_sw ? 7'h0 : _GEN_6; // @[Hello.scala 13:19 22:36]
  wire [6:0] _GEN_8 = 4'h7 == io_sw ? 7'h78 : _GEN_7; // @[Hello.scala 13:19 21:36]
  wire [6:0] _GEN_9 = 4'h6 == io_sw ? 7'h2 : _GEN_8; // @[Hello.scala 13:19 20:36]
  wire [6:0] _GEN_10 = 4'h5 == io_sw ? 7'h12 : _GEN_9; // @[Hello.scala 13:19 19:36]
  wire [6:0] _GEN_11 = 4'h4 == io_sw ? 7'h19 : _GEN_10; // @[Hello.scala 13:19 18:36]
  wire [6:0] _GEN_12 = 4'h3 == io_sw ? 7'h30 : _GEN_11; // @[Hello.scala 13:19 17:36]
  wire [6:0] _GEN_13 = 4'h2 == io_sw ? 7'h24 : _GEN_12; // @[Hello.scala 13:19 16:36]
  wire [6:0] _GEN_14 = 4'h1 == io_sw ? 7'h79 : _GEN_13; // @[Hello.scala 13:19 15:36]
  assign io_segOut = 4'h0 == io_sw ? 7'h40 : _GEN_14; // @[Hello.scala 13:19 14:36]
endmodule
