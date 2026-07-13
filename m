Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012006.outbound.protection.outlook.com [52.101.126.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4189542F6FF;
	Mon, 13 Jul 2026 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948970; cv=fail; b=t4vWzygGkck+shC884rb4tPaZ9GXg7ETmKkVuquzif8lRGLsUGLJ5Jd+Uf8BlRLhuHxZJTP5WYtk4FRLQH8Mx/TvxAcz7tttnNNkrQI673otN9AbJkbibCOpfJsOg8qNsIeEKhuO0EvIz74X4HTJYEHfD0RdYhoXWy8qPULWkZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948970; c=relaxed/simple;
	bh=B9UOpKPptzzGHMYPrdc7X8+0Lg+LXOsTuHU7YCvJ2UI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=I1PS5r/2Aun2K4q20Rmsx05kqJzOABrmYDG2Hq9nAeSmcBVlQvEP5ANIkqbxpuzqSYFRf/VcOhMQ00PEDfzYAMNcB1Ed+UPqzuwz9VtY5wyeKL4b5YVHzgtCL+44WBQWxsxZgOKGRJRcsKQscGwBrdDtDoPPXuXHkTAdt3jT5sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PZrdg3DU; arc=fail smtp.client-ip=52.101.126.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PZrdg3DU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0NBMU2vzjyipnlwHKY6oBUWVSib5E/3I7KZ8DL40666FS4P1zgE/8mDU/0GmUWtFVQaTLfxoa5N83Luz95MX4+to+HBq4/q8MI+Z3QKom9q/VR2Qg6Ya12YkP0t/g99OKy9sfpvnyWpt/sTGEzKYGNzVT/w5EmHK/vx5I4FRRDcIknzRCJakHM5kDyhLc3TxPfwcHuJWhTN6KLBGItopBLL37y9WgzsKwHiovTQjh/lzNcQqU1dO/QDm/wX9zLMcKYNkgawkLHPIvQi2PNYMvxrJP8D7uSLlGaqLECxxzUSL3pxzUHO8tzVl3Wk8m58uPa25fi6mkJPQWyxlJjF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP+xtcwDvQ4aCQZqMdybSJIGAwQxrf3XS15BckP0hyc=;
 b=TvRXByKlyfg6FGu0ySoqCvc82HpuyyKvaVqtsOw3z7oqJg/+1GmPOe+dhWOZEDrFBX0x7kgNPEIetmUNm70aF4/+nLCdy89x9Pwq51BKfasOQNlrYWiqYys9wBM/OAkjE9ra60vmnLJm98y63vljosM8CdwfO43c4e2sZtpnEybUf0qsY1CBbQIIWhx3GqLs0H4KwJfBOr2gUbZ/ln7PzakfAx9/5MNjQPdNNUFw60FlKW1SnhWlYeP8YdcjB8FEnfvtpbXcUhBDxdjiChvvGvcLqlu2IVJRFUV64hmO0LIH6kWYSWPZwRfgTRQqXwtiF0vL6wJYDfdn3s1vBkFXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP+xtcwDvQ4aCQZqMdybSJIGAwQxrf3XS15BckP0hyc=;
 b=PZrdg3DUhtUoD5VCfs+r8d+EIWmoU9Pq7OSj0fdjw8BgguD5WEZyjsYImv5LPZv4qoWTf7PXoZIiwH+v3IQ0olFQnr4vaK9ve3CwxOYlW29U4jeZ13fdxQHib6CkBg2IDpjxy4/yEPvEPKwdUaZQSrDD92aMFrB/V2WyOIX/YxMUw6prAYOIM5ow5tTBqzW7AwyS3jP6Mttuoo0vhUPWIf8n10FZxgnDodzGMnAL9Z+u8hodKvElXiPUg+9UhvCbDHODr86ul35MlXq/DhdUgfuoCsLxoRqGzbNg54GME7o4p+LfOtQYMXXhoUEv91r/W3+LBHnZfKDtemDXZtjBmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB9248.apcprd06.prod.outlook.com (2603:1096:405:3d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 13:22:46 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:22:46 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org (open list:FPGA MANAGER FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH] fpga: zynq-fpga: Remove redundant dev_err()
Date: Mon, 13 Jul 2026 21:22:36 +0800
Message-Id: <20260713132237.370272-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0060.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::10) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYNPR06MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd2aef9-83ec-4fd7-9443-08dee0e1d3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|23010399003|1800799024|38350700014|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	t79cqSHkiIvPS0JvQKFjeDfizf8z/OKsde4zR1H3UHJdQfdKK4QcqUtBap5A07Jd9/Yo+DfCeEooBqhiGnuL6DSRLi51z6VXUcK//z9WXs2zSS3ay840TM+7wv1F1R/U8+yi5Z2i9mTevgBPsdiUu9TJIIlMb4kWEXZvKqoc/aCUZyMd1YYQHl2tk9EUGZdnm7t/SCGJqQww6bKH8ySAqDwksLRn1PYIZNpLeCdcHMp5co0L873JVvOu9NIJRLeAwRRsGkt2ur5byk5BaTlELJ4eQ+5QYS875dOAdnL3U3QKSV9xoVv9/QEN8G7oDZj3xvTY7GTLV9Y7GZEogGknxCMWPAgFs2w3o21wuRYa9boreGWrNSClcmpz7YfXUf6Wt1itncP88YU2+2U5Fu2x9nYOpNIl90OwL7DWPHvP34UWnNLlWGqE0LhJfJviv5dG+VfmrA4qNwkSaiSlirvia6A/I+ZlIr31+b9IXtzlrmnHRxnSjvxa9T1wDq9cRF6V7p3/x//9478ooWeofCY7WCs7UxdHlDBW2SN3xGgAy8I/wgXVYVUNR51JInOLZa6I7uaBwAt/4LFusSkwXjfCYA4v9rSfWno3q1aALXo+L7XxrES/edh9W64T6os3TEytWEIzzl72zNl5Er+4uka/XiPtDip6K8Rb8abYtBL0Fswl8Zu3k51BoaP6URRe3vgxNcb95l+czKt+zjl7X5acNfxNDcprZ9M53yfgKqNq48k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(23010399003)(1800799024)(38350700014)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e2/yS9xsz+MmoIOcPBFqkyOiyAt2KzdzMCVrNPe0b+NRnd9HAnV+aPFBRk4E?=
 =?us-ascii?Q?sQ5ocPJpYARekC56bqM/pPCDMnnTAw8ySl2e4ecF1F3yKkGi3hJfHlOuOGEi?=
 =?us-ascii?Q?wQGLAs5xapcNQlWkUnWPu88xSJ5YJ2iPnVM2jmcbF500nrzlk93oWcCk4+pr?=
 =?us-ascii?Q?ME0GgOhNmTBugigDkreGL/1BfPy+dTmnLoHdH0ahiy6/KzNev5cIj6xIAHql?=
 =?us-ascii?Q?fHDAxQT2q4jZiO816DFxo15q2fV0nWvrcpGGBaywfYxWJ0bY74oqbeQdWcRn?=
 =?us-ascii?Q?QD1Vomv/WFr2/dGdUmEQRr1O6pSxItX8hLIwIXSgiJBf/73f1J6ZZIOFBiAA?=
 =?us-ascii?Q?ySHlbjO9hLjUnrUMOILTG/HjKZILmUjNXikvwXCZzgFC/CPpbXLKL6t1U1/j?=
 =?us-ascii?Q?3lGp7Ji+JogXECQctiu5PmdXRxdCknP9MLqkmGX4VhTuUkjFfHqvp475+zNC?=
 =?us-ascii?Q?MoQDf18paqqB7SWSWqV0FQN5CXl1Jq7wV03hjRxTPY0VqzS/dpQgl1HudPBs?=
 =?us-ascii?Q?hhPZ6b8iOadRjRRLPoz/mWe86GLU4C468oDNZwjO8ms19Jxofk6gAD04B68C?=
 =?us-ascii?Q?WRGud6TKwMvowpQJugGcjqM74hWJVGMP9rEusjsgry2IhMIoMwdj9qR3QE70?=
 =?us-ascii?Q?K+gu/ME3W3XPCRJ7zy6+wrxdbfRuh1KnEZ4QCX3KKoUDzCj+y7+6pkJrIEXg?=
 =?us-ascii?Q?lqmWqe5w8j1CA6c3qDx+6V/i02kFtCU9+mEcI7y2KiiPnBoDVxEtvNWiU24C?=
 =?us-ascii?Q?IBVSKcvMopqNmfqRpWKMOKI+Amx8k51u+aXDUhzv++1tRR/HL3YqCmf7K0Ea?=
 =?us-ascii?Q?NXvAqvkW8/fuk8d8Dha6mgem1/Ub8N1+XkUgLGuU1zJhjJaVbjxGfEO0Qoso?=
 =?us-ascii?Q?pQwW0GEXtutpaFW9ALpc6Bl/qH1qYvnSsRoXZ4wWkJ38AD+ADlQBP6WjoVmu?=
 =?us-ascii?Q?uKERuDso2EUj/NEaQ5DCBQsMAR9+xHYjq+LVikO37V5gLiAmpmk04JNDl8B1?=
 =?us-ascii?Q?XfZhHwFZJG+nP1/cwqCwMXMrcoAZ4sgUL5nuL2wwiafYR5KUrnaNWYolCMRq?=
 =?us-ascii?Q?N9WTqNRW9ZFzC+fTBcNeukApMlpqSiC3WC4gNy3y/mNh9CFADMCICZlFscRE?=
 =?us-ascii?Q?Bza4Upi+HzO7O6UL6QvkH/amH5mZh416jWo18vcPtNPM70d7qh2DpHFM/Sce?=
 =?us-ascii?Q?IP8luBuGKmU3vKIhEfmhC6a4r3zCxxLPmYoXHBOhjj0ondasAA48HlugevpY?=
 =?us-ascii?Q?tAGTQzBp810HuVQbzJ8btIfVvGSMJFAakO1lHEwKP5N2ScvYdVGAXmtpmkPx?=
 =?us-ascii?Q?GV8xPwVyeaR8jAmB1XQV1X0/e0qK2yubNkCwD6AX+aPuGyPBfiriKskNUniJ?=
 =?us-ascii?Q?uYmapiSx7KM43mNUHETHOaUrXfb3ZDGhpwL70vC9vaPrdp3Ro3Lz0wqsOxVk?=
 =?us-ascii?Q?iVbv/Dm54oo0h9xXJ1c8CN1KMjQ6SjCrRmHbYDG3N2COF4QE+zjzi/x12AvG?=
 =?us-ascii?Q?7Rp3fAQ/NLNftjlEV5XuRU3R3K47PdUDdQOTOd/6GaHtJSA17cKPwPZt6l6q?=
 =?us-ascii?Q?1NkTM4UZUH+BgP6boOpsYZLifxP3eFHRl5yVnTrc1mqHnltB4g0lSWQ/hBw0?=
 =?us-ascii?Q?IcgaCWPXYcWbyAsRBwSLLMrLrfkuLo511gZ/7tZBb0QEaGWJt2cx34Cnf+dE?=
 =?us-ascii?Q?0JCmcVy0T6lSjG6tRSdSHp+I7eO90R4opPb4vFmFDvtwMfYP5/O24T7NRbUW?=
 =?us-ascii?Q?fPIjrG/KAQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd2aef9-83ec-4fd7-9443-08dee0e1d3e1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:22:46.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBLDpUeFgXcNYB1/iSAi6mCVNmZoST+e7ae+lpL6MMOOPb+zMjxW52NK9buyXicHsUaqPt2jCk3uGqJAdy8sqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB9248

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/fpga/zynq-fpga.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 9d1d599ef718..2f8ba32e4002 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -598,7 +598,6 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	err = devm_request_irq(dev, priv->irq, zynq_fpga_isr, 0, dev_name(dev),
 			       priv);
 	if (err) {
-		dev_err(dev, "unable to request IRQ\n");
 		clk_disable_unprepare(priv->clk);
 		return err;
 	}
-- 
2.34.1

