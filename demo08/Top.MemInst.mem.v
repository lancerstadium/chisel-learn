module BindsTo_0_MemInst(
  input         clock,
  input  [31:0] io_addr,
  output [31:0] io_inst
);

initial begin
  $readmemh("src/test/scala/rv32isc/MemInst.hex", MemInst.mem);
end
                      endmodule

bind MemInst BindsTo_0_MemInst BindsTo_0_MemInst_Inst(.*);