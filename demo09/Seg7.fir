circuit Seg7 :
  module Seg7 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip sw : UInt<4>, segOut : UInt<7>}

    io.segOut <= UInt<7>("h7f") @[Hello.scala 11:15]
    node _T = eq(UInt<1>("h0"), io.sw) @[Hello.scala 13:19]
    when _T : @[Hello.scala 13:19]
      io.segOut <= UInt<7>("h40") @[Hello.scala 14:36]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.sw) @[Hello.scala 13:19]
      when _T_1 : @[Hello.scala 13:19]
        io.segOut <= UInt<7>("h79") @[Hello.scala 15:36]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.sw) @[Hello.scala 13:19]
        when _T_2 : @[Hello.scala 13:19]
          io.segOut <= UInt<6>("h24") @[Hello.scala 16:36]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.sw) @[Hello.scala 13:19]
          when _T_3 : @[Hello.scala 13:19]
            io.segOut <= UInt<6>("h30") @[Hello.scala 17:36]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.sw) @[Hello.scala 13:19]
            when _T_4 : @[Hello.scala 13:19]
              io.segOut <= UInt<5>("h19") @[Hello.scala 18:36]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.sw) @[Hello.scala 13:19]
              when _T_5 : @[Hello.scala 13:19]
                io.segOut <= UInt<5>("h12") @[Hello.scala 19:36]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.sw) @[Hello.scala 13:19]
                when _T_6 : @[Hello.scala 13:19]
                  io.segOut <= UInt<2>("h2") @[Hello.scala 20:36]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.sw) @[Hello.scala 13:19]
                  when _T_7 : @[Hello.scala 13:19]
                    io.segOut <= UInt<7>("h78") @[Hello.scala 21:36]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.sw) @[Hello.scala 13:19]
                    when _T_8 : @[Hello.scala 13:19]
                      io.segOut <= UInt<1>("h0") @[Hello.scala 22:36]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.sw) @[Hello.scala 13:19]
                      when _T_9 : @[Hello.scala 13:19]
                        io.segOut <= UInt<5>("h10") @[Hello.scala 23:36]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.sw) @[Hello.scala 13:19]
                        when _T_10 : @[Hello.scala 13:19]
                          io.segOut <= UInt<4>("h8") @[Hello.scala 24:36]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.sw) @[Hello.scala 13:19]
                          when _T_11 : @[Hello.scala 13:19]
                            io.segOut <= UInt<2>("h3") @[Hello.scala 25:36]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.sw) @[Hello.scala 13:19]
                            when _T_12 : @[Hello.scala 13:19]
                              io.segOut <= UInt<6>("h27") @[Hello.scala 26:36]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.sw) @[Hello.scala 13:19]
                              when _T_13 : @[Hello.scala 13:19]
                                io.segOut <= UInt<6>("h21") @[Hello.scala 27:36]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.sw) @[Hello.scala 13:19]
                                when _T_14 : @[Hello.scala 13:19]
                                  io.segOut <= UInt<3>("h6") @[Hello.scala 28:36]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.sw) @[Hello.scala 13:19]
                                  when _T_15 : @[Hello.scala 13:19]
                                    io.segOut <= UInt<4>("he") @[Hello.scala 29:36]

