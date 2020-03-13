/*
 * Copyright (c) 2020, Synopsys, Inc.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef K_COMPILER_H
#define K_COMPILER_H

#define RHINO_INLINE                static inline
/* get the return address of the current function
   void * __builtin_return_address (unsigned int level) */
#define RHINO_GET_RA()              __builtin_return_address(0)
/* get the return address of the current function */
__attribute__((always_inline)) RHINO_INLINE void *RHINO_GET_SP(void)
{
    void *stack_point;
    asm volatile("mov %0, %%sp\n" : "=r" (stack_point));
    return stack_point;
}
/* get the number of leading 0-bits in x
   int __builtin_clz (unsigned int x) */
//#define RHINO_BIT_CLZ(x)            __builtin_clz(x)

#ifndef RHINO_WEAK
#define RHINO_WEAK                  __attribute__((weak))
#endif

#ifndef RHINO_ASM
#define RHINO_ASM                   __asm__
#endif

#endif /* K_COMPILER_H */
