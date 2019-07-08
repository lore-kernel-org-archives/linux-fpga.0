Return-Path: <SRS0=TJWw=VF=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=TJWw=VF=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:2175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbfGHHP4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 8 Jul 2019 03:15:56 -0400
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] fpga-manager: altera-ps-spi: Fix build error
Date: Mon, 8 Jul 2019 15:13:56 +0800
Message-ID: <20190708071356.50928-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: mdf@kernel.org, stillcompiling@gmail.com, atull@kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>

If BITREVERSE is m and FPGA_MGR_ALTERA_PS_SPI is y,
build fails:

drivers/fpga/altera-ps-spi.o: In function `altera_ps_write':
altera-ps-spi.c:(.text+0x4ec): undefined reference to `byte_rev_table'

Select BITREVERSE to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: fcfe18f885f6 ("fpga-manager: altera-ps-spi: use bitrev8x4")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/fpga/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 474f304..cdd4f73 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -40,6 +40,7 @@ config ALTERA_PR_IP_CORE_PLAT
 config FPGA_MGR_ALTERA_PS_SPI
 	tristate "Altera FPGA Passive Serial over SPI"
 	depends on SPI
+	select BITREVERSE
 	help
 	  FPGA manager driver support for Altera Arria/Cyclone/Stratix
 	  using the passive serial interface over SPI.
-- 
2.7.4
