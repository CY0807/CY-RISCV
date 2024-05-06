include common.mk

CLEAN_DIR := $(shell cd sim; ls)
BIN ?= simple
CORE ?= tinyriscv_original

run:
	@cd tests/example/$(BIN); make
	@cd sim/$(CORE); make BIN=$(ROOT_DIR)/tests/example/$(BIN)/build/$(BIN).bin

clean:
	@cd tests/isa; make clean
	@cd tests/example; make clean
	@for dir in $(CLEAN_DIR); do \
        cd sim/$$dir; make clean; \
    done

isa:
	@cd tests/isa; make
	
MAKE_TEST:
	@echo $(CLEAN_DIR)

autopush:
	@git add .; git commit -m "auto commit"; git push -u gitee develop; git push -u github develop

push:
	@git push -u gitee develop;git push -u github develop

.PHONY := clean isa MAKE_TEST autopush push run
.DEFAULT_GOAL := run
