Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 3/5] fpga: altera-hps2fpga: add NULL check on of_match_device() return value
Date: Tue,  1 Aug 2017 21:20:53 -0500
Message-Id: <1501640455-2719-4-git-send-email-atull@kernel.org>
In-Reply-To: <1501640455-2719-1-git-send-email-atull@kernel.org>
References: <1501640455-2719-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-ID: <linux-fpga@vger.kernel.org>

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Check return value from call to of_match_device()
in order to prevent a NULL pointer dereference.

In case of NULL print error message and return -ENODEV

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/altera-hps2fpga.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
index a18ff43..e6c948b 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -143,6 +143,11 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 	int ret;
 
 	of_id = of_match_device(altera_fpga_of_match, dev);
+	if (!of_id) {
+		dev_err(dev, "failed to match device\n");
+		return -ENODEV;
+	}
+
 	priv = (struct altera_hps2fpga_data *)of_id->data;
 
 	priv->bridge_reset = of_reset_control_get_exclusive_by_index(dev->of_node,
-- 
2.7.4
