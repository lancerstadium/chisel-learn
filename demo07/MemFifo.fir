circuit MemFifo :
  module MemFifo :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    smem mem : UInt<8> [3] @[Hello.scala 162:26]
    wire incrRead : UInt<1>
    incrRead <= UInt<1>("h0")
    wire incrWrite : UInt<1>
    incrWrite <= UInt<1>("h0")
    reg readPtr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Hello.scala 154:29]
    node _nextVal_T = eq(readPtr, UInt<2>("h2")) @[Hello.scala 155:34]
    node _nextVal_T_1 = add(readPtr, UInt<1>("h1")) @[Hello.scala 155:63]
    node _nextVal_T_2 = tail(_nextVal_T_1, 1) @[Hello.scala 155:63]
    node nextRead = mux(_nextVal_T, UInt<1>("h0"), _nextVal_T_2) @[Hello.scala 155:26]
    when incrRead : @[Hello.scala 156:20]
      readPtr <= nextRead @[Hello.scala 157:20]
    reg writePtr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Hello.scala 154:29]
    node _nextVal_T_3 = eq(writePtr, UInt<2>("h2")) @[Hello.scala 155:34]
    node _nextVal_T_4 = add(writePtr, UInt<1>("h1")) @[Hello.scala 155:63]
    node _nextVal_T_5 = tail(_nextVal_T_4, 1) @[Hello.scala 155:63]
    node nextWrite = mux(_nextVal_T_3, UInt<1>("h0"), _nextVal_T_5) @[Hello.scala 155:26]
    when incrWrite : @[Hello.scala 156:20]
      writePtr <= nextWrite @[Hello.scala 157:20]
    reg emptyReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[Hello.scala 169:27]
    reg fullReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Hello.scala 170:26]
    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Hello.scala 174:27]
    reg shadowReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), shadowReg) @[Hello.scala 175:24]
    node _T = eq(fullReg, UInt<1>("h0")) @[Hello.scala 178:26]
    node _T_1 = and(io.enq.valid, _T) @[Hello.scala 178:23]
    when _T_1 : @[Hello.scala 178:36]
      write mport MPORT = mem[writePtr], clock
      MPORT <= io.enq.bits
      emptyReg <= UInt<1>("h0") @[Hello.scala 180:18]
      node _fullReg_T = eq(nextWrite, readPtr) @[Hello.scala 181:30]
      fullReg <= _fullReg_T @[Hello.scala 181:17]
      incrWrite <= UInt<1>("h1") @[Hello.scala 182:19]
    wire _data_WIRE : UInt @[Hello.scala 185:24]
    _data_WIRE is invalid @[Hello.scala 185:24]
    when UInt<1>("h1") : @[Hello.scala 185:24]
      _data_WIRE <= readPtr @[Hello.scala 185:24]
      node _data_T = or(_data_WIRE, UInt<2>("h0")) @[Hello.scala 185:24]
      node _data_T_1 = bits(_data_T, 1, 0) @[Hello.scala 185:24]
      read mport data = mem[_data_T_1], clock @[Hello.scala 185:24]
    node _T_2 = eq(UInt<2>("h0"), stateReg) @[Hello.scala 187:22]
    when _T_2 : @[Hello.scala 187:22]
      node _T_3 = eq(emptyReg, UInt<1>("h0")) @[Hello.scala 189:18]
      when _T_3 : @[Hello.scala 189:29]
        stateReg <= UInt<2>("h1") @[Hello.scala 190:26]
        fullReg <= UInt<1>("h0") @[Hello.scala 191:25]
        node _emptyReg_T = eq(nextRead, writePtr) @[Hello.scala 192:38]
        emptyReg <= _emptyReg_T @[Hello.scala 192:26]
        incrRead <= UInt<1>("h1") @[Hello.scala 193:26]
    else :
      node _T_4 = eq(UInt<2>("h1"), stateReg) @[Hello.scala 187:22]
      when _T_4 : @[Hello.scala 187:22]
        when io.deq.ready : @[Hello.scala 197:32]
          node _T_5 = eq(emptyReg, UInt<1>("h0")) @[Hello.scala 198:22]
          when _T_5 : @[Hello.scala 198:33]
            stateReg <= UInt<2>("h1") @[Hello.scala 199:30]
            fullReg <= UInt<1>("h0") @[Hello.scala 200:29]
            node _emptyReg_T_1 = eq(nextRead, writePtr) @[Hello.scala 201:42]
            emptyReg <= _emptyReg_T_1 @[Hello.scala 201:30]
            incrRead <= UInt<1>("h1") @[Hello.scala 202:30]
          else :
            stateReg <= UInt<2>("h0") @[Hello.scala 204:30]
        else :
          shadowReg <= data @[Hello.scala 207:27]
          stateReg <= UInt<2>("h2") @[Hello.scala 208:26]
      else :
        node _T_6 = eq(UInt<2>("h2"), stateReg) @[Hello.scala 187:22]
        when _T_6 : @[Hello.scala 187:22]
          when io.deq.ready : @[Hello.scala 212:32]
            node _T_7 = eq(emptyReg, UInt<1>("h0")) @[Hello.scala 213:22]
            when _T_7 : @[Hello.scala 213:33]
              stateReg <= UInt<2>("h1") @[Hello.scala 214:30]
              fullReg <= UInt<1>("h0") @[Hello.scala 215:29]
              node _emptyReg_T_2 = eq(nextRead, writePtr) @[Hello.scala 216:42]
              emptyReg <= _emptyReg_T_2 @[Hello.scala 216:30]
              incrRead <= UInt<1>("h1") @[Hello.scala 217:30]
            else :
              stateReg <= UInt<2>("h0") @[Hello.scala 219:30]
    node _io_deq_bits_T = eq(stateReg, UInt<2>("h1")) @[Hello.scala 225:33]
    node _io_deq_bits_T_1 = mux(_io_deq_bits_T, data, shadowReg) @[Hello.scala 225:23]
    io.deq.bits <= _io_deq_bits_T_1 @[Hello.scala 225:17]
    node _io_enq_ready_T = eq(fullReg, UInt<1>("h0")) @[Hello.scala 226:21]
    io.enq.ready <= _io_enq_ready_T @[Hello.scala 226:18]
    node _io_deq_valid_T = eq(stateReg, UInt<2>("h1")) @[Hello.scala 227:30]
    node _io_deq_valid_T_1 = eq(stateReg, UInt<2>("h2")) @[Hello.scala 227:52]
    node _io_deq_valid_T_2 = or(_io_deq_valid_T, _io_deq_valid_T_1) @[Hello.scala 227:40]
    io.deq.valid <= _io_deq_valid_T_2 @[Hello.scala 227:18]

