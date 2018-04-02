Return-Path: <SRS0=ELSG=GX=gmail.com=p.pisati@kernel.org>
Return-Path: <SRS0=ELSG=GX=gmail.com=p.pisati@kernel.org>
From: Paolo Pisati <p.pisati@gmail.com>
Subject: [PATCH v9 0/2] fpga: Lattice MachXO2 Slave SPI FPGA Manager support
Date: Mon,  2 Apr 2018 17:13:44 +0200
Message-Id: <1522682026-11395-1-git-send-email-p.pisati@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi all,
this series adds support for the Lattice MachXO2 FPGA chip, programmed
over slave SPI.

Tested on a raspberry pi3, beaglebone black (little endian mode) and imx6
hummingboard (big endian mode) + bugblat's pif2 fpga hat (machxo2 7000HC) or
tinyfpga A1/A2 (machxo2 256HC / 1200HC), in SPI slave mode with varying bus
speed.

Changes since v8:
* style fixes pointed out by Alan
* rebase on the new fpga_mgr_register() API

Paolo Pisati (2):
  dt: bindings: fpga: add lattice machxo2 slave spi binding description
  fpga: lattice machxo2: Add Lattice MachXO2 support

 .../bindings/fpga/lattice-machxo2-spi.txt          |  29 ++
 drivers/fpga/Kconfig                               |   7 +
 drivers/fpga/Makefile                              |   1 +
 drivers/fpga/machxo2-spi.c                         | 405 +++++++++++++++++++++
 4 files changed, 442 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
 create mode 100644 drivers/fpga/machxo2-spi.c

-- 
2.7.4
