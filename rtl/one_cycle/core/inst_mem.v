
`include "define_core.v"

module inst_mem
(
  input  wire                 clk     ,
  input  wire                 rst_n   ,
  input  wire [`InstAddrBus]  rd_addr ,
  output wire [`InstBus]      rd_inst
);

reg [`InstBus] mem_inst [`mem_inst_size-1:0];

always@(*) begin
  rd_inst <= mem_inst[rd_addr];
end

endmodule

// Instantiation

/*

inst_mem inst_mem_inst
(
  .clk     (clk     ),
  .rst_n   (rst_n   ),
  .rd_addr (rd_addr ),
  .rd_inst (rd_inst )
);


*/
