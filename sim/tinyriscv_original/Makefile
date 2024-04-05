include ../../common.mk

CORE := $(basename $(notdir $(shell pwd)))
BIN_NAME = $(basename $(notdir $(BIN)))

# DIRs
BUILD_DIR := $(shell pwd)/build
RTL_DIR := $(ROOT_DIR)/rtl/$(CORE)
TB_DIR := $(ROOT_DIR)/tb/$(CORE)
ISA_DIR := $(ROOT_DIR)/tests/isa

# TARGETs
IS_COMPIANCE_TEST := 0
BIN ?= $(ROOT_DIR)/tests/isa/generated/rv32ui-p-add.bin
ISA_BIN := $(shell find $(ISA_DIR)/generated/ -name *.bin)
INST := $(BUILD_DIR)/$(BIN_NAME).inst
VVP := $(BUILD_DIR)/$(BIN_NAME).vvp
VCD := $(BUILD_DIR)/$(BIN_NAME).vcd
LOG := $(BUILD_DIR)/$(BIN_NAME).log
INST_LOG := $(BUILD_DIR)/$(BIN_NAME).inst_log

# SRCs
RTL_SRC := $(shell find $(RTL_DIR) -name *.v)
TB_SRC ?= $(TB_DIR)/tinyriscv_soc_tb.v

# iverilog cmd configurations
I_FLAG := -I $(RTL_DIR)/core
O_FLAG := -o $(VVP)
D_FLAG := -DINST=\"$(INST)\"
D_FLAG += -DCOUT=\"$(BUILD_DIR)/ctest.output\"
D_FLAG += -DLOG=\"$(LOG)\"
D_FLAG += -DVCD=\"$(VCD)\"
D_FLAG += -DINST_LOG=\"$(INST_LOG)\"


# TOOLs
BIN2INST := $(ROOT_DIR)/tools/BinToMem_CLI.py

# inst data in ROM for RTL verilog
$(INST):
	@mkdir -p build
	@python $(BIN2INST) $(BIN) $(INST)

# from rtl to vvp
$(VVP):$(INST)
	@mkdir -p build
	@echo compiling vvp
	@iverilog $(O_FLAG) $(I_FLAG) $(D_FLAG) $(TB_SRC) $(RTL_SRC)

# vvp files to vcd wave file
$(VCD):$(VVP)
	@echo
	@echo "********************************"
	@echo BIN : $(BIN)
	@echo CORE: $(CORE)
	@echo "********************************"
	@echo
	@mkdir -p build
	@echo generating vcd file
	@vvp $(VVP) | tee $(LOG)

# test all isa
ISA:
ifeq (ISA_BIN,)
	$(warning Making ISA bin files)
	@cd $(ISA_DIR); make
endif
	@for bin in $(ISA_BIN); do \
	    ./test_all_isa.sh $$bin; \
    done
	@make clean

# compliance test
CTEST:
	@make \
        BIN=$(ROOT_DIR)/tests/riscv-compliance/build_generated/rv32i/I-ADD-01.elf.bin \
        TB_SRC=$(TB_DIR)/compliance_test/tinyriscv_soc_tb.v
	@python compliance_test.py \
        $(ROOT_DIR)/tests/riscv-compliance/build_generated/rv32i/I-ADD-01.elf.bin \
        $(ROOT_DIR) \
        $(BUILD_DIR)/ctest.output

# clean and make agian
rebuild:
	@make clean
	@make

# show make output
show:
	@make clean
	@make
	@make clean

clean:
	@rm -rf $(BUILD_DIR)

# used for Makefile debug
MAKE_TEST:
	$(D_FLAG)

.PHONY := ISA clean MAKE_TEST CTEST rebuild show
.DEFAULT_GOAL := $(VCD)

