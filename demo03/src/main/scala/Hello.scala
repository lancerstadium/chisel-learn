/*
 * This code is a minimal hardware described in Chisel.
 * 
 * Blinking LED: the FPGA version of Hello World
 */

import chisel3._
import scala.io.Source


class FileReader extends Module {
    val io = IO(new Bundle {
        val addr = Input(UInt(8.W))
        val data = Output(UInt(8.W))
    })

    val arr = new Array[Int](256)
    var idx = 0

    // read file
    val src = Source.fromFile("/home/lexer/item/chisel_learn/chisel-learn/demo03/data.txt")
    for (line <- src.getLines()) {
        arr(idx) = line.toInt
        idx = idx + 1
    }

    // arr -> vec
    val vec = VecInit(arr.map(_.U(8.W)))

    // use vec table
    io.data := vec(io.addr)
}

class BcdTable extends Module {
    val io = IO(new Bundle {
        val address = Input(UInt(8.W))
        val data = Output(UInt(8.W))
    })
    
    val table = Wire(Vec(100, UInt(8.W)))
    
    // 二进制转换为BCD
    for (i <- 0 until 100) {
        table(i) := (((i/10)<<4) + i%10).U
    }
    
    io.data := table(io.address)
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
    (new chisel3.stage.ChiselStage).emitVerilog(new FileReader())
}

