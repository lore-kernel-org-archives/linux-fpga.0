Return-Path: <SRS0=10uA=AY=intel.com=yilun.xu@kernel.org>
Return-Path: <SRS0=10uA=AY=intel.com=yilun.xu@kernel.org>
From: Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 2/2] fpga: dfl: fix bug in port reset handshake
Date: Mon, 13 Jul 2020 14:10:03 +0800
Message-Id: <1594620603-18029-3-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1594620603-18029-1-git-send-email-yilun.xu@intel.com>
References: <1594620603-18029-1-git-send-email-yilun.xu@intel.com>
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lgoncalv@redhat.com, trix@redhat.com, Matthew Gerlach <matthew.gerlach@linux.intel.com>, Xu Yilun <yilun.xu@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

When putting the port in reset, driver must wait for the soft reset
acknowledgment bit instead of the soft reset bit.

Fixes: 47c1b19c160f (fpga: dfl: afu: add port ops support)
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v2: add Reviewed-by of Tom, no code change.
---
 drivers/fpga/dfl-afu-main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 7c84fee..753cda4 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -83,7 +83,8 @@ int __afu_port_disable(struct platform_device *pdev)
 	 * on this port and minimum soft reset pulse width has elapsed.
 	 * Driver polls port_soft_reset_ack to determine if reset done by HW.
 	 */
-	if (readq_poll_timeout(base + PORT_HDR_CTRL, v, v & PORT_CTRL_SFTRST,
+	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
+			       v & PORT_CTRL_SFTRST_ACK,
 			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
 		dev_err(&pdev->dev, "timeout, fail to reset device\n");
 		return -ETIMEDOUT;
-- 
2.7.4
