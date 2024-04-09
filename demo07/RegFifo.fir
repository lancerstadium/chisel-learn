circuit RegFifo :
  module RegFifo :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg memReg : UInt<8>[3], clock with :
      reset => (UInt<1>("h0"), memReg) @[Hello.scala 120:21]
    wire incrRead : UInt<1>
    incrRead <= UInt<1>("h0")
    wire incrWrite : UInt<1>
    incrWrite <= UInt<1>("h0")
    reg readPtr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Hello.scala 112:29]
    node _nextVal_T = eq(readPtr, UInt<2>("h2")) @[Hello.scala 113:34]
    node _nextVal_T_1 = add(readPtr, UInt<1>("h1")) @[Hello.scala 113:63]
    node _nextVal_T_2 = tail(_nextVal_T_1, 1) @[Hello.scala 113:63]
    node nextRead = mux(_nextVal_T, UInt<1>("h0"), _nextVal_T_2) @[Hello.scala 113:26]
    when incrRead : @[Hello.scala 114:20]
      readPtr <= nextRead @[Hello.scala 115:20]
    reg writePtr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Hello.scala 112:29]
    node _nextVal_T_3 = eq(writePtr, UInt<2>("h2")) @[Hello.scala 113:34]
    node _nextVal_T_4 = add(writePtr, UInt<1>("h1")) @[Hello.scala 113:63]
    node _nextVal_T_5 = tail(_nextVal_T_4, 1) @[Hello.scala 113:63]
    node nextWrite = mux(_nextVal_T_3, UInt<1>("h0"), _nextVal_T_5) @[Hello.scala 113:26]
    when incrWrite : @[Hello.scala 114:20]
      writePtr <= nextWrite @[Hello.scala 115:20]
    reg emptyReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[Hello.scala 127:27]
    reg fullReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Hello.scala 128:26]
    node _T = eq(fullReg, UInt<1>("h0")) @[Hello.scala 131:26]
    node _T_1 = and(io.enq.valid, _T) @[Hello.scala 131:23]
    when _T_1 : @[Hello.scala 131:36]
      memReg[writePtr] <= io.enq.bits @[Hello.scala 132:26]
      emptyReg <= UInt<1>("h0") @[Hello.scala 133:18]
      node _fullReg_T = eq(nextWrite, readPtr) @[Hello.scala 134:30]
      fullReg <= _fullReg_T @[Hello.scala 134:17]
      incrWrite <= UInt<1>("h1") @[Hello.scala 135:19]
    node _T_2 = eq(emptyReg, UInt<1>("h0")) @[Hello.scala 139:26]
    node _T_3 = and(io.deq.ready, _T_2) @[Hello.scala 139:23]
    when _T_3 : @[Hello.scala 139:37]
      fullReg <= UInt<1>("h0") @[Hello.scala 140:17]
      node _emptyReg_T = eq(nextRead, writePtr) @[Hello.scala 141:30]
      emptyReg <= _emptyReg_T @[Hello.scala 141:18]
      incrRead <= UInt<1>("h1") @[Hello.scala 142:18]
    io.deq.bits <= memReg[readPtr] @[Hello.scala 145:17]
    node _io_enq_ready_T = eq(fullReg, UInt<1>("h0")) @[Hello.scala 146:21]
    io.enq.ready <= _io_enq_ready_T @[Hello.scala 146:18]
    node _io_deq_valid_T = eq(emptyReg, UInt<1>("h0")) @[Hello.scala 147:21]
    io.deq.valid <= _io_deq_valid_T @[Hello.scala 147:18]

