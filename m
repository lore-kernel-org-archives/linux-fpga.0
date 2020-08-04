Return-Path: <SRS0=IFE+=BO=analog.com=alexandru.Ardelean@kernel.org>
Return-Path: <SRS0=IFE+=BO=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 0/6] clk: axi-clk-gen: misc updates to the driver
Date: Tue, 4 Aug 2020 14:06:52 +0300
Message-ID: <20200804110658.40911-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, mdf@kernel.org, Alexandru Ardelean <alexandru.ardelean@analog.com>
List-ID: <linux-fpga@vger.kernel.org>

These patches synchronize the driver with the current state in the
Analog Devices Linux tree:
  https://github.com/analogdevicesinc/linux/

They have been in the tree for about 2-3, so they did receive some
testing.

Highlights are:
* Add support for fractional dividers (Lars-Peter Clausen)
* Enable support for ZynqMP (UltraScale) (Dragos Bogdan)
* Support frequency limits for ZynqMP (Mathias Tausen)
  - And continued by Mircea Caprioru, to read them from the IP cores

Dragos Bogdan (1):
  clk: axi-clkgen: add support for ZynqMP (UltraScale)

Lars-Peter Clausen (2):
  clk: axi-clkgen: Add support for fractional dividers
  clk: axi-clkgen: Set power bits for fractional mode

Mathias Tausen (1):
  clk: axi-clkgen: Respect ZYNQMP PFD/VCO frequency limits

Mircea Caprioru (2):
  include: fpga: adi-axi-common.h: add definitions for supported FPGAs
  clk: axi-clkgen: Add support for FPGA info

 drivers/clk/Kconfig                 |   2 +-
 drivers/clk/clk-axi-clkgen.c        | 253 ++++++++++++++++++++++------
 include/linux/fpga/adi-axi-common.h |  37 ++++
 3 files changed, 236 insertions(+), 56 deletions(-)

-- 
2.17.1
