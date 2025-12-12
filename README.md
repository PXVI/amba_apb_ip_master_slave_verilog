# ip_amba_apb_ms_rtl_v

This repository houses various AMBA APB master and slave protocol IPs. The protocol version which is supported by the RTLs is **Arm's AMBA3** open standard protocol.

The reason for adding version numbers for the IP is that the RTL is functionally stable in every aspect, but will need more user specific features in the future and if a new feature is added; it will be provided as a stand alone IP built over the existing one.

## Contents of the repository

### APB3 Master Zero (v00.00)

Located in: `apb3_v00_00_master_rtl_v/`

A fully compliant AMBA APB3 Master IP with comprehensive transaction control capabilities.

**Features:**
- Generic application/CPU interface for easy integration
- Heavy user control for transaction initiations
- Parameterized interface port widths
- Fully compliant with the APB3 protocol
- Complete granular support for interfacing with any kind of bridge
- Additional support for protocol timeout timers
- Back-to-back transaction support
- Asynchronous reset support

### APB3 Slave Zero (v00.00)

**Note**: Ongoing Bug Fixes. Core is unusable at this moment.

**Features:**
- Generic memory supporting interface
- Fully compliant with the APB3 protocol
- Parameterized interface port widths
- Modifiable granularity
- No support for timeouts

### APB3 Master One (v00.00)

A lighter, simplified version of the APB3 Master IP.

**Features:**
- Simple interface
- Easy transaction generation
- Parameterized design
- Full APB3 compliance
- Lighter version (easier to use and configure)

### APB3 Slave One (v00.00)

A lighter, simplified version of the APB3 Slave IP.

**Features:**
- Simple interface
- Easy transaction generation
- Parameterized design
- Full APB3 Slave compliance
- Light version

## License

This project is licensed under the MIT License. See individual file headers for copyright information.
