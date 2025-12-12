# APB3 Slave RTL (v00.00) - Zero

A fully compliant AMBA APB3 Slave IP core with parameterized interface widths and internal memory support.

## Overview

This IP implements a complete AMBA APB3 Slave controller that acts as a simple memory storage device. The design provides a programmable base address register for flexible memory access and includes address boundary checking with error reporting.

## Features

- **Parameterized Interface Ports**: Fully configurable data, address, and control signal widths
- **Full APB3 Protocol Compliance**: Implements all required APB3 protocol states and signals
- **Internal Memory Array**: Configurable memory depth and word length
- **Programmable Base Address**: Base address register allows offset-based memory access
- **Address Boundary Checking**: PSLVERR assertion for out-of-bounds accesses
- **Granular Control**: Efficient integration with memory or specific applications
- **Asynchronous Reset Support**: Active-low asynchronous reset

## Configuration and Naming Conventions

The APB3 Slave Zero RTL uses a unique naming convention with the `APB3_SLV_` prefix to ensure no conflicts with other IPs. All configuration defines are located in `common/ip_amba_apb_slave_top_defines.vh`:

### Configuration Defines

- `APB3_SLV_PSTRB_WIDTH`: Write strobe width in bytes (default: 4)
- `APB3_SLV_PWDATA_WIDTH`: Write data width in bits (default: 8 * PSTRB_WIDTH = 32)
- `APB3_SLV_PRDATA_WIDTH`: Read data width in bits (default: 32)
- `APB3_SLV_PADDR_WIDTH`: Address width in bits (default: 32)
- `APB3_SLV_PSEL_WIDTH`: Slave select signal width (default: 1)
- `APB3_SLV_BASE_ADDR`: Default base address value (default: 1)
- `APB3_SLV_MEM_ARRAY_SIZE_INT`: Memory array size exponent (default: 2, resulting in 2^2 = 4 words)

### Parameter Declaration Macro

The module uses the `APB3_SLV_DESIGN_ATTRIBUTES` macro (defined in `common/ip_amba_apb_slave_top_parameters.vh`) for parameterized instantiation. This macro allows customization of all interface widths, memory depth, and base address during module instantiation.

## Module Interface

### Top-Level Module: `ip_amba_apb_slave_top`

#### APB3 Protocol Signals

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
- `PREADY`: Ready signal indicating transaction completion
- `PRDATA[PRDATA_width-1:0]`: Read data bus
- `PSLVERR`: Slave error response (asserted for out-of-bounds accesses)

## Memory Organization

The slave implements an internal memory array with the following characteristics:

- **Memory Depth**: Configurable via `MEM_DEPTH` parameter (default: 2^MEM_ARRAY_SIZE_INT)
- **Word Length**: Configurable via `WORD_LENGTH` parameter (default: PRDATA_width)
- **Base Address Register**: Located at address 0x0, programmable to set the lower address boundary
- **Address Mapping**: Memory access uses offset addressing relative to the base address register

### Base Address Register

The base address register provides the following functionality:

- Default value after reset: `APB_BASE_ADDR` (default: 1)
- Allows memory access using offsets relative to the programmed base address
- Out-of-bounds accesses (relative to base address) result in PSLVERR assertion
- Can be written via APB write transactions to address 0x0

## Protocol Compliance

The IP implements a standard APB3 slave interface with:

- **SETUP Phase**: Address and control signals are sampled
- **ACCESS Phase**: Data transfer occurs when PENABLE is asserted
- **PREADY Handling**: Always asserted (zero-wait-state operation)
- **Error Handling**: PSLVERR asserted for invalid address ranges

## File Structure

```
apb3_v00_00_slave_rtl_v/
├── common/
│   ├── ip_amba_apb_slave_top_defines.vh      # Configuration defines
│   └── ip_amba_apb_slave_top_parameters.vh    # Parameter declaration macro
├── top/
│   └── ip_amba_apb_slave_top.v               # Top-level module
└── README.md                                  # This file
```

## Usage Example

```verilog
`include "common/ip_amba_apb_slave_top_defines.vh"
`include "common/ip_amba_apb_slave_top_parameters.vh"

ip_amba_apb_slave_top `APB3_SLV_DESIGN_ATTRIBUTES (
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
