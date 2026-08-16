Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E334388F;
	Sun, 16 Aug 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786892879; cv=fail; b=r8/Nccs6AKU3pii10Nlqkrm0+54w12yyJaaNpCWJB+Em3ZfBIJvinz2psVXFsIzg63KMeBVIHhJ11XWUhlG+c5IJUoiWYXsoZxFj5rRswXqmq1RLIfytyAAlxcJeCUspkpLy/hFcihuULcx7KeLW3G6zvm2sWSAjSKpS7aY3EfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786892879; c=relaxed/simple;
	bh=vXr9KT5UKslGuKDqQsQ++vjhzTDwaWW/E9GgPN2/r74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2PbA0+0FUg1rRSmjDA4uCyqTTzIgdsvT12C/APaFQXJTfYzbscgKACa7qX1TsTAWpvX56TFGkbPGt2kM2pTdDSensjHvSeTfZM3aI4ShF6ivS3EvmWeaAGmJ1+kdLZ5Sq5z8ZmVG6LclvIp7KcYtRAc6Q8tOB8Cx8DZumGItuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QQbvyrhy; arc=fail smtp.client-ip=52.101.61.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QQbvyrhy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbyLC7T+XlKHoLm7p4pnAZ2zwq+iC9eupE5ZzClZPbTZkQN5YiuXxxlNh8Otvd2O+O+kHGdrw39NbVMDN+2rYqDZTUvXrjp0UPXEePBQ9tePSstipDg3ODXAQfCjc1t39CyXMRf4kKOZzVX7+13oKVxNFkQC3FVztTIEllHZFhU/jLfwflB3KM5jMpOCPjmCBU1671TLobB7ksn1lU6P+btc+UbkRfgZRXyl6PrHitLgIoUC5h6CQxINz9TVKSqS4tx9T5jzFj/Xm2xOlOuKj/uCNmwK4t+3e9RXNduvKTTaaOVTblcR+xqNuBjnJR+KeI5PrP6vNechusXOLWKOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWiEbjvB6KG8r35ElgGB2hSjNOPcqL39sj13KUsV9Qk=;
 b=Zvxvf28vbdE89NkEwTZ69N17oKvFyD2BqO7RQYXw7ZPXhSn1pis9LWhl1pzWaXwS2kuvoOgeSRglj79GjR7ipIQ4Q764ORnAuVnRNVMWywwZ1QDlAWcUxu9xyegZzJuDBJpkYSVl4fzKpUn43EtYLOquCytobWjVomlIQ6qwqMAa9CNfDIh3vVpT+3tWaW/VX6P94cuTS1+/Kh8/coU5bzDec/NDacQmosAREC3KiAxpFNhqBNsuH5YzROqWt/hR+L+RiXFe0Vw9Xsj4QSnetaZau/dn2R+NeaFvCjxIng0kWDOzK1XjNGd75fpOOrjG/HWpTQFpeirgvh+uS2itcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWiEbjvB6KG8r35ElgGB2hSjNOPcqL39sj13KUsV9Qk=;
 b=QQbvyrhyw2ojZiuUrrsFVVxqhXMKLGmy5Ja9aUWfjg1zHmzWOPIzhd5+C2XqxjhrEoa1FHJPo41KN4U852iI6qnRZJ3FkDlzTNUUW/Wg4iJFBApklNzTv2VB4NdDeSaoyKR308o42BAV0Zah5qm77hSSqVokDOlKlCRkYElv8GI=
Received: from CH0PR03CA0332.namprd03.prod.outlook.com (2603:10b6:610:11a::9)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 15:07:54 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::64) by CH0PR03CA0332.outlook.office365.com
 (2603:10b6:610:11a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Sun,
 16 Aug 2026 15:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Sun, 16 Aug 2026 15:07:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 10:07:53 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 10:07:52 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Sun, 16 Aug 2026 10:07:48 -0500
From: Aravind Thokala <aravind.thokala@amd.com>
To: <mdf@kernel.org>, <yilun.xu@intel.com>, <trix@redhat.com>,
	<sumit.semwal@linaro.org>, <christian.koenig@amd.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-doc@vger.kernel.org>, <git@amd.com>,
	<aravind.thokala@amd.com>, <nava.kishore.manne@amd.com>
Subject: [PATCH 2/2] fpga: versal: add dma-buf programming support
Date: Sun, 16 Aug 2026 20:37:34 +0530
Message-ID: <20260816150734.2092802-3-aravind.thokala@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: efcbe18b-b801-423f-dba7-08defba825ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|7416014|376014|82310400026|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	lZswCj3PVPVaVCL5WPjHVFMhqAyDpAbNh8Yl7jgrFmSl4D44O9vMXjnjhLRnsaOwzX8/FbQUutW1xlGVEcuGrQBAOclInru5RFFTUfq9i0wJtaPbuQtwyv80agfygrgaWwin8/ZsjXhC8KMkzcgkj7Pfw1mdH3+wEmNmplcgeacGla4crUNiXsjTvidiqHjVWDQFIW8QGTaxZRkFm4qvRbBImcvOAA1A5kSoS4Jn4eXL2Y1rsFkaup+sbZm/v7iKicVMEPnlGe2CTdG54D3uqx/QjikCIrobqqhUMD5uqCgXkJ5LaSGhr4mdc4C3PrPOgACRb7IXOyDLPG3nhkMooBZZDzX0m6Iw5v48Fc1aeST39PzL9FdbjyO89TbqhH7m/vhUDrIbTClentw5VUwpa08RRtUyJk1CXK997t055Pq3AxWgpyL8UbksARsq3ypBnasdJY2kL6OsURHa+AfakLfHpd2r8UwvcJ3kQukPC//HSj/BsOuTg4YneNywd7HFa6EiD9umRlqWQaw+Bued00owFQF3EhFujpIkZXsm33RcpNdEAcf0y1QCyvLpfSIn6nitSTuiRdLyOql1dubZLhbIYCwhahbilz84F5qIg/twoPSvQuF22g4htAqyRNcRyFfjiklKIdXx3iHoBcEZFSJNsrO5jp0L15Prm2FrhaaDO/pCG0/FPU6ynekg9hUvRGMWX/S1RFegaaNOUAcHrg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(7416014)(376014)(82310400026)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fVGE6v7EbWk/7532ZASAA3wrQbPh8L3YakVYJ4ckP9AWRQO6SPCl3S7DsQveQH7/NpwpIAJye3Jdxt80N0ocLiFOV4bHRafhJt0EOLv5iItb1smvBAFE7X76kRsI521LOaxSy2FHUqI6pMZBcWQtfSgQS1bXa3bUWMCsd9VTB+fJHFC7etCX2yCVso6CIxx0RygDQwxThLElTYnj3hw9LGuSI8vm/rPA5Bm4nYR7UK2Y2NYChVSO5Ghbhok3I/bO5mEftpCLaIWXIXHHu5vXKRdhlujU87Wlln94vy/yySCuCQndUJvKmgEoa7azCne37ZVH+4Fn54niLQe7aMnPC2+eBC14ozUd0QiC5fvjssr59lWXcy7c6Cbf74ZHEIW80WwuvffxQo8xMDb6B9cHnPt9KAE96izh2jWZskQXnPVU8wZAkv0uQvA+m06DepaN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 15:07:53.8477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efcbe18b-b801-423f-dba7-08defba825ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655

The existing .write callback allocates a DMA-coherent buffer and
copies the image into it before passing the address to firmware. With
dma-buf, the buffer is already DMA-mapped by userspace.

Add a .write_sg callback that extracts the DMA address directly from
the scatter-gather table and passes it to zynqmp_pm_load_pdi(),
avoiding the intermediate copy. Register the dma-buf interface in
probe with devres-managed cleanup.

Co-developed-by: Nava kishore Manne <nava.kishore.manne@amd.com>
Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
Signed-off-by: Aravind Thokala <aravind.thokala@amd.com>
---
 drivers/fpga/versal-fpga.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
index e6189106c468..bdaa15a6c991 100644
--- a/drivers/fpga/versal-fpga.c
+++ b/drivers/fpga/versal-fpga.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/fpga/fpga-dmabuf.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -37,11 +38,34 @@ static int versal_fpga_ops_write(struct fpga_manager *mgr,
 	return ret;
 }
 
+static int versal_fpga_ops_write_sg(struct fpga_manager *mgr,
+				    struct sg_table *sgt)
+{
+	dma_addr_t dma_addr;
+
+	/* zynqmp_pm_load_pdi() takes a single base address */
+	if (sgt->nents != 1) {
+		dev_err(&mgr->dev, "dma-buf has %u segments, need exactly 1\n",
+			sgt->nents);
+		return -EINVAL;
+	}
+
+	dma_addr = sg_dma_address(sgt->sgl);
+
+	return zynqmp_pm_load_pdi(PDI_SRC_DDR, dma_addr);
+}
+
 static const struct fpga_manager_ops versal_fpga_ops = {
 	.write_init = versal_fpga_ops_write_init,
 	.write = versal_fpga_ops_write,
+	.write_sg = versal_fpga_ops_write_sg,
 };
 
+static void versal_fpga_dmabuf_remove(void *data)
+{
+	fpga_dmabuf_unregister(data);
+}
+
 static int versal_fpga_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -56,7 +80,14 @@ static int versal_fpga_probe(struct platform_device *pdev)
 
 	mgr = devm_fpga_mgr_register(dev, "Xilinx Versal FPGA Manager",
 				     &versal_fpga_ops, NULL);
-	return PTR_ERR_OR_ZERO(mgr);
+	if (IS_ERR(mgr))
+		return PTR_ERR(mgr);
+
+	ret = fpga_dmabuf_register(mgr);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, versal_fpga_dmabuf_remove, mgr);
 }
 
 static const struct of_device_id versal_fpga_of_match[] = {
-- 
2.34.1

