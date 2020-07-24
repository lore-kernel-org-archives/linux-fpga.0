Return-Path: <SRS0=kF30=BD=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=kF30=BD=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14547 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgGXCMh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 23 Jul 2020 22:12:37 -0400
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 0/4] Modularization of DFL private feature drivers
Date: Fri, 24 Jul 2020 10:09:11 +0800
Message-Id: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com

This patchset makes it possible to develop independent driver modules
for DFL private features. It also helps to leverage existing kernel
drivers to enable some IP blocks in DFL.

Patch #1: An improvement of feature id definition. The feature id will be used
	  as the key field for dfl device/driver matching.
Patch #2: Release the dfl mmio regions after enumeration, so that private
	  feature drivers could request mmio region in their own drivers.
Patch #3: Introduce the dfl bus, then dfl devices could be supported by
	  independent dfl drivers.
Patch #4: An example of the dfl driver for N3000 nios private feature.


Main changes from v1:
- Add the new Patch #1, to improve the feature id definition.
- Change the dfl bus uevent format.
- Change the dfl device's sysfs name format.
- refactor dfl_dev_add()
- Add the Patch #4 as an example of the dfl driver.
- A lot of minor fixes for comments from Hao and Tom.

Xu Yilun (4):
  fpga: dfl: change data type of feature id to u16
  fpga: dfl: map feature mmio resources in their own feature drivers
  fpga: dfl: create a dfl bus type to support DFL devices
  fpga: dfl: add support for N3000 nios private feature

 Documentation/ABI/testing/sysfs-bus-dfl            |  15 +
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  16 +
 drivers/fpga/Kconfig                               |  12 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-fme-perf.c                        |   2 +-
 drivers/fpga/dfl-n3000-nios.c                      | 483 +++++++++++++++++++++
 drivers/fpga/dfl-pci.c                             |  24 +-
 drivers/fpga/dfl.c                                 | 464 ++++++++++++++++----
 drivers/fpga/dfl.h                                 | 101 ++++-
 9 files changed, 1017 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 drivers/fpga/dfl-n3000-nios.c

-- 
2.7.4
