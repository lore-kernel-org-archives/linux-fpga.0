Return-Path: <SRS0=2b8I=KL=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=2b8I=KL=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr710082.outbound.protection.outlook.com ([40.107.71.82]:30016
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbeG0HnT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 27 Jul 2018 03:43:19 -0400
From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v4 2/2] fpga: zynq-fpga: Add support for readback of FPGA configuration data and registers
Date: Fri, 27 Jul 2018 11:52:31 +0530
Message-ID: <1532672551-22146-2-git-send-email-appana.durga.rao@xilinx.com>
In-Reply-To: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
References: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: atull@kernel.org, mdf@kernel.org, michal.simek@xilinx.com, kedare06@gmail.com
Cc: linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, navam@xilinx.com, apandey@xilinx.com, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

This patch adds support for readback of FPGA configuration data and registers.

Usage:
Readback of PL configuration data
        cat /sys/kernel/debug/fpga/fpga0/image
Readback of PL configuration registers
        cat /sys/kernel/debug/fpga/f8007000.devcfg/cfg_reg

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v4:
--> Improved commit message description as suggested by Moritz.
--> Used GENMASK and BIT() Macros wherever applicable as suggested by Moritz.
--> Fixed commenting sytle issues as suggested by Moritz and Alan.
--> Get rid of the readback_type module param as suggested by Alan and Moritz.
Changes for v3:
--> Added support for pl configuration data readback
--> Improved the pl configuration register readback logic.
Changes for v2:
--> Removed locks from the read_ops as lock handling is done in the framework.

 drivers/fpga/zynq-fpga.c | 430 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 430 insertions(+)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 70b15b3..1746d18 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -31,6 +31,7 @@
 #include <linux/regmap.h>
 #include <linux/string.h>
 #include <linux/scatterlist.h>
+#include <linux/seq_file.h>
 
 /* Offsets into SLCR regmap */
 
@@ -127,6 +128,69 @@
 /* Disable global resets */
 #define FPGA_RST_NONE_MASK		0x0
 
+/**
+ * struct zynq_configreg - Configuration register offsets
+ * @reg:	Name of the configuration register.
+ * @offset:	Register offset.
+ */
+struct zynq_configreg {
+	char *reg;
+	u32 offset;
+};
+
+static struct zynq_configreg cfgreg[] = {
+	{.reg = "CRC",		.offset = 0},
+	{.reg = "FAR",		.offset = 1},
+	{.reg = "FDRI",		.offset = 2},
+	{.reg = "FDRO",		.offset = 3},
+	{.reg = "CMD",		.offset = 4},
+	{.reg = "CTRL0",	.offset = 5},
+	{.reg = "MASK",		.offset = 6},
+	{.reg = "STAT",		.offset = 7},
+	{.reg = "LOUT",		.offset = 8},
+	{.reg = "COR0",		.offset = 9},
+	{.reg = "MFWR",		.offset = 10},
+	{.reg = "CBC",		.offset = 11},
+	{.reg = "IDCODE",	.offset = 12},
+	{.reg = "AXSS",		.offset = 13},
+	{.reg = "COR1",		.offset = 14},
+	{.reg = "WBSTR",	.offset = 16},
+	{.reg = "TIMER",	.offset = 17},
+	{.reg = "BOOTSTS",	.offset = 22},
+	{.reg = "CTRL1",	.offset = 24},
+	{}
+};
+
+/* Masks for Configuration registers */
+#define FAR_ADDR_MASK		0x00000000
+#define RCFG_CMD_MASK		BIT(2)
+#define START_CMD_MASK		BIT(2) + BIT(0)
+#define RCRC_CMD_MASK		GENMASK(2, 0)
+#define SHUTDOWN_CMD_MASK	GENMASK(1, 0) + BIT(3)
+#define DESYNC_WORD_MASK	GENMASK(2, 3) + BIT(0)
+#define BUSWIDTH_SYNCWORD_MASK	0x000000BB
+#define NOOP_WORD_MASK		BIT(29)
+#define BUSWIDTH_DETECT_MASK	0x11220044
+#define SYNC_WORD_MASK		0xAA995566
+#define DUMMY_WORD_MASK		GENMASK(31, 0)
+
+#define TYPE_HDR_SHIFT		29
+#define TYPE_REG_SHIFT		13
+#define TYPE_OP_SHIFT		27
+#define TYPE_OPCODE_NOOP	0
+#define TYPE_OPCODE_READ	1
+#define TYPE_OPCODE_WRITE	2
+#define TYPE_FAR_OFFSET		1
+#define TYPE_FDRO_OFFSET	3
+#define TYPE_CMD_OFFSET		4
+
+#define READ_STEP5_NOOPS	6
+#define READ_STEP9_NOOPS	32
+
+#define READ_DMA_SIZE		0x200
+#define DUMMY_FRAMES_SIZE	0x28
+#define SLCR_PCAP_FREQ		10000000
+
 struct zynq_fpga_priv {
 	int irq;
 	struct clk *clk;
@@ -140,6 +204,11 @@ struct zynq_fpga_priv {
 	struct scatterlist *cur_sg;
 
 	struct completion dma_done;
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	struct mutex ref_mutex;
+	struct dentry *dir;
+#endif
+	u32 size;
 };
 
 static inline void zynq_fpga_write(struct zynq_fpga_priv *priv, u32 offset,
@@ -164,6 +233,27 @@ static inline void zynq_fpga_set_irq(struct zynq_fpga_priv *priv, u32 enable)
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
+static int zynq_fpga_wait_fordone(struct zynq_fpga_priv *priv)
+{
+	u32 status;
+	int ret;
+
+	ret = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, status,
+				     status & IXR_D_P_DONE_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	return ret;
+}
+
 /* Must be called with dma_lock held */
 static void zynq_step_dma(struct zynq_fpga_priv *priv)
 {
@@ -192,6 +282,7 @@ static void zynq_step_dma(struct zynq_fpga_priv *priv)
 			priv->dma_elm++;
 		}
 
+		priv->size += len;
 		zynq_fpga_write(priv, DMA_SRC_ADDR_OFFSET, addr);
 		zynq_fpga_write(priv, DMA_DST_ADDR_OFFSET, DMA_INVALID_ADDRESS);
 		zynq_fpga_write(priv, DMA_SRC_LEN_OFFSET, len / 4);
@@ -401,6 +492,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	int i;
 
 	priv = mgr->priv;
+	priv->size = 0;
 
 	/* The hardware can only DMA multiples of 4 bytes, and it requires the
 	 * starting addresses to be aligned to 64 bits (UG585 pg 212).
@@ -546,12 +638,327 @@ static enum fpga_mgr_states zynq_fpga_ops_state(struct fpga_manager *mgr)
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
+	 * Generating the Type 1 packet header which involves shifting of Type1
+	 * Header Mask, Register value and the OpCode which is 01 in this case
+	 * as only read operation is to be carried out and then performing OR
+	 * operation with the Word Length.
+	 * For more details refer ug470 Packet Types section Table 5-20.
+	 */
+	return (((1 << TYPE_HDR_SHIFT) |
+		(reg << TYPE_REG_SHIFT) |
+		(opcode << TYPE_OP_SHIFT)) | size);
+
+}
+
+static int zynq_type2_pkt(u8 opcode, u32 size)
+{
+	/*
+	 * Type 2 Packet Header Format
+	 * The header section is always a 32-bit word.
+	 *
+	 * HeaderType | Opcode |  Word Count
+	 * [31:29]      [28:27]         [26:0]
+	 * --------------------------------------------------------------
+	 *   010          xx      xxxxxxxxxxxxx
+	 *
+	 * @R: means the bit is not used and reserved for future use.
+	 * The reserved bits should be written as 0s.
+	 *
+	 * Generating the Type 2 packet header which involves shifting of Type 2
+	 * Header Mask, OpCode and then performing OR operation with the Word
+	 * Length. For more details refer ug470 Packet Types section
+	 * Table 5-22.
+	 */
+	return (((2 << TYPE_HDR_SHIFT) |
+		(opcode << TYPE_OP_SHIFT)) | size);
+}
+
+static int zynq_fpga_ops_read_image(struct fpga_manager *mgr,
+				    struct seq_file *s)
+{
+	struct zynq_fpga_priv *priv = mgr->priv;
+	int ret = 0, cmdindex, clk_rate;
+	u32 intr_status, status, i;
+	dma_addr_t dma_addr;
+	unsigned int *buf;
+	size_t size;
+
+	ret = clk_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	size = priv->size + READ_DMA_SIZE + DUMMY_FRAMES_SIZE;
+	buf = dma_zalloc_coherent(mgr->dev.parent, size,
+				 &dma_addr, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto disable_clk;
+	}
+
+	seq_puts(s, "Zynq FPGA Configuration data contents are\n");
+
+	/*
+	 * There is no h/w flow control for pcap read
+	 * to prevent the FIFO from over flowing, reduce
+	 * the PCAP operating frequency.
+	 */
+	clk_rate = clk_get_rate(priv->clk);
+	ret = clk_set_rate(priv->clk, SLCR_PCAP_FREQ);
+	if (ret) {
+		dev_err(&mgr->dev, "Unable to reduce the PCAP freq\n");
+		goto free_dmabuf;
+	}
+
+	ret = zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status,
+				     status & STATUS_PCFG_INIT_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
+		goto restore_pcap_clk;
+	}
+
+	cmdindex = 0;
+	buf[cmdindex++] = DUMMY_WORD_MASK;
+	buf[cmdindex++] = BUSWIDTH_SYNCWORD_MASK;
+	buf[cmdindex++] = BUSWIDTH_DETECT_MASK;
+	buf[cmdindex++] = DUMMY_WORD_MASK;
+	buf[cmdindex++] = SYNC_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET, TYPE_OPCODE_WRITE,
+					 1);
+	buf[cmdindex++] = SHUTDOWN_CMD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET, TYPE_OPCODE_WRITE,
+					 1);
+	buf[cmdindex++] = RCRC_CMD_MASK;
+	for (i = 0; i < READ_STEP5_NOOPS; i++)
+		buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET, TYPE_OPCODE_WRITE,
+					 1);
+	buf[cmdindex++] = RCFG_CMD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_FAR_OFFSET, TYPE_OPCODE_WRITE,
+					 1);
+	buf[cmdindex++] = FAR_ADDR_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_FDRO_OFFSET, TYPE_OPCODE_READ,
+					 0);
+	buf[cmdindex++] = zynq_type2_pkt(TYPE_OPCODE_READ, priv->size/4);
+	for (i = 0; i < READ_STEP9_NOOPS; i++)
+		buf[cmdindex++] = NOOP_WORD_MASK;
+
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
+
+	/* Write to PCAP */
+	zynq_fpga_dma_xfer(priv, dma_addr, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "SRCDMA: Timeout waiting for D_P_DONE\n");
+		goto restore_pcap_clk;
+	}
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
+
+	/* Read From PACP */
+	zynq_fpga_dma_xfer(priv, DMA_INVALID_ADDRESS, 0,
+			   dma_addr + READ_DMA_SIZE, priv->size/4);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "DSTDMA: Timeout waiting for D_P_DONE\n");
+		goto restore_pcap_clk;
+	}
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, intr_status);
+
+	/* Write to PCAP */
+	cmdindex = 0;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
+					 TYPE_OPCODE_WRITE, 1);
+	buf[cmdindex++] = START_CMD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
+					 TYPE_OPCODE_WRITE, 1);
+	buf[cmdindex++] = RCRC_CMD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
+					 TYPE_OPCODE_WRITE, 1);
+	buf[cmdindex++] = DESYNC_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+
+	zynq_fpga_dma_xfer(priv, dma_addr, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "SRCDMA1: Timeout waiting for D_P_DONE\n");
+		goto restore_pcap_clk;
+	}
+
+	seq_write(s, &buf[READ_DMA_SIZE/4], priv->size);
+
+restore_pcap_clk:
+	clk_set_rate(priv->clk, clk_rate);
+free_dmabuf:
+	dma_free_coherent(mgr->dev.parent, size, buf,
+			  dma_addr);
+disable_clk:
+	clk_disable(priv->clk);
+	return ret;
+}
+
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+#include <linux/debugfs.h>
+
+static int zynq_fpga_getconfigreg(struct fpga_manager *mgr, u8 reg,
+				  dma_addr_t dma_addr, int *buf)
+{
+	struct zynq_fpga_priv *priv = mgr->priv;
+	int ret = 0, cmdindex, src_dmaoffset;
+	u32 intr_status, status;
+
+	src_dmaoffset = 0x8;
+	cmdindex = 2;
+	buf[cmdindex++] = DUMMY_WORD_MASK;
+	buf[cmdindex++] = BUSWIDTH_SYNCWORD_MASK;
+	buf[cmdindex++] = BUSWIDTH_DETECT_MASK;
+	buf[cmdindex++] = DUMMY_WORD_MASK;
+	buf[cmdindex++] = SYNC_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = zynq_type1_pkt(reg, TYPE_OPCODE_READ, 1);
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+
+	ret = zynq_fpga_poll_timeout(priv, STATUS_OFFSET, status,
+				     status & STATUS_PCFG_INIT_MASK,
+				     INIT_POLL_DELAY,
+				     INIT_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(&mgr->dev, "Timeout waiting for PCFG_INIT\n");
+		goto out;
+	}
+
+	/* Write to PCAP */
+	intr_status = zynq_fpga_read(priv, INT_STS_OFFSET);
+	zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
+
+	zynq_fpga_dma_xfer(priv, dma_addr + src_dmaoffset, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "SRCDMA: Timeout waiting for D_P_DONE\n");
+		goto out;
+	}
+	zynq_fpga_set_irq(priv, intr_status);
+
+	/* Read from PACP */
+	zynq_fpga_dma_xfer(priv, DMA_INVALID_ADDRESS, 0, dma_addr, 1);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret) {
+		dev_err(&mgr->dev, "DSTDMA: Timeout waiting for D_P_DONE\n");
+		goto out;
+	}
+
+	/* Write to PCAP */
+	cmdindex = 2;
+	buf[cmdindex++] = zynq_type1_pkt(TYPE_CMD_OFFSET,
+					 TYPE_OPCODE_WRITE, 1);
+	buf[cmdindex++] = DESYNC_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	buf[cmdindex++] = NOOP_WORD_MASK;
+	zynq_fpga_dma_xfer(priv, dma_addr + src_dmaoffset, cmdindex,
+			   DMA_INVALID_ADDRESS, 0);
+	ret = zynq_fpga_wait_fordone(priv);
+	if (ret)
+		dev_err(&mgr->dev, "SRCDMA1: Timeout waiting for D_P_DONE\n");
+out:
+	return ret;
+}
+
+static int zynq_fpga_read_cfg_reg(struct seq_file *s, void *data)
+{
+	struct fpga_manager *mgr = (struct fpga_manager *)s->private;
+	struct zynq_fpga_priv *priv = mgr->priv;
+	struct zynq_configreg *p = cfgreg;
+	dma_addr_t dma_addr;
+	unsigned int *buf;
+	int ret = 0;
+
+	if (!mutex_trylock(&priv->ref_mutex))
+		return -EBUSY;
+
+	if (mgr->state != FPGA_MGR_STATE_OPERATING) {
+		ret = -EPERM;
+		goto err_unlock;
+	}
+
+	ret = clk_enable(priv->clk);
+	if (ret)
+		goto err_unlock;
+
+	buf = dma_zalloc_coherent(mgr->dev.parent, READ_DMA_SIZE,
+				 &dma_addr, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto disable_clk;
+	}
+
+	seq_puts(s, "Zynq FPGA Configuration register contents are\n");
+
+	while (p->reg) {
+		ret = zynq_fpga_getconfigreg(mgr, p->offset, dma_addr, buf);
+		if (ret)
+			goto free_dmabuf;
+		seq_printf(s, "%s --> \t %x \t\r\n", p->reg, buf[0]);
+		p++;
+	}
+
+free_dmabuf:
+	dma_free_coherent(mgr->dev.parent, READ_DMA_SIZE, buf,
+			  dma_addr);
+disable_clk:
+	clk_disable(priv->clk);
+err_unlock:
+	mutex_unlock(&priv->ref_mutex);
+	return ret;
+}
+
+static int zynq_fpga_read_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, zynq_fpga_read_cfg_reg, inode->i_private);
+}
+
+static const struct file_operations zynq_fpga_ops_cfg_reg = {
+	.owner = THIS_MODULE,
+	.open = zynq_fpga_read_open,
+	.read = seq_read,
+};
+#endif
+
 static const struct fpga_manager_ops zynq_fpga_ops = {
 	.initial_header_size = 128,
 	.state = zynq_fpga_ops_state,
 	.write_init = zynq_fpga_ops_write_init,
 	.write_sg = zynq_fpga_ops_write,
 	.write_complete = zynq_fpga_ops_write_complete,
+	.read = zynq_fpga_ops_read_image,
 };
 
 static int zynq_fpga_probe(struct platform_device *pdev)
@@ -621,6 +1028,26 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 		return err;
 	}
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	struct dentry *d;
+	struct fpga_manager *mgr;
+
+	mgr = platform_get_drvdata(pdev);
+	mutex_init(&priv->ref_mutex);
+
+	d = debugfs_create_dir(pdev->dev.kobj.name, mgr->dir);
+	if (!d)
+		return err;
+
+	priv->dir = d;
+	d = debugfs_create_file("cfg_reg", 0644, priv->dir, mgr,
+				&zynq_fpga_ops_cfg_reg);
+	if (!d) {
+		debugfs_remove_recursive(mgr->dir);
+		return err;
+	}
+#endif
+
 	return 0;
 }
 
@@ -632,6 +1059,9 @@ static int zynq_fpga_remove(struct platform_device *pdev)
 	mgr = platform_get_drvdata(pdev);
 	priv = mgr->priv;
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	debugfs_remove_recursive(priv->dir);
+#endif
 	fpga_mgr_unregister(&pdev->dev);
 
 	clk_unprepare(priv->clk);
-- 
2.7.4

