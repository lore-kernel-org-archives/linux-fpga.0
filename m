Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F258A5632B3;
	Tue, 22 Sep 2026 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092990; cv=fail; b=I49UDw7VoQyzreyxnDi3dBwk+wHuRMP8B/wbQbEMMiiXvkemruhXJIj4NenzN1kShxTd0ms/Qhj9+o7GO2HH2i/lnlz3aTUiACGrCBjp6Wb4RXKv+Sa8KFypOgDTYjFP7MHqGGzJRwiQuG3fqmV7f0s8IddWbcdEk359PwA4mxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092990; c=relaxed/simple;
	bh=VKshTG1QizCNB+g5Y5M/8lSNVfCIXzqj59UFipvyFtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yv+dkg1UOJHaGzn0uhHp36JF2k/A8fkbQMB0hY1su/9YsnHqePJFYfVHwaeC4lWNFgumZgmlRx94avxT4OsedQ3rGlKlIePa3Q2Aop3bIMJF3Axs1odwsmVgnWBkTD3vQRWqYsP5eMyhQa2beI94do1ApWDhZ2QRP6uvHEtr0Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=I8iqxCAl; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="I8iqxCAl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XN2yxRk/A7AsJFJkEIQ8gpLcVeKM+pZDIfUFDVkjTh5oZ2QOaLAYe80UaXG9DmicKYpu5qG4rkQgspL3p6V586SrhhFRNaP2ts03gTitpTbTiandHNhyFrv6M2jKUkEaP9JjVU83MWA/2wx8wI41XywzWbZDSRf6siSA7l8t3Kx+5BfkqJfO/C+RJ4Rj60jcWOoSLBkJajjLOQa/DMhzwBCgQMbMZ5LlsaZE6eFjWGrHJaJI+A9hVJBVtzZzzeU8TndJCB3mJjVadH08J4fnWCVFUMFjkHRTWIxofbDG/ouZJNFip2cRb03GdMU/+hQW9dszH0khjxv8yZnmKipbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OroRCiBJZWWNIk8i9U9diVwGwEX5v4YJU43kIsI46Vc=;
 b=BzsYGoKO0OkTvU90GArODzK9scbAndfgobCNlboy8RrCQCfyyx58zoIUS54MmS9lIdriaVOM4zkkyIgZiDjPYtZfvlsnEtdDLiw0oD0qi4eFuuyMeaTlP0GWylqVPHUQZrgqnc8carwbB0s+USLG/uMsZrUFr8z/lyHVyWRG9Kk9+dgF6l63MpxdtUE8VLOeMJAyyBuSkGbIq/cqRBTNorx0KmNKAWZan5jlAhsDQRQdmBYkr94ubXywulfgY7rjRAEKcmVXQIF2k1hbUanxrQZm+z35lLX3sWUYB2UImtMsSLgV31dZQyHM/fcJzc1qZ8TjCK+7GTlKVEc9Ke/wbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OroRCiBJZWWNIk8i9U9diVwGwEX5v4YJU43kIsI46Vc=;
 b=I8iqxCAlRZJS5coThcmfafLl/j6SFbW3a2c7rWWgsXUCBJ+nl2T7wz/+EDX3jL7k7sTZx16kJ3SqssT8ObDSMiwfyK9vXGQfI9BiEoWPnEUWYqKEJKj2ZQ5NdVKcOlFRxl1/5ywjQ/qpSCvVs+vrdCmPktglaOFjXmjHRM28OsiWsiX/lTJENa6QVL2N8u7obsttgPyErB9zHiaH871V6wWNmK8x19/+InrNvL56iAYM+rMxXma70Vg2qnpyEGxSgIKGL1SAR1LdNtO17vKoL3yEzhDxh7ac+pxXeUOfY19ENDDtVQnvdLkG2Vb6H2eOZpCUmm1iSR0UsWU9s4IJUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12)
 by SJ0PR03MB5918.namprd03.prod.outlook.com (2603:10b6:a03:2da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 16:02:56 +0000
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80]) by SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80%3]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 16:02:56 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Subject: [PATCH 1/3] fpga: stratix10-soc: always wait for svc buffer completion
Date: Wed, 23 Sep 2026 00:02:41 +0800
Message-ID: <d241323c396d772d818fea1b9470e5380b4ebaa5.1790090287.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1790090287.git.adrian.ho.yin.ng@altera.com>
References: <cover.1790090287.git.adrian.ho.yin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To SJ0PR03MB6581.namprd03.prod.outlook.com
 (2603:10b6:a03:393::12)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6581:EE_|SJ0PR03MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fc1e1b-5897-4555-373a-08df18c2f77b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|55112099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	4+qGWVmXkhfiZjTN0gVBAzWYAsofrWZ4Oez5Aip7UpqqTy3lt5hFgpnwWFYVrGoxnS4W3RWqFTPIKr7OzSgDsafEFMg5rpEBo0xpGWkn0ecICqCmgYw2imow7pn+WvDdLgzzlXWNcteUxHKO918bYR7UPMAJH7Ts3f8MKaO9mbfdBhK7MYc+0rqGCfAvIdASskX6kTbNeHjJtl600KcNg/65fSKFGEC8Cg2ca318MSRj1ue99xIQnr0d91w3zyb3C85uE2gjeXS6cXb7SxXwWNKUH72OHNtAzZoGLSHOlbxaTQmd7aMAWhIytZ2cOCts3U6xAkgcsAM4TrgH6T7FNfr9rvs6a4QUMGSki33lazOgqbREhpBledjkswdpCAUoAX5ZkvoPwpyRPF7x+3NOiwBylOIwpEldU3hX60XtJi0KPmFplE1jlbtaaGfy5rfP/k7u4rtx+PajK46MMMkrKz6nt/PQC0I3q0IAMRNArN8OuHfCgq9NXtFFvgyGXYJCjyg46OYdZcCLqYXE/xQkxw7Zd+Ul7DzW/bpPEwx7d5tDnIvpJFj72mg9/Ep7oiysfW4rxqYCiOrdOWtAEr/7g45c9IKghbwwj5tIU9VxOBeON/D/K7B9eSrgWzI82TdfOK3IiialehUUbE7kWLoLKJiu52a/iPIAB5G6ls/NLIs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6581.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(55112099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6r+nVZVl6ttxtOodZZv9/40e29HAvj7xHCw9PDzIEaLJsTV3d9ZGgebNRqx2?=
 =?us-ascii?Q?v8Axvj7eXaYUAIemtCtHYC1CigxondXOT6nBL54+p6hsxL0Jl1j07T175P19?=
 =?us-ascii?Q?yb2yNCiCLGTLc7WnDjdeh/irD5f2oFfT/4WG1IM5L0CnWgWwMxUaJXSLF5Pn?=
 =?us-ascii?Q?wFvs/3RZz86jXtZIdjs5xJr/9cAToj3BxuXmgw/nEXWaCUVXH2A4ivJdedQi?=
 =?us-ascii?Q?3rKcFnt9Rvbsheyy0keObltzd/jxX8NPAiFIkJARN01FDdJAm/irfNPTFMCL?=
 =?us-ascii?Q?PCMq9PyvxNEFRvYc20sSTD67fwCK2C5pyDFH9yuLurY/SCqxjL8YKxXhtw6i?=
 =?us-ascii?Q?7D11lXz94qiyHhA/gKF72Ldvquw+ZYiRhGxBfxfmCF7HM2HxUjHNM+2bA3ls?=
 =?us-ascii?Q?32p1mD7J1HZfjEK1PL+/tbMqXwgGV3xrvvrnuEBwkX8P+v6taAHMYB/FlI/c?=
 =?us-ascii?Q?wdCQrf3Cu2i991he9093TJegjTQz1q40l6z2kM3izMHZEtRL9QJlVSD9665U?=
 =?us-ascii?Q?6vZzkC0NetWwxXFOYW29t2qZv/g1eO9evBkIv8uIl64EuivnwWkDSSTun7Va?=
 =?us-ascii?Q?HWMbI11lGBID4R0h9mzyMcbSJBBQ1ga41f34rzgLJA9XmpYVBuaZM/6AmJ4y?=
 =?us-ascii?Q?gX33YqXFNyZRfXfUdNrmm4pg6Ll5zHLI1ipoYd9tqdBQ9Z7AJA9CUlWFuA2f?=
 =?us-ascii?Q?mACcNbW0uRurhu5T3Up8mBZBLhXtv50o3PfYHR/mhIc3KA/4l4yXbVONxHoO?=
 =?us-ascii?Q?nW50Lrg9XnBwSMr1oF+OuzYnFOJNwMlxk/7dD6sArxHLIST3bZ5RWGNxtOhn?=
 =?us-ascii?Q?pyiNIBfdkUdgMS06BOz9Fq97hFOjS8SvalSczX+4vSUwmqLwgXMcfvBKdVmr?=
 =?us-ascii?Q?tVsurk2tdwuJM1DBjdkimM/tOjohmfnSShMAqycAPI98W6aoA9WJGoVyi2ED?=
 =?us-ascii?Q?tooVTVPrLccLGEJBRD2lb/dWEcYjoDxWz2DPwMzttoTiYrIdiOkhXCCDcz0d?=
 =?us-ascii?Q?Wm6KwAEF8xyoNiiilp3FXNHEj951TzwLKeDynZIjwGxR+QVZQaW1pUABP2VI?=
 =?us-ascii?Q?+itBk3lizQ8AE/qFKqpuy6l8T1VmGTGT5VxTdOCaCYeEj5DaF6zmkxHqtMFc?=
 =?us-ascii?Q?ldeYpHrRIxGt9kQ0X2EVM+H+hP6giAMy4gRueF9qPEAu46KjCXMg7Fr8140U?=
 =?us-ascii?Q?GI/+ao4AZlzBt8T+g9ooqnANNM0pF0bpAmoKnySokXIQ9r4L0GOXTpwGlhQp?=
 =?us-ascii?Q?K0fiNnSZBJldFGEUvPEeVgI7V6RRdsTdqU5fKbuq4dFg3GDyIgAcEXlZmuE1?=
 =?us-ascii?Q?BJP7x9AofQSblBoA5WAhBKHLYaeHPjL9YGW7UrNYoenqRnjusoyZrzNUV14O?=
 =?us-ascii?Q?7kqFVp9F3HEwGyoJ2UA8h1SGZVuYqBM56GxbshDEVSUfw5sw0SoSmyHzes87?=
 =?us-ascii?Q?vBkisKXo6DjZjyUhBhg5DV4Dlnwk2omFS0Uz6r6eKcTyuStddmdG83lq2SJp?=
 =?us-ascii?Q?oSU4jCfJ+QBkcK1WMPU4mt8eDq9GOv4zxWhvRfMK6zCkEdagHrMvd1jbuvq6?=
 =?us-ascii?Q?SnsYKtT+20Mmc9WvX3DhCBKpHUqWG7qW9jrfRjfDouwWtCS73UKEM4d005UQ?=
 =?us-ascii?Q?3S+VzXi9TP2GCSo8IGZmoSh4stXTh35dYD08u38lSK2/ujJ6I1qravTbhoJc?=
 =?us-ascii?Q?hQFUqrkOuxLDDZeK/flrFw9DqrjEwLLSMYobAw55fUf/voeQQcdd4soBtrz3?=
 =?us-ascii?Q?BqP+hbrLozgtKjfEPQgD0vpYEwJvesk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fc1e1b-5897-4555-373a-08df18c2f77b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6581.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:02:56.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/Yydtb3/8RBYisgwdy46iULr6nKUr5MBrF2fjfBPc44D/ONbtFXtRaJ42KZCXp2S0oZe7lBih8w6nUOc8E301Jg0bVyg5RfzdD0acFQhvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5918

Always call wait_for_completion_timeout() in s10_ops_write(). Skipping
the wait when priv->status is already set is unnecessary: if the
callback already ran, complete() raised the done counter and the wait
returns immediately.

Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 drivers/fpga/stratix10-soc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index b8ec2e6f615f..3ba0ffa1d9e0 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -310,14 +310,14 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 		}
 
 		/*
-		 * If callback hasn't already happened, wait for buffers to be
-		 * returned from service layer
+		 * Always wait for the completion rather than skipping it when
+		 * priv->status is already set. The callback may have fired
+		 * between the CLAIM/SUBMIT send and here; if so, complete()
+		 * has already incremented the done counter and
+		 * wait_for_completion_timeout() returns immediately.
 		 */
-		wait_status = 1; /* not timed out */
-		if (!priv->status)
-			wait_status = wait_for_completion_timeout(
-				&priv->status_return_completion,
-				S10_BUFFER_TIMEOUT);
+		wait_status = wait_for_completion_timeout(
+			&priv->status_return_completion, S10_BUFFER_TIMEOUT);
 
 		if (test_and_clear_bit(SVC_STATUS_BUFFER_DONE, &priv->status) ||
 		    test_and_clear_bit(SVC_STATUS_BUFFER_SUBMITTED,
-- 
2.49.GIT

