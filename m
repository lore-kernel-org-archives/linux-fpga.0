Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [RESEND PATCH v3 0/4] fpga: don't use drvdata in common code
Date: Tue, 27 Mar 2018 14:59:53 -0500
Message-Id: <20180327195957.3878-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Anatolij Gustschin <agust@denx.de>, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Joel Holdsworth <joel@airwebreathe.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Joshua Clayton <stillcompiling@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Setting drvdata is fine for DT based devices which have one manager,
bridge, or region device per platform device.  However, PCIe based
devices may have multiple FPGA mgr/bridge/regions under one PCIe
device.  Without these changes, PCIe-based solutions have to create an
extra device for each child mgr/bridge/region to hold drvdata.

Also changing the fpga_*_register/unregister functions to take the
corresponding struct as the only parameter wherever they weren't already.

* int fpga_bridge_register(struct fpga_bridge *br)
* int fpga_mgr_register(struct fpga_manager *mgr)
* int fpga_region_register(struct fpga_region *region)

* void fpga_bridge_unregister(struct fpga_bridge *br)
* void fpga_mgr_unregister(struct fpga_manager *mgr)
* int fpga_region_unregister(struct fpga_region *region)

Changes from v2:
* Drop patch 5 which fixed a DT overlay issue.  The underlying
  issue was fixed in the main DT overlay code.
* Minor code cleanup to make it more obvious that the changes
  were not breaking anything
* Added Moritz' ack on patch 1

Alan Tull (4):
  fpga: region: don't use drvdata in common fpga code
  fpga: manager: don't use drvdata in common fpga code
  fpga: bridge: don't use drvdata in common fpga code
  fpga: region: change fpga_region_register to have one param

 Documentation/fpga/fpga-mgr.txt     | 24 +++++++++++++++------
 Documentation/fpga/fpga-region.txt  |  3 +--
 drivers/fpga/altera-cvp.c           | 18 ++++++++++++----
 drivers/fpga/altera-fpga2sdram.c    | 20 +++++++++++++----
 drivers/fpga/altera-freeze-bridge.c | 18 +++++++++++++---
 drivers/fpga/altera-hps2fpga.c      | 16 +++++++++++---
 drivers/fpga/altera-pr-ip-core.c    | 17 +++++++++++++--
 drivers/fpga/altera-ps-spi.c        | 18 +++++++++++++---
 drivers/fpga/fpga-bridge.c          | 43 ++++++++++++++-----------------------
 drivers/fpga/fpga-mgr.c             | 39 ++++++++++++---------------------
 drivers/fpga/fpga-region.c          |  9 ++++++--
 drivers/fpga/ice40-spi.c            | 20 +++++++++++++----
 drivers/fpga/of-fpga-region.c       |  4 +++-
 drivers/fpga/socfpga-a10.c          | 16 +++++++++++---
 drivers/fpga/socfpga.c              | 18 +++++++++++++---
 drivers/fpga/ts73xx-fpga.c          | 18 +++++++++++++---
 drivers/fpga/xilinx-pr-decoupler.c  | 15 ++++++++++---
 drivers/fpga/xilinx-spi.c           | 18 +++++++++++++---
 drivers/fpga/zynq-fpga.c            | 16 +++++++++++---
 include/linux/fpga/fpga-bridge.h    |  7 +++---
 include/linux/fpga/fpga-mgr.h       |  8 +++----
 include/linux/fpga/fpga-region.h    |  4 +++-
 22 files changed, 256 insertions(+), 113 deletions(-)

-- 
2.14.2
