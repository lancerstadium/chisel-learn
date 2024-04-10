circuit Top :
  module PCReg :
    input clock : Clock
    input reset : UInt<1>
    output io_addrOut : UInt<32>
    input io_ctrlJump : UInt<1>
    input io_ctrlBranch : UInt<1>
    input io_resultBranch : UInt<1>
    input io_addrTarget : UInt<32>

    reg regPC : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regPC) @[PCReg.scala 29:24]
    node _T = and(io_ctrlBranch, io_resultBranch) @[PCReg.scala 31:41]
    node _T_1 = or(io_ctrlJump, _T) @[PCReg.scala 31:23]
    node _regPC_T = add(regPC, UInt<3>("h4")) @[PCReg.scala 36:24]
    node _regPC_T_1 = tail(_regPC_T, 1) @[PCReg.scala 36:24]
    node _GEN_0 = mux(_T_1, io_addrTarget, _regPC_T_1) @[PCReg.scala 31:62 33:15 36:15]
    io_addrOut <= regPC @[PCReg.scala 39:16]
    regPC <= mux(reset, UInt<1>("h0"), _GEN_0) @[PCReg.scala 29:{24,24}]

  module MemInst :
    input clock : Clock
    input reset : UInt<1>
    input io_addr : UInt<32>
    output io_inst : UInt<32>

    mem mem : @[MemInst.scala 20:18]
      data-type => UInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => io_inst_MPORT
      read-under-write => undefined
    node _io_inst_T = dshr(io_addr, UInt<2>("h2")) @[MemInst.scala 27:33]
    node _io_inst_T_1 = bits(_io_inst_T, 9, 0) @[MemInst.scala 27:24]
    io_inst <= mem.io_inst_MPORT.data @[MemInst.scala 27:13]
    mem.io_inst_MPORT.addr <= _io_inst_T_1 @[MemInst.scala 27:24]
    mem.io_inst_MPORT.en <= UInt<1>("h1") @[MemInst.scala 27:24]
    mem.io_inst_MPORT.clk <= clock @[MemInst.scala 27:24]

  module Decoder :
    input clock : Clock
    input reset : UInt<1>
    input io_inst : UInt<32>
    output io_bundleCtrl_ctrlJump : UInt<1>
    output io_bundleCtrl_ctrlBranch : UInt<1>
    output io_bundleCtrl_ctrlRegWrite : UInt<1>
    output io_bundleCtrl_ctrlLoad : UInt<1>
    output io_bundleCtrl_ctrlStore : UInt<1>
    output io_bundleCtrl_ctrlALUSrc : UInt<1>
    output io_bundleCtrl_ctrlJAL : UInt<1>
    output io_bundleCtrl_ctrlOP : UInt<4>
    output io_bundleCtrl_ctrlSigned : UInt<1>
    output io_bundleCtrl_ctrlLSType : UInt<2>
    output io_bundleReg_rs1 : UInt<5>
    output io_bundleReg_rs2 : UInt<5>
    output io_bundleReg_rd : UInt<5>
    output io_imm : UInt<32>

    node _io_bundleReg_rs1_T = bits(io_inst, 19, 15) @[Decoder.scala 23:32]
    node _io_bundleReg_rs2_T = bits(io_inst, 24, 20) @[Decoder.scala 24:32]
    node _io_bundleReg_rd_T = bits(io_inst, 11, 7) @[Decoder.scala 25:31]
    node _imm_i_T = bits(io_inst, 31, 31) @[Decoder.scala 28:37]
    node _imm_i_T_1 = bits(_imm_i_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_i_T_2 = mux(_imm_i_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_i_T_3 = bits(io_inst, 31, 20) @[Decoder.scala 28:51]
    node imm_i = cat(_imm_i_T_2, _imm_i_T_3) @[Cat.scala 31:58]
    node _imm_s_T = bits(io_inst, 31, 31) @[Decoder.scala 29:37]
    node _imm_s_T_1 = bits(_imm_s_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_s_T_2 = mux(_imm_s_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_s_T_3 = bits(io_inst, 31, 25) @[Decoder.scala 29:51]
    node _imm_s_T_4 = bits(io_inst, 11, 7) @[Decoder.scala 29:68]
    node imm_s_hi = cat(_imm_s_T_2, _imm_s_T_3) @[Cat.scala 31:58]
    node imm_s = cat(imm_s_hi, _imm_s_T_4) @[Cat.scala 31:58]
    node _imm_b_T = bits(io_inst, 31, 31) @[Decoder.scala 30:37]
    node _imm_b_T_1 = bits(_imm_b_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_b_T_2 = mux(_imm_b_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_b_T_3 = bits(io_inst, 7, 7) @[Decoder.scala 30:51]
    node _imm_b_T_4 = bits(io_inst, 30, 25) @[Decoder.scala 30:63]
    node _imm_b_T_5 = bits(io_inst, 11, 8) @[Decoder.scala 30:80]
    node imm_b_lo = cat(_imm_b_T_5, UInt<1>("h0")) @[Cat.scala 31:58]
    node imm_b_hi_hi = cat(_imm_b_T_2, _imm_b_T_3) @[Cat.scala 31:58]
    node imm_b_hi = cat(imm_b_hi_hi, _imm_b_T_4) @[Cat.scala 31:58]
    node imm_b = cat(imm_b_hi, imm_b_lo) @[Cat.scala 31:58]
    node _imm_u_T = bits(io_inst, 31, 12) @[Decoder.scala 31:28]
    node _imm_u_T_1 = mux(UInt<1>("h0"), UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 74:12]
    node imm_u = cat(_imm_u_T, _imm_u_T_1) @[Cat.scala 31:58]
    node _imm_j_T = bits(io_inst, 31, 31) @[Decoder.scala 32:37]
    node _imm_j_T_1 = bits(_imm_j_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_j_T_2 = mux(_imm_j_T_1, UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 74:12]
    node _imm_j_T_3 = bits(io_inst, 31, 31) @[Decoder.scala 32:51]
    node _imm_j_T_4 = bits(io_inst, 19, 12) @[Decoder.scala 32:64]
    node _imm_j_T_5 = bits(io_inst, 20, 20) @[Decoder.scala 32:81]
    node _imm_j_T_6 = bits(io_inst, 30, 21) @[Decoder.scala 32:94]
    node imm_j_lo_hi = cat(_imm_j_T_5, _imm_j_T_6) @[Cat.scala 31:58]
    node imm_j_lo = cat(imm_j_lo_hi, UInt<1>("h0")) @[Cat.scala 31:58]
    node imm_j_hi_hi = cat(_imm_j_T_2, _imm_j_T_3) @[Cat.scala 31:58]
    node imm_j_hi = cat(imm_j_hi_hi, _imm_j_T_4) @[Cat.scala 31:58]
    node imm_j = cat(imm_j_hi, imm_j_lo) @[Cat.scala 31:58]
    node _imm_shamt_T = mux(UInt<1>("h0"), UInt<27>("h7ffffff"), UInt<27>("h0")) @[Bitwise.scala 74:12]
    node _imm_shamt_T_1 = bits(io_inst, 24, 20) @[Decoder.scala 34:47]
    node imm_shamt = cat(_imm_shamt_T, _imm_shamt_T_1) @[Cat.scala 31:58]
    node _T = bits(io_inst, 6, 2) @[Decoder.scala 52:20]
    node _T_1 = eq(UInt<4>("hd"), _T) @[Decoder.scala 52:28]
    node _T_2 = eq(UInt<3>("h5"), _T) @[Decoder.scala 52:28]
    node _T_3 = or(_T_1, _T_2) @[Decoder.scala 52:28]
    node _T_4 = eq(UInt<5>("h1b"), _T) @[Decoder.scala 52:28]
    node _T_5 = eq(UInt<5>("h19"), _T) @[Decoder.scala 52:28]
    node _T_6 = eq(UInt<1>("h0"), _T) @[Decoder.scala 52:28]
    node _T_7 = eq(UInt<3>("h4"), _T) @[Decoder.scala 52:28]
    node _T_8 = or(_T_5, _T_6) @[Decoder.scala 52:28]
    node _T_9 = or(_T_8, _T_7) @[Decoder.scala 52:28]
    node _T_10 = bits(io_inst, 6, 2) @[Decoder.scala 73:26]
    node _T_11 = eq(_T_10, UInt<5>("h19")) @[Decoder.scala 73:33]
    node _T_12 = bits(io_inst, 6, 2) @[Decoder.scala 79:31]
    node _T_13 = eq(_T_12, UInt<1>("h0")) @[Decoder.scala 79:38]
    node _T_14 = bits(io_inst, 14, 12) @[Decoder.scala 83:30]
    node _T_15 = eq(_T_14, UInt<3>("h4")) @[Decoder.scala 83:39]
    node _T_16 = bits(io_inst, 14, 12) @[Decoder.scala 83:61]
    node _T_17 = eq(_T_16, UInt<3>("h5")) @[Decoder.scala 83:70]
    node _T_18 = or(_T_15, _T_17) @[Decoder.scala 83:52]
    node _GEN_0 = mux(_T_18, UInt<1>("h0"), UInt<1>("h1")) @[Decoder.scala 83:84 84:32]
    node _T_19 = bits(io_inst, 6, 2) @[Decoder.scala 88:31]
    node _T_20 = eq(_T_19, UInt<3>("h4")) @[Decoder.scala 88:38]
    node _T_21 = bits(io_inst, 14, 12) @[Decoder.scala 88:64]
    node _T_22 = eq(_T_21, UInt<1>("h1")) @[Decoder.scala 88:73]
    node _T_23 = bits(io_inst, 14, 12) @[Decoder.scala 88:96]
    node _T_24 = eq(_T_23, UInt<3>("h5")) @[Decoder.scala 88:105]
    node _T_25 = or(_T_22, _T_24) @[Decoder.scala 88:86]
    node _T_26 = and(_T_20, _T_25) @[Decoder.scala 88:53]
    node _T_27 = bits(io_inst, 30, 30) @[Decoder.scala 90:36]
    node _T_28 = bits(io_inst, 14, 12) @[Decoder.scala 90:49]
    node _T_29 = cat(_T_27, _T_28) @[Cat.scala 31:58]
    node _T_30 = eq(UInt<1>("h1"), _T_29) @[Decoder.scala 90:60]
    node _T_31 = eq(UInt<3>("h5"), _T_29) @[Decoder.scala 90:60]
    node _T_32 = eq(UInt<4>("hd"), _T_29) @[Decoder.scala 90:60]
    node _GEN_1 = mux(_T_32, UInt<4>("hb"), UInt<4>("h0")) @[Decoder.scala 101:32 90:60]
    node _GEN_2 = mux(_T_31, UInt<4>("h9"), _GEN_1) @[Decoder.scala 90:60 97:32]
    node _GEN_3 = mux(_T_30, UInt<4>("h8"), _GEN_2) @[Decoder.scala 90:60 93:32]
    node _T_33 = bits(io_inst, 14, 12) @[Decoder.scala 106:32]
    node _T_34 = eq(UInt<1>("h0"), _T_33) @[Decoder.scala 106:42]
    node _T_35 = eq(UInt<2>("h2"), _T_33) @[Decoder.scala 106:42]
    node _T_36 = eq(UInt<2>("h3"), _T_33) @[Decoder.scala 106:42]
    node _T_37 = eq(UInt<3>("h4"), _T_33) @[Decoder.scala 106:42]
    node _T_38 = eq(UInt<3>("h6"), _T_33) @[Decoder.scala 106:42]
    node _T_39 = eq(UInt<3>("h7"), _T_33) @[Decoder.scala 106:42]
    node _GEN_4 = mux(_T_39, UInt<3>("h4"), UInt<4>("h0")) @[Decoder.scala 106:42 130:32]
    node _GEN_5 = mux(_T_38, UInt<3>("h5"), _GEN_4) @[Decoder.scala 106:42 126:32]
    node _GEN_6 = mux(_T_37, UInt<3>("h7"), _GEN_5) @[Decoder.scala 106:42 122:32]
    node _GEN_7 = mux(_T_36, UInt<4>("he"), _GEN_6) @[Decoder.scala 106:42 117:32]
    node _GEN_8 = mux(_T_36, UInt<1>("h0"), UInt<1>("h1")) @[Decoder.scala 106:42 118:36]
    node _GEN_9 = mux(_T_35, UInt<4>("he"), _GEN_7) @[Decoder.scala 106:42 113:32]
    node _GEN_10 = mux(_T_35, UInt<1>("h1"), _GEN_8) @[Decoder.scala 106:42]
    node _GEN_11 = mux(_T_34, UInt<1>("h1"), _GEN_9) @[Decoder.scala 106:42 109:32]
    node _GEN_12 = mux(_T_34, UInt<1>("h1"), _GEN_10) @[Decoder.scala 106:42]
    node _GEN_13 = mux(_T_26, imm_shamt, imm_i) @[Decoder.scala 88:120 105:21 89:21]
    node _GEN_14 = mux(_T_26, _GEN_3, _GEN_11) @[Decoder.scala 88:120]
    node _GEN_15 = mux(_T_26, UInt<1>("h1"), _GEN_12) @[Decoder.scala 88:120]
    node _GEN_16 = mux(_T_13, UInt<1>("h1"), UInt<1>("h0")) @[Decoder.scala 79:54 80:26]
    node _GEN_17 = mux(_T_13, UInt<1>("h1"), _GEN_14) @[Decoder.scala 79:54 81:24]
    node _GEN_18 = mux(_T_13, imm_i, _GEN_13) @[Decoder.scala 79:54 82:21]
    node _GEN_19 = mux(_T_13, _GEN_0, _GEN_15) @[Decoder.scala 79:54]
    node _GEN_20 = mux(_T_11, UInt<1>("h1"), UInt<1>("h0")) @[Decoder.scala 73:49 74:26]
    node _GEN_21 = mux(_T_11, UInt<1>("h1"), _GEN_17) @[Decoder.scala 73:49 75:24]
    node _GEN_22 = mux(_T_11, imm_i, _GEN_18) @[Decoder.scala 73:49 76:21]
    node _GEN_23 = mux(_T_11, UInt<1>("h0"), _GEN_16) @[Decoder.scala 73:49]
    node _GEN_24 = mux(_T_11, UInt<1>("h1"), _GEN_19) @[Decoder.scala 73:49]
    node _T_40 = eq(UInt<5>("h18"), _T) @[Decoder.scala 52:28]
    node _T_41 = bits(io_inst, 14, 12) @[Decoder.scala 141:28]
    node _T_42 = eq(UInt<1>("h0"), _T_41) @[Decoder.scala 141:38]
    node _T_43 = eq(UInt<1>("h1"), _T_41) @[Decoder.scala 141:38]
    node _T_44 = eq(UInt<3>("h4"), _T_41) @[Decoder.scala 141:38]
    node _T_45 = eq(UInt<3>("h5"), _T_41) @[Decoder.scala 141:38]
    node _T_46 = eq(UInt<3>("h6"), _T_41) @[Decoder.scala 141:38]
    node _T_47 = eq(UInt<3>("h7"), _T_41) @[Decoder.scala 141:38]
    node _GEN_25 = mux(_T_47, UInt<4>("hf"), UInt<4>("h0")) @[Decoder.scala 141:38 165:28]
    node _GEN_26 = mux(_T_47, UInt<1>("h0"), UInt<1>("h1")) @[Decoder.scala 141:38 166:32]
    node _GEN_27 = mux(_T_46, UInt<4>("he"), _GEN_25) @[Decoder.scala 141:38 160:28]
    node _GEN_28 = mux(_T_46, UInt<1>("h0"), _GEN_26) @[Decoder.scala 141:38 161:32]
    node _GEN_29 = mux(_T_45, UInt<4>("hf"), _GEN_27) @[Decoder.scala 141:38 156:28]
    node _GEN_30 = mux(_T_45, UInt<1>("h1"), _GEN_28) @[Decoder.scala 141:38]
    node _GEN_31 = mux(_T_44, UInt<4>("he"), _GEN_29) @[Decoder.scala 141:38 152:28]
    node _GEN_32 = mux(_T_44, UInt<1>("h1"), _GEN_30) @[Decoder.scala 141:38]
    node _GEN_33 = mux(_T_43, UInt<4>("hd"), _GEN_31) @[Decoder.scala 141:38 148:28]
    node _GEN_34 = mux(_T_43, UInt<1>("h1"), _GEN_32) @[Decoder.scala 141:38]
    node _GEN_35 = mux(_T_42, UInt<4>("hc"), _GEN_33) @[Decoder.scala 141:38 144:28]
    node _GEN_36 = mux(_T_42, UInt<1>("h1"), _GEN_34) @[Decoder.scala 141:38]
    node _T_48 = eq(UInt<4>("h8"), _T) @[Decoder.scala 52:28]
    node _T_49 = bits(io_inst, 14, 12) @[Decoder.scala 177:26]
    node _T_50 = eq(_T_49, UInt<1>("h0")) @[Decoder.scala 177:35]
    node _GEN_37 = mux(_T_50, UInt<1>("h0"), UInt<2>("h0")) @[Decoder.scala 177:49 178:28]
    node _T_51 = bits(io_inst, 14, 12) @[Decoder.scala 180:26]
    node _T_52 = eq(_T_51, UInt<1>("h1")) @[Decoder.scala 180:35]
    node _GEN_38 = mux(_T_52, UInt<1>("h1"), _GEN_37) @[Decoder.scala 180:49 181:28]
    node _T_53 = eq(UInt<4>("hc"), _T) @[Decoder.scala 52:28]
    node _T_54 = bits(io_inst, 14, 12) @[Decoder.scala 186:28]
    node _T_55 = eq(UInt<1>("h0"), _T_54) @[Decoder.scala 186:38]
    node _T_56 = bits(io_inst, 30, 30) @[Decoder.scala 189:34]
    node _GEN_39 = mux(_T_56, UInt<2>("h2"), UInt<1>("h1")) @[Decoder.scala 189:40 190:32 192:32]
    node _T_57 = eq(UInt<1>("h1"), _T_54) @[Decoder.scala 186:38]
    node _T_58 = eq(UInt<2>("h2"), _T_54) @[Decoder.scala 186:38]
    node _T_59 = eq(UInt<2>("h3"), _T_54) @[Decoder.scala 186:38]
    node _T_60 = eq(UInt<3>("h4"), _T_54) @[Decoder.scala 186:38]
    node _T_61 = eq(UInt<3>("h5"), _T_54) @[Decoder.scala 186:38]
    node _T_62 = bits(io_inst, 30, 30) @[Decoder.scala 214:34]
    node _GEN_40 = mux(_T_62, UInt<4>("hb"), UInt<4>("h9")) @[Decoder.scala 214:40 215:32 217:32]
    node _T_63 = eq(UInt<3>("h6"), _T_54) @[Decoder.scala 186:38]
    node _T_64 = eq(UInt<3>("h7"), _T_54) @[Decoder.scala 186:38]
    node _GEN_41 = mux(_T_64, UInt<3>("h4"), UInt<4>("h0")) @[Decoder.scala 186:38 226:28]
    node _GEN_42 = mux(_T_63, UInt<3>("h5"), _GEN_41) @[Decoder.scala 186:38 222:28]
    node _GEN_43 = mux(_T_61, _GEN_40, _GEN_42) @[Decoder.scala 186:38]
    node _GEN_44 = mux(_T_60, UInt<3>("h7"), _GEN_43) @[Decoder.scala 186:38 210:28]
    node _GEN_45 = mux(_T_59, UInt<1>("h0"), _GEN_44) @[Decoder.scala 186:38 206:28]
    node _GEN_46 = mux(_T_58, UInt<4>("he"), _GEN_45) @[Decoder.scala 186:38 201:28]
    node _GEN_47 = mux(_T_57, UInt<4>("h8"), _GEN_46) @[Decoder.scala 186:38 197:28]
    node _GEN_48 = mux(_T_55, _GEN_39, _GEN_47) @[Decoder.scala 186:38]
    node _GEN_49 = mux(_T_53, _GEN_48, UInt<4>("h0")) @[Decoder.scala 52:28]
    node _GEN_50 = mux(_T_48, UInt<1>("h1"), UInt<1>("h0")) @[Decoder.scala 172:24 52:28]
    node _GEN_51 = mux(_T_48, UInt<1>("h0"), UInt<1>("h1")) @[Decoder.scala 174:26 52:28]
    node _GEN_52 = mux(_T_48, UInt<1>("h1"), _GEN_49) @[Decoder.scala 175:20 52:28]
    node _GEN_53 = mux(_T_48, imm_s, UInt<32>("h0")) @[Decoder.scala 176:17 52:28]
    node _GEN_54 = mux(_T_48, _GEN_38, UInt<2>("h0")) @[Decoder.scala 52:28]
    node _GEN_55 = mux(_T_40, UInt<1>("h0"), _GEN_50) @[Decoder.scala 137:24 52:28]
    node _GEN_56 = mux(_T_40, UInt<1>("h1"), UInt<1>("h0")) @[Decoder.scala 138:24 52:28]
    node _GEN_57 = mux(_T_40, UInt<1>("h0"), _GEN_51) @[Decoder.scala 139:26 52:28]
    node _GEN_58 = mux(_T_40, imm_b, _GEN_53) @[Decoder.scala 140:17 52:28]
    node _GEN_59 = mux(_T_40, _GEN_35, _GEN_52) @[Decoder.scala 52:28]
    node _GEN_60 = mux(_T_40, _GEN_36, UInt<1>("h1")) @[Decoder.scala 52:28]
    node _GEN_61 = mux(_T_40, UInt<2>("h0"), _GEN_54) @[Decoder.scala 52:28]
    node _GEN_62 = mux(_T_9, UInt<1>("h1"), _GEN_55) @[Decoder.scala 52:28 71:24]
    node _GEN_63 = mux(_T_9, _GEN_20, UInt<1>("h0")) @[Decoder.scala 52:28]
    node _GEN_64 = mux(_T_9, _GEN_21, _GEN_59) @[Decoder.scala 52:28]
    node _GEN_65 = mux(_T_9, _GEN_22, _GEN_58) @[Decoder.scala 52:28]
    node _GEN_66 = mux(_T_9, _GEN_23, UInt<1>("h0")) @[Decoder.scala 52:28]
    node _GEN_67 = mux(_T_9, _GEN_24, _GEN_60) @[Decoder.scala 52:28]
    node _GEN_68 = mux(_T_9, UInt<1>("h0"), _GEN_56) @[Decoder.scala 52:28]
    node _GEN_69 = mux(_T_9, UInt<1>("h1"), _GEN_57) @[Decoder.scala 52:28]
    node _GEN_70 = mux(_T_9, UInt<1>("h0"), _GEN_55) @[Decoder.scala 52:28]
    node _GEN_71 = mux(_T_9, UInt<2>("h0"), _GEN_61) @[Decoder.scala 52:28]
    node _GEN_72 = mux(_T_4, UInt<1>("h1"), _GEN_62) @[Decoder.scala 52:28 61:24]
    node _GEN_73 = mux(_T_4, UInt<1>("h1"), _GEN_63) @[Decoder.scala 52:28 62:22]
    node _GEN_74 = mux(_T_4, UInt<1>("h1"), _GEN_64) @[Decoder.scala 52:28 63:20]
    node _GEN_75 = mux(_T_4, UInt<1>("h1"), UInt<1>("h0")) @[Decoder.scala 52:28 64:21]
    node _GEN_76 = mux(_T_4, imm_j, _GEN_65) @[Decoder.scala 52:28 65:17]
    node _GEN_77 = mux(_T_4, UInt<1>("h0"), _GEN_66) @[Decoder.scala 52:28]
    node _GEN_78 = mux(_T_4, UInt<1>("h1"), _GEN_67) @[Decoder.scala 52:28]
    node _GEN_79 = mux(_T_4, UInt<1>("h0"), _GEN_68) @[Decoder.scala 52:28]
    node _GEN_80 = mux(_T_4, UInt<1>("h1"), _GEN_69) @[Decoder.scala 52:28]
    node _GEN_81 = mux(_T_4, UInt<1>("h0"), _GEN_70) @[Decoder.scala 52:28]
    node _GEN_82 = mux(_T_4, UInt<2>("h0"), _GEN_71) @[Decoder.scala 52:28]
    node _GEN_83 = mux(_T_3, UInt<1>("h1"), _GEN_72) @[Decoder.scala 52:28 55:24]
    node _GEN_84 = mux(_T_3, UInt<1>("h1"), _GEN_74) @[Decoder.scala 52:28 56:20]
    node _GEN_85 = mux(_T_3, imm_u, _GEN_76) @[Decoder.scala 52:28 57:17]
    node _GEN_86 = mux(_T_3, UInt<1>("h0"), _GEN_73) @[Decoder.scala 52:28]
    node _GEN_87 = mux(_T_3, UInt<1>("h0"), _GEN_75) @[Decoder.scala 52:28]
    node _GEN_88 = mux(_T_3, UInt<1>("h0"), _GEN_77) @[Decoder.scala 52:28]
    node _GEN_89 = mux(_T_3, UInt<1>("h1"), _GEN_78) @[Decoder.scala 52:28]
    node _GEN_90 = mux(_T_3, UInt<1>("h0"), _GEN_79) @[Decoder.scala 52:28]
    node _GEN_91 = mux(_T_3, UInt<1>("h1"), _GEN_80) @[Decoder.scala 52:28]
    node _GEN_92 = mux(_T_3, UInt<1>("h0"), _GEN_81) @[Decoder.scala 52:28]
    node _GEN_93 = mux(_T_3, UInt<2>("h0"), _GEN_82) @[Decoder.scala 52:28]
    node imm = bits(_GEN_85, 31, 0)
    node ctrlJump = _GEN_86
    node ctrlBranch = _GEN_90
    node ctrlRegWrite = _GEN_91
    node ctrlLoad = _GEN_88
    node ctrlStore = _GEN_92
    node ctrlALUSrc = _GEN_83
    node ctrlJAL = _GEN_87
    node ctrlOP = _GEN_84
    node ctrlSigned = _GEN_89
    node ctrlLSType = _GEN_93
    io_bundleCtrl_ctrlJump <= ctrlJump @[Decoder.scala 236:28]
    io_bundleCtrl_ctrlBranch <= ctrlBranch @[Decoder.scala 234:30]
    io_bundleCtrl_ctrlRegWrite <= ctrlRegWrite @[Decoder.scala 239:32]
    io_bundleCtrl_ctrlLoad <= ctrlLoad @[Decoder.scala 237:28]
    io_bundleCtrl_ctrlStore <= ctrlStore @[Decoder.scala 241:29]
    io_bundleCtrl_ctrlALUSrc <= ctrlALUSrc @[Decoder.scala 233:30]
    io_bundleCtrl_ctrlJAL <= ctrlJAL @[Decoder.scala 235:27]
    io_bundleCtrl_ctrlOP <= ctrlOP @[Decoder.scala 238:26]
    io_bundleCtrl_ctrlSigned <= ctrlSigned @[Decoder.scala 240:30]
    io_bundleCtrl_ctrlLSType <= ctrlLSType @[Decoder.scala 242:30]
    io_bundleReg_rs1 <= _io_bundleReg_rs1_T @[Decoder.scala 23:22]
    io_bundleReg_rs2 <= _io_bundleReg_rs2_T @[Decoder.scala 24:22]
    io_bundleReg_rd <= _io_bundleReg_rd_T @[Decoder.scala 25:21]
    io_imm <= imm @[Decoder.scala 243:12]

  module Registers :
    input clock : Clock
    input reset : UInt<1>
    input io_ctrlRegWrite : UInt<1>
    input io_ctrlJump : UInt<1>
    input io_pc : UInt<32>
    input io_dataWrite : UInt<32>
    input io_bundleReg_rs1 : UInt<5>
    input io_bundleReg_rs2 : UInt<5>
    input io_bundleReg_rd : UInt<5>
    output io_dataRead1 : UInt<32>
    output io_dataRead2 : UInt<32>

    reg regs_0 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_0) @[Registers.scala 23:19]
    reg regs_1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_1) @[Registers.scala 23:19]
    reg regs_2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_2) @[Registers.scala 23:19]
    reg regs_3 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_3) @[Registers.scala 23:19]
    reg regs_4 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_4) @[Registers.scala 23:19]
    reg regs_5 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_5) @[Registers.scala 23:19]
    reg regs_6 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_6) @[Registers.scala 23:19]
    reg regs_7 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_7) @[Registers.scala 23:19]
    reg regs_8 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_8) @[Registers.scala 23:19]
    reg regs_9 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_9) @[Registers.scala 23:19]
    reg regs_10 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_10) @[Registers.scala 23:19]
    reg regs_11 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_11) @[Registers.scala 23:19]
    reg regs_12 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_12) @[Registers.scala 23:19]
    reg regs_13 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_13) @[Registers.scala 23:19]
    reg regs_14 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_14) @[Registers.scala 23:19]
    reg regs_15 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_15) @[Registers.scala 23:19]
    reg regs_16 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_16) @[Registers.scala 23:19]
    reg regs_17 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_17) @[Registers.scala 23:19]
    reg regs_18 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_18) @[Registers.scala 23:19]
    reg regs_19 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_19) @[Registers.scala 23:19]
    reg regs_20 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_20) @[Registers.scala 23:19]
    reg regs_21 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_21) @[Registers.scala 23:19]
    reg regs_22 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_22) @[Registers.scala 23:19]
    reg regs_23 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_23) @[Registers.scala 23:19]
    reg regs_24 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_24) @[Registers.scala 23:19]
    reg regs_25 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_25) @[Registers.scala 23:19]
    reg regs_26 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_26) @[Registers.scala 23:19]
    reg regs_27 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_27) @[Registers.scala 23:19]
    reg regs_28 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_28) @[Registers.scala 23:19]
    reg regs_29 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_29) @[Registers.scala 23:19]
    reg regs_30 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_30) @[Registers.scala 23:19]
    reg regs_31 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_31) @[Registers.scala 23:19]
    node _T = eq(io_bundleReg_rs1, UInt<1>("h0")) @[Registers.scala 26:27]
    node _T_1 = eq(io_bundleReg_rs2, UInt<1>("h0")) @[Registers.scala 29:27]
    node _GEN_0 = validif(eq(UInt<1>("h0"), io_bundleReg_rs1), regs_0) @[Registers.scala 33:{18,18}]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_bundleReg_rs1), regs_1, _GEN_0) @[Registers.scala 33:{18,18}]
    node _GEN_2 = mux(eq(UInt<2>("h2"), io_bundleReg_rs1), regs_2, _GEN_1) @[Registers.scala 33:{18,18}]
    node _GEN_3 = mux(eq(UInt<2>("h3"), io_bundleReg_rs1), regs_3, _GEN_2) @[Registers.scala 33:{18,18}]
    node _GEN_4 = mux(eq(UInt<3>("h4"), io_bundleReg_rs1), regs_4, _GEN_3) @[Registers.scala 33:{18,18}]
    node _GEN_5 = mux(eq(UInt<3>("h5"), io_bundleReg_rs1), regs_5, _GEN_4) @[Registers.scala 33:{18,18}]
    node _GEN_6 = mux(eq(UInt<3>("h6"), io_bundleReg_rs1), regs_6, _GEN_5) @[Registers.scala 33:{18,18}]
    node _GEN_7 = mux(eq(UInt<3>("h7"), io_bundleReg_rs1), regs_7, _GEN_6) @[Registers.scala 33:{18,18}]
    node _GEN_8 = mux(eq(UInt<4>("h8"), io_bundleReg_rs1), regs_8, _GEN_7) @[Registers.scala 33:{18,18}]
    node _GEN_9 = mux(eq(UInt<4>("h9"), io_bundleReg_rs1), regs_9, _GEN_8) @[Registers.scala 33:{18,18}]
    node _GEN_10 = mux(eq(UInt<4>("ha"), io_bundleReg_rs1), regs_10, _GEN_9) @[Registers.scala 33:{18,18}]
    node _GEN_11 = mux(eq(UInt<4>("hb"), io_bundleReg_rs1), regs_11, _GEN_10) @[Registers.scala 33:{18,18}]
    node _GEN_12 = mux(eq(UInt<4>("hc"), io_bundleReg_rs1), regs_12, _GEN_11) @[Registers.scala 33:{18,18}]
    node _GEN_13 = mux(eq(UInt<4>("hd"), io_bundleReg_rs1), regs_13, _GEN_12) @[Registers.scala 33:{18,18}]
    node _GEN_14 = mux(eq(UInt<4>("he"), io_bundleReg_rs1), regs_14, _GEN_13) @[Registers.scala 33:{18,18}]
    node _GEN_15 = mux(eq(UInt<4>("hf"), io_bundleReg_rs1), regs_15, _GEN_14) @[Registers.scala 33:{18,18}]
    node _GEN_16 = mux(eq(UInt<5>("h10"), io_bundleReg_rs1), regs_16, _GEN_15) @[Registers.scala 33:{18,18}]
    node _GEN_17 = mux(eq(UInt<5>("h11"), io_bundleReg_rs1), regs_17, _GEN_16) @[Registers.scala 33:{18,18}]
    node _GEN_18 = mux(eq(UInt<5>("h12"), io_bundleReg_rs1), regs_18, _GEN_17) @[Registers.scala 33:{18,18}]
    node _GEN_19 = mux(eq(UInt<5>("h13"), io_bundleReg_rs1), regs_19, _GEN_18) @[Registers.scala 33:{18,18}]
    node _GEN_20 = mux(eq(UInt<5>("h14"), io_bundleReg_rs1), regs_20, _GEN_19) @[Registers.scala 33:{18,18}]
    node _GEN_21 = mux(eq(UInt<5>("h15"), io_bundleReg_rs1), regs_21, _GEN_20) @[Registers.scala 33:{18,18}]
    node _GEN_22 = mux(eq(UInt<5>("h16"), io_bundleReg_rs1), regs_22, _GEN_21) @[Registers.scala 33:{18,18}]
    node _GEN_23 = mux(eq(UInt<5>("h17"), io_bundleReg_rs1), regs_23, _GEN_22) @[Registers.scala 33:{18,18}]
    node _GEN_24 = mux(eq(UInt<5>("h18"), io_bundleReg_rs1), regs_24, _GEN_23) @[Registers.scala 33:{18,18}]
    node _GEN_25 = mux(eq(UInt<5>("h19"), io_bundleReg_rs1), regs_25, _GEN_24) @[Registers.scala 33:{18,18}]
    node _GEN_26 = mux(eq(UInt<5>("h1a"), io_bundleReg_rs1), regs_26, _GEN_25) @[Registers.scala 33:{18,18}]
    node _GEN_27 = mux(eq(UInt<5>("h1b"), io_bundleReg_rs1), regs_27, _GEN_26) @[Registers.scala 33:{18,18}]
    node _GEN_28 = mux(eq(UInt<5>("h1c"), io_bundleReg_rs1), regs_28, _GEN_27) @[Registers.scala 33:{18,18}]
    node _GEN_29 = mux(eq(UInt<5>("h1d"), io_bundleReg_rs1), regs_29, _GEN_28) @[Registers.scala 33:{18,18}]
    node _GEN_30 = mux(eq(UInt<5>("h1e"), io_bundleReg_rs1), regs_30, _GEN_29) @[Registers.scala 33:{18,18}]
    node _GEN_31 = mux(eq(UInt<5>("h1f"), io_bundleReg_rs1), regs_31, _GEN_30) @[Registers.scala 33:{18,18}]
    node _GEN_32 = validif(eq(UInt<1>("h0"), io_bundleReg_rs2), regs_0) @[Registers.scala 34:{18,18}]
    node _GEN_33 = mux(eq(UInt<1>("h1"), io_bundleReg_rs2), regs_1, _GEN_32) @[Registers.scala 34:{18,18}]
    node _GEN_34 = mux(eq(UInt<2>("h2"), io_bundleReg_rs2), regs_2, _GEN_33) @[Registers.scala 34:{18,18}]
    node _GEN_35 = mux(eq(UInt<2>("h3"), io_bundleReg_rs2), regs_3, _GEN_34) @[Registers.scala 34:{18,18}]
    node _GEN_36 = mux(eq(UInt<3>("h4"), io_bundleReg_rs2), regs_4, _GEN_35) @[Registers.scala 34:{18,18}]
    node _GEN_37 = mux(eq(UInt<3>("h5"), io_bundleReg_rs2), regs_5, _GEN_36) @[Registers.scala 34:{18,18}]
    node _GEN_38 = mux(eq(UInt<3>("h6"), io_bundleReg_rs2), regs_6, _GEN_37) @[Registers.scala 34:{18,18}]
    node _GEN_39 = mux(eq(UInt<3>("h7"), io_bundleReg_rs2), regs_7, _GEN_38) @[Registers.scala 34:{18,18}]
    node _GEN_40 = mux(eq(UInt<4>("h8"), io_bundleReg_rs2), regs_8, _GEN_39) @[Registers.scala 34:{18,18}]
    node _GEN_41 = mux(eq(UInt<4>("h9"), io_bundleReg_rs2), regs_9, _GEN_40) @[Registers.scala 34:{18,18}]
    node _GEN_42 = mux(eq(UInt<4>("ha"), io_bundleReg_rs2), regs_10, _GEN_41) @[Registers.scala 34:{18,18}]
    node _GEN_43 = mux(eq(UInt<4>("hb"), io_bundleReg_rs2), regs_11, _GEN_42) @[Registers.scala 34:{18,18}]
    node _GEN_44 = mux(eq(UInt<4>("hc"), io_bundleReg_rs2), regs_12, _GEN_43) @[Registers.scala 34:{18,18}]
    node _GEN_45 = mux(eq(UInt<4>("hd"), io_bundleReg_rs2), regs_13, _GEN_44) @[Registers.scala 34:{18,18}]
    node _GEN_46 = mux(eq(UInt<4>("he"), io_bundleReg_rs2), regs_14, _GEN_45) @[Registers.scala 34:{18,18}]
    node _GEN_47 = mux(eq(UInt<4>("hf"), io_bundleReg_rs2), regs_15, _GEN_46) @[Registers.scala 34:{18,18}]
    node _GEN_48 = mux(eq(UInt<5>("h10"), io_bundleReg_rs2), regs_16, _GEN_47) @[Registers.scala 34:{18,18}]
    node _GEN_49 = mux(eq(UInt<5>("h11"), io_bundleReg_rs2), regs_17, _GEN_48) @[Registers.scala 34:{18,18}]
    node _GEN_50 = mux(eq(UInt<5>("h12"), io_bundleReg_rs2), regs_18, _GEN_49) @[Registers.scala 34:{18,18}]
    node _GEN_51 = mux(eq(UInt<5>("h13"), io_bundleReg_rs2), regs_19, _GEN_50) @[Registers.scala 34:{18,18}]
    node _GEN_52 = mux(eq(UInt<5>("h14"), io_bundleReg_rs2), regs_20, _GEN_51) @[Registers.scala 34:{18,18}]
    node _GEN_53 = mux(eq(UInt<5>("h15"), io_bundleReg_rs2), regs_21, _GEN_52) @[Registers.scala 34:{18,18}]
    node _GEN_54 = mux(eq(UInt<5>("h16"), io_bundleReg_rs2), regs_22, _GEN_53) @[Registers.scala 34:{18,18}]
    node _GEN_55 = mux(eq(UInt<5>("h17"), io_bundleReg_rs2), regs_23, _GEN_54) @[Registers.scala 34:{18,18}]
    node _GEN_56 = mux(eq(UInt<5>("h18"), io_bundleReg_rs2), regs_24, _GEN_55) @[Registers.scala 34:{18,18}]
    node _GEN_57 = mux(eq(UInt<5>("h19"), io_bundleReg_rs2), regs_25, _GEN_56) @[Registers.scala 34:{18,18}]
    node _GEN_58 = mux(eq(UInt<5>("h1a"), io_bundleReg_rs2), regs_26, _GEN_57) @[Registers.scala 34:{18,18}]
    node _GEN_59 = mux(eq(UInt<5>("h1b"), io_bundleReg_rs2), regs_27, _GEN_58) @[Registers.scala 34:{18,18}]
    node _GEN_60 = mux(eq(UInt<5>("h1c"), io_bundleReg_rs2), regs_28, _GEN_59) @[Registers.scala 34:{18,18}]
    node _GEN_61 = mux(eq(UInt<5>("h1d"), io_bundleReg_rs2), regs_29, _GEN_60) @[Registers.scala 34:{18,18}]
    node _GEN_62 = mux(eq(UInt<5>("h1e"), io_bundleReg_rs2), regs_30, _GEN_61) @[Registers.scala 34:{18,18}]
    node _GEN_63 = mux(eq(UInt<5>("h1f"), io_bundleReg_rs2), regs_31, _GEN_62) @[Registers.scala 34:{18,18}]
    node _T_2 = neq(io_bundleReg_rd, UInt<1>("h0")) @[Registers.scala 36:45]
    node _T_3 = and(io_ctrlRegWrite, _T_2) @[Registers.scala 36:26]
    node _regs_T = add(io_pc, UInt<3>("h4")) @[Registers.scala 38:44]
    node _regs_T_1 = tail(_regs_T, 1) @[Registers.scala 38:44]
    node _regs_io_bundleReg_rd = _regs_T_1 @[Registers.scala 38:{35,35}]
    node _GEN_64 = mux(eq(UInt<1>("h0"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_0) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_65 = mux(eq(UInt<1>("h1"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_1) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_66 = mux(eq(UInt<2>("h2"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_2) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_67 = mux(eq(UInt<2>("h3"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_3) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_68 = mux(eq(UInt<3>("h4"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_4) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_69 = mux(eq(UInt<3>("h5"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_5) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_70 = mux(eq(UInt<3>("h6"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_6) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_71 = mux(eq(UInt<3>("h7"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_7) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_72 = mux(eq(UInt<4>("h8"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_8) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_73 = mux(eq(UInt<4>("h9"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_9) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_74 = mux(eq(UInt<4>("ha"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_10) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_75 = mux(eq(UInt<4>("hb"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_11) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_76 = mux(eq(UInt<4>("hc"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_12) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_77 = mux(eq(UInt<4>("hd"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_13) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_78 = mux(eq(UInt<4>("he"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_14) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_79 = mux(eq(UInt<4>("hf"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_15) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_80 = mux(eq(UInt<5>("h10"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_16) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_81 = mux(eq(UInt<5>("h11"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_17) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_82 = mux(eq(UInt<5>("h12"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_18) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_83 = mux(eq(UInt<5>("h13"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_19) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_84 = mux(eq(UInt<5>("h14"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_20) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_85 = mux(eq(UInt<5>("h15"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_21) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_86 = mux(eq(UInt<5>("h16"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_22) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_87 = mux(eq(UInt<5>("h17"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_23) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_88 = mux(eq(UInt<5>("h18"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_24) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_89 = mux(eq(UInt<5>("h19"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_25) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_90 = mux(eq(UInt<5>("h1a"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_26) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_91 = mux(eq(UInt<5>("h1b"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_27) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_92 = mux(eq(UInt<5>("h1c"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_28) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_93 = mux(eq(UInt<5>("h1d"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_29) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_94 = mux(eq(UInt<5>("h1e"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_30) @[Registers.scala 23:19 38:{35,35}]
    node _GEN_95 = mux(eq(UInt<5>("h1f"), io_bundleReg_rd), _regs_io_bundleReg_rd, regs_31) @[Registers.scala 23:19 38:{35,35}]
    node _regs_io_bundleReg_rd_0 = io_dataWrite @[Registers.scala 40:{35,35}]
    node _GEN_96 = mux(eq(UInt<1>("h0"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_0) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_97 = mux(eq(UInt<1>("h1"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_1) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_98 = mux(eq(UInt<2>("h2"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_2) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_99 = mux(eq(UInt<2>("h3"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_3) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_100 = mux(eq(UInt<3>("h4"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_4) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_101 = mux(eq(UInt<3>("h5"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_5) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_102 = mux(eq(UInt<3>("h6"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_6) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_103 = mux(eq(UInt<3>("h7"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_7) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_104 = mux(eq(UInt<4>("h8"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_8) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_105 = mux(eq(UInt<4>("h9"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_9) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_106 = mux(eq(UInt<4>("ha"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_10) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_107 = mux(eq(UInt<4>("hb"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_11) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_108 = mux(eq(UInt<4>("hc"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_12) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_109 = mux(eq(UInt<4>("hd"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_13) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_110 = mux(eq(UInt<4>("he"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_14) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_111 = mux(eq(UInt<4>("hf"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_15) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_112 = mux(eq(UInt<5>("h10"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_16) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_113 = mux(eq(UInt<5>("h11"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_17) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_114 = mux(eq(UInt<5>("h12"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_18) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_115 = mux(eq(UInt<5>("h13"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_19) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_116 = mux(eq(UInt<5>("h14"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_20) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_117 = mux(eq(UInt<5>("h15"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_21) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_118 = mux(eq(UInt<5>("h16"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_22) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_119 = mux(eq(UInt<5>("h17"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_23) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_120 = mux(eq(UInt<5>("h18"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_24) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_121 = mux(eq(UInt<5>("h19"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_25) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_122 = mux(eq(UInt<5>("h1a"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_26) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_123 = mux(eq(UInt<5>("h1b"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_27) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_124 = mux(eq(UInt<5>("h1c"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_28) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_125 = mux(eq(UInt<5>("h1d"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_29) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_126 = mux(eq(UInt<5>("h1e"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_30) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_127 = mux(eq(UInt<5>("h1f"), io_bundleReg_rd), _regs_io_bundleReg_rd_0, regs_31) @[Registers.scala 23:19 40:{35,35}]
    node _GEN_128 = mux(io_ctrlJump, _GEN_64, _GEN_96) @[Registers.scala 37:27]
    node _GEN_129 = mux(io_ctrlJump, _GEN_65, _GEN_97) @[Registers.scala 37:27]
    node _GEN_130 = mux(io_ctrlJump, _GEN_66, _GEN_98) @[Registers.scala 37:27]
    node _GEN_131 = mux(io_ctrlJump, _GEN_67, _GEN_99) @[Registers.scala 37:27]
    node _GEN_132 = mux(io_ctrlJump, _GEN_68, _GEN_100) @[Registers.scala 37:27]
    node _GEN_133 = mux(io_ctrlJump, _GEN_69, _GEN_101) @[Registers.scala 37:27]
    node _GEN_134 = mux(io_ctrlJump, _GEN_70, _GEN_102) @[Registers.scala 37:27]
    node _GEN_135 = mux(io_ctrlJump, _GEN_71, _GEN_103) @[Registers.scala 37:27]
    node _GEN_136 = mux(io_ctrlJump, _GEN_72, _GEN_104) @[Registers.scala 37:27]
    node _GEN_137 = mux(io_ctrlJump, _GEN_73, _GEN_105) @[Registers.scala 37:27]
    node _GEN_138 = mux(io_ctrlJump, _GEN_74, _GEN_106) @[Registers.scala 37:27]
    node _GEN_139 = mux(io_ctrlJump, _GEN_75, _GEN_107) @[Registers.scala 37:27]
    node _GEN_140 = mux(io_ctrlJump, _GEN_76, _GEN_108) @[Registers.scala 37:27]
    node _GEN_141 = mux(io_ctrlJump, _GEN_77, _GEN_109) @[Registers.scala 37:27]
    node _GEN_142 = mux(io_ctrlJump, _GEN_78, _GEN_110) @[Registers.scala 37:27]
    node _GEN_143 = mux(io_ctrlJump, _GEN_79, _GEN_111) @[Registers.scala 37:27]
    node _GEN_144 = mux(io_ctrlJump, _GEN_80, _GEN_112) @[Registers.scala 37:27]
    node _GEN_145 = mux(io_ctrlJump, _GEN_81, _GEN_113) @[Registers.scala 37:27]
    node _GEN_146 = mux(io_ctrlJump, _GEN_82, _GEN_114) @[Registers.scala 37:27]
    node _GEN_147 = mux(io_ctrlJump, _GEN_83, _GEN_115) @[Registers.scala 37:27]
    node _GEN_148 = mux(io_ctrlJump, _GEN_84, _GEN_116) @[Registers.scala 37:27]
    node _GEN_149 = mux(io_ctrlJump, _GEN_85, _GEN_117) @[Registers.scala 37:27]
    node _GEN_150 = mux(io_ctrlJump, _GEN_86, _GEN_118) @[Registers.scala 37:27]
    node _GEN_151 = mux(io_ctrlJump, _GEN_87, _GEN_119) @[Registers.scala 37:27]
    node _GEN_152 = mux(io_ctrlJump, _GEN_88, _GEN_120) @[Registers.scala 37:27]
    node _GEN_153 = mux(io_ctrlJump, _GEN_89, _GEN_121) @[Registers.scala 37:27]
    node _GEN_154 = mux(io_ctrlJump, _GEN_90, _GEN_122) @[Registers.scala 37:27]
    node _GEN_155 = mux(io_ctrlJump, _GEN_91, _GEN_123) @[Registers.scala 37:27]
    node _GEN_156 = mux(io_ctrlJump, _GEN_92, _GEN_124) @[Registers.scala 37:27]
    node _GEN_157 = mux(io_ctrlJump, _GEN_93, _GEN_125) @[Registers.scala 37:27]
    node _GEN_158 = mux(io_ctrlJump, _GEN_94, _GEN_126) @[Registers.scala 37:27]
    node _GEN_159 = mux(io_ctrlJump, _GEN_95, _GEN_127) @[Registers.scala 37:27]
    node _GEN_160 = mux(_T_3, _GEN_128, regs_0) @[Registers.scala 23:19 36:54]
    node _GEN_161 = mux(_T_3, _GEN_129, regs_1) @[Registers.scala 23:19 36:54]
    node _GEN_162 = mux(_T_3, _GEN_130, regs_2) @[Registers.scala 23:19 36:54]
    node _GEN_163 = mux(_T_3, _GEN_131, regs_3) @[Registers.scala 23:19 36:54]
    node _GEN_164 = mux(_T_3, _GEN_132, regs_4) @[Registers.scala 23:19 36:54]
    node _GEN_165 = mux(_T_3, _GEN_133, regs_5) @[Registers.scala 23:19 36:54]
    node _GEN_166 = mux(_T_3, _GEN_134, regs_6) @[Registers.scala 23:19 36:54]
    node _GEN_167 = mux(_T_3, _GEN_135, regs_7) @[Registers.scala 23:19 36:54]
    node _GEN_168 = mux(_T_3, _GEN_136, regs_8) @[Registers.scala 23:19 36:54]
    node _GEN_169 = mux(_T_3, _GEN_137, regs_9) @[Registers.scala 23:19 36:54]
    node _GEN_170 = mux(_T_3, _GEN_138, regs_10) @[Registers.scala 23:19 36:54]
    node _GEN_171 = mux(_T_3, _GEN_139, regs_11) @[Registers.scala 23:19 36:54]
    node _GEN_172 = mux(_T_3, _GEN_140, regs_12) @[Registers.scala 23:19 36:54]
    node _GEN_173 = mux(_T_3, _GEN_141, regs_13) @[Registers.scala 23:19 36:54]
    node _GEN_174 = mux(_T_3, _GEN_142, regs_14) @[Registers.scala 23:19 36:54]
    node _GEN_175 = mux(_T_3, _GEN_143, regs_15) @[Registers.scala 23:19 36:54]
    node _GEN_176 = mux(_T_3, _GEN_144, regs_16) @[Registers.scala 23:19 36:54]
    node _GEN_177 = mux(_T_3, _GEN_145, regs_17) @[Registers.scala 23:19 36:54]
    node _GEN_178 = mux(_T_3, _GEN_146, regs_18) @[Registers.scala 23:19 36:54]
    node _GEN_179 = mux(_T_3, _GEN_147, regs_19) @[Registers.scala 23:19 36:54]
    node _GEN_180 = mux(_T_3, _GEN_148, regs_20) @[Registers.scala 23:19 36:54]
    node _GEN_181 = mux(_T_3, _GEN_149, regs_21) @[Registers.scala 23:19 36:54]
    node _GEN_182 = mux(_T_3, _GEN_150, regs_22) @[Registers.scala 23:19 36:54]
    node _GEN_183 = mux(_T_3, _GEN_151, regs_23) @[Registers.scala 23:19 36:54]
    node _GEN_184 = mux(_T_3, _GEN_152, regs_24) @[Registers.scala 23:19 36:54]
    node _GEN_185 = mux(_T_3, _GEN_153, regs_25) @[Registers.scala 23:19 36:54]
    node _GEN_186 = mux(_T_3, _GEN_154, regs_26) @[Registers.scala 23:19 36:54]
    node _GEN_187 = mux(_T_3, _GEN_155, regs_27) @[Registers.scala 23:19 36:54]
    node _GEN_188 = mux(_T_3, _GEN_156, regs_28) @[Registers.scala 23:19 36:54]
    node _GEN_189 = mux(_T_3, _GEN_157, regs_29) @[Registers.scala 23:19 36:54]
    node _GEN_190 = mux(_T_3, _GEN_158, regs_30) @[Registers.scala 23:19 36:54]
    node _GEN_191 = mux(_T_3, _GEN_159, regs_31) @[Registers.scala 23:19 36:54]
    node _regs_io_bundleReg_rs1 = _GEN_31 @[Registers.scala 33:18]
    node _regs_io_bundleReg_rs2 = _GEN_63 @[Registers.scala 34:18]
    io_dataRead1 <= _regs_io_bundleReg_rs1 @[Registers.scala 33:18]
    io_dataRead2 <= _regs_io_bundleReg_rs2 @[Registers.scala 34:18]
    regs_0 <= _GEN_160
    regs_1 <= _GEN_161
    regs_2 <= _GEN_162
    regs_3 <= _GEN_163
    regs_4 <= _GEN_164
    regs_5 <= _GEN_165
    regs_6 <= _GEN_166
    regs_7 <= _GEN_167
    regs_8 <= _GEN_168
    regs_9 <= _GEN_169
    regs_10 <= _GEN_170
    regs_11 <= _GEN_171
    regs_12 <= _GEN_172
    regs_13 <= _GEN_173
    regs_14 <= _GEN_174
    regs_15 <= _GEN_175
    regs_16 <= _GEN_176
    regs_17 <= _GEN_177
    regs_18 <= _GEN_178
    regs_19 <= _GEN_179
    regs_20 <= _GEN_180
    regs_21 <= _GEN_181
    regs_22 <= _GEN_182
    regs_23 <= _GEN_183
    regs_24 <= _GEN_184
    regs_25 <= _GEN_185
    regs_26 <= _GEN_186
    regs_27 <= _GEN_187
    regs_28 <= _GEN_188
    regs_29 <= _GEN_189
    regs_30 <= _GEN_190
    regs_31 <= _GEN_191

  module Alu :
    input clock : Clock
    input reset : UInt<1>
    input io_bundleAluControl_ctrlALUSrc : UInt<1>
    input io_bundleAluControl_ctrlJAL : UInt<1>
    input io_bundleAluControl_ctrlOP : UInt<4>
    input io_bundleAluControl_ctrlSigned : UInt<1>
    input io_bundleAluControl_ctrlBranch : UInt<1>
    input io_dataRead1 : UInt<32>
    input io_dataRead2 : UInt<32>
    input io_imm : UInt<32>
    input io_pc : UInt<32>
    output io_resultBranch : UInt<1>
    output io_resultAlu : UInt<32>

    node _oprand1_T = mux(io_bundleAluControl_ctrlJAL, io_pc, io_dataRead1) @[Alu.scala 31:19]
    node _oprand2_T = mux(io_bundleAluControl_ctrlALUSrc, io_imm, io_dataRead2) @[Alu.scala 32:19]
    node _T = eq(UInt<1>("h0"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node _T_1 = eq(UInt<1>("h1"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node oprand1 = _oprand1_T
    node oprand2 = _oprand2_T
    node _resultAlu_T = add(oprand1, oprand2) @[Alu.scala 41:34]
    node _T_2 = eq(UInt<2>("h2"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node _resultAlu_T_1 = sub(oprand1, oprand2) @[Alu.scala 44:34]
    node _resultAlu_T_2 = asUInt(_resultAlu_T_1) @[Alu.scala 44:34]
    node _T_3 = eq(UInt<3>("h4"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node _resultAlu_T_3 = and(oprand1, oprand2) @[Alu.scala 47:34]
    node _T_4 = eq(UInt<3>("h5"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node _resultAlu_T_4 = or(oprand1, oprand2) @[Alu.scala 50:34]
    node _T_5 = eq(UInt<3>("h7"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node _resultAlu_T_5 = xor(oprand1, oprand2) @[Alu.scala 53:34]
    node _T_6 = eq(UInt<4>("h8"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node _resultAlu_T_6 = bits(oprand2, 4, 0) @[Alu.scala 56:44]
    node _resultAlu_T_7 = dshl(oprand1, _resultAlu_T_6) @[Alu.scala 56:34]
    node _T_7 = eq(UInt<4>("h9"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node _resultAlu_T_8 = bits(oprand2, 4, 0) @[Alu.scala 59:44]
    node _resultAlu_T_9 = dshr(oprand1, _resultAlu_T_8) @[Alu.scala 59:34]
    node _T_8 = eq(UInt<4>("hb"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node _resultAlu_T_10 = asSInt(oprand1) @[Alu.scala 62:35]
    node _resultAlu_T_11 = bits(oprand2, 4, 0) @[Alu.scala 62:52]
    node _resultAlu_T_12 = dshr(_resultAlu_T_10, _resultAlu_T_11) @[Alu.scala 62:42]
    node _resultAlu_T_13 = asUInt(_resultAlu_T_12) @[Alu.scala 62:60]
    node _T_9 = eq(UInt<4>("hc"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node _resultBranch_T = asSInt(oprand1) @[Alu.scala 65:37]
    node _resultBranch_T_1 = asSInt(oprand2) @[Alu.scala 65:56]
    node _resultBranch_T_2 = eq(_resultBranch_T, _resultBranch_T_1) @[Alu.scala 65:44]
    node _resultAlu_T_14 = add(io_pc, io_imm) @[Alu.scala 66:32]
    node _T_10 = eq(UInt<4>("hd"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node _resultBranch_T_3 = asSInt(oprand1) @[Alu.scala 69:37]
    node _resultBranch_T_4 = asSInt(oprand2) @[Alu.scala 69:56]
    node _resultBranch_T_5 = neq(_resultBranch_T_3, _resultBranch_T_4) @[Alu.scala 69:44]
    node _resultAlu_T_15 = add(io_pc, io_imm) @[Alu.scala 70:32]
    node _T_11 = eq(UInt<4>("he"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node _resultBranch_T_6 = asSInt(oprand1) @[Alu.scala 75:45]
    node _resultBranch_T_7 = asSInt(oprand2) @[Alu.scala 75:62]
    node _resultBranch_T_8 = lt(_resultBranch_T_6, _resultBranch_T_7) @[Alu.scala 75:52]
    node _resultBranch_T_9 = lt(oprand1, oprand2) @[Alu.scala 77:45]
    node _GEN_0 = mux(io_bundleAluControl_ctrlSigned, _resultBranch_T_8, _resultBranch_T_9) @[Alu.scala 74:54 75:34 77:34]
    node _resultAlu_T_16 = add(io_pc, io_imm) @[Alu.scala 79:36]
    node _resultAlu_T_17 = asSInt(oprand1) @[Alu.scala 82:42]
    node _resultAlu_T_18 = asSInt(oprand2) @[Alu.scala 82:59]
    node _resultAlu_T_19 = lt(_resultAlu_T_17, _resultAlu_T_18) @[Alu.scala 82:49]
    node _resultAlu_T_20 = lt(oprand1, oprand2) @[Alu.scala 84:42]
    node _GEN_1 = mux(io_bundleAluControl_ctrlSigned, _resultAlu_T_19, _resultAlu_T_20) @[Alu.scala 81:54 82:31 84:31]
    node _GEN_2 = mux(io_bundleAluControl_ctrlBranch, _GEN_0, UInt<1>("h0")) @[Alu.scala 73:50]
    node _GEN_3 = mux(io_bundleAluControl_ctrlBranch, _resultAlu_T_16, _GEN_1) @[Alu.scala 73:50 79:27]
    node _T_12 = eq(UInt<4>("hf"), io_bundleAluControl_ctrlOP) @[Alu.scala 35:40]
    node _resultBranch_T_10 = asSInt(oprand1) @[Alu.scala 90:41]
    node _resultBranch_T_11 = asSInt(oprand2) @[Alu.scala 90:59]
    node _resultBranch_T_12 = geq(_resultBranch_T_10, _resultBranch_T_11) @[Alu.scala 90:48]
    node _resultBranch_T_13 = geq(oprand1, oprand2) @[Alu.scala 92:41]
    node _GEN_4 = mux(io_bundleAluControl_ctrlSigned, _resultBranch_T_12, _resultBranch_T_13) @[Alu.scala 89:50 90:30 92:30]
    node _resultAlu_T_21 = add(io_pc, io_imm) @[Alu.scala 94:32]
    node _GEN_5 = mux(_T_12, _GEN_4, UInt<1>("h0")) @[Alu.scala 35:40]
    node _GEN_6 = mux(_T_12, _resultAlu_T_21, UInt<32>("h0")) @[Alu.scala 35:40 94:23]
    node _GEN_7 = mux(_T_11, _GEN_2, _GEN_5) @[Alu.scala 35:40]
    node _GEN_8 = mux(_T_11, _GEN_3, _GEN_6) @[Alu.scala 35:40]
    node _GEN_9 = mux(_T_10, _resultBranch_T_5, _GEN_7) @[Alu.scala 35:40 69:26]
    node _GEN_10 = mux(_T_10, _resultAlu_T_15, _GEN_8) @[Alu.scala 35:40 70:23]
    node _GEN_11 = mux(_T_9, _resultBranch_T_2, _GEN_9) @[Alu.scala 35:40 65:26]
    node _GEN_12 = mux(_T_9, _resultAlu_T_14, _GEN_10) @[Alu.scala 35:40 66:23]
    node _GEN_13 = mux(_T_8, _resultAlu_T_13, _GEN_12) @[Alu.scala 35:40 62:23]
    node _GEN_14 = mux(_T_8, UInt<1>("h0"), _GEN_11) @[Alu.scala 35:40]
    node _GEN_15 = mux(_T_7, _resultAlu_T_9, _GEN_13) @[Alu.scala 35:40 59:23]
    node _GEN_16 = mux(_T_7, UInt<1>("h0"), _GEN_14) @[Alu.scala 35:40]
    node _GEN_17 = mux(_T_6, _resultAlu_T_7, _GEN_15) @[Alu.scala 35:40 56:23]
    node _GEN_18 = mux(_T_6, UInt<1>("h0"), _GEN_16) @[Alu.scala 35:40]
    node _GEN_19 = mux(_T_5, _resultAlu_T_5, _GEN_17) @[Alu.scala 35:40 53:23]
    node _GEN_20 = mux(_T_5, UInt<1>("h0"), _GEN_18) @[Alu.scala 35:40]
    node _GEN_21 = mux(_T_4, _resultAlu_T_4, _GEN_19) @[Alu.scala 35:40 50:23]
    node _GEN_22 = mux(_T_4, UInt<1>("h0"), _GEN_20) @[Alu.scala 35:40]
    node _GEN_23 = mux(_T_3, _resultAlu_T_3, _GEN_21) @[Alu.scala 35:40 47:23]
    node _GEN_24 = mux(_T_3, UInt<1>("h0"), _GEN_22) @[Alu.scala 35:40]
    node _GEN_25 = mux(_T_2, _resultAlu_T_2, _GEN_23) @[Alu.scala 35:40 44:23]
    node _GEN_26 = mux(_T_2, UInt<1>("h0"), _GEN_24) @[Alu.scala 35:40]
    node _GEN_27 = mux(_T_1, _resultAlu_T, _GEN_25) @[Alu.scala 35:40 41:23]
    node _GEN_28 = mux(_T_1, UInt<1>("h0"), _GEN_26) @[Alu.scala 35:40]
    node _GEN_29 = mux(_T, UInt<1>("h0"), _GEN_27) @[Alu.scala 35:40 37:23]
    node _GEN_30 = mux(_T, UInt<1>("h0"), _GEN_28) @[Alu.scala 35:40 38:26]
    node resultBranch = _GEN_30
    node resultAlu = bits(_GEN_29, 31, 0)
    io_resultBranch <= resultBranch @[Alu.scala 99:21]
    io_resultAlu <= resultAlu @[Alu.scala 98:18]

  module MemData :
    input clock : Clock
    input reset : UInt<1>
    input io_bundleMemDataControl_ctrlLoad : UInt<1>
    input io_bundleMemDataControl_ctrlStore : UInt<1>
    input io_bundleMemDataControl_ctrlSigned : UInt<1>
    input io_bundleMemDataControl_ctrlLSType : UInt<2>
    input io_resultALU : UInt<32>
    input io_dataStore : UInt<32>
    output io_result : UInt<32>

    mem mem : @[MemData.scala 22:18]
      data-type => UInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => dataLoad_MPORT
      writer => MPORT
      writer => MPORT_1
      writer => MPORT_2
      read-under-write => undefined
    node _dataLoad_T = dshr(io_resultALU, UInt<2>("h2")) @[MemData.scala 31:39]
    node _dataLoad_T_1 = bits(_dataLoad_T, 9, 0) @[MemData.scala 31:25]
    node _T = eq(io_bundleMemDataControl_ctrlLSType, UInt<2>("h2")) @[MemData.scala 35:49]
    node _T_1 = dshr(io_resultALU, UInt<2>("h2")) @[MemData.scala 36:36]
    node _T_2 = bits(_T_1, 9, 0)
    node _T_3 = eq(io_bundleMemDataControl_ctrlLSType, UInt<1>("h1")) @[MemData.scala 37:55]
    node _T_4 = dshr(io_resultALU, UInt<2>("h2")) @[MemData.scala 38:36]
    node dataLoad = mem.dataLoad_MPORT.data
    node _T_5 = bits(dataLoad, 31, 16) @[MemData.scala 38:74]
    node _T_6 = bits(io_dataStore, 15, 0) @[MemData.scala 38:96]
    node _T_7 = cat(_T_5, _T_6) @[Cat.scala 31:58]
    node _T_8 = bits(_T_4, 9, 0)
    node _T_9 = dshr(io_resultALU, UInt<2>("h2")) @[MemData.scala 40:36]
    node _T_10 = bits(dataLoad, 31, 8) @[MemData.scala 40:74]
    node _T_11 = bits(io_dataStore, 7, 0) @[MemData.scala 40:95]
    node _T_12 = cat(_T_10, _T_11) @[Cat.scala 31:58]
    node _T_13 = bits(_T_9, 9, 0)
    node _GEN_0 = validif(_T_3, _T_8) @[MemData.scala 37:65]
    node _GEN_1 = validif(_T_3, clock) @[MemData.scala 37:65]
    node _GEN_2 = mux(_T_3, UInt<1>("h1"), UInt<1>("h0")) @[MemData.scala 22:18 37:65]
    node _GEN_3 = validif(_T_3, UInt<1>("h1")) @[MemData.scala 37:65]
    node _GEN_4 = validif(_T_3, _T_7) @[MemData.scala 37:65]
    node _GEN_5 = validif(eq(_T_3, UInt<1>("h0")), _T_13) @[MemData.scala 37:65]
    node _GEN_6 = validif(eq(_T_3, UInt<1>("h0")), clock) @[MemData.scala 37:65]
    node _GEN_7 = mux(_T_3, UInt<1>("h0"), UInt<1>("h1")) @[MemData.scala 22:18 37:65]
    node _GEN_8 = validif(eq(_T_3, UInt<1>("h0")), UInt<1>("h1")) @[MemData.scala 37:65]
    node _GEN_9 = validif(eq(_T_3, UInt<1>("h0")), _T_12) @[MemData.scala 37:65]
    node _GEN_10 = validif(_T, _T_2) @[MemData.scala 35:59]
    node _GEN_11 = validif(_T, clock) @[MemData.scala 35:59]
    node _GEN_12 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[MemData.scala 22:18 35:59]
    node _GEN_13 = validif(_T, UInt<1>("h1")) @[MemData.scala 35:59]
    node _GEN_14 = validif(_T, io_dataStore) @[MemData.scala 35:59]
    node _GEN_15 = validif(eq(_T, UInt<1>("h0")), _GEN_0) @[MemData.scala 35:59]
    node _GEN_16 = validif(eq(_T, UInt<1>("h0")), _GEN_1) @[MemData.scala 35:59]
    node _GEN_17 = mux(_T, UInt<1>("h0"), _GEN_2) @[MemData.scala 22:18 35:59]
    node _GEN_18 = validif(eq(_T, UInt<1>("h0")), _GEN_3) @[MemData.scala 35:59]
    node _GEN_19 = validif(eq(_T, UInt<1>("h0")), _GEN_4) @[MemData.scala 35:59]
    node _GEN_20 = validif(eq(_T, UInt<1>("h0")), _GEN_5) @[MemData.scala 35:59]
    node _GEN_21 = validif(eq(_T, UInt<1>("h0")), _GEN_6) @[MemData.scala 35:59]
    node _GEN_22 = mux(_T, UInt<1>("h0"), _GEN_7) @[MemData.scala 22:18 35:59]
    node _GEN_23 = validif(eq(_T, UInt<1>("h0")), _GEN_8) @[MemData.scala 35:59]
    node _GEN_24 = validif(eq(_T, UInt<1>("h0")), _GEN_9) @[MemData.scala 35:59]
    node _GEN_25 = validif(io_bundleMemDataControl_ctrlStore, _GEN_10) @[MemData.scala 34:45]
    node _GEN_26 = validif(io_bundleMemDataControl_ctrlStore, _GEN_11) @[MemData.scala 34:45]
    node _GEN_27 = mux(io_bundleMemDataControl_ctrlStore, _GEN_12, UInt<1>("h0")) @[MemData.scala 22:18 34:45]
    node _GEN_28 = validif(io_bundleMemDataControl_ctrlStore, _GEN_13) @[MemData.scala 34:45]
    node _GEN_29 = validif(io_bundleMemDataControl_ctrlStore, _GEN_14) @[MemData.scala 34:45]
    node _GEN_30 = validif(io_bundleMemDataControl_ctrlStore, _GEN_15) @[MemData.scala 34:45]
    node _GEN_31 = validif(io_bundleMemDataControl_ctrlStore, _GEN_16) @[MemData.scala 34:45]
    node _GEN_32 = mux(io_bundleMemDataControl_ctrlStore, _GEN_17, UInt<1>("h0")) @[MemData.scala 22:18 34:45]
    node _GEN_33 = validif(io_bundleMemDataControl_ctrlStore, _GEN_18) @[MemData.scala 34:45]
    node _GEN_34 = validif(io_bundleMemDataControl_ctrlStore, _GEN_19) @[MemData.scala 34:45]
    node _GEN_35 = validif(io_bundleMemDataControl_ctrlStore, _GEN_20) @[MemData.scala 34:45]
    node _GEN_36 = validif(io_bundleMemDataControl_ctrlStore, _GEN_21) @[MemData.scala 34:45]
    node _GEN_37 = mux(io_bundleMemDataControl_ctrlStore, _GEN_22, UInt<1>("h0")) @[MemData.scala 22:18 34:45]
    node _GEN_38 = validif(io_bundleMemDataControl_ctrlStore, _GEN_23) @[MemData.scala 34:45]
    node _GEN_39 = validif(io_bundleMemDataControl_ctrlStore, _GEN_24) @[MemData.scala 34:45]
    node _T_14 = eq(io_bundleMemDataControl_ctrlLSType, UInt<2>("h2")) @[MemData.scala 45:49]
    node _T_15 = eq(io_bundleMemDataControl_ctrlLSType, UInt<1>("h1")) @[MemData.scala 47:55]
    node _result_T = bits(dataLoad, 15, 15) @[MemData.scala 49:48]
    node _result_T_1 = bits(_result_T, 0, 0) @[Bitwise.scala 74:15]
    node _result_T_2 = mux(_result_T_1, UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
    node _result_T_3 = bits(dataLoad, 15, 0) @[MemData.scala 49:63]
    node _result_T_4 = cat(_result_T_2, _result_T_3) @[Cat.scala 31:58]
    node _result_T_5 = mux(UInt<1>("h0"), UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
    node _result_T_6 = bits(dataLoad, 15, 0) @[MemData.scala 51:54]
    node _result_T_7 = cat(_result_T_5, _result_T_6) @[Cat.scala 31:58]
    node _GEN_40 = mux(io_bundleMemDataControl_ctrlSigned, _result_T_4, _result_T_7) @[MemData.scala 48:55 49:24 51:24]
    node _result_T_8 = bits(dataLoad, 7, 7) @[MemData.scala 55:48]
    node _result_T_9 = bits(_result_T_8, 0, 0) @[Bitwise.scala 74:15]
    node _result_T_10 = mux(_result_T_9, UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 74:12]
    node _result_T_11 = bits(dataLoad, 7, 0) @[MemData.scala 55:62]
    node _result_T_12 = cat(_result_T_10, _result_T_11) @[Cat.scala 31:58]
    node _result_T_13 = mux(UInt<1>("h0"), UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 74:12]
    node _result_T_14 = bits(dataLoad, 7, 0) @[MemData.scala 57:54]
    node _result_T_15 = cat(_result_T_13, _result_T_14) @[Cat.scala 31:58]
    node _GEN_41 = mux(io_bundleMemDataControl_ctrlSigned, _result_T_12, _result_T_15) @[MemData.scala 54:55 55:24 57:24]
    node _GEN_42 = mux(_T_15, _GEN_40, _GEN_41) @[MemData.scala 47:65]
    node _GEN_43 = mux(_T_14, dataLoad, _GEN_42) @[MemData.scala 45:59 46:20]
    node _GEN_44 = mux(io_bundleMemDataControl_ctrlLoad, _GEN_43, io_resultALU) @[MemData.scala 44:45 62:16]
    node result = _GEN_44
    io_result <= result @[MemData.scala 66:15]
    mem.dataLoad_MPORT.addr <= _dataLoad_T_1 @[MemData.scala 31:25]
    mem.dataLoad_MPORT.en <= UInt<1>("h1") @[MemData.scala 31:25]
    mem.dataLoad_MPORT.clk <= clock @[MemData.scala 31:25]
    mem.MPORT.addr <= _GEN_25
    mem.MPORT.en <= _GEN_27
    mem.MPORT.clk <= _GEN_26
    mem.MPORT.data <= _GEN_29
    mem.MPORT.mask <= _GEN_28
    mem.MPORT_1.addr <= _GEN_30
    mem.MPORT_1.en <= _GEN_32
    mem.MPORT_1.clk <= _GEN_31
    mem.MPORT_1.data <= _GEN_34
    mem.MPORT_1.mask <= _GEN_33
    mem.MPORT_2.addr <= _GEN_35
    mem.MPORT_2.en <= _GEN_37
    mem.MPORT_2.clk <= _GEN_36
    mem.MPORT_2.data <= _GEN_39
    mem.MPORT_2.mask <= _GEN_38

  module Controller :
    input clock : Clock
    input reset : UInt<1>
    input io_bundleControlIn_ctrlJump : UInt<1>
    input io_bundleControlIn_ctrlBranch : UInt<1>
    input io_bundleControlIn_ctrlRegWrite : UInt<1>
    input io_bundleControlIn_ctrlLoad : UInt<1>
    input io_bundleControlIn_ctrlStore : UInt<1>
    input io_bundleControlIn_ctrlALUSrc : UInt<1>
    input io_bundleControlIn_ctrlJAL : UInt<1>
    input io_bundleControlIn_ctrlOP : UInt<4>
    input io_bundleControlIn_ctrlSigned : UInt<1>
    input io_bundleControlIn_ctrlLSType : UInt<2>
    output io_bundleAluControl_ctrlALUSrc : UInt<1>
    output io_bundleAluControl_ctrlJAL : UInt<1>
    output io_bundleAluControl_ctrlOP : UInt<4>
    output io_bundleAluControl_ctrlSigned : UInt<1>
    output io_bundleAluControl_ctrlBranch : UInt<1>
    output io_bundleMemDataControl_ctrlLoad : UInt<1>
    output io_bundleMemDataControl_ctrlStore : UInt<1>
    output io_bundleMemDataControl_ctrlSigned : UInt<1>
    output io_bundleMemDataControl_ctrlLSType : UInt<2>
    output io_bundleControlOut_ctrlJump : UInt<1>
    output io_bundleControlOut_ctrlBranch : UInt<1>
    output io_bundleControlOut_ctrlRegWrite : UInt<1>
    output io_bundleControlOut_ctrlLoad : UInt<1>
    output io_bundleControlOut_ctrlStore : UInt<1>
    output io_bundleControlOut_ctrlALUSrc : UInt<1>
    output io_bundleControlOut_ctrlJAL : UInt<1>
    output io_bundleControlOut_ctrlOP : UInt<4>
    output io_bundleControlOut_ctrlSigned : UInt<1>
    output io_bundleControlOut_ctrlLSType : UInt<2>

    io_bundleAluControl_ctrlALUSrc <= io_bundleControlIn_ctrlALUSrc @[Controller.scala 19:36]
    io_bundleAluControl_ctrlJAL <= io_bundleControlIn_ctrlJAL @[Controller.scala 20:33]
    io_bundleAluControl_ctrlOP <= io_bundleControlIn_ctrlOP @[Controller.scala 21:32]
    io_bundleAluControl_ctrlSigned <= io_bundleControlIn_ctrlSigned @[Controller.scala 22:36]
    io_bundleAluControl_ctrlBranch <= io_bundleControlIn_ctrlBranch @[Controller.scala 23:36]
    io_bundleMemDataControl_ctrlLoad <= io_bundleControlIn_ctrlLoad @[Controller.scala 27:38]
    io_bundleMemDataControl_ctrlStore <= io_bundleControlIn_ctrlStore @[Controller.scala 29:39]
    io_bundleMemDataControl_ctrlSigned <= io_bundleControlIn_ctrlSigned @[Controller.scala 28:40]
    io_bundleMemDataControl_ctrlLSType <= pad(io_bundleControlIn_ctrlALUSrc, 2) @[Controller.scala 26:40]
    io_bundleControlOut_ctrlJump <= io_bundleControlIn_ctrlJump @[Controller.scala 32:25]
    io_bundleControlOut_ctrlBranch <= io_bundleControlIn_ctrlBranch @[Controller.scala 32:25]
    io_bundleControlOut_ctrlRegWrite <= io_bundleControlIn_ctrlRegWrite @[Controller.scala 32:25]
    io_bundleControlOut_ctrlLoad <= io_bundleControlIn_ctrlLoad @[Controller.scala 32:25]
    io_bundleControlOut_ctrlStore <= io_bundleControlIn_ctrlStore @[Controller.scala 32:25]
    io_bundleControlOut_ctrlALUSrc <= io_bundleControlIn_ctrlALUSrc @[Controller.scala 32:25]
    io_bundleControlOut_ctrlJAL <= io_bundleControlIn_ctrlJAL @[Controller.scala 32:25]
    io_bundleControlOut_ctrlOP <= io_bundleControlIn_ctrlOP @[Controller.scala 32:25]
    io_bundleControlOut_ctrlSigned <= io_bundleControlIn_ctrlSigned @[Controller.scala 32:25]
    io_bundleControlOut_ctrlLSType <= io_bundleControlIn_ctrlLSType @[Controller.scala 32:25]

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io_addr : UInt<32>
    output io_inst : UInt<32>
    output io_bundleCtrl_ctrlJump : UInt<1>
    output io_bundleCtrl_ctrlBranch : UInt<1>
    output io_bundleCtrl_ctrlRegWrite : UInt<1>
    output io_bundleCtrl_ctrlLoad : UInt<1>
    output io_bundleCtrl_ctrlStore : UInt<1>
    output io_bundleCtrl_ctrlALUSrc : UInt<1>
    output io_bundleCtrl_ctrlJAL : UInt<1>
    output io_bundleCtrl_ctrlOP : UInt<4>
    output io_bundleCtrl_ctrlSigned : UInt<1>
    output io_bundleCtrl_ctrlLSType : UInt<2>
    output io_resultALU : UInt<32>
    output io_rs1 : UInt<32>
    output io_rs2 : UInt<32>
    output io_imm : UInt<32>
    output io_resultBranch : UInt<1>
    output io_result : UInt<32>

    inst pcReg of PCReg @[Top.scala 25:23]
    inst memInst of MemInst @[Top.scala 26:25]
    inst decoder of Decoder @[Top.scala 27:25]
    inst registers of Registers @[Top.scala 28:27]
    inst alu of Alu @[Top.scala 29:21]
    inst memData of MemData @[Top.scala 30:25]
    inst controller of Controller @[Top.scala 31:28]
    io_addr <= pcReg.io_addrOut @[Top.scala 68:13]
    io_inst <= memInst.io_inst @[Top.scala 70:13]
    io_bundleCtrl_ctrlJump <= decoder.io_bundleCtrl_ctrlJump @[Top.scala 69:19]
    io_bundleCtrl_ctrlBranch <= decoder.io_bundleCtrl_ctrlBranch @[Top.scala 69:19]
    io_bundleCtrl_ctrlRegWrite <= decoder.io_bundleCtrl_ctrlRegWrite @[Top.scala 69:19]
    io_bundleCtrl_ctrlLoad <= decoder.io_bundleCtrl_ctrlLoad @[Top.scala 69:19]
    io_bundleCtrl_ctrlStore <= decoder.io_bundleCtrl_ctrlStore @[Top.scala 69:19]
    io_bundleCtrl_ctrlALUSrc <= decoder.io_bundleCtrl_ctrlALUSrc @[Top.scala 69:19]
    io_bundleCtrl_ctrlJAL <= decoder.io_bundleCtrl_ctrlJAL @[Top.scala 69:19]
    io_bundleCtrl_ctrlOP <= decoder.io_bundleCtrl_ctrlOP @[Top.scala 69:19]
    io_bundleCtrl_ctrlSigned <= decoder.io_bundleCtrl_ctrlSigned @[Top.scala 69:19]
    io_bundleCtrl_ctrlLSType <= decoder.io_bundleCtrl_ctrlLSType @[Top.scala 69:19]
    io_resultALU <= alu.io_resultAlu @[Top.scala 72:18]
    io_rs1 <= registers.io_dataRead1 @[Top.scala 75:12]
    io_rs2 <= registers.io_dataRead2 @[Top.scala 76:12]
    io_imm <= decoder.io_imm @[Top.scala 74:12]
    io_resultBranch <= alu.io_resultBranch @[Top.scala 73:21]
    io_result <= memData.io_result @[Top.scala 71:15]
    pcReg.clock <= clock
    pcReg.reset <= reset
    pcReg.io_ctrlJump <= controller.io_bundleControlOut_ctrlJump @[Top.scala 37:23]
    pcReg.io_ctrlBranch <= controller.io_bundleControlOut_ctrlBranch @[Top.scala 36:25]
    pcReg.io_resultBranch <= alu.io_resultBranch @[Top.scala 34:27]
    pcReg.io_addrTarget <= memData.io_result @[Top.scala 35:25]
    memInst.clock <= clock
    memInst.reset <= reset
    memInst.io_addr <= pcReg.io_addrOut @[Top.scala 40:21]
    decoder.clock <= clock
    decoder.reset <= reset
    decoder.io_inst <= memInst.io_inst @[Top.scala 43:21]
    registers.clock <= clock
    registers.reset <= reset
    registers.io_ctrlRegWrite <= controller.io_bundleControlOut_ctrlRegWrite @[Top.scala 47:31]
    registers.io_ctrlJump <= controller.io_bundleControlOut_ctrlJump @[Top.scala 48:27]
    registers.io_pc <= pcReg.io_addrOut @[Top.scala 50:21]
    registers.io_dataWrite <= memData.io_result @[Top.scala 49:28]
    registers.io_bundleReg_rs1 <= decoder.io_bundleReg_rs1 @[Top.scala 46:28]
    registers.io_bundleReg_rs2 <= decoder.io_bundleReg_rs2 @[Top.scala 46:28]
    registers.io_bundleReg_rd <= decoder.io_bundleReg_rd @[Top.scala 46:28]
    alu.clock <= clock
    alu.reset <= reset
    alu.io_bundleAluControl_ctrlALUSrc <= controller.io_bundleAluControl_ctrlALUSrc @[Top.scala 53:29]
    alu.io_bundleAluControl_ctrlJAL <= controller.io_bundleAluControl_ctrlJAL @[Top.scala 53:29]
    alu.io_bundleAluControl_ctrlOP <= controller.io_bundleAluControl_ctrlOP @[Top.scala 53:29]
    alu.io_bundleAluControl_ctrlSigned <= controller.io_bundleAluControl_ctrlSigned @[Top.scala 53:29]
    alu.io_bundleAluControl_ctrlBranch <= controller.io_bundleAluControl_ctrlBranch @[Top.scala 53:29]
    alu.io_dataRead1 <= registers.io_dataRead1 @[Top.scala 54:22]
    alu.io_dataRead2 <= registers.io_dataRead2 @[Top.scala 55:22]
    alu.io_imm <= decoder.io_imm @[Top.scala 56:16]
    alu.io_pc <= pcReg.io_addrOut @[Top.scala 57:15]
    memData.clock <= clock
    memData.reset <= reset
    memData.io_bundleMemDataControl_ctrlLoad <= controller.io_bundleMemDataControl_ctrlLoad @[Top.scala 60:37]
    memData.io_bundleMemDataControl_ctrlStore <= controller.io_bundleMemDataControl_ctrlStore @[Top.scala 60:37]
    memData.io_bundleMemDataControl_ctrlSigned <= controller.io_bundleMemDataControl_ctrlSigned @[Top.scala 60:37]
    memData.io_bundleMemDataControl_ctrlLSType <= controller.io_bundleMemDataControl_ctrlLSType @[Top.scala 60:37]
    memData.io_resultALU <= alu.io_resultAlu @[Top.scala 62:26]
    memData.io_dataStore <= registers.io_dataRead2 @[Top.scala 61:26]
    controller.clock <= clock
    controller.reset <= reset
    controller.io_bundleControlIn_ctrlJump <= decoder.io_bundleCtrl_ctrlJump @[Top.scala 65:35]
    controller.io_bundleControlIn_ctrlBranch <= decoder.io_bundleCtrl_ctrlBranch @[Top.scala 65:35]
    controller.io_bundleControlIn_ctrlRegWrite <= decoder.io_bundleCtrl_ctrlRegWrite @[Top.scala 65:35]
    controller.io_bundleControlIn_ctrlLoad <= decoder.io_bundleCtrl_ctrlLoad @[Top.scala 65:35]
    controller.io_bundleControlIn_ctrlStore <= decoder.io_bundleCtrl_ctrlStore @[Top.scala 65:35]
    controller.io_bundleControlIn_ctrlALUSrc <= decoder.io_bundleCtrl_ctrlALUSrc @[Top.scala 65:35]
    controller.io_bundleControlIn_ctrlJAL <= decoder.io_bundleCtrl_ctrlJAL @[Top.scala 65:35]
    controller.io_bundleControlIn_ctrlOP <= decoder.io_bundleCtrl_ctrlOP @[Top.scala 65:35]
    controller.io_bundleControlIn_ctrlSigned <= decoder.io_bundleCtrl_ctrlSigned @[Top.scala 65:35]
    controller.io_bundleControlIn_ctrlLSType <= decoder.io_bundleCtrl_ctrlLSType @[Top.scala 65:35]
