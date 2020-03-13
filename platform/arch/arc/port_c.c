/*
 * Copyright (c) 2020, Synopsys, Inc.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <k_api.h>
#include "arc/arc_exception.h"

#if ARC_FEATURE_STACK_CHECK
#define ARC_INIT_STATUS ((1 << AUX_STATUS_BIT_SC) | AUX_STATUS_MASK_IE | ((-1 - INT_PRI_MIN) << 1) | STATUS32_RESET_VALUE)
#else
#define ARC_INIT_STATUS (AUX_STATUS_MASK_IE | ((-1 - INT_PRI_MIN) << 1) | STATUS32_RESET_VALUE)
#endif

extern void start_r(void);

uint32_t g_context_switch_reqflg;
uint32_t g_exc_nest_count;

struct init_stack_frame {
    uint32_t pc;
    uint32_t blink;
    uint32_t task;
    uint32_t status32;
    uint32_t r0;
};

void *cpu_task_stack_init(cpu_stack_t *stack_base, size_t stack_size,
                          void *arg, task_entry_t entry)
{
    struct init_stack_frame *stack_frame;
    cpu_stack_t *stk;

    uint32_t temp = (uint32_t)(stack_base + stack_size);
    /* stack aligned by 8 byte */
    temp &= 0xfffffffc;
    stk = (cpu_stack_t *)temp;

    stk -= sizeof(struct init_stack_frame);

    stack_frame = (struct init_stack_frame *)stk;

    stack_frame->pc = (uint32_t)start_r;
    stack_frame->blink = (uint32_t)krhino_task_deathbed;
    stack_frame->task = (uint32_t)entry;
    stack_frame->status32 = ARC_INIT_STATUS;
	stack_frame->r0 = (uint32_t)arg;

    return stk;
}

void set_hw_stack_check(ktask_t *from, ktask_t *to)
{
	if (to != NULL) {
#if ARC_FEATURE_SEC_PRESENT
		arc_aux_write(AUX_S_KSTACK_TOP, (uint32_t)(to->task_stack_base));
		arc_aux_write(AUX_S_KSTACK_BASE, (uint32_t)(to->task_stack_base + to->stack_size);
#else
		arc_aux_write(AUX_KSTACK_TOP, (uint32_t)(to->task_stack_base));
		arc_aux_write(AUX_KSTACK_BASE, (uint32_t)(to->task_stack_base + to->stack_size));
#endif
	}
}
