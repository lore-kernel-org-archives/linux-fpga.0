Return-Path: <SRS0=KltO=4P=analog.com=Sergiu.Cuciurean@kernel.org>
Return-Path: <SRS0=KltO=4P=analog.com=Sergiu.Cuciurean@kernel.org>
From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: [PATCH] fpga: machxo2-spi: Use new structure for SPI transfer delays
Date: Thu, 27 Feb 2020 16:24:14 +0200
Message-ID: <20200227142414.16547-1-sergiu.cuciurean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
To: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
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
 drivers/fpga/machxo2-spi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 4d8a87641587..b316369156fe 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -157,7 +157,8 @@ static int machxo2_cleanup(struct fpga_manager *mgr)
 	spi_message_init(&msg);
 	tx[1].tx_buf = &refresh;
 	tx[1].len = sizeof(refresh);
-	tx[1].delay_usecs = MACHXO2_REFRESH_USEC;
+	tx[1].delay.value = MACHXO2_REFRESH_USEC;
+	tx[1].delay.unit = SPI_DELAY_UNIT_USECS;
 	spi_message_add_tail(&tx[1], &msg);
 	ret = spi_sync(spi, &msg);
 	if (ret)
@@ -208,7 +209,8 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 	spi_message_init(&msg);
 	tx[0].tx_buf = &enable;
 	tx[0].len = sizeof(enable);
-	tx[0].delay_usecs = MACHXO2_LOW_DELAY_USEC;
+	tx[0].delay.value = MACHXO2_LOW_DELAY_USEC;
+	tx[0].delay.unit = SPI_DELAY_UNIT_USECS;
 	spi_message_add_tail(&tx[0], &msg);
 
 	tx[1].tx_buf = &erase;
@@ -269,7 +271,8 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
 		spi_message_init(&msg);
 		tx.tx_buf = payload;
 		tx.len = MACHXO2_BUF_SIZE;
-		tx.delay_usecs = MACHXO2_HIGH_DELAY_USEC;
+		tx.delay.value = MACHXO2_HIGH_DELAY_USEC;
+		tx.delay.unit = SPI_DELAY_UNIT_USECS;
 		spi_message_add_tail(&tx, &msg);
 		ret = spi_sync(spi, &msg);
 		if (ret) {
@@ -317,7 +320,8 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 		spi_message_init(&msg);
 		tx[1].tx_buf = &refresh;
 		tx[1].len = sizeof(refresh);
-		tx[1].delay_usecs = MACHXO2_REFRESH_USEC;
+		tx[1].delay.value = MACHXO2_REFRESH_USEC;
+		tx[1].delay.unit = SPI_DELAY_UNIT_USECS;
 		spi_message_add_tail(&tx[1], &msg);
 		ret = spi_sync(spi, &msg);
 		if (ret)
-- 
2.17.1
