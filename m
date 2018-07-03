Return-Path: <SRS0=lG9C=JT=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=lG9C=JT=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-sn1nam02on0064.outbound.protection.outlook.com ([104.47.36.64]:29776
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932702AbeGCIoz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Jul 2018 04:44:55 -0400
From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [RFC PATCH 2/2] fpga: zynq-fpga: Add support for readback of configuration registers
Date: Tue, 3 Jul 2018 14:14:33 +0530
Message-ID: <1530607473-6362-1-git-send-email-appana.durga.rao@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: atull@kernel.org, mdf@kernel.org, michal.simek@xilinx.com, navam@xilinx.com
Cc: linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

This patch adds support for Read-back of
configuration registers in zynq.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 drivers/fpga/zynq-fpga.c | 254 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 70b15b3..31d39f0 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -25,6 +25,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mutex.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/pm.h>
@@ -127,6 +128,49 @@
 /* Disable global resets */
 #define FPGA_RST_NONE_MASK		0x0
 
+/* Configuration Registers */
+#define TYPE1_CRC_OFFSET	0x0
+#define TYPE1_FAR_OFFSET	0x1
+#define TYPE1_FDRI_OFFSET	0x2
+#define TYPE1_FDRO_OFFSET	0x3
+#define TYPE1_CMD_OFFSET	0x4
+#define TYPE1_CTRL0_OFFSET	0x5
+#define TYPE1_MASK_OFFSET	0x6
+#define TYPE1_STAT_OFFSET	0x7
+#define TYPE1_LOUT_OFFSET	0x8
+#define TYPE1_COR0_OFFSET	0x9
+#define TYPE1_MFWR_OFFSET	0xa
+#define TYPE1_CBC_OFFSET	0xb
+#define TYPE1_IDCODE_OFFSET	0xc
+#define TYPE1_AXSS_OFFSET	0xd
+#define TYPE1_COR1_OFFSET	0xe
+#define TYPE1_WBSTR_OFFSET	0x10
+#define TYPE1_TIMER_OFFSET	0x11
+#define TYPE1_BOOTSTS_OFFSET	0x16
+#define TYPE1_CTRL1_OFFSET	0x18
+#define TYPE1_BSPI_OFFSET	0x1f
+
+/* Masks for Configuration registers */
+#define RCFG_CMD_MASK		0x00000004
+#define START_CMD_MASK		0x00000005
+#define RCRC_CMD_MASK		0x00000007
+#define SHUTDOWN_CMD_MASK	0x0000000B
+#define DESYNC_WORD_MASK	0x0000000D
+#define BUSWIDTH_SYNCWORD_MASK	0x000000BB
+#define NOOP_WORD_MASK		0x20000000
+#define BUSWIDTH_DETECT_MASK	0x11220044
+#define SYNC_WORD_MASK		0xAA995566
+#define DUMMY_WORD_MASK		0xFFFFFFFF
+
+#define TYPE1_HDR_SHIFT		29
+#define TYPE1_REG_SHIFT		13
+#define TYPE1_OP_SHIFT		27
+#define TYPE1_OPCODE_NOOP	0
+#define TYPE1_OPCODE_READ	1
+#define TYPE1_OPCODE_WRITE	2
+
+#define CFGREG_SRCDMA_SIZE	0x40
+
 struct zynq_fpga_priv {
 	int irq;
 	struct clk *clk;
@@ -140,6 +184,7 @@ struct zynq_fpga_priv {
 	struct scatterlist *cur_sg;
 
 	struct completion dma_done;
+	struct mutex mutex_lock;
 };
 
 static inline void zynq_fpga_write(struct zynq_fpga_priv *priv, u32 offset,
@@ -164,6 +209,15 @@ static inline void zynq_fpga_set_irq(struct zynq_fpga_priv *priv, u32 enable)
 	zynq_fpga_write(priv, INT_MASK_OFFSET, ~enable);
 }
 
+static void zynq_fpga_dma_xfer(struct zynq_fpga_priv *priv, u32 srcaddr,
+			       u32 srclen, u32 dstaddr, u32 dstlen)
+{
+	zynq_fpga_write(priv, DMA_SRC_ADDR_OFFSET, srcaddr);
+	zynq_fpga_write(priv, DMA_DST_ADDR_OFFSET, dstaddr);
+	zynq_fpga_write(priv, DMA_SRC_LEN_OFFSET, srclen);
+	zynq_fpga_write(priv, DMA_DEST_LEN_OFFSET, dstlen);
+}
+
 /* Must be called with dma_lock held */
 static void zynq_step_dma(struct zynq_fpga_priv *priv)
 {
@@ -546,12 +600,211 @@ static enum fpga_mgr_states zynq_fpga_ops_state(struct fpga_manager *mgr)
 	return FPGA_MGR_STATE_UNKNOWN;
 }
 
+static int zynq_type1_pkt(u8 reg, u8 opcode, u16 size)
+{
+	/*
+	 * Type 1 Packet Header Format
+	 * The header section is always a 32-bit word.
+	 *
+	 * HeaderType | Opcode | Register Address | Reserved | Word Count
+	 * [31:29]      [28:27]         [26:13]      [12:11]     [10:0]
+	 * --------------------------------------------------------------
+	 *   001          xx      RRRRRRRRRxxxxx        RR      xxxxxxxxxxx
+	 *
+	 * @R: means the bit is not used and reserved for future use.
+	 * The reserved bits should be written as 0s.
+	 *
+	 * Generating the Type 1 packet header which involves sifting of Type1
+	 * Header Mask, Register value and the OpCode which is 01 in this case
+	 * as only read operation is to be carried out and then performing OR
+	 * operation with the Word Length.
+	 */
+	return (((1 << TYPE1_HDR_SHIFT) |
+		(reg << TYPE1_REG_SHIFT) |
+		(opcode << TYPE1_OP_SHIFT)) | size);
+
+}
+
+static int zynq_fpga_getconfigreg(struct fpga_manager *mgr, u8 reg)
+{
+	struct zynq_fpga_priv *priv;
+	int ret = 0, cmdindex, src_offset;
+	int *srcbuf, *dstbuf;
+	dma_addr_t src_dma_addr, dst_dma_addr;
+	u32 status, intr_status;
+
+	priv = mgr->priv;
+
+	srcbuf = dma_alloc_coherent(mgr->dev.parent, CFGREG_SRCDMA_SIZE,
+				    &src_dma_addr, GFP_KERNEL);
+	if (!srcbuf)
+		return -ENOMEM;
+
+	dstbuf = dma_alloc_coherent(mgr->dev.parent, sizeof(dstbuf),
+				    &dst_dma_addr, GFP_KERNEL);
+	if (!dstbuf)
+		goto free_srcbuf;
+
+	cmdindex = 0;
+	srcbuf[cmdindex++] = DUMMY_WORD_MASK;
+	srcbuf[cmdindex++] = BUSWIDTH_SYNCWORD_MASK;
+	srcbuf[cmdindex++] = BUSWIDTH_DETECT_MASK;
+	srcbuf[cmdindex++] = DUMMY_WORD_MASK;
+	srcbuf[cmdindex++] = SYNC_WORD_MASK;
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+	srcbuf[cmdindex++] = zynq_type1_pkt(reg, TYPE1_OPCODE_READ, 1);
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+
+	ret = zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status,
+				     status & STATUS_PCFG_INIT_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
+		goto free_dstbuf;
+	}
+
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
+
+	zynq_fpga_dma_xfer(priv, src_dma_addr, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_D_P_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for D_P_DONE\n");
+		goto free_dstbuf;
+	}
+	zynq_fpga_set_irq(priv, intr_status);
+	zynq_fpga_dma_xfer(priv, DMA_INVALID_ADDRESS, 0, dst_dma_addr, 1);
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_DMA_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for DMA DONE\n");
+		goto free_dstbuf;
+	}
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_D_P_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for D_P_DONE\n");
+		goto free_dstbuf;
+	}
+	src_offset = cmdindex * 4;
+	cmdindex = 0;
+	srcbuf[cmdindex++] = zynq_type1_pkt(TYPE1_CMD_OFFSET,
+					    TYPE1_OPCODE_WRITE, 1);
+	srcbuf[cmdindex++] = DESYNC_WORD_MASK;
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+	srcbuf[cmdindex++] = NOOP_WORD_MASK;
+	zynq_fpga_dma_xfer(priv, src_dma_addr + src_offset, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_DMA_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for DMA DONE\n");
+		goto free_dstbuf;
+	}
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_D_P_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for D_P_DONE\n");
+		goto free_dstbuf;
+	}
+
+	ret = *dstbuf;
+
+free_dstbuf:
+	dma_free_coherent(mgr->dev.parent, sizeof(dstbuf), dstbuf,
+			  dst_dma_addr);
+free_srcbuf:
+	dma_free_coherent(mgr->dev.parent, CFGREG_SRCDMA_SIZE, srcbuf,
+			  src_dma_addr);
+
+	return ret;
+}
+
+static int zynq_fpga_ops_read(struct fpga_manager *mgr, struct seq_file *s)
+{
+	struct zynq_fpga_priv *priv;
+	int err;
+
+	priv = mgr->priv;
+
+	if (!mutex_trylock(&priv->mutex_lock))
+		return -EBUSY;
+
+	err = clk_enable(priv->clk);
+	if (err)
+		goto err_unlock;
+
+	seq_puts(s, "zynq FPGA Configuration register contents are\n");
+	seq_printf(s, "CRC --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CRC_OFFSET)));
+	seq_printf(s, "FAR --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_FAR_OFFSET)));
+	seq_printf(s, "FDRI --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_FDRI_OFFSET)));
+	seq_printf(s, "FDRO --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_FDRO_OFFSET)));
+	seq_printf(s, "CMD --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CMD_OFFSET)));
+	seq_printf(s, "CTRL0 --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CTRL0_OFFSET)));
+	seq_printf(s, "MASK --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_MASK_OFFSET)));
+	seq_printf(s, "STAT --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_STAT_OFFSET)));
+	seq_printf(s, "LOUT --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_LOUT_OFFSET)));
+	seq_printf(s, "COR0 --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_COR0_OFFSET)));
+	seq_printf(s, "MFWR --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_MFWR_OFFSET)));
+	seq_printf(s, "CBC --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CBC_OFFSET)));
+	seq_printf(s, "IDCODE --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_IDCODE_OFFSET)));
+	seq_printf(s, "AXSS --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_AXSS_OFFSET)));
+	seq_printf(s, "COR1 --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_COR1_OFFSET)));
+	seq_printf(s, "WBSTR --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_WBSTR_OFFSET)));
+	seq_printf(s, "TIMER --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_TIMER_OFFSET)));
+	seq_printf(s, "BOOTSTS --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_BOOTSTS_OFFSET)));
+	seq_printf(s, "CTRL1 --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_CTRL1_OFFSET)));
+	seq_printf(s, "BSPI --> \t %x \t\r\n",
+		   (zynq_fpga_getconfigreg(mgr, TYPE1_BSPI_OFFSET)));
+
+	clk_disable(priv->clk);
+
+err_unlock:
+	mutex_unlock(&priv->mutex_lock);
+
+	return 0;
+}
+
 static const struct fpga_manager_ops zynq_fpga_ops = {
 	.initial_header_size = 128,
 	.state = zynq_fpga_ops_state,
 	.write_init = zynq_fpga_ops_write_init,
 	.write_sg = zynq_fpga_ops_write,
 	.write_complete = zynq_fpga_ops_write_complete,
+	.read = zynq_fpga_ops_read,
 };
 
 static int zynq_fpga_probe(struct platform_device *pdev)
@@ -565,6 +818,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 	spin_lock_init(&priv->dma_lock);
+	mutex_init(&priv->mutex_lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->io_base = devm_ioremap_resource(dev, res);
-- 
2.7.4

