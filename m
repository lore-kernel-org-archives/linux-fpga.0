Return-Path: <SRS0=Vslg=6L=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=Vslg=6L=intel.com=hao.wu@kernel.org>
From: Wu Hao <hao.wu@intel.com>
Subject: [PATCH v10 0/2] add performance reporting support to FPGA DFL drivers
Date: Mon, 27 Apr 2020 09:06:21 +0800
Message-Id: <1587949583-12058-1-git-send-email-hao.wu@intel.com>
To: will@kernel.org, mdf@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com, trix@redhat.com, bhu@redhat.com, rdunlap@infradead.org, Wu Hao <hao.wu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

Hi all,

This patchset adds performance reporting support for FPGA DFL drivers. It
introduces one pmu to expose userspace interfaces via standard perf API.
User could use standard perf tool to access perf events exposed via pmu.


Main changes from v9:
 - fix Randy's comments on documentation in patch #1.

Main changes from v8:
 - rebase against 5.7-rc1.

Main changes from v7:
 - rename pmu name from "fme%d" to "dfl_fme%d".
 - monitor cpu hotplug for cpumask sysfs and update cpumask sysfs doc.
 - add extra read for 64bit counter registers to avoid 2-32bit readl issue.

Main changes from v6:
 - add a new ABI/testing/ sysfs documentation in patch #2.
 - fix a warning reported by kbuild in patch #2.

Main changes from v5:
 - use dev_ext_attribute instead of fme_perf_event_attr.
 - use is_visible function to decide which events to expose per
   hardware capability, and add event_init checking for all events.

Main changes from v4:
 - rebase and clean up.
 - update Kconfig for PERF_EVENTS dependency.

Main changes from v3:
 - add more descriptions in doc, including how to use perf tool for these
   hardware counters. (patch #1)
 - use standard perf API instead of sysfs entries. (patch #2)


Wu Hao (1):
  fpga: dfl: fme: add performance reporting support

Xu Yilun (1):
  Documentation: fpga: dfl: add description for performance reporting
    support

 .../testing/sysfs-bus-event_source-devices-dfl_fme |  104 ++
 Documentation/fpga/dfl.rst                         |   84 ++
 drivers/fpga/Kconfig                               |    2 +-
 drivers/fpga/Makefile                              |    1 +
 drivers/fpga/dfl-fme-main.c                        |    4 +
 drivers/fpga/dfl-fme-perf.c                        | 1020 ++++++++++++++++++++
 drivers/fpga/dfl-fme.h                             |    2 +
 drivers/fpga/dfl.h                                 |    2 +
 8 files changed, 1218 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl_fme
 create mode 100644 drivers/fpga/dfl-fme-perf.c

-- 
1.8.3.1
