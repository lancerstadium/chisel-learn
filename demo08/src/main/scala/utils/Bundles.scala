package utils

import chisel3._

import config.Configs._
import utils.OP_TYPES._

// 用于连接控制模块的Bundle
class BundleControl extends Bundle {
    val ctrlJump = Output(Bool())
    val ctrlBranch = Output(Bool())
    val ctrlRegWrite = Output(Bool())
    val ctrlLoad = Output(Bool())
    val ctrlStore = Output(Bool())
    val ctrlALUSrc = Output(Bool())
    val ctrlJAL = Output(Bool())
    val ctrlOP = Output(UInt(OP_TYPES_WIDTH.W))
    val ctrlSigned = Output(Bool())
}

// 用于连接寄存器模块的Bundle
class BundleReg extends Bundle {
    val rs1 = Output(UInt(REG_NUMS_LOG.W))
    val rs2 = Output(UInt(REG_NUMS_LOG.W))
    val rd = Output(UInt(REG_NUMS_LOG.W))
}