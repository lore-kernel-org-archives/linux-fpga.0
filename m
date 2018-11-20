Return-Path: <SRS0=E6IX=N7=denx.de=agust@kernel.org>
Return-Path: <SRS0=E6IX=N7=denx.de=agust@kernel.org>
From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 0/3] Add support for ARRI FPGA configuration
Date: Tue, 20 Nov 2018 01:28:18 +0100
Message-Id: <20181120002821.12794-1-agust@denx.de>
To: linux-usb@vger.kernel.org, linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, atull@kernel.org, mdf@kernel.org
List-ID: <linux-fpga@vger.kernel.org>

This series adds drivers and FPGA manager support required
for FT232H based ARRI FPGA configuration adapters.

Patch 1/3 adds FT232H interface driver (for ARRI USB PIDs)
implementing commonly used FTDI USB transfer operations and
ACBUS/MPSSE GPIO controllers. Depending on USB PIDs it creates
platform devices for MPSSE SPI bus with attached SPI slaves
or platform devices for ARRI FPP FPGA manager.

Patch 2/3 adds MPSSE SPI controller driver which registers
an FTDI USB-SPI bus with attached SPI slaves from description
in platform data, so existing SPI protocol drivers can be
used for these slave devices (in our case altera-ps-spi).
Via interface driver in patch 1/3 it is easily possible to add
support for other slave devices using custom USB PIDs (e.g.
spi-nor flash W25Q32 with m25p80 driver has beed used for
testing MPSSE SPI controller driver).

Patch 3/3 adds FPGA manager driver for ARRI FPP adapters for
FPGA configuration via Altera fast passive parallel interface.

Changes since v1:
  Patch 1/3
  - add myself as a maintainer for these drivers
  - update copyright line to include 2018
  - include required linux headers
  - fix gcc 7.3.0 build warnings -Wunused-const-variable=
  - make ftdi functions and spi_board_info struct static
  - use KBUILD_MODNAME in drivers struct
  - use dev_err() for error messages instead of dev_info()
  - drop not needed output about number of used MPSSE pins
    since it is constant (not configurable)
  - remove ftdi function prototypes from header ft232h-intf.h
    as these are not exported anymore
  - update comments (don't use kernel-doc format as we do not
    export symbols anymore and functions are "static")

  Patch 2/3
  - fix build breakage when building with ARCH=i386 allmodconfig
  - add checks for ops->lock/ops->unlock presence in pdata
  - update copyright line to include 2018
  - remove printing numbers in parentheses (%d)

  Patch 3/3
  - update copyright line to include 2018
  - add sysfs ABI documentation
 
Changes since initial version (MFD based):
  - don't use MFD framework
  - don't use original FT232H USB PID (it is too generic and collides
    with existing ftdi_sio driver)
  - don't add separate CBUS GPIO driver based on FT232H MFD device
  - redesign/rework the drivers as described under [4]
  - add basic FT232H interface driver under drivers/usb/misc/
  - use custom reserved USB PIDs in the USB driver for adapter devices
  - add notes about borrowed protocol code from libftdi to commit log
    and header file
  - add MPSSE SPI controller driver supporting USB-SPI bus with
    dynamically added SPI slaves from description in platform data
    (the initial attempt didn't include USB SPI bus support for PS-
     SPI FPGA configuration via USB)
  - rework FPP fpga manager driver based on new FT232H interface
    driver and extend it according to CPLD changes for additional
    support of new hardware revision B.

Anatolij Gustschin (3):
  usb: misc: add driver for FT232H based FPGA configuration devices
  spi: add FTDI MPSSE SPI controller driver
  fpga: Add fpga manager driver for ARRI Altera FPP

 .../ABI/testing/sysfs-driver-ftdi-fifo-fpp    |    7 +
 MAINTAINERS                                   |    8 +
 drivers/fpga/Kconfig                          |    7 +
 drivers/fpga/Makefile                         |    1 +
 drivers/fpga/ftdi-fifo-fpp.c                  |  594 +++++++
 drivers/spi/Kconfig                           |    7 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-ftdi-mpsse.c                  |  673 ++++++++
 drivers/usb/misc/Kconfig                      |    9 +
 drivers/usb/misc/Makefile                     |    1 +
 drivers/usb/misc/ft232h-intf.c                | 1464 +++++++++++++++++
 include/linux/usb/ft232h-intf.h               |  187 +++
 12 files changed, 2959 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ftdi-fifo-fpp
 create mode 100644 drivers/fpga/ftdi-fifo-fpp.c
 create mode 100644 drivers/spi/spi-ftdi-mpsse.c
 create mode 100644 drivers/usb/misc/ft232h-intf.c
 create mode 100644 include/linux/usb/ft232h-intf.h

-- 
2.17.1
