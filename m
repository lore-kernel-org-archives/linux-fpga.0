Return-Path: <SRS0=FSxJ=6A=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=FSxJ=6A=intel.com=yilun.xu@kernel.org>
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 0/2] Bug fixes for FPGA DFL
Date: Thu, 16 Apr 2020 11:11:50 +0800
Message-Id: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trix@redhat.com, bhu@redhat.com, Xu Yilun <yilun.xu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

Patch #1 fixes lkp cppcheck warnings in dfl-pci.c
Patch #2 fixes bug in dfl port reset handshake

Matthew Gerlach (1):
  fpga: dfl: fix bug in port reset handshake

Xu Yilun (1):
  fpga: dfl: pci: reduce the scope of variable 'ret'

 drivers/fpga/dfl-afu-main.c | 3 ++-
 drivers/fpga/dfl-pci.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.7.4
