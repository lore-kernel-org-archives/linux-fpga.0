Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 0/4] fpga: add managed create functions
Date: Mon, 15 Oct 2018 17:20:00 -0500
Message-Id: <1539642004-18473-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

Please take these four patches that have been reviewed on the mailing
list.  They all apply and build cleanly on the current linux-next and
char-misc-testing.  The first 3 add managed create functions for the
FPGA API.  The fourth is documentation rework.

Alan

Alan Tull (4):
  fpga: mgr: add devm_fpga_mgr_create
  fpga: bridge: add devm_fpga_bridge_create
  fpga: add devm_fpga_region_create
  docs: fpga: document programming fpgas using regions

 Documentation/driver-api/fpga/fpga-bridge.rst      |  37 ++----
 Documentation/driver-api/fpga/fpga-mgr.rst         | 126 +++------------------
 Documentation/driver-api/fpga/fpga-programming.rst | 107 +++++++++++++++++
 Documentation/driver-api/fpga/fpga-region.rst      |  91 +++++++--------
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
 drivers/fpga/dfl-fme-region.c                      |   6 +-
 drivers/fpga/dfl.c                                 |   6 +-
 drivers/fpga/fpga-bridge.c                         |  68 +++++++++--
 drivers/fpga/fpga-mgr.c                            |  64 +++++++++--
 drivers/fpga/fpga-region.c                         |  65 +++++++++--
 drivers/fpga/ice40-spi.c                           |  10 +-
 drivers/fpga/machxo2-spi.c                         |  11 +-
 drivers/fpga/of-fpga-region.c                      |   6 +-
 drivers/fpga/socfpga-a10.c                         |   5 +-
 drivers/fpga/socfpga.c                             |  10 +-
 drivers/fpga/ts73xx-fpga.c                         |  11 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |   4 +-
 drivers/fpga/xilinx-spi.c                          |  12 +-
 drivers/fpga/zynq-fpga.c                           |   5 +-
 include/linux/fpga/fpga-bridge.h                   |   4 +
 include/linux/fpga/fpga-mgr.h                      |   4 +
 include/linux/fpga/fpga-region.h                   |   4 +
 31 files changed, 412 insertions(+), 326 deletions(-)
 create mode 100644 Documentation/driver-api/fpga/fpga-programming.rst

-- 
2.7.4
