Return-Path: <SRS0=8V10=4M=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=8V10=4M=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23673 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXAmy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 23 Feb 2020 19:42:54 -0500
From: Wu Hao <hao.wu@intel.com>
Subject: [PATCH v8 0/2] add performance reporting support to FPGA DFL drivers
Date: Mon, 24 Feb 2020 08:21:45 +0800
Message-Id: <1582503707-10737-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: mdf@kernel.org, will@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com, Wu Hao <hao.wu@intel.com>

Hi all,

This patchset adds performance reporting support for FPGA DFL drivers. It
introduces one pmu to expose userspace interfaces via standard perf API.
User could use standard perf tool to access perf events exposed via pmu.

This patchset is generated based on 5.6-rc2.

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
 drivers/fpga/dfl-fme-perf.c                        | 1021 ++++++++++++++++++++
 drivers/fpga/dfl-fme.h                             |    2 +
 drivers/fpga/dfl.h                                 |    2 +
 8 files changed, 1219 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl_fme
 create mode 100644 drivers/fpga/dfl-fme-perf.c

-- 
1.8.3.1
