Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213525393E;
	Tue, 23 Jun 2026 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205332; cv=fail; b=bZ+8KbV9lts4R2VmzUuf92bklR8DbWhsRcC1S3pdyt+YkTAXDyUEtfeKRSSB3I3cl2WZ16n58aGB5cx21OMI6YzxZ3Ljzhi3NClmAaNQUmi/I+rG4Mu266RjURqmMR1uAA1HbwqWAaJXg/XZyxmxL7bUp9H1dVtU4pDDv0Pp2/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205332; c=relaxed/simple;
	bh=dkI1s0OOO76khw3c+oeECBXIe2DMS/KN/JEHC0DGVss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eJfHinDbRcq4GPYKIhCztpGNju2NVraZD4x9wzEpwXphVtvBIt4Xyted+BGlFCIreUbtVlvyLUKLs9leb4IRe/2MxJNGQxmWLH6G1Zj7l3yCEHlIIrxks4z7voe2jlzX3awVT+hgkDYrMNrptuywXJ34s5SrlqMaiZUY8FjSi3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H7twu6/N; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H7twu6/N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AU54zTDVcC0h/AEMDVx206/e0Dr17uj4I6mAYIl/FshfbM/fyXbBIGq7ZutGUwjtS+6zGZC6OCxx4t9Ey20tHVEiVPwPjkGONtXMj1Erkc5a+YJmK1bNEzun7JuyJlPb/wn6SW8kS1qrPhr0rRnO6vgVxh5iP/a8yomlgXwEle2tHyVCnem383soCwVl2k5vOt0d05JsQPtJSl5lQxAk4AU3FSnV2HL/NRc0Ewzaemq3qed+rbn9ntkHdrU+ouzblOm7Cvjmv0eYngdiYx300Kj7SdiZ+sknIgtzPwMQFIPseYxKklRajnwhv9sqYp6gyDyIsl2WicabFxHz4rS7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdlaDW1rY1rZErwxB1HGnYFNRg5JjM3w+I1SGSwz1BE=;
 b=Q6LD92AZ2Z6lJuljdNXEqkHpcLbDTU8nhdvJIrVSCnzzSwsAlX8hhHCKhboGh4xxfagdrexvXbIwpD6Qo23hT/HGjkC4TEUOmWYtYKyr3Zh1wLKYqWuB9+wy43Uzr77PCC/7Buuc2Y/JHguhjS0XUfI/7XPqu3vBZE5VECIiWbsCCwAt7a1gINheXh1bKYru/qKs0Gb4/d2Y9Bb1l2126oplakaGRAMLY7wjGSYwxcPzD89B4XfEVN/m+1FiYtN3ny9wekr7DJyjX6bqwiQUFeA1yvfZy9aru6itRi0ewJjDa8w483DWfZR97P49IlxPl+Mncgfh7L4eqUL8/6pJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdlaDW1rY1rZErwxB1HGnYFNRg5JjM3w+I1SGSwz1BE=;
 b=H7twu6/NSXUhtQsTzVUhRmVimLenY0pMbCBxoPbaAn/eE8YEPIEOA5vRsgUyh/4dZn6v8CsQiEdJSNFF4EgMP/KIjFAu495cadESm+M63zmFug8AZ/a06RueMdA2K08OKspWrSi8RTjnJneqJhHv17nS1azdHPcK8ZvwEVoNhd0=
Received: from SJ0PR13CA0103.namprd13.prod.outlook.com (2603:10b6:a03:2c5::18)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:02:04 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::26) by SJ0PR13CA0103.outlook.office365.com
 (2603:10b6:a03:2c5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 09:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 09:02:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 04:01:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 04:01:37 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 04:01:37 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@amd.com>, <git@amd.com>
CC: Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>, Xu Yilun
	<yilun.xu@intel.com>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, "open list:FPGA MANAGER FRAMEWORK"
	<linux-fpga@vger.kernel.org>
Subject: [PATCH] fpga: xilinx-pr-decoupler: Use devm_clk_get_prepared()
Date: Tue, 23 Jun 2026 11:01:27 +0200
Message-ID: <8ca8ee5ba720b608a41f842d2b743302e5500ad0.1782205286.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2405; i=michal.simek@amd.com; h=from:subject:message-id; bh=dkI1s0OOO76khw3c+oeECBXIe2DMS/KN/JEHC0DGVss=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZeWeHsLn8Kn0eZ+G/d97N33OCHbiyZ3y6xZqs9vLQT Ye6Y4EOHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjARaxFGhi0/vLf7TDdV8z09 y+eG159X91eF7b2iyb2ysXLteuYFE/UZGVrv+Ykvzqh3qarqcpKuY+Eq5PwkxPmk58Hcnjfrr4Y bMQEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 926063d4-e1d1-4d90-bf75-08ded106185f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+1vpjZ311h9CktFtUihF3BCyAQXsDLnrQRyp9US14YAddy+JEWAhmvHUwXE1Kjp+aX0WefvaySobU+U5em78AI4jDiPcva6rvwdyfC1AOihePpkVC6gciSn646tw+PZgK9wjMBRfeH5Z5SN6a00qfzyZVp2J7i3XcJ8J0SHrr6ATir/i3EuDFogLMGAWgnPHehmaIVY86HURpQPl1cN/4aaQH0zPSUYGW2/2aNHXprNxAh5gLwCKZHXq5Eba1aGBIxsaH8nO4E6ZJXjFTZ3cPpUXfM7T0x49wD3VNcUX6NPagv2+N+FWDEihqjQHde6JobNkPFFTSoF0U4emEI1G4K2OtQZRfXHt7g1lvO0B9X++G9rQhz4V6nsWnumcQh8l4shzuDu7Ean/MLUz0o27b9AjtyDBhSehVcagNyjKEeTwZvDiyK+jhIu6uZKzUfAv9lZJ33J/5ybd8/2JMoUGImYV9V3g4NynHPBwq76XRNG4S1NtDAQuQQbR+LRfzyYDuQJDyHqi/rzlIfalFO0h/S9lCQPpsJV3RaFTll73tcXAb+kHmVSetST1r29Oq/kHbJPZWl3wSXQvlC0NEqk84hJl4TFhJVVbHTSKIYFCLa7ZUKTtqzs+Ejjj+XxjSNFGNtPaGC4SwUBh+aiSWcLMiervCGpcOftO3zISE3ruEPsHVYBjz17YurssZZslPGowPKVn7qdEJJP4+xsn23hyrg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e6PLkJnjLYguvSphlyLjnW3pQSA9UtBC9JInpShMjxYKybGar12PtiFAoGjoXKMkb3z7KWMOjVP6sQQNXAe2Gl9BPJ99kdeUM8pUUfFp53ofqyk1ej3YGT1VOLCoF4c90ZX/VpdQ2wlbjZv3GbYr8W1Z53FY0oGMagseIhWJuHz5r60iibdZ5Qg6aReThMaXdm+Ac1BLW2HjesWC+TPbmqFj+JToPj/N25FxhtqOxVzhybNOhCwZO2hLSisCHKlD6zr2AjloBNya1xFFzbUhbPDOjn2bFv7yqx9hUTzqVZ40MY9RtFhvAtfPT48EkTYZxmYT0tES5LDbR41zAoIHK22aGhchnTlwQJKxkjkBE/byiB/04MjnSgcHM6O88GiyjWiIzsjeFYFxz6AgazBiwplqjRCBomnl1Fhp5xcG0eoG4g5aDpB5q7SNLDWwSee5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:02:04.1309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 926063d4-e1d1-4d90-bf75-08ded106185f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787

The driver keeps the "aclk" clock prepared but disabled in its idle
state, toggling only the atomic clk_enable()/clk_disable() around
register accesses in the bridge enable_set/enable_show callbacks.

At probe time this was open-coded as clk_prepare_enable() immediately
followed by clk_disable(), leaving the clock prepared, with a matching
clk_unprepare() in the error path and in remove().

devm_clk_get_prepared() expresses exactly this: it gets and prepares the
clock and unprepares it automatically on driver detach.

Use it to drop the manual prepare/disable dance, the error-path
unprepare, and the now-empty clock teardown in remove().

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/fpga/xilinx-pr-decoupler.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 6994d68e9036..45b65a3264af 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -118,46 +118,30 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->io_base))
 		return PTR_ERR(priv->io_base);
 
-	priv->clk = devm_clk_get(&pdev->dev, "aclk");
+	priv->clk = devm_clk_get_prepared(&pdev->dev, "aclk");
 	if (IS_ERR(priv->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
 				     "input clock not found\n");
 
-	err = clk_prepare_enable(priv->clk);
-	if (err) {
-		dev_err(&pdev->dev, "unable to enable clock\n");
-		return err;
-	}
-
-	clk_disable(priv->clk);
-
 	br = fpga_bridge_register(&pdev->dev, priv->ipconfig->name,
 				  &xlnx_pr_decoupler_br_ops, priv);
 	if (IS_ERR(br)) {
 		err = PTR_ERR(br);
 		dev_err(&pdev->dev, "unable to register %s",
 			priv->ipconfig->name);
-		goto err_clk;
+		return err;
 	}
 
 	platform_set_drvdata(pdev, br);
 
 	return 0;
-
-err_clk:
-	clk_unprepare(priv->clk);
-
-	return err;
 }
 
 static void xlnx_pr_decoupler_remove(struct platform_device *pdev)
 {
 	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
-	struct xlnx_pr_decoupler_data *p = bridge->priv;
 
 	fpga_bridge_unregister(bridge);
-
-	clk_unprepare(p->clk);
 }
 
 static struct platform_driver xlnx_pr_decoupler_driver = {
---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
branch: xnext/pr-decoupler

-- 
2.43.0

