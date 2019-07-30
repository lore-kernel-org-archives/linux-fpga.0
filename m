Return-Path: <SRS0=74yO=V3=chromium.org=swboyd@kernel.org>
Return-Path: <SRS0=74yO=V3=chromium.org=swboyd@kernel.org>
From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v6 14/57] fpga: Remove dev_err() usage after platform_get_irq()
Date: Tue, 30 Jul 2019 11:15:14 -0700
Message-Id: <20190730181557.90391-15-swboyd@chromium.org>
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-ID: <linux-fpga@vger.kernel.org>

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/fpga/zynq-fpga.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 31ef38e38537..ee7765049607 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -578,10 +578,8 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	init_completion(&priv->dma_done);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq < 0) {
-		dev_err(dev, "No IRQ available\n");
+	if (priv->irq < 0)
 		return priv->irq;
-	}
 
 	priv->clk = devm_clk_get(dev, "ref_clk");
 	if (IS_ERR(priv->clk)) {
-- 
Sent by a computer through tubes
