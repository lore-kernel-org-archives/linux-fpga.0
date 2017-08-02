Return-Path: <atull@kernel.org>
Return-Path: <atull@kernel.org>
From: Alan Tull <atull@kernel.org>
Subject: [PATCH 4/5] fpga: altera-hps2fpga: fix multiple init of l3_remap_lock
Date: Tue,  1 Aug 2017 21:20:54 -0500
Message-Id: <1501640455-2719-5-git-send-email-atull@kernel.org>
In-Reply-To: <1501640455-2719-1-git-send-email-atull@kernel.org>
References: <1501640455-2719-1-git-send-email-atull@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>, "# 4 . 10+" <stable@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

From: Ian Abbott <abbotti@mev.co.uk>

The global spinlock `l3_remap_lock` is reinitialized every time the
"probe" function `alt_fpga_bridge_probe()` is called.  It should only be
initialized once.  Use `DEFINE_SPINLOCK()` to initialize it statically.

Fixes: e5f8efa5c8bf ("ARM: socfpga: fpga bridge driver support")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Reviewed-By: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/altera-hps2fpga.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
index e6c948b..406d2f1 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -66,7 +66,7 @@ static int alt_hps2fpga_enable_show(struct fpga_bridge *bridge)
 
 /* The L3 REMAP register is write only, so keep a cached value. */
 static unsigned int l3_remap_shadow;
-static spinlock_t l3_remap_lock;
+static DEFINE_SPINLOCK(l3_remap_lock);
 
 static int _alt_hps2fpga_enable_set(struct altera_hps2fpga_data *priv,
 				    bool enable)
@@ -177,8 +177,6 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	spin_lock_init(&l3_remap_lock);
-
 	if (!of_property_read_u32(dev->of_node, "bridge-enable", &enable)) {
 		if (enable > 1) {
 			dev_warn(dev, "invalid bridge-enable %u > 1\n", enable);
-- 
2.7.4
