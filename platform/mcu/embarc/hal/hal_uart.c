/*
 * Copyright (c) 2020, Synopsys, Inc.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <stdio.h>
#include <stdint.h>
#include "aos/hal/uart.h"
#include "k_api.h"
#include "embARC.h"

int32_t hal_uart_send(uart_dev_t *uart, const void *data, uint32_t size, uint32_t timeout)
{
    DEV_UART_PTR embarc_uart;
    int ret;

    embarc_uart = uart_get_dev(uart->port);

    if (embarc_uart == NULL)
    {
        return -1;
    }

    ret = embarc_uart->uart_write(data, size);

    if (ret < 0) {
        return -1;
    } else {
        return 0;
    }
}

int32_t hal_uart_recv_II(uart_dev_t *uart, void *data, uint32_t expect_size,
                      uint32_t *recv_size, uint32_t timeout)
{
    DEV_UART_PTR embarc_uart;
    int ret, rx_count;

    embarc_uart = uart_get_dev(uart->port);

    if (embarc_uart == NULL)
    {
        return -1;
    }

    rx_count = embarc_uart->uart_read(data, expect_size);

    if(recv_size)
    {
        *recv_size = rx_count;
    }

    if(rx_count != 0)
    {
        ret = 0;
    }
    else
    {
        ret = -1;
    }

    return ret;
}

int32_t hal_uart_init(uart_dev_t *uart)
{
    int32_t ret = 0;
    DEV_UART_PTR embarc_uart;

    embarc_uart = uart_get_dev(uart->port);

    if (uart == NULL)
    {
        return -1;
    }

    /* default format: 8bits, no parity, 1 stop bits */
    ret = embarc_uart->uart_open(uart->config.baud_rate);

    if (ret != E_OPNED && ret != E_OK) {
        return -1;
    }

    ret = 0;
    return ret;
}

int32_t hal_uart_finalize(uart_dev_t *uart)
{
    return 0;
}
