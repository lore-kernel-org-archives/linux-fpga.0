Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/3] fpga: don't use drvdata in common fpga code
Date: Tue, 31 Oct 2017 15:42:12 -0500
Message-Id: <1509482535-4921-1-git-send-email-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

This patch set goes on top of the non-dt set that's been on
the list since March.  

This patchset changes the following fpga_*_register functions to not
set drvdata:
* fpga_region_register.
* fpga_mgr_register
* fpga_bridge_register

Setting drvdata is fine for DT based devices, that will have one
manager, bridge, or region device per platform device.  PCIe based
devices may have multiple FPGA mgr/bridge/regions under one pcie
device.  Without these changes, PCIe-based solutions have to create an
extra device for each child mgr/bridge/region to hold drvdata.

Other changes:

- pass mgr to fpga_mgr_register/unregister instead of dev.
- pass bridge to fpga_bridge_register/unregister.
- Callers of fpga_bridge/mgr_register, are changed to alloc the
bridge/mgr struct and partly fill it, adding name, ops and priv.
- Caller uses devm for allocating the mgr/bridge structures.
- The caller can set drvdata if desired.

Alan

Alan Tull (3):
  fpga: region: don't use drvdata in common fpga code
  fpga: manager: don't use drvdata in common fpga code
  fpga: bridge: don't use drvdata in common fpga code

 Documentation/fpga/fpga-mgr.txt     | 23 ++++++++++++++++-------
 drivers/fpga/altera-cvp.c           | 17 +++++++++++++----
 drivers/fpga/altera-fpga2sdram.c    | 19 +++++++++++++++----
 drivers/fpga/altera-freeze-bridge.c | 17 ++++++++++++++---
 drivers/fpga/altera-hps2fpga.c      | 15 ++++++++++++---
 drivers/fpga/altera-pr-ip-core.c    | 16 ++++++++++++++--
 drivers/fpga/altera-ps-spi.c        | 17 ++++++++++++++---
 drivers/fpga/fpga-bridge.c          | 30 +++++++-----------------------
 drivers/fpga/fpga-mgr.c             | 28 +++++++---------------------
 drivers/fpga/fpga-region.c          |  1 -
 drivers/fpga/ice40-spi.c            | 19 +++++++++++++++----
 drivers/fpga/of-fpga-region.c       |  1 +
 drivers/fpga/socfpga-a10.c          | 15 ++++++++++++---
 drivers/fpga/socfpga.c              | 17 ++++++++++++++---
 drivers/fpga/ts73xx-fpga.c          | 17 ++++++++++++++---
 drivers/fpga/xilinx-pr-decoupler.c  | 14 +++++++++++---
 drivers/fpga/xilinx-spi.c           | 17 ++++++++++++++---
 drivers/fpga/zynq-fpga.c            | 15 ++++++++++++---
 include/linux/fpga/fpga-bridge.h    |  5 ++---
 include/linux/fpga/fpga-mgr.h       |  6 ++----
 20 files changed, 209 insertions(+), 100 deletions(-)

-- 
2.7.4
