Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 2/5] ARM: socfpga: explicitly request exclusive reset control
Date: Tue,  1 Aug 2017 21:20:52 -0500
Message-Id: <1501640455-2719-3-git-send-email-atull@kernel.org>
In-Reply-To: <1501640455-2719-1-git-send-email-atull@kernel.org>
References: <1501640455-2719-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Moritz Fischer <moritz.fischer@ettus.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Philipp Zabel <p.zabel@pengutronix.de>

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <moritz.fischer@ettus.com>
Cc: linux-fpga@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-By: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/altera-hps2fpga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
index 3066b80..a18ff43 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -145,7 +145,8 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 	of_id = of_match_device(altera_fpga_of_match, dev);
 	priv = (struct altera_hps2fpga_data *)of_id->data;
 
-	priv->bridge_reset = of_reset_control_get_by_index(dev->of_node, 0);
+	priv->bridge_reset = of_reset_control_get_exclusive_by_index(dev->of_node,
+								     0);
 	if (IS_ERR(priv->bridge_reset)) {
 		dev_err(dev, "Could not get %s reset control\n", priv->name);
 		return PTR_ERR(priv->bridge_reset);
-- 
2.7.4
