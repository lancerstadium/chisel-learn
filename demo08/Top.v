module PCReg(
  input         clock,
  input         reset,
  output [31:0] io_addrOut,
  input         io_ctrlJump,
  input         io_ctrlBranch,
  input         io_resultBranch,
  input  [31:0] io_addrTarget
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regPC; // @[PCReg.scala 29:24]
  wire [31:0] _regPC_T_1 = regPC + 32'h4; // @[PCReg.scala 36:24]
  assign io_addrOut = regPC; // @[PCReg.scala 39:16]
  always @(posedge clock) begin
    if (reset) begin // @[PCReg.scala 29:24]
      regPC <= 32'h0; // @[PCReg.scala 29:24]
    end else if (io_ctrlJump | io_ctrlBranch & io_resultBranch) begin // @[PCReg.scala 31:62]
      regPC <= io_addrTarget; // @[PCReg.scala 33:15]
    end else begin
      regPC <= _regPC_T_1; // @[PCReg.scala 36:15]
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
  regPC = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MemInst(
  input         clock,
  input  [31:0] io_addr,
  output [31:0] io_inst
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] mem [0:1023]; // @[MemInst.scala 20:18]
  wire  mem_io_inst_MPORT_en; // @[MemInst.scala 20:18]
  wire [9:0] mem_io_inst_MPORT_addr; // @[MemInst.scala 20:18]
  wire [31:0] mem_io_inst_MPORT_data; // @[MemInst.scala 20:18]
  wire [31:0] _io_inst_T = {{2'd0}, io_addr[31:2]}; // @[MemInst.scala 27:33]
  assign mem_io_inst_MPORT_en = 1'h1;
  assign mem_io_inst_MPORT_addr = _io_inst_T[9:0];
  assign mem_io_inst_MPORT_data = mem[mem_io_inst_MPORT_addr]; // @[MemInst.scala 20:18]
  assign io_inst = mem_io_inst_MPORT_data; // @[MemInst.scala 27:13]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Decoder(
  input  [31:0] io_inst,
  output        io_bundleCtrl_ctrlJump,
  output        io_bundleCtrl_ctrlBranch,
  output        io_bundleCtrl_ctrlRegWrite,
  output        io_bundleCtrl_ctrlLoad,
  output        io_bundleCtrl_ctrlStore,
  output        io_bundleCtrl_ctrlALUSrc,
  output        io_bundleCtrl_ctrlJAL,
  output [3:0]  io_bundleCtrl_ctrlOP,
  output        io_bundleCtrl_ctrlSigned,
  output [1:0]  io_bundleCtrl_ctrlLSType,
  output [4:0]  io_bundleReg_rs1,
  output [4:0]  io_bundleReg_rs2,
  output [4:0]  io_bundleReg_rd,
  output [31:0] io_imm
);
  wire [19:0] _imm_i_T_2 = io_inst[31] ? 20'hfffff : 20'h0; // @[Bitwise.scala 74:12]
  wire [31:0] imm_i = {_imm_i_T_2,io_inst[31:20]}; // @[Cat.scala 31:58]
  wire [31:0] imm_s = {_imm_i_T_2,io_inst[31:25],io_inst[11:7]}; // @[Cat.scala 31:58]
  wire [31:0] imm_b = {_imm_i_T_2,io_inst[7],io_inst[30:25],io_inst[11:8],1'h0}; // @[Cat.scala 31:58]
  wire [31:0] imm_u = {io_inst[31:12],12'h0}; // @[Cat.scala 31:58]
  wire [11:0] _imm_j_T_2 = io_inst[31] ? 12'hfff : 12'h0; // @[Bitwise.scala 74:12]
  wire [32:0] imm_j = {_imm_j_T_2,io_inst[31],io_inst[19:12],io_inst[20],io_inst[30:21],1'h0}; // @[Cat.scala 31:58]
  wire [31:0] imm_shamt = {27'h0,io_inst[24:20]}; // @[Cat.scala 31:58]
  wire  _T_11 = io_inst[6:2] == 5'h19; // @[Decoder.scala 73:33]
  wire  _T_13 = io_inst[6:2] == 5'h0; // @[Decoder.scala 79:38]
  wire  _T_17 = io_inst[14:12] == 3'h5; // @[Decoder.scala 83:70]
  wire  _GEN_0 = io_inst[14:12] == 3'h4 | io_inst[14:12] == 3'h5 ? 1'h0 : 1'h1; // @[Decoder.scala 83:84 84:32]
  wire  _T_22 = io_inst[14:12] == 3'h1; // @[Decoder.scala 88:73]
  wire [3:0] _T_29 = {io_inst[30],io_inst[14:12]}; // @[Cat.scala 31:58]
  wire [3:0] _GEN_1 = 4'hd == _T_29 ? 4'hb : 4'h0; // @[Decoder.scala 101:32 90:60]
  wire [3:0] _GEN_2 = 4'h5 == _T_29 ? 4'h9 : _GEN_1; // @[Decoder.scala 90:60 97:32]
  wire [3:0] _GEN_3 = 4'h1 == _T_29 ? 4'h8 : _GEN_2; // @[Decoder.scala 90:60 93:32]
  wire  _T_34 = 3'h0 == io_inst[14:12]; // @[Decoder.scala 106:42]
  wire  _T_35 = 3'h2 == io_inst[14:12]; // @[Decoder.scala 106:42]
  wire  _T_36 = 3'h3 == io_inst[14:12]; // @[Decoder.scala 106:42]
  wire  _T_37 = 3'h4 == io_inst[14:12]; // @[Decoder.scala 106:42]
  wire  _T_38 = 3'h6 == io_inst[14:12]; // @[Decoder.scala 106:42]
  wire  _T_39 = 3'h7 == io_inst[14:12]; // @[Decoder.scala 106:42]
  wire [3:0] _GEN_4 = 3'h7 == io_inst[14:12] ? 4'h4 : 4'h0; // @[Decoder.scala 106:42 130:32]
  wire [3:0] _GEN_5 = 3'h6 == io_inst[14:12] ? 4'h5 : _GEN_4; // @[Decoder.scala 106:42 126:32]
  wire [3:0] _GEN_6 = 3'h4 == io_inst[14:12] ? 4'h7 : _GEN_5; // @[Decoder.scala 106:42 122:32]
  wire [3:0] _GEN_7 = 3'h3 == io_inst[14:12] ? 4'he : _GEN_6; // @[Decoder.scala 106:42 117:32]
  wire  _GEN_8 = 3'h3 == io_inst[14:12] ? 1'h0 : 1'h1; // @[Decoder.scala 106:42 118:36]
  wire [3:0] _GEN_9 = 3'h2 == io_inst[14:12] ? 4'he : _GEN_7; // @[Decoder.scala 106:42 113:32]
  wire [3:0] _GEN_11 = 3'h0 == io_inst[14:12] ? 4'h1 : _GEN_9; // @[Decoder.scala 106:42 109:32]
  wire  _GEN_12 = 3'h0 == io_inst[14:12] | (3'h2 == io_inst[14:12] | _GEN_8); // @[Decoder.scala 106:42]
  wire [31:0] _GEN_13 = io_inst[6:2] == 5'h4 & (io_inst[14:12] == 3'h1 | _T_17) ? imm_shamt : imm_i; // @[Decoder.scala 88:120 105:21 89:21]
  wire [3:0] _GEN_14 = io_inst[6:2] == 5'h4 & (io_inst[14:12] == 3'h1 | _T_17) ? _GEN_3 : _GEN_11; // @[Decoder.scala 88:120]
  wire  _GEN_15 = io_inst[6:2] == 5'h4 & (io_inst[14:12] == 3'h1 | _T_17) | _GEN_12; // @[Decoder.scala 88:120]
  wire [3:0] _GEN_17 = io_inst[6:2] == 5'h0 ? 4'h1 : _GEN_14; // @[Decoder.scala 79:54 81:24]
  wire [31:0] _GEN_18 = io_inst[6:2] == 5'h0 ? imm_i : _GEN_13; // @[Decoder.scala 79:54 82:21]
  wire  _GEN_19 = io_inst[6:2] == 5'h0 ? _GEN_0 : _GEN_15; // @[Decoder.scala 79:54]
  wire [3:0] _GEN_21 = io_inst[6:2] == 5'h19 ? 4'h1 : _GEN_17; // @[Decoder.scala 73:49 75:24]
  wire [31:0] _GEN_22 = io_inst[6:2] == 5'h19 ? imm_i : _GEN_18; // @[Decoder.scala 73:49 76:21]
  wire  _GEN_23 = io_inst[6:2] == 5'h19 ? 1'h0 : _T_13; // @[Decoder.scala 73:49]
  wire  _GEN_24 = io_inst[6:2] == 5'h19 | _GEN_19; // @[Decoder.scala 73:49]
  wire  _T_43 = 3'h1 == io_inst[14:12]; // @[Decoder.scala 141:38]
  wire  _T_45 = 3'h5 == io_inst[14:12]; // @[Decoder.scala 141:38]
  wire [3:0] _GEN_25 = _T_39 ? 4'hf : 4'h0; // @[Decoder.scala 141:38 165:28]
  wire  _GEN_26 = _T_39 ? 1'h0 : 1'h1; // @[Decoder.scala 141:38 166:32]
  wire [3:0] _GEN_27 = _T_38 ? 4'he : _GEN_25; // @[Decoder.scala 141:38 160:28]
  wire  _GEN_28 = _T_38 ? 1'h0 : _GEN_26; // @[Decoder.scala 141:38 161:32]
  wire [3:0] _GEN_29 = 3'h5 == io_inst[14:12] ? 4'hf : _GEN_27; // @[Decoder.scala 141:38 156:28]
  wire [3:0] _GEN_31 = _T_37 ? 4'he : _GEN_29; // @[Decoder.scala 141:38 152:28]
  wire [3:0] _GEN_33 = 3'h1 == io_inst[14:12] ? 4'hd : _GEN_31; // @[Decoder.scala 141:38 148:28]
  wire [3:0] _GEN_35 = _T_34 ? 4'hc : _GEN_33; // @[Decoder.scala 141:38 144:28]
  wire  _GEN_36 = _T_34 | (3'h1 == io_inst[14:12] | (_T_37 | (3'h5 == io_inst[14:12] | _GEN_28))); // @[Decoder.scala 141:38]
  wire [1:0] _GEN_38 = _T_22 ? 2'h1 : 2'h0; // @[Decoder.scala 180:49 181:28]
  wire [1:0] _GEN_39 = io_inst[30] ? 2'h2 : 2'h1; // @[Decoder.scala 189:40 190:32 192:32]
  wire [3:0] _GEN_40 = io_inst[30] ? 4'hb : 4'h9; // @[Decoder.scala 214:40 215:32 217:32]
  wire [3:0] _GEN_43 = _T_45 ? _GEN_40 : _GEN_5; // @[Decoder.scala 186:38]
  wire [3:0] _GEN_44 = _T_37 ? 4'h7 : _GEN_43; // @[Decoder.scala 186:38 210:28]
  wire [3:0] _GEN_45 = _T_36 ? 4'h0 : _GEN_44; // @[Decoder.scala 186:38 206:28]
  wire [3:0] _GEN_46 = _T_35 ? 4'he : _GEN_45; // @[Decoder.scala 186:38 201:28]
  wire [3:0] _GEN_47 = _T_43 ? 4'h8 : _GEN_46; // @[Decoder.scala 186:38 197:28]
  wire [3:0] _GEN_48 = _T_34 ? {{2'd0}, _GEN_39} : _GEN_47; // @[Decoder.scala 186:38]
  wire [3:0] _GEN_49 = 5'hc == io_inst[6:2] ? _GEN_48 : 4'h0; // @[Decoder.scala 52:28]
  wire  _GEN_51 = 5'h8 == io_inst[6:2] ? 1'h0 : 1'h1; // @[Decoder.scala 174:26 52:28]
  wire [3:0] _GEN_52 = 5'h8 == io_inst[6:2] ? 4'h1 : _GEN_49; // @[Decoder.scala 175:20 52:28]
  wire [31:0] _GEN_53 = 5'h8 == io_inst[6:2] ? imm_s : 32'h0; // @[Decoder.scala 176:17 52:28]
  wire [1:0] _GEN_54 = 5'h8 == io_inst[6:2] ? _GEN_38 : 2'h0; // @[Decoder.scala 52:28]
  wire  _GEN_55 = 5'h18 == io_inst[6:2] ? 1'h0 : 5'h8 == io_inst[6:2]; // @[Decoder.scala 137:24 52:28]
  wire  _GEN_57 = 5'h18 == io_inst[6:2] ? 1'h0 : _GEN_51; // @[Decoder.scala 139:26 52:28]
  wire [31:0] _GEN_58 = 5'h18 == io_inst[6:2] ? imm_b : _GEN_53; // @[Decoder.scala 140:17 52:28]
  wire [3:0] _GEN_59 = 5'h18 == io_inst[6:2] ? _GEN_35 : _GEN_52; // @[Decoder.scala 52:28]
  wire  _GEN_60 = 5'h18 == io_inst[6:2] ? _GEN_36 : 1'h1; // @[Decoder.scala 52:28]
  wire [1:0] _GEN_61 = 5'h18 == io_inst[6:2] ? 2'h0 : _GEN_54; // @[Decoder.scala 52:28]
  wire  _GEN_62 = 5'h19 == io_inst[6:2] | 5'h0 == io_inst[6:2] | 5'h4 == io_inst[6:2] | _GEN_55; // @[Decoder.scala 52:28 71:24]
  wire [3:0] _GEN_64 = 5'h19 == io_inst[6:2] | 5'h0 == io_inst[6:2] | 5'h4 == io_inst[6:2] ? _GEN_21 : _GEN_59; // @[Decoder.scala 52:28]
  wire [31:0] _GEN_65 = 5'h19 == io_inst[6:2] | 5'h0 == io_inst[6:2] | 5'h4 == io_inst[6:2] ? _GEN_22 : _GEN_58; // @[Decoder.scala 52:28]
  wire  _GEN_67 = 5'h19 == io_inst[6:2] | 5'h0 == io_inst[6:2] | 5'h4 == io_inst[6:2] ? _GEN_24 : _GEN_60; // @[Decoder.scala 52:28]
  wire  _GEN_68 = 5'h19 == io_inst[6:2] | 5'h0 == io_inst[6:2] | 5'h4 == io_inst[6:2] ? 1'h0 : 5'h18 == io_inst[6:2]; // @[Decoder.scala 52:28]
  wire  _GEN_70 = 5'h19 == io_inst[6:2] | 5'h0 == io_inst[6:2] | 5'h4 == io_inst[6:2] ? 1'h0 : _GEN_55; // @[Decoder.scala 52:28]
  wire [1:0] _GEN_71 = 5'h19 == io_inst[6:2] | 5'h0 == io_inst[6:2] | 5'h4 == io_inst[6:2] ? 2'h0 : _GEN_61; // @[Decoder.scala 52:28]
  wire  _GEN_72 = 5'h1b == io_inst[6:2] | _GEN_62; // @[Decoder.scala 52:28 61:24]
  wire  _GEN_73 = 5'h1b == io_inst[6:2] | (5'h19 == io_inst[6:2] | 5'h0 == io_inst[6:2] | 5'h4 == io_inst[6:2]) & _T_11; // @[Decoder.scala 52:28 62:22]
  wire [3:0] _GEN_74 = 5'h1b == io_inst[6:2] ? 4'h1 : _GEN_64; // @[Decoder.scala 52:28 63:20]
  wire [32:0] _GEN_76 = 5'h1b == io_inst[6:2] ? imm_j : {{1'd0}, _GEN_65}; // @[Decoder.scala 52:28 65:17]
  wire  _GEN_77 = 5'h1b == io_inst[6:2] ? 1'h0 : (5'h19 == io_inst[6:2] | 5'h0 == io_inst[6:2] | 5'h4 == io_inst[6:2])
     & _GEN_23; // @[Decoder.scala 52:28]
  wire  _GEN_79 = 5'h1b == io_inst[6:2] ? 1'h0 : _GEN_68; // @[Decoder.scala 52:28]
  wire  _GEN_81 = 5'h1b == io_inst[6:2] ? 1'h0 : _GEN_70; // @[Decoder.scala 52:28]
  wire [1:0] _GEN_82 = 5'h1b == io_inst[6:2] ? 2'h0 : _GEN_71; // @[Decoder.scala 52:28]
  wire [32:0] _GEN_85 = 5'hd == io_inst[6:2] | 5'h5 == io_inst[6:2] ? {{1'd0}, imm_u} : _GEN_76; // @[Decoder.scala 52:28 57:17]
  assign io_bundleCtrl_ctrlJump = 5'hd == io_inst[6:2] | 5'h5 == io_inst[6:2] ? 1'h0 : _GEN_73; // @[Decoder.scala 52:28]
  assign io_bundleCtrl_ctrlBranch = 5'hd == io_inst[6:2] | 5'h5 == io_inst[6:2] ? 1'h0 : _GEN_79; // @[Decoder.scala 52:28]
  assign io_bundleCtrl_ctrlRegWrite = 5'hd == io_inst[6:2] | 5'h5 == io_inst[6:2] | (5'h1b == io_inst[6:2] | (5'h19 ==
    io_inst[6:2] | 5'h0 == io_inst[6:2] | 5'h4 == io_inst[6:2] | _GEN_57)); // @[Decoder.scala 52:28]
  assign io_bundleCtrl_ctrlLoad = 5'hd == io_inst[6:2] | 5'h5 == io_inst[6:2] ? 1'h0 : _GEN_77; // @[Decoder.scala 52:28]
  assign io_bundleCtrl_ctrlStore = 5'hd == io_inst[6:2] | 5'h5 == io_inst[6:2] ? 1'h0 : _GEN_81; // @[Decoder.scala 52:28]
  assign io_bundleCtrl_ctrlALUSrc = 5'hd == io_inst[6:2] | 5'h5 == io_inst[6:2] | _GEN_72; // @[Decoder.scala 52:28 55:24]
  assign io_bundleCtrl_ctrlJAL = 5'hd == io_inst[6:2] | 5'h5 == io_inst[6:2] ? 1'h0 : 5'h1b == io_inst[6:2]; // @[Decoder.scala 52:28]
  assign io_bundleCtrl_ctrlOP = 5'hd == io_inst[6:2] | 5'h5 == io_inst[6:2] ? 4'h1 : _GEN_74; // @[Decoder.scala 52:28 56:20]
  assign io_bundleCtrl_ctrlSigned = 5'hd == io_inst[6:2] | 5'h5 == io_inst[6:2] | (5'h1b == io_inst[6:2] | _GEN_67); // @[Decoder.scala 52:28]
  assign io_bundleCtrl_ctrlLSType = 5'hd == io_inst[6:2] | 5'h5 == io_inst[6:2] ? 2'h0 : _GEN_82; // @[Decoder.scala 52:28]
  assign io_bundleReg_rs1 = io_inst[19:15]; // @[Decoder.scala 23:32]
  assign io_bundleReg_rs2 = io_inst[24:20]; // @[Decoder.scala 24:32]
  assign io_bundleReg_rd = io_inst[11:7]; // @[Decoder.scala 25:31]
  assign io_imm = _GEN_85[31:0]; // @[Decoder.scala 243:12]
endmodule
module Registers(
  input         clock,
  input         io_ctrlRegWrite,
  input         io_ctrlJump,
  input  [31:0] io_pc,
  input  [31:0] io_dataWrite,
  input  [4:0]  io_bundleReg_rs1,
  input  [4:0]  io_bundleReg_rs2,
  input  [4:0]  io_bundleReg_rd,
  output [31:0] io_dataRead1,
  output [31:0] io_dataRead2
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regs_0; // @[Registers.scala 23:19]
  reg [31:0] regs_1; // @[Registers.scala 23:19]
  reg [31:0] regs_2; // @[Registers.scala 23:19]
  reg [31:0] regs_3; // @[Registers.scala 23:19]
  reg [31:0] regs_4; // @[Registers.scala 23:19]
  reg [31:0] regs_5; // @[Registers.scala 23:19]
  reg [31:0] regs_6; // @[Registers.scala 23:19]
  reg [31:0] regs_7; // @[Registers.scala 23:19]
  reg [31:0] regs_8; // @[Registers.scala 23:19]
  reg [31:0] regs_9; // @[Registers.scala 23:19]
  reg [31:0] regs_10; // @[Registers.scala 23:19]
  reg [31:0] regs_11; // @[Registers.scala 23:19]
  reg [31:0] regs_12; // @[Registers.scala 23:19]
  reg [31:0] regs_13; // @[Registers.scala 23:19]
  reg [31:0] regs_14; // @[Registers.scala 23:19]
  reg [31:0] regs_15; // @[Registers.scala 23:19]
  reg [31:0] regs_16; // @[Registers.scala 23:19]
  reg [31:0] regs_17; // @[Registers.scala 23:19]
  reg [31:0] regs_18; // @[Registers.scala 23:19]
  reg [31:0] regs_19; // @[Registers.scala 23:19]
  reg [31:0] regs_20; // @[Registers.scala 23:19]
  reg [31:0] regs_21; // @[Registers.scala 23:19]
  reg [31:0] regs_22; // @[Registers.scala 23:19]
  reg [31:0] regs_23; // @[Registers.scala 23:19]
  reg [31:0] regs_24; // @[Registers.scala 23:19]
  reg [31:0] regs_25; // @[Registers.scala 23:19]
  reg [31:0] regs_26; // @[Registers.scala 23:19]
  reg [31:0] regs_27; // @[Registers.scala 23:19]
  reg [31:0] regs_28; // @[Registers.scala 23:19]
  reg [31:0] regs_29; // @[Registers.scala 23:19]
  reg [31:0] regs_30; // @[Registers.scala 23:19]
  reg [31:0] regs_31; // @[Registers.scala 23:19]
  wire [31:0] _GEN_1 = 5'h1 == io_bundleReg_rs1 ? regs_1 : regs_0; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_2 = 5'h2 == io_bundleReg_rs1 ? regs_2 : _GEN_1; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_3 = 5'h3 == io_bundleReg_rs1 ? regs_3 : _GEN_2; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_4 = 5'h4 == io_bundleReg_rs1 ? regs_4 : _GEN_3; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_5 = 5'h5 == io_bundleReg_rs1 ? regs_5 : _GEN_4; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_6 = 5'h6 == io_bundleReg_rs1 ? regs_6 : _GEN_5; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_7 = 5'h7 == io_bundleReg_rs1 ? regs_7 : _GEN_6; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_8 = 5'h8 == io_bundleReg_rs1 ? regs_8 : _GEN_7; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_9 = 5'h9 == io_bundleReg_rs1 ? regs_9 : _GEN_8; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_10 = 5'ha == io_bundleReg_rs1 ? regs_10 : _GEN_9; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_11 = 5'hb == io_bundleReg_rs1 ? regs_11 : _GEN_10; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_12 = 5'hc == io_bundleReg_rs1 ? regs_12 : _GEN_11; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_13 = 5'hd == io_bundleReg_rs1 ? regs_13 : _GEN_12; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_14 = 5'he == io_bundleReg_rs1 ? regs_14 : _GEN_13; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_15 = 5'hf == io_bundleReg_rs1 ? regs_15 : _GEN_14; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_16 = 5'h10 == io_bundleReg_rs1 ? regs_16 : _GEN_15; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_17 = 5'h11 == io_bundleReg_rs1 ? regs_17 : _GEN_16; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_18 = 5'h12 == io_bundleReg_rs1 ? regs_18 : _GEN_17; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_19 = 5'h13 == io_bundleReg_rs1 ? regs_19 : _GEN_18; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_20 = 5'h14 == io_bundleReg_rs1 ? regs_20 : _GEN_19; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_21 = 5'h15 == io_bundleReg_rs1 ? regs_21 : _GEN_20; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_22 = 5'h16 == io_bundleReg_rs1 ? regs_22 : _GEN_21; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_23 = 5'h17 == io_bundleReg_rs1 ? regs_23 : _GEN_22; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_24 = 5'h18 == io_bundleReg_rs1 ? regs_24 : _GEN_23; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_25 = 5'h19 == io_bundleReg_rs1 ? regs_25 : _GEN_24; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_26 = 5'h1a == io_bundleReg_rs1 ? regs_26 : _GEN_25; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_27 = 5'h1b == io_bundleReg_rs1 ? regs_27 : _GEN_26; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_28 = 5'h1c == io_bundleReg_rs1 ? regs_28 : _GEN_27; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_29 = 5'h1d == io_bundleReg_rs1 ? regs_29 : _GEN_28; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_30 = 5'h1e == io_bundleReg_rs1 ? regs_30 : _GEN_29; // @[Registers.scala 33:{18,18}]
  wire [31:0] _GEN_33 = 5'h1 == io_bundleReg_rs2 ? regs_1 : regs_0; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_34 = 5'h2 == io_bundleReg_rs2 ? regs_2 : _GEN_33; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_35 = 5'h3 == io_bundleReg_rs2 ? regs_3 : _GEN_34; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_36 = 5'h4 == io_bundleReg_rs2 ? regs_4 : _GEN_35; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_37 = 5'h5 == io_bundleReg_rs2 ? regs_5 : _GEN_36; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_38 = 5'h6 == io_bundleReg_rs2 ? regs_6 : _GEN_37; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_39 = 5'h7 == io_bundleReg_rs2 ? regs_7 : _GEN_38; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_40 = 5'h8 == io_bundleReg_rs2 ? regs_8 : _GEN_39; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_41 = 5'h9 == io_bundleReg_rs2 ? regs_9 : _GEN_40; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_42 = 5'ha == io_bundleReg_rs2 ? regs_10 : _GEN_41; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_43 = 5'hb == io_bundleReg_rs2 ? regs_11 : _GEN_42; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_44 = 5'hc == io_bundleReg_rs2 ? regs_12 : _GEN_43; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_45 = 5'hd == io_bundleReg_rs2 ? regs_13 : _GEN_44; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_46 = 5'he == io_bundleReg_rs2 ? regs_14 : _GEN_45; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_47 = 5'hf == io_bundleReg_rs2 ? regs_15 : _GEN_46; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_48 = 5'h10 == io_bundleReg_rs2 ? regs_16 : _GEN_47; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_49 = 5'h11 == io_bundleReg_rs2 ? regs_17 : _GEN_48; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_50 = 5'h12 == io_bundleReg_rs2 ? regs_18 : _GEN_49; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_51 = 5'h13 == io_bundleReg_rs2 ? regs_19 : _GEN_50; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_52 = 5'h14 == io_bundleReg_rs2 ? regs_20 : _GEN_51; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_53 = 5'h15 == io_bundleReg_rs2 ? regs_21 : _GEN_52; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_54 = 5'h16 == io_bundleReg_rs2 ? regs_22 : _GEN_53; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_55 = 5'h17 == io_bundleReg_rs2 ? regs_23 : _GEN_54; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_56 = 5'h18 == io_bundleReg_rs2 ? regs_24 : _GEN_55; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_57 = 5'h19 == io_bundleReg_rs2 ? regs_25 : _GEN_56; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_58 = 5'h1a == io_bundleReg_rs2 ? regs_26 : _GEN_57; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_59 = 5'h1b == io_bundleReg_rs2 ? regs_27 : _GEN_58; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_60 = 5'h1c == io_bundleReg_rs2 ? regs_28 : _GEN_59; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_61 = 5'h1d == io_bundleReg_rs2 ? regs_29 : _GEN_60; // @[Registers.scala 34:{18,18}]
  wire [31:0] _GEN_62 = 5'h1e == io_bundleReg_rs2 ? regs_30 : _GEN_61; // @[Registers.scala 34:{18,18}]
  wire [31:0] _regs_T_1 = io_pc + 32'h4; // @[Registers.scala 38:44]
  assign io_dataRead1 = 5'h1f == io_bundleReg_rs1 ? regs_31 : _GEN_30; // @[Registers.scala 33:{18,18}]
  assign io_dataRead2 = 5'h1f == io_bundleReg_rs2 ? regs_31 : _GEN_62; // @[Registers.scala 34:{18,18}]
  always @(posedge clock) begin
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h0 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_0 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h0 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_0 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h1 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_1 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h1 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_1 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h2 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_2 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h2 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_2 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h3 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_3 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h3 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_3 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h4 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_4 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h4 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_4 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h5 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_5 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h5 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_5 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h6 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_6 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h6 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_6 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h7 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_7 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h7 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_7 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h8 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_8 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h8 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_8 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h9 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_9 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h9 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_9 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'ha == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_10 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'ha == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_10 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'hb == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_11 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'hb == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_11 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'hc == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_12 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'hc == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_12 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'hd == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_13 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'hd == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_13 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'he == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_14 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'he == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_14 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'hf == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_15 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'hf == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_15 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h10 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_16 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h10 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_16 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h11 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_17 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h11 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_17 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h12 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_18 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h12 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_18 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h13 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_19 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h13 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_19 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h14 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_20 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h14 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_20 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h15 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_21 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h15 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_21 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h16 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_22 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h16 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_22 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h17 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_23 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h17 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_23 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h18 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_24 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h18 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_24 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h19 == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_25 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h19 == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_25 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h1a == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_26 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h1a == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_26 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h1b == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_27 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h1b == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_27 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h1c == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_28 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h1c == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_28 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h1d == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_29 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h1d == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_29 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h1e == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_30 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h1e == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_30 <= io_dataWrite; // @[Registers.scala 40:35]
      end
    end
    if (io_ctrlRegWrite & io_bundleReg_rd != 5'h0) begin // @[Registers.scala 36:54]
      if (io_ctrlJump) begin // @[Registers.scala 37:27]
        if (5'h1f == io_bundleReg_rd) begin // @[Registers.scala 38:35]
          regs_31 <= _regs_T_1; // @[Registers.scala 38:35]
        end
      end else if (5'h1f == io_bundleReg_rd) begin // @[Registers.scala 40:35]
        regs_31 <= io_dataWrite; // @[Registers.scala 40:35]
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
  regs_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  regs_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  regs_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  regs_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  regs_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  regs_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  regs_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  regs_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  regs_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  regs_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  regs_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  regs_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  regs_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  regs_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  regs_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  regs_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  regs_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  regs_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  regs_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  regs_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  regs_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  regs_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  regs_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  regs_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  regs_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  regs_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  regs_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  regs_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  regs_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  regs_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  regs_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  regs_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Alu(
  input         io_bundleAluControl_ctrlALUSrc,
  input         io_bundleAluControl_ctrlJAL,
  input  [3:0]  io_bundleAluControl_ctrlOP,
  input         io_bundleAluControl_ctrlSigned,
  input         io_bundleAluControl_ctrlBranch,
  input  [31:0] io_dataRead1,
  input  [31:0] io_dataRead2,
  input  [31:0] io_imm,
  input  [31:0] io_pc,
  output        io_resultBranch,
  output [31:0] io_resultAlu
);
  wire [31:0] oprand1 = io_bundleAluControl_ctrlJAL ? io_pc : io_dataRead1; // @[Alu.scala 31:19]
  wire [31:0] oprand2 = io_bundleAluControl_ctrlALUSrc ? io_imm : io_dataRead2; // @[Alu.scala 32:19]
  wire [32:0] _resultAlu_T = oprand1 + oprand2; // @[Alu.scala 41:34]
  wire [32:0] _resultAlu_T_1 = oprand1 - oprand2; // @[Alu.scala 44:34]
  wire [31:0] _resultAlu_T_3 = oprand1 & oprand2; // @[Alu.scala 47:34]
  wire [31:0] _resultAlu_T_4 = oprand1 | oprand2; // @[Alu.scala 50:34]
  wire [31:0] _resultAlu_T_5 = oprand1 ^ oprand2; // @[Alu.scala 53:34]
  wire [62:0] _GEN_1 = {{31'd0}, oprand1}; // @[Alu.scala 56:34]
  wire [62:0] _resultAlu_T_7 = _GEN_1 << oprand2[4:0]; // @[Alu.scala 56:34]
  wire [31:0] _resultAlu_T_9 = oprand1 >> oprand2[4:0]; // @[Alu.scala 59:34]
  wire [31:0] _resultAlu_T_10 = io_bundleAluControl_ctrlJAL ? io_pc : io_dataRead1; // @[Alu.scala 62:35]
  wire [31:0] _resultAlu_T_13 = $signed(_resultAlu_T_10) >>> oprand2[4:0]; // @[Alu.scala 62:60]
  wire [31:0] _resultBranch_T_1 = io_bundleAluControl_ctrlALUSrc ? io_imm : io_dataRead2; // @[Alu.scala 65:56]
  wire [32:0] _resultAlu_T_14 = io_pc + io_imm; // @[Alu.scala 66:32]
  wire  _GEN_0 = io_bundleAluControl_ctrlSigned ? $signed(_resultAlu_T_10) < $signed(_resultBranch_T_1) : oprand1 <
    oprand2; // @[Alu.scala 74:54 75:34 77:34]
  wire  _GEN_2 = io_bundleAluControl_ctrlBranch & _GEN_0; // @[Alu.scala 73:50]
  wire [32:0] _GEN_3 = io_bundleAluControl_ctrlBranch ? _resultAlu_T_14 : {{32'd0}, _GEN_0}; // @[Alu.scala 73:50 79:27]
  wire  _GEN_4 = io_bundleAluControl_ctrlSigned ? $signed(_resultAlu_T_10) >= $signed(_resultBranch_T_1) : oprand1 >=
    oprand2; // @[Alu.scala 89:50 90:30 92:30]
  wire [32:0] _GEN_6 = 4'hf == io_bundleAluControl_ctrlOP ? _resultAlu_T_14 : 33'h0; // @[Alu.scala 35:40 94:23]
  wire  _GEN_7 = 4'he == io_bundleAluControl_ctrlOP ? _GEN_2 : 4'hf == io_bundleAluControl_ctrlOP & _GEN_4; // @[Alu.scala 35:40]
  wire [32:0] _GEN_8 = 4'he == io_bundleAluControl_ctrlOP ? _GEN_3 : _GEN_6; // @[Alu.scala 35:40]
  wire  _GEN_9 = 4'hd == io_bundleAluControl_ctrlOP ? $signed(_resultAlu_T_10) != $signed(_resultBranch_T_1) : _GEN_7; // @[Alu.scala 35:40 69:26]
  wire [32:0] _GEN_10 = 4'hd == io_bundleAluControl_ctrlOP ? _resultAlu_T_14 : _GEN_8; // @[Alu.scala 35:40 70:23]
  wire  _GEN_11 = 4'hc == io_bundleAluControl_ctrlOP ? $signed(_resultAlu_T_10) == $signed(_resultBranch_T_1) : _GEN_9; // @[Alu.scala 35:40 65:26]
  wire [32:0] _GEN_12 = 4'hc == io_bundleAluControl_ctrlOP ? _resultAlu_T_14 : _GEN_10; // @[Alu.scala 35:40 66:23]
  wire [32:0] _GEN_13 = 4'hb == io_bundleAluControl_ctrlOP ? {{1'd0}, _resultAlu_T_13} : _GEN_12; // @[Alu.scala 35:40 62:23]
  wire  _GEN_14 = 4'hb == io_bundleAluControl_ctrlOP ? 1'h0 : _GEN_11; // @[Alu.scala 35:40]
  wire [32:0] _GEN_15 = 4'h9 == io_bundleAluControl_ctrlOP ? {{1'd0}, _resultAlu_T_9} : _GEN_13; // @[Alu.scala 35:40 59:23]
  wire  _GEN_16 = 4'h9 == io_bundleAluControl_ctrlOP ? 1'h0 : _GEN_14; // @[Alu.scala 35:40]
  wire [62:0] _GEN_17 = 4'h8 == io_bundleAluControl_ctrlOP ? _resultAlu_T_7 : {{30'd0}, _GEN_15}; // @[Alu.scala 35:40 56:23]
  wire  _GEN_18 = 4'h8 == io_bundleAluControl_ctrlOP ? 1'h0 : _GEN_16; // @[Alu.scala 35:40]
  wire [62:0] _GEN_19 = 4'h7 == io_bundleAluControl_ctrlOP ? {{31'd0}, _resultAlu_T_5} : _GEN_17; // @[Alu.scala 35:40 53:23]
  wire  _GEN_20 = 4'h7 == io_bundleAluControl_ctrlOP ? 1'h0 : _GEN_18; // @[Alu.scala 35:40]
  wire [62:0] _GEN_21 = 4'h5 == io_bundleAluControl_ctrlOP ? {{31'd0}, _resultAlu_T_4} : _GEN_19; // @[Alu.scala 35:40 50:23]
  wire  _GEN_22 = 4'h5 == io_bundleAluControl_ctrlOP ? 1'h0 : _GEN_20; // @[Alu.scala 35:40]
  wire [62:0] _GEN_23 = 4'h4 == io_bundleAluControl_ctrlOP ? {{31'd0}, _resultAlu_T_3} : _GEN_21; // @[Alu.scala 35:40 47:23]
  wire  _GEN_24 = 4'h4 == io_bundleAluControl_ctrlOP ? 1'h0 : _GEN_22; // @[Alu.scala 35:40]
  wire [62:0] _GEN_25 = 4'h2 == io_bundleAluControl_ctrlOP ? {{30'd0}, _resultAlu_T_1} : _GEN_23; // @[Alu.scala 35:40 44:23]
  wire  _GEN_26 = 4'h2 == io_bundleAluControl_ctrlOP ? 1'h0 : _GEN_24; // @[Alu.scala 35:40]
  wire [62:0] _GEN_27 = 4'h1 == io_bundleAluControl_ctrlOP ? {{30'd0}, _resultAlu_T} : _GEN_25; // @[Alu.scala 35:40 41:23]
  wire  _GEN_28 = 4'h1 == io_bundleAluControl_ctrlOP ? 1'h0 : _GEN_26; // @[Alu.scala 35:40]
  wire [62:0] _GEN_29 = 4'h0 == io_bundleAluControl_ctrlOP ? 63'h0 : _GEN_27; // @[Alu.scala 35:40 37:23]
  assign io_resultBranch = 4'h0 == io_bundleAluControl_ctrlOP ? 1'h0 : _GEN_28; // @[Alu.scala 35:40 38:26]
  assign io_resultAlu = _GEN_29[31:0]; // @[Alu.scala 98:18]
endmodule
module MemData(
  input         clock,
  input         io_bundleMemDataControl_ctrlLoad,
  input         io_bundleMemDataControl_ctrlStore,
  input         io_bundleMemDataControl_ctrlSigned,
  input  [1:0]  io_bundleMemDataControl_ctrlLSType,
  input  [31:0] io_resultALU,
  input  [31:0] io_dataStore,
  output [31:0] io_result
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] mem [0:1023]; // @[MemData.scala 22:18]
  wire  mem_dataLoad_MPORT_en; // @[MemData.scala 22:18]
  wire [9:0] mem_dataLoad_MPORT_addr; // @[MemData.scala 22:18]
  wire [31:0] mem_dataLoad_MPORT_data; // @[MemData.scala 22:18]
  wire [31:0] mem_MPORT_data; // @[MemData.scala 22:18]
  wire [9:0] mem_MPORT_addr; // @[MemData.scala 22:18]
  wire  mem_MPORT_mask; // @[MemData.scala 22:18]
  wire  mem_MPORT_en; // @[MemData.scala 22:18]
  wire [31:0] mem_MPORT_1_data; // @[MemData.scala 22:18]
  wire [9:0] mem_MPORT_1_addr; // @[MemData.scala 22:18]
  wire  mem_MPORT_1_mask; // @[MemData.scala 22:18]
  wire  mem_MPORT_1_en; // @[MemData.scala 22:18]
  wire [31:0] mem_MPORT_2_data; // @[MemData.scala 22:18]
  wire [9:0] mem_MPORT_2_addr; // @[MemData.scala 22:18]
  wire  mem_MPORT_2_mask; // @[MemData.scala 22:18]
  wire  mem_MPORT_2_en; // @[MemData.scala 22:18]
  wire [31:0] _dataLoad_T = {{2'd0}, io_resultALU[31:2]}; // @[MemData.scala 31:39]
  wire  _T = io_bundleMemDataControl_ctrlLSType == 2'h2; // @[MemData.scala 35:49]
  wire  _T_3 = io_bundleMemDataControl_ctrlLSType == 2'h1; // @[MemData.scala 37:55]
  wire [31:0] dataLoad = mem_dataLoad_MPORT_data;
  wire  _GEN_7 = io_bundleMemDataControl_ctrlLSType == 2'h1 ? 1'h0 : 1'h1; // @[MemData.scala 22:18 37:65]
  wire  _GEN_17 = io_bundleMemDataControl_ctrlLSType == 2'h2 ? 1'h0 : _T_3; // @[MemData.scala 22:18 35:59]
  wire  _GEN_22 = io_bundleMemDataControl_ctrlLSType == 2'h2 ? 1'h0 : _GEN_7; // @[MemData.scala 22:18 35:59]
  wire [15:0] _result_T_2 = dataLoad[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _result_T_4 = {_result_T_2,dataLoad[15:0]}; // @[Cat.scala 31:58]
  wire [31:0] _result_T_7 = {16'h0,dataLoad[15:0]}; // @[Cat.scala 31:58]
  wire [31:0] _GEN_40 = io_bundleMemDataControl_ctrlSigned ? _result_T_4 : _result_T_7; // @[MemData.scala 48:55 49:24 51:24]
  wire [23:0] _result_T_10 = dataLoad[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 74:12]
  wire [31:0] _result_T_12 = {_result_T_10,dataLoad[7:0]}; // @[Cat.scala 31:58]
  wire [31:0] _result_T_15 = {24'h0,dataLoad[7:0]}; // @[Cat.scala 31:58]
  wire [31:0] _GEN_41 = io_bundleMemDataControl_ctrlSigned ? _result_T_12 : _result_T_15; // @[MemData.scala 54:55 55:24 57:24]
  wire [31:0] _GEN_42 = _T_3 ? _GEN_40 : _GEN_41; // @[MemData.scala 47:65]
  wire [31:0] _GEN_43 = _T ? dataLoad : _GEN_42; // @[MemData.scala 45:59 46:20]
  assign mem_dataLoad_MPORT_en = 1'h1;
  assign mem_dataLoad_MPORT_addr = _dataLoad_T[9:0];
  assign mem_dataLoad_MPORT_data = mem[mem_dataLoad_MPORT_addr]; // @[MemData.scala 22:18]
  assign mem_MPORT_data = io_dataStore;
  assign mem_MPORT_addr = _dataLoad_T[9:0];
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_bundleMemDataControl_ctrlStore & _T;
  assign mem_MPORT_1_data = {dataLoad[31:16],io_dataStore[15:0]};
  assign mem_MPORT_1_addr = _dataLoad_T[9:0];
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = io_bundleMemDataControl_ctrlStore & _GEN_17;
  assign mem_MPORT_2_data = {dataLoad[31:8],io_dataStore[7:0]};
  assign mem_MPORT_2_addr = _dataLoad_T[9:0];
  assign mem_MPORT_2_mask = 1'h1;
  assign mem_MPORT_2_en = io_bundleMemDataControl_ctrlStore & _GEN_22;
  assign io_result = io_bundleMemDataControl_ctrlLoad ? _GEN_43 : io_resultALU; // @[MemData.scala 44:45 62:16]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[MemData.scala 22:18]
    end
    if (mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[MemData.scala 22:18]
    end
    if (mem_MPORT_2_en & mem_MPORT_2_mask) begin
      mem[mem_MPORT_2_addr] <= mem_MPORT_2_data; // @[MemData.scala 22:18]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Controller(
  input        io_bundleControlIn_ctrlJump,
  input        io_bundleControlIn_ctrlBranch,
  input        io_bundleControlIn_ctrlRegWrite,
  input        io_bundleControlIn_ctrlLoad,
  input        io_bundleControlIn_ctrlStore,
  input        io_bundleControlIn_ctrlALUSrc,
  input        io_bundleControlIn_ctrlJAL,
  input  [3:0] io_bundleControlIn_ctrlOP,
  input        io_bundleControlIn_ctrlSigned,
  output       io_bundleAluControl_ctrlALUSrc,
  output       io_bundleAluControl_ctrlJAL,
  output [3:0] io_bundleAluControl_ctrlOP,
  output       io_bundleAluControl_ctrlSigned,
  output       io_bundleAluControl_ctrlBranch,
  output       io_bundleMemDataControl_ctrlLoad,
  output       io_bundleMemDataControl_ctrlStore,
  output       io_bundleMemDataControl_ctrlSigned,
  output [1:0] io_bundleMemDataControl_ctrlLSType,
  output       io_bundleControlOut_ctrlJump,
  output       io_bundleControlOut_ctrlBranch,
  output       io_bundleControlOut_ctrlRegWrite
);
  assign io_bundleAluControl_ctrlALUSrc = io_bundleControlIn_ctrlALUSrc; // @[Controller.scala 19:36]
  assign io_bundleAluControl_ctrlJAL = io_bundleControlIn_ctrlJAL; // @[Controller.scala 20:33]
  assign io_bundleAluControl_ctrlOP = io_bundleControlIn_ctrlOP; // @[Controller.scala 21:32]
  assign io_bundleAluControl_ctrlSigned = io_bundleControlIn_ctrlSigned; // @[Controller.scala 22:36]
  assign io_bundleAluControl_ctrlBranch = io_bundleControlIn_ctrlBranch; // @[Controller.scala 23:36]
  assign io_bundleMemDataControl_ctrlLoad = io_bundleControlIn_ctrlLoad; // @[Controller.scala 27:38]
  assign io_bundleMemDataControl_ctrlStore = io_bundleControlIn_ctrlStore; // @[Controller.scala 29:39]
  assign io_bundleMemDataControl_ctrlSigned = io_bundleControlIn_ctrlSigned; // @[Controller.scala 28:40]
  assign io_bundleMemDataControl_ctrlLSType = {{1'd0}, io_bundleControlIn_ctrlALUSrc}; // @[Controller.scala 26:40]
  assign io_bundleControlOut_ctrlJump = io_bundleControlIn_ctrlJump; // @[Controller.scala 32:25]
  assign io_bundleControlOut_ctrlBranch = io_bundleControlIn_ctrlBranch; // @[Controller.scala 32:25]
  assign io_bundleControlOut_ctrlRegWrite = io_bundleControlIn_ctrlRegWrite; // @[Controller.scala 32:25]
endmodule
module Top(
  input         clock,
  input         reset,
  output [31:0] io_addr,
  output [31:0] io_inst,
  output        io_bundleCtrl_ctrlJump,
  output        io_bundleCtrl_ctrlBranch,
  output        io_bundleCtrl_ctrlRegWrite,
  output        io_bundleCtrl_ctrlLoad,
  output        io_bundleCtrl_ctrlStore,
  output        io_bundleCtrl_ctrlALUSrc,
  output        io_bundleCtrl_ctrlJAL,
  output [3:0]  io_bundleCtrl_ctrlOP,
  output        io_bundleCtrl_ctrlSigned,
  output [1:0]  io_bundleCtrl_ctrlLSType,
  output [31:0] io_resultALU,
  output [31:0] io_rs1,
  output [31:0] io_rs2,
  output [31:0] io_imm,
  output        io_resultBranch,
  output [31:0] io_result
);
  wire  pcReg_clock; // @[Top.scala 25:23]
  wire  pcReg_reset; // @[Top.scala 25:23]
  wire [31:0] pcReg_io_addrOut; // @[Top.scala 25:23]
  wire  pcReg_io_ctrlJump; // @[Top.scala 25:23]
  wire  pcReg_io_ctrlBranch; // @[Top.scala 25:23]
  wire  pcReg_io_resultBranch; // @[Top.scala 25:23]
  wire [31:0] pcReg_io_addrTarget; // @[Top.scala 25:23]
  wire  memInst_clock; // @[Top.scala 26:25]
  wire [31:0] memInst_io_addr; // @[Top.scala 26:25]
  wire [31:0] memInst_io_inst; // @[Top.scala 26:25]
  wire [31:0] decoder_io_inst; // @[Top.scala 27:25]
  wire  decoder_io_bundleCtrl_ctrlJump; // @[Top.scala 27:25]
  wire  decoder_io_bundleCtrl_ctrlBranch; // @[Top.scala 27:25]
  wire  decoder_io_bundleCtrl_ctrlRegWrite; // @[Top.scala 27:25]
  wire  decoder_io_bundleCtrl_ctrlLoad; // @[Top.scala 27:25]
  wire  decoder_io_bundleCtrl_ctrlStore; // @[Top.scala 27:25]
  wire  decoder_io_bundleCtrl_ctrlALUSrc; // @[Top.scala 27:25]
  wire  decoder_io_bundleCtrl_ctrlJAL; // @[Top.scala 27:25]
  wire [3:0] decoder_io_bundleCtrl_ctrlOP; // @[Top.scala 27:25]
  wire  decoder_io_bundleCtrl_ctrlSigned; // @[Top.scala 27:25]
  wire [1:0] decoder_io_bundleCtrl_ctrlLSType; // @[Top.scala 27:25]
  wire [4:0] decoder_io_bundleReg_rs1; // @[Top.scala 27:25]
  wire [4:0] decoder_io_bundleReg_rs2; // @[Top.scala 27:25]
  wire [4:0] decoder_io_bundleReg_rd; // @[Top.scala 27:25]
  wire [31:0] decoder_io_imm; // @[Top.scala 27:25]
  wire  registers_clock; // @[Top.scala 28:27]
  wire  registers_io_ctrlRegWrite; // @[Top.scala 28:27]
  wire  registers_io_ctrlJump; // @[Top.scala 28:27]
  wire [31:0] registers_io_pc; // @[Top.scala 28:27]
  wire [31:0] registers_io_dataWrite; // @[Top.scala 28:27]
  wire [4:0] registers_io_bundleReg_rs1; // @[Top.scala 28:27]
  wire [4:0] registers_io_bundleReg_rs2; // @[Top.scala 28:27]
  wire [4:0] registers_io_bundleReg_rd; // @[Top.scala 28:27]
  wire [31:0] registers_io_dataRead1; // @[Top.scala 28:27]
  wire [31:0] registers_io_dataRead2; // @[Top.scala 28:27]
  wire  alu_io_bundleAluControl_ctrlALUSrc; // @[Top.scala 29:21]
  wire  alu_io_bundleAluControl_ctrlJAL; // @[Top.scala 29:21]
  wire [3:0] alu_io_bundleAluControl_ctrlOP; // @[Top.scala 29:21]
  wire  alu_io_bundleAluControl_ctrlSigned; // @[Top.scala 29:21]
  wire  alu_io_bundleAluControl_ctrlBranch; // @[Top.scala 29:21]
  wire [31:0] alu_io_dataRead1; // @[Top.scala 29:21]
  wire [31:0] alu_io_dataRead2; // @[Top.scala 29:21]
  wire [31:0] alu_io_imm; // @[Top.scala 29:21]
  wire [31:0] alu_io_pc; // @[Top.scala 29:21]
  wire  alu_io_resultBranch; // @[Top.scala 29:21]
  wire [31:0] alu_io_resultAlu; // @[Top.scala 29:21]
  wire  memData_clock; // @[Top.scala 30:25]
  wire  memData_io_bundleMemDataControl_ctrlLoad; // @[Top.scala 30:25]
  wire  memData_io_bundleMemDataControl_ctrlStore; // @[Top.scala 30:25]
  wire  memData_io_bundleMemDataControl_ctrlSigned; // @[Top.scala 30:25]
  wire [1:0] memData_io_bundleMemDataControl_ctrlLSType; // @[Top.scala 30:25]
  wire [31:0] memData_io_resultALU; // @[Top.scala 30:25]
  wire [31:0] memData_io_dataStore; // @[Top.scala 30:25]
  wire [31:0] memData_io_result; // @[Top.scala 30:25]
  wire  controller_io_bundleControlIn_ctrlJump; // @[Top.scala 31:28]
  wire  controller_io_bundleControlIn_ctrlBranch; // @[Top.scala 31:28]
  wire  controller_io_bundleControlIn_ctrlRegWrite; // @[Top.scala 31:28]
  wire  controller_io_bundleControlIn_ctrlLoad; // @[Top.scala 31:28]
  wire  controller_io_bundleControlIn_ctrlStore; // @[Top.scala 31:28]
  wire  controller_io_bundleControlIn_ctrlALUSrc; // @[Top.scala 31:28]
  wire  controller_io_bundleControlIn_ctrlJAL; // @[Top.scala 31:28]
  wire [3:0] controller_io_bundleControlIn_ctrlOP; // @[Top.scala 31:28]
  wire  controller_io_bundleControlIn_ctrlSigned; // @[Top.scala 31:28]
  wire  controller_io_bundleAluControl_ctrlALUSrc; // @[Top.scala 31:28]
  wire  controller_io_bundleAluControl_ctrlJAL; // @[Top.scala 31:28]
  wire [3:0] controller_io_bundleAluControl_ctrlOP; // @[Top.scala 31:28]
  wire  controller_io_bundleAluControl_ctrlSigned; // @[Top.scala 31:28]
  wire  controller_io_bundleAluControl_ctrlBranch; // @[Top.scala 31:28]
  wire  controller_io_bundleMemDataControl_ctrlLoad; // @[Top.scala 31:28]
  wire  controller_io_bundleMemDataControl_ctrlStore; // @[Top.scala 31:28]
  wire  controller_io_bundleMemDataControl_ctrlSigned; // @[Top.scala 31:28]
  wire [1:0] controller_io_bundleMemDataControl_ctrlLSType; // @[Top.scala 31:28]
  wire  controller_io_bundleControlOut_ctrlJump; // @[Top.scala 31:28]
  wire  controller_io_bundleControlOut_ctrlBranch; // @[Top.scala 31:28]
  wire  controller_io_bundleControlOut_ctrlRegWrite; // @[Top.scala 31:28]
  PCReg pcReg ( // @[Top.scala 25:23]
    .clock(pcReg_clock),
    .reset(pcReg_reset),
    .io_addrOut(pcReg_io_addrOut),
    .io_ctrlJump(pcReg_io_ctrlJump),
    .io_ctrlBranch(pcReg_io_ctrlBranch),
    .io_resultBranch(pcReg_io_resultBranch),
    .io_addrTarget(pcReg_io_addrTarget)
  );
  MemInst memInst ( // @[Top.scala 26:25]
    .clock(memInst_clock),
    .io_addr(memInst_io_addr),
    .io_inst(memInst_io_inst)
  );
  Decoder decoder ( // @[Top.scala 27:25]
    .io_inst(decoder_io_inst),
    .io_bundleCtrl_ctrlJump(decoder_io_bundleCtrl_ctrlJump),
    .io_bundleCtrl_ctrlBranch(decoder_io_bundleCtrl_ctrlBranch),
    .io_bundleCtrl_ctrlRegWrite(decoder_io_bundleCtrl_ctrlRegWrite),
    .io_bundleCtrl_ctrlLoad(decoder_io_bundleCtrl_ctrlLoad),
    .io_bundleCtrl_ctrlStore(decoder_io_bundleCtrl_ctrlStore),
    .io_bundleCtrl_ctrlALUSrc(decoder_io_bundleCtrl_ctrlALUSrc),
    .io_bundleCtrl_ctrlJAL(decoder_io_bundleCtrl_ctrlJAL),
    .io_bundleCtrl_ctrlOP(decoder_io_bundleCtrl_ctrlOP),
    .io_bundleCtrl_ctrlSigned(decoder_io_bundleCtrl_ctrlSigned),
    .io_bundleCtrl_ctrlLSType(decoder_io_bundleCtrl_ctrlLSType),
    .io_bundleReg_rs1(decoder_io_bundleReg_rs1),
    .io_bundleReg_rs2(decoder_io_bundleReg_rs2),
    .io_bundleReg_rd(decoder_io_bundleReg_rd),
    .io_imm(decoder_io_imm)
  );
  Registers registers ( // @[Top.scala 28:27]
    .clock(registers_clock),
    .io_ctrlRegWrite(registers_io_ctrlRegWrite),
    .io_ctrlJump(registers_io_ctrlJump),
    .io_pc(registers_io_pc),
    .io_dataWrite(registers_io_dataWrite),
    .io_bundleReg_rs1(registers_io_bundleReg_rs1),
    .io_bundleReg_rs2(registers_io_bundleReg_rs2),
    .io_bundleReg_rd(registers_io_bundleReg_rd),
    .io_dataRead1(registers_io_dataRead1),
    .io_dataRead2(registers_io_dataRead2)
  );
  Alu alu ( // @[Top.scala 29:21]
    .io_bundleAluControl_ctrlALUSrc(alu_io_bundleAluControl_ctrlALUSrc),
    .io_bundleAluControl_ctrlJAL(alu_io_bundleAluControl_ctrlJAL),
    .io_bundleAluControl_ctrlOP(alu_io_bundleAluControl_ctrlOP),
    .io_bundleAluControl_ctrlSigned(alu_io_bundleAluControl_ctrlSigned),
    .io_bundleAluControl_ctrlBranch(alu_io_bundleAluControl_ctrlBranch),
    .io_dataRead1(alu_io_dataRead1),
    .io_dataRead2(alu_io_dataRead2),
    .io_imm(alu_io_imm),
    .io_pc(alu_io_pc),
    .io_resultBranch(alu_io_resultBranch),
    .io_resultAlu(alu_io_resultAlu)
  );
  MemData memData ( // @[Top.scala 30:25]
    .clock(memData_clock),
    .io_bundleMemDataControl_ctrlLoad(memData_io_bundleMemDataControl_ctrlLoad),
    .io_bundleMemDataControl_ctrlStore(memData_io_bundleMemDataControl_ctrlStore),
    .io_bundleMemDataControl_ctrlSigned(memData_io_bundleMemDataControl_ctrlSigned),
    .io_bundleMemDataControl_ctrlLSType(memData_io_bundleMemDataControl_ctrlLSType),
    .io_resultALU(memData_io_resultALU),
    .io_dataStore(memData_io_dataStore),
    .io_result(memData_io_result)
  );
  Controller controller ( // @[Top.scala 31:28]
    .io_bundleControlIn_ctrlJump(controller_io_bundleControlIn_ctrlJump),
    .io_bundleControlIn_ctrlBranch(controller_io_bundleControlIn_ctrlBranch),
    .io_bundleControlIn_ctrlRegWrite(controller_io_bundleControlIn_ctrlRegWrite),
    .io_bundleControlIn_ctrlLoad(controller_io_bundleControlIn_ctrlLoad),
    .io_bundleControlIn_ctrlStore(controller_io_bundleControlIn_ctrlStore),
    .io_bundleControlIn_ctrlALUSrc(controller_io_bundleControlIn_ctrlALUSrc),
    .io_bundleControlIn_ctrlJAL(controller_io_bundleControlIn_ctrlJAL),
    .io_bundleControlIn_ctrlOP(controller_io_bundleControlIn_ctrlOP),
    .io_bundleControlIn_ctrlSigned(controller_io_bundleControlIn_ctrlSigned),
    .io_bundleAluControl_ctrlALUSrc(controller_io_bundleAluControl_ctrlALUSrc),
    .io_bundleAluControl_ctrlJAL(controller_io_bundleAluControl_ctrlJAL),
    .io_bundleAluControl_ctrlOP(controller_io_bundleAluControl_ctrlOP),
    .io_bundleAluControl_ctrlSigned(controller_io_bundleAluControl_ctrlSigned),
    .io_bundleAluControl_ctrlBranch(controller_io_bundleAluControl_ctrlBranch),
    .io_bundleMemDataControl_ctrlLoad(controller_io_bundleMemDataControl_ctrlLoad),
    .io_bundleMemDataControl_ctrlStore(controller_io_bundleMemDataControl_ctrlStore),
    .io_bundleMemDataControl_ctrlSigned(controller_io_bundleMemDataControl_ctrlSigned),
    .io_bundleMemDataControl_ctrlLSType(controller_io_bundleMemDataControl_ctrlLSType),
    .io_bundleControlOut_ctrlJump(controller_io_bundleControlOut_ctrlJump),
    .io_bundleControlOut_ctrlBranch(controller_io_bundleControlOut_ctrlBranch),
    .io_bundleControlOut_ctrlRegWrite(controller_io_bundleControlOut_ctrlRegWrite)
  );
  assign io_addr = pcReg_io_addrOut; // @[Top.scala 68:13]
  assign io_inst = memInst_io_inst; // @[Top.scala 70:13]
  assign io_bundleCtrl_ctrlJump = decoder_io_bundleCtrl_ctrlJump; // @[Top.scala 69:19]
  assign io_bundleCtrl_ctrlBranch = decoder_io_bundleCtrl_ctrlBranch; // @[Top.scala 69:19]
  assign io_bundleCtrl_ctrlRegWrite = decoder_io_bundleCtrl_ctrlRegWrite; // @[Top.scala 69:19]
  assign io_bundleCtrl_ctrlLoad = decoder_io_bundleCtrl_ctrlLoad; // @[Top.scala 69:19]
  assign io_bundleCtrl_ctrlStore = decoder_io_bundleCtrl_ctrlStore; // @[Top.scala 69:19]
  assign io_bundleCtrl_ctrlALUSrc = decoder_io_bundleCtrl_ctrlALUSrc; // @[Top.scala 69:19]
  assign io_bundleCtrl_ctrlJAL = decoder_io_bundleCtrl_ctrlJAL; // @[Top.scala 69:19]
  assign io_bundleCtrl_ctrlOP = decoder_io_bundleCtrl_ctrlOP; // @[Top.scala 69:19]
  assign io_bundleCtrl_ctrlSigned = decoder_io_bundleCtrl_ctrlSigned; // @[Top.scala 69:19]
  assign io_bundleCtrl_ctrlLSType = decoder_io_bundleCtrl_ctrlLSType; // @[Top.scala 69:19]
  assign io_resultALU = alu_io_resultAlu; // @[Top.scala 72:18]
  assign io_rs1 = registers_io_dataRead1; // @[Top.scala 75:12]
  assign io_rs2 = registers_io_dataRead2; // @[Top.scala 76:12]
  assign io_imm = decoder_io_imm; // @[Top.scala 74:12]
  assign io_resultBranch = alu_io_resultBranch; // @[Top.scala 73:21]
  assign io_result = memData_io_result; // @[Top.scala 71:15]
  assign pcReg_clock = clock;
  assign pcReg_reset = reset;
  assign pcReg_io_ctrlJump = controller_io_bundleControlOut_ctrlJump; // @[Top.scala 37:23]
  assign pcReg_io_ctrlBranch = controller_io_bundleControlOut_ctrlBranch; // @[Top.scala 36:25]
  assign pcReg_io_resultBranch = alu_io_resultBranch; // @[Top.scala 34:27]
  assign pcReg_io_addrTarget = memData_io_result; // @[Top.scala 35:25]
  assign memInst_clock = clock;
  assign memInst_io_addr = pcReg_io_addrOut; // @[Top.scala 40:21]
  assign decoder_io_inst = memInst_io_inst; // @[Top.scala 43:21]
  assign registers_clock = clock;
  assign registers_io_ctrlRegWrite = controller_io_bundleControlOut_ctrlRegWrite; // @[Top.scala 47:31]
  assign registers_io_ctrlJump = controller_io_bundleControlOut_ctrlJump; // @[Top.scala 48:27]
  assign registers_io_pc = pcReg_io_addrOut; // @[Top.scala 50:21]
  assign registers_io_dataWrite = memData_io_result; // @[Top.scala 49:28]
  assign registers_io_bundleReg_rs1 = decoder_io_bundleReg_rs1; // @[Top.scala 46:28]
  assign registers_io_bundleReg_rs2 = decoder_io_bundleReg_rs2; // @[Top.scala 46:28]
  assign registers_io_bundleReg_rd = decoder_io_bundleReg_rd; // @[Top.scala 46:28]
  assign alu_io_bundleAluControl_ctrlALUSrc = controller_io_bundleAluControl_ctrlALUSrc; // @[Top.scala 53:29]
  assign alu_io_bundleAluControl_ctrlJAL = controller_io_bundleAluControl_ctrlJAL; // @[Top.scala 53:29]
  assign alu_io_bundleAluControl_ctrlOP = controller_io_bundleAluControl_ctrlOP; // @[Top.scala 53:29]
  assign alu_io_bundleAluControl_ctrlSigned = controller_io_bundleAluControl_ctrlSigned; // @[Top.scala 53:29]
  assign alu_io_bundleAluControl_ctrlBranch = controller_io_bundleAluControl_ctrlBranch; // @[Top.scala 53:29]
  assign alu_io_dataRead1 = registers_io_dataRead1; // @[Top.scala 54:22]
  assign alu_io_dataRead2 = registers_io_dataRead2; // @[Top.scala 55:22]
  assign alu_io_imm = decoder_io_imm; // @[Top.scala 56:16]
  assign alu_io_pc = pcReg_io_addrOut; // @[Top.scala 57:15]
  assign memData_clock = clock;
  assign memData_io_bundleMemDataControl_ctrlLoad = controller_io_bundleMemDataControl_ctrlLoad; // @[Top.scala 60:37]
  assign memData_io_bundleMemDataControl_ctrlStore = controller_io_bundleMemDataControl_ctrlStore; // @[Top.scala 60:37]
  assign memData_io_bundleMemDataControl_ctrlSigned = controller_io_bundleMemDataControl_ctrlSigned; // @[Top.scala 60:37]
  assign memData_io_bundleMemDataControl_ctrlLSType = controller_io_bundleMemDataControl_ctrlLSType; // @[Top.scala 60:37]
  assign memData_io_resultALU = alu_io_resultAlu; // @[Top.scala 62:26]
  assign memData_io_dataStore = registers_io_dataRead2; // @[Top.scala 61:26]
  assign controller_io_bundleControlIn_ctrlJump = decoder_io_bundleCtrl_ctrlJump; // @[Top.scala 65:35]
  assign controller_io_bundleControlIn_ctrlBranch = decoder_io_bundleCtrl_ctrlBranch; // @[Top.scala 65:35]
  assign controller_io_bundleControlIn_ctrlRegWrite = decoder_io_bundleCtrl_ctrlRegWrite; // @[Top.scala 65:35]
  assign controller_io_bundleControlIn_ctrlLoad = decoder_io_bundleCtrl_ctrlLoad; // @[Top.scala 65:35]
  assign controller_io_bundleControlIn_ctrlStore = decoder_io_bundleCtrl_ctrlStore; // @[Top.scala 65:35]
  assign controller_io_bundleControlIn_ctrlALUSrc = decoder_io_bundleCtrl_ctrlALUSrc; // @[Top.scala 65:35]
  assign controller_io_bundleControlIn_ctrlJAL = decoder_io_bundleCtrl_ctrlJAL; // @[Top.scala 65:35]
  assign controller_io_bundleControlIn_ctrlOP = decoder_io_bundleCtrl_ctrlOP; // @[Top.scala 65:35]
  assign controller_io_bundleControlIn_ctrlSigned = decoder_io_bundleCtrl_ctrlSigned; // @[Top.scala 65:35]
endmodule
