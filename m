Return-Path: <SRS0=eNah=BO=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=eNah=BO=intel.com=yilun.xu@kernel.org>
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v3 0/4] Modularization of DFL private feature drivers
Date: Tue,  4 Aug 2020 15:05:11 +0800
Message-Id: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com
List-ID: <linux-fpga@vger.kernel.org>

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

Main changes from v2:
- Add the doc for dfl-n3000-nios driver.
- Minor fixes for comments from Tom.

Xu Yilun (4):
  fpga: dfl: change data type of feature id to u16
  fpga: dfl: map feature mmio resources in their own feature drivers
  fpga: dfl: create a dfl bus type to support DFL devices
  fpga: dfl: add support for N3000 nios private feature

 Documentation/ABI/testing/sysfs-bus-dfl            |  15 +
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  18 +
 Documentation/fpga/dfl-n3000-nios.rst              |  39 ++
 Documentation/fpga/index.rst                       |   1 +
 drivers/fpga/Kconfig                               |  12 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-fme-perf.c                        |   2 +-
 drivers/fpga/dfl-n3000-nios.c                      | 518 +++++++++++++++++++++
 drivers/fpga/dfl-pci.c                             |  24 +-
 drivers/fpga/dfl.c                                 | 464 +++++++++++++++---
 drivers/fpga/dfl.h                                 | 101 +++-
 11 files changed, 1094 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
 create mode 100644 drivers/fpga/dfl-n3000-nios.c

-- 
2.7.4
