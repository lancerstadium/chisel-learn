/*
 * This code is a minimal hardware described in Chisel.
 * 
 * Blinking LED: the FPGA version of Hello World
 */

import chisel3._
import chisel3.util._

class WriterIO(size: Int) extends Bundle {
    val write = Input(Bool())
    val full = Output(Bool())
    val din = Input(UInt(size.W))
}

class ReaderIO(size: Int) extends Bundle {
    val read = Input(Bool())
    val empty = Output(Bool())
    val dout = Output(UInt(size.W))
}

// 单 FIFO
class SingleFIFO(size: Int) extends Module {
    val io = IO(new Bundle {
        val write = new WriterIO(size)
        val read = new ReaderIO(size)
    })

    val empty :: full :: Nil = Enum(2)
    val stateReg = RegInit(empty)
    val dataReg = RegInit(0.U(size.W))

    when(stateReg === empty) {
        when(io.write.write) {
            stateReg := full
            dataReg := io.write.din
        }
    }.elsewhen(stateReg === full) {
        when(io.read.read) {
            stateReg := empty
            dataReg := 0.U
        }
    }.otherwise {
        
    }
    io.write.full := (stateReg === full)
    io.read.empty := (stateReg === empty)
    io.read.dout := dataReg
}

// 多 FIFO
class BubbleFIFO(size: Int, depth: Int) extends Module {
    val io = IO(new Bundle {
        val write = new WriterIO(size)
        val read = new ReaderIO(size)
    })

    val buffers = Array.fill(depth) { 
        Module(new SingleFIFO(size)) 
    }

    for(i <- 0 until depth - 1) {
        buffers(i + 1).io.write.din := buffers(i).io.read.dout
        buffers(i + 1).io.write.write := buffers(i).io.read.read
        buffers(i).io.read.read := ~buffers(i + 1).io.write.full
    }

    io.write <> buffers(0).io.write
    io.read <> buffers(depth - 1).io.read
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
    (new chisel3.stage.ChiselStage).emitVerilog(new BubbleFIFO(8, 5))
}
