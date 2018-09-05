Return-Path: <SRS0=Ghnj=LS=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Ghnj=LS=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-bn3nam01on0050.outbound.protection.outlook.com ([104.47.33.50]:6848
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbeIDLtT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 4 Sep 2018 07:49:19 -0400
From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [RFC PATCH v2 1/3] firmware: xilinx: Add fpga API's
Date: Wed, 5 Sep 2018 12:54:46 +0530
Message-ID: <20180905072448.12488-2-nava.manne@xilinx.com>
In-Reply-To: <20180905072448.12488-1-nava.manne@xilinx.com>
References: <20180905072448.12488-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, atull@kernel.org, mdf@kernel.org, jollys@xilinx.com, sboyd@kernel.org, rajanv@xilinx.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, chinnikishore369@gmail.com
Cc: Nava kishore Manne <nava.manne@xilinx.com>

This Patch Adds fpga API's to support the Bitstream loading
by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 46 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  4 +++
 2 files changed, 50 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7ccedf083926..9b3a59512dd7 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -447,6 +447,50 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_fpga_load - Perform the fpga load
+ * @address:	Address to write to
+ * @size:	pl bitstream size
+ * @flags:
+ *	BIT(0) - Bit-stream type.
+ *		 0 - Full Bit-stream.
+ *		 1 - Partial Bit-stream.
+ *
+ * This function provides access to pmufw. To transfer
+ * the required bitstream into PL.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_load(const u64 address, const u32 size,
+			       const u32 flags)
+{
+	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
+				   upper_32_bits(address), size, flags, NULL);
+}
+
+/**
+ * zynqmp_pm_fpga_get_status - Read value from PCAP status register
+ * @value: Value to read
+ *
+ * This function provides access to the xilfpga library to get
+ * the PCAP status
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_get_status(u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
+	*value = ret_payload[1];
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
@@ -460,6 +504,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.fpga_load = zynqmp_pm_fpga_load,
+	.fpga_get_status = zynqmp_pm_fpga_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 58a74781b51d..5a6bd5e58ea4 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_FPGA_LOAD = 22,
+	PM_FPGA_GET_STATUS,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -90,6 +92,8 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
+	int (*fpga_get_status)(u32 *value);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
-- 
2.18.0
