circuit BubbleFifo :
  module Buffer :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg fullReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Hello.scala 23:30]
    reg dataReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[Hello.scala 24:26]
    when fullReg : @[Hello.scala 26:24]
      when io.deq.ready : @[Hello.scala 27:33]
        fullReg <= UInt<1>("h0") @[Hello.scala 28:25]
    else :
      when io.enq.valid : @[Hello.scala 31:33]
        fullReg <= UInt<1>("h1") @[Hello.scala 32:25]
        dataReg <= io.enq.bits @[Hello.scala 33:25]
    node _io_enq_ready_T = eq(fullReg, UInt<1>("h0")) @[Hello.scala 37:25]
    io.enq.ready <= _io_enq_ready_T @[Hello.scala 37:22]
    io.deq.valid <= fullReg @[Hello.scala 38:22]
    io.deq.bits <= dataReg @[Hello.scala 39:21]

  module Buffer_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg fullReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Hello.scala 23:30]
    reg dataReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[Hello.scala 24:26]
    when fullReg : @[Hello.scala 26:24]
      when io.deq.ready : @[Hello.scala 27:33]
        fullReg <= UInt<1>("h0") @[Hello.scala 28:25]
    else :
      when io.enq.valid : @[Hello.scala 31:33]
        fullReg <= UInt<1>("h1") @[Hello.scala 32:25]
        dataReg <= io.enq.bits @[Hello.scala 33:25]
    node _io_enq_ready_T = eq(fullReg, UInt<1>("h0")) @[Hello.scala 37:25]
    io.enq.ready <= _io_enq_ready_T @[Hello.scala 37:22]
    io.deq.valid <= fullReg @[Hello.scala 38:22]
    io.deq.bits <= dataReg @[Hello.scala 39:21]

  module Buffer_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    reg fullReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Hello.scala 23:30]
    reg dataReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), dataReg) @[Hello.scala 24:26]
    when fullReg : @[Hello.scala 26:24]
      when io.deq.ready : @[Hello.scala 27:33]
        fullReg <= UInt<1>("h0") @[Hello.scala 28:25]
    else :
      when io.enq.valid : @[Hello.scala 31:33]
        fullReg <= UInt<1>("h1") @[Hello.scala 32:25]
        dataReg <= io.enq.bits @[Hello.scala 33:25]
    node _io_enq_ready_T = eq(fullReg, UInt<1>("h0")) @[Hello.scala 37:25]
    io.enq.ready <= _io_enq_ready_T @[Hello.scala 37:22]
    io.deq.valid <= fullReg @[Hello.scala 38:22]
    io.deq.bits <= dataReg @[Hello.scala 39:21]

  module BubbleFifo :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip enq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}, deq : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<8>}}

    inst Buffer of Buffer @[Hello.scala 44:15]
    Buffer.clock <= clock
    Buffer.reset <= reset
    inst Buffer_1 of Buffer_1 @[Hello.scala 44:15]
    Buffer_1.clock <= clock
    Buffer_1.reset <= reset
    inst Buffer_2 of Buffer_2 @[Hello.scala 44:15]
    Buffer_2.clock <= clock
    Buffer_2.reset <= reset
    Buffer_1.io.enq <= Buffer.io.deq @[Hello.scala 47:31]
    Buffer_2.io.enq <= Buffer_1.io.deq @[Hello.scala 47:31]
    Buffer.io.enq <= io.enq @[Hello.scala 50:12]
    io.deq.bits <= Buffer_2.io.deq.bits @[Hello.scala 51:12]
    io.deq.valid <= Buffer_2.io.deq.valid @[Hello.scala 51:12]
    Buffer_2.io.deq.ready <= io.deq.ready @[Hello.scala 51:12]

