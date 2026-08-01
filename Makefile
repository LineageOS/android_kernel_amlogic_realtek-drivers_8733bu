KERNEL_SRC ?= /lib/modules/$(shell uname -r)/build
M ?= $(shell pwd)

ifeq ($(O),)
out_dir := .
else
out_dir := $(O)
endif

# Realtek ships the driver in a subdirectory; the Amlogic wifi build framework
# builds it as "rtl8733bu" with rtl8733bu_build_path = rtl8733BU.  That Makefile
# already provides "modules" (its default goal), "modules_install" and "clean",
# so the goal is forwarded unchanged.
DRIVER_DIR := rtl8733BU
DRIVER_KOS := 8733bu.ko
DRIVER_ARGS := 

modules modules_install clean:
	$(MAKE) -C $(KERNEL_SRC)/$(M)/$(DRIVER_DIR) M=$(M)/$(DRIVER_DIR) KERNEL_SRC=$(KERNEL_SRC) \
		$(DRIVER_ARGS) $(@)
	if [ -e $(out_dir)/$(M)/$(DRIVER_DIR)/Module.symvers ]; then \
		ln -sf $(out_dir)/$(M)/$(DRIVER_DIR)/Module.symvers $(out_dir)/$(M)/Module.symvers; \
	fi
	for ko in $(DRIVER_KOS); do \
		if [ -e $(out_dir)/$(M)/$(DRIVER_DIR)/$$ko ]; then \
			ln -sf $(out_dir)/$(M)/$(DRIVER_DIR)/$$ko $(out_dir)/$(M)/$$ko; \
		fi; \
	done
