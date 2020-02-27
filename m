Return-Path: <SRS0=KltO=4P=analog.com=Sergiu.Cuciurean@kernel.org>
Return-Path: <SRS0=KltO=4P=analog.com=Sergiu.Cuciurean@kernel.org>
From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: [PATCH] fpga: ice40-spi: Use new structure for SPI transfer delays
Date: Thu, 27 Feb 2020 14:09:32 +0200
Message-ID: <20200227120932.12542-1-sergiu.cuciurean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
To: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: mdf@kernel.org, Sergiu Cuciurean <sergiu.cuciurean@analog.com>
List-ID: <linux-fpga@vger.kernel.org>

In a recent change to the SPI subsystem [1], a new `delay` struct was added
to replace the `delay_usecs`. This change replaces the current
`delay_usecs` with `delay` for this driver.

The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
that both `delay_usecs` & `delay` are used (in this order to preserve
backwards compatibility).

[1] commit bebcfd272df6 ("spi: introduce `delay` field for
`spi_transfer` + spi_transfer_delay_exec()")

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/fpga/ice40-spi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 56e112e14a10..8d689fea0dab 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -46,10 +46,16 @@ static int ice40_fpga_ops_write_init(struct fpga_manager *mgr,
 	struct spi_message message;
 	struct spi_transfer assert_cs_then_reset_delay = {
 		.cs_change   = 1,
-		.delay_usecs = ICE40_SPI_RESET_DELAY
+		.delay = {
+			.value = ICE40_SPI_RESET_DELAY,
+			.unit = SPI_DELAY_UNIT_USECS
+		}
 	};
 	struct spi_transfer housekeeping_delay_then_release_cs = {
-		.delay_usecs = ICE40_SPI_HOUSEKEEPING_DELAY
+		.delay = {
+			.value = ICE40_SPI_HOUSEKEEPING_DELAY,
+			.unit = SPI_DELAY_UNIT_USECS
+		}
 	};
 	int ret;
 
-- 
2.17.1
