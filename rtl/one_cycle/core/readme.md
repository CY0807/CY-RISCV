
This is a one-cycle RISC-V core

# 1. Contents:

core/
│
├─ define_core.v: Macros for this core
│
├─ pc_reg.v: PC register and its logic
│
├─ if.v: Instruction fetch from instruction cache
│
├─ id.v: Instruction decode
│
├─ ex.v: Execute instruction
│
├─ wr_mem.v: load or store datas with data cache
│
├─ wb.v: Write back (to register file)
│
├─ reg_file.v: Regsigter file
│
├─ inst_mem.v: latches cache, 0 clock delay for R&W
│
├─ data_mem.v: same as inst_cache
