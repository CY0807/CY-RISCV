
// macros for core rtl


// basic
`define DataWidth 32;
`define InstWidth 32;
`define DataAddrWidth 32;
`define InstAddrWidth 32;
`define DataBus `DataWidth-1:0;
`define InstBus `InstWidth-1:0;
`define DataAddrBus `DataAddrWidth-1:0;
`define InstAddrBus `InstAddrWidth-1:0;

// pc
`define pc_init_value 0;

// mem/cache
`define mem_inst_size 1024<<3;
`define mem_data_size 1024<<3;






