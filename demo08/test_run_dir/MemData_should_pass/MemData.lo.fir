circuit MemData :
  module MemData :
    input clock : Clock
    input reset : UInt<1>
    input io_bundleMemDataControl_ctrlLoad : UInt<1>
    input io_bundleMemDataControl_ctrlStore : UInt<1>
    input io_bundleMemDataControl_ctrlSigned : UInt<1>
    input io_bundleMemDataControl_ctrlLSType : UInt<2>
    input io_resultALU : UInt<32>
    input io_dataStore : UInt<32>
    output io_result : UInt<32>

    mem mem : @[MemData.scala 22:18]
      data-type => UInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => dataLoad_MPORT
      writer => MPORT
      writer => MPORT_1
      writer => MPORT_2
      read-under-write => undefined
    node _dataLoad_T = dshr(io_resultALU, UInt<2>("h2")) @[MemData.scala 31:39]
    node _dataLoad_T_1 = bits(_dataLoad_T, 9, 0) @[MemData.scala 31:25]
    node _T = eq(io_bundleMemDataControl_ctrlLSType, UInt<2>("h2")) @[MemData.scala 35:49]
    node _T_1 = dshr(io_resultALU, UInt<2>("h2")) @[MemData.scala 36:36]
    node _T_2 = bits(_T_1, 9, 0)
    node _T_3 = eq(io_bundleMemDataControl_ctrlLSType, UInt<1>("h1")) @[MemData.scala 37:55]
    node _T_4 = dshr(io_resultALU, UInt<2>("h2")) @[MemData.scala 38:36]
    node dataLoad = mem.dataLoad_MPORT.data
    node _T_5 = bits(dataLoad, 31, 16) @[MemData.scala 38:74]
    node _T_6 = bits(io_dataStore, 15, 0) @[MemData.scala 38:96]
    node _T_7 = cat(_T_5, _T_6) @[Cat.scala 31:58]
    node _T_8 = bits(_T_4, 9, 0)
    node _T_9 = dshr(io_resultALU, UInt<2>("h2")) @[MemData.scala 40:36]
    node _T_10 = bits(dataLoad, 31, 8) @[MemData.scala 40:74]
    node _T_11 = bits(io_dataStore, 7, 0) @[MemData.scala 40:95]
    node _T_12 = cat(_T_10, _T_11) @[Cat.scala 31:58]
    node _T_13 = bits(_T_9, 9, 0)
    node _GEN_0 = validif(_T_3, _T_8) @[MemData.scala 37:65]
    node _GEN_1 = validif(_T_3, clock) @[MemData.scala 37:65]
    node _GEN_2 = mux(_T_3, UInt<1>("h1"), UInt<1>("h0")) @[MemData.scala 22:18 37:65]
    node _GEN_3 = validif(_T_3, UInt<1>("h1")) @[MemData.scala 37:65]
    node _GEN_4 = validif(_T_3, _T_7) @[MemData.scala 37:65]
    node _GEN_5 = validif(eq(_T_3, UInt<1>("h0")), _T_13) @[MemData.scala 37:65]
    node _GEN_6 = validif(eq(_T_3, UInt<1>("h0")), clock) @[MemData.scala 37:65]
    node _GEN_7 = mux(_T_3, UInt<1>("h0"), UInt<1>("h1")) @[MemData.scala 22:18 37:65]
    node _GEN_8 = validif(eq(_T_3, UInt<1>("h0")), UInt<1>("h1")) @[MemData.scala 37:65]
    node _GEN_9 = validif(eq(_T_3, UInt<1>("h0")), _T_12) @[MemData.scala 37:65]
    node _GEN_10 = validif(_T, _T_2) @[MemData.scala 35:59]
    node _GEN_11 = validif(_T, clock) @[MemData.scala 35:59]
    node _GEN_12 = mux(_T, UInt<1>("h1"), UInt<1>("h0")) @[MemData.scala 22:18 35:59]
    node _GEN_13 = validif(_T, UInt<1>("h1")) @[MemData.scala 35:59]
    node _GEN_14 = validif(_T, io_dataStore) @[MemData.scala 35:59]
    node _GEN_15 = validif(eq(_T, UInt<1>("h0")), _GEN_0) @[MemData.scala 35:59]
    node _GEN_16 = validif(eq(_T, UInt<1>("h0")), _GEN_1) @[MemData.scala 35:59]
    node _GEN_17 = mux(_T, UInt<1>("h0"), _GEN_2) @[MemData.scala 22:18 35:59]
    node _GEN_18 = validif(eq(_T, UInt<1>("h0")), _GEN_3) @[MemData.scala 35:59]
    node _GEN_19 = validif(eq(_T, UInt<1>("h0")), _GEN_4) @[MemData.scala 35:59]
    node _GEN_20 = validif(eq(_T, UInt<1>("h0")), _GEN_5) @[MemData.scala 35:59]
    node _GEN_21 = validif(eq(_T, UInt<1>("h0")), _GEN_6) @[MemData.scala 35:59]
    node _GEN_22 = mux(_T, UInt<1>("h0"), _GEN_7) @[MemData.scala 22:18 35:59]
    node _GEN_23 = validif(eq(_T, UInt<1>("h0")), _GEN_8) @[MemData.scala 35:59]
    node _GEN_24 = validif(eq(_T, UInt<1>("h0")), _GEN_9) @[MemData.scala 35:59]
    node _GEN_25 = validif(io_bundleMemDataControl_ctrlStore, _GEN_10) @[MemData.scala 34:45]
    node _GEN_26 = validif(io_bundleMemDataControl_ctrlStore, _GEN_11) @[MemData.scala 34:45]
    node _GEN_27 = mux(io_bundleMemDataControl_ctrlStore, _GEN_12, UInt<1>("h0")) @[MemData.scala 22:18 34:45]
    node _GEN_28 = validif(io_bundleMemDataControl_ctrlStore, _GEN_13) @[MemData.scala 34:45]
    node _GEN_29 = validif(io_bundleMemDataControl_ctrlStore, _GEN_14) @[MemData.scala 34:45]
    node _GEN_30 = validif(io_bundleMemDataControl_ctrlStore, _GEN_15) @[MemData.scala 34:45]
    node _GEN_31 = validif(io_bundleMemDataControl_ctrlStore, _GEN_16) @[MemData.scala 34:45]
    node _GEN_32 = mux(io_bundleMemDataControl_ctrlStore, _GEN_17, UInt<1>("h0")) @[MemData.scala 22:18 34:45]
    node _GEN_33 = validif(io_bundleMemDataControl_ctrlStore, _GEN_18) @[MemData.scala 34:45]
    node _GEN_34 = validif(io_bundleMemDataControl_ctrlStore, _GEN_19) @[MemData.scala 34:45]
    node _GEN_35 = validif(io_bundleMemDataControl_ctrlStore, _GEN_20) @[MemData.scala 34:45]
    node _GEN_36 = validif(io_bundleMemDataControl_ctrlStore, _GEN_21) @[MemData.scala 34:45]
    node _GEN_37 = mux(io_bundleMemDataControl_ctrlStore, _GEN_22, UInt<1>("h0")) @[MemData.scala 22:18 34:45]
    node _GEN_38 = validif(io_bundleMemDataControl_ctrlStore, _GEN_23) @[MemData.scala 34:45]
    node _GEN_39 = validif(io_bundleMemDataControl_ctrlStore, _GEN_24) @[MemData.scala 34:45]
    node _T_14 = eq(io_bundleMemDataControl_ctrlLSType, UInt<2>("h2")) @[MemData.scala 45:49]
    node _T_15 = eq(io_bundleMemDataControl_ctrlLSType, UInt<1>("h1")) @[MemData.scala 47:55]
    node _result_T = bits(dataLoad, 15, 15) @[MemData.scala 49:48]
    node _result_T_1 = bits(_result_T, 0, 0) @[Bitwise.scala 74:15]
    node _result_T_2 = mux(_result_T_1, UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
    node _result_T_3 = bits(dataLoad, 15, 0) @[MemData.scala 49:63]
    node _result_T_4 = cat(_result_T_2, _result_T_3) @[Cat.scala 31:58]
    node _result_T_5 = mux(UInt<1>("h0"), UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 74:12]
    node _result_T_6 = bits(dataLoad, 15, 0) @[MemData.scala 51:54]
    node _result_T_7 = cat(_result_T_5, _result_T_6) @[Cat.scala 31:58]
    node _GEN_40 = mux(io_bundleMemDataControl_ctrlSigned, _result_T_4, _result_T_7) @[MemData.scala 48:55 49:24 51:24]
    node _result_T_8 = bits(dataLoad, 7, 7) @[MemData.scala 55:48]
    node _result_T_9 = bits(_result_T_8, 0, 0) @[Bitwise.scala 74:15]
    node _result_T_10 = mux(_result_T_9, UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 74:12]
    node _result_T_11 = bits(dataLoad, 7, 0) @[MemData.scala 55:62]
    node _result_T_12 = cat(_result_T_10, _result_T_11) @[Cat.scala 31:58]
    node _result_T_13 = mux(UInt<1>("h0"), UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 74:12]
    node _result_T_14 = bits(dataLoad, 7, 0) @[MemData.scala 57:54]
    node _result_T_15 = cat(_result_T_13, _result_T_14) @[Cat.scala 31:58]
    node _GEN_41 = mux(io_bundleMemDataControl_ctrlSigned, _result_T_12, _result_T_15) @[MemData.scala 54:55 55:24 57:24]
    node _GEN_42 = mux(_T_15, _GEN_40, _GEN_41) @[MemData.scala 47:65]
    node _GEN_43 = mux(_T_14, dataLoad, _GEN_42) @[MemData.scala 45:59 46:20]
    node _GEN_44 = mux(io_bundleMemDataControl_ctrlLoad, _GEN_43, io_resultALU) @[MemData.scala 44:45 62:16]
    node result = _GEN_44
    io_result <= result @[MemData.scala 66:15]
    mem.dataLoad_MPORT.addr <= _dataLoad_T_1 @[MemData.scala 31:25]
    mem.dataLoad_MPORT.en <= UInt<1>("h1") @[MemData.scala 31:25]
    mem.dataLoad_MPORT.clk <= clock @[MemData.scala 31:25]
    mem.MPORT.addr <= _GEN_25
    mem.MPORT.en <= _GEN_27
    mem.MPORT.clk <= _GEN_26
    mem.MPORT.data <= _GEN_29
    mem.MPORT.mask <= _GEN_28
    mem.MPORT_1.addr <= _GEN_30
    mem.MPORT_1.en <= _GEN_32
    mem.MPORT_1.clk <= _GEN_31
    mem.MPORT_1.data <= _GEN_34
    mem.MPORT_1.mask <= _GEN_33
    mem.MPORT_2.addr <= _GEN_35
    mem.MPORT_2.en <= _GEN_37
    mem.MPORT_2.clk <= _GEN_36
    mem.MPORT_2.data <= _GEN_39
    mem.MPORT_2.mask <= _GEN_38
