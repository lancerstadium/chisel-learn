import chisel3._
import chisel3.util._


class Seg7 extends Module {
    val io = IO(new Bundle {
        val sw = Input(UInt(4.W))
        val segOut = Output(UInt(7.W))
    })

    io.segOut := "b111_1111".U

    switch(io.sw) {
        is ("b0000".U) { io.segOut := "b100_0000".U }
        is ("b0001".U) { io.segOut := "b111_1001".U }
        is ("b0010".U) { io.segOut := "b010_0100".U }
        is ("b0011".U) { io.segOut := "b011_0000".U }
        is ("b0100".U) { io.segOut := "b001_1001".U }
        is ("b0101".U) { io.segOut := "b001_0010".U }
        is ("b0110".U) { io.segOut := "b000_0010".U }
        is ("b0111".U) { io.segOut := "b111_1000".U }
        is ("b1000".U) { io.segOut := "b000_0000".U }
        is ("b1001".U) { io.segOut := "b001_0000".U }
        is ("b1010".U) { io.segOut := "b000_1000".U }
        is ("b1011".U) { io.segOut := "b000_0011".U }
        is ("b1100".U) { io.segOut := "b010_0111".U }
        is ("b1101".U) { io.segOut := "b010_0001".U }
        is ("b1110".U) { io.segOut := "b000_0110".U }
        is ("b1111".U) { io.segOut := "b000_1110".U }
    }

}


object Seg7 extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new Seg7())
}
