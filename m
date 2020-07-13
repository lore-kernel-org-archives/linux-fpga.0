Return-Path: <SRS0=10uA=AY=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=10uA=AY=intel.com=yilun.xu@kernel.org>
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 0/2] Bug fixes for FPGA DFL
Date: Mon, 13 Jul 2020 14:10:01 +0800
Message-Id: <1594620603-18029-1-git-send-email-yilun.xu@intel.com>
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lgoncalv@redhat.com, trix@redhat.com, Xu Yilun <yilun.xu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

2 fix patches for FPGA DFL.

v2 adds Reviewed-by of Tom. No code change.

Matthew Gerlach (1):
  fpga: dfl: fix bug in port reset handshake

Xu Yilun (1):
  fpga: dfl: pci: reduce the scope of variable 'ret'

 drivers/fpga/dfl-afu-main.c | 3 ++-
 drivers/fpga/dfl-pci.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.7.4
