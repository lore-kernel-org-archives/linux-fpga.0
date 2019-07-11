Return-Path: <SRS0=cAwu=VI=linux.intel.com=thor.thayer@kernel.org>
Return-Path: <SRS0=cAwu=VI=linux.intel.com=thor.thayer@kernel.org>
From: thor.thayer@linux.intel.com
Subject: [PATCH 2/3] fpga: altera-cvp: Preparation for V2 parts.
Date: Thu, 11 Jul 2019 15:32:49 -0500
Message-Id: <1562877170-23931-3-git-send-email-thor.thayer@linux.intel.com>
In-Reply-To: <1562877170-23931-1-git-send-email-thor.thayer@linux.intel.com>
References: <1562877170-23931-1-git-send-email-thor.thayer@linux.intel.com>
To: mdf@kernel.org, richard.gong@intel.com, agust@denx.de
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

From: Thor Thayer <thor.thayer@linux.intel.com>

In preparation for adding newer V2 parts that use a FIFO,
reorganize altera_cvp_chk_error() and change the write
function to block based.
V2 parts have a block size matching the FIFO while older
V1 parts write a 32 bit word at a time.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/fpga/altera-cvp.c | 72 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 04f2b2a072a7..59835f6f9b2d 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -140,6 +140,41 @@ static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
 	return -ETIMEDOUT;
 }
 
+static inline int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
+{
+	struct altera_cvp_conf *conf = mgr->priv;
+	u32 val;
+
+	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
+	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
+	if (val & VSE_CVP_STATUS_CFG_ERR) {
+		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
+			bytes);
+		return -EPROTO;
+	}
+	return 0;
+}
+
+static int altera_cvp_send_block(struct altera_cvp_conf *conf,
+				 const u32 *data, size_t len)
+{
+	int i, remainder;
+	u32 mask, words = len / sizeof(u32);
+
+	for (i = 0; i < words; i++)
+		conf->write_data(conf, *data++);
+
+	/* write up to 3 trailing bytes, if any */
+	remainder = len % sizeof(u32);
+	if (remainder) {
+		mask = BIT(remainder * 8) - 1;
+		if (mask)
+			conf->write_data(conf, *data & mask);
+	}
+
+	return 0;
+}
+
 static int altera_cvp_teardown(struct fpga_manager *mgr,
 			       struct fpga_image_info *info)
 {
@@ -262,39 +297,29 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 	return 0;
 }
 
-static inline int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
-{
-	struct altera_cvp_conf *conf = mgr->priv;
-	u32 val;
-
-	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
-	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
-	if (val & VSE_CVP_STATUS_CFG_ERR) {
-		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
-			bytes);
-		return -EPROTO;
-	}
-	return 0;
-}
-
 static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
 			    size_t count)
 {
 	struct altera_cvp_conf *conf = mgr->priv;
 	const u32 *data;
-	size_t done, remaining;
+	size_t done, remaining, len;
 	int status = 0;
-	u32 mask;
 
 	/* STEP 9 - write 32-bit data from RBF file to CVP data register */
 	data = (u32 *)buf;
 	remaining = count;
 	done = 0;
 
-	while (remaining >= 4) {
-		conf->write_data(conf, *data++);
-		done += 4;
-		remaining -= 4;
+	while (remaining) {
+		if (remaining >= sizeof(u32))
+			len = sizeof(u32);
+		else
+			len = remaining;
+
+		altera_cvp_send_block(conf, data, len);
+		data++;
+		done += len;
+		remaining -= len;
 
 		/*
 		 * STEP 10 (optional) and STEP 11
@@ -312,11 +337,6 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
 		}
 	}
 
-	/* write up to 3 trailing bytes, if any */
-	mask = BIT(remaining * 8) - 1;
-	if (mask)
-		conf->write_data(conf, *data & mask);
-
 	if (altera_cvp_chkcfg)
 		status = altera_cvp_chk_error(mgr, count);
 
-- 
2.7.4
