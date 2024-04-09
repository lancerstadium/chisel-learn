circuit DoubleBufferFifo :
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

  module DoubleBuffer_1 :
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
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    inst DoubleBuffer of DoubleBuffer @[Hello.scala 98:15]
    DoubleBuffer.clock <= clock
    DoubleBuffer.reset <= reset
    inst DoubleBuffer_1 of DoubleBuffer_1 @[Hello.scala 98:15]
    DoubleBuffer_1.clock <= clock
    DoubleBuffer_1.reset <= reset
    DoubleBuffer_1.io.enq <= DoubleBuffer.io.deq @[Hello.scala 101:31]
    DoubleBuffer.io.enq <= io.enq @[Hello.scala 104:12]
    io.deq.bits <= DoubleBuffer_1.io.deq.bits @[Hello.scala 105:12]
    io.deq.valid <= DoubleBuffer_1.io.deq.valid @[Hello.scala 105:12]
    DoubleBuffer_1.io.deq.ready <= io.deq.ready @[Hello.scala 105:12]

