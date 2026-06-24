Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746FE309EEC;
	Wed, 24 Jun 2026 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272348; cv=fail; b=puygMSUZd6lOIJLUuvccIOJ0tLmRCdczwZlcENIoHEIXK4gR1fXKEBJz0tL5T/emAj9Z4nqJNB2xIi3PDIjamiZD5++vuhyj5bwp6A6u4K3MTDWh3ZXm8x7sH0vxt7Nh3dSvDEVobooC5fNX4z8vi0tYXYz0pCoieBxe4MDChds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272348; c=relaxed/simple;
	bh=hYATmBMmYFGR9BA0oB6XEwFpd5KE0d/2qAxIQ7RYy4w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bWd0DCoIXzOmvQtD+JFHJFaCAOBcCLhwirnBLXeAPTRudWQf7QThn9cYhJcOdEq3l/boHrfFY/Bg7na69WKG/Hl5c4fu//fPJiPKT9k/60kZdn3ikXETpAomf1tI6brESZ+yvlXcAWFoW+5r/9G2XTY2bLIXzYWNojJO7+j3M/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=arWCwpjO; arc=fail smtp.client-ip=52.101.57.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="arWCwpjO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSRazT85w6JVeb1CMAW9N4C098XijY2gDvdlKJtq6qD5oVy+Jls/QgWtekFJufkrLu0r4NsD9Jm7+TjvcKLDTqQsbrgVAsx73b7uXlo0umRbXBf44047g83qUEfp/+vNAUn/Rl/xhmaEzy/56WMWR68s6ujv1RKVNkfvbzpbDcd25XNOT76VcwckcA4YMpxSBXKHSSGw0+T9Cb6Xck6sNH7eVMbJGxIVife8lv7OsU946oenPrzv3xfFD5eKWnaj2RAklDmrVwXsAiQHksEaZHncwQunVX8JCsvpl5fdeGag7BzbBLJbN6YtPMkHl93cTRWM3oS1MrE48X5fQRvcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOFL0PSiRM6ToDp4k9LxnKgok+ZNL5Q0wbuPrEowOp8=;
 b=Lroum3Y+tSD1A9uHFPlILcxv/G80ZoMSXBUaRPpI3m+hsEJOkIlt/1S4k1wR5Ew93GNNKcb/0jarzkPtUtQCcGNZLEyzUg4fob6+4CMo7etwLsih7P4ARunfmGY9h2PNUsXOuRYkXZasfbY5hK/7KeE8KpN+Lq78wS+6UrY1A3ivHLmSjUzZy+NOJ4t3z6GIGbjU42EIa2Y5Sy0AnWO109C4UGfyKNfnHeLPX2X+GHWHZaZcwymYTw5pnl8cGJgY8opSyUIIwQa7vSOumFQFpQQjtifu8hxADDLJzVNbWZVVAP3kLok3rYXEL74CexJlWzWDivgtwZioTAq9zj9GNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOFL0PSiRM6ToDp4k9LxnKgok+ZNL5Q0wbuPrEowOp8=;
 b=arWCwpjO8mryYO50TLyyHMWh8nlvtDT2E1qozwmwKjYknwtc/SgfebyyYXQS0rUM+odXVByk+lxJX8JzTnDl7M3oO3rXaAIAYUegT4Lh/9smCZgaOuK28UzPlv3ogXBSJZa4RxICvpnumQYQpBXDA6L7zK3WYW16CTfVG+TrFo+9Fzhtmh5LrKNVYT+32WvUMJGN39rDEUqkWdoHKdy6jpra3anAudcYMyYhPhIBZXpy2Y4oZKkW9FdRgw3jMn1gUlYiUD8HTXULd3axzU8SwOMiEJocVBd1MDHTujgzsIvW4dePkOanSlRjmrCtq3ty07gprFLN5prdURB5Y4Yx2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SA1PR03MB7032.namprd03.prod.outlook.com (2603:10b6:806:331::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 03:39:04 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 03:39:04 +0000
From: tze.yee.ng@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Richard Gong <richard.gong@intel.com>,
	Alan Tull <atull@kernel.org>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tien.sung.ang@altera.com
Subject: [PATCH v2] fpga: stratix10-soc: Fix SVC mailbox handling during reconfiguration
Date: Tue, 23 Jun 2026 20:37:58 -0700
Message-ID: <b019a8ba0b0c30b0bc19719386a46d47df3141b3.1782271444.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SA1PR03MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: e6af72c2-8a09-4ec8-7f09-08ded1a22368
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|18002099003|55112099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ha8Wtn+m3wa/2VwMY3iENTOOc1lKvL1xLWcspNlri9SYewTTBlWL6J29nfPTwUZBPqBH24elOPZyP4K2pBhZ/z8knkM/MKjb1iQOz1KKdq9feohmbYam45IryntomV2jv002wzDeMnjPLMlsClNt5DylX0Ejo9W4Q4wUxjUSnIzDREOW65ybY08EUgQEQ/a/Ew1sZcR24RIwG8FE3XoMG6ZzZ058p3y26jqAuV2gMm9GoPQuSb70rfxbbdPW+SNTiMVKRfqju3QH6O5M7W/dDft3bWWdbM62wjPNxBjhDMMkKeahE7VN9xxyctRRgP1VkYEEg+H3lKjBzop8zm/9TQkkUDsablyTKyj6WgW9Q3B28c1Sqjot4T9NZqVT5qnHaGmm7OXXpexfS9rWylmgOF4bGxYJV67ir2W7g9HNIEHU6EA1GrZEM1aJ9kwWSWD2u3onQcM+dTSNJ0zEGzkLM2+H6Zi8c6gZAENxG8eBipNgtdZPZLdeZDj08aQ8Se45TjIuNpsUqJH/zChGJ5JBVufgA4G09mlX69OtoNYidnkVL09astH7O5X/w54O5wLmmnYp/J08on3M6iN1qHGpVI484fxd769fcCr9ghfQZs0lkd6DZzNrZK4QwghdWrc2R/2hSDTzCblkOxOtaUobkB31oCssrKvEGVnFBC8zJfI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(18002099003)(55112099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o6MJuL/tCzq9Wkm9N62RqxtuuDNCF5PTq3j8moDefK84kBgTp4VHM3MVvmWR?=
 =?us-ascii?Q?M2v3QCx2K8v73YCnt9GCINi4gU42JN/SGvpN4UhatN5Bf+pxRvLQPQHkGIhe?=
 =?us-ascii?Q?mA79Yhc7BvIvoZPrToWxBHUMeg0wQ3rPh84Cx4fdJii19E4Z2bQ4oRNZyhV6?=
 =?us-ascii?Q?5mCC1uAkvfuE0oGV1iZFt2leHxEaXLwMApqh9DFfpmUXI/RFfTooEOJ6Zv+Y?=
 =?us-ascii?Q?fvX8nE0G+nTQ1DAzkfhEr4MqtCwYLEC5LQKQ8/lfNP5jTZQ9boEyJSeUaHxk?=
 =?us-ascii?Q?2dE5y+T9HyB0W6FukN4urIUxDLIlOIR8vzw4SBrqdu6dXyekSh3/VSya+A74?=
 =?us-ascii?Q?A/lDMbcVSWuqqBEMYUsGY5LNQD/IpxzOZTv12qHvyTJxDa+6Ysm1LkZ/AMl5?=
 =?us-ascii?Q?E1QLhoLpUJAnnusSqVNFBrdck3msGTkZOagFubPRc6H4WeHKvYud37Om8aap?=
 =?us-ascii?Q?zMXphB8+46x3oU+VjUwhXsfy94oDbtCcF9R9Wvxcjpuig+SAn4EPml9us75e?=
 =?us-ascii?Q?M/y7yo6jpibBzlSKk4ZWTG+aQpLOtfHitfnqUB6ruNU1wpClAOcfb4hd32HN?=
 =?us-ascii?Q?ljKibIqhA2+VzwE4i1EuEdfInT4ED710wE0qIlkD3pYtQt0PATG4j0UQQHJ3?=
 =?us-ascii?Q?gCLwrlVch+GJp3qPfHQGno0L3pte07XgKiWCtSXTwjsBhmy/Kq1VmibwSJ7d?=
 =?us-ascii?Q?2SHN035DM7u4fVdivVr2skxsNR2C/9LZpLgWc6u8qYgtUI8QzGOQO9hsrgUo?=
 =?us-ascii?Q?XD5dILXgHvNR/CUWMWYwC1lRL8BMxKU48k7DJDcSSGb2BdTC1u1VNJZO/4ZF?=
 =?us-ascii?Q?0eTsCo0r5LJZ2b9xfHgT6y+urvs8whneD0/84WuVknOhViA7lLFFHiko9Vy/?=
 =?us-ascii?Q?7XRdBWkKh7IJGi8dA2a7zSdX4k4MWi9mA7YJgvGOK7QhCtC0rD7owLId9Y7g?=
 =?us-ascii?Q?7Bexvd56SQ7e76uVgUAUTuUjA1sjbfdmSJa+4K+LD0tMiFSeEDo+0nw+RU/4?=
 =?us-ascii?Q?R0+L6zDEl1llaMH/HxL6mzV3xiIwTuYYQFBApt+kNb+2Hgj4XS1bGTVxe8gt?=
 =?us-ascii?Q?YMH2NBxwuDP+d1j8l8o2TcV6vVTN7Rv2QqFG48lWc5wBcVDGfmychBeuhnlb?=
 =?us-ascii?Q?P5SttONGqWuc0j888NDk1PAjloBBsE+y48MFEMkdkbeemMSUdUgaNIF3NNbF?=
 =?us-ascii?Q?J1W/6ejeKi3xi/A7K5o6j1lDsItOdTDSzcjnhxc/qjt0jG5ZC8Of/wATuaZZ?=
 =?us-ascii?Q?MbftmeDV6MwAmVCooLcPHA7Ef0o69EB0Cb2UM4bmjLxK6cg9FTbQ4kQ1h5UJ?=
 =?us-ascii?Q?4HAuWQAkutiLaRfHJJAEP5w6sS/u9B6zKW7hxK5TBnUse8BTBV2wNlOxXghW?=
 =?us-ascii?Q?bJk4/sHAEza1znxQjXY+YupECwaKKpXE9Vd8GPurePQQXQ7wJjezZr0PzeT0?=
 =?us-ascii?Q?Co71qLa/jREo6DReH7ttvWZpG2IK8auWQqjScg7cqq8aYzBYKaVqmMl5fSLC?=
 =?us-ascii?Q?jDQmVEKyEGq0ZzhlyBFYIkLOFSkZ9B6X4mr1u5G8WENYwzeTO7Vykh6TJLvS?=
 =?us-ascii?Q?c/Crh14NeUZhKBd3ZA/GEbMSCdbUu4WDBPFNU8QIGZ90uXoryixyKfEwv0gm?=
 =?us-ascii?Q?0ZE5GbYQMw+Nkavkh42nizZLky8FIQcbUXvQ/3hl1cXlR0lrU+UPZz0dXWI7?=
 =?us-ascii?Q?6dUlrwHCvaJ6rVlfeGqTOouQDntDPsqKSQIAQw4LcyMQbxPSzPz2MrrVIaRS?=
 =?us-ascii?Q?GGJp+PU4yA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6af72c2-8a09-4ec8-7f09-08ded1a22368
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 03:39:04.3494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TUy7QZxrnvEilKVmDMBDAwIakpNyfGHDR7xE36470zC0c/vIHjmfd8QgdUK/PGk0w22p0CloHk3qCnOs92ruw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7032

From: Tien Sung Ang <tien.sung.ang@altera.com>

Fix incorrect stratix10_svc_done() usage during FPGA reconfiguration.

Do not call stratix10_svc_done() at the end of write_init() on success, so
the SVC session remains active through write() and write_complete(). Call
stratix10_svc_done() on failure in write_init() and write() so the shared
SVC mailbox is released when reconfiguration aborts, allowing coexistence
with other SVC clients such as soc64-hwmon.

Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
Cc: stable@vger.kernel.org # 5.1+

Signed-off-by: Tien Sung Ang <tien.sung.ang@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v2:
- Add Fixes: e7eef1d7633a per maintainer review; the incorrect
  stratix10_svc_done() call in write_init() dates to the initial driver.
- Add Cc: stable@vger.kernel.org # 5.1+ for stable backport consideration.
- No code changes from v1.
---
 drivers/fpga/stratix10-soc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 0a295ccf1644..0d07d303bad1 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -195,20 +195,20 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG,
 			       &ctype, sizeof(ctype));
 	if (ret < 0)
-		goto init_done;
+		goto init_error;
 
 	ret = wait_for_completion_timeout(
 		&priv->status_return_completion, S10_RECONFIG_TIMEOUT);
 	if (!ret) {
 		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
 		ret = -ETIMEDOUT;
-		goto init_done;
+		goto init_error;
 	}
 
 	ret = 0;
 	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
 		ret = -ETIMEDOUT;
-		goto init_done;
+		goto init_error;
 	}
 
 	/* Allocate buffers from the service layer's pool. */
@@ -216,16 +216,19 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
 		if (IS_ERR(kbuf)) {
 			s10_free_buffers(mgr);
-			ret = PTR_ERR(kbuf);
-			goto init_done;
+			ret = -ENOMEM;
+			goto init_error;
 		}
 
 		priv->svc_bufs[i].buf = kbuf;
 		priv->svc_bufs[i].lock = 0;
 	}
 
-init_done:
+	goto init_done;
+
+init_error:
 	stratix10_svc_done(priv->chan);
+init_done:
 	return ret;
 }
 
@@ -342,6 +345,9 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 	if (!s10_free_buffers(mgr))
 		dev_err(dev, "%s not all buffers were freed\n", __func__);
 
+	if (ret < 0)
+		stratix10_svc_done(priv->chan);
+
 	return ret;
 }
 
-- 
2.43.7

