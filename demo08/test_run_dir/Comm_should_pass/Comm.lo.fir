circuit Comm :
  module Tx :
    input clock : Clock
    input reset : UInt<1>
    output io_txd : UInt<1>
    input io_channel_data : UInt<8>
    output io_channel_ready : UInt<1>
    input io_channel_valid : UInt<1>

    reg clkReg : UInt<16>, clock with :
      reset => (UInt<1>("h0"), clkReg) @[Hello.scala 16:25]
    node _clkReg_T = add(clkReg, UInt<1>("h1")) @[Hello.scala 17:22]
    node _clkReg_T_1 = tail(_clkReg_T, 1) @[Hello.scala 17:22]
    reg shiftReg : UInt<11>, clock with :
      reset => (UInt<1>("h0"), shiftReg) @[Hello.scala 21:27]
    reg cntReg : UInt<20>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[Hello.scala 22:25]
    reg bitsReg : UInt<4>, clock with :
      reset => (UInt<1>("h0"), bitsReg) @[Hello.scala 23:26]
    node _io_channel_ready_T = eq(cntReg, UInt<1>("h0")) @[Hello.scala 25:33]
    node _io_channel_ready_T_1 = eq(bitsReg, UInt<1>("h0")) @[Hello.scala 25:54]
    node _io_channel_ready_T_2 = and(_io_channel_ready_T, _io_channel_ready_T_1) @[Hello.scala 25:42]
    node _io_txd_T = bits(shiftReg, 0, 0) @[Hello.scala 26:23]
    node _T = eq(cntReg, UInt<1>("h0")) @[Hello.scala 28:17]
    node _T_1 = neq(bitsReg, UInt<1>("h0")) @[Hello.scala 30:22]
    node shift = shr(shiftReg, 1) @[Hello.scala 31:34]
    node _shiftReg_T = bits(shift, 9, 0) @[Hello.scala 32:39]
    node _shiftReg_T_1 = cat(UInt<1>("h1"), _shiftReg_T) @[Cat.scala 31:58]
    node _bitsReg_T = sub(bitsReg, UInt<1>("h1")) @[Hello.scala 33:32]
    node _bitsReg_T_1 = tail(_bitsReg_T, 1) @[Hello.scala 33:32]
    node _T_2 = bits(shiftReg, 1, 1) @[Hello.scala 34:59]
    node _T_3 = asUInt(reset) @[Hello.scala 34:19]
    node _T_4 = eq(_T_3, UInt<1>("h0")) @[Hello.scala 34:19]
    node _shiftReg_T_2 = cat(UInt<2>("h3"), io_channel_data) @[Cat.scala 31:58]
    node _shiftReg_T_3 = cat(_shiftReg_T_2, UInt<1>("h0")) @[Cat.scala 31:58]
    node _T_5 = asUInt(reset) @[Hello.scala 39:23]
    node _T_6 = eq(_T_5, UInt<1>("h0")) @[Hello.scala 39:23]
    node _GEN_0 = mux(io_channel_valid, _shiftReg_T_3, UInt<11>("h7ff")) @[Hello.scala 36:36 38:26 42:26]
    node _GEN_1 = mux(io_channel_valid, UInt<4>("hb"), bitsReg) @[Hello.scala 36:36 40:25 23:26]
    node _GEN_2 = mux(_T_1, _shiftReg_T_1, _GEN_0) @[Hello.scala 30:31 32:22]
    node _GEN_3 = mux(_T_1, _bitsReg_T_1, _GEN_1) @[Hello.scala 30:31 33:21]
    node _cntReg_T = sub(cntReg, UInt<1>("h1")) @[Hello.scala 46:26]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[Hello.scala 46:26]
    node _GEN_4 = mux(_T, UInt<5>("h18"), _cntReg_T_1) @[Hello.scala 28:26 29:16 46:16]
    node _GEN_5 = mux(_T, _GEN_2, shiftReg) @[Hello.scala 28:26 21:27]
    node _GEN_6 = mux(_T, _GEN_3, bitsReg) @[Hello.scala 23:26 28:26]
    io_txd <= _io_txd_T @[Hello.scala 26:12]
    io_channel_ready <= _io_channel_ready_T_2 @[Hello.scala 25:22]
    clkReg <= mux(reset, UInt<16>("h0"), _clkReg_T_1) @[Hello.scala 16:{25,25} 17:12]
    shiftReg <= mux(reset, UInt<11>("h7ff"), _GEN_5) @[Hello.scala 21:{27,27}]
    cntReg <= mux(reset, UInt<20>("h0"), _GEN_4) @[Hello.scala 22:{25,25}]
    bitsReg <= mux(reset, UInt<4>("h0"), _GEN_6) @[Hello.scala 23:{26,26}]
    printf(clock, and(and(and(and(UInt<1>("h1"), _T), _T_1), _T_4), UInt<1>("h1")), "%d: sending ...%b\n", clkReg, _T_2) : printf @[Hello.scala 34:19]
    printf(clock, and(and(and(and(and(UInt<1>("h1"), _T), eq(_T_1, UInt<1>("h0"))), io_channel_valid), _T_6), UInt<1>("h1")), "%d: sending start 0 ...%b\n", clkReg, UInt<1>("h0")) : printf_1 @[Hello.scala 39:23]

  module Buffer :
    input clock : Clock
    input reset : UInt<1>
    input io_in_data : UInt<8>
    output io_in_ready : UInt<1>
    input io_in_valid : UInt<1>
    output io_out_data : UInt<8>
    input io_out_ready : UInt<1>
    output io_out_valid : UInt<1>

    reg stateReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stateReg) @[Hello.scala 57:27]
    reg dataReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[Hello.scala 58:26]
    node _io_in_ready_T = eq(stateReg, UInt<1>("h0")) @[Hello.scala 60:29]
    node _io_out_valid_T = eq(stateReg, UInt<1>("h1")) @[Hello.scala 61:30]
    node _T = eq(stateReg, UInt<1>("h0")) @[Hello.scala 63:19]
    node _GEN_0 = mux(io_in_valid, io_in_data, dataReg) @[Hello.scala 64:27 65:21 58:26]
    node _GEN_1 = mux(io_in_valid, UInt<1>("h1"), stateReg) @[Hello.scala 64:27 66:22 57:27]
    node _GEN_2 = mux(io_out_ready, UInt<1>("h0"), stateReg) @[Hello.scala 69:28 70:22 57:27]
    node _GEN_3 = mux(_T, _GEN_0, dataReg) @[Hello.scala 58:26 63:30]
    node _GEN_4 = mux(_T, _GEN_1, _GEN_2) @[Hello.scala 63:30]
    io_in_ready <= _io_in_ready_T @[Hello.scala 60:17]
    io_out_data <= dataReg @[Hello.scala 74:17]
    io_out_valid <= _io_out_valid_T @[Hello.scala 61:18]
    stateReg <= mux(reset, UInt<1>("h0"), _GEN_4) @[Hello.scala 57:{27,27}]
    dataReg <= mux(reset, UInt<8>("h0"), _GEN_3) @[Hello.scala 58:{26,26}]

  module BufferedTx :
    input clock : Clock
    input reset : UInt<1>
    output io_txd : UInt<1>
    input io_channel_data : UInt<8>
    output io_channel_ready : UInt<1>
    input io_channel_valid : UInt<1>

    inst tx of Tx @[Hello.scala 83:20]
    inst buf of Buffer @[Hello.scala 84:21]
    io_txd <= tx.io_txd @[Hello.scala 88:12]
    io_channel_ready <= buf.io_in_ready @[Hello.scala 86:15]
    tx.clock <= clock
    tx.reset <= reset
    tx.io_channel_data <= buf.io_out_data @[Hello.scala 87:19]
    tx.io_channel_valid <= buf.io_out_valid @[Hello.scala 87:19]
    buf.clock <= clock
    buf.reset <= reset
    buf.io_in_data <= io_channel_data @[Hello.scala 86:15]
    buf.io_in_valid <= io_channel_valid @[Hello.scala 86:15]
    buf.io_out_ready <= tx.io_channel_ready @[Hello.scala 87:19]

  module Rx :
    input clock : Clock
    input reset : UInt<1>
    input io_rxd : UInt<1>
    output io_channel_data : UInt<8>
    input io_channel_ready : UInt<1>
    output io_channel_valid : UInt<1>

    reg clkReg : UInt<16>, clock with :
      reset => (UInt<1>("h0"), clkReg) @[Hello.scala 97:25]
    node _clkReg_T = add(clkReg, UInt<1>("h1")) @[Hello.scala 98:22]
    node _clkReg_T_1 = tail(_clkReg_T, 1) @[Hello.scala 98:22]
    reg rxReg_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxReg_REG) @[Hello.scala 106:32]
    reg rxReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxReg) @[Hello.scala 106:24]
    reg shiftReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), shiftReg) @[Hello.scala 108:27]
    reg cntReg : UInt<20>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[Hello.scala 109:25]
    reg bitsReg : UInt<4>, clock with :
      reset => (UInt<1>("h0"), bitsReg) @[Hello.scala 110:26]
    reg valReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), valReg) @[Hello.scala 111:25]
    node _T = neq(cntReg, UInt<1>("h0")) @[Hello.scala 113:17]
    node _cntReg_T = sub(cntReg, UInt<1>("h1")) @[Hello.scala 114:26]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[Hello.scala 114:26]
    node _T_1 = neq(bitsReg, UInt<1>("h0")) @[Hello.scala 115:24]
    node _shiftReg_T = shr(shiftReg, 1) @[Hello.scala 117:41]
    node _shiftReg_T_1 = cat(rxReg, _shiftReg_T) @[Cat.scala 31:58]
    node _bitsReg_T = sub(bitsReg, UInt<1>("h1")) @[Hello.scala 118:28]
    node _bitsReg_T_1 = tail(_bitsReg_T, 1) @[Hello.scala 118:28]
    node _T_2 = asUInt(reset) @[Hello.scala 119:15]
    node _T_3 = eq(_T_2, UInt<1>("h0")) @[Hello.scala 119:15]
    node _T_4 = eq(bitsReg, UInt<1>("h1")) @[Hello.scala 121:22]
    node _T_5 = shr(shiftReg, 1) @[Hello.scala 123:64]
    node _T_6 = cat(rxReg, _T_5) @[Cat.scala 31:58]
    node _T_7 = asUInt(reset) @[Hello.scala 123:19]
    node _T_8 = eq(_T_7, UInt<1>("h0")) @[Hello.scala 123:19]
    node _GEN_0 = mux(_T_4, UInt<1>("h1"), valReg) @[Hello.scala 121:31 122:20 111:25]
    node _T_9 = eq(rxReg, UInt<1>("h0")) @[Hello.scala 125:22]
    node _T_10 = asUInt(reset) @[Hello.scala 128:15]
    node _T_11 = eq(_T_10, UInt<1>("h0")) @[Hello.scala 128:15]
    node _GEN_1 = mux(_T_9, UInt<6>("h25"), cntReg) @[Hello.scala 125:31 126:16 109:25]
    node _GEN_2 = mux(_T_9, UInt<4>("h8"), bitsReg) @[Hello.scala 125:31 127:17 110:26]
    node _GEN_3 = mux(_T_1, UInt<5>("h18"), _GEN_1) @[Hello.scala 115:33 116:16]
    node _GEN_4 = mux(_T_1, _shiftReg_T_1, shiftReg) @[Hello.scala 115:33 117:18 108:27]
    node _GEN_5 = mux(_T_1, _bitsReg_T_1, _GEN_2) @[Hello.scala 115:33 118:17]
    node _GEN_6 = mux(_T_1, _GEN_0, valReg) @[Hello.scala 111:25 115:33]
    node _GEN_7 = mux(_T, _cntReg_T_1, _GEN_3) @[Hello.scala 113:26 114:16]
    node _GEN_8 = mux(_T, shiftReg, _GEN_4) @[Hello.scala 113:26 108:27]
    node _GEN_9 = mux(_T, bitsReg, _GEN_5) @[Hello.scala 110:26 113:26]
    node _GEN_10 = mux(_T, valReg, _GEN_6) @[Hello.scala 111:25 113:26]
    node _T_12 = and(valReg, io_channel_ready) @[Hello.scala 131:17]
    node _GEN_11 = mux(_T_12, UInt<1>("h0"), _GEN_10) @[Hello.scala 131:38 132:16]
    io_channel_data <= shiftReg @[Hello.scala 135:21]
    io_channel_valid <= valReg @[Hello.scala 136:22]
    clkReg <= mux(reset, UInt<16>("h0"), _clkReg_T_1) @[Hello.scala 97:{25,25} 98:12]
    rxReg_REG <= mux(reset, UInt<1>("h1"), io_rxd) @[Hello.scala 106:{32,32,32}]
    rxReg <= mux(reset, UInt<1>("h1"), rxReg_REG) @[Hello.scala 106:{24,24,24}]
    shiftReg <= mux(reset, UInt<8>("h41"), _GEN_8) @[Hello.scala 108:{27,27}]
    cntReg <= mux(reset, UInt<20>("h0"), _GEN_7) @[Hello.scala 109:{25,25}]
    bitsReg <= mux(reset, UInt<4>("h0"), _GEN_9) @[Hello.scala 110:{26,26}]
    valReg <= mux(reset, UInt<1>("h0"), _GEN_11) @[Hello.scala 111:{25,25}]
    printf(clock, and(and(and(and(UInt<1>("h1"), eq(_T, UInt<1>("h0"))), _T_1), _T_3), UInt<1>("h1")), "%d: reading ...%b\n", clkReg, rxReg) : printf @[Hello.scala 119:15]
    printf(clock, and(and(and(and(and(UInt<1>("h1"), eq(_T, UInt<1>("h0"))), _T_1), _T_4), _T_8), UInt<1>("h1")), "Done reading ...%c\n", _T_6) : printf_1 @[Hello.scala 123:19]
    printf(clock, and(and(and(and(and(UInt<1>("h1"), eq(_T, UInt<1>("h0"))), eq(_T_1, UInt<1>("h0"))), _T_9), _T_11), UInt<1>("h1")), "%d: reading start 0 ...%b\n", clkReg, rxReg) : printf_2 @[Hello.scala 128:15]

  module Comm :
    input clock : Clock
    input reset : UInt<1>

    inst tx of BufferedTx @[Hello.scala 140:20]
    inst rx of Rx @[Hello.scala 141:20]
    reg cntReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[Hello.scala 147:25]
    node _tx_io_channel_data_T = bits(cntReg, 3, 0)
    node text_0 = UInt<7>("h48") @[Hello.scala 144:{23,23}]
    node _GEN_0 = validif(eq(UInt<1>("h0"), _tx_io_channel_data_T), text_0) @[Hello.scala 149:{24,24}]
    node text_1 = UInt<7>("h65") @[Hello.scala 144:{23,23}]
    node _GEN_1 = mux(eq(UInt<1>("h1"), _tx_io_channel_data_T), text_1, _GEN_0) @[Hello.scala 149:{24,24}]
    node text_2 = UInt<7>("h6c") @[Hello.scala 144:{23,23}]
    node _GEN_2 = mux(eq(UInt<2>("h2"), _tx_io_channel_data_T), text_2, _GEN_1) @[Hello.scala 149:{24,24}]
    node text_3 = UInt<7>("h6c") @[Hello.scala 144:{23,23}]
    node _GEN_3 = mux(eq(UInt<2>("h3"), _tx_io_channel_data_T), text_3, _GEN_2) @[Hello.scala 149:{24,24}]
    node text_4 = UInt<7>("h6f") @[Hello.scala 144:{23,23}]
    node _GEN_4 = mux(eq(UInt<3>("h4"), _tx_io_channel_data_T), text_4, _GEN_3) @[Hello.scala 149:{24,24}]
    node text_5 = UInt<7>("h20") @[Hello.scala 144:{23,23}]
    node _GEN_5 = mux(eq(UInt<3>("h5"), _tx_io_channel_data_T), text_5, _GEN_4) @[Hello.scala 149:{24,24}]
    node text_6 = UInt<7>("h57") @[Hello.scala 144:{23,23}]
    node _GEN_6 = mux(eq(UInt<3>("h6"), _tx_io_channel_data_T), text_6, _GEN_5) @[Hello.scala 149:{24,24}]
    node text_7 = UInt<7>("h6f") @[Hello.scala 144:{23,23}]
    node _GEN_7 = mux(eq(UInt<3>("h7"), _tx_io_channel_data_T), text_7, _GEN_6) @[Hello.scala 149:{24,24}]
    node text_8 = UInt<7>("h72") @[Hello.scala 144:{23,23}]
    node _GEN_8 = mux(eq(UInt<4>("h8"), _tx_io_channel_data_T), text_8, _GEN_7) @[Hello.scala 149:{24,24}]
    node text_9 = UInt<7>("h6c") @[Hello.scala 144:{23,23}]
    node _GEN_9 = mux(eq(UInt<4>("h9"), _tx_io_channel_data_T), text_9, _GEN_8) @[Hello.scala 149:{24,24}]
    node text_10 = UInt<7>("h64") @[Hello.scala 144:{23,23}]
    node _GEN_10 = mux(eq(UInt<4>("ha"), _tx_io_channel_data_T), text_10, _GEN_9) @[Hello.scala 149:{24,24}]
    node text_11 = UInt<7>("h21") @[Hello.scala 144:{23,23}]
    node _GEN_11 = mux(eq(UInt<4>("hb"), _tx_io_channel_data_T), text_11, _GEN_10) @[Hello.scala 149:{24,24}]
    node _tx_io_channel_valid_T = neq(cntReg, UInt<4>("hc")) @[Hello.scala 150:35]
    node _T = neq(cntReg, UInt<4>("hc")) @[Hello.scala 154:40]
    node _T_1 = and(tx.io_channel_ready, _T) @[Hello.scala 154:30]
    node _cntReg_T = add(cntReg, UInt<1>("h1")) @[Hello.scala 155:26]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[Hello.scala 155:26]
    node _GEN_12 = mux(_T_1, _cntReg_T_1, cntReg) @[Hello.scala 154:49 155:16 147:25]
    node _text_tx_io_channel_data_T = _GEN_11 @[Hello.scala 149:24]
    tx.clock <= clock
    tx.reset <= reset
    tx.io_channel_data <= pad(_text_tx_io_channel_data_T, 8) @[Hello.scala 149:24]
    tx.io_channel_valid <= _tx_io_channel_valid_T @[Hello.scala 150:25]
    rx.clock <= clock
    rx.reset <= reset
    rx.io_rxd <= tx.io_txd @[Hello.scala 152:15]
    rx.io_channel_ready <= tx.io_channel_ready @[Hello.scala 151:25]
    cntReg <= mux(reset, UInt<8>("h0"), _GEN_12) @[Hello.scala 147:{25,25}]
