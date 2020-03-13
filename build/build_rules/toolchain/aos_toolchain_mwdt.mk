##
# Copyright (c) 2020, Synopsys, Inc.
#
# SPDX-License-Identifier: Apache-2.0
##

TOOLCHAIN_PATH ?=
TOOLCHAIN_PREFIX :=
CC      := $(TOOLCHAIN_PATH)ccac
CXX     := $(TOOLCHAIN_PATH)ccac
AS      := $(TOOLCHAIN_PATH)ccac
AR      := $(TOOLCHAIN_PATH)arac
LD      := $(TOOLCHAIN_PATH)ccac
CPP     := $(TOOLCHAIN_PATH)ccac

# OPTIONS_IN_FILE_OPTION_PREFIX_DIRECT  = $
OPTIONS_IN_FILE_OPTION_PREFIX         = @
# OPTIONS_IN_FILE_OPTION                = (file <
# OPTIONS_IN_FILE_OPTION_SUFFIX         = )
# OBJCOPYFLAGS := --bin --output=

ADD_COMPILER_SPECIFIC_STANDARD_CFLAGS   = $(1)-Hnoccm -Hnosdata -Wincompatible-pointer-types -Wno-builtin-macro-redefined -Wno-implicit-function-declaration -Hnocopyr -Hpurge
ADD_COMPILER_SPECIFIC_STANDARD_CXXFLAGS = $(1) -Hnoccm -Hnosdata -Wincompatible-pointer-types -Wno-builtin-macro-redefined -Wno-implicit-function-declaration -Hnocopyr -Hpurge
ADD_COMPILER_SPECIFIC_STANDARD_ADMFLAGS = $(1)
COMPILER_SPECIFIC_OPTIMIZED_CFLAGS     := -O0
COMPILER_SPECIFIC_UNOPTIMIZED_CFLAGS   := -Og
COMPILER_SPECIFIC_PEDANTIC_CFLAGS      := $(COMPILER_SPECIFIC_STANDARD_CFLAGS)
COMPILER_SPECIFIC_ARFLAGS_CREATE       := -rsq
COMPILER_SPECIFIC_ARFLAGS_ADD          := -rsq
COMPILER_SPECIFIC_ARFLAGS_VERBOSE      := -v

# debug: no optimize, full exception inspect and log enabled
COMPILER_SPECIFIC_DEBUG_CFLAGS         := -g $(COMPILER_SPECIFIC_OPTIMIZED_CFLAGS)
COMPILER_SPECIFIC_DEBUG_CXXFLAGS       := -g $(COMPILER_SPECIFIC_OPTIMIZED_CFLAGS)
COMPILER_SPECIFIC_DEBUG_ASFLAGS        := -g $(COMPILER_SPECIFIC_OPTIMIZED_CFLAGS) -Hnoccm -Hnosdata -Wincompatible-pointer-types -Wno-builtin-macro-redefined -Wno-implicit-function-declaration -Hnocopyr -Hpurge
COMPILER_SPECIFIC_DEBUG_LDFLAGS        :=

# inspect: optimize, full exception inspect and log enabled
COMPILER_SPECIFIC_INSPECT_CFLAGS       := -g $(COMPILER_SPECIFIC_OPTIMIZED_CFLAGS)
COMPILER_SPECIFIC_INSPECT_CXXFLAGS     := -g $(COMPILER_SPECIFIC_OPTIMIZED_CFLAGS)
COMPILER_SPECIFIC_INSPECT_ASFLAGS      := -g $(COMPILER_SPECIFIC_OPTIMIZED_CFLAGS) -Hnoccm -Hnosdata -Wincompatible-pointer-types -Wno-builtin-macro-redefined -Wno-implicit-function-declaration -Hnocopyr -Hpurge
COMPILER_SPECIFIC_INSPECT_LDFLAGS      :=

# release_log: optimize, minimal exception inspect and less log
COMPILER_SPECIFIC_RELEASE_LOG_CFLAGS   := -g $(COMPILER_SPECIFIC_OPTIMIZED_CFLAGS)
COMPILER_SPECIFIC_RELEASE_LOG_CXXFLAGS := -g $(COMPILER_SPECIFIC_OPTIMIZED_CFLAGS)
COMPILER_SPECIFIC_RELEASE_LOG_ASFLAGS  := -g $(COMPILER_SPECIFIC_OPTIMIZED_CFLAGS) -Hnoccm -Hnosdata -Wincompatible-pointer-types -Wno-builtin-macro-redefined -Wno-implicit-function-declaration -Hnocopyr -Hpurge
COMPILER_SPECIFIC_RELEASE_LOG_LDFLAGS  :=

# release: optimize, and log, cli, exception inspect disabled
COMPILER_SPECIFIC_RELEASE_CFLAGS       := -g $(COMPILER_SPECIFIC_OPTIMIZED_CFLAGS)
COMPILER_SPECIFIC_RELEASE_CXXFLAGS     := -g $(COMPILER_SPECIFIC_OPTIMIZED_CFLAGS)
COMPILER_SPECIFIC_RELEASE_ASFLAGS      := -g $(COMPILER_SPECIFIC_OPTIMIZED_CFLAGS) -Hnoccm -Hnosdata -Wincompatible-pointer-types -Wno-builtin-macro-redefined -Wno-implicit-function-declaration -Hnocopyr -Hpurge
COMPILER_SPECIFIC_RELEASE_LDFLAGS      :=

# -MD -> --dependencies xx.d
COMPILER_SPECIFIC_DEPS_FLAG                := -MMD
COMPILER_SPECIFIC_DEPS_FILE                 = -MF $(1)
COMPILER_SPECIFIC_COMP_ONLY_FLAG           := -c
COMPILER_SPECIFIC_LINK_MAP                  = -Hldopt=-Coutput=$(1) -Hldopt=-Csections -Hldopt=-Ccrossfunc -Hldopt=-Csize -zstdout -Hldopt=-Bgrouplib
COMPILER_SPECIFIC_LINK_FILES                = $(1)
COMPILER_SPECIFIC_LINK_SCRIPT_DEFINE_OPTION =
COMPILER_SPECIFIC_LINK_SCRIPT               =

LINKER                             := $(LD)
LINK_SCRIPT_SUFFIX                 := .icf
TOOLCHAIN_NAME := mwdt

ENDIAN_CFLAGS_LITTLE   := --littleend
ENDIAN_CXXFLAGS_LITTLE := --littleend
ENDIAN_ASMFLAGS_LITTLE :=
ENDIAN_LDFLAGS_LITTLE  := --littleend
CLIB_LDFLAGS_NANO      :=
CLIB_LDFLAGS_NANO_FLOAT:=

# Chip specific flags for compiler
CPU_CFLAGS     :=
CPU_CXXFLAGS   :=
CPU_ASMFLAGS   := -Hasmcpp -MMD
CPU_LDFLAGS    :=

# $(1) is map file, $(2) is CSV output file
#COMPILER_SPECIFIC_MAPFILE_TO_CSV = $(PYTHON) $(MAPFILE_PARSER) $(1) > $(2)

#TODO
#MAPFILE_PARSER            :=$(SCRIPTS_PATH)/map_parse_gcc.py

# $(1) is map file, $(2) is CSV output file
# mwdt map file format is different
# COMPILER_SPECIFIC_MAPFILE_DISPLAY_SUMMARY = $(PYTHON) $(MAPFILE_PARSER) $(1)

OBJDUMP := $(TOOLCHAIN_PATH)stripac
OBJCOPY := $(TOOLCHAIN_PATH)elf2hex

OBJCOPY_OUTPUT_PREFIX := -o
OBJCOPY_BIN_FLAGS   := -B
OBJCOPY_HEX_FLAGS   := -Q -I

STRIP   := $(TOOLCHAIN_PATH)stripac
# STRIPFLAGS := --strip --silent
#STRIP_OUTPUT_PREFIX := -o

LINK_OUTPUT_SUFFIX  :=.elf
BIN_OUTPUT_SUFFIX   :=.bin
HEX_OUTPUT_SUFFIX   :=.hex

