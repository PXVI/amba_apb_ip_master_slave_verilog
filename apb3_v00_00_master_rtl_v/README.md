# APB3 Master RTL (v00.00) - Zero

A fully compliant AMBA APB3 Master IP core with parameterized interface widths and comprehensive transaction control capabilities.

## Overview

This IP implements a complete AMBA APB3 Master controller that provides a generic CPU/application interface for easy integration into system-on-chip designs. The design emphasizes granular user control over transaction initiation while maintaining full protocol compliance.

## Features

- **Parameterized Interface Ports**: Fully configurable data, address, and control signal widths
- **Generic Application Interface**: Easy-to-use CPU-side interface for transaction initiation
- **Programmable PSELx Timeout**: Configurable timeout mechanism for slave response detection (hardcoded default value)
- **Full APB3 Protocol Compliance**: Implements all required APB3 protocol states and signals
- **Granular Transaction Control**: Fine-grained control over transaction initiation and timing
- **Back-to-Back Transaction Support**: Efficient handling of consecutive data transactions
- **Asynchronous Reset Support**: Active-low asynchronous reset for both APB and CPU interfaces

## Configuration and Naming Conventions

The APB3 Master Zero RTL uses a unique naming convention with the `APB3_MST_` prefix to ensure no conflicts with other IPs. All configuration defines are located in `common/ip_amba_apb_top_defines.vh`:

### Configuration Defines

- `APB3_MST_PSEL_TIMEOUT_CYCLES`: Timeout value for PSELx signal in clock cycles (default: 20)
- `APB3_MST_PSTRB_WIDTH`: Write strobe width in bytes (default: 4)
- `APB3_MST_PWDATA_WIDTH`: Write data width in bits (default: 8 * PSTRB_WIDTH = 32)
- `APB3_MST_PRDATA_WIDTH`: Read data width in bits (default: 32)
- `APB3_MST_PADDR_WIDTH`: Address width in bits (default: 32)
- `APB3_MST_PSEL_WIDTH`: Slave select signal width (default: 1)

### Parameter Declaration Macro

The module uses the `APB3_MST_DESIGN_ATTRIBUTES` macro (defined in `common/ip_amba_apb_top_parameters.vh`) for parameterized instantiation. This macro allows customization of all interface widths during module instantiation.

## Module Interface

### Top-Level Module: `ip_amba_apb_master_top`

#### APB3 Protocol Signals

**Clock and Reset:**
- `PCLK`: APB clock input
- `PRESETn`: APB active-low reset input

**Master Outputs:**
- `PADDR[PADDR_width-1:0]`: Address bus
- `PPROT[2:0]`: Protection type (currently hardcoded to 0)
- `PSELx[PSELx_width-1:0]`: Peripheral select signal
- `PENABLE`: Enable signal for access phase
- `PWRITE`: Write/read control (1 = write, 0 = read)
- `PWDATA[PWDATA_width-1:0]`: Write data bus
- `PSTRB[PSTRB_width-1:0]`: Write strobe signals

**Master Inputs:**
- `PREADY`: Ready signal from slave
- `PRDATA[PRDATA_width-1:0]`: Read data bus from slave
- `PSLVERR`: Slave error response

#### CPU/Application Interface

**Control Inputs:**
- `from_cpu_resetn`: CPU-side active-low reset
- `from_cpu_valid_txn`: Valid transaction request
- `from_cpu_rd_wr`: Read/write control (1 = write, 0 = read)
- `from_cpu_address[PADDR_width-1:0]`: Transaction address
- `from_cpu_wr_STRB[PSTRB_width-1:0]`: Write strobe for write transactions
- `from_cpu_wr_WDATA[PWDATA_width-1:0]`: Write data for write transactions
- `from_cpu_slave_sel`: Slave select signal

**Status Outputs:**
- `apb_ready_for_txn`: Indicates when the master is ready to accept new transactions
- `to_cpu_RDATA[PRDATA_width-1:0]`: Read data from completed read transactions
- `to_cpu_RDATA_valid_WDATA_done`: Valid signal for read data or write completion
- `to_cpu_txn_err`: Transaction error flag (set when PSLVERR is asserted)
- `to_cpu_txn_timeout`: Timeout flag (set when PSELx timeout occurs)

## Protocol State Machine

The IP implements a standard APB3 three-state finite state machine:

1. **IDLE**: Default state, waiting for transaction request
2. **SETUP**: Address and control signals are set up, PSELx is asserted
3. **ACCESS**: PENABLE is asserted, waiting for PREADY from slave

The state machine handles:
- Normal transaction completion
- Back-to-back transactions
- Error responses (PSLVERR)
- Timeout conditions

## Timeout Mechanism

The IP includes a configurable timeout counter that monitors the PSELx signal. If a slave does not respond with PREADY within the configured timeout period, the transaction is aborted and the `to_cpu_txn_timeout` signal is asserted. The timeout value is controlled by the `APB3_MST_PSEL_TIMEOUT_CYCLES` define.

## File Structure

```
apb3_v00_00_master_rtl_v/
├── common/
│   ├── ip_amba_apb_top_defines.vh      # Configuration defines
│   └── ip_amba_apb_top_parameters.vh    # Parameter declaration macro
├── top/
│   └── ip_amba_apb_master_top.v        # Top-level module
└── README.md                            # This file
```

## Usage Example

```verilog
`include "common/ip_amba_apb_top_defines.vh"
`include "common/ip_amba_apb_top_parameters.vh"

ip_amba_apb_master_top `APB3_MST_DESIGN_ATTRIBUTES (
    // APB Interface
    .PCLK(clk),
    .PRESETn(rstn),
    .PREADY(slave_ready),
    .PRDATA(slave_rdata),
    .PSLVERR(slave_error),
    .PADDR(apb_addr),
    .PPROT(apb_prot),
    .PSELx(apb_sel),
    .PENABLE(apb_enable),
    .PWRITE(apb_write),
    .PWDATA(apb_wdata),
    .PSTRB(apb_strb),
    
    // CPU Interface
    .from_cpu_resetn(cpu_rstn),
    .from_cpu_valid_txn(cpu_valid),
    .from_cpu_rd_wr(cpu_write),
    .from_cpu_address(cpu_addr),
    .from_cpu_wr_STRB(cpu_strb),
    .from_cpu_wr_WDATA(cpu_wdata),
    .from_cpu_slave_sel(cpu_sel),
    .apb_ready_for_txn(ready),
    .to_cpu_RDATA(cpu_rdata),
    .to_cpu_RDATA_valid_WDATA_done(cpu_valid_out),
    .to_cpu_txn_err(cpu_error),
    .to_cpu_txn_timeout(cpu_timeout)
);
```

## License

This project is licensed under the MIT License. See individual file headers for copyright information.

Copyright (c) 2020 k-sva
