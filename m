Return-Path: <SRS0=8dAr=NQ=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=8dAr=NQ=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:36924 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbeKFBjn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Nov 2018 20:39:43 -0500
From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 0/3] Add support for ARRI FPGA configuration
Date: Mon,  5 Nov 2018 17:19:10 +0100
Message-Id: <20181105161913.27538-1-agust@denx.de>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, atull@kernel.org, mdf@kernel.org

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

Anatolij Gustschin (3):
  usb: misc: add driver for FT232H based FPGA configuration devices
  spi: add FTDI MPSSE SPI controller driver
  fpga: Add fpga manager driver for ARRI Altera FPP

 drivers/fpga/Kconfig            |    7 +
 drivers/fpga/Makefile           |    1 +
 drivers/fpga/ftdi-fifo-fpp.c    |  594 +++++++++++++
 drivers/spi/Kconfig             |    7 +
 drivers/spi/Makefile            |    1 +
 drivers/spi/spi-ftdi-mpsse.c    |  671 ++++++++++++++
 drivers/usb/misc/Kconfig        |    9 +
 drivers/usb/misc/Makefile       |    1 +
 drivers/usb/misc/ft232h-intf.c  | 1468 +++++++++++++++++++++++++++++++
 include/linux/usb/ft232h-intf.h |  198 +++++
 10 files changed, 2957 insertions(+)
 create mode 100644 drivers/fpga/ftdi-fifo-fpp.c
 create mode 100644 drivers/spi/spi-ftdi-mpsse.c
 create mode 100644 drivers/usb/misc/ft232h-intf.c
 create mode 100644 include/linux/usb/ft232h-intf.h

-- 
2.17.1
