Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794295039;
	b=xXPxDa4X3HGUcRr17hQCPyr7L6gANz8obZEQSn3PdaAwutcF4xFHJ0HETy4a56XUb1mi
	 XsThyaH3SMYqhPiSieGPBjSiMCXFW/lUo6iQ+LmOsmpbtcjkPVIap257laY6DVXMIC2Kc
	 pfAWP+mxoRY13Q95P0gNV+IpWCJFnAta0gLReisvEKl2kh52IBj82dJvQjIFrHcfYyBto
	 KH6qokFgvTnW3pD/lcZV4SzVd0alDe1WisLPj/llQpuhQKME39gk2VPESH8pjWo7aFnCs
	 hAVVgmpE2MkBiEqezG6Ygo4SocD+WWqkmwwdqxWaz1zLP/gUo8bapo0v5mxjIz86vVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295039;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:X-B4-Tracking:X-Change-ID:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ACMszO6yIjeEHdllxoWhhw6yoEA0sHblzco0Hv5GICU=;
	b=JzVCQ0o4nTK6ZzqSZ12Jka/mstjm6R2Xpx9QAcUhwseWeOD8Hg5LRNROaEsFLVURAbup
	 oWNLSv3muqwHQjNPU5TNoMUotpCjk2CrdSXmy9ZolwCd4Q9gwku6L4hp0tF+ZS8KhoA4T
	 kY4kJk7DYGjyT4HvNWkdZhwdzX+oUUWpTZ2LMhCH6VEh0JLOx9qUkfTcshI+x6H3R2y0N
	 J5J0QdNnphbg0Nd7P0ndhGI6b+NkrK+d8pQB//5OulB5MPYBJXNzxL9M+6igAC0mzAyHn
	 EAN559/Qoffi9CK/4lnElp20L/jMXt13wfEV3TpTHEy7aVtageUKF25LIi0hxZqTcSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="ue/XGSEz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.16
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260DB606A325;
	Tue, 10 Nov 2026 07:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 260DB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ue/XGSEz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4shnVKPYr/1jnzrs2jIq3A46waUHHZL0zRtPFgoTRfbEypKGX2MZhewIlu0nRz2SvJsnt1rRX/kK5M6dnpknSyAMMuqYQun1UWjkyroiwpKmaa59ndpteGRrH0tge4f4H0+5DbehR2i6WO7HvakgeebsMZGut8t921UtzEQbOqRi2WebimJxa2XKxHhctM3rNpDM3K1uv9SVcmO4qyG5VgDijbzIGKrV7QH62mpP2EPFJFQVvGrxDCeRNseXKwKEcokWL+0DpUjpztuurKya5FPzL/ghaIxqY66W+FlBu+bhb5DFTReAehLmdpgGJmMpAiue4IY4Xm7UktPilUFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACMszO6yIjeEHdllxoWhhw6yoEA0sHblzco0Hv5GICU=;
 b=vKsyXPCTr5oS2zraxz4k5DUWok80kzjx6Kr1TDDQAO987QmrLWwDtqNk85BjPgsK+PZXXhx1XXyxeIveZxdx/qCuWQoHF42AFimEjNV3Gxz/C9tbVqlBZTldZj44HG2AVkbxg+87vD19z7gtxerOXB+GeeTeScnSH81SSRBno4mQM5IQ5gOHqnqhEqoQQDqG3HWdv3YHCZfXDlLvyCvyT94YLPLoDcMO9MvNclQDZBIISmHhQhKH6DCCWBL82VZRwB7kW4vGfuZR1jnvMuj2Shy0n2lVzcHcccXYs9H5IxjlR6JpdY8Uud1J1hOUW7unT6kOOI2OCd3pSUu7X587XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACMszO6yIjeEHdllxoWhhw6yoEA0sHblzco0Hv5GICU=;
 b=ue/XGSEz47BgyMHaAnuzm1+UX6h0lPG33oZKvfYH11sHHsI5T5Mmh2w7xgwEQ20ZwLkys4H/iQW9U9PmWwJlufdYyOxBiix81b5nb7irqLUKb4m0u8N7kqgBcuwUhpvC90ZrWEjtv6SqWXy/FZIzxJEDicNXfXGJ7nc8kXsLrZg=
Received: from BN0PR04CA0154.namprd04.prod.outlook.com (2603:10b6:408:eb::9)
 by IA4PR12MB379828.namprd12.prod.outlook.com (2603:10b6:207:143::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 07:17:16 +0000
Received: from LV8PEPF00000059.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::47) by BN0PR04CA0154.outlook.office365.com
 (2603:10b6:408:eb::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 07:17:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000059.mail.protection.outlook.com (10.167.245.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 07:17:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 01:17:16 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 01:17:13 -0600
From: Aravind Thokala <aravind.thokala@amd.com>
Date: Tue, 10 Nov 2026 12:46:35 +0530
Subject: [PATCH] fpga: xilinx-pr-decoupler: add shutdown() handler
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261110-pr_decoupler_shutdown_handler-v1-1-b833dfe9d380@amd.com>
X-B4-Tracking: v=1; b=H4sIANLE8moC/yXM0QrCMAyF4VcZubawFCzoq4gU16QuIm1J1ymMv
 btVL//D4dugsgpXOA8bKK9SJaceeBggzLd0ZyPUG+xoHSKOpqgnDrmVJ6uvc1sov5LvV+qDmaI
 9nlx0hMTQjaIc5f3zL9d/1zY9OCxfFPb9A4plStqBAAAA
X-Change-ID: 20261110-pr_decoupler_shutdown_handler-bf2596f6d1de
To: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix
	<trix@redhat.com>, Michal Simek <michal.simek@amd.com>
CC: <linux-fpga@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Aravind Thokala
	<aravind.thokala@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794295033; l=1742;
 i=aravind.thokala@amd.com; s=20261110; h=from:subject:message-id;
 bh=dsrA1WAi8TbxqO5q0bCmjKadRMF9aX4i+KtydGhSXbQ=;
 b=H4uYUjw5HpQIk1Rfixita+tNlnbjkAGledo3u5lK45S6J7SKywmLRxzQ51xkd4vOdm33kaN3H
 eGg1WJDT/iqAhnDzYPiWevcd3yUpV5S6w2KDl8ZUU15s9W02iwLjRns
X-Developer-Key: i=aravind.thokala@amd.com; a=ed25519;
 pk=PRM+iqXzDj0C0C/vWTONu+tBeWoTqWRDeeXllRQZ7ZY=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000059:EE_|IA4PR12MB379828:EE_
X-MS-Office365-Filtering-Correlation-Id: ae44d356-2f5b-48c1-2795-08df3efaa6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261009223027099003|56012099006|11063799006|261026121527099003|261021121427099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3cPjmVYUdb0dz91ZNWxzIr8/Kc2kOG+oXx+G1J0UbcGuq8Hjrc1UipFwwpIm1eqHGfUGRO7as1y/8T+KQdqs5zMnHMce6MMG/5Z1OZLZOqpp8LseaB1+QUCYUTY7BSRsuLtmb6Ool4f+YsPF2wCjmJHKZfdWs3stGPCS25lFHHxzlw/9kvcturUuwq1rhJNnHAXQ3Ii1vgxwBxRcx9jKePKuZNxPmnfq3gbxfbrXtEcixN5Wqw4i/9wJekQxPEpaRQgIPOCMOaeTHsEUKRyiXIxWMBF+sNJP3mPQvyBtOWmZRUv9chCfiofXlkc+19ZnuYkyjaA40EEpMjBrOgUtBhqhMUxda5Y3YK3AOUfLa8vhOKPahMGP5TKKNsoUbQFjeu0kDLMlC4sZwq9lCQ2i0wMHEyg+IBb+YX0OpLJryiMCEw6mugVAXk/YpZh4j3i/1iNitzpWkwTa6ko4kN92QgLcla8fl2yBujxxRJ4fcjnPEJ8P7OiLIqQgiPKm3fU0Bi/LHtpkcqdKHshkt97Vd8zVjLcfrSkBopwL27T75FZOXd2gPKgp/gab1wDvCKpvgQbQO0UIPJjXJmitvC2hOFCwUGtp2i/1zUeALrmWrORHik6GxMIYvl8YdDwJ+HA4u0MjOyyW90HxwCbVMKMl2P94pqBE1umiEnvEhNx6ZDhwVCkglEGyP6S1BDbk0hd9Kc74Pv/oFbo0Qe5rlLbFog==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261009223027099003)(56012099006)(11063799006)(261026121527099003)(261021121427099003)(261102123227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UrL2dKfj7vtIAlFaV0MlxsRmCCdbA+DPheo+PFpIKinxdxxwqQJidKD2E7m6c61ELpzQNtXt9LaHSKZQBmihqC0emIqv4IvaJ2zPn1MmigzqbXtAfn0bp9uJ6Kiq0jUEt28X+ujLuoSjmoKYo16ErcmAIdU+aPQcHazXpUm8JVJePlK1z1d7oFt4mi596jNkpiQy0xxL6hijq9QHaTfouC6oI+HuQCrzMKlvQ2kG7EJDJ6mwrqNgJ3nNhIyYubRhPu/givLq7rLfQn11NxFHy+Rs8aUpxsjPOhanZdD9/nIsI9KC4WdYQZXGrBpJBkGEGGmRpSL1uGRN0eQ75PBSvg60IFnbdLsvhq4msTXF616KuK5XXG9C9xJI5Y19PrrUKPZi/RxNOBy0KsoJuuhoAM7iQK205oRsa2LSVrFys+EIR6EiD0jCrWFm0vBhuK1h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 07:17:16.8367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae44d356-2f5b-48c1-2795-08df3efaa6aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000059.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB379828

Add a .shutdown() handler to decouple the Reconfigurable Partition
from the static logic on reboot, shutdown, and kexec.

The handler writes CTRL_CMD_DECOUPLE to the control register. On the
PR Decoupler, this turns decoupling on, which stops signal changes
passing through the bridge. On the DFX AXI Shutdown Manager, it
requests that the IP stop passing AXI transactions through.

Signed-off-by: Aravind Thokala <aravind.thokala@amd.com>
---
 drivers/fpga/xilinx-pr-decoupler.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 1405ddbe88f1..75b59edbf440 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -137,6 +137,13 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void xlnx_pr_decoupler_shutdown(struct platform_device *pdev)
+{
+	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
+
+	xlnx_pr_decoupler_enable_set(bridge, false);
+}
+
 static void xlnx_pr_decoupler_remove(struct platform_device *pdev)
 {
 	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
@@ -147,6 +154,7 @@ static void xlnx_pr_decoupler_remove(struct platform_device *pdev)
 static struct platform_driver xlnx_pr_decoupler_driver = {
 	.probe = xlnx_pr_decoupler_probe,
 	.remove = xlnx_pr_decoupler_remove,
+	.shutdown = xlnx_pr_decoupler_shutdown,
 	.driver = {
 		.name = "xlnx_pr_decoupler",
 		.of_match_table = xlnx_pr_decoupler_of_match,

---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-pr_decoupler_shutdown_handler-bf2596f6d1de

Best regards,
--  
Aravind Thokala <aravind.thokala@amd.com>

