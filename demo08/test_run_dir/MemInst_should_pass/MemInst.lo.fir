circuit MemInst :
  module MemInst :
    input clock : Clock
    input reset : UInt<1>
    input io_addr : UInt<32>
    output io_inst : UInt<32>

    mem mem : @[MemInst.scala 20:18]
      data-type => UInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => io_inst_MPORT
      read-under-write => undefined
    node _io_inst_T = dshr(io_addr, UInt<2>("h2")) @[MemInst.scala 27:33]
    node _io_inst_T_1 = bits(_io_inst_T, 9, 0) @[MemInst.scala 27:24]
    io_inst <= mem.io_inst_MPORT.data @[MemInst.scala 27:13]
    mem.io_inst_MPORT.addr <= _io_inst_T_1 @[MemInst.scala 27:24]
    mem.io_inst_MPORT.en <= UInt<1>("h1") @[MemInst.scala 27:24]
    mem.io_inst_MPORT.clk <= clock @[MemInst.scala 27:24]
