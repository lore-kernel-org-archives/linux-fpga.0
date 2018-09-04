Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v2 0/8] fpga: add devm managed create APIs
Date: Tue,  4 Sep 2018 16:22:29 -0500
Message-Id: <20180904212237.3078-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Fix one functional FPGA bug.

Implement managed devm_fpga_(mgr|bridge|region)_create() functions.

More documentation cleanup to make the documentation more helpful
and to emphasize the use of FPGA regions for FPGA programming.

Fix a few minor documentation corrections.

v2: Add Suggested-by
    Documentation changes from review comments

Alan Tull (8):
  fpga: do not access region struct after fpga_region_unregister
  fpga: mgr: add devm_fpga_mgr_create
  fpga: bridge: add devm_fpga_bridge_create
  fpga: add devm_fpga_region_create
  dt-bindings: fpga: fix freeze controller compatible in region doc
  fpga: bridge: fix obvious function documentation error
  docs: fpga: document fpga manager flags
  docs: fpga: document programming fpgas using regions

 .../devicetree/bindings/fpga/fpga-region.txt       |   4 +-
 Documentation/driver-api/fpga/fpga-bridge.rst      |  37 ++-----
 Documentation/driver-api/fpga/fpga-mgr.rst         | 121 +++------------------
 Documentation/driver-api/fpga/fpga-programming.rst | 107 ++++++++++++++++++
 Documentation/driver-api/fpga/fpga-region.rst      |  91 ++++++++--------
 Documentation/driver-api/fpga/index.rst            |   2 +
 Documentation/driver-api/fpga/intro.rst            |   2 +-
 drivers/fpga/altera-cvp.c                          |   8 +-
 drivers/fpga/altera-fpga2sdram.c                   |   8 +-
 drivers/fpga/altera-freeze-bridge.c                |  13 +--
 drivers/fpga/altera-hps2fpga.c                     |   7 +-
 drivers/fpga/altera-pr-ip-core.c                   |   9 +-
 drivers/fpga/altera-ps-spi.c                       |  11 +-
 drivers/fpga/dfl-fme-br.c                          |  11 +-
 drivers/fpga/dfl-fme-mgr.c                         |  11 +-
 drivers/fpga/dfl-fme-region.c                      |  10 +-
 drivers/fpga/dfl.c                                 |   6 +-
 drivers/fpga/fpga-bridge.c                         |  74 +++++++++++--
 drivers/fpga/fpga-mgr.c                            |  67 ++++++++++--
 drivers/fpga/fpga-region.c                         |  68 ++++++++++--
 drivers/fpga/ice40-spi.c                           |  10 +-
 drivers/fpga/machxo2-spi.c                         |  11 +-
 drivers/fpga/of-fpga-region.c                      |   9 +-
 drivers/fpga/socfpga-a10.c                         |   5 +-
 drivers/fpga/socfpga.c                             |  10 +-
 drivers/fpga/ts73xx-fpga.c                         |  11 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |   4 +-
 drivers/fpga/xilinx-spi.c                          |  12 +-
 drivers/fpga/zynq-fpga.c                           |   5 +-
 include/linux/fpga/fpga-bridge.h                   |   4 +
 include/linux/fpga/fpga-mgr.h                      |  24 +++-
 include/linux/fpga/fpga-region.h                   |   4 +
 32 files changed, 444 insertions(+), 332 deletions(-)
 create mode 100644 Documentation/driver-api/fpga/fpga-programming.rst

-- 
2.7.4
