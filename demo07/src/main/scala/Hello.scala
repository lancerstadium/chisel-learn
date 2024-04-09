import chisel3._
import chisel3.util._


// FIFO 抽象类
abstract class Fifo[T <: Data](gen: T, depth: Int) extends Module {
    val io = IO(new  FifoIO(gen))
    assert(depth > 0, "Number of buffer elements needs to be larger than 0")
}

// FIFO IO
class FifoIO[T <: Data](gen: T) extends Bundle {
    val enq = Flipped(Decoupled(gen))
    val deq = Decoupled(gen)
}

// Bubble FIFO
class BubbleFifo[T <: Data](gen: T, depth: Int) extends Fifo(gen: T, depth: Int) {
    
    private class Buffer() extends Module {
        val io = IO(new FifoIO(gen))

        val fullReg = RegInit(false.B)
        val dataReg = Reg(gen)

        when (fullReg) {
            when (io.deq.ready) {
                fullReg := false.B
            }
        } .otherwise {
            when (io.enq.valid) {
                fullReg := true.B
                dataReg := io.enq.bits
            }
        }

        io.enq.ready := !fullReg
        io.deq.valid := fullReg
        io.deq.bits := dataReg
    }

    // 把Buffer组件实现为BubbleFifo内部的一个私有类
    private val buffers = Array.fill(depth) { 
        Module(new Buffer()) 
    }
    for(i <- 0 until depth - 1) {
        buffers(i + 1).io.enq <> buffers(i).io.deq
    }

    io.enq <> buffers(0).io.enq
    io.deq <> buffers(depth - 1).io.deq
}

// Double Buffer FIFO
class DoubleBufferFifo[T <: Data](gen: T, depth: Int) extends Fifo(gen: T, depth: Int) {
    private class DoubleBuffer extends Module {
        val io = IO(new FifoIO(gen))

        val empty :: one :: two :: Nil = Enum(3)
        val stateReg = RegInit(empty)
        val dataReg = Reg(gen)
        val shadowReg = Reg(gen)

        switch (stateReg) {
            is (empty) {
                when(io.enq.valid) {
                    stateReg := one
                    dataReg := io.enq.bits
                }
            }
            is (one) {
                when(io.deq.ready && !io.enq.valid) {
                    stateReg := empty
                }
                when(io.deq.ready && io.enq.valid) {
                    stateReg := one
                    dataReg := io.enq.bits
                }
                when(!io.deq.ready && io.enq.valid) {
                    stateReg := two
                    shadowReg := io.enq.bits
                }
            }
            is (two) {
                when(io.deq.ready && !io.enq.valid) {
                    stateReg := one
                    dataReg := shadowReg
                }
            }
        }

        io.enq.ready := (stateReg === empty || stateReg === one)
        io.deq.valid := (stateReg === one || stateReg === two)
        io.deq.bits := dataReg
    }

    private val buffers = Array.fill((depth+1)/2) { 
        Module(new DoubleBuffer()) 
    }
    for(i <- 0 until (depth+1)/2 - 1) {
        buffers(i + 1).io.enq <> buffers(i).io.deq
    }

    io.enq <> buffers(0).io.enq
    io.deq <> buffers((depth+1)/2 - 1).io.deq
}


// 基于寄存器的实现
class RegFifo[T <: Data](gen: T, depth: Int) extends Fifo(gen: T, depth: Int) {
    def counter(depth: Int, incr: Bool): (UInt, UInt) = {
        val cntReg = RegInit(0.U(log2Ceil(depth).W))
        val nextVal = Mux(cntReg === (depth-1).U, 0.U, cntReg + 1.U)
        when(incr) {
            cntReg := nextVal
        }
        (cntReg, nextVal)
    }

    val memReg = Reg(Vec(depth, gen))

    val incrRead = WireDefault(false.B)
    val incrWrite = WireDefault(false.B)
    val (readPtr, nextRead) = counter(depth, incrRead)
    val (writePtr, nextWrite) = counter(depth, incrWrite)

    val emptyReg = RegInit(true.B)
    val fullReg = RegInit(false.B)

    // 当写指针准备好时，且队列非满时
    when(io.enq.valid && !fullReg) {
        memReg(writePtr) := io.enq.bits     // 写入寄存器
        emptyReg := false.B                 // 队列非空
        fullReg := nextWrite === readPtr
        incrWrite := true.B
    }

    // 当读指针准备好时，且队列非空时
    when(io.deq.ready && !emptyReg) {
        fullReg := false.B
        emptyReg := nextRead === writePtr
        incrRead := true.B
    }

    io.deq.bits := memReg(readPtr)
    io.enq.ready := !fullReg
    io.deq.valid := !emptyReg
}


// 基于片上内存的 FIFO：同步内存
class MemFifo[T <: Data](gen: T, depth: Int) extends Fifo(gen: T, depth: Int) {
    def counter(depth: Int, incr: Bool): (UInt, UInt) = {
        val cntReg = RegInit(0.U(log2Ceil(depth).W))
        val nextVal = Mux(cntReg === (depth-1).U, 0.U, cntReg + 1.U)
        when(incr) {
            cntReg := nextVal
        }
        (cntReg, nextVal)
    }

    val mem = SyncReadMem(depth, gen)

    val incrRead = WireDefault(false.B)
    val incrWrite = WireDefault(false.B)
    val (readPtr, nextRead) = counter(depth, incrRead)
    val (writePtr, nextWrite) = counter(depth, incrWrite)

    val emptyReg = RegInit(true.B)
    val fullReg = RegInit(false.B)

    val idle :: valid :: full :: Nil = Enum(3)

    val stateReg = RegInit(idle)
    val shadowReg = Reg(gen)

    // FIFO处理相同
    when(io.enq.valid && !fullReg) {
        mem.write(writePtr, io.enq.bits)
        emptyReg := false.B
        fullReg := nextWrite === readPtr
        incrWrite := true.B
    }
    // 读内存：处理一周期时延
    val data = mem.read(readPtr)

    switch(stateReg) {
        is(idle) {
            when(!emptyReg) {
                stateReg := valid
                fullReg := false.B
                emptyReg := nextRead === writePtr
                incrRead := true.B
            }
        }
        is(valid) {
            when(io.deq.ready) {
                when(!emptyReg) {
                    stateReg := valid
                    fullReg := false.B
                    emptyReg := nextRead === writePtr
                    incrRead := true.B
                }.otherwise {
                    stateReg := idle
                }
            }.otherwise {   // 如果这个值不被消费的话，那就把它存放到影子寄存器
                shadowReg := data
                stateReg := full
            }
        }
        is(full) {
            when(io.deq.ready) {
                when(!emptyReg) {
                    stateReg := valid
                    fullReg := false.B
                    emptyReg := nextRead === writePtr
                    incrRead := true.B
                }.otherwise {
                    stateReg := idle
                }
            }
        }
    }

    io.deq.bits := Mux(stateReg === valid, data, shadowReg)
    io.enq.ready := !fullReg
    io.deq.valid := stateReg === valid || stateReg === full
}

// 很容易地通过组合两个 FIFO 把我们的设计流水化
class CombFifo[T <: Data](gen: T, depth: Int) extends Fifo(gen: T, depth: Int) {
    val memFifo = Module(new MemFifo(gen, depth))
    val bufferFIFO = Module(new DoubleBufferFifo(gen, 2))
    
    io.enq <> memFifo.io.enq
    io.deq <> bufferFIFO.io.deq
    memFifo.io.deq <> bufferFIFO.io.enq
}

object FifoGen extends App {
    (new chisel3.stage.ChiselStage).emitVerilog(new BubbleFifo(UInt(8.W), 3))
    (new chisel3.stage.ChiselStage).emitVerilog(new DoubleBufferFifo(UInt(8.W), 3))
    (new chisel3.stage.ChiselStage).emitVerilog(new RegFifo(UInt(8.W), 3))
    (new chisel3.stage.ChiselStage).emitVerilog(new MemFifo(UInt(8.W), 3))
    (new chisel3.stage.ChiselStage).emitVerilog(new CombFifo(UInt(8.W), 3))
}