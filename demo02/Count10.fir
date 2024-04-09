circuit Count10 :
  module Adder :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<8>, flip b : UInt<8>, y : UInt<8>}

    node _io_y_T = add(io.a, io.b) @[Hello.scala 44:18]
    node _io_y_T_1 = tail(_io_y_T, 1) @[Hello.scala 44:18]
    io.y <= _io_y_T_1 @[Hello.scala 44:10]

  module Register :
    input clock : Clock
    input reset : Reset
    output io : { flip d : UInt<8>, q : UInt<8>}

    reg reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[Hello.scala 53:22]
    reg <= io.d @[Hello.scala 54:9]
    io.q <= reg @[Hello.scala 55:10]

  module Count10 :
    input clock : Clock
    input reset : UInt<1>
    output io : { dout : UInt<8>}

    inst add of Adder @[Hello.scala 65:21]
    add.clock <= clock
    add.reset <= reset
    inst reg of Register @[Hello.scala 66:21]
    reg.clock <= clock
    reg.reset <= reset
    add.io.a <= UInt<1>("h1") @[Hello.scala 72:14]
    add.io.b <= reg.io.q @[Hello.scala 73:14]
    node _next_T = eq(reg.io.q, UInt<4>("h9")) @[Hello.scala 77:26]
    node next = mux(_next_T, UInt<1>("h0"), add.io.y) @[Hello.scala 77:19]
    reg.io.d <= next @[Hello.scala 78:14]
    io.dout <= reg.io.q @[Hello.scala 80:13]

