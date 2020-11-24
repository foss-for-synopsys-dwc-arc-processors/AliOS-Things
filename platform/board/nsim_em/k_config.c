/*
 * Copyright (c) 2020, Synopsys, Inc.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <k_api.h>
#include <assert.h>
#include <stdio.h>
#include <sys/time.h>

void hal_reboot(void)
{
    printf("hal reboot\r\n");
}

#if (RHINO_CONFIG_HW_COUNT > 0)
void soc_hw_timer_init(void)
{
}

hr_timer_t soc_hr_hw_cnt_get(void)
{
    return 0;
    //return *(volatile uint64_t *)0xc0000120;
}

lr_timer_t soc_lr_hw_cnt_get(void)
{
    return 0;
}
#endif /* RHINO_CONFIG_HW_COUNT */

#if (RHINO_CONFIG_INTRPT_STACK_OVF_CHECK > 0)
void soc_intrpt_stack_ovf_check(void)
{
}
#endif

#if (RHINO_CONFIG_MM_TLF > 0)

#define       AOS_HEAP_BUFFER_SIZE (200*1024)
uint8_t       aos_heap_buffer[AOS_HEAP_BUFFER_SIZE];
k_mm_region_t g_mm_region[1];
int           g_region_num = 1;

void aos_heap_set()
{
    g_mm_region[0].start = aos_heap_buffer;
    g_mm_region[0].len   = AOS_HEAP_BUFFER_SIZE;
}

#endif

#if (RHINO_CONFIG_TASK_STACK_CUR_CHECK > 0)
size_t soc_get_cur_sp()
{
    size_t sp = 0;
#if defined (__GNUC__)&&!defined(__CC_ARM)
    asm volatile(
        "mov %0,sp\n"
        :"=r"(sp));
#endif
    return sp;
}
static void soc_print_stack()
{
    void    *cur, *end;
    int      i=0;
    int     *p;

    end   = krhino_cur_task_get()->task_stack_base + krhino_cur_task_get()->stack_size;
    cur = (void *)soc_get_cur_sp();
    p = (int*)cur;
    while(p < (int*)end) {
        if(i%4==0) {
            printf("\r\n%08x:",(uint32_t)p);
        }
        printf("%08x ", *p);
        i++;
        p++;
    }
    printf("\r\n");
    return;
}
#endif

void soc_err_proc(kstat_t err)
{
    (void)err;
    printf("soc_err_proc %d \r\n", err);
    //krhino_backtrace_now();
    #if (RHINO_CONFIG_TASK_STACK_CUR_CHECK > 0)
    //soc_print_stack();
    #endif
    while(1);
}

krhino_err_proc_t g_err_proc = soc_err_proc;


/**
* krhino hook for k_hook.h
* -- start
*/
#if (RHINO_CONFIG_USER_HOOK > 0)
void krhino_idle_hook(void)
{
}

void krhino_init_hook(void)
{
#if (RHINO_CONFIG_HW_COUNT > 0)
    soc_hw_timer_init();
#endif
}

void krhino_start_hook(void)
{
#if (RHINO_CONFIG_SYS_STATS > 0)
    krhino_task_sched_stats_reset();
#endif
}

void krhino_task_create_hook(ktask_t *task)
{
    (void)task;
}

void krhino_task_del_hook(ktask_t *task, res_free_t *arg)
{
    (void)task;
    (void)arg;
}

void krhino_task_switch_hook(ktask_t *orgin, ktask_t *dest)
{
    (void)orgin;
    (void)dest;
    //printf("task_switch from [%s] to [%s]\r\n", orgin->task_name, dest->task_name);
}

void krhino_tick_hook(void)
{
}

void krhino_task_abort_hook(ktask_t *task)
{
    (void)task;
}

void krhino_mm_alloc_hook(void *mem, size_t size)
{
    (void)mem;
    (void)size;
}

void krhino_idle_pre_hook(void)
{
}
#endif
/**
* krhino hook for k_hook.h
* -- end
*/
