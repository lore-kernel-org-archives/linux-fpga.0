Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 00/14] fpga api changes and kernel-doc fixup
Date: Wed, 16 May 2018 18:49:53 -0500
Message-Id: <20180516235007.3951-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

I'm posting these all together because they are interdependent.

Patches 1-4 are a repost of v4 of the FPGA api change.

Patch 5 is a repost of adding SPDX to my fpga code

Patch 6-12 update the fpga kernel-doc documentation and move
existing .txt fpga documentation to driver-api ReST documents.

Patch 13 is a minor documentation fix

Patch 14 updates MAINTAINERS for the new driver-api/fpga directory

Alan Tull (14):
  fpga: region: don't use drvdata in common fpga code
  fpga: manager: change api, don't use drvdata
  fpga: bridge: change api, don't use drvdata
  fpga: region: change api, add fpga_region_create/free
  fpga: use SPDX
  fpga: mgr: kernel-doc fixes
  fpga: bridge: kernel-doc fixes
  fpga: region: kernel-doc fixes
  Documentation: fpga: move fpga overview to driver-api
  documentation: fpga: move fpga-mgr.txt to driver-api
  documentation: fpga: add bridge document to driver-api
  documentation: fpga: move fpga-region.txt to driver-api
  fpga: clarify that unregister functions also free
  MAINTAINERS: Add driver-api/fpga path

 Documentation/driver-api/fpga/fpga-bridge.rst |  49 ++++++
 Documentation/driver-api/fpga/fpga-mgr.rst    | 220 ++++++++++++++++++++++++++
 Documentation/driver-api/fpga/fpga-region.rst | 102 ++++++++++++
 Documentation/driver-api/fpga/index.rst       |  13 ++
 Documentation/driver-api/fpga/intro.rst       |  54 +++++++
 Documentation/driver-api/index.rst            |   1 +
 Documentation/fpga/fpga-mgr.txt               | 199 -----------------------
 Documentation/fpga/fpga-region.txt            |  95 -----------
 Documentation/fpga/overview.txt               |  23 ---
 MAINTAINERS                                   |   1 +
 drivers/fpga/altera-cvp.c                     |  19 ++-
 drivers/fpga/altera-fpga2sdram.c              |  34 ++--
 drivers/fpga/altera-freeze-bridge.c           |  35 ++--
 drivers/fpga/altera-hps2fpga.c                |  37 +++--
 drivers/fpga/altera-pr-ip-core-plat.c         |  13 +-
 drivers/fpga/altera-pr-ip-core.c              |  31 ++--
 drivers/fpga/altera-ps-spi.c                  |  20 ++-
 drivers/fpga/fpga-bridge.c                    |  86 +++++-----
 drivers/fpga/fpga-mgr.c                       | 129 +++++++++------
 drivers/fpga/fpga-region.c                    |  86 ++++++----
 drivers/fpga/ice40-spi.c                      |  21 ++-
 drivers/fpga/machxo2-spi.c                    |  20 ++-
 drivers/fpga/of-fpga-region.c                 |  28 +---
 drivers/fpga/socfpga-a10.c                    |  28 ++--
 drivers/fpga/socfpga.c                        |  32 ++--
 drivers/fpga/ts73xx-fpga.c                    |  20 ++-
 drivers/fpga/xilinx-pr-decoupler.c            |  22 ++-
 drivers/fpga/xilinx-spi.c                     |  20 ++-
 drivers/fpga/zynq-fpga.c                      |  14 +-
 include/linux/fpga/altera-pr-ip-core.h        |  13 +-
 include/linux/fpga/fpga-bridge.h              |   9 +-
 include/linux/fpga/fpga-mgr.h                 |  23 +--
 include/linux/fpga/fpga-region.h              |  13 +-
 33 files changed, 890 insertions(+), 620 deletions(-)
 create mode 100644 Documentation/driver-api/fpga/fpga-bridge.rst
 create mode 100644 Documentation/driver-api/fpga/fpga-mgr.rst
 create mode 100644 Documentation/driver-api/fpga/fpga-region.rst
 create mode 100644 Documentation/driver-api/fpga/index.rst
 create mode 100644 Documentation/driver-api/fpga/intro.rst
 delete mode 100644 Documentation/fpga/fpga-mgr.txt
 delete mode 100644 Documentation/fpga/fpga-region.txt
 delete mode 100644 Documentation/fpga/overview.txt

-- 
2.7.4
