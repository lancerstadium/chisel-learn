circuit UpTicker :
  module UpTicker :
    input clock : Clock
    input reset : UInt<1>
    output io_tick : UInt<1>

    reg cntReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[Hello.scala 18:25]
    node _cntReg_T = add(cntReg, UInt<1>("h1")) @[Hello.scala 20:22]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[Hello.scala 20:22]
    node _T = eq(cntReg, UInt<3>("h4")) @[Hello.scala 22:18]
    node _GEN_0 = mux(_T, UInt<1>("h0"), _cntReg_T_1) @[Hello.scala 20:12 22:25 23:16]
    node _io_tick_T = eq(cntReg, UInt<3>("h4")) @[Hello.scala 26:23]
    io_tick <= _io_tick_T @[Hello.scala 26:13]
    cntReg <= mux(reset, UInt<8>("h0"), _GEN_0) @[Hello.scala 18:{25,25}]
