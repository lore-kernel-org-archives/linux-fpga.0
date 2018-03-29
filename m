Return-Path: <SRS0=aM/a=GT=ettus.com=moritz.fischer@kernel.org>
Return-Path: <SRS0=aM/a=GT=ettus.com=moritz.fischer@kernel.org>
From: Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/6] FPGA Manager Patches for 4.17
Date: Thu, 29 Mar 2018 08:36:52 -0700
Message-Id: <20180329153658.11614-1-mdf@kernel.org>
To: gregkh@linuxfoundation.org
Cc: atull@kernel.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

Hi Greg,

can you please take the following patches for 4.17.

Alan's changes are mostly refactoring in preparation for non-dt based
FPGA regions.

Anatolij's changes fix a small issue with altera-ps-spi FPGAs,
where the FPGA is being reset unnessesarily on driver load.

All patches have been reviewed on the list.

I'm sending the patches this time instead of Alan so I can get more
familiar with the process.

If you prefer to pull instead there's also a signed tag:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux.git tags/fpga-for-greg-4.17

Thanks,

Moritz

Alan Tull (5):
  fpga: region: don't use drvdata in common fpga code
  fpga: manager: don't use drvdata in common fpga code
  fpga: bridge: don't use drvdata in common fpga code
  fpga: region: change fpga_region_register to have one param
  fpga: fpga-region: comment on fpga_region_program_fpga locking

Anatolij Gustschin (1):
  fpga-manager: altera-ps-spi: preserve nCONFIG state

 Documentation/fpga/fpga-mgr.txt     | 24 +++++++++++++++------
 Documentation/fpga/fpga-region.txt  |  3 +--
 drivers/fpga/altera-cvp.c           | 18 ++++++++++++----
 drivers/fpga/altera-fpga2sdram.c    | 20 +++++++++++++----
 drivers/fpga/altera-freeze-bridge.c | 18 +++++++++++++---
 drivers/fpga/altera-hps2fpga.c      | 16 +++++++++++---
 drivers/fpga/altera-pr-ip-core.c    | 17 +++++++++++++--
 drivers/fpga/altera-ps-spi.c        | 20 +++++++++++++----
 drivers/fpga/fpga-bridge.c          | 43 ++++++++++++++-----------------------
 drivers/fpga/fpga-mgr.c             | 39 ++++++++++++---------------------
 drivers/fpga/fpga-region.c          | 14 ++++++++++--
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
 22 files changed, 262 insertions(+), 114 deletions(-)

-- 
2.16.2
