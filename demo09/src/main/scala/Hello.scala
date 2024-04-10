/*
 * This code is a minimal hardware described in Chisel.
 * 
 * Blinking LED: the FPGA version of Hello World
 */

import chisel3._

/**
 * The blinking LED component.
 */

class Hello extends Module {
    val io = IO(new Bundle {
        val led = Output(UInt(1.W))
        val sw = Input(UInt(3.W))
    })

    // switch
    io.led := io.sw(0)

    // and
    // io.led := io.sw(0) & io.sw(1)

    // mux
    // io.led := Mux(io.sw(0), io.sw(1), io.sw(2))

    // val CNT_MAX = (50000000 / 2 - 1).U

    // val cntReg = RegInit(0.U(32.W))
    // val blkReg = RegInit(0.U(1.W))

    // cntReg := cntReg + 1.U
    // when(cntReg === CNT_MAX) {
    //     cntReg := 0.U
    //     blkReg := ~blkReg
    // }
    // io.led := blkReg
}

/**
 * An object extending App to generate the Verilog code.
 */
object Hello extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new Hello())
}
