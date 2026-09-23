Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012068.outbound.protection.outlook.com [40.93.195.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4278B3BB678;
	Wed, 23 Sep 2026 05:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141561; cv=fail; b=pvZ7C9OmvbadKBq8ImHSR/npN/Mpm3MQ6U0gycLmbZ9M20/NSNEqsPfx+E1eKpc7HnAHk8R8RPE7vwUUOv56ccep8peoCADMi3jsTnuyY1n14RA6T+Ks/QKWEsff37oqIHbBmZ6SFCL73gMLWf6PRCMN0HkRMRIbJejzlX5cqgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141561; c=relaxed/simple;
	bh=582XCatafQg/1kNVwgs2rbzL0FZEaQVTO3Hnz29Duhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FRdMcdHqWhh1hgscxw4yPNa1lejd4j+Qblk8Jteh/jG30TlsAxnZm+7dOMyGv2nvdojpEv5lSsf15FdmuvUUtdf0bMeoV0GxWhGnVZimSKgzM0Tx/9NKYD1dX/4Zv5WoI7jtFp5dd9v8EXAs19kGWfXnTHGUnPbGTo/Bi4AXZFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=FQSdK0C5; arc=fail smtp.client-ip=40.93.195.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="FQSdK0C5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+RBHBa1XXUd5qvzBBkjEIix0+GZFs3AemMlydcuKSAEeC+SxZ25PhwYcxtdxwq/L2GjDqs+LqR3aDtNKmhAlTCY2T9bRBjDAlO2FyeUy0UyNus/y2Blatl8xrZ8TRWREhXmXFkrMMW8M/ZBgklQMndm6xATeDnbmhYBqI647K3LNCta0oif2zn2/da2o8akcohvqIOLWywt3os5kDl9rtLymZWcPDfEbv9ByD2L6BS7QAgBw0V9Exu4FkpscG4M+kFM27yufBTni+EBf6nLYnC0h59JHLincVIiSxC9BOe3xFMUdlO2FRkjviXVopMZZxHl/YyKEhSnhUaUjmwaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVCbW7bcZLsWxbR0HtyzARjUsdPWztVmXJnho+Dl0wM=;
 b=UQmfcjf7slj4K/Gl1lYwODfkHfL199y0EdLZOxCcrNhC1gUdT35X0Q3ksbR85alGwgtl4o4iWk1gHHtLmy5vEh16fsHhQq/zh4DRl9sYxsWz4mWSYbWaajaUOFt4vCZ9MjNkhDwyEMzC0zjgDqM8iEXBrhfgHQcB3N/rwF8lbi6qgWvM9lQoOX5kTo5d/NtJpfKxUHkZtb0Y+1qpfcQJENCv67GaP2wPk9V7SobFTdWsiAypvtnQgg9p1M0C2bnwkWLo8ck01Xn4/1ePLNXw+FSh/0WySWva0mgpJg+YO/2ZXNxN7orSz6OV5agT2utMXaIR3vgtiX47yDLfj+SBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVCbW7bcZLsWxbR0HtyzARjUsdPWztVmXJnho+Dl0wM=;
 b=FQSdK0C53+svB76iTSOEFVMO8DhZT99QUbSI8o7spBPJ44e+vGFauj7DNV3nbGRpw/XIYSw0jPu+7EAF4ZRQWPa2BTNVv3gVMSDAgdM+AaO4v3aj8PZYpco+Alr/i0hDLrqA0YoqO0tcVIUfG+EoqMgnrZuKmuX+0ourYRlWkOQUWUoU2umHplKpiSx+ZzWK/uOC2nTOogJdf2QjuhmIeNMypbMG7ai8uB9xnXaYaBHdUnlEMwQ3vENgIowvsj8ZJa/hDHJtxVzQ7SuJxZxnuJR8jXoLnhFxLROZTQpFzGSELO6q6LxSh+z8gir7Rae/aO79JuoEgE9EouFpRx5goA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM6PR03MB5324.namprd03.prod.outlook.com (2603:10b6:5:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 05:32:36 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 05:32:36 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] fpga: altera-cvp: Retry teardown and reset CVP state on failure
Date: Tue, 22 Sep 2026 22:32:33 -0700
Message-ID: <20260923053233.10890-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260923053233.10890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260923053233.10890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::10) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DM6PR03MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: d5847656-bdc4-49b3-d8ad-08df19341314
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lIWuIg8ANojPbEzSr6XCjK1JumMHQlQ87uP8Es6SoEmKDn4HVv0V0ecxU3wqZLhEphxD7jLztDL/CletbozXlwkfE95fv1RXbScT7otuTslCMNKfJd5WfpnzJmGeTgb8zPHSvQsNl/ZwcPA7GeqFeRitcGMTr0eHfQdJLi83npf9dtRbZAqcBD7AC534LzvWKJ08XcSv5WQ/Ze0PUubAkoYTc804XPDx+4ekzPQ3mbIkxKPgmRwcE/bPL+6TJIaUIQxqlYeI5j7LErH4ES55jaN/tYfRXSkee+AH5fa5Dqo3gnRkJL2F+Ul7bqUecv3qLXMQH30wf3j/mY8kwASEwSHBY2EEevFCXb1I2QUwa74srq98/XnV9bP/JZ1aEMrsIM+sNKZie47nK7YnKjJWtBunaImvkobuR/5DXqK9OLZx4iTDgAvhdMIbMc5iAVYUeCGvPxcTEASf3u8twP/O3w+NI1k8jZ33+de5+Yb+9hr/I24giC34Xrq0u/v3Uj63bSXA5zwH2SK0+Rck1T3Q4HmK4aLsFboli3wUKvFveQ60Uhs8bKsy153WS8gv02hnUigXnwn1AfyI3DB2H44XxUP7+IpL2dOTHYh6ELYJu43E8GLUKOv0XsAj14uJptogSAaOXfdWs4j98IjP5SEcmBZCKrGbs5CZb8ZtliZ5WU4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oG5pAD2a5dX0eAM39zjZE7xcuZD3pac0S/Lf6xmM1mWsNnpL53zE3FE1bkwZ?=
 =?us-ascii?Q?b9ltR0v4Oeb7HZoh2yTwhsda2RwjSh999BNe4b62bcP3WvWj6nSVQjb91toh?=
 =?us-ascii?Q?OgovfTyES3ioHtESrctiVU0eICSHj1dUDeetu79oT3P95PQzrcLDFF8eeapc?=
 =?us-ascii?Q?rOYgIhaMZIUffs7Iq/lax9Z/KpTIhbeCkJw3Mim6vAQS31pPHC9x7//ZTAN8?=
 =?us-ascii?Q?nGFE2ylM6hKPUwTuHbsFPCBTuHvlvECd6ohDhJsYBJnc9zUYkf21JmrmjUv2?=
 =?us-ascii?Q?KS1C1rgP24I9m71v9w5jpxBc9Lre3jE9xo2S0n2YoDIO0w1dWT8Fhns6CEKK?=
 =?us-ascii?Q?hR71bxulhcN/OvMDf8ICqayFR/ZGjGEBFE9ZRW8h+Ez6XonzKApaL3uzxCt4?=
 =?us-ascii?Q?SeV/2shllKITiw8OT8AAfQ+gqXR8vlmzBuEHxhgWN+p4KtUAk6ki5Tj2CKtk?=
 =?us-ascii?Q?QOnh68Mpvp4FFL41U9Y3MIldw++aBoddUHp+onrUmyIlis8rEoU+S86+ILll?=
 =?us-ascii?Q?7P7D5E7dULSeGcJtsed1z9zRadILe6wtLYmCHqoV5iw93kCLNAkwm7cVNzPk?=
 =?us-ascii?Q?3qw2pMZA5+To4E6J/8gD8DFBA49b8zJmFJhvPGd6Lajo8Fq8x2LO6un+K2QA?=
 =?us-ascii?Q?t4T/0jkZyL+BbzGKmxN14LeBbaHXZb6I9MEcPtMntVWv9Yx9pqFhEhvkPOOm?=
 =?us-ascii?Q?JbZTHCLYbiL7f12atA8IvdEFXZPf/wvYvK3j59CKFW7kTYN5CfvUIa6fwCCx?=
 =?us-ascii?Q?ZSQK1zT8IYr6nuJETZR/Hs0GIE12ZD2OAnyLYax4Kvk3zstzG6VzTx9aDrKc?=
 =?us-ascii?Q?9bvygC3p8q5EQbC83rWvjem2FihjBM0K6kjvrKNy5/qo5C23OhS33V31Fp4R?=
 =?us-ascii?Q?aWhR0PW+b6qsTZtTAgQOUNtO+aDqwGCEHOwaNLCJT7b44mtmR1lCxeR4zwrR?=
 =?us-ascii?Q?xzbeQNK+eSSswDohcwa3cIMZigHXrWCzWUxuRllRfphBdzaz1f5t/VVDfzL8?=
 =?us-ascii?Q?HTnNYRF0qxqtGjaVauxAKnJGptB0t0C7oKsLh7+GlXxv5VA5ImkRxbaQh+dA?=
 =?us-ascii?Q?dFn0EuWuhIhe2DSgPMH0I2pINVryBhd7nolvOv+LSR24m8zQgYu6vMZrylg5?=
 =?us-ascii?Q?DHyKALEs56RmYe8oTWJl/LKci9E8PkGFnx+W+HGfwdWXDvycHjr01ZtYQWEn?=
 =?us-ascii?Q?S2g4fWFfUcUsZKiaJFF1dQwN/JZGtQkOGCqd2cgsM7ig+eOU3Ob0DdvUVS39?=
 =?us-ascii?Q?1ulmUuzQIPpqO0Qg/raplQ+5X21zsqa4qnlCVXuWgG98hr5IqgPPv6gBvDHL?=
 =?us-ascii?Q?sXBBWH35AXvpaT/iFPVUpx8u8Ef+CcxL0Ypbuti7+DD4DUBSWeLtkXz3m6Q/?=
 =?us-ascii?Q?6IoSET+esyMVlRwpaLc9JSgW+Rnpr/GgmK4SzmeQLcf4BIIZmSPRspP9U+tB?=
 =?us-ascii?Q?XH5451eCThXpXzYy4tihMhDK9MlYneSYe3+gJ1GZV+RPy0o6v2Zb6SzXcaDs?=
 =?us-ascii?Q?Zo4BjP474xYxcW7tILzPqRANNxA/ihZLFiKiR3zZZQFvQKXF5JS3tPBogzkZ?=
 =?us-ascii?Q?7h6n0+5KxAPYSRHHwyLHekBsjG5W8otKbvuv8vcVFRs+8zdJM3UwofTqUAZZ?=
 =?us-ascii?Q?VC6j7XzFefCU4rBtWxMcCHXcSezpaG1l2Zci0Dw3uw57Yl4v1MYKZJQwuA4i?=
 =?us-ascii?Q?7K/SRy2iP+NwelH8SN7e6l6GbXK8JhP+A1RtrxCvYLu06DtRlVgTyhZ9NHCA?=
 =?us-ascii?Q?hCLO47S3hFSTNhlrED3hRyoActLMq1H6lNRrRntFXiy/rXt/3uxWtgkDDtS6?=
X-MS-Exchange-AntiSpam-MessageData-1: +WUiPJXdar14yg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5847656-bdc4-49b3-d8ad-08df19341314
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 05:32:36.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZGUEWg8KV0PErjdSSidLlrLkI9LzsMu36vtuLOiGltUwkgGBxvAK0DqogzbkdserDZ5Fmja5uHX7rkuDHLSVvwCwFOBWSlV3tQRjrd7J5gkZ3n13h3FuAT+qkaKXg6jCyJaZaHXZx+U61Kkzfg6Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5324

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The driver polls CFG_RDY for 0 as notification that the endpoint has
finished teardown and a new session can start safely. After a bad
bitstream that poll can time out: CFG_RDY may stay stuck when
HIP_CLK_SEL=0 if the device has already left usermode before the poll.

Retrying teardown alone is not enough. Exit CvP mode and switch the HIP
clock that feeds CFG_RDY so CVP_STATUS becomes responsive again, then
try the teardown once more.

Introduce altera_cvp_recovery() to wrap this cleanup and single retry.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/fpga/altera-cvp.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 559191180825..549e0ce1545f 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -316,7 +316,29 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
 	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
 				     conf->priv->poll_time_us);
 	if (ret)
-		dev_err(&mgr->dev, "CFG_RDY == 0 timeout\n");
+		dev_warn(&mgr->dev, "CFG_RDY == 0 timeout\n");
+
+	return ret;
+}
+
+static int altera_cvp_recovery(struct fpga_manager *mgr,
+			       struct fpga_image_info *info)
+{
+	struct altera_cvp_conf *conf = mgr->priv;
+	int ret;
+
+	ret = altera_cvp_teardown(mgr, info);
+	if (ret) {
+		/*
+		 * CVP_STATUS may get stuck if the device left user mode
+		 * before the poll. Exit CvP mode to switch back the clock
+		 * feeding CVP_STATUS, then try the teardown again.
+		 */
+		altera_cvp_disable_cvp_mode(conf);
+		ret = altera_cvp_teardown(mgr, info);
+		if (ret)
+			dev_err(&mgr->dev, "Tear-down failed\n");
+	}
 
 	return ret;
 }
@@ -353,7 +375,7 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 
 	if (val & VSE_CVP_STATUS_CFG_RDY) {
 		dev_warn(&mgr->dev, "CvP already started, tear down first\n");
-		ret = altera_cvp_teardown(mgr, info);
+		ret = altera_cvp_recovery(mgr, info);
 		if (ret)
 			return ret;
 	}
@@ -494,7 +516,7 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 	u32 mask, val;
 	int ret;
 
-	ret = altera_cvp_teardown(mgr, info);
+	ret = altera_cvp_recovery(mgr, info);
 	if (ret)
 		return ret;
 
-- 
2.43.7

