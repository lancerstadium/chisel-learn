package rv32isc

import chisel3._
import chisel3.util._

import chisel3.util.experimental.loadMemoryFromFile
import firrtl.annotations.MemoryLoadFileType

import config.Configs._

class MemInstIO extends Bundle {
    val addr = Input(UInt(ADDR_WIDTH.W))    // 地址输入
    val inst = Output(UInt(INST_WIDTH.W))   // 指令输出
}

// Mem 内存为异步读、同步写，输出指令不含时序，为组合电路
class MemInst extends Module {
    val io = IO(new MemInstIO)              // 定义 IO
    // 指令存储器：1024 个 32 位指令
    val mem = Mem(MEM_INST_SIZE, UInt(INST_WIDTH.W))
    // 内存初始化
    loadMemoryFromFile(mem, "src/test/scala/rv32isc/MemInst.hex", MemoryLoadFileType.Hex)
    // 读取对应位置指令并输出：通过将输入的指令地址右移两位，相当于将地址除以4，从而得到了指令在内存中的正确位置
    io.inst := mem.read(io.addr >> INST_BYTE_WIDTH_LOG.U)
}