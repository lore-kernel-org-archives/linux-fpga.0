Return-Path: <SRS0=gzMe=5J=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=gzMe=5J=intel.com=yilun.xu@kernel.org>
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v3 0/7] Add interrupt support to FPGA DFL drivers
Date: Tue, 24 Mar 2020 16:32:36 +0800
Message-Id: <1585038763-22944-1-git-send-email-yilun.xu@intel.com>
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trix@redhat.com, bhu@redhat.com, Xu Yilun <yilun.xu@intel.com>
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

Main changes from v1:
 - Early validating irq table for each feature in parse_feature_irq()
   in Patch #1.
 - Changes IOCTL interfaces. use DFL_FPGA_FME/PORT_XXX_GET_IRQ_NUM
   instead of DFL_FPGA_FME/PORT_XXX_GET_INFO, delete flag field for
   DFL_FPGA_FME/PORT_XXX_SET_IRQ param

Main changes from v2:
 - put parse_feature_irqs() inside create_feature_instance().
 - refines code for dfl_fpga_set_irq_triggers, delete local variable j.
 - put_user() instead of copy_to_user() for DFL_FPGA_XXX_GET_IRQ_NUM IOCTL

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
 drivers/fpga/dfl-afu-error.c  |  60 +++++++++++
 drivers/fpga/dfl-afu-main.c   |  74 +++++++++++++
 drivers/fpga/dfl-fme-error.c  |  62 +++++++++++
 drivers/fpga/dfl-fme-main.c   |   6 ++
 drivers/fpga/dfl-pci.c        |  76 +++++++++++--
 drivers/fpga/dfl.c            | 245 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h            |  51 +++++++++
 include/uapi/linux/fpga-dfl.h |  75 +++++++++++++
 9 files changed, 657 insertions(+), 9 deletions(-)

-- 
2.7.4
