circuit BubbleFIFO :
  module SingleFIFO :
    input clock : Clock
    input reset : Reset
    output io : { write : { flip write : UInt<1>, full : UInt<1>, flip din : UInt<8>}, read : { flip read : UInt<1>, empty : UInt<1>, dout : UInt<8>}}

    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Hello.scala 30:27]
    reg dataReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Hello.scala 31:26]
    node _T = eq(stateReg, UInt<1>("h0")) @[Hello.scala 33:19]
    when _T : @[Hello.scala 33:30]
      when io.write.write : @[Hello.scala 34:30]
        stateReg <= UInt<1>("h1") @[Hello.scala 35:22]
        dataReg <= io.write.din @[Hello.scala 36:21]
    else :
      node _T_1 = eq(stateReg, UInt<1>("h1")) @[Hello.scala 38:25]
      when _T_1 : @[Hello.scala 38:35]
        when io.read.read : @[Hello.scala 39:28]
          stateReg <= UInt<1>("h0") @[Hello.scala 40:22]
          dataReg <= UInt<1>("h0") @[Hello.scala 41:21]
      else :
        skip
    node _io_write_full_T = eq(stateReg, UInt<1>("h1")) @[Hello.scala 46:32]
    io.write.full <= _io_write_full_T @[Hello.scala 46:19]
    node _io_read_empty_T = eq(stateReg, UInt<1>("h0")) @[Hello.scala 47:32]
    io.read.empty <= _io_read_empty_T @[Hello.scala 47:19]
    io.read.dout <= dataReg @[Hello.scala 48:18]

  module SingleFIFO_1 :
    input clock : Clock
    input reset : Reset
    output io : { write : { flip write : UInt<1>, full : UInt<1>, flip din : UInt<8>}, read : { flip read : UInt<1>, empty : UInt<1>, dout : UInt<8>}}

    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Hello.scala 30:27]
    reg dataReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Hello.scala 31:26]
    node _T = eq(stateReg, UInt<1>("h0")) @[Hello.scala 33:19]
    when _T : @[Hello.scala 33:30]
      when io.write.write : @[Hello.scala 34:30]
        stateReg <= UInt<1>("h1") @[Hello.scala 35:22]
        dataReg <= io.write.din @[Hello.scala 36:21]
    else :
      node _T_1 = eq(stateReg, UInt<1>("h1")) @[Hello.scala 38:25]
      when _T_1 : @[Hello.scala 38:35]
        when io.read.read : @[Hello.scala 39:28]
          stateReg <= UInt<1>("h0") @[Hello.scala 40:22]
          dataReg <= UInt<1>("h0") @[Hello.scala 41:21]
      else :
        skip
    node _io_write_full_T = eq(stateReg, UInt<1>("h1")) @[Hello.scala 46:32]
    io.write.full <= _io_write_full_T @[Hello.scala 46:19]
    node _io_read_empty_T = eq(stateReg, UInt<1>("h0")) @[Hello.scala 47:32]
    io.read.empty <= _io_read_empty_T @[Hello.scala 47:19]
    io.read.dout <= dataReg @[Hello.scala 48:18]

  module SingleFIFO_2 :
    input clock : Clock
    input reset : Reset
    output io : { write : { flip write : UInt<1>, full : UInt<1>, flip din : UInt<8>}, read : { flip read : UInt<1>, empty : UInt<1>, dout : UInt<8>}}

    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Hello.scala 30:27]
    reg dataReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Hello.scala 31:26]
    node _T = eq(stateReg, UInt<1>("h0")) @[Hello.scala 33:19]
    when _T : @[Hello.scala 33:30]
      when io.write.write : @[Hello.scala 34:30]
        stateReg <= UInt<1>("h1") @[Hello.scala 35:22]
        dataReg <= io.write.din @[Hello.scala 36:21]
    else :
      node _T_1 = eq(stateReg, UInt<1>("h1")) @[Hello.scala 38:25]
      when _T_1 : @[Hello.scala 38:35]
        when io.read.read : @[Hello.scala 39:28]
          stateReg <= UInt<1>("h0") @[Hello.scala 40:22]
          dataReg <= UInt<1>("h0") @[Hello.scala 41:21]
      else :
        skip
    node _io_write_full_T = eq(stateReg, UInt<1>("h1")) @[Hello.scala 46:32]
    io.write.full <= _io_write_full_T @[Hello.scala 46:19]
    node _io_read_empty_T = eq(stateReg, UInt<1>("h0")) @[Hello.scala 47:32]
    io.read.empty <= _io_read_empty_T @[Hello.scala 47:19]
    io.read.dout <= dataReg @[Hello.scala 48:18]

  module SingleFIFO_3 :
    input clock : Clock
    input reset : Reset
    output io : { write : { flip write : UInt<1>, full : UInt<1>, flip din : UInt<8>}, read : { flip read : UInt<1>, empty : UInt<1>, dout : UInt<8>}}

    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Hello.scala 30:27]
    reg dataReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Hello.scala 31:26]
    node _T = eq(stateReg, UInt<1>("h0")) @[Hello.scala 33:19]
    when _T : @[Hello.scala 33:30]
      when io.write.write : @[Hello.scala 34:30]
        stateReg <= UInt<1>("h1") @[Hello.scala 35:22]
        dataReg <= io.write.din @[Hello.scala 36:21]
    else :
      node _T_1 = eq(stateReg, UInt<1>("h1")) @[Hello.scala 38:25]
      when _T_1 : @[Hello.scala 38:35]
        when io.read.read : @[Hello.scala 39:28]
          stateReg <= UInt<1>("h0") @[Hello.scala 40:22]
          dataReg <= UInt<1>("h0") @[Hello.scala 41:21]
      else :
        skip
    node _io_write_full_T = eq(stateReg, UInt<1>("h1")) @[Hello.scala 46:32]
    io.write.full <= _io_write_full_T @[Hello.scala 46:19]
    node _io_read_empty_T = eq(stateReg, UInt<1>("h0")) @[Hello.scala 47:32]
    io.read.empty <= _io_read_empty_T @[Hello.scala 47:19]
    io.read.dout <= dataReg @[Hello.scala 48:18]

  module SingleFIFO_4 :
    input clock : Clock
    input reset : Reset
    output io : { write : { flip write : UInt<1>, full : UInt<1>, flip din : UInt<8>}, read : { flip read : UInt<1>, empty : UInt<1>, dout : UInt<8>}}

    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Hello.scala 30:27]
    reg dataReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Hello.scala 31:26]
    node _T = eq(stateReg, UInt<1>("h0")) @[Hello.scala 33:19]
    when _T : @[Hello.scala 33:30]
      when io.write.write : @[Hello.scala 34:30]
        stateReg <= UInt<1>("h1") @[Hello.scala 35:22]
        dataReg <= io.write.din @[Hello.scala 36:21]
    else :
      node _T_1 = eq(stateReg, UInt<1>("h1")) @[Hello.scala 38:25]
      when _T_1 : @[Hello.scala 38:35]
        when io.read.read : @[Hello.scala 39:28]
          stateReg <= UInt<1>("h0") @[Hello.scala 40:22]
          dataReg <= UInt<1>("h0") @[Hello.scala 41:21]
      else :
        skip
    node _io_write_full_T = eq(stateReg, UInt<1>("h1")) @[Hello.scala 46:32]
    io.write.full <= _io_write_full_T @[Hello.scala 46:19]
    node _io_read_empty_T = eq(stateReg, UInt<1>("h0")) @[Hello.scala 47:32]
    io.read.empty <= _io_read_empty_T @[Hello.scala 47:19]
    io.read.dout <= dataReg @[Hello.scala 48:18]

  module BubbleFIFO :
    input clock : Clock
    input reset : UInt<1>
    output io : { write : { flip write : UInt<1>, full : UInt<1>, flip din : UInt<8>}, read : { flip read : UInt<1>, empty : UInt<1>, dout : UInt<8>}}

    inst SingleFIFO of SingleFIFO @[Hello.scala 59:15]
    SingleFIFO.clock <= clock
    SingleFIFO.reset <= reset
    inst SingleFIFO_1 of SingleFIFO_1 @[Hello.scala 59:15]
    SingleFIFO_1.clock <= clock
    SingleFIFO_1.reset <= reset
    inst SingleFIFO_2 of SingleFIFO_2 @[Hello.scala 59:15]
    SingleFIFO_2.clock <= clock
    SingleFIFO_2.reset <= reset
    inst SingleFIFO_3 of SingleFIFO_3 @[Hello.scala 59:15]
    SingleFIFO_3.clock <= clock
    SingleFIFO_3.reset <= reset
    inst SingleFIFO_4 of SingleFIFO_4 @[Hello.scala 59:15]
    SingleFIFO_4.clock <= clock
    SingleFIFO_4.reset <= reset
    SingleFIFO_1.io.write.din <= SingleFIFO.io.read.dout @[Hello.scala 63:37]
    SingleFIFO_1.io.write.write <= SingleFIFO.io.read.read @[Hello.scala 64:39]
    node _T = not(SingleFIFO_1.io.write.full) @[Hello.scala 65:36]
    SingleFIFO.io.read.read <= _T @[Hello.scala 65:33]
    SingleFIFO_2.io.write.din <= SingleFIFO_1.io.read.dout @[Hello.scala 63:37]
    SingleFIFO_2.io.write.write <= SingleFIFO_1.io.read.read @[Hello.scala 64:39]
    node _T_1 = not(SingleFIFO_2.io.write.full) @[Hello.scala 65:36]
    SingleFIFO_1.io.read.read <= _T_1 @[Hello.scala 65:33]
    SingleFIFO_3.io.write.din <= SingleFIFO_2.io.read.dout @[Hello.scala 63:37]
    SingleFIFO_3.io.write.write <= SingleFIFO_2.io.read.read @[Hello.scala 64:39]
    node _T_2 = not(SingleFIFO_3.io.write.full) @[Hello.scala 65:36]
    SingleFIFO_2.io.read.read <= _T_2 @[Hello.scala 65:33]
    SingleFIFO_4.io.write.din <= SingleFIFO_3.io.read.dout @[Hello.scala 63:37]
    SingleFIFO_4.io.write.write <= SingleFIFO_3.io.read.read @[Hello.scala 64:39]
    node _T_3 = not(SingleFIFO_4.io.write.full) @[Hello.scala 65:36]
    SingleFIFO_3.io.read.read <= _T_3 @[Hello.scala 65:33]
    SingleFIFO.io.write.din <= io.write.din @[Hello.scala 68:14]
    io.write.full <= SingleFIFO.io.write.full @[Hello.scala 68:14]
    SingleFIFO.io.write.write <= io.write.write @[Hello.scala 68:14]
    io.read.dout <= SingleFIFO_4.io.read.dout @[Hello.scala 69:13]
    io.read.empty <= SingleFIFO_4.io.read.empty @[Hello.scala 69:13]
    SingleFIFO_4.io.read.read <= io.read.read @[Hello.scala 69:13]

