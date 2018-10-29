Return-Path: <SRS0=bKZa=NJ=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=bKZa=NJ=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:32768 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeJ2XbV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Oct 2018 19:31:21 -0400
From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] fpga: xilinx-spi: Use unique FPGA manager names
Date: Mon, 29 Oct 2018 15:42:22 +0100
Message-Id: <20181029144222.26927-1-agust@denx.de>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: linux-fpga@vger.kernel.org
Cc: atull@kernel.org, mdf@kernel.org

Currently we have the same FPGA manager name for all registered
xlnx-slave-spi managers, so it is not clear which fpga manager
index belongs to which configuration interface (SPI slave device).
Use unique fpga manager name for each registered manager. With
this change we have names with SPI slave device name encoded in
the manager name string, e.g. like "xlnx-slave-spi spi1.2".

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/fpga/xilinx-spi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 469486be20c4..34b13d1c0f88 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -27,6 +27,7 @@ struct xilinx_spi_conf {
 	struct spi_device *spi;
 	struct gpio_desc *prog_b;
 	struct gpio_desc *done;
+	char mgr_name[64];
 };
 
 static enum fpga_mgr_states xilinx_spi_state(struct fpga_manager *mgr)
@@ -166,8 +167,11 @@ static int xilinx_spi_probe(struct spi_device *spi)
 		return PTR_ERR(conf->done);
 	}
 
-	mgr = devm_fpga_mgr_create(&spi->dev,
-				   "Xilinx Slave Serial FPGA Manager",
+	/* Register manager with unique name */
+	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
+		 dev_driver_string(&spi->dev), dev_name(&spi->dev));
+
+	mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
 				   &xilinx_spi_ops, conf);
 	if (!mgr)
 		return -ENOMEM;
-- 
2.17.1
