Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 2/5] fpga: bridge: fix obvious function documentation error
Date: Wed, 12 Sep 2018 09:43:24 -0500
Message-Id: <20180912144327.3130-3-atull@kernel.org>
In-Reply-To: <20180912144327.3130-1-atull@kernel.org>
References: <20180912144327.3130-1-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

fpga_bridge_dev_match() returns a FPGA bridge struct, not a
FPGA manager struct so s/manager/bridge/.

Signed-off-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 24b8f98..c983dac 100644
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
