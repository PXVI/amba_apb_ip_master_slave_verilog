# APB4 Slave RTL (v00.00) - One

A fully compliant AMBA APB4 Slave IP core with parameterized interface widths and internal memory support.

## Overview

This IP implements a complete AMBA APB4 Slave controller with an internal memory array. The design provides a simple, configurable memory interface that is fully compliant with the APB4 protocol specification.

## Features

- **Parameterized Interface Ports**: Fully configurable data, address, and control signal widths
- **Full APB4 Protocol Compliance**: Implements all required APB4 protocol states and signals
- **Internal Memory Array**: Configurable memory depth and word length
- **Byte-Level Write Support**: Write strobe (PSTRB) support for byte-level writes
- **Zero-Wait-State Operation**: Always-ready operation for maximum throughput
- **Asynchronous Reset Support**: Active-low asynchronous reset

## Configuration and Naming Conventions

The APB4 Slave One RTL uses a unique naming convention with the `APB4_SLV_` prefix to ensure no conflicts with other IPs. All configuration defines are located in `common/ip_amba_apb4_s_top_defines.vh`:

### Configuration Defines

- `APB4_SLV_PSTRB_WIDTH`: Write strobe width in bytes (default: 4)
- `APB4_SLV_PWDATA_WIDTH`: Write data width in bits (default: 8 * PSTRB_WIDTH = 32)
- `APB4_SLV_PRDATA_WIDTH`: Read data width in bits (default: 32)
- `APB4_SLV_PADDR_WIDTH`: Address width in bits (default: 32)
- `APB4_SLV_PSEL_WIDTH`: Slave select signal width (default: 1)
- `APB4_SLV_MEM_ARRAY_SIZE_INT`: Memory array size exponent (default: 2, resulting in 2^2 = 4 words)
- `APB4_SLV_DEV_BASE_ADDRESS`: Device base address (default: 32'h0)

### Parameter Declaration Macro

The module uses the `APB4_SLV_DESIGN_ATTRIBUTES` macro (defined in `common/ip_amba_apb4_s_top_parameters.vh`) for parameterized instantiation. This macro allows customization of all interface widths, memory depth, and base address during module instantiation.

## Module Interface

### Top-Level Module: `ip_amba_apb4_s_top`

#### APB4 Protocol Signals

**Clock and Reset:**
- `PCLK`: APB clock input
- `PRESETn`: APB active-low reset input

**Slave Inputs:**
- `PADDR[PADDR_width-1:0]`: Address bus
- `PPROT[2:0]`: Protection type
- `PSELx[PSELx_width-1:0]`: Peripheral select signal
- `PENABLE`: Enable signal for access phase
- `PWRITE`: Write/read control (1 = write, 0 = read)
- `PWDATA[PWDATA_width-1:0]`: Write data bus
- `PSTRB[PSTRB_width-1:0]`: Write strobe signals

**Slave Outputs:**
- `PREADY`: Ready signal indicating transaction completion (always asserted)
- `PRDATA[PRDATA_width-1:0]`: Read data bus
- `PSLVERR`: Slave error response (currently not used, defaults to 0)

## Memory Organization

The slave implements an internal memory array with the following characteristics:

- **Memory Depth**: Configurable via `MEM_DEPTH` parameter (default: 2^MEM_ARRAY_SIZE_INT)
- **Word Length**: Configurable via `WORD_LENGTH` parameter (default: PRDATA_width)
- **Byte-Level Writes**: Write strobe (PSTRB) allows selective byte writes within a word
- **Direct Addressing**: Memory accessed directly via PADDR

### Write Operation

- Each byte within a word can be selectively written using PSTRB
- PSTRB[i] = 1 enables write to byte i of the word
- Write data is masked with PSTRB before being written to memory

### Read Operation

- Complete word is read from memory location specified by PADDR
- Read data is available on PRDATA in the ACCESS phase

## Protocol Compliance

The IP implements a standard APB4 slave interface with:

- **SETUP Phase**: Address and control signals are sampled
- **ACCESS Phase**: Data transfer occurs when PENABLE is asserted
- **PREADY Handling**: Always asserted (zero-wait-state operation)
- **Error Handling**: PSLVERR currently defaults to 0 (can be extended for address validation)

## File Structure

```
apb4_v00_00_s_rtl_v/
├── common/
│   ├── ip_amba_apb4_s_top_defines.vh      # Configuration defines
│   └── ip_amba_apb4_s_top_parameters.vh    # Parameter declaration macro
├── top/
│   └── ip_amba_apb4_s_top.v               # Top-level module
└── README.md                               # This file
```

## Usage Example

```verilog
`include "common/ip_amba_apb4_s_top_defines.vh"
`include "common/ip_amba_apb4_s_top_parameters.vh"

ip_amba_apb4_s_top `APB4_SLV_DESIGN_ATTRIBUTES (
    // APB Interface
    .PCLK(clk),
    .PRESETn(rstn),
    .PADDR(apb_addr),
    .PPROT(apb_prot),
    .PSELx(apb_sel),
    .PENABLE(apb_enable),
    .PWRITE(apb_write),
    .PWDATA(apb_wdata),
    .PSTRB(apb_strb),
    .PREADY(slave_ready),
    .PRDATA(slave_rdata),
    .PSLVERR(slave_error)
);
```

## License

This project is licensed under the MIT License. See individual file headers for copyright information.

Copyright (c) 2020 k-sva
