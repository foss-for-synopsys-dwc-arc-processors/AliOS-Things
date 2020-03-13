##
# Copyright (c) 2020, Synopsys, Inc.
#
# SPDX-License-Identifier: Apache-2.0
##

EXTRA_PRE_BUILD_TARGETS += gen_embarc_bsp_lib
EXTRA_POST_BUILD_TARGETS += mdb_debug

export EMBARC_ROOT := ./platform/mcu/embarc/embarc_bsp
export OUT_DIR_ROOT := ./platform/mcu/embarc/embarc_bsp

EMBARC_BSP_TEST_FILE = $(EMBARC_ROOT)/arc/startup/arc_startup.s

ifeq ($(wildcard $(EMBARC_BSP_TEST_FILE)),)
$(info )
$(info )
$(info )
$(info ######################################################################################################)
$(info #                                                                                                    #)
$(info #    embarc_bsp not exist!!!                                                                         #)
$(info #    please git embarc_bsp from github                                                               #)
$(info #    run cmd blow in folder <SOURCE_ROOT>/platform/mcu/embarc:                                       #)
$(info #    git clone https://github.com/foss-for-synopsys-dwc-arc-processors/embarc_bsp.git -b upstream    #)
$(info #                                                                                                    #)
$(info ######################################################################################################)
$(info )
$(info )
$(info )
$(error [Makefile.error]: embarc_bsp not exist!!!)
endif

$(info [embarc_bsp.mk.info] EMBARC_ROOT = $(EMBARC_ROOT))
$(info [embarc_bsp.mk.info]: BOARD = $(BOARD))
$(info [embarc_bsp.mk.info]: BD_VER = $(BD_VER))
$(info [embarc_bsp.mk.info]: TOOLCHAIN = $(TOOLCHAIN))

gen_embarc_bsp_lib:
	$(info [embarc_bsp.mk.build] EMBARC_ROOT = $(EMBARC_ROOT))
	$(QUIET)$(ECHO) Making $(notdir $@)
	$(QUIET) make -r $(JOBSNO) $(SILENT) -f $(EMBARC_ROOT)/options/options.mk V=1 embarc_lib

mdb_debug:
	$(info [nsim_em.mdb_debug]: mdb_debug)
