circuit Alu :
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
