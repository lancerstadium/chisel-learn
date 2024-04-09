circuit NerdTicker :
  module NerdTicker :
    input clock : Clock
    input reset : UInt<1>
    output io_tick : UInt<1>

    reg cntReg : SInt<8>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[Hello.scala 46:25]
    node _cntReg_T = sub(cntReg, asSInt(UInt<2>("h1"))) @[Hello.scala 50:22]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[Hello.scala 50:22]
    node _cntReg_T_2 = asSInt(_cntReg_T_1) @[Hello.scala 50:22]
    node _T = bits(cntReg, 7, 7) @[Hello.scala 51:16]
    node _GEN_0 = mux(_T, asSInt(UInt<8>("h9")), _cntReg_T_2) @[Hello.scala 50:12 51:21 52:16]
    node _GEN_1 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[Hello.scala 48:13 51:21 53:17]
    io_tick <= _GEN_1
    cntReg <= mux(reset, asSInt(UInt<8>("h9")), _GEN_0) @[Hello.scala 46:{25,25}]
