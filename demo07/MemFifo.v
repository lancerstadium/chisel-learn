module MemFifo(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem [0:2]; // @[Hello.scala 162:26]
  wire  mem_data_en; // @[Hello.scala 162:26]
  wire [1:0] mem_data_addr; // @[Hello.scala 162:26]
  wire [7:0] mem_data_data; // @[Hello.scala 162:26]
  wire [7:0] mem_MPORT_data; // @[Hello.scala 162:26]
  wire [1:0] mem_MPORT_addr; // @[Hello.scala 162:26]
  wire  mem_MPORT_mask; // @[Hello.scala 162:26]
  wire  mem_MPORT_en; // @[Hello.scala 162:26]
  reg  mem_data_en_pipe_0;
  reg [1:0] mem_data_addr_pipe_0;
  reg [1:0] readPtr; // @[Hello.scala 154:29]
  wire [1:0] _nextVal_T_2 = readPtr + 2'h1; // @[Hello.scala 155:63]
  wire [1:0] nextRead = readPtr == 2'h2 ? 2'h0 : _nextVal_T_2; // @[Hello.scala 155:26]
  reg [1:0] stateReg; // @[Hello.scala 174:27]
  reg  emptyReg; // @[Hello.scala 169:27]
  wire  _T_3 = ~emptyReg; // @[Hello.scala 189:18]
  wire  _GEN_24 = io_deq_ready & _T_3; // @[Hello.scala 197:32]
  wire  _GEN_41 = 2'h1 == stateReg ? _GEN_24 : 2'h2 == stateReg & _GEN_24; // @[Hello.scala 187:22]
  wire  incrRead = 2'h0 == stateReg ? _T_3 : _GEN_41; // @[Hello.scala 187:22]
  reg [1:0] writePtr; // @[Hello.scala 154:29]
  wire [1:0] _nextVal_T_5 = writePtr + 2'h1; // @[Hello.scala 155:63]
  wire [1:0] nextWrite = writePtr == 2'h2 ? 2'h0 : _nextVal_T_5; // @[Hello.scala 155:26]
  reg  fullReg; // @[Hello.scala 170:26]
  wire  _T = ~fullReg; // @[Hello.scala 178:26]
  wire  incrWrite = io_enq_valid & ~fullReg; // @[Hello.scala 178:23]
  reg [7:0] shadowReg; // @[Hello.scala 175:24]
  wire  _GEN_7 = incrWrite ? 1'h0 : emptyReg; // @[Hello.scala 178:36 180:18 169:27]
  wire  _GEN_8 = incrWrite ? nextWrite == readPtr : fullReg; // @[Hello.scala 178:36 181:17 170:26]
  wire  _GEN_14 = ~emptyReg ? 1'h0 : _GEN_8; // @[Hello.scala 189:29 191:25]
  wire  _GEN_15 = ~emptyReg ? nextRead == writePtr : _GEN_7; // @[Hello.scala 189:29 192:26]
  wire [1:0] _GEN_17 = _T_3 ? 2'h1 : 2'h0; // @[Hello.scala 198:33 199:30 204:30]
  wire  _GEN_22 = io_deq_ready ? _GEN_14 : _GEN_8; // @[Hello.scala 197:32]
  wire  _GEN_23 = io_deq_ready ? _GEN_15 : _GEN_7; // @[Hello.scala 197:32]
  wire [1:0] _GEN_30 = io_deq_ready ? _GEN_17 : stateReg; // @[Hello.scala 174:27 212:32]
  wire  _GEN_36 = 2'h2 == stateReg ? _GEN_23 : _GEN_7; // @[Hello.scala 187:22]
  wire  _GEN_40 = 2'h1 == stateReg ? _GEN_23 : _GEN_36; // @[Hello.scala 187:22]
  wire  _GEN_45 = 2'h0 == stateReg ? _GEN_15 : _GEN_40; // @[Hello.scala 187:22]
  wire  _io_deq_bits_T = stateReg == 2'h1; // @[Hello.scala 225:33]
  assign mem_data_en = mem_data_en_pipe_0;
  assign mem_data_addr = mem_data_addr_pipe_0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign mem_data_data = mem[mem_data_addr]; // @[Hello.scala 162:26]
  `else
  assign mem_data_data = mem_data_addr >= 2'h3 ? _RAND_1[7:0] : mem[mem_data_addr]; // @[Hello.scala 162:26]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign mem_MPORT_data = io_enq_bits;
  assign mem_MPORT_addr = writePtr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_enq_valid & _T;
  assign io_enq_ready = ~fullReg; // @[Hello.scala 226:21]
  assign io_deq_valid = _io_deq_bits_T | stateReg == 2'h2; // @[Hello.scala 227:40]
  assign io_deq_bits = stateReg == 2'h1 ? mem_data_data : shadowReg; // @[Hello.scala 225:23]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[Hello.scala 162:26]
    end
    mem_data_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_data_addr_pipe_0 <= readPtr;
    end
    if (reset) begin // @[Hello.scala 154:29]
      readPtr <= 2'h0; // @[Hello.scala 154:29]
    end else if (incrRead) begin // @[Hello.scala 156:20]
      if (readPtr == 2'h2) begin // @[Hello.scala 155:26]
        readPtr <= 2'h0;
      end else begin
        readPtr <= _nextVal_T_2;
      end
    end
    if (reset) begin // @[Hello.scala 174:27]
      stateReg <= 2'h0; // @[Hello.scala 174:27]
    end else if (2'h0 == stateReg) begin // @[Hello.scala 187:22]
      if (~emptyReg) begin // @[Hello.scala 189:29]
        stateReg <= 2'h1; // @[Hello.scala 190:26]
      end
    end else if (2'h1 == stateReg) begin // @[Hello.scala 187:22]
      if (io_deq_ready) begin // @[Hello.scala 197:32]
        stateReg <= _GEN_17;
      end else begin
        stateReg <= 2'h2; // @[Hello.scala 208:26]
      end
    end else if (2'h2 == stateReg) begin // @[Hello.scala 187:22]
      stateReg <= _GEN_30;
    end
    emptyReg <= reset | _GEN_45; // @[Hello.scala 169:{27,27}]
    if (reset) begin // @[Hello.scala 154:29]
      writePtr <= 2'h0; // @[Hello.scala 154:29]
    end else if (incrWrite) begin // @[Hello.scala 156:20]
      if (writePtr == 2'h2) begin // @[Hello.scala 155:26]
        writePtr <= 2'h0;
      end else begin
        writePtr <= _nextVal_T_5;
      end
    end
    if (reset) begin // @[Hello.scala 170:26]
      fullReg <= 1'h0; // @[Hello.scala 170:26]
    end else if (2'h0 == stateReg) begin // @[Hello.scala 187:22]
      fullReg <= _GEN_14;
    end else if (2'h1 == stateReg) begin // @[Hello.scala 187:22]
      fullReg <= _GEN_22;
    end else if (2'h2 == stateReg) begin // @[Hello.scala 187:22]
      fullReg <= _GEN_22;
    end else begin
      fullReg <= _GEN_8;
    end
    if (!(2'h0 == stateReg)) begin // @[Hello.scala 187:22]
      if (2'h1 == stateReg) begin // @[Hello.scala 187:22]
        if (!(io_deq_ready)) begin // @[Hello.scala 197:32]
          shadowReg <= mem_data_data; // @[Hello.scala 207:27]
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
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_1 = {1{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    mem[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  mem_data_en_pipe_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  mem_data_addr_pipe_0 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  readPtr = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  stateReg = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  emptyReg = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  writePtr = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  fullReg = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  shadowReg = _RAND_9[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
