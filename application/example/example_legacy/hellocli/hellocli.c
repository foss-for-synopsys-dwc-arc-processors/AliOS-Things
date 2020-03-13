/*
 * Copyright (c) 2020, Synopsys, Inc.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <stdio.h>

#include <aos/kernel.h>

int application_start(int argc, char *argv[])
{
    printf("hello cli entry here!\r\n");

    while(1) {
        aos_msleep(1000);
    };
}
