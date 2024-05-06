
`include "define_core.v"

// Instruction fetch

module ifch
(
  input  wire clk,
  input  wire rst_n,
  // to inst_cache
  output wire [`InstAddrBus] rd_addr,
  input  wire [`InstBus] rd_inst,
  // in/out port
  input  wire [`InstAddrBus] pc_in,
  output wire [`InstBus] inst_out
);

assign rd_addr = pc_in;
assign inst_out = rd_inst;

endmodule

// instantiation

/*

ifch ifch_inst
(
  .clk        (clk      ),
  .rst_n      (rst_n    ),
  // to inst_cache
  .rd_addr    (rd_addr  ),
  .rd_inst    (rd_inst  ),
  // in/out port
  .pc_in      (pc_in    ),
  .inst_out   (inst_out )
);

*/

