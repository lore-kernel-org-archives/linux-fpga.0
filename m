Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1462D97BE;
	Mon, 15 Dec 2025 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765787322; cv=fail; b=b9Q89dND3YROG4i939xTO3r1kya6NrCEOY0M59ndEAjh7cjIMdysoIkl0378j9/IJipR0kOUrM0ZtoUw9mh2c1BWyPI/rFuXqD3/URv3RBDxtMI4cyUCoIlYZMBjUzQmkGKS6QwJyfri212xFkAuAKxFp7ZQ7Vd62eCWB5wfJNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765787322; c=relaxed/simple;
	bh=3yiWAGaPtMNvk6XKRjSnDzIw1bcfhhyQoDuYz7PqlHo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ukzchssohu3c7QGKQE8o3r/MgueDfudhTTYULuW1Kqvea1ihT44th2om49NM4FjgKmEGvAhY2glFTV6vk7xWTlQgjYC2rMMoEVznqMazZ/6KCV+VnfdgKpqLgdD1Chn3Bt5aL89JKIgregO0hMiJ8dkpxJO6QaO7pnlUf8y1eqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZCmrFe5W; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZCmrFe5W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZQn+s7Nsjo6eySvpfeQ3PvOUPxmMQx0Mxm1oP4pmTsde6EtSJUT2h9RNBERW+jA7cF50i0dcQpn1xl+yz1MhkUyACHLPv2uT5GaleJzJKzUymhJsPKpKT/lqATCmODWc3fvstwB8iu3C4X4/PVwFXJkjVn/SymY8Loa2oymlrPqkrTA9QeOkrtxaer50BqQnOYmQrsUlGswDxYqGWU0mMYtwCowPXuCgiWkNISwq7BAIALPG4tiHN3RjhKHVX+KrQyxXXIlqtG4yhtHtsQUlPI8LVXO/+WwQcqlUctpn93uCmVuNAYjAwPSu6KYOclGRUHSyyMYPMXMnbtpHugwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5379LnMx8g0UOH+/q3HDROHzF3mIk6HNg9AEY0p4ew4=;
 b=Mr+LCTQxViZWT4KC2AgK0BtwSruZ7mIrJC6rM1BjbhaFHihlIUxq6hwBhHek39lx/BTsI1wBOHU6Kh7ZCwW+bKnJFpbW9mycDDG/3GgJXET79m8xiuvs0TtQDZr5zoj55F1L3whfa5DTAJhv6Ud/kxQWIyONmSYn5lIxHS+u9ChiI2/XRoPT84LOm3D/XkN2oRCBaVbsmFHu2YynVaa7kKZSl1SOxg2utyT2LazajtJGks2FXRw11crh/Se5Cwi/48RM/HZw4bioycC2Rb6kIxT0JkkXaz4d7V72hfDCC58rAEo18vLMM9qJ9Ei+JCeeOP3W0pwUiRwdGmP68rB4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5379LnMx8g0UOH+/q3HDROHzF3mIk6HNg9AEY0p4ew4=;
 b=ZCmrFe5WWjKRsZUJo6fGtE1kY1ZecbOuY4c8501Q73hGkfhwqLfCDxxCoWYBsrGax7N1l4TboVm+uyNvOk8F3UYLVD7WCnX37NvAJLPiUs7VS8R4aHlZeXx0KlCiNHVu6EFQiWmaa8GMy3pNk5Yv4y/FnH3eQdM0jD/FMgF2yi8=
Received: from BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::14)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 08:28:37 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::84) by BL1P223CA0009.outlook.office365.com
 (2603:10b6:208:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 08:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 08:28:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 15 Dec
 2025 02:28:36 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Dec
 2025 02:28:34 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Dec 2025 02:28:34 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@amd.com>, <git@amd.com>
CC: Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>, Xu Yilun
	<yilun.xu@intel.com>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, "open list:FPGA MANAGER FRAMEWORK"
	<linux-fpga@vger.kernel.org>
Subject: [PATCH] fpga: xilinx: Switch Michal Simek's email to new one
Date: Mon, 15 Dec 2025 09:28:29 +0100
Message-ID: <49de9536c9952a3a36bb996f2fb0a1f0efb1ba6f.1765787307.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=michal.simek@amd.com; h=from:subject:message-id; bh=3yiWAGaPtMNvk6XKRjSnDzIw1bcfhhyQoDuYz7PqlHo=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTaH1sf2LPb8U/Jpy9sp08su5D3tfPsKofoyXs7JP3De PW7jjLO7ChlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJzDFmZGiQO+Cxa0nRjRkN GoqXC9Pc3jNNKJnVqv876N/RFQuC/b8y/C//XcqY87/tdJ1VkoGp9ISn87+F7X5++n7rLOEYwZW JMrwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 26cbc903-6a47-459f-49c5-08de3bb3f1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bgh5SeR5Q3giqTs86j0cG5RdiiXoJiQn1T3yHikEAFed1TRKGVEPiSFC2IaL?=
 =?us-ascii?Q?XvzXxcHd5VgFssaJKkJV+1UYfWWNNuit+1Dq/G+g/fC87ykSBvGmID+ePDMx?=
 =?us-ascii?Q?oXsoozh+IqE1+jGH0parot2OyYUQlqkonz1Qlu8/dVJjJ0+YuYME97yYpjeb?=
 =?us-ascii?Q?ODSQMphvWayxrJXWlK+vND9RkLtLKRaunQdyKwPevYEh9A1MOR7seVHUxODW?=
 =?us-ascii?Q?aa9pTkeztr7b8WBxPZIHDKXWwEgZ+RtqgzwFNOr/9QTgywaKUREcp6Z8Cidy?=
 =?us-ascii?Q?5QDrbpP6HiMf+CKE4ftMVAsZD1PVfUWI4BjbsPHTFAGdaMGSUBld6X3uj3Nn?=
 =?us-ascii?Q?WH2miseAhyl0CCAb6dYNfGTXwhY9/6cGE1zX92Zso4E2BXyfP3ubmM1qBVWA?=
 =?us-ascii?Q?djZMceezh/zJoo2aloj6DTl8Q0lVgnGtWhIgSrX6vDuCVvF+WbVmtoCpa6aO?=
 =?us-ascii?Q?x3G0WLk/6g6vmuo3Wn4jU0NbSxLhDVWsk+cgD0uqQRsM586pw6BghdCySEY2?=
 =?us-ascii?Q?39E1y5ncnM8lzM1QWmN8ljB8hr8udY6iNoJbGGSzKJuZaycEnVAV1JKZljLe?=
 =?us-ascii?Q?6o4DIdvv7vJjbB/PerBesDJHSFdH6ClojJj5g2q3FjmDH5+8K4cbH0PTg50d?=
 =?us-ascii?Q?1CbZz78JNTli0s5jW4WbCDMvW+D+Bi6kFhtHgKObbLXv9cDDwEawKTlccF2g?=
 =?us-ascii?Q?tlYjbKOxZBowPWU36UTMFbs/eQQtkonkjXCmm/RvsRCnMAe3gpaMbc7W//6o?=
 =?us-ascii?Q?N+KqXDpq/ZovNf1A44OB1c4kwnkL/Th1xYh7Hw2dEOdRBtgCRr/cxbI6mGBm?=
 =?us-ascii?Q?G7MF9ZkGgvWqJTBLdB1gQf0yDHq9EqXtIAD/snd2nmFhlVIGAyFy0F5t4kf0?=
 =?us-ascii?Q?B5JR9TMQcA00v/Md7px5nw/t2lKF8fpHVcyKs1+j3BFhVAyN6kQH9yV0oW7B?=
 =?us-ascii?Q?552o+SfFeQYdC3dbaACRQwnrgMK4Vv1nSWa51RRShJ3F0KceRjrUUdkzug+k?=
 =?us-ascii?Q?7Ps+G+A1+fsVUwZlgH0tXUEMpsgCVynl2u+CxzABdgV9oHejEGCsSrEORxQ0?=
 =?us-ascii?Q?8TZdMXv0zY1iEG8n2UF6Xg7nSi6LMUhUaBPi0Kjik1/2q8IY9Ouw9F32MecE?=
 =?us-ascii?Q?9N7Nj8WUb7ffyL63DTIxiMRfOUiv5MG8+HEVlwUzPS0Yte1wWJxJt+gVHNmL?=
 =?us-ascii?Q?3t6ULKtVN7Ks6x7D+GijB8n4Ha6Vn6AHAo2KZ0X+AodfKFJTy2sRPRztEehb?=
 =?us-ascii?Q?T8t8KGye4BaJdgBt8nsWXx/lyEdF+QDDU/qHSQOd6MV23IJTL4vMYuWs7sGZ?=
 =?us-ascii?Q?1wvS8axYYaRSZZyfBdg2X62LO9AbHQQ+WF0I13tWkmce8rfq7s6uUqCs79/J?=
 =?us-ascii?Q?oKHgj42nPYQ+o64xce+XChfteWA99KWiLfluZ982AO+GCRZVfUeJxaDwaSjq?=
 =?us-ascii?Q?aa+2pvgv7RhaTPI4zjtX3tGlkmCnMcWLL14r0Ampzz41Topr6k24Cw4QMKB/?=
 =?us-ascii?Q?LPCQhbn/fV2k78pWgiIMqQXGlOD6Mdu+rZKAR61XPNpdiMoDr7qcl96jZlvM?=
 =?us-ascii?Q?pr6DVHc2EQUNUvYb7iw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 08:28:37.2139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cbc903-6a47-459f-49c5-08de3bb3f1a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274

@xilinx.com is still working but better to switch to new amd.com after
AMD/Xilinx acquisition.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/fpga/xilinx-pr-decoupler.c | 2 +-
 drivers/fpga/zynq-fpga.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 822751fad18a..6994d68e9036 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -173,5 +173,5 @@ module_platform_driver(xlnx_pr_decoupler_driver);
 
 MODULE_DESCRIPTION("Xilinx Partial Reconfiguration Decoupler");
 MODULE_AUTHOR("Moritz Fischer <mdf@kernel.org>");
-MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>");
+MODULE_AUTHOR("Michal Simek <michal.simek@amd.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index b7629a0e4813..9d1d599ef718 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -652,6 +652,6 @@ static struct platform_driver zynq_fpga_driver = {
 module_platform_driver(zynq_fpga_driver);
 
 MODULE_AUTHOR("Moritz Fischer <moritz.fischer@ettus.com>");
-MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>");
+MODULE_AUTHOR("Michal Simek <michal.simek@amd.com>");
 MODULE_DESCRIPTION("Xilinx Zynq FPGA Manager");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

base-commit: ebfbf945d90b0efff3ce0dc17fb7f1f0db5b6628
branch: zynqmp/soc
