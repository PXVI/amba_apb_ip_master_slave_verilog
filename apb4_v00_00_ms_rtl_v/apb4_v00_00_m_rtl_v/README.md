# APB4 Master RTL (v00.00) - One

A fully compliant AMBA APB4 Master IP core with parameterized interface widths and simplified application interface.

## Overview

This IP implements a complete AMBA APB4 Master controller with a lightweight, easy-to-use application interface. The design emphasizes simplicity while maintaining full protocol compliance and efficient transaction handling.

## Features

- **Parameterized Interface Ports**: Fully configurable data, address, and control signal widths
- **Simplified Application Interface**: Easy-to-use interface for transaction initiation
- **Full APB4 Protocol Compliance**: Implements all required APB4 protocol states and signals
- **Granular Transaction Control**: Fine-grained control over transaction initiation
- **Back-to-Back Transaction Support**: Efficient handling of consecutive data transactions
- **Asynchronous Reset Support**: Active-low asynchronous reset
- **Zero-Wait-State Ready**: Application interface ready signal for immediate transaction acceptance

## Configuration and Naming Conventions

The APB4 Master One RTL uses a unique naming convention with the `APB4_MST_` prefix to ensure no conflicts with other IPs. All configuration defines are located in `common/ip_amba_apb4_m_top_defines.vh`:

### Configuration Defines

- `APB4_MST_PSEL_TIMEOUT_CYCLES`: Timeout value for PSELx signal in clock cycles (default: 20)
- `APB4_MST_PSTRB_WIDTH`: Write strobe width in bytes (default: 4)
- `APB4_MST_PWDATA_WIDTH`: Write data width in bits (default: 8 * PSTRB_WIDTH = 32)
- `APB4_MST_PRDATA_WIDTH`: Read data width in bits (default: 32)
- `APB4_MST_PADDR_WIDTH`: Address width in bits (default: 32)
- `APB4_MST_PSEL_WIDTH`: Slave select signal width (default: 1)

### Parameter Declaration Macro

The module uses the `APB4_MST_DESIGN_ATTRIBUTES` macro (defined in `common/ip_amba_apb4_m_top_parameters.vh`) for parameterized instantiation. This macro allows customization of all interface widths during module instantiation.

## Module Interface

### Top-Level Module: `ip_amba_apb4_m_top`

#### APB4 Protocol Signals

**Clock and Reset:**
- `PCLK`: APB clock input
- `PRESETn`: APB active-low reset input

**Master Outputs:**
- `PADDR[PADDR_width-1:0]`: Address bus
- `PPROT[2:0]`: Protection type
- `PSELx[PSELx_width-1:0]`: Peripheral select signal
- `PENABLE`: Enable signal for access phase
- `PWRITE`: Write/read control (1 = write, 0 = read)
- `PWDATA[PWDATA_width-1:0]`: Write data bus
- `PSTRB[PSTRB_width-1:0]`: Write strobe signals

**Master Inputs:**
- `PREADY`: Ready signal from slave
- `PRDATA[PRDATA_width-1:0]`: Read data bus from slave
- `PSLVERR`: Slave error response

#### Application Interface

**Control Inputs:**
- `vld_ap`: Valid transaction request
- `rw_ap`: Read/write control (1 = write, 0 = read)
- `addr_ap[PADDR_width-1:0]`: Transaction address
- `wdata_ap[PWDATA_width-1:0]`: Write data for write transactions
- `wstrb_ap[PSTRB_width-1:0]`: Write strobe for write transactions

**Status Outputs:**
- `rdy_ap`: Ready signal indicating when the master can accept new transactions
- `rdata_ap[PRDATA_width-1:0]`: Read data from completed read transactions
- `err_ap`: Error flag (set when PSLVERR is asserted)

## Protocol State Machine

The IP implements a standard APB4 three-state finite state machine:

1. **IDLE**: Default state, waiting for transaction request (rdy_ap = 1)
2. **SETUP**: Address and control signals are set up, PSELx is asserted (rdy_ap = 0)
3. **ACCESS**: PENABLE is asserted, waiting for PREADY from slave (rdy_ap = 0)

The state machine handles:
- Normal transaction completion
- Back-to-back transactions (when vld_ap remains asserted)
- Error responses (PSLVERR)

## Application Interface Behavior

- **rdy_ap**: Asserted in IDLE and ACCESS states, deasserted in SETUP state
- **Transaction Initiation**: When vld_ap is asserted and rdy_ap is high, transaction starts
- **Back-to-Back Transactions**: If vld_ap remains asserted after PREADY, next transaction begins immediately
- **Error Reporting**: err_ap mirrors PSLVERR signal

## File Structure

```
apb4_v00_00_m_rtl_v/
├── common/
│   ├── ip_amba_apb4_m_top_defines.vh      # Configuration defines
│   └── ip_amba_apb4_m_top_parameters.vh   # Parameter declaration macro
├── top/
│   └── ip_amba_apb4_m_top.v              # Top-level module
└── README.md                              # This file
```

## Usage Example

```verilog
`include "common/ip_amba_apb4_m_top_defines.vh"
`include "common/ip_amba_apb4_m_top_parameters.vh"

ip_amba_apb4_m_top `APB4_MST_DESIGN_ATTRIBUTES (
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
    
    // Application Interface
    .vld_ap(app_valid),
    .rw_ap(app_write),
    .addr_ap(app_addr),
    .wdata_ap(app_wdata),
    .wstrb_ap(app_strb),
    .rdy_ap(app_ready),
    .rdata_ap(app_rdata),
    .err_ap(app_error)
);
```

## License

This project is licensed under the MIT License. See individual file headers for copyright information.

Copyright (c) 2020 k-sva
