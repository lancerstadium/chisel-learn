import chisel3._
import chisel3.util._

 class Channel extends Bundle {
    val data = Input(Bits(8.W))
    val ready = Output(Bool())
    val valid = Input(Bool())
}

class Tx(frequency: Int, baudRate: Int) extends Module {
    val io = IO(new Bundle {
        val txd = Output(Bits(1.W))
        val channel = new Channel()
    })

    val clkReg = RegInit(0.U(16.W))
    clkReg := clkReg + 1.U

    val BIT_CNT = ((frequency + baudRate / 2) / baudRate - 1).asUInt

    val shiftReg = RegInit(0x7ff.U) // 共11位，一个开始位，两个结束位
    val cntReg = RegInit(0.U(20.W))
    val bitsReg = RegInit(0.U(4.W))

    io.channel.ready := (cntReg === 0.U) && (bitsReg === 0.U)
    io.txd := shiftReg(0)

    when(cntReg === 0.U) {
        cntReg := BIT_CNT
        when(bitsReg =/= 0.U) {
            val shift = shiftReg >> 1
            shiftReg := Cat(1.U, shift(9, 0))
            bitsReg := bitsReg - 1.U
            printf("%d: sending ...%b\n", clkReg, shiftReg(1))
        }.otherwise {
            when(io.channel.valid) {
                // 一个起始位0和两个结束位11
                shiftReg := Cat(Cat(3.U, io.channel.data), 0.U)
                printf("%d: sending start 0 ...%b\n", clkReg, 0.U)
                bitsReg := 11.U
            }.otherwise {
                shiftReg := 0x7ff.U
            }
        }
    }.otherwise {
        cntReg := cntReg - 1.U
    }
}

class Buffer extends Module {
    val io = IO(new Bundle {
        val in = new Channel()
        val out = Flipped(new Channel())
    })

    val empty :: full :: Nil = Enum(2)
    val stateReg = RegInit(empty)
    val dataReg = RegInit(0.U(8.W))

    io.in.ready := stateReg === empty
    io.out.valid := stateReg === full

    when(stateReg === empty) {
        when(io.in.valid) {
            dataReg := io.in.data
            stateReg := full
        }
    }.otherwise {
        when(io.out.ready) {
            stateReg := empty
        }
    }

    io.out.data := dataReg
}

class BufferedTx(frequency: Int, baudRate: Int) extends Module {
    val io = IO(new Bundle {
        val txd = Output(Bits(1.W))
        val channel = new Channel()
    })

    val tx = Module(new Tx(frequency, baudRate))
    val buf = Module(new Buffer())

    buf.io.in <> io.channel
    tx.io.channel <> buf.io.out
    io.txd <> tx.io.txd
}

class Rx(frequency: Int, baudRate: Int) extends Module {
    val io = IO(new Bundle {
        val rxd = Input(Bits(1.W))
        val channel = Flipped(new Channel())
    })

    val clkReg = RegInit(0.U(16.W))
    clkReg := clkReg + 1.U

    val BIT_CNT = ((frequency + baudRate / 2) / baudRate - 1).U
    // 接收器在起始位下降沿的1.5个比特时间后开始接收数据
    val START_CNT = ((3 * frequency / 2 + baudRate / 2) / baudRate - 1).U

    // 同步异步的RX数据
    // 复位时会复位为1以停止读数据
    val rxReg = RegNext(RegNext(io.rxd, 1.U), 1.U)

    val shiftReg = RegInit('A'.U(8.W))
    val cntReg = RegInit(0.U(20.W))
    val bitsReg = RegInit(0.U(4.W))
    val valReg = RegInit(false.B)

    when(cntReg =/= 0.U) {
        cntReg := cntReg - 1.U
    }.elsewhen(bitsReg =/= 0.U) {
        cntReg := BIT_CNT
        shiftReg := Cat(rxReg, shiftReg >> 1)
        bitsReg := bitsReg - 1.U
        printf("%d: reading ...%b\n", clkReg, rxReg)
        // 移入最后一位时
        when(bitsReg === 1.U) {
            valReg := true.B
            printf("Done reading ...%c\n", Cat(rxReg, shiftReg >> 1))
        }
    }.elsewhen(rxReg === 0.U) {
        cntReg := START_CNT
        bitsReg := 8.U
        printf("%d: reading start 0 ...%b\n", clkReg, rxReg)
    }

    when(valReg && io.channel.ready) {
        valReg := false.B
    }

    io.channel.data := shiftReg
    io.channel.valid := valReg
}

class Comm(frequency: Int, baudRate: Int) extends Module {
    val tx = Module(new BufferedTx(frequency, baudRate))
    val rx = Module(new Rx(frequency, baudRate))

    val msg = "Hello World!"
    val text = VecInit(msg.map(_.U))
    val len = msg.length().U

    val cntReg = RegInit(0.U(8.W))

    tx.io.channel.data := text(cntReg)
    tx.io.channel.valid := cntReg =/= len
    rx.io.channel.ready := tx.io.channel.ready
    rx.io.rxd := tx.io.txd

    when(tx.io.channel.ready && cntReg =/= len) {
        cntReg := cntReg + 1.U
    }
}
