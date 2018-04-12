Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v4 0/4] fpga: change api, don't use drive data
Date: Thu, 12 Apr 2018 15:30:39 -0500
Message-Id: <20180412203043.3001-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

This patchset must go on top of Paolo Pisoli's
 "fpga: lattice machxo2: Add Lattice MachXO2 support"

Don't set or use drvdata in the FPGA common manager/bridge/region
code.

Change API for manager, bridge, and region to each include functions
for create, free, register, and unregister.  This involved adding new
create/free functions and changing the existing register/unregister
functions to take the corresponding manager/bridge/region struct as
the only parameter.

Setting drvdata is fine for DT based devices which have one manager,
bridge, or region device per platform device.  However, PCIe based
devices may have multiple FPGA mgr/bridge/regions under one PCIe
device.  Without these changes, PCIe-based solutions have to create an
extra device for each child mgr/bridge/region to hold drvdata.

Alan Tull (4):
  fpga: region: don't use drvdata in common fpga code
  fpga: manager: change api, don't use drvdata
  fpga: bridge: change api, don't use drvdata
  fpga: region: change api, add fpga_region_create/free

 Documentation/fpga/fpga-mgr.txt     | 35 +++++++++++++----
 Documentation/fpga/fpga-region.txt  |  3 +-
 drivers/fpga/altera-cvp.c           | 19 ++++++---
 drivers/fpga/altera-fpga2sdram.c    | 21 +++++++---
 drivers/fpga/altera-freeze-bridge.c | 22 +++++++++--
 drivers/fpga/altera-hps2fpga.c      | 24 +++++++++---
 drivers/fpga/altera-pr-ip-core.c    | 18 ++++++++-
 drivers/fpga/altera-ps-spi.c        | 20 ++++++++--
 drivers/fpga/fpga-bridge.c          | 70 +++++++++++++++++++++------------
 drivers/fpga/fpga-mgr.c             | 78 ++++++++++++++++++++++++-------------
 drivers/fpga/fpga-region.c          | 69 +++++++++++++++++++++++++-------
 drivers/fpga/ice40-spi.c            | 21 ++++++++--
 drivers/fpga/machxo2-spi.c          | 20 ++++++++--
 drivers/fpga/of-fpga-region.c       | 14 +++----
 drivers/fpga/socfpga-a10.c          | 14 +++++--
 drivers/fpga/socfpga.c              | 19 +++++++--
 drivers/fpga/ts73xx-fpga.c          | 20 ++++++++--
 drivers/fpga/xilinx-pr-decoupler.c  | 22 ++++++++---
 drivers/fpga/xilinx-spi.c           | 20 ++++++++--
 drivers/fpga/zynq-fpga.c            | 14 +++++--
 include/linux/fpga/fpga-bridge.h    |  9 +++--
 include/linux/fpga/fpga-mgr.h       | 10 +++--
 include/linux/fpga/fpga-region.h    | 11 ++++--
 23 files changed, 429 insertions(+), 144 deletions(-)

-- 
2.7.4
