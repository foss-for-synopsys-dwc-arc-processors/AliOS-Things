/*
 * Copyright (c) 2020, Synopsys, Inc.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <k_api.h>
#include <stdio.h>
#include <stdlib.h>

#include "aos/init.h"
#include "embARC.h"
#include "arc/arc_timer.h"
#include "arc/arc_exception.h"

/*
main task stask size(byte)
*/
#define OS_MAIN_TASK_STACK 1024
#define OS_MAIN_TASK_PRI 32

/*  For user config
    kinit.argc = 0;
    kinit.argv = NULL;
    kinit.cli_enable = 1;
*/
static kinit_t kinit = {0, NULL, 1};
static ktask_t *g_main_task;

extern void aos_heap_set();

#ifndef AOS_BINS
extern int application_start(int argc, char **argv);
#endif

static void sys_init(void)
{
    aos_components_init(&kinit);

    #ifndef AOS_BINS
    application_start(kinit.argc, kinit.argv);  /* jump to app/example entry */
    #endif
}

static void aos_hw_timer_isr(int vector, void *param)
{
    arc_timer_int_clear(BOARD_OS_TIMER_ID);
//    krhino_intrpt_enter();
    krhino_tick_proc();
//    krhino_intrpt_exit();
}

int aos_hw_timer_init(void)
{

    unsigned int cyc = BOARD_CPU_CLOCK / RHINO_CONFIG_TICKS_PER_SECOND;

    int_disable(BOARD_OS_TIMER_INTNO); /* disable os timer interrupt */
    arc_timer_stop(BOARD_OS_TIMER_ID);
    arc_timer_start(BOARD_OS_TIMER_ID, TIMER_CTRL_IE | TIMER_CTRL_NH, cyc);

    int_handler_install(BOARD_OS_TIMER_INTNO, (INT_HANDLER_T)aos_hw_timer_isr);
    int_pri_set(BOARD_OS_TIMER_INTNO, INT_PRI_MIN + 1); /* currently, firq(INT_PRI_MIN) not supported*/
    int_enable(BOARD_OS_TIMER_INTNO);

    return 0;
}

int main(void)
{
    aos_hw_timer_init();
    /*mm heap set*/
    aos_heap_set();
    /*kernel init, malloc can use after this!*/
    krhino_init();

    /*main task to run */
    krhino_task_dyn_create(&g_main_task, "main_task", 0, OS_MAIN_TASK_PRI, 0, OS_MAIN_TASK_STACK, (task_entry_t)sys_init, 1);

    /*kernel start schedule!*/
    krhino_start();

    /*never run here*/
    return 0;
}
