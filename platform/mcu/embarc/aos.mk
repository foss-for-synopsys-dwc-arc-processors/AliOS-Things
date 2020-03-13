##
# Copyright (c) 2020, Synopsys, Inc.
#
# SPDX-License-Identifier: Apache-2.0
##

NAME := mcu_embarc

HOST_OPENOCD := synopsys_arc_embarc

$(NAME)_MBINS_TYPE := kernel
$(NAME)_VERSION    := 1.0.1
$(NAME)_SUMMARY    := driver & sdk for Synopsys ARC processors

$(NAME)_COMPONENTS += arch_arc

$(NAME)_SOURCES := hal/hal_uart.c

$(info [embarc.aos.info]: BOARD = $(BOARD))
$(info [embarc.aos.info]: BD_VER = $(BD_VER))

CURRENT_PATH := $($(NAME)_LOCATION)

EMBARC_OUT_DIR = embarc_bsp/obj_$(BOARD)_$(BD_VER)/$(TOOLCHAIN)_$(CUR_CORE)

$(info [embarc.aos.info]: EMBARC_OUT_DIR = $(EMBARC_OUT_DIR))

GCC_ARG := ./platform/mcu/embarc/$(EMBARC_OUT_DIR)/embARC_generated/gcc.arg
CCAC_ARG := ./platform/mcu/embarc/$(EMBARC_OUT_DIR)/embARC_generated/ccac.arg
GCC_LDF_FILE := ./platform/mcu/embarc/$(EMBARC_OUT_DIR)/linker_gnu.ldf
CCAC_LDF_FILE := ./platform/mcu/embarc/$(EMBARC_OUT_DIR)/linker_mw.ldf

GLOBAL_INCLUDES += embarc_bsp/board/nsim/configs/10
GLOBAL_INCLUDES += $(EMBARC_OUT_DIR)/embARC_generated
GLOBAL_INCLUDES += embarc_bsp
GLOBAL_INCLUDES += embarc_bsp/board
GLOBAL_INCLUDES += embarc_bsp/include
GLOBAL_INCLUDES += embarc_bsp/include/device/designware
GLOBAL_INCLUDES += embarc_bsp/include/device/subsystem
GLOBAL_INCLUDES += embarc_bsp/library

ifeq ($(COMPILER),mwdt)
GLOBAL_CFLAGS += @$(CCAC_ARG)
GLOBAL_CXXFLAGS += @$(CCAC_ARG)
GLOBAL_ASMFLAGS += @$(CCAC_ARG)
GLOBAL_LDFLAGS += @$(CCAC_ARG) -Hpurge -Hnocopyr -Hnosdata -Hnocrt $(CCAC_LDF_FILE)
else
GLOBAL_CFLAGS += @$(GCC_ARG)
GLOBAL_CXXFLAGS += @$(GCC_ARG)
GLOBAL_ASMFLAGS += @$(GCC_ARG)
GLOBAL_LDFLAGS += @$(GCC_ARG) -Wl,--script=$(GCC_LDF_FILE)
endif


$(NAME)_PREBUILT_LIBRARY := $(EMBARC_OUT_DIR)/board/board.o
$(NAME)_PREBUILT_LIBRARY += $(EMBARC_OUT_DIR)/arc/startup/arc_startup.o
$(NAME)_PREBUILT_LIBRARY += $(EMBARC_OUT_DIR)/arc/startup/arc_cxx_support.o
$(NAME)_PREBUILT_LIBRARY += $(EMBARC_OUT_DIR)/libboard_nsim.a
$(NAME)_PREBUILT_LIBRARY += $(EMBARC_OUT_DIR)/libcpuarc.a
$(NAME)_PREBUILT_LIBRARY += $(EMBARC_OUT_DIR)/libembarc_libc.a
$(NAME)_PREBUILT_LIBRARY += $(EMBARC_OUT_DIR)/libembarc_console.a

EXTRA_TARGET_MAKEFILES +=  $(CURRENT_PATH)/embarc_bsp.mk
