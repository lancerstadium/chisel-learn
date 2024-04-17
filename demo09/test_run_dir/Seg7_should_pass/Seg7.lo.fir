circuit Seg7 :
  module Seg7 :
    input clock : Clock
    input reset : UInt<1>
    input io_sw : UInt<4>
    output io_segOut : UInt<7>

    node _T = eq(UInt<1>("h0"), io_sw) @[Hello.scala 13:19]
    node _T_1 = eq(UInt<1>("h1"), io_sw) @[Hello.scala 13:19]
    node _T_2 = eq(UInt<2>("h2"), io_sw) @[Hello.scala 13:19]
    node _T_3 = eq(UInt<2>("h3"), io_sw) @[Hello.scala 13:19]
    node _T_4 = eq(UInt<3>("h4"), io_sw) @[Hello.scala 13:19]
    node _T_5 = eq(UInt<3>("h5"), io_sw) @[Hello.scala 13:19]
    node _T_6 = eq(UInt<3>("h6"), io_sw) @[Hello.scala 13:19]
    node _T_7 = eq(UInt<3>("h7"), io_sw) @[Hello.scala 13:19]
    node _T_8 = eq(UInt<4>("h8"), io_sw) @[Hello.scala 13:19]
    node _T_9 = eq(UInt<4>("h9"), io_sw) @[Hello.scala 13:19]
    node _T_10 = eq(UInt<4>("ha"), io_sw) @[Hello.scala 13:19]
    node _T_11 = eq(UInt<4>("hb"), io_sw) @[Hello.scala 13:19]
    node _T_12 = eq(UInt<4>("hc"), io_sw) @[Hello.scala 13:19]
    node _T_13 = eq(UInt<4>("hd"), io_sw) @[Hello.scala 13:19]
    node _T_14 = eq(UInt<4>("he"), io_sw) @[Hello.scala 13:19]
    node _T_15 = eq(UInt<4>("hf"), io_sw) @[Hello.scala 13:19]
    node _GEN_0 = mux(_T_15, UInt<4>("he"), UInt<7>("h7f")) @[Hello.scala 11:15 13:19 29:36]
    node _GEN_1 = mux(_T_14, UInt<3>("h6"), _GEN_0) @[Hello.scala 13:19 28:36]
    node _GEN_2 = mux(_T_13, UInt<6>("h21"), _GEN_1) @[Hello.scala 13:19 27:36]
    node _GEN_3 = mux(_T_12, UInt<6>("h27"), _GEN_2) @[Hello.scala 13:19 26:36]
    node _GEN_4 = mux(_T_11, UInt<2>("h3"), _GEN_3) @[Hello.scala 13:19 25:36]
    node _GEN_5 = mux(_T_10, UInt<4>("h8"), _GEN_4) @[Hello.scala 13:19 24:36]
    node _GEN_6 = mux(_T_9, UInt<5>("h10"), _GEN_5) @[Hello.scala 13:19 23:36]
    node _GEN_7 = mux(_T_8, UInt<1>("h0"), _GEN_6) @[Hello.scala 13:19 22:36]
    node _GEN_8 = mux(_T_7, UInt<7>("h78"), _GEN_7) @[Hello.scala 13:19 21:36]
    node _GEN_9 = mux(_T_6, UInt<2>("h2"), _GEN_8) @[Hello.scala 13:19 20:36]
    node _GEN_10 = mux(_T_5, UInt<5>("h12"), _GEN_9) @[Hello.scala 13:19 19:36]
    node _GEN_11 = mux(_T_4, UInt<5>("h19"), _GEN_10) @[Hello.scala 13:19 18:36]
    node _GEN_12 = mux(_T_3, UInt<6>("h30"), _GEN_11) @[Hello.scala 13:19 17:36]
    node _GEN_13 = mux(_T_2, UInt<6>("h24"), _GEN_12) @[Hello.scala 13:19 16:36]
    node _GEN_14 = mux(_T_1, UInt<7>("h79"), _GEN_13) @[Hello.scala 13:19 15:36]
    node _GEN_15 = mux(_T, UInt<7>("h40"), _GEN_14) @[Hello.scala 13:19 14:36]
    io_segOut <= _GEN_15
