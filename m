Return-Path: <SRS0=JcOM=7Y=lucaceresoli.net=luca@kernel.org>
Return-Path: <SRS0=JcOM=7Y=lucaceresoli.net=luca@kernel.org>
From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 3/5] fpga manager: xilinx-spi: remove unneeded, mistyped variables
Date: Thu, 11 Jun 2020 23:11:42 +0200
Message-Id: <20200611211144.9421-3-luca@lucaceresoli.net>
In-Reply-To: <20200611211144.9421-1-luca@lucaceresoli.net>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-fpga@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
List-ID: <linux-fpga@vger.kernel.org>

Using variables does not add readability here: parameters passed
to udelay*() are obviously in microseconds and their meaning is clear
from the context.

The type is also wrong, udelay expects an unsigned long.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/fpga/xilinx-spi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 79106626c3f8..799ae04301be 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -41,8 +41,6 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
 				 const char *buf, size_t count)
 {
 	struct xilinx_spi_conf *conf = mgr->priv;
-	const size_t prog_latency_7500us = 7500;
-	const size_t prog_pulse_1us = 1;
 
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
@@ -51,7 +49,7 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
 
 	gpiod_set_value(conf->prog_b, 1);
 
-	udelay(prog_pulse_1us); /* min is 500 ns */
+	udelay(1); /* min is 500 ns */
 
 	gpiod_set_value(conf->prog_b, 0);
 
@@ -61,7 +59,7 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
 	}
 
 	/* program latency */
-	usleep_range(prog_latency_7500us, prog_latency_7500us + 100);
+	usleep_range(7500, 7600);
 	return 0;
 }
 
-- 
2.27.0
