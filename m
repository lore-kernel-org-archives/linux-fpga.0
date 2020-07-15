Return-Path: <SRS0=SetD=A2=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=SetD=A2=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:59036 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgGOFmf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Jul 2020 01:42:35 -0400
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 0/2] Modularization of DFL private feature drivers
Date: Wed, 15 Jul 2020 13:38:16 +0800
Message-Id: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trix@redhat.com, lgoncalv@redhat.com, Xu Yilun <yilun.xu@intel.com>

This patchset makes it possible to develop independent driver modules
for DFL private features. It also helps to leverage existing kernel
drivers to enable some IP blocks in DFL.

Xu Yilun (2):
  fpga: dfl: map feature mmio resources in their own feature drivers
  fpga: dfl: create a dfl bus type to support DFL devices

 Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
 drivers/fpga/dfl-pci.c                  |  21 +-
 drivers/fpga/dfl.c                      | 435 +++++++++++++++++++++++++++-----
 drivers/fpga/dfl.h                      |  91 ++++++-
 4 files changed, 492 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl

-- 
2.7.4
