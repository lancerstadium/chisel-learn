module Hello(
  input        clock,
  input        reset,
  output       io_led,
  input  [2:0] io_sw
);
  assign io_led = io_sw[0]; // @[Hello.scala 63:20]
endmodule
