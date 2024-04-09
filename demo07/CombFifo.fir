circuit CombFifo :
  module MemFifo :
    input clock : Clock
    input reset : Reset
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

  module DoubleBuffer :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[Hello.scala 60:31]
    reg dataReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[Hello.scala 61:26]
    reg shadowReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), shadowReg) @[Hello.scala 62:28]
    node _T = eq(UInt<2>("h0"), stateReg) @[Hello.scala 64:27]
    when _T : @[Hello.scala 64:27]
      when io.enq.valid : @[Hello.scala 66:36]
        stateReg <= UInt<2>("h1") @[Hello.scala 67:30]
        dataReg <= io.enq.bits @[Hello.scala 68:29]
    else :
      node _T_1 = eq(UInt<2>("h1"), stateReg) @[Hello.scala 64:27]
      when _T_1 : @[Hello.scala 64:27]
        node _T_2 = eq(io.enq.valid, UInt<1>("h0")) @[Hello.scala 72:38]
        node _T_3 = and(io.deq.ready, _T_2) @[Hello.scala 72:35]
        when _T_3 : @[Hello.scala 72:53]
          stateReg <= UInt<2>("h0") @[Hello.scala 73:30]
        node _T_4 = and(io.deq.ready, io.enq.valid) @[Hello.scala 75:35]
        when _T_4 : @[Hello.scala 75:52]
          stateReg <= UInt<2>("h1") @[Hello.scala 76:30]
          dataReg <= io.enq.bits @[Hello.scala 77:29]
        node _T_5 = eq(io.deq.ready, UInt<1>("h0")) @[Hello.scala 79:22]
        node _T_6 = and(_T_5, io.enq.valid) @[Hello.scala 79:36]
        when _T_6 : @[Hello.scala 79:53]
          stateReg <= UInt<2>("h2") @[Hello.scala 80:30]
          shadowReg <= io.enq.bits @[Hello.scala 81:31]
      else :
        node _T_7 = eq(UInt<2>("h2"), stateReg) @[Hello.scala 64:27]
        when _T_7 : @[Hello.scala 64:27]
          node _T_8 = eq(io.enq.valid, UInt<1>("h0")) @[Hello.scala 85:38]
          node _T_9 = and(io.deq.ready, _T_8) @[Hello.scala 85:35]
          when _T_9 : @[Hello.scala 85:53]
            stateReg <= UInt<2>("h1") @[Hello.scala 86:30]
            dataReg <= shadowReg @[Hello.scala 87:29]
    node _io_enq_ready_T = eq(stateReg, UInt<2>("h0")) @[Hello.scala 92:35]
    node _io_enq_ready_T_1 = eq(stateReg, UInt<2>("h1")) @[Hello.scala 92:57]
    node _io_enq_ready_T_2 = or(_io_enq_ready_T, _io_enq_ready_T_1) @[Hello.scala 92:45]
    io.enq.ready <= _io_enq_ready_T_2 @[Hello.scala 92:22]
    node _io_deq_valid_T = eq(stateReg, UInt<2>("h1")) @[Hello.scala 93:35]
    node _io_deq_valid_T_1 = eq(stateReg, UInt<2>("h2")) @[Hello.scala 93:55]
    node _io_deq_valid_T_2 = or(_io_deq_valid_T, _io_deq_valid_T_1) @[Hello.scala 93:43]
    io.deq.valid <= _io_deq_valid_T_2 @[Hello.scala 93:22]
    io.deq.bits <= dataReg @[Hello.scala 94:21]

  module DoubleBufferFifo :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    inst DoubleBuffer of DoubleBuffer @[Hello.scala 98:15]
    DoubleBuffer.clock <= clock
    DoubleBuffer.reset <= reset
    DoubleBuffer.io.enq <= io.enq @[Hello.scala 104:12]
    io.deq.bits <= DoubleBuffer.io.deq.bits @[Hello.scala 105:12]
    io.deq.valid <= DoubleBuffer.io.deq.valid @[Hello.scala 105:12]
    DoubleBuffer.io.deq.ready <= io.deq.ready @[Hello.scala 105:12]

  module CombFifo :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    inst memFifo of MemFifo @[Hello.scala 232:25]
    memFifo.clock <= clock
    memFifo.reset <= reset
    inst bufferFIFO of DoubleBufferFifo @[Hello.scala 233:28]
    bufferFIFO.clock <= clock
    bufferFIFO.reset <= reset
    memFifo.io.enq <= io.enq @[Hello.scala 235:12]
    io.deq.bits <= bufferFIFO.io.deq.bits @[Hello.scala 236:12]
    io.deq.valid <= bufferFIFO.io.deq.valid @[Hello.scala 236:12]
    bufferFIFO.io.deq.ready <= io.deq.ready @[Hello.scala 236:12]
    bufferFIFO.io.enq <= memFifo.io.deq @[Hello.scala 237:20]

