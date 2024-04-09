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
}

/**
 * An object extending App to generate the Verilog code.
 */
object Hello extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new Count10())
}


class Adder extends Module {
    val io = IO(new Bundle {
        val a = Input(UInt(8.W))
        val b = Input(UInt(8.W))
        val y = Output(UInt(8.W))
    })

    io.y := io.a + io.b
}

class Register extends Module {
    val io = IO(new Bundle {
        val d = Input(UInt(8.W))
        val q = Output(UInt(8.W))
    })

    val reg = RegInit(0.U(8.W))
    reg := io.d
    io.q := reg

}


class Count10 extends Module {
    val io = IO(new Bundle {
        val dout = Output(UInt(8.W))
    })

    val add = Module(new Adder())
    val reg = Module(new Register())

    // reg output
    val count = reg.io.q

    // connect the adder
    add.io.a := 1.U
    add.io.b := count
    val result = add.io.y

    // connect the Mux and reg inputs
    val next = Mux(count === 9.U, 0.U, result)
    reg.io.d := next

    io.dout := count

}
