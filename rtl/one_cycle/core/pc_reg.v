
// PC register

`include "define_core.v"

module pc_reg
#(
  parameter [`InstAddrBus] init_value
)
(
  input  wire                 clk       ,
  input  wire                 rst_n     ,
  input  wire                 jump_en   , // jump enable
  input  wire [`InstAddrBus]  jump_addr , // jump address
  output wire [`InstBus]      pc_out      // output pc address
);

reg [`InstAddrBus] pc;

always@(posedge clk or negedge rst_n) begin
  if(!rst_n) begin
    pc <= init_value;
  end
  else if(jump_en) begin
    pc <= jump_addr;
  end
  else begin
    pc <= pc + 'd4;
  end
end

endmodule


// Instantiation

/*

pc_reg
#(
  .init_value(pc_init_value)
)
pc_reg_inst
(
  .clk       (clk         ),
  .rst_n     (rst_n       ),
  .jump_en   (jump_en     ), // jump enable
  .jump_addr (jump_addr   ), // jump address
  .pc_out    (pc_out      )  // output pc address
);

*/
