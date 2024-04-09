circuit Hello :
  module Hello :
    input clock : Clock
    input reset : UInt<1>
    output io : { led : UInt<1>, flip sw : UInt<3>}

    node _io_led_T = bits(io.sw, 0, 0) @[Hello.scala 20:20]
    io.led <= _io_led_T @[Hello.scala 20:12]

