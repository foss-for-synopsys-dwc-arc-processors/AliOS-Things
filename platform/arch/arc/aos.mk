##
# Copyright (c) 2020, Synopsys, Inc.
#
# SPDX-License-Identifier: Apache-2.0
##

NAME := arch_arc

$(NAME)_MBINS_TYPE := kernel
$(NAME)_VERSION    := 1.0.0
$(NAME)_SUMMARY    := arch for arc

$(NAME)_SOURCES := port_s.s
$(NAME)_SOURCES += port_c.c

$(NAME)_INCLUDES += .

GLOBAL_INCLUDES += include

# $(info [arc_arc.info]: GLOBAL_INCLUDES = $(GLOBAL_INCLUDES))
