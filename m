Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/5] fpga: enhancements to support non-dt code
Date: Mon, 13 Mar 2017 16:53:28 -0500
Message-Id: <20170313215333.3008-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Set of patches that supports writing code that uses
FPGA regions without Device Tree overlays.

Main differences from the RFC:
* dropping the sysfs interface
* dropping support for more than one DT overlay on a region

Alan Tull (5):
  fpga-mgr: pass parameters for loading fpga in image info
  fpga-bridge: support getting bridge from device
  doc: fpga-mgr: separate getting/locking FPGA manager
  fpga-mgr: separate getting/locking FPGA manager
  fpga-region: separate out common code from dt specific code

 Documentation/fpga/fpga-mgr.txt  |  19 +-
 drivers/fpga/Kconfig             |  12 +-
 drivers/fpga/Makefile            |   1 +
 drivers/fpga/fpga-bridge.c       | 107 +++++++--
 drivers/fpga/fpga-mgr.c          |  56 ++++-
 drivers/fpga/fpga-region.c       | 473 +++++++--------------------------------
 drivers/fpga/fpga-region.h       |  50 +++++
 drivers/fpga/of-fpga-region.c    | 453 +++++++++++++++++++++++++++++++++++++
 include/linux/fpga/fpga-bridge.h |   7 +-
 include/linux/fpga/fpga-mgr.h    |  17 ++
 10 files changed, 766 insertions(+), 429 deletions(-)
 create mode 100644 drivers/fpga/fpga-region.h
 create mode 100644 drivers/fpga/of-fpga-region.c

-- 
2.7.4
