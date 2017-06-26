Return-Path: <SRS0=SP6n=57=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=SP6n=57=intel.com=hao.wu@kernel.org>
From: Wu Hao <hao.wu@intel.com>
Subject: [PATCH v2 03/22] fpga: bridge: remove OF dependency for fpga-bridge
Date: Mon, 26 Jun 2017 09:51:59 +0800
Message-Id: <1498441938-14046-4-git-send-email-hao.wu@intel.com>
In-Reply-To: <1498441938-14046-1-git-send-email-hao.wu@intel.com>
References: <1498441938-14046-1-git-send-email-hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com, yi.z.zhang@intel.com, hao.wu@intel.com
List-ID: <linux-fpga@vger.kernel.org>

This patch removes OF dependency of fpga-bridge, it allows drivers
to use fpga-bridge class without device tree support.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index ed600d5..c1d8f41 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -75,7 +75,6 @@ config FPGA_MGR_ZYNQ_FPGA
 
 config FPGA_BRIDGE
 	tristate "FPGA Bridge Framework"
-	depends on OF
 	help
 	  Say Y here if you want to support bridges connected between host
 	  processors and FPGAs or between FPGAs.
-- 
1.8.3.1
