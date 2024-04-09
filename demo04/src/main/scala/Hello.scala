/*
 * This code is a minimal hardware described in Chisel.
 * 
 * Blinking LED: the FPGA version of Hello World
 */

import chisel3._


abstract class Ticker(n: Int) extends Module {
    val io = IO(new Bundle {
        val tick = Output(Bool())
    })
}

class UpTicker(n: Int) extends Ticker(n) {
    val N = (n-1).U
    val cntReg = RegInit(0.U(8.W))

    cntReg := cntReg + 1.U

    when (cntReg === N) {
        cntReg := 0.U
    }

    io.tick := cntReg === N
}

class DownTicker(n: Int) extends Ticker(n) {
    val N = (n-1).U
    
    val cntReg = RegInit(N)
    
    cntReg := cntReg - 1.U

    when(cntReg === 0.U) {
        cntReg := N
    }
    
    io.tick := cntReg === N
}

class NerdTicker(n: Int) extends Ticker(n) {
    val N = n
    val MAX = (N-2).S(8.W)
    val cntReg = RegInit(MAX)
    
    io.tick := false.B
    
    cntReg := cntReg - 1.S
    when(cntReg(7)) {
        cntReg := MAX
        io.tick := true.B
    }
}


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
}

/**
 * An object extending App to generate the Verilog code.
 */
object Hello extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new Hello())
}
