Return-Path: <SRS0=iGBL=NE=xilinx.com=navam@kernel.org>
Return-Path: <SRS0=iGBL=NE=xilinx.com=navam@kernel.org>
From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 1/3] firmware: xilinx: Add fpga API's
Date: Thu, 25 Oct 2018 13:02:04 +0530
Message-ID: <20181025073206.9264-2-nava.manne@xilinx.com>
In-Reply-To: <20181025073206.9264-1-nava.manne@xilinx.com>
References: <20181025073206.9264-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
To: atull@kernel.org, mdf@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, rajanv@xilinx.com, jollys@xilinx.com, nava.manne@xilinx.com, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
List-ID: <linux-fpga@vger.kernel.org>

This Patch Adds fpga API's to support the Bitstream loading
by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
This patch depends on the below series of patches
https://lkml.org/lkml/2018/9/12/983
Which is got integrated into the below upstream repo.
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/tree/drivers/firmware/xilinx?h=for-next

Changes for v2:
		-Added Firmware FPGA Manager flags As suggested by
		 Moritz.
Changes for v1:
                -None.

Changes for RFC-V2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 46 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2eca8b..4a5919448198 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -428,6 +428,50 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_fpga_load - Perform the fpga load
+ * @address:	Address to write to
+ * @size:	pl bitstream size
+ * @flags:
+ *	BIT(0) - Bit-stream type.
+ *		 0 - Full Bitstream.
+ *		 1 - Partial Bitstream.
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
 	.query_data = zynqmp_pm_query_data,
@@ -440,6 +484,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.fpga_load = zynqmp_pm_fpga_load,
+	.fpga_get_status = zynqmp_pm_fpga_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130431e6..0f900b48e1be 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -32,8 +32,18 @@
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+/*
+ * Firmware FPGA Manager flags
+ * XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration
+ */
+#define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
+
+
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_FPGA_LOAD = 22,
+	PM_FPGA_GET_STATUS,
 	PM_QUERY_DATA = 35,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
@@ -89,6 +99,8 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
+	int (*fpga_get_status)(u32 *value);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
 	int (*clock_disable)(u32 clock_id);
-- 
2.18.0
