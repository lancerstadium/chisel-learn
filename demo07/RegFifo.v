module RegFifo(
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
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] memReg_0; // @[Hello.scala 120:21]
  reg [7:0] memReg_1; // @[Hello.scala 120:21]
  reg [7:0] memReg_2; // @[Hello.scala 120:21]
  reg [1:0] readPtr; // @[Hello.scala 112:29]
  wire [1:0] _nextVal_T_2 = readPtr + 2'h1; // @[Hello.scala 113:63]
  wire [1:0] nextRead = readPtr == 2'h2 ? 2'h0 : _nextVal_T_2; // @[Hello.scala 113:26]
  reg  emptyReg; // @[Hello.scala 127:27]
  wire  incrRead = io_deq_ready & ~emptyReg; // @[Hello.scala 139:23]
  reg [1:0] writePtr; // @[Hello.scala 112:29]
  wire [1:0] _nextVal_T_5 = writePtr + 2'h1; // @[Hello.scala 113:63]
  wire [1:0] nextWrite = writePtr == 2'h2 ? 2'h0 : _nextVal_T_5; // @[Hello.scala 113:26]
  reg  fullReg; // @[Hello.scala 128:26]
  wire  incrWrite = io_enq_valid & ~fullReg; // @[Hello.scala 131:23]
  wire  _GEN_8 = incrWrite ? 1'h0 : emptyReg; // @[Hello.scala 131:36 133:18 127:27]
  wire  _GEN_12 = incrRead ? nextRead == writePtr : _GEN_8; // @[Hello.scala 139:37 141:18]
  wire [7:0] _GEN_15 = 2'h1 == readPtr ? memReg_1 : memReg_0; // @[Hello.scala 145:{17,17}]
  assign io_enq_ready = ~fullReg; // @[Hello.scala 146:21]
  assign io_deq_valid = ~emptyReg; // @[Hello.scala 147:21]
  assign io_deq_bits = 2'h2 == readPtr ? memReg_2 : _GEN_15; // @[Hello.scala 145:{17,17}]
  always @(posedge clock) begin
    if (incrWrite) begin // @[Hello.scala 131:36]
      if (2'h0 == writePtr) begin // @[Hello.scala 132:26]
        memReg_0 <= io_enq_bits; // @[Hello.scala 132:26]
      end
    end
    if (incrWrite) begin // @[Hello.scala 131:36]
      if (2'h1 == writePtr) begin // @[Hello.scala 132:26]
        memReg_1 <= io_enq_bits; // @[Hello.scala 132:26]
      end
    end
    if (incrWrite) begin // @[Hello.scala 131:36]
      if (2'h2 == writePtr) begin // @[Hello.scala 132:26]
        memReg_2 <= io_enq_bits; // @[Hello.scala 132:26]
      end
    end
    if (reset) begin // @[Hello.scala 112:29]
      readPtr <= 2'h0; // @[Hello.scala 112:29]
    end else if (incrRead) begin // @[Hello.scala 114:20]
      if (readPtr == 2'h2) begin // @[Hello.scala 113:26]
        readPtr <= 2'h0;
      end else begin
        readPtr <= _nextVal_T_2;
      end
    end
    emptyReg <= reset | _GEN_12; // @[Hello.scala 127:{27,27}]
    if (reset) begin // @[Hello.scala 112:29]
      writePtr <= 2'h0; // @[Hello.scala 112:29]
    end else if (incrWrite) begin // @[Hello.scala 114:20]
      if (writePtr == 2'h2) begin // @[Hello.scala 113:26]
        writePtr <= 2'h0;
      end else begin
        writePtr <= _nextVal_T_5;
      end
    end
    if (reset) begin // @[Hello.scala 128:26]
      fullReg <= 1'h0; // @[Hello.scala 128:26]
    end else if (incrRead) begin // @[Hello.scala 139:37]
      fullReg <= 1'h0; // @[Hello.scala 140:17]
    end else if (incrWrite) begin // @[Hello.scala 131:36]
      fullReg <= nextWrite == readPtr; // @[Hello.scala 134:17]
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
  memReg_0 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  memReg_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  memReg_2 = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  readPtr = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  emptyReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  writePtr = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  fullReg = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
