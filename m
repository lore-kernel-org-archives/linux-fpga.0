Return-Path: <SRS0=dZuy=7R=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=dZuy=7R=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:40369 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgFDIzx (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Jun 2020 04:55:53 -0400
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v6 0/7] Add interrupt support to FPGA DFL drivers
Date: Thu,  4 Jun 2020 16:52:10 +0800
Message-Id: <1591260737-15211-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trix@redhat.com, bhu@redhat.com, mtosatti@redhat.com, gregkh@linuxfoundation.org, Xu Yilun <yilun.xu@intel.com>

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

Main changes from v3:
 - rebased to 5.7-rc1.
 - fail the dfl enumeration when irq parsing error happens.
 - Add 2 helper functions in dfl.c to handle generic irq ioctls in feature
   drivers.

Main changes from v4:
 - Minor fixes for Hao's comments.

Main changes from v5:
 - Remove unnecessary type casting in Patch #1 & #3.
 - Minor fixes for Moritz's comments.

Xu Yilun (7):
  fpga: dfl: parse interrupt info for feature devices on enumeration
  fpga: dfl: pci: add irq info for feature devices enumeration
  fpga: dfl: introduce interrupt trigger setting API
  fpga: dfl: afu: add interrupt support for port error reporting
  fpga: dfl: fme: add interrupt support for global error reporting
  fpga: dfl: afu: add AFU interrupt support
  Documentation: fpga: dfl: add descriptions for interrupt related
    interfaces.

 Documentation/fpga/dfl.rst    |  19 +++
 drivers/fpga/dfl-afu-error.c  |  17 +++
 drivers/fpga/dfl-afu-main.c   |  32 +++++
 drivers/fpga/dfl-fme-error.c  |  18 +++
 drivers/fpga/dfl-fme-main.c   |   6 +
 drivers/fpga/dfl-pci.c        |  81 +++++++++--
 drivers/fpga/dfl.c            | 308 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h            |  57 ++++++++
 include/uapi/linux/fpga-dfl.h |  82 +++++++++++
 9 files changed, 611 insertions(+), 9 deletions(-)

-- 
2.7.4
