Return-Path: <SRS0=XHe7=IL=linux.intel.com=richard.gong@kernel.org>
Return-Path: <SRS0=XHe7=IL=linux.intel.com=richard.gong@kernel.org>
From: richard.gong@linux.intel.com
Subject: [PATCHv5 6/8] fpga: add intel stratix10 soc fpga manager driver
Date: Thu, 24 May 2018 11:33:18 -0500
Message-Id: <1527179600-26441-7-git-send-email-richard.gong@linux.intel.com>
In-Reply-To: <1527179600-26441-1-git-send-email-richard.gong@linux.intel.com>
References: <1527179600-26441-1-git-send-email-richard.gong@linux.intel.com>
To: catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, corbet@lwn.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org, yves.vandervennet@linux.intel.com, richard.gong@linux.intel.com, richard.gong@intel.com
List-ID: <linux-fpga@vger.kernel.org>

From: Alan Tull <atull@kernel.org>

Add driver for reconfiguring Intel Stratix10 SoC FPGA devices.
This driver communicates through the Intel Service Driver which
does communication with privileged hardware (that does the
FPGA programming) through a secure mailbox.

Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: this patch is added in patch set version 2
v3: change to align to the update of service client APIs, and the
    update of fpga_mgr device node
v4: changes to align with stratix10-svc-client API updates
    add Richard's signed-off-by
v5: update to align changes at service layer to minimize service
    layer thread usages
---
 drivers/fpga/Kconfig         |   6 +
 drivers/fpga/Makefile        |   1 +
 drivers/fpga/stratix10-soc.c | 545 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 552 insertions(+)
 create mode 100644 drivers/fpga/stratix10-soc.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index f47ef84..1624a73 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -57,6 +57,12 @@ config FPGA_MGR_ZYNQ_FPGA
 	help
 	  FPGA manager driver support for Xilinx Zynq FPGAs.
 
+config FPGA_MGR_STRATIX10_SOC
+	tristate "Intel Stratix10 SoC FPGA Manager"
+	depends on (ARCH_STRATIX10 && STRATIX10_SERVICE)
+	help
+	  FPGA manager driver support for the Intel Stratix10 SoC.
+
 config FPGA_MGR_XILINX_SPI
 	tristate "Xilinx Configuration over Slave Serial (SPI)"
 	depends on SPI
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 3cb276a..6eef670 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_FPGA_MGR_ALTERA_PS_SPI)	+= altera-ps-spi.o
 obj-$(CONFIG_FPGA_MGR_ICE40_SPI)	+= ice40-spi.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
+obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
 obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
new file mode 100644
index 0000000..d645ef7
--- /dev/null
+++ b/drivers/fpga/stratix10-soc.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Manager Driver for Intel Stratix10 SoC
+ *
+ *  Copyright (C) 2018 Intel Corporation
+ */
+#include <linux/completion.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/stratix10-svc-client.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+/*
+ * FPGA programming requires a higher level of privilege (EL3), per the SoC
+ * design.
+ */
+#define NUM_SVC_BUFS	4
+#define SVC_BUF_SIZE	SZ_512K
+
+/* Indicates buffer is in use if set */
+#define SVC_BUF_LOCK	0
+
+/**
+ * struct s10_svc_buf
+ * @buf: virtual address of buf provided by service layer
+ * @lock: locked if buffer is in use
+ */
+struct s10_svc_buf {
+	char *buf;
+	unsigned long lock;
+};
+
+struct s10_priv {
+	struct stratix10_svc_chan *chan;
+	struct stratix10_svc_client client;
+	struct completion status_return_completion;
+	struct s10_svc_buf svc_bufs[NUM_SVC_BUFS];
+	unsigned long status;
+};
+
+static int s10_svc_send_msg(struct s10_priv *priv,
+			    enum stratix10_svc_command_code command,
+			    void *payload, u32 payload_length)
+{
+	struct stratix10_svc_chan *chan = priv->chan;
+	struct stratix10_svc_client_msg msg;
+	int ret;
+
+	pr_debug("%s cmd=%d payload=%p legnth=%d\n",
+		 __func__, command, payload, payload_length);
+
+	msg.command = command;
+	msg.payload = payload;
+	msg.payload_length = payload_length;
+
+	ret = stratix10_svc_send(chan, &msg);
+	pr_debug("stratix10_svc_send returned status %d\n", ret);
+
+	return ret;
+}
+
+/**
+ * s10_free_buffers
+ * Free buffers allocated from the service layer's pool that are not in use.
+ * @mgr: fpga manager struct
+ * Free all buffers that are not in use.
+ * Return true when all buffers are freed.
+ */
+static bool s10_free_buffers(struct fpga_manager *mgr)
+{
+	struct s10_priv *priv = mgr->priv;
+	uint num_free = 0;
+	uint i;
+
+	for (i = 0; i < NUM_SVC_BUFS; i++) {
+		if (!priv->svc_bufs[i].buf) {
+			num_free++;
+			continue;
+		}
+
+		if (!test_and_set_bit_lock(SVC_BUF_LOCK,
+					   &priv->svc_bufs[i].lock)) {
+			stratix10_svc_free_memory(priv->chan,
+					      priv->svc_bufs[i].buf);
+			priv->svc_bufs[i].buf = NULL;
+			num_free++;
+		}
+	}
+
+	return num_free == NUM_SVC_BUFS;
+}
+
+/**
+ * s10_free_buffer_count
+ * Count how many buffers are not in use.
+ * @mgr: fpga manager struct
+ * Return # of buffers that are not in use.
+ */
+static uint s10_free_buffer_count(struct fpga_manager *mgr)
+{
+	struct s10_priv *priv = mgr->priv;
+	uint num_free = 0;
+	uint i;
+
+	for (i = 0; i < NUM_SVC_BUFS; i++)
+		if (!priv->svc_bufs[i].buf)
+			num_free++;
+
+	return num_free;
+}
+
+/**
+ * s10_unlock_bufs
+ * Given the returned buffer address, match that address to our buffer struct
+ * and unlock that buffer.  This marks it as available to be refilled and sent
+ * (or freed).
+ * @priv: private data
+ * @kaddr: kernel address of buffer that was returned from service layer
+ */
+static void s10_unlock_bufs(struct s10_priv *priv, void *kaddr)
+{
+	uint i;
+
+	if (!kaddr)
+		return;
+
+	for (i = 0; i < NUM_SVC_BUFS; i++)
+		if (priv->svc_bufs[i].buf == kaddr) {
+			clear_bit_unlock(SVC_BUF_LOCK,
+					 &priv->svc_bufs[i].lock);
+			return;
+		}
+
+	WARN(1, "Unknown buffer returned from service layer %p\n", kaddr);
+}
+
+/**
+ * s10_receive_callback
+ * Callback for service layer to use to provide client (this driver) messages
+ * received through the mailbox.
+ * @client: service layer client struct
+ * @data: message
+ */
+static void s10_receive_callback(struct stratix10_svc_client *client,
+				 struct stratix10_svc_cb_data *data)
+{
+	struct s10_priv *priv = client->priv;
+	u32 status;
+	int i;
+
+	WARN_ONCE(!data, "%s: stratix10_svc_rc_data = NULL", __func__);
+
+	status = data->status;
+
+	/*
+	 * Here we set status bits as we receive them.  Elsewhere, we always use
+	 * test_and_clear_bit() to check status in priv->status
+	 */
+	for (i = 0; i <= SVC_STATUS_RECONFIG_ERROR; i++)
+		if (status & (1 << i))
+			set_bit(i, &priv->status);
+
+	if (status & BIT(SVC_STATUS_RECONFIG_BUFFER_DONE)) {
+		s10_unlock_bufs(priv, data->kaddr1);
+		s10_unlock_bufs(priv, data->kaddr2);
+		s10_unlock_bufs(priv, data->kaddr3);
+	}
+
+	complete(&priv->status_return_completion);
+}
+
+/**
+ * s10_ops_write_init
+ * Prepare for FPGA reconfiguration by requesting partial reconfig and
+ * allocating buffers from the service layer.
+ * @mgr: fpga manager
+ * @info: fpga image info
+ * @buf: fpga image buffer
+ * @count: size of buf in bytes
+ */
+static int s10_ops_write_init(struct fpga_manager *mgr,
+			      struct fpga_image_info *info,
+			      const char *buf, size_t count)
+{
+	struct s10_priv *priv = mgr->priv;
+	struct device *dev = priv->client.dev;
+	unsigned long timeout;
+	struct stratix10_svc_command_reconfig_payload payload;
+	char *kbuf;
+	uint i;
+	int ret;
+
+	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
+		dev_info(dev, "Requesting partial reconfiguration.\n");
+		payload.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
+	} else {
+		dev_info(dev, "Requesting full reconfiguration.\n");
+	}
+
+	reinit_completion(&priv->status_return_completion);
+	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG,
+			       &payload, sizeof(payload));
+	if (ret)
+		goto init_done;
+
+	timeout = msecs_to_jiffies(SVC_RECONFIG_REQUEST_TIMEOUT_MS);
+	ret = wait_for_completion_interruptible_timeout(
+		&priv->status_return_completion, timeout);
+	if (!ret) {
+		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
+		ret = -ETIMEDOUT;
+		goto init_done;
+	}
+	if (ret < 0) {
+		dev_err(dev, "error (%d) waiting for RECONFIG_REQUEST\n", ret);
+		goto init_done;
+	}
+
+	ret = 0;
+	if (!test_and_clear_bit(SVC_STATUS_RECONFIG_REQUEST_OK,
+				&priv->status)) {
+		ret = -ETIMEDOUT;
+		goto init_done;
+	}
+
+	/* Allocate buffers from the service layer's pool. */
+	for (i = 0; i < NUM_SVC_BUFS; i++) {
+		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
+		if (!kbuf) {
+			s10_free_buffers(mgr);
+			ret = -ENOMEM;
+			goto init_done;
+		}
+
+		priv->svc_bufs[i].buf = kbuf;
+		priv->svc_bufs[i].lock = 0;
+	}
+
+init_done:
+	stratix10_svc_done(priv->chan);
+	return ret;
+}
+
+/**
+ * s10_send_buf
+ * Send a buffer to the service layer queue
+ * @mgr: fpga manager struct
+ * @buf_num: index of buffer in svc_bufs array
+ * @buf: fpga image buffer
+ * @count: size of buf in bytes
+ * Returns # of bytes transferred or -errno, never 0
+ */
+static int s10_send_buf(struct fpga_manager *mgr, uint buf_num,
+			const char *buf, size_t count)
+
+{
+	struct s10_priv *priv = mgr->priv;
+	struct device *dev = priv->client.dev;
+	void *svc_buf;
+	size_t xfer_sz;
+	int ret;
+
+	xfer_sz = count < SVC_BUF_SIZE ? count : SVC_BUF_SIZE;
+
+	svc_buf = priv->svc_bufs[buf_num].buf;
+	memcpy(svc_buf, buf, xfer_sz);
+	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_DATA_SUBMIT,
+			       svc_buf, xfer_sz);
+	if (ret) {
+		dev_err(dev,
+			"Error while sending data to service layer (%d)", ret);
+		return ret;
+	}
+
+	return xfer_sz;
+}
+
+/**
+ * s10_ops_write
+ * Send a FPGA image to privileged layers to write to the FPGA.  When done
+ * sending, free all service layer buffers we allocated in write_init.
+ * @mgr: fpga manager
+ * @buf: fpga image buffer
+ * @count: size of buf in bytes
+ * Returns 0 for success or negative errno.
+ */
+static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
+			 size_t count)
+{
+	struct s10_priv *priv = mgr->priv;
+	struct device *dev = priv->client.dev;
+	unsigned long timeout;
+	size_t sent = 0;
+	int ret = 0;
+	uint i;
+
+	timeout = msecs_to_jiffies(SVC_RECONFIG_BUFFER_TIMEOUT_MS);
+
+	/* Buffer loop: either send buffers or free them. */
+	while (1) {
+		reinit_completion(&priv->status_return_completion);
+
+		if (count > 0) {
+			for (i = 0; i < NUM_SVC_BUFS; i++)
+				if (!test_and_set_bit_lock(
+					 SVC_BUF_LOCK, &priv->svc_bufs[i].lock))
+					break;
+
+			if (i == NUM_SVC_BUFS)
+				/* wait for a free buffer */
+				continue;
+
+			sent = s10_send_buf(mgr, i, buf, count);
+			/*
+			 * If service queue was full, we won't get a callback.
+			 * Wait and try again
+			 */
+			if (sent < 0)
+				continue;
+
+			count -= sent;
+			buf += sent;
+		} else {
+			s10_free_buffers(mgr);
+			if (s10_free_buffer_count(mgr) == NUM_SVC_BUFS)
+				return 0;
+
+			ret = s10_svc_send_msg(
+				priv, COMMAND_RECONFIG_DATA_CLAIM,
+				NULL, 0);
+			if (ret)
+				break;
+		}
+
+		/*
+		 * If callback hasn't already happened, wait for buffers to be
+		 * returned from service layer
+		 */
+		if (priv->status)
+			ret = 0;
+		else
+			ret = wait_for_completion_interruptible_timeout(
+				&priv->status_return_completion, timeout);
+
+		if (test_and_clear_bit(
+				SVC_STATUS_RECONFIG_BUFFER_DONE, &priv->status))
+			continue;
+
+		if (test_and_clear_bit(SVC_STATUS_RECONFIG_BUFFER_SUBMITTED,
+				       &priv->status))
+			continue;
+
+		if (test_and_clear_bit(SVC_STATUS_RECONFIG_ERROR,
+				       &priv->status)) {
+			dev_err(dev, "ERROR - giving up - SVC_STATUS_RECONFIG_ERROR\n");
+			ret = -EFAULT;
+			break;
+		}
+
+		if (!ret) {
+			dev_err(dev, "timeout waiting for svc layer buffers\n");
+			ret = -ETIMEDOUT;
+			break;
+		}
+		if (ret < 0) {
+			dev_err(dev,
+				"error (%d) waiting for svc layer buffers\n",
+				ret);
+			break;
+		}
+	}
+
+	s10_free_buffers(mgr);
+	if (s10_free_buffer_count(mgr) != NUM_SVC_BUFS)
+		dev_err(dev, "%s not all buffers were freed\n", __func__);
+
+	return ret;
+}
+
+/**
+ * s10_ops_write_complete
+ * Wait for FPGA configuration to be done
+ * @mgr: fpga manager
+ * @info: fpga image info
+ * Returns 0 for success negative errno.
+ */
+static int s10_ops_write_complete(struct fpga_manager *mgr,
+				  struct fpga_image_info *info)
+{
+	struct s10_priv *priv = mgr->priv;
+	struct device *dev = priv->client.dev;
+	unsigned long timeout;
+	int ret;
+
+	timeout = usecs_to_jiffies(info->config_complete_timeout_us);
+
+	do {
+		reinit_completion(&priv->status_return_completion);
+
+		ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_STATUS, NULL, 0);
+		if (ret)
+			break;
+
+		ret = wait_for_completion_interruptible_timeout(
+			&priv->status_return_completion, timeout);
+		if (!ret) {
+			dev_err(dev,
+				"timeout waiting for RECONFIG_COMPLETED\n");
+			ret = -ETIMEDOUT;
+			break;
+		}
+		if (ret < 0) {
+			dev_err(dev,
+				"error (%d) waiting for RECONFIG_COMPLETED\n",
+				ret);
+			break;
+		}
+		/* Not error or timeout, so ret is # of jiffies until timeout */
+		timeout = ret;
+		ret = 0;
+
+		if (test_and_clear_bit(SVC_STATUS_RECONFIG_COMPLETED,
+				       &priv->status))
+			break;
+
+		if (test_and_clear_bit(SVC_STATUS_RECONFIG_ERROR,
+				       &priv->status)) {
+			dev_err(dev, "ERROR - giving up - SVC_STATUS_RECONFIG_ERROR\n");
+			ret = -EFAULT;
+			break;
+		}
+	} while (1);
+
+	stratix10_svc_done(priv->chan);
+	return ret;
+}
+
+static enum fpga_mgr_states s10_ops_state(struct fpga_manager *mgr)
+{
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static const struct fpga_manager_ops s10_ops = {
+	.state = s10_ops_state,
+	.write_init = s10_ops_write_init,
+	.write = s10_ops_write,
+	.write_complete = s10_ops_write_complete,
+};
+
+static int s10_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct s10_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->client.dev = dev;
+	priv->client.receive_cb = s10_receive_callback;
+	priv->client.priv = priv;
+
+	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
+						SVC_CLIENT_FPGA);
+	if (IS_ERR(priv->chan)) {
+		dev_err(dev, "couldn't get service channel (%s)\n",
+			SVC_CLIENT_FPGA);
+		return PTR_ERR(priv->chan);
+	}
+
+	init_completion(&priv->status_return_completion);
+
+	ret = fpga_mgr_register(dev, "Stratix10 SOC FPGA Manager",
+				&s10_ops, priv);
+
+	if (ret)
+		stratix10_svc_free_channel(priv->chan);
+
+	return ret;
+}
+
+static int s10_remove(struct platform_device *pdev)
+{
+	struct fpga_manager *mgr = platform_get_drvdata(pdev);
+	struct s10_priv *priv = mgr->priv;
+
+	fpga_mgr_unregister(&pdev->dev);
+	stratix10_svc_free_channel(priv->chan);
+
+	return 0;
+}
+
+static const struct of_device_id s10_of_match[] = {
+	{ .compatible = "intel,stratix10-soc-fpga-mgr", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, s10_of_match);
+
+static struct platform_driver s10_driver = {
+	.probe = s10_probe,
+	.remove = s10_remove,
+	.driver = {
+		.name	= "Stratix10 SoC FPGA manager",
+		.of_match_table = of_match_ptr(s10_of_match),
+	},
+};
+
+static int __init s10_init(void)
+{
+	struct device_node *fw_np;
+	struct device_node *np;
+	int ret;
+
+	fw_np = of_find_node_by_name(NULL, "svc");
+	if (!fw_np)
+		return -ENODEV;
+
+	np = of_find_matching_node(fw_np, s10_of_match);
+	if (!np) {
+		of_node_put(fw_np);
+		return -ENODEV;
+	}
+
+	of_node_put(np);
+	ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
+	of_node_put(fw_np);
+	if (ret)
+		return ret;
+
+	return platform_driver_register(&s10_driver);
+}
+
+static void __exit s10_exit(void)
+{
+	return platform_driver_unregister(&s10_driver);
+}
+
+module_init(s10_init);
+module_exit(s10_exit);
+
+MODULE_AUTHOR("Alan Tull <atull@kernel.org>");
+MODULE_DESCRIPTION("Intel Stratix 10 SOC FPGA Manager");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
