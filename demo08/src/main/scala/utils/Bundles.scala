package utils

import chisel3._

import config.Configs._
import utils.OP_TYPES._
import utils.LS_TYPES._

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
    val ctrlLSType = Output(UInt(LS_TYPES_WIDTH.W))
}

// 用于连接寄存器模块的Bundle
class BundleReg extends Bundle {
    val rs1 = Output(UInt(REG_NUMS_LOG.W))
    val rs2 = Output(UInt(REG_NUMS_LOG.W))
    val rd = Output(UInt(REG_NUMS_LOG.W))
}

// 用于连接存储器模块的Bundle
class BundleMemDataControl extends Bundle {
    val ctrlLoad = Input(Bool())
    val ctrlStore = Input(Bool())
    val ctrlSigned = Input(Bool())
    val ctrlLSType = Input(UInt(LS_TYPES_WIDTH.W))
}

// 用于连接ALU模块的Bundle
class BundleAluControl extends Bundle {
    val ctrlALUSrc = Input(Bool())
    val ctrlJAL = Input(Bool())
    val ctrlOP = Input(UInt(OP_TYPES_WIDTH.W))
    val ctrlSigned = Input(Bool())
    val ctrlBranch = Input(Bool())
}