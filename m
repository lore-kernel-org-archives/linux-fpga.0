Return-Path: <SRS0=Witp=DD=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Witp=DD=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46942 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753566AbdLGObx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Dec 2017 09:31:53 -0500
Date: Thu, 7 Dec 2017 15:31:50 +0100
From: Anatolij Gustschin <agust@denx.de>
Subject: RFC: FT232H based FPGA configuration adapter drivers
Message-ID: <20171207153150.6f33f2e7@crub>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org
Cc: linux-usb@vger.kernel.org, linux-spi@vger.kernel.org

Hi,

I have to rework drivers for custom FT232H based FPGA configuration
adapters to make them suitable for including in mainline kernel. These
adapters should be usable via low-level drivers for FPGA Manager
framework. Two required low-level FPGA Manager drivers (for PS-SPI and
CvP configurations) are already in mainline. The missing parts are the
MPSSE SPI master driver (for attaching altera-ps-spi SPI devices) and
the FTDI FIFO FPP interface driver for FPGA Manager. I'm CCing the
relevant subsystem mailing lists and would like to get feedback to the
draft below before rewriting the missing driver parts.

A few words about our FPGA and FPGA configuration adapter hardware. We
have FPGA PCIe boards with two different FT232H based configuration
adapters. The first adapter type utilizes FT232H chip in MPSSE mode to
connect ADBUS SPI/GPIO pins to Stratix-V PS-SPI interface. Another
adapter type connects FT232H ADBUS (in FT245 FIFO mode) and two ACBUS
GPIOs to a CPLD, the CPLD is connected to the Arria-10 FPP interface.
Both FPGA boards are connected to the host via PCIe and USB (FT232H).

Below simplified diagram shows the drivers relationship used in the
first patch series [1] submitted to the FPGA and USB lists before
(this series didn't yet include the MPSSE SPI master driver).

   +-------------+
   |             |
   |  STRATIX V  |PS-SPI         FT245 FIFO & GPIO
   |             +-----+    +-------------------+
   |  on Board 1 |     |    |                   |
   |             |                         +----+---+
   |  PCIe       |   ADBUS&ACBUS           |  CPLD  |
   +---+---------+ Connection Options      +----+---+
       ^          (MPSSE or FIFO&GPIO)          |
       |                  |              +------+-------+
  altera-cvp  +-----------+----------+   |     FPP      |
              |                      |   |              |
              | FT232H 0x0403:0x6014 |   |   ARRIA 10   |
              |                      |   |              |
              +----------+-----------+   |  on Board 2  |
                         |               |              |
      MFD drv +----------+-----------+   |        PCIe  |
      creates | ftdi-ft232h MFD drv  |   +----------+---+
     platform |  USB bulk/ctrl xfer  |              ^
      devices +---+------+-------+---+              |
       below      |      |       |                  |
            +-----+      |       +-------------+    +--------+
            |            |                     |             |
     +------+-------+ +--+-----------+ +-------+---------+   |
     |ftdi-mpsse-spi| |ftdi-cbus-gpio| |ftdi-fifo-fpp-mgr|   |
     | platform dev | | platform dev | |  platform dev   |   |
     +-------+------+ +------+-------+ +---------+-------+   |
  platform   ^               ^                   ^           |
   drivers:  +               +                   |           |
     MPSSE SPI master  ACBUS GPIO Ctrl     +-----+        +--+
             ^               ^             |              |
             |               |             +              +
       altera-ps-spi         \uses   ftdi-fifo-fpp     altera-cvp
        FPGA Manager          ------+ FPGA Manager    FPGA Manager
             ^                            ^               ^
             |                            |               |
             +-------------------------+  +  +------------+
                                       fpga-mgr

The first FTDI FPP adapter driver patch series has some fundamental
issues as discussed on the lists and I plan to rework the FT232H
specific parts to prepare a new patch series. We have already
reserved custom PIDs for both adapter types and can use them in
adapter EEPROMs to ensure binding to the vendor specific drivers
for SPI and FIFO FPP types.

Instead of MFD part as in previous version I intend to add an USB misc
driver for our FPGA configuration adapters under drivers/usb/misc.
When probing for VID/PID assigned to FIFO-FPP adapter type, this
driver will register CBUS GPIO controller, GPIO lookup tables for
FIFO FPP device and will create a platform device for attaching the
low-level FPGA manager driver for FIFO FPP interface. The attached
FPGA manager driver will be similar to the ftdi-fifo-fpp driver and
will reside in drivers/fpga. When probing for VID/PID assigned to
MPSSE SPI adapter type, the USB misc driver will register MPSSE GPIO
controller, GPIO lookup tables for altera-ps-spi control/status GPIOs
and will create platform device for attaching MPSSE SPI master
controller driver. The SPI master controller platform driver will
register MPSSE SPI bus with SPI slave device from spi_board_info
struct in its platform data (in our case altera-ps-spi SPI slave
device for attaching altera-ps-spi driver). The intended location
of this custom SPI master controller driver is drivers/spi.

Below simplified diagram shows the intended device and drivers
relationship for reworking the adapter drivers.

   +-------------+
   |             |
   |  STRATIX V  |PS-SPI         FT245 FIFO & GPIO
   |             +-----+    +-------------------+
   |  on Board 1 |     +    +                   |
   |             |                         +----+---+
   |  PCIe       |   ADBUS&ACBUS           |  CPLD  |
   +---+---------+ Connection Options      +----+---+
       ^          (MPSSE or FIFO&GPIO)          |
       +                  +              +------+-------+
  altera-cvp  +-----------+----------+   |     FPP      |
              |        FT232H        |   |              |
              |     0x0403:0x7148    |   |   ARRIA 10   |
              |     0x0403:0x7149    |   |              |
              +----------+-----------+   |  on Board 2  |
                         |               |              |
             +-----------+------------+  |        PCIe  |
    USB misc | fpga-cfg-intf USB misc |  +----------+---+
  drv creates|     bulk/ctrl xfer     |             ^
    platform |ACBUS GPIO Ctrl (0x7148)|             |
     devices |MPSSE GPIO Ctrl (0x7149)|             |
      below  +-------+-------+--------+             |
                     |       |                      |
        for     +----+       +------+    for        |
     PID 0x7149 |                   | PID 0x7148    |
      +---------+--------+  +-------+---------+     |
      | ftdi-mpsse-spi + |  |                 |     |
      | altera-ps-spi in |  |ftdi-fifo-fpp-mgr|     |
      |  spi_board_info  |  | platform device |     |
      +---------+--------+  +--------+--------+     |
                ^                    ^              |
      drivers:  |                    |              |
                +                    |              |
         MPSSE SPI master            |              |
                ^                    |              |
                |                    +              +
          altera-ps-spi        ftdi-fifo-fpp    altera-cvp
           FPGA Manager         FPGA Manager   FPGA Manager
                ^                    ^              ^
                |                    |              |
                +---------------+    +    +---------+
                                  fpga-mgr

It would be worthwhile to concentrate the common USB transfer related
functions (bulk, control and FTDI mode setting code used in previous
ftdi-ft232h driver part) in a single file and reuse them in MPSSE SPI
master and FIFO FPP drivers to avoid code duplication. I plan to add
these functions in USB misc adapter driver and it could pass them to
platform drivers as callbacks in an ops struct via platform data.

Before reworking the adapter drivers I'd like to get comments to this
draft, especially when there are design issues that will cause driver
rejection in the appropriate subsystem.

Thanks!

Anatolij

[1] https://lkml.org/lkml/2017/7/6/710
