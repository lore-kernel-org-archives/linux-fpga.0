Return-Path: <SRS0=SwJh=AU=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=SwJh=AU=intel.com=yilun.xu@kernel.org>
From: Xu Yilun <yilun.xu@intel.com>
Subject: [RESEND PATCH 0/2] Bug fixes for FPGA DFL
Date: Thu,  9 Jul 2020 16:12:15 +0800
Message-Id: <1594282337-32125-1-git-send-email-yilun.xu@intel.com>
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: trix@redhat.com, lgoncalv@redhat.com, Xu Yilun <yilun.xu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

Resend these 2 fix patches since the to-be-fixed patches have been
merged to mainline.

Matthew Gerlach (1):
  fpga: dfl: fix bug in port reset handshake

Xu Yilun (1):
  fpga: dfl: pci: reduce the scope of variable 'ret'

 drivers/fpga/dfl-afu-main.c | 3 ++-
 drivers/fpga/dfl-pci.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.7.4
