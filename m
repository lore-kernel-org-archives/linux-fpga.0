Return-Path: <SRS0=hO1J=4C=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=hO1J=4C=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv1 6/7] firmware: stratix10-svc: add the compatible value for intel agilex
Date: Fri, 14 Feb 2020 10:00:51 -0600
Message-Id: <1581696052-11540-7-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
To: gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Richard Gong <richard.gong@intel.com>

Add the compatible property value so we can reuse Intel Stratix10
Service Layer driver on Intel Agilex SoC platform.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/firmware/stratix10-svc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 7ffb42b..d5f0769 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -966,6 +966,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_free_memory);
 
 static const struct of_device_id stratix10_svc_drv_match[] = {
 	{.compatible = "intel,stratix10-svc"},
+	{.compatible = "intel,agilex-svc"},
 	{},
 };
 
-- 
2.7.4
