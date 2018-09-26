Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v3 0/4] fpga: add devm managed create APIs
Date: Wed, 26 Sep 2018 11:12:18 -0500
Message-Id: <1537978342-17697-1-git-send-email-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, Federico Vaga <federico.vaga@cern.ch>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Implement managed devm_fpga_(mgr|bridge|region)_create() functions.

Patchset is dependent on the patches that were acked/sent upstream:
   https://lkml.org/lkml/2018/9/12/639

v3 changes:
* take out unclear explanation fpga_(mgr|br|region)_unregister
* Add acks
* drop the separately resent "dt-bindings: fpga: fix freeze controller compatible in region doc"
* drop some of the acked patches that I send to Greg

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
