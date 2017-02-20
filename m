Return-Path: <mdf@kernel.org>
Return-Path: <mdf@kernel.org>
From: mdf@kernel.org
Subject: [PATCH v2 2/3] fpga: zynq: Add support for encrypted bitstreams
Date: Mon, 20 Feb 2017 12:55:22 -0800
Message-Id: <1487624123-13579-2-git-send-email-mdf@kernel.org>
In-Reply-To: <1487624123-13579-1-git-send-email-mdf@kernel.org>
References: <1487624123-13579-1-git-send-email-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

From: Moritz Fischer <mdf@kernel.org>

Add support for encrypted bitstreams. For this to work the system
must be booted in secure mode.

In order for on-the-fly decryption to work, the PCAP clock rate
needs to be lowered via the PCAP_RATE_EN bit.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
Cc: Alan Tull <atull@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fpga@vger.kernel.org
---

Changes from v1:
- Renamed flag from FPGA_MGR_DECRYPT_BITSTREAM->FPGA_MGR_ENCRYPTED_BITSTREAM

---
 drivers/fpga/zynq-fpga.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 34cb981..70b15b3 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -72,6 +72,10 @@
 #define CTRL_PCAP_PR_MASK		BIT(27)
 /* Enable PCAP */
 #define CTRL_PCAP_MODE_MASK		BIT(26)
+/* Lower rate to allow decrypt on the fly */
+#define CTRL_PCAP_RATE_EN_MASK		BIT(25)
+/* System booted in secure mode */
+#define CTRL_SEC_EN_MASK		BIT(7)
 
 /* Miscellaneous Control Register bit definitions */
 /* Internal PCAP loopback */
@@ -266,6 +270,17 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
 	if (err)
 		return err;
 
+	/* check if bitstream is encrypted & and system's still secure */
+	if (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM) {
+		ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
+		if (!(ctrl & CTRL_SEC_EN_MASK)) {
+			dev_err(&mgr->dev,
+				"System not secure, can't use crypted bitstreams\n");
+			err = -EINVAL;
+			goto out_err;
+		}
+	}
+
 	/* don't globally reset PL if we're doing partial reconfig */
 	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
 		if (!zynq_fpga_has_sync(buf, count)) {
@@ -337,12 +352,19 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
 
 	/* set configuration register with following options:
 	 * - enable PCAP interface
-	 * - set throughput for maximum speed
+	 * - set throughput for maximum speed (if bistream not crypted)
 	 * - set CPU in user mode
 	 */
 	ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
-	zynq_fpga_write(priv, CTRL_OFFSET,
-			(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK | ctrl));
+	if (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM)
+		zynq_fpga_write(priv, CTRL_OFFSET,
+				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
+				 | CTRL_PCAP_RATE_EN_MASK | ctrl));
+	else
+		zynq_fpga_write(priv, CTRL_OFFSET,
+				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
+				 | ctrl));
+
 
 	/* We expect that the command queue is empty right now. */
 	status = zynq_fpga_read(priv, STATUS_OFFSET);
-- 
2.7.4
