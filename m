Return-Path: <SRS0=KMFu=GN=gmail.com=p.pisati@kernel.org>
Return-Path: <SRS0=KMFu=GN=gmail.com=p.pisati@kernel.org>
From: Paolo Pisati <p.pisati@gmail.com>
Subject: [PATCH 0/2 v8] Lattice MachXO2 Slave SPI FPGA Manager support
Date: Fri, 23 Mar 2018 13:27:10 +0100
Message-Id: <1521808032-29645-1-git-send-email-p.pisati@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi all,
this series adds support for the Lattice MachXO2 FPGA chip, programmed
over Slave SPI.

Tested on a raspberry pi3, beaglebone black (little endian mode) and imx6
hummingboard (big endian mode) + bugblat's pif2 fpga hat (machxo2 7000HC) or
tinyfpga A1/A2 (machxo2 256HC / 1200HC), in SPI slave mode with varying bus
speed.

Changes since v7:
* misc style fixes, among which:
  * static const u8 cmd[]
  * #ifdef DEBUG ... #endif reorder
  * introduction of get_err_string()
  * direct returns to reduce line count
  * indentation


Paolo Pisati (2):
  dt: bindings: fpga: add lattice machxo2 slave spi binding description
  fpga: lattice machxo2: Add Lattice MachXO2 support

 .../bindings/fpga/lattice-machxo2-spi.txt          |  29 ++
 drivers/fpga/Kconfig                               |   8 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/machxo2-spi.c                         | 388 +++++++++++++++++++++
 4 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
 create mode 100644 drivers/fpga/machxo2-spi.c

-- 
2.7.4
