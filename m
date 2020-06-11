Return-Path: <SRS0=JcOM=7Y=lucaceresoli.net=luca@kernel.org>
Return-Path: <SRS0=JcOM=7Y=lucaceresoli.net=luca@kernel.org>
From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 2/5] fpga manager: xilinx-spi: valid for the 7 Series too
Date: Thu, 11 Jun 2020 23:11:41 +0200
Message-Id: <20200611211144.9421-2-luca@lucaceresoli.net>
In-Reply-To: <20200611211144.9421-1-luca@lucaceresoli.net>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-fpga@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
List-ID: <linux-fpga@vger.kernel.org>

The Xilinx 7-series uses the same protocol, mention that.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/fpga/xilinx-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 272ee0c22822..79106626c3f8 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Xilinx Spartan6 Slave Serial SPI Driver
+ * Xilinx Spartan6 and 7 Series Slave Serial SPI Driver
  *
  * Copyright (C) 2017 DENX Software Engineering
  *
-- 
2.27.0
