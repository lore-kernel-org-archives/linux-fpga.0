Return-Path: <SRS0=IFE+=BO=analog.com=alexandru.Ardelean@kernel.org>
Return-Path: <SRS0=IFE+=BO=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/6] clk: axi-clkgen: add support for ZynqMP (UltraScale)
Date: Tue, 4 Aug 2020 14:06:55 +0300
Message-ID: <20200804110658.40911-4-alexandru.ardelean@analog.com>
In-Reply-To: <20200804110658.40911-1-alexandru.ardelean@analog.com>
References: <20200804110658.40911-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, mdf@kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>, Alexandru Ardelean <alexandru.ardelean@analog.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Dragos Bogdan <dragos.bogdan@analog.com>

This IP core also works and is supported on the Xilinx ZynqMP (UltraScale)
FPGA boards.
This patch enables the driver to be available on these platforms as well.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 69934c0c3dd8..eaabc758a7e4 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -240,7 +240,7 @@ config CLK_TWL6040
 
 config COMMON_CLK_AXI_CLKGEN
 	tristate "AXI clkgen driver"
-	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || MICROBLAZE || COMPILE_TEST
 	help
 	  Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
 	  FPGAs. It is commonly used in Analog Devices' reference designs.
-- 
2.17.1
