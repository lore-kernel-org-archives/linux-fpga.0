Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCCD233942;
	Sun, 16 Aug 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786892879; cv=fail; b=W2xWmvHTKjR1ECkULAe+uTlnNpN/YpcsRS4inEz4U6FEOkaZJSlY7IouXT8c1bEjVEokqympQ8jjkwjpC5n4N4eM+HbxpHeHIvR2SrrqeBJSMHiW/iV1wZOcaJBgAsdMWP5p94GzPqEg4z49/apjyIQ+/2PQ/jQu9oZLmA2Lxgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786892879; c=relaxed/simple;
	bh=VEOayEY8sYKUi0kGyzr2xS2UmNvASfsyOV0pIPXFp5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdtKDMBR4LeTgXVV7sZwzoD2bd58ifJBrxUhHH36TqcwXUVX7I0IEYJX+kr0SWrdNu5sxp/X4g+iaxKTtCyrgjssYiW9Zj1q8vy089quqWsrvEjZztUJFTk9Zer7ClZoTK3DOj2lac+Te1feUAOzXomsSjf3r9TVJVWJH5C2FQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y/CFo06f; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y/CFo06f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6MAaGK6K4ueecJkgzP4UNtpZFwH4wW7CRmyEZG5xX01LwmHv+GeMz2WCewvncBxYA1me4wPuuSxolAb/Qr6T2sg2xCMdd91T1EDJJL+ZN+zAXyZe27OSKsIBsTIeqLO1TF7hGU2K/owX2c4qG4Z7i7VnFnd/+Rx5/3zr+hTkhjnVw9LVUZvgQQzox5xwGOJnl/v0kC6q0VHJGohWTnK4jlMrISeZiaE18HvPpUdsYsWkBk2SB3xHwV0QmsYJTsn0pxEcUhqCHq0aQME3/LsuA4HBbP41qtihHZ4nDkefrD43UvQnu8ecpsFP6kjR9h5NqeZy6x506VkoYZd4L7F9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4aRDbwd94FTPDcjspyLi6nSrq0WPncHle989yB5BT8=;
 b=tTDTOomlzaK0jBUSxYjXA7LeA7Ez4DTCqx/52MwoJVQ6LGbclOZF8k9eNmUITxCprlfopjAUqZvup/mPATsVjYJJ0MZKIUZEtHgZL2n2z/G4KNT6qS8hS0evmTj3sjlDaRiIwAeXnmsXNzAJ1yAOZLpGCJYf2m3qarBN7gUtnKxasUldA7S7GZD31Tm5/Y/s61iespWZkYyzChNZbfFHoacfmper9n3G2/XmqiAeo5EzZR9bpZX2jKIW8tuHsXikjUyi563GLN26ROZCu+RBZwRAbyUyLsrpBSr4djQAEgdli7xIXuz2GA45KedcHFPLDNIrYGelPJYSCDADjeSFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4aRDbwd94FTPDcjspyLi6nSrq0WPncHle989yB5BT8=;
 b=y/CFo06fY4hPizKdgBTHpfB2Xm7X/aEuThofELSImUSTi0smQ8n+55WCwskFxslc6kADftfssasMQjjbvZBBQ/0706YLzoCrtuejKHSyT9ZQu1f/PwwQc/1aAEd9DMfgs3h5n+PJiXRO+7Go0bleLjGTaggId9RxnHkUi89caDk=
Received: from DS1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::6) by
 IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 15:07:50 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:8:455:cafe::12) by DS1P220CA0011.outlook.office365.com
 (2603:10b6:8:455::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Sun,
 16 Aug 2026 15:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Sun, 16 Aug 2026 15:07:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 10:07:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 10:07:48 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Sun, 16 Aug 2026 10:07:44 -0500
From: Aravind Thokala <aravind.thokala@amd.com>
To: <mdf@kernel.org>, <yilun.xu@intel.com>, <trix@redhat.com>,
	<sumit.semwal@linaro.org>, <christian.koenig@amd.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-doc@vger.kernel.org>, <git@amd.com>,
	<aravind.thokala@amd.com>, <nava.kishore.manne@amd.com>
Subject: [PATCH 1/2] fpga: Add dma-buf interface for FPGA programming
Date: Sun, 16 Aug 2026 20:37:33 +0530
Message-ID: <20260816150734.2092802-2-aravind.thokala@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260816150734.2092802-1-aravind.thokala@amd.com>
References: <20260816150734.2092802-1-aravind.thokala@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f57549a-f81b-43fd-3e5a-08defba8232f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|23010399003|36860700016|22082099003|18002099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	LAx9pRrbLGqY/EDNGksw2lRTrfLFiquqW6xWUQjrBEYugdIJE/n6K8N6koRxZKvd8ZMCwtdVSYXfJcPU40kzg+pwBd0QFfgdmOl7F4Ncgspw1RxmOnLYks12DnPZVVPie0xehruNG/lx0ZXJOmK/bPHp6X9mDMtIy7/LQ5X8cilTOpPuzb/4fK1Lavngq3JA6TodHtwUJt7gTc3sgCcRp3MyrbPjJBABhZGjhWrzapIO5G0B0zz8b2JGoy+Xe+hkcyJn5kR6HvwINpc6pK4g1yAUQdm2apexsUxPAkeQJ2Tyy83W3oAIL+Ct/9IFU6ipZkIkomEaMVwlE21NeW+7Dsk7AJZrmkOeUOkzf3jkLh18j7AAjygs+/Z6c7VG4By6wD0LI7Ll/ELWFS2SrMeVfFYkL7HdgbxlR+WFX5Buoy3Col3r07MBpyEXwD0GT58h80PAKiEE76IYJbc8N8q5LB1YpzvVX6AqSiC/xj/mT2YPfoOOKkIpEHCVn5mQnowVaDHNGFBoYjovLmhULPAywYrkNDWfHfYy+EZU4AcbpG5Ir0SvOhp0o/Y/ql7H0k9fohrmRGwygLuNdLmBasupftzxP2skawxBe18CgHauMQGYPxUPiTCWiYpQocfKXzUuS8yJp09ftzOY9ai2s0TvXizwikDZEPYGjzy+Njubn/gEfa5znbzZTZWzS7CtFnJhaDNmL4f26sxyh8UhwPy+Cw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M4G27f3Xfhf1AvWyMkCtF+IZNiiPMXgxHFuYRqsIIfHFF6I0kWgkyE+jDEVOxfeygWYbdcbhT5KA/cddkjkPMgZx6ishW7dZ7SCZ8sSgugasC4dTMQ86whKtLBlFEyYHQzI5sPqr/9mD4Ef6iTHC2l+O4jrZjmUCkg+B9MbOm3g7IHVUYi77NWaj8oA6GXwg4btamWkVMSLaF+17HH5CikmsQeu3g49me/oOfTlrlmIWp00upy6TteSoU4cwMxBfKDvamk7wGFgW0/MJ1cJ28YDWCVPA9+oHJf0aAZAt1GNS0LHEMgMfxzc9C9P+lgLpis0aJrHdaSRvTzm5lLZnOI1lcxeefebtE2LNXERI1WuPM4E0QhDHqWeDLMOOkT6ZfBgYOu3hMKw+wI3hSsN1u2DLLmHuVoC+dTwa2kFBoHFPLvueAtIhV/uUvzQ0TFk5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 15:07:49.6126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f57549a-f81b-43fd-3e5a-08defba8232f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287

Loading FPGA images through the firmware interface requires the image
to be loaded into kernel memory first and then copied into DMA memory.
This extra copy creates needless memory pressure and delays.

Add a module that allows userspace to pass a pre-allocated DMA buffer
directly to the FPGA manager via ioctl, eliminating the extra copy.
A miscdevice (/dev/fpgaX) is created for each FPGA manager that
registers dma-buf support. The module imports the dma-buf fd, maps it
for DMA, and calls the FPGA manager load API with the scatter-gather
table.

Co-developed-by: Nava kishore Manne <nava.kishore.manne@amd.com>
Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
Signed-off-by: Aravind Thokala <aravind.thokala@amd.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   2 +
 drivers/fpga/fpga-dmabuf.c                    | 198 ++++++++++++++++++
 include/linux/fpga/fpga-dmabuf.h              |  22 ++
 include/linux/fpga/fpga-mgr.h                 |   1 +
 include/uapi/linux/fpga.h                     |  15 ++
 8 files changed, 249 insertions(+)
 create mode 100644 drivers/fpga/fpga-dmabuf.c
 create mode 100644 include/linux/fpga/fpga-dmabuf.h
 create mode 100644 include/uapi/linux/fpga.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 3f0ef1e27eb0..f8537dd23463 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -170,6 +170,7 @@ Code  Seq#    Include File                                             Comments
 'I'   all    linux/isdn.h                                              conflict!
 'I'   00-0F  drivers/isdn/divert/isdn_divert.h                         conflict!
 'I'   40-4F  linux/mISDNif.h                                           conflict!
+'J'   01     uapi/linux/fpga.h                                         FPGA DMA buffer interface
 'K'   all    linux/kd.h
 'L'   00-1F  linux/loop.h                                              conflict!
 'L'   10-1F  drivers/scsi/mpt3sas/mpt3sas_ctl.h                        conflict!
diff --git a/MAINTAINERS b/MAINTAINERS
index 5114e6db7307..7551dfa35d1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10217,6 +10217,7 @@ F:	Documentation/driver-api/fpga/
 F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
+F:	include/uapi/linux/fpga.h
 
 FRAMEBUFFER CONSOLE
 M:	Helge Deller <deller@gmx.de>
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 748fc210c135..e3ad791c9808 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -157,6 +157,15 @@ config OF_FPGA_REGION
 	  Support for loading FPGA images by applying a Device Tree
 	  overlay.
 
+config FPGA_DMA_BUF
+	tristate "FPGA DMA Buffer Support"
+	depends on DMA_SHARED_BUFFER
+	help
+	  Support for programming FPGAs from a pre-allocated DMA buffer
+	  shared via dma-buf. A miscdevice (/dev/fpgaX) accepts a dma-buf
+	  file descriptor via ioctl to load the FPGA image without
+	  redundant memory copies.
+
 config FPGA_DFL
 	tristate "FPGA Device Feature List (DFL) support"
 	select FPGA_BRIDGE
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 6f5798b27e0d..e52154296d2d 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -40,6 +40,8 @@ obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
 # High Level Interfaces
 obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
 obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
+# FPGA DMA Buffer Interface
+obj-$(CONFIG_FPGA_DMA_BUF)		+= fpga-dmabuf.o
 
 # FPGA Device Feature List Support
 obj-$(CONFIG_FPGA_DFL)			+= dfl.o
diff --git a/drivers/fpga/fpga-dmabuf.c b/drivers/fpga/fpga-dmabuf.c
new file mode 100644
index 000000000000..0e92eb134698
--- /dev/null
+++ b/drivers/fpga/fpga-dmabuf.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Manager DMA Buffer Support
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+#include <linux/capability.h>
+#include <linux/dma-buf.h>
+#include <linux/fpga/fpga-dmabuf.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/kref.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <uapi/linux/fpga.h>
+
+struct fpga_dmabuf_priv {
+	struct kref ref;
+	struct mutex lock; /* serializes ioctl against teardown */
+	bool dead;
+	struct fpga_manager *mgr;
+	struct miscdevice miscdev;
+};
+
+static void fpga_dmabuf_free(struct kref *ref)
+{
+	struct fpga_dmabuf_priv *priv = container_of(ref,
+					struct fpga_dmabuf_priv, ref);
+
+	put_device(&priv->mgr->dev);
+	kfree(priv->miscdev.name);
+	kfree(priv);
+}
+
+static int fpga_dmabuf_load(struct fpga_manager *mgr, int buffd)
+{
+	struct fpga_image_info *info;
+	struct dma_buf_attachment *attach;
+	struct dma_buf *dmabuf;
+	struct sg_table *sgt;
+	int ret;
+
+	dmabuf = dma_buf_get(buffd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	info = fpga_image_info_alloc(mgr->dev.parent);
+	if (!info) {
+		ret = -ENOMEM;
+		goto err_put;
+	}
+
+	attach = dma_buf_attach(dmabuf, mgr->dev.parent);
+	if (IS_ERR(attach)) {
+		ret = PTR_ERR(attach);
+		goto err_free_info;
+	}
+
+	sgt = dma_buf_map_attachment_unlocked(attach, DMA_TO_DEVICE);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		goto err_detach;
+	}
+
+	info->sgt = sgt;
+
+	ret = fpga_mgr_lock(mgr);
+	if (ret)
+		goto err_unmap;
+
+	ret = fpga_mgr_load(mgr, info);
+	fpga_mgr_unlock(mgr);
+
+err_unmap:
+	dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_TO_DEVICE);
+err_detach:
+	dma_buf_detach(dmabuf, attach);
+err_free_info:
+	fpga_image_info_free(info);
+err_put:
+	dma_buf_put(dmabuf);
+
+	return ret;
+}
+
+static int fpga_dmabuf_open(struct inode *inode, struct file *file)
+{
+	struct miscdevice *miscdev = file->private_data;
+	struct fpga_dmabuf_priv *priv;
+
+	priv = container_of(miscdev, struct fpga_dmabuf_priv, miscdev);
+	kref_get(&priv->ref);
+	file->private_data = priv;
+
+	return 0;
+}
+
+static int fpga_dmabuf_release(struct inode *inode, struct file *file)
+{
+	struct fpga_dmabuf_priv *priv = file->private_data;
+
+	kref_put(&priv->ref, fpga_dmabuf_free);
+	return 0;
+}
+
+static long fpga_dmabuf_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct fpga_dmabuf_priv *priv = file->private_data;
+	int buffd;
+	int ret;
+
+	switch (cmd) {
+	case FPGA_IOCTL_LOAD_DMA_BUF:
+		if (!capable(CAP_SYS_RAWIO))
+			return -EPERM;
+		if (copy_from_user(&buffd, (void __user *)arg, sizeof(buffd)))
+			return -EFAULT;
+
+		mutex_lock(&priv->lock);
+		if (priv->dead) {
+			mutex_unlock(&priv->lock);
+			return -ENODEV;
+		}
+		ret = fpga_dmabuf_load(priv->mgr, buffd);
+		mutex_unlock(&priv->lock);
+		return ret;
+	default:
+		return -ENOTTY;
+	}
+}
+
+static const struct file_operations fpga_dmabuf_fops = {
+	.owner		= THIS_MODULE,
+	.open		= fpga_dmabuf_open,
+	.release	= fpga_dmabuf_release,
+	.unlocked_ioctl	= fpga_dmabuf_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+};
+
+int fpga_dmabuf_register(struct fpga_manager *mgr)
+{
+	struct fpga_dmabuf_priv *priv;
+	int ret;
+
+	priv = kzalloc_obj(*priv);
+	if (!priv)
+		return -ENOMEM;
+
+	kref_init(&priv->ref);
+	mutex_init(&priv->lock);
+	get_device(&mgr->dev);
+	priv->mgr = mgr;
+	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
+	priv->miscdev.name = kstrdup(dev_name(&mgr->dev), GFP_KERNEL);
+	if (!priv->miscdev.name) {
+		put_device(&mgr->dev);
+		kfree(priv);
+		return -ENOMEM;
+	}
+	priv->miscdev.fops = &fpga_dmabuf_fops;
+	priv->miscdev.parent = &mgr->dev;
+
+	ret = misc_register(&priv->miscdev);
+	if (ret) {
+		kfree(priv->miscdev.name);
+		put_device(&mgr->dev);
+		kfree(priv);
+		return ret;
+	}
+
+	mgr->dmabuf_priv = priv;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fpga_dmabuf_register);
+
+void fpga_dmabuf_unregister(struct fpga_manager *mgr)
+{
+	struct fpga_dmabuf_priv *priv = mgr->dmabuf_priv;
+
+	if (!priv)
+		return;
+
+	mutex_lock(&priv->lock);
+	priv->dead = true;
+	mutex_unlock(&priv->lock);
+
+	misc_deregister(&priv->miscdev);
+	mgr->dmabuf_priv = NULL;
+	kref_put(&priv->ref, fpga_dmabuf_free);
+}
+EXPORT_SYMBOL_GPL(fpga_dmabuf_unregister);
+
+MODULE_IMPORT_NS("DMA_BUF");
+MODULE_DESCRIPTION("FPGA DMA Buffer Interface");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/fpga/fpga-dmabuf.h b/include/linux/fpga/fpga-dmabuf.h
new file mode 100644
index 000000000000..bf54bdfdf968
--- /dev/null
+++ b/include/linux/fpga/fpga-dmabuf.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+#ifndef _LINUX_FPGA_DMABUF_H
+#define _LINUX_FPGA_DMABUF_H
+
+struct fpga_manager;
+
+#if IS_REACHABLE(CONFIG_FPGA_DMA_BUF)
+int fpga_dmabuf_register(struct fpga_manager *mgr);
+void fpga_dmabuf_unregister(struct fpga_manager *mgr);
+#else
+static inline int fpga_dmabuf_register(struct fpga_manager *mgr)
+{
+	return 0;
+}
+
+static inline void fpga_dmabuf_unregister(struct fpga_manager *mgr) {}
+#endif
+
+#endif /* _LINUX_FPGA_DMABUF_H */
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 0d4fe068f3d8..38af47f60503 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -213,6 +213,7 @@ struct fpga_manager {
 	const struct fpga_manager_ops *mops;
 	struct module *mops_owner;
 	void *priv;
+	void *dmabuf_priv;
 };
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
diff --git a/include/uapi/linux/fpga.h b/include/uapi/linux/fpga.h
new file mode 100644
index 000000000000..868650c66526
--- /dev/null
+++ b/include/uapi/linux/fpga.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * FPGA userspace API
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+#ifndef _UAPI_LINUX_FPGA_H
+#define _UAPI_LINUX_FPGA_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#define FPGA_IOCTL_LOAD_DMA_BUF	_IOW('J', 1, __s32)
+
+#endif /* _UAPI_LINUX_FPGA_H */
-- 
2.34.1

