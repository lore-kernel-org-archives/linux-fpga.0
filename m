Return-Path: <SRS0=xP2i=42=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=xP2i=42=intel.com=yilun.xu@kernel.org>
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 0/7] Add interrupt support to FPGA DFL drivers
Date: Mon,  9 Mar 2020 18:29:43 +0800
Message-Id: <1583749790-10837-1-git-send-email-yilun.xu@intel.com>
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Xu Yilun <yilun.xu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

This patchset add interrupt support to FPGA DFL drivers.

With these patches, DFL driver will parse and assign interrupt resources
for enumerated feature devices and their sub features.

This patchset also introduces a set of APIs for user to monitor DFL
interrupts. Three sub features (DFL FME error, DFL AFU error and user
interrupt) drivers now support these APIs.

Patch #1: DFL framework change. Accept interrupt info input from DFL bus
	  driver, and add interrupt parsing and assignment for feature
	  sub devices.
Patch #2: DFL pci driver change, add interrupt info on DFL enumeration.
Patch #3: DFL framework change. Add helper functions for feature sub
	  device drivers to handle interrupt and notify users.
Patch #4: Add interrupt support for AFU error reporting sub feature.
Patch #5: Add interrupt support for FME global error reporting sub
	  feature.
Patch #6: Add interrupt support for a new sub feature, to handle user
	  interrupts implemented in AFU.
Patch #7: Documentation for DFL interrupt handling.

Xu Yilun (7):
  fpga: dfl: parse interrupt info for feature devices on enumeration
  fpga: dfl: pci: add irq info for feature devices enumeration
  fpga: dfl: introduce interrupt trigger setting API
  fpga: dfl: afu: add interrupt support for error reporting
  fpga: dfl: fme: add interrupt support for global error reporting
  fpga: dfl: afu: add user interrupt support
  Documentation: fpga: dfl: add descriptions for interrupt related
    interfaces.

 Documentation/fpga/dfl.rst    |  17 +++
 drivers/fpga/dfl-afu-error.c  |  69 +++++++++++++
 drivers/fpga/dfl-afu-main.c   |  83 +++++++++++++++
 drivers/fpga/dfl-fme-error.c  |  71 +++++++++++++
 drivers/fpga/dfl-fme-main.c   |   6 ++
 drivers/fpga/dfl-pci.c        |  66 +++++++++++-
 drivers/fpga/dfl.c            | 233 +++++++++++++++++++++++++++++++++++++++++-
 drivers/fpga/dfl.h            |  51 +++++++++
 include/uapi/linux/fpga-dfl.h |  89 ++++++++++++++++
 9 files changed, 676 insertions(+), 9 deletions(-)

-- 
2.7.4
