# ip_amba_apb_ms_rtl_v

This repository houses various AMBA APB master and slave protocol IPs. The protocol version which is supported by the RTLs is **Arm's AMBA3** open standard protocol.

The reason for adding version numbers for the IP is that the RTL is functionally stable in every aspect, but will need more user specific features in the future and if a new feature is added; it will be provided as a stand alone IP built over the existing one.

## Contents of the repository

### APB3 Master Zero ( v00.00 )

Located in: `apb3_v00_00_master_rtl_v/`

- Generic application interface
- Heavy user control for transaction initiations
- Parameterized interface port widths
- Fully compliant with the APB3 protocol
- Complete granular support for interfacing with any kind of bridge
- Additional support for the protocol timeout timers

#### Configuration and Naming Conventions

The APB3 Master Zero RTL uses a unique naming convention with the `APB3_MST_` prefix to ensure no conflicts with other IPs. The following configuration defines are available in `common/ip_amba_apb_top_defines.vh`:

- `APB3_MST_PSEL_TIMEOUT_CYCLES`: Timeout value for PSELx signal (default: 20 clock cycles)
- `APB3_MST_PSTRB_WIDTH`: Write strobe width (default: 4)
- `APB3_MST_PWDATA_WIDTH`: Write data width (default: 8 * PSTRB_WIDTH = 32)
- `APB3_MST_PRDATA_WIDTH`: Read data width (default: 32)
- `APB3_MST_PADDR_WIDTH`: Address width (default: 32)
- `APB3_MST_PSEL_WIDTH`: Slave select width (default: 1)

The module uses the `APB3_MST_DESIGN_ATTRIBUTES` macro (defined in `common/ip_amba_apb_top_parameters.vh`) for parameterized instantiation, which allows customization of all interface widths.

#### Module Interface

The top-level module `ip_amba_apb_master_top` provides:
- Standard APB3 protocol signals (PCLK, PRESETn, PADDR, PWDATA, PRDATA, PSELx, PENABLE, PWRITE, PSTRB, PREADY, PSLVERR)
- CPU-side control interface for transaction initiation
- Timeout detection and error reporting
- Full APB3 protocol state machine implementation

### APB3 Slave Zero ( v00.00 )

**Note**: Ongoing Bug Fixes. Core is unusable at this moment.

- Generic memory supporting interface
- Fully compliant with the APB3 protocol
- Parameterized interface port widths
- Modifiable granularity
- No support for timeouts

### APB3 Master One ( v00.00 )

- Simple interface
- Easy transaction generation
- Parameterized Design
- Full APB3 compliance
- Lighter version (Easier to use and configure)

### APB3 Slave One ( v00.00 )

- Simple interface
- Easy transaction generation
- Parameterized Design
- Full APB3 Slave compliance
- Light Version

## License

This project is licensed under the MIT License. See individual file headers for copyright information.
