circuit DownTicker :
  module DownTicker :
    input clock : Clock
    input reset : UInt<1>
    output io_tick : UInt<1>

    reg cntReg : UInt<3>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[Hello.scala 32:25]
    node _cntReg_T = sub(cntReg, UInt<1>("h1")) @[Hello.scala 34:22]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[Hello.scala 34:22]
    node _T = eq(cntReg, UInt<1>("h0")) @[Hello.scala 36:17]
    node _GEN_0 = mux(_T, UInt<3>("h6"), _cntReg_T_1) @[Hello.scala 34:12 36:26 37:16]
    node _io_tick_T = eq(cntReg, UInt<3>("h6")) @[Hello.scala 40:23]
    io_tick <= _io_tick_T @[Hello.scala 40:13]
    cntReg <= mux(reset, UInt<3>("h6"), _GEN_0) @[Hello.scala 32:{25,25}]
