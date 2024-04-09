package rv32isc


import chisel3._
import chisel3.util._

import config.Configs._

// PCReg 模块：
// 1. 输出：32 位的指令地址
// 2. 自增：每个时钟周期指令地址加 4
// 3. 跳转控制：当前指令为跳转指令，收到控制单元的信号ctrlJump，接收计算结果（跳转地址）作为下一个地址
// 4. 分支控制：当前指令为分支指令，收到控制单元的信号ctrlBranch，若分支成功，接收计算结果（跳转地址）作为下一个地址
// 5. 初始化：输出地址为 0


class PCRegIO extends Bundle {
    val addrOut = Output(UInt(ADDR_WIDTH.W))        // 地址输出
    val ctrlJump = Input(Bool())                    // 跳转控制
    val ctrlBranch = Input(Bool())                  // 分支控制
    val resultBranch = Input(Bool())                // 分支成功
    val addrTarget = Input(UInt(ADDR_WIDTH.W))      // 目标地址
}


class PCReg extends Module {
    val io = IO(new PCRegIO)
    // 初始化
    val regPC = RegInit(UInt(ADDR_WIDTH.W), START_ADDR.U)
    
    when (io.ctrlJump || (io.ctrlBranch && io.resultBranch)) {
        // 分支成功或跳转时，更新地址
        regPC := io.addrTarget
    } .otherwise {
        // 其他情况，地址加 4
        regPC := regPC + 4.U
    }
    // 输出
    io.addrOut := regPC
}
