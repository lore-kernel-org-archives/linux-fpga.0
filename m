Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH v2 6/8] fpga: bridge: fix obvious function documentation error
Date: Tue,  4 Sep 2018 16:22:35 -0500
Message-Id: <20180904212237.3078-7-atull@kernel.org>
In-Reply-To: <20180904212237.3078-1-atull@kernel.org>
References: <20180904212237.3078-1-atull@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, Alan Tull <atull@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

fpga_bridge_dev_match() returns a FPGA bridge struct, not a
FPGA manager struct so s/manager/bridge/.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: no change in v2 of patchset
---
 drivers/fpga/fpga-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index c39d35f..7b0071a 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -125,7 +125,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
  *
  * Given a device, get an exclusive reference to a fpga bridge.
  *
- * Return: fpga manager struct or IS_ERR() condition containing error code.
+ * Return: fpga bridge struct or IS_ERR() condition containing error code.
  */
 struct fpga_bridge *fpga_bridge_get(struct device *dev,
 				    struct fpga_image_info *info)
-- 
2.7.4
