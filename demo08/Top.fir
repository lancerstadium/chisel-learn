circuit Top :
  module PCReg :
    input clock : Clock
    input reset : Reset
    output io : { addrOut : UInt<32>, flip ctrlJump : UInt<1>, flip ctrlBranch : UInt<1>, flip resultBranch : UInt<1>, flip addrTarget : UInt<32>}

    reg regPC : UInt<32>, clock with :
      reset => (reset, UInt<1>("h0")) @[PCReg.scala 29:24]
    node _T = and(io.ctrlBranch, io.resultBranch) @[PCReg.scala 31:41]
    node _T_1 = or(io.ctrlJump, _T) @[PCReg.scala 31:23]
    when _T_1 : @[PCReg.scala 31:62]
      regPC <= io.addrTarget @[PCReg.scala 33:15]
    else :
      node _regPC_T = add(regPC, UInt<3>("h4")) @[PCReg.scala 36:24]
      node _regPC_T_1 = tail(_regPC_T, 1) @[PCReg.scala 36:24]
      regPC <= _regPC_T_1 @[PCReg.scala 36:15]
    io.addrOut <= regPC @[PCReg.scala 39:16]

  module MemInst :
    input clock : Clock
    input reset : Reset
    output io : { flip addr : UInt<32>, inst : UInt<32>}

    cmem mem : UInt<32> [1024] @[MemInst.scala 20:18]
    node _io_inst_T = dshr(io.addr, UInt<2>("h2")) @[MemInst.scala 27:33]
    node _io_inst_T_1 = bits(_io_inst_T, 9, 0) @[MemInst.scala 27:24]
    read mport io_inst_MPORT = mem[_io_inst_T_1], clock @[MemInst.scala 27:24]
    io.inst <= io_inst_MPORT @[MemInst.scala 27:13]

  module Decoder :
    input clock : Clock
    input reset : Reset
    output io : { flip inst : UInt<32>, bundleCtrl : { ctrlJump : UInt<1>, ctrlBranch : UInt<1>, ctrlRegWrite : UInt<1>, ctrlLoad : UInt<1>, ctrlStore : UInt<1>, ctrlALUSrc : UInt<1>, ctrlJAL : UInt<1>, ctrlOP : UInt<4>, ctrlSigned : UInt<1>, ctrlLSType : UInt<2>}, bundleReg : { rs1 : UInt<5>, rs2 : UInt<5>, rd : UInt<5>}, imm : UInt<32>}

    node _io_bundleReg_rs1_T = bits(io.inst, 19, 15) @[Decoder.scala 23:32]
    io.bundleReg.rs1 <= _io_bundleReg_rs1_T @[Decoder.scala 23:22]
    node _io_bundleReg_rs2_T = bits(io.inst, 24, 20) @[Decoder.scala 24:32]
    io.bundleReg.rs2 <= _io_bundleReg_rs2_T @[Decoder.scala 24:22]
    node _io_bundleReg_rd_T = bits(io.inst, 11, 7) @[Decoder.scala 25:31]
    io.bundleReg.rd <= _io_bundleReg_rd_T @[Decoder.scala 25:21]
    node _imm_i_T = bits(io.inst, 31, 31) @[Decoder.scala 28:37]
    node _imm_i_T_1 = bits(_imm_i_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_i_T_2 = mux(_imm_i_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_i_T_3 = bits(io.inst, 31, 20) @[Decoder.scala 28:51]
    node imm_i = cat(_imm_i_T_2, _imm_i_T_3) @[Cat.scala 31:58]
    node _imm_s_T = bits(io.inst, 31, 31) @[Decoder.scala 29:37]
    node _imm_s_T_1 = bits(_imm_s_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_s_T_2 = mux(_imm_s_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_s_T_3 = bits(io.inst, 31, 25) @[Decoder.scala 29:51]
    node _imm_s_T_4 = bits(io.inst, 11, 7) @[Decoder.scala 29:68]
    node imm_s_hi = cat(_imm_s_T_2, _imm_s_T_3) @[Cat.scala 31:58]
    node imm_s = cat(imm_s_hi, _imm_s_T_4) @[Cat.scala 31:58]
    node _imm_b_T = bits(io.inst, 31, 31) @[Decoder.scala 30:37]
    node _imm_b_T_1 = bits(_imm_b_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_b_T_2 = mux(_imm_b_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_b_T_3 = bits(io.inst, 7, 7) @[Decoder.scala 30:51]
    node _imm_b_T_4 = bits(io.inst, 30, 25) @[Decoder.scala 30:63]
    node _imm_b_T_5 = bits(io.inst, 11, 8) @[Decoder.scala 30:80]
    node imm_b_lo = cat(_imm_b_T_5, UInt<1>("h0")) @[Cat.scala 31:58]
    node imm_b_hi_hi = cat(_imm_b_T_2, _imm_b_T_3) @[Cat.scala 31:58]
    node imm_b_hi = cat(imm_b_hi_hi, _imm_b_T_4) @[Cat.scala 31:58]
    node imm_b = cat(imm_b_hi, imm_b_lo) @[Cat.scala 31:58]
    node _imm_u_T = bits(io.inst, 31, 12) @[Decoder.scala 31:28]
    node _imm_u_T_1 = mux(UInt<1>("h0"), UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 74:12]
    node imm_u = cat(_imm_u_T, _imm_u_T_1) @[Cat.scala 31:58]
    node _imm_j_T = bits(io.inst, 31, 31) @[Decoder.scala 32:37]
    node _imm_j_T_1 = bits(_imm_j_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_j_T_2 = mux(_imm_j_T_1, UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 74:12]
    node _imm_j_T_3 = bits(io.inst, 31, 31) @[Decoder.scala 32:51]
    node _imm_j_T_4 = bits(io.inst, 19, 12) @[Decoder.scala 32:64]
    node _imm_j_T_5 = bits(io.inst, 20, 20) @[Decoder.scala 32:81]
    node _imm_j_T_6 = bits(io.inst, 30, 21) @[Decoder.scala 32:94]
    node imm_j_lo_hi = cat(_imm_j_T_5, _imm_j_T_6) @[Cat.scala 31:58]
    node imm_j_lo = cat(imm_j_lo_hi, UInt<1>("h0")) @[Cat.scala 31:58]
    node imm_j_hi_hi = cat(_imm_j_T_2, _imm_j_T_3) @[Cat.scala 31:58]
    node imm_j_hi = cat(imm_j_hi_hi, _imm_j_T_4) @[Cat.scala 31:58]
    node imm_j = cat(imm_j_hi, imm_j_lo) @[Cat.scala 31:58]
    node _imm_shamt_T = mux(UInt<1>("h0"), UInt<27>("h7ffffff"), UInt<27>("h0")) @[Bitwise.scala 74:12]
    node _imm_shamt_T_1 = bits(io.inst, 24, 20) @[Decoder.scala 34:47]
    node imm_shamt = cat(_imm_shamt_T, _imm_shamt_T_1) @[Cat.scala 31:58]
    wire imm : UInt<32>
    imm <= UInt<32>("h0")
    wire ctrlJump : UInt<1>
    ctrlJump <= UInt<1>("h0")
    wire ctrlBranch : UInt<1>
    ctrlBranch <= UInt<1>("h0")
    wire ctrlRegWrite : UInt<1>
    ctrlRegWrite <= UInt<1>("h1")
    wire ctrlLoad : UInt<1>
    ctrlLoad <= UInt<1>("h0")
    wire ctrlStore : UInt<1>
    ctrlStore <= UInt<1>("h0")
    wire ctrlALUSrc : UInt<1>
    ctrlALUSrc <= UInt<1>("h0")
    wire ctrlJAL : UInt<1>
    ctrlJAL <= UInt<1>("h0")
    wire ctrlOP : UInt<4>
    ctrlOP <= UInt<4>("h0")
    wire ctrlSigned : UInt<1>
    ctrlSigned <= UInt<1>("h1")
    wire ctrlLSType : UInt<2>
    ctrlLSType <= UInt<2>("h0")
    node _T = bits(io.inst, 6, 2) @[Decoder.scala 52:20]
    node _T_1 = eq(UInt<4>("hd"), _T) @[Decoder.scala 52:28]
    node _T_2 = eq(UInt<3>("h5"), _T) @[Decoder.scala 52:28]
    node _T_3 = or(_T_1, _T_2) @[Decoder.scala 52:28]
    when _T_3 : @[Decoder.scala 52:28]
      ctrlALUSrc <= UInt<1>("h1") @[Decoder.scala 55:24]
      ctrlOP <= UInt<1>("h1") @[Decoder.scala 56:20]
      imm <= imm_u @[Decoder.scala 57:17]
    else :
      node _T_4 = eq(UInt<5>("h1b"), _T) @[Decoder.scala 52:28]
      when _T_4 : @[Decoder.scala 52:28]
        ctrlALUSrc <= UInt<1>("h1") @[Decoder.scala 61:24]
        ctrlJump <= UInt<1>("h1") @[Decoder.scala 62:22]
        ctrlOP <= UInt<1>("h1") @[Decoder.scala 63:20]
        ctrlJAL <= UInt<1>("h1") @[Decoder.scala 64:21]
        imm <= imm_j @[Decoder.scala 65:17]
      else :
        node _T_5 = eq(UInt<5>("h19"), _T) @[Decoder.scala 52:28]
        node _T_6 = eq(UInt<1>("h0"), _T) @[Decoder.scala 52:28]
        node _T_7 = eq(UInt<3>("h4"), _T) @[Decoder.scala 52:28]
        node _T_8 = or(_T_5, _T_6) @[Decoder.scala 52:28]
        node _T_9 = or(_T_8, _T_7) @[Decoder.scala 52:28]
        when _T_9 : @[Decoder.scala 52:28]
          ctrlALUSrc <= UInt<1>("h1") @[Decoder.scala 71:24]
          node _T_10 = bits(io.inst, 6, 2) @[Decoder.scala 73:26]
          node _T_11 = eq(_T_10, UInt<5>("h19")) @[Decoder.scala 73:33]
          when _T_11 : @[Decoder.scala 73:49]
            ctrlJump <= UInt<1>("h1") @[Decoder.scala 74:26]
            ctrlOP <= UInt<1>("h1") @[Decoder.scala 75:24]
            imm <= imm_i @[Decoder.scala 76:21]
          else :
            node _T_12 = bits(io.inst, 6, 2) @[Decoder.scala 79:31]
            node _T_13 = eq(_T_12, UInt<1>("h0")) @[Decoder.scala 79:38]
            when _T_13 : @[Decoder.scala 79:54]
              ctrlLoad <= UInt<1>("h1") @[Decoder.scala 80:26]
              ctrlOP <= UInt<1>("h1") @[Decoder.scala 81:24]
              imm <= imm_i @[Decoder.scala 82:21]
              node _T_14 = bits(io.inst, 14, 12) @[Decoder.scala 83:30]
              node _T_15 = eq(_T_14, UInt<3>("h4")) @[Decoder.scala 83:39]
              node _T_16 = bits(io.inst, 14, 12) @[Decoder.scala 83:61]
              node _T_17 = eq(_T_16, UInt<3>("h5")) @[Decoder.scala 83:70]
              node _T_18 = or(_T_15, _T_17) @[Decoder.scala 83:52]
              when _T_18 : @[Decoder.scala 83:84]
                ctrlSigned <= UInt<1>("h0") @[Decoder.scala 84:32]
            else :
              node _T_19 = bits(io.inst, 6, 2) @[Decoder.scala 88:31]
              node _T_20 = eq(_T_19, UInt<3>("h4")) @[Decoder.scala 88:38]
              node _T_21 = bits(io.inst, 14, 12) @[Decoder.scala 88:64]
              node _T_22 = eq(_T_21, UInt<1>("h1")) @[Decoder.scala 88:73]
              node _T_23 = bits(io.inst, 14, 12) @[Decoder.scala 88:96]
              node _T_24 = eq(_T_23, UInt<3>("h5")) @[Decoder.scala 88:105]
              node _T_25 = or(_T_22, _T_24) @[Decoder.scala 88:86]
              node _T_26 = and(_T_20, _T_25) @[Decoder.scala 88:53]
              when _T_26 : @[Decoder.scala 88:120]
                imm <= imm_shamt @[Decoder.scala 89:21]
                node _T_27 = bits(io.inst, 30, 30) @[Decoder.scala 90:36]
                node _T_28 = bits(io.inst, 14, 12) @[Decoder.scala 90:49]
                node _T_29 = cat(_T_27, _T_28) @[Cat.scala 31:58]
                node _T_30 = eq(UInt<1>("h1"), _T_29) @[Decoder.scala 90:60]
                when _T_30 : @[Decoder.scala 90:60]
                  ctrlOP <= UInt<4>("h8") @[Decoder.scala 93:32]
                else :
                  node _T_31 = eq(UInt<3>("h5"), _T_29) @[Decoder.scala 90:60]
                  when _T_31 : @[Decoder.scala 90:60]
                    ctrlOP <= UInt<4>("h9") @[Decoder.scala 97:32]
                  else :
                    node _T_32 = eq(UInt<4>("hd"), _T_29) @[Decoder.scala 90:60]
                    when _T_32 : @[Decoder.scala 90:60]
                      ctrlOP <= UInt<4>("hb") @[Decoder.scala 101:32]
              else :
                imm <= imm_i @[Decoder.scala 105:21]
                node _T_33 = bits(io.inst, 14, 12) @[Decoder.scala 106:32]
                node _T_34 = eq(UInt<1>("h0"), _T_33) @[Decoder.scala 106:42]
                when _T_34 : @[Decoder.scala 106:42]
                  ctrlOP <= UInt<1>("h1") @[Decoder.scala 109:32]
                else :
                  node _T_35 = eq(UInt<2>("h2"), _T_33) @[Decoder.scala 106:42]
                  when _T_35 : @[Decoder.scala 106:42]
                    ctrlOP <= UInt<4>("he") @[Decoder.scala 113:32]
                  else :
                    node _T_36 = eq(UInt<2>("h3"), _T_33) @[Decoder.scala 106:42]
                    when _T_36 : @[Decoder.scala 106:42]
                      ctrlOP <= UInt<4>("he") @[Decoder.scala 117:32]
                      ctrlSigned <= UInt<1>("h0") @[Decoder.scala 118:36]
                    else :
                      node _T_37 = eq(UInt<3>("h4"), _T_33) @[Decoder.scala 106:42]
                      when _T_37 : @[Decoder.scala 106:42]
                        ctrlOP <= UInt<3>("h7") @[Decoder.scala 122:32]
                      else :
                        node _T_38 = eq(UInt<3>("h6"), _T_33) @[Decoder.scala 106:42]
                        when _T_38 : @[Decoder.scala 106:42]
                          ctrlOP <= UInt<3>("h5") @[Decoder.scala 126:32]
                        else :
                          node _T_39 = eq(UInt<3>("h7"), _T_33) @[Decoder.scala 106:42]
                          when _T_39 : @[Decoder.scala 106:42]
                            ctrlOP <= UInt<3>("h4") @[Decoder.scala 130:32]
        else :
          node _T_40 = eq(UInt<5>("h18"), _T) @[Decoder.scala 52:28]
          when _T_40 : @[Decoder.scala 52:28]
            ctrlALUSrc <= UInt<1>("h0") @[Decoder.scala 137:24]
            ctrlBranch <= UInt<1>("h1") @[Decoder.scala 138:24]
            ctrlRegWrite <= UInt<1>("h0") @[Decoder.scala 139:26]
            imm <= imm_b @[Decoder.scala 140:17]
            node _T_41 = bits(io.inst, 14, 12) @[Decoder.scala 141:28]
            node _T_42 = eq(UInt<1>("h0"), _T_41) @[Decoder.scala 141:38]
            when _T_42 : @[Decoder.scala 141:38]
              ctrlOP <= UInt<4>("hc") @[Decoder.scala 144:28]
            else :
              node _T_43 = eq(UInt<1>("h1"), _T_41) @[Decoder.scala 141:38]
              when _T_43 : @[Decoder.scala 141:38]
                ctrlOP <= UInt<4>("hd") @[Decoder.scala 148:28]
              else :
                node _T_44 = eq(UInt<3>("h4"), _T_41) @[Decoder.scala 141:38]
                when _T_44 : @[Decoder.scala 141:38]
                  ctrlOP <= UInt<4>("he") @[Decoder.scala 152:28]
                else :
                  node _T_45 = eq(UInt<3>("h5"), _T_41) @[Decoder.scala 141:38]
                  when _T_45 : @[Decoder.scala 141:38]
                    ctrlOP <= UInt<4>("hf") @[Decoder.scala 156:28]
                  else :
                    node _T_46 = eq(UInt<3>("h6"), _T_41) @[Decoder.scala 141:38]
                    when _T_46 : @[Decoder.scala 141:38]
                      ctrlOP <= UInt<4>("he") @[Decoder.scala 160:28]
                      ctrlSigned <= UInt<1>("h0") @[Decoder.scala 161:32]
                    else :
                      node _T_47 = eq(UInt<3>("h7"), _T_41) @[Decoder.scala 141:38]
                      when _T_47 : @[Decoder.scala 141:38]
                        ctrlOP <= UInt<4>("hf") @[Decoder.scala 165:28]
                        ctrlSigned <= UInt<1>("h0") @[Decoder.scala 166:32]
          else :
            node _T_48 = eq(UInt<4>("h8"), _T) @[Decoder.scala 52:28]
            when _T_48 : @[Decoder.scala 52:28]
              ctrlALUSrc <= UInt<1>("h1") @[Decoder.scala 172:24]
              ctrlStore <= UInt<1>("h1") @[Decoder.scala 173:23]
              ctrlRegWrite <= UInt<1>("h0") @[Decoder.scala 174:26]
              ctrlOP <= UInt<1>("h1") @[Decoder.scala 175:20]
              imm <= imm_s @[Decoder.scala 176:17]
              node _T_49 = bits(io.inst, 14, 12) @[Decoder.scala 177:26]
              node _T_50 = eq(_T_49, UInt<1>("h0")) @[Decoder.scala 177:35]
              when _T_50 : @[Decoder.scala 177:49]
                ctrlLSType <= UInt<1>("h0") @[Decoder.scala 178:28]
              node _T_51 = bits(io.inst, 14, 12) @[Decoder.scala 180:26]
              node _T_52 = eq(_T_51, UInt<1>("h1")) @[Decoder.scala 180:35]
              when _T_52 : @[Decoder.scala 180:49]
                ctrlLSType <= UInt<1>("h1") @[Decoder.scala 181:28]
            else :
              node _T_53 = eq(UInt<4>("hc"), _T) @[Decoder.scala 52:28]
              when _T_53 : @[Decoder.scala 52:28]
                node _T_54 = bits(io.inst, 14, 12) @[Decoder.scala 186:28]
                node _T_55 = eq(UInt<1>("h0"), _T_54) @[Decoder.scala 186:38]
                when _T_55 : @[Decoder.scala 186:38]
                  node _T_56 = bits(io.inst, 30, 30) @[Decoder.scala 189:34]
                  when _T_56 : @[Decoder.scala 189:40]
                    ctrlOP <= UInt<2>("h2") @[Decoder.scala 190:32]
                  else :
                    ctrlOP <= UInt<1>("h1") @[Decoder.scala 192:32]
                else :
                  node _T_57 = eq(UInt<1>("h1"), _T_54) @[Decoder.scala 186:38]
                  when _T_57 : @[Decoder.scala 186:38]
                    ctrlOP <= UInt<4>("h8") @[Decoder.scala 197:28]
                  else :
                    node _T_58 = eq(UInt<2>("h2"), _T_54) @[Decoder.scala 186:38]
                    when _T_58 : @[Decoder.scala 186:38]
                      ctrlOP <= UInt<4>("he") @[Decoder.scala 201:28]
                    else :
                      node _T_59 = eq(UInt<2>("h3"), _T_54) @[Decoder.scala 186:38]
                      when _T_59 : @[Decoder.scala 186:38]
                        ctrlOP <= UInt<4>("he") @[Decoder.scala 205:28]
                        ctrlOP <= UInt<1>("h0") @[Decoder.scala 206:28]
                      else :
                        node _T_60 = eq(UInt<3>("h4"), _T_54) @[Decoder.scala 186:38]
                        when _T_60 : @[Decoder.scala 186:38]
                          ctrlOP <= UInt<3>("h7") @[Decoder.scala 210:28]
                        else :
                          node _T_61 = eq(UInt<3>("h5"), _T_54) @[Decoder.scala 186:38]
                          when _T_61 : @[Decoder.scala 186:38]
                            node _T_62 = bits(io.inst, 30, 30) @[Decoder.scala 214:34]
                            when _T_62 : @[Decoder.scala 214:40]
                              ctrlOP <= UInt<4>("hb") @[Decoder.scala 215:32]
                            else :
                              ctrlOP <= UInt<4>("h9") @[Decoder.scala 217:32]
                          else :
                            node _T_63 = eq(UInt<3>("h6"), _T_54) @[Decoder.scala 186:38]
                            when _T_63 : @[Decoder.scala 186:38]
                              ctrlOP <= UInt<3>("h5") @[Decoder.scala 222:28]
                            else :
                              node _T_64 = eq(UInt<3>("h7"), _T_54) @[Decoder.scala 186:38]
                              when _T_64 : @[Decoder.scala 186:38]
                                ctrlOP <= UInt<3>("h4") @[Decoder.scala 226:28]
    io.bundleCtrl.ctrlALUSrc <= ctrlALUSrc @[Decoder.scala 233:30]
    io.bundleCtrl.ctrlBranch <= ctrlBranch @[Decoder.scala 234:30]
    io.bundleCtrl.ctrlJAL <= ctrlJAL @[Decoder.scala 235:27]
    io.bundleCtrl.ctrlJump <= ctrlJump @[Decoder.scala 236:28]
    io.bundleCtrl.ctrlLoad <= ctrlLoad @[Decoder.scala 237:28]
    io.bundleCtrl.ctrlOP <= ctrlOP @[Decoder.scala 238:26]
    io.bundleCtrl.ctrlRegWrite <= ctrlRegWrite @[Decoder.scala 239:32]
    io.bundleCtrl.ctrlSigned <= ctrlSigned @[Decoder.scala 240:30]
    io.bundleCtrl.ctrlStore <= ctrlStore @[Decoder.scala 241:29]
    io.bundleCtrl.ctrlLSType <= ctrlLSType @[Decoder.scala 242:30]
    io.imm <= imm @[Decoder.scala 243:12]

  module Registers :
    input clock : Clock
    input reset : Reset
    output io : { flip ctrlRegWrite : UInt<1>, flip ctrlJump : UInt<1>, flip pc : UInt<32>, flip dataWrite : UInt<32>, flip bundleReg : { rs1 : UInt<5>, rs2 : UInt<5>, rd : UInt<5>}, dataRead1 : UInt<32>, dataRead2 : UInt<32>}

    reg regs : UInt<32>[32], clock with :
      reset => (UInt<1>("h0"), regs) @[Registers.scala 23:19]
    node _T = eq(io.bundleReg.rs1, UInt<1>("h0")) @[Registers.scala 26:27]
    when _T : @[Registers.scala 26:36]
      io.dataRead1 <= UInt<1>("h0") @[Registers.scala 27:22]
    node _T_1 = eq(io.bundleReg.rs2, UInt<1>("h0")) @[Registers.scala 29:27]
    when _T_1 : @[Registers.scala 29:36]
      io.dataRead2 <= UInt<1>("h0") @[Registers.scala 30:22]
    io.dataRead1 <= regs[io.bundleReg.rs1] @[Registers.scala 33:18]
    io.dataRead2 <= regs[io.bundleReg.rs2] @[Registers.scala 34:18]
    node _T_2 = neq(io.bundleReg.rd, UInt<1>("h0")) @[Registers.scala 36:45]
    node _T_3 = and(io.ctrlRegWrite, _T_2) @[Registers.scala 36:26]
    when _T_3 : @[Registers.scala 36:54]
      when io.ctrlJump : @[Registers.scala 37:27]
        node _regs_T = add(io.pc, UInt<3>("h4")) @[Registers.scala 38:44]
        node _regs_T_1 = tail(_regs_T, 1) @[Registers.scala 38:44]
        regs[io.bundleReg.rd] <= _regs_T_1 @[Registers.scala 38:35]
      else :
        regs[io.bundleReg.rd] <= io.dataWrite @[Registers.scala 40:35]

  module Alu :
    input clock : Clock
    input reset : Reset
    output io : { bundleAluControl : { flip ctrlALUSrc : UInt<1>, flip ctrlJAL : UInt<1>, flip ctrlOP : UInt<4>, flip ctrlSigned : UInt<1>, flip ctrlBranch : UInt<1>}, flip dataRead1 : UInt<32>, flip dataRead2 : UInt<32>, flip imm : UInt<32>, flip pc : UInt<32>, resultBranch : UInt<1>, resultAlu : UInt<32>}

    wire resultBranch : UInt<1>
    resultBranch <= UInt<1>("h0")
    wire resultAlu : UInt<32>
    resultAlu <= UInt<32>("h0")
    wire oprand1 : UInt<32>
    oprand1 <= UInt<32>("h0")
    wire oprand2 : UInt<32>
    oprand2 <= UInt<32>("h0")
    node _oprand1_T = mux(io.bundleAluControl.ctrlJAL, io.pc, io.dataRead1) @[Alu.scala 31:19]
    oprand1 <= _oprand1_T @[Alu.scala 31:13]
    node _oprand2_T = mux(io.bundleAluControl.ctrlALUSrc, io.imm, io.dataRead2) @[Alu.scala 32:19]
    oprand2 <= _oprand2_T @[Alu.scala 32:13]
    node _T = eq(UInt<1>("h0"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
    when _T : @[Alu.scala 35:40]
      resultAlu <= UInt<1>("h0") @[Alu.scala 37:23]
      resultBranch <= UInt<1>("h0") @[Alu.scala 38:26]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
      when _T_1 : @[Alu.scala 35:40]
        node _resultAlu_T = add(oprand1, oprand2) @[Alu.scala 41:34]
        resultAlu <= _resultAlu_T @[Alu.scala 41:23]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
        when _T_2 : @[Alu.scala 35:40]
          node _resultAlu_T_1 = sub(oprand1, oprand2) @[Alu.scala 44:34]
          node _resultAlu_T_2 = asUInt(_resultAlu_T_1) @[Alu.scala 44:34]
          resultAlu <= _resultAlu_T_2 @[Alu.scala 44:23]
        else :
          node _T_3 = eq(UInt<3>("h4"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
          when _T_3 : @[Alu.scala 35:40]
            node _resultAlu_T_3 = and(oprand1, oprand2) @[Alu.scala 47:34]
            resultAlu <= _resultAlu_T_3 @[Alu.scala 47:23]
          else :
            node _T_4 = eq(UInt<3>("h5"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
            when _T_4 : @[Alu.scala 35:40]
              node _resultAlu_T_4 = or(oprand1, oprand2) @[Alu.scala 50:34]
              resultAlu <= _resultAlu_T_4 @[Alu.scala 50:23]
            else :
              node _T_5 = eq(UInt<3>("h7"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
              when _T_5 : @[Alu.scala 35:40]
                node _resultAlu_T_5 = xor(oprand1, oprand2) @[Alu.scala 53:34]
                resultAlu <= _resultAlu_T_5 @[Alu.scala 53:23]
              else :
                node _T_6 = eq(UInt<4>("h8"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
                when _T_6 : @[Alu.scala 35:40]
                  node _resultAlu_T_6 = bits(oprand2, 4, 0) @[Alu.scala 56:44]
                  node _resultAlu_T_7 = dshl(oprand1, _resultAlu_T_6) @[Alu.scala 56:34]
                  resultAlu <= _resultAlu_T_7 @[Alu.scala 56:23]
                else :
                  node _T_7 = eq(UInt<4>("h9"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
                  when _T_7 : @[Alu.scala 35:40]
                    node _resultAlu_T_8 = bits(oprand2, 4, 0) @[Alu.scala 59:44]
                    node _resultAlu_T_9 = dshr(oprand1, _resultAlu_T_8) @[Alu.scala 59:34]
                    resultAlu <= _resultAlu_T_9 @[Alu.scala 59:23]
                  else :
                    node _T_8 = eq(UInt<4>("hb"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
                    when _T_8 : @[Alu.scala 35:40]
                      node _resultAlu_T_10 = asSInt(oprand1) @[Alu.scala 62:35]
                      node _resultAlu_T_11 = bits(oprand2, 4, 0) @[Alu.scala 62:52]
                      node _resultAlu_T_12 = dshr(_resultAlu_T_10, _resultAlu_T_11) @[Alu.scala 62:42]
                      node _resultAlu_T_13 = asUInt(_resultAlu_T_12) @[Alu.scala 62:60]
                      resultAlu <= _resultAlu_T_13 @[Alu.scala 62:23]
                    else :
                      node _T_9 = eq(UInt<4>("hc"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
                      when _T_9 : @[Alu.scala 35:40]
                        node _resultBranch_T = asSInt(oprand1) @[Alu.scala 65:37]
                        node _resultBranch_T_1 = asSInt(oprand2) @[Alu.scala 65:56]
                        node _resultBranch_T_2 = eq(_resultBranch_T, _resultBranch_T_1) @[Alu.scala 65:44]
                        resultBranch <= _resultBranch_T_2 @[Alu.scala 65:26]
                        node _resultAlu_T_14 = add(io.pc, io.imm) @[Alu.scala 66:32]
                        resultAlu <= _resultAlu_T_14 @[Alu.scala 66:23]
                      else :
                        node _T_10 = eq(UInt<4>("hd"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
                        when _T_10 : @[Alu.scala 35:40]
                          node _resultBranch_T_3 = asSInt(oprand1) @[Alu.scala 69:37]
                          node _resultBranch_T_4 = asSInt(oprand2) @[Alu.scala 69:56]
                          node _resultBranch_T_5 = neq(_resultBranch_T_3, _resultBranch_T_4) @[Alu.scala 69:44]
                          resultBranch <= _resultBranch_T_5 @[Alu.scala 69:26]
                          node _resultAlu_T_15 = add(io.pc, io.imm) @[Alu.scala 70:32]
                          resultAlu <= _resultAlu_T_15 @[Alu.scala 70:23]
                        else :
                          node _T_11 = eq(UInt<4>("he"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
                          when _T_11 : @[Alu.scala 35:40]
                            when io.bundleAluControl.ctrlBranch : @[Alu.scala 73:50]
                              when io.bundleAluControl.ctrlSigned : @[Alu.scala 74:54]
                                node _resultBranch_T_6 = asSInt(oprand1) @[Alu.scala 75:45]
                                node _resultBranch_T_7 = asSInt(oprand2) @[Alu.scala 75:62]
                                node _resultBranch_T_8 = lt(_resultBranch_T_6, _resultBranch_T_7) @[Alu.scala 75:52]
                                resultBranch <= _resultBranch_T_8 @[Alu.scala 75:34]
                              else :
                                node _resultBranch_T_9 = lt(oprand1, oprand2) @[Alu.scala 77:45]
                                resultBranch <= _resultBranch_T_9 @[Alu.scala 77:34]
                              node _resultAlu_T_16 = add(io.pc, io.imm) @[Alu.scala 79:36]
                              resultAlu <= _resultAlu_T_16 @[Alu.scala 79:27]
                            else :
                              when io.bundleAluControl.ctrlSigned : @[Alu.scala 81:54]
                                node _resultAlu_T_17 = asSInt(oprand1) @[Alu.scala 82:42]
                                node _resultAlu_T_18 = asSInt(oprand2) @[Alu.scala 82:59]
                                node _resultAlu_T_19 = lt(_resultAlu_T_17, _resultAlu_T_18) @[Alu.scala 82:49]
                                resultAlu <= _resultAlu_T_19 @[Alu.scala 82:31]
                              else :
                                node _resultAlu_T_20 = lt(oprand1, oprand2) @[Alu.scala 84:42]
                                resultAlu <= _resultAlu_T_20 @[Alu.scala 84:31]
                          else :
                            node _T_12 = eq(UInt<4>("hf"), io.bundleAluControl.ctrlOP) @[Alu.scala 35:40]
                            when _T_12 : @[Alu.scala 35:40]
                              when io.bundleAluControl.ctrlSigned : @[Alu.scala 89:50]
                                node _resultBranch_T_10 = asSInt(oprand1) @[Alu.scala 90:41]
                                node _resultBranch_T_11 = asSInt(oprand2) @[Alu.scala 90:59]
                                node _resultBranch_T_12 = geq(_resultBranch_T_10, _resultBranch_T_11) @[Alu.scala 90:48]
                                resultBranch <= _resultBranch_T_12 @[Alu.scala 90:30]
                              else :
                                node _resultBranch_T_13 = geq(oprand1, oprand2) @[Alu.scala 92:41]
                                resultBranch <= _resultBranch_T_13 @[Alu.scala 92:30]
                              node _resultAlu_T_21 = add(io.pc, io.imm) @[Alu.scala 94:32]
                              resultAlu <= _resultAlu_T_21 @[Alu.scala 94:23]
    io.resultAlu <= resultAlu @[Alu.scala 98:18]
    io.resultBranch <= resultBranch @[Alu.scala 99:21]

  module MemData :
    input clock : Clock
    input reset : Reset
    output io : { bundleMemDataControl : { flip ctrlLoad : UInt<1>, flip ctrlStore : UInt<1>, flip ctrlSigned : UInt<1>, flip ctrlLSType : UInt<2>}, flip resultALU : UInt<32>, flip dataStore : UInt<32>, result : UInt<32>}

    cmem mem : UInt<32> [1024] @[MemData.scala 22:18]
    wire result : UInt<32>
    result <= UInt<32>("h0")
    wire dataLoad : UInt<32>
    dataLoad <= UInt<32>("h0")
    node _dataLoad_T = dshr(io.resultALU, UInt<2>("h2")) @[MemData.scala 31:39]
    node _dataLoad_T_1 = bits(_dataLoad_T, 9, 0) @[MemData.scala 31:25]
    read mport dataLoad_MPORT = mem[_dataLoad_T_1], clock @[MemData.scala 31:25]
    dataLoad <= dataLoad_MPORT @[MemData.scala 31:14]
    when io.bundleMemDataControl.ctrlStore : @[MemData.scala 34:45]
      node _T = eq(io.bundleMemDataControl.ctrlLSType, UInt<2>("h2")) @[MemData.scala 35:49]
      when _T : @[MemData.scala 35:59]
        node _T_1 = dshr(io.resultALU, UInt<2>("h2")) @[MemData.scala 36:36]
        node _T_2 = bits(_T_1, 9, 0)
        write mport MPORT = mem[_T_2], clock
        MPORT <= io.dataStore
      else :
        node _T_3 = eq(io.bundleMemDataControl.ctrlLSType, UInt<1>("h1")) @[MemData.scala 37:55]
        when _T_3 : @[MemData.scala 37:65]
          node _T_4 = dshr(io.resultALU, UInt<2>("h2")) @[MemData.scala 38:36]
          node _T_5 = bits(dataLoad, 31, 16) @[MemData.scala 38:74]
          node _T_6 = bits(io.dataStore, 15, 0) @[MemData.scala 38:96]
          node _T_7 = cat(_T_5, _T_6) @[Cat.scala 31:58]
          node _T_8 = bits(_T_4, 9, 0)
          write mport MPORT_1 = mem[_T_8], clock
          MPORT_1 <= _T_7
        else :
          node _T_9 = dshr(io.resultALU, UInt<2>("h2")) @[MemData.scala 40:36]
          node _T_10 = bits(dataLoad, 31, 8) @[MemData.scala 40:74]
          node _T_11 = bits(io.dataStore, 7, 0) @[MemData.scala 40:95]
          node _T_12 = cat(_T_10, _T_11) @[Cat.scala 31:58]
          node _T_13 = bits(_T_9, 9, 0)
          write mport MPORT_2 = mem[_T_13], clock
          MPORT_2 <= _T_12
    when io.bundleMemDataControl.ctrlLoad : @[MemData.scala 44:45]
      node _T_14 = eq(io.bundleMemDataControl.ctrlLSType, UInt<2>("h2")) @[MemData.scala 45:49]
      when _T_14 : @[MemData.scala 45:59]
        result <= dataLoad @[MemData.scala 46:20]
      else :
        node _T_15 = eq(io.bundleMemDataControl.ctrlLSType, UInt<1>("h1")) @[MemData.scala 47:55]
        when _T_15 : @[MemData.scala 47:65]
          when io.bundleMemDataControl.ctrlSigned : @[MemData.scala 48:55]
            node _result_T = bits(dataLoad, 15, 15) @[MemData.scala 49:48]
            node _result_T_1 = bits(_result_T, 0, 0) @[Bitwise.scala 74:15]
            node _result_T_2 = mux(_result_T_1, UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
            node _result_T_3 = bits(dataLoad, 15, 0) @[MemData.scala 49:63]
            node _result_T_4 = cat(_result_T_2, _result_T_3) @[Cat.scala 31:58]
            result <= _result_T_4 @[MemData.scala 49:24]
          else :
            node _result_T_5 = mux(UInt<1>("h0"), UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
            node _result_T_6 = bits(dataLoad, 15, 0) @[MemData.scala 51:54]
            node _result_T_7 = cat(_result_T_5, _result_T_6) @[Cat.scala 31:58]
            result <= _result_T_7 @[MemData.scala 51:24]
        else :
          when io.bundleMemDataControl.ctrlSigned : @[MemData.scala 54:55]
            node _result_T_8 = bits(dataLoad, 7, 7) @[MemData.scala 55:48]
            node _result_T_9 = bits(_result_T_8, 0, 0) @[Bitwise.scala 74:15]
            node _result_T_10 = mux(_result_T_9, UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 74:12]
            node _result_T_11 = bits(dataLoad, 7, 0) @[MemData.scala 55:62]
            node _result_T_12 = cat(_result_T_10, _result_T_11) @[Cat.scala 31:58]
            result <= _result_T_12 @[MemData.scala 55:24]
          else :
            node _result_T_13 = mux(UInt<1>("h0"), UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 74:12]
            node _result_T_14 = bits(dataLoad, 7, 0) @[MemData.scala 57:54]
            node _result_T_15 = cat(_result_T_13, _result_T_14) @[Cat.scala 31:58]
            result <= _result_T_15 @[MemData.scala 57:24]
    else :
      result <= io.resultALU @[MemData.scala 62:16]
    io.result <= result @[MemData.scala 66:15]

  module Controller :
    input clock : Clock
    input reset : Reset
    output io : { flip bundleControlIn : { ctrlJump : UInt<1>, ctrlBranch : UInt<1>, ctrlRegWrite : UInt<1>, ctrlLoad : UInt<1>, ctrlStore : UInt<1>, ctrlALUSrc : UInt<1>, ctrlJAL : UInt<1>, ctrlOP : UInt<4>, ctrlSigned : UInt<1>, ctrlLSType : UInt<2>}, flip bundleAluControl : { flip ctrlALUSrc : UInt<1>, flip ctrlJAL : UInt<1>, flip ctrlOP : UInt<4>, flip ctrlSigned : UInt<1>, flip ctrlBranch : UInt<1>}, flip bundleMemDataControl : { flip ctrlLoad : UInt<1>, flip ctrlStore : UInt<1>, flip ctrlSigned : UInt<1>, flip ctrlLSType : UInt<2>}, bundleControlOut : { ctrlJump : UInt<1>, ctrlBranch : UInt<1>, ctrlRegWrite : UInt<1>, ctrlLoad : UInt<1>, ctrlStore : UInt<1>, ctrlALUSrc : UInt<1>, ctrlJAL : UInt<1>, ctrlOP : UInt<4>, ctrlSigned : UInt<1>, ctrlLSType : UInt<2>}}

    io.bundleAluControl.ctrlALUSrc <= io.bundleControlIn.ctrlALUSrc @[Controller.scala 19:36]
    io.bundleAluControl.ctrlJAL <= io.bundleControlIn.ctrlJAL @[Controller.scala 20:33]
    io.bundleAluControl.ctrlOP <= io.bundleControlIn.ctrlOP @[Controller.scala 21:32]
    io.bundleAluControl.ctrlSigned <= io.bundleControlIn.ctrlSigned @[Controller.scala 22:36]
    io.bundleAluControl.ctrlBranch <= io.bundleControlIn.ctrlBranch @[Controller.scala 23:36]
    io.bundleMemDataControl.ctrlLSType <= io.bundleControlIn.ctrlALUSrc @[Controller.scala 26:40]
    io.bundleMemDataControl.ctrlLoad <= io.bundleControlIn.ctrlLoad @[Controller.scala 27:38]
    io.bundleMemDataControl.ctrlSigned <= io.bundleControlIn.ctrlSigned @[Controller.scala 28:40]
    io.bundleMemDataControl.ctrlStore <= io.bundleControlIn.ctrlStore @[Controller.scala 29:39]
    io.bundleControlOut <= io.bundleControlIn @[Controller.scala 32:25]

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io : { addr : UInt<32>, inst : UInt<32>, bundleCtrl : { ctrlJump : UInt<1>, ctrlBranch : UInt<1>, ctrlRegWrite : UInt<1>, ctrlLoad : UInt<1>, ctrlStore : UInt<1>, ctrlALUSrc : UInt<1>, ctrlJAL : UInt<1>, ctrlOP : UInt<4>, ctrlSigned : UInt<1>, ctrlLSType : UInt<2>}, resultALU : UInt<32>, rs1 : UInt<32>, rs2 : UInt<32>, imm : UInt<32>, resultBranch : UInt<1>, result : UInt<32>}

    inst pcReg of PCReg @[Top.scala 25:23]
    pcReg.clock <= clock
    pcReg.reset <= reset
    inst memInst of MemInst @[Top.scala 26:25]
    memInst.clock <= clock
    memInst.reset <= reset
    inst decoder of Decoder @[Top.scala 27:25]
    decoder.clock <= clock
    decoder.reset <= reset
    inst registers of Registers @[Top.scala 28:27]
    registers.clock <= clock
    registers.reset <= reset
    inst alu of Alu @[Top.scala 29:21]
    alu.clock <= clock
    alu.reset <= reset
    inst memData of MemData @[Top.scala 30:25]
    memData.clock <= clock
    memData.reset <= reset
    inst controller of Controller @[Top.scala 31:28]
    controller.clock <= clock
    controller.reset <= reset
    pcReg.io.resultBranch <= alu.io.resultBranch @[Top.scala 34:27]
    pcReg.io.addrTarget <= memData.io.result @[Top.scala 35:25]
    pcReg.io.ctrlBranch <= controller.io.bundleControlOut.ctrlBranch @[Top.scala 36:25]
    pcReg.io.ctrlJump <= controller.io.bundleControlOut.ctrlJump @[Top.scala 37:23]
    memInst.io.addr <= pcReg.io.addrOut @[Top.scala 40:21]
    decoder.io.inst <= memInst.io.inst @[Top.scala 43:21]
    registers.io.bundleReg <= decoder.io.bundleReg @[Top.scala 46:28]
    registers.io.ctrlRegWrite <= controller.io.bundleControlOut.ctrlRegWrite @[Top.scala 47:31]
    registers.io.ctrlJump <= controller.io.bundleControlOut.ctrlJump @[Top.scala 48:27]
    registers.io.dataWrite <= memData.io.result @[Top.scala 49:28]
    registers.io.pc <= pcReg.io.addrOut @[Top.scala 50:21]
    alu.io.bundleAluControl.ctrlBranch <= controller.io.bundleAluControl.ctrlBranch @[Top.scala 53:29]
    alu.io.bundleAluControl.ctrlSigned <= controller.io.bundleAluControl.ctrlSigned @[Top.scala 53:29]
    alu.io.bundleAluControl.ctrlOP <= controller.io.bundleAluControl.ctrlOP @[Top.scala 53:29]
    alu.io.bundleAluControl.ctrlJAL <= controller.io.bundleAluControl.ctrlJAL @[Top.scala 53:29]
    alu.io.bundleAluControl.ctrlALUSrc <= controller.io.bundleAluControl.ctrlALUSrc @[Top.scala 53:29]
    alu.io.dataRead1 <= registers.io.dataRead1 @[Top.scala 54:22]
    alu.io.dataRead2 <= registers.io.dataRead2 @[Top.scala 55:22]
    alu.io.imm <= decoder.io.imm @[Top.scala 56:16]
    alu.io.pc <= pcReg.io.addrOut @[Top.scala 57:15]
    memData.io.bundleMemDataControl.ctrlLSType <= controller.io.bundleMemDataControl.ctrlLSType @[Top.scala 60:37]
    memData.io.bundleMemDataControl.ctrlSigned <= controller.io.bundleMemDataControl.ctrlSigned @[Top.scala 60:37]
    memData.io.bundleMemDataControl.ctrlStore <= controller.io.bundleMemDataControl.ctrlStore @[Top.scala 60:37]
    memData.io.bundleMemDataControl.ctrlLoad <= controller.io.bundleMemDataControl.ctrlLoad @[Top.scala 60:37]
    memData.io.dataStore <= registers.io.dataRead2 @[Top.scala 61:26]
    memData.io.resultALU <= alu.io.resultAlu @[Top.scala 62:26]
    controller.io.bundleControlIn <= decoder.io.bundleCtrl @[Top.scala 65:35]
    io.addr <= pcReg.io.addrOut @[Top.scala 68:13]
    io.bundleCtrl <= decoder.io.bundleCtrl @[Top.scala 69:19]
    io.inst <= memInst.io.inst @[Top.scala 70:13]
    io.result <= memData.io.result @[Top.scala 71:15]
    io.resultALU <= alu.io.resultAlu @[Top.scala 72:18]
    io.resultBranch <= alu.io.resultBranch @[Top.scala 73:21]
    io.imm <= decoder.io.imm @[Top.scala 74:12]
    io.rs1 <= registers.io.dataRead1 @[Top.scala 75:12]
    io.rs2 <= registers.io.dataRead2 @[Top.scala 76:12]

