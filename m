Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C33769FF;
	Tue, 30 Jun 2026 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802649; cv=fail; b=iyXGbrQeB37DqEyNHRdsqwHLpHs4UtL1V23wVXKX91/1U3LPgxgJmSegTIkL4qgOwl8bOkBqKNjqfxlRH9OHTiSHqbMYs1MklTYgDZ+FxYedGKUAyXZISBwBwpR0WI7GaH6VRVjlQ6lstGfMzKB9QS0lShKkdOpJp5I7o0UNYyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802649; c=relaxed/simple;
	bh=OggzUOgkJQ0J8ywXEk++kowDqxcYF9kDl/K3yiBGFUU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c5w9vopfR935DXgxy2XNlNtq3olG/gy8spkkp5Sn0865HQJDQit6Gt83a+GXlTpsLLFl2TdQFSfBJHY70Bi8d9/vsnlQ0rHk07Rb7xUeiWrnX9f8xPK74xLT4/P1WdXdxy/8hT509xQ+2x1HZ+A30tCgdu+X/w6YnwNLxmwoc8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=PwXk6/yc; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="PwXk6/yc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTqhVpSwlorgS/x2SykvFi3FKOxIAyoHUe50aszG/reLNDbOj3Uq3BjyHMbpuma2WPmXgEfRP7cRm5Tev8MIDCZoqGm+6uZh45oKSKJ3quU0JFD3vxeaIA/DTGWvGW/9/Ly789qRRcYUYpnEdFaLmhYism8/oQatpfM3B8Gb24bYyQV7CwV+RxGy8UdaRM69kb7pHzhb483bl+mBDICojP0N/g02uS/lQcbYJ8FRfFJ+zNVXy84/m9XNGjQ95qyeEmUHi2B4GQjqt3eMBuIGnSTCXKzSEEFdmeNgsAKVPUlDyw596a5y1SnSP3tFHVLInhR8hhxW6tPnWMRn+HTX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2Cn6qrkM1ySgy0nPDUJPVY9BQSJOvu4MEkUFWfZkfk=;
 b=eFQnMcLdkxESzSHh7gT8jmo5viZyXCvMu3gP9KaWW/auTnuVvfX8sI2pUQVxHw3FN0X19rnwviYhb34Y5CZbuRo4A7rqnW0yUwbGK+QulP7rRnvvw5qt070dr1R6CKfMAkW3Ob7vcvCn/WRn1YYCY3ge67cLFnZM77EeBShlKXk4KjUvOGNv2yIplrGOu4jPQWw+BhRKv394MXLb5bjLM4ueuJcVYHcM19dq0G85qlMuYmtrKYXzq0LUkySUVabZm48zBsuUU5cUduiimNcRU6Ilb9zcDhC18fJYDWSSVw2a7vcINtiRDSCDobqPRjrw5GMySDIZEoHRI2roBeMroQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2Cn6qrkM1ySgy0nPDUJPVY9BQSJOvu4MEkUFWfZkfk=;
 b=PwXk6/ycCwXccGmxfVdTkT1iRtYAAzyTmpvAXyf2s1DJBfCQ4JuKJ9y41KuB/gyV2o+U1bYEniDfv4HBnfHgtHCVX4+s3tRt2zizPP+/S3MtjssajEPgWeExPCjal79xEw10wgZ/65QPBqvjjigP6Ybv/LmLbz/5OE208QJ82QFbitO74yNofTOKgSxdxSeX/RQquBT+i/CEzFTgAJFhuRxSPFq5NgZLwtIGrv9i8DFkadgtecq/qzmM1SBcNz/FAcLPLzWGDQQZV4guXHN7BY9+PODs8sZi/YGVNqmbpgHf/B6TK96OU+IFSrdS+d2EDXCaexxk7RRwM5LHKOaAZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CO1PR03MB5937.namprd03.prod.outlook.com (2603:10b6:303:6e::18)
 by SJ0PR03MB5853.namprd03.prod.outlook.com (2603:10b6:a03:2d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Tue, 30 Jun
 2026 06:57:23 +0000
Received: from CO1PR03MB5937.namprd03.prod.outlook.com
 ([fe80::f970:684e:8c80:91c3]) by CO1PR03MB5937.namprd03.prod.outlook.com
 ([fe80::f970:684e:8c80:91c3%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:57:23 +0000
From: tze.yee.ng@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Richard Gong <richard.gong@intel.com>,
	Alan Tull <atull@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] fpga: stratix10-soc: Fix SVC mailbox handling during reconfiguration
Date: Mon, 29 Jun 2026 23:57:19 -0700
Message-ID: <8768ce3260489c9febdfce08e27d03f5f5ed9c33.1782801986.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::16) To CO1PR03MB5937.namprd03.prod.outlook.com
 (2603:10b6:303:6e::18)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR03MB5937:EE_|SJ0PR03MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: cfeaf0e1-d16e-4f80-5b53-08ded674d5e0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|6133799003|18002099003|56012099006|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info:
	WEW3mUWL2SFFdMyTi9OEV1XlrjEi6llXBOIjii53yCKVFzZx4VAFPMaluyBTYWKxszx0+Di5wzqJ2sf4oReVRYhNQIMC9fVYWZW956xwIU65Fcjv9xfZvbH532j+vvCQd7jTXV9unUOk+EqmStRJsB8b4Ue8YXLj5p3/WVpKbCC1vnZa++pvC6904CO4O05j9RFT7WMBzzLfBkouhARZUiuC5PFhYiTLkS/UT903v5+7kHSHFbsoeCrXCIzHPsbp40c+Uj9qwpJme/n/lUqbDgUhbl+k1uBiFcJF7AB3ZeR5rBku17pX2nemw+tvhB8bgpQwE+02FStkaEZP3PrDBQNTZhjAff+QGG7k346SDbL0i2x85DQUm9lW67e3Z7q2Rn10Nsd84Dxoc+yzgGFF28fNzZjM7Qyk5Rn3xh7SInfvfdInpfGkZKL1HWBUoxUdgQ2dLCp8Me5dZwUGKO+iwdcdqNSCpEdGEmbKV2EVESupMzodQeME5PbuwbMApJo2Kn+MuB4A+CGVDNdYGekiNRaPACgW07lYAEOSM8797B1pNiWPLNhd/xTz5bIhG5da771f3lwKfzyEmUzDGbBa25v4tFG3GFTvbxihtNsws7vnHdrY+wJubVAHQB5dVIMhAkXd+NvIJ/l6Sg5IU+nE0EsuJyD63hgpu+OCa+Y8A2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR03MB5937.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(18002099003)(56012099006)(11063799006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CVhkzq3f3o3IdkTRaVmTfRKUlo8sqX6zbfkPo2/DWcfiWsSdEsPjzR02QAG6?=
 =?us-ascii?Q?DEJMdK3D+P/zW/LzFxM0Y3fSP7o2XcCNr68u2ILx8X0/G4M6VgmIgF6wbav/?=
 =?us-ascii?Q?a0+uFrEI1deSh3ks443j06gVqCVVM61TOEzYx/ZQVIA1T3pljdMNh19gMYzB?=
 =?us-ascii?Q?O3C3+IrskxjcO87aZPEVzlDLDKDGii2ZW4ou2v492VFA2G1LjIYRW48bhTnZ?=
 =?us-ascii?Q?ZsxUiXJIEDK/x/l1+Yd9Ql7lY1YulXHx3yu715vqYy2OmCzdW/uttr8UtEKP?=
 =?us-ascii?Q?sEBRaoUueHLm2YOGFRio3z6srU602bP5DBIEyLzCgdllkeqdshgyzO9knYkf?=
 =?us-ascii?Q?ANeRO2CMU/E11x1w0A1MMthTLvTQMw43hu9CSrnMKFamHqCr0RIzGvnNlADA?=
 =?us-ascii?Q?7UwigLIeyrlByU1HABGCnT8RWbjNrTGg804dhtrIGQSMVA3jvXzxdOvbAeXo?=
 =?us-ascii?Q?AtofDvUN6Z9ZALyKxmN0qF+6k2xpszjkoJL3VGqTdXl7754f5pr+LTU9KMtD?=
 =?us-ascii?Q?A1EDqNnTuZTW5dObZBo0crfUGiZ5M1bjZvV0CYGXee8EoSqUg8tc4dvpppBo?=
 =?us-ascii?Q?z5zT/avUlD97tFJSO+iZBUAOluCJv4hwFdXmIO/YFnKK1l9SCR0Xw4um1BwU?=
 =?us-ascii?Q?eMJRqRiXtBR9PZVn54k/F3VTdBnIY5DcQ0sY9bC/jGw50stWT80ckgBa8xHp?=
 =?us-ascii?Q?p9MgDW4YrCBCRt0WL3y/JrLDcXbiEf8NQ+WkdaVPT82AZkdWFpqN4NtPXJwL?=
 =?us-ascii?Q?5Sk2LmfzJMLymXmgs/c8ufzsB6rTradn+Crp+6jvVU5KQCiTjOwf9iVf+x8H?=
 =?us-ascii?Q?ziQQLCNDzPhcqMl04UAKgGrtId0Z0z3xLrgUOyIotPIeI/CjlkzojPN2a/Im?=
 =?us-ascii?Q?KNRX2+Rsb/wZgOJzY86vn6aJwvwhZpP1FyKJgte1cUE9udryNiGbAm18w1oQ?=
 =?us-ascii?Q?ezo9ScVeduxDVXllE7KBAKV5P1U9kQuC3zsyhizAPmc2ZpPswQmlEGM7mVox?=
 =?us-ascii?Q?gK8vONa6hHzZkfLzZhC6c+zcq/enkpSM95ZNFsICboVNauyyfNdIZDBLsfUw?=
 =?us-ascii?Q?Cny13k2phpV/P1P3EZuwrQ6x2xcCcUDqnPaO5v8iEUMMLyrjVRjTTRbS+bgF?=
 =?us-ascii?Q?yxHOzLrjpaEUOzl6zGn4t6pCOA9dq8wrfgoPf1D5dVAWuu6OXwxQVW1PHhsr?=
 =?us-ascii?Q?hWIQ6T4FA+KOFkMAT16sb4LVKtX5kwI0lbv6LMHZu7Jx0iIMf3otydCflifK?=
 =?us-ascii?Q?/wROYAAKwVJ8rBEIRE24idWLl0/xMtynERHMIHaeviHc8WntPEh1csZceIaA?=
 =?us-ascii?Q?TokxoDKq/3mRKXqi5JiSPlC/mWAbD4KLxJCuZPyVfxg+Ei7RauQY+K5nxquX?=
 =?us-ascii?Q?bDxIixdALy7sNKH5odn5VRWAPC8utMHyUHkksfn2rHwrR8h61l1f0i4HdRAI?=
 =?us-ascii?Q?tYceAgA230xDd7QXTX3SDyfFbp3hk7qc5oAR0eHov/AhQHSUEPmoGs+ms4Wu?=
 =?us-ascii?Q?0d5r9LIGmzTx/4kCOhBz/XwXmKDLOPyIoHubB/5wcnY/GbBSKu5A4FeqHk7g?=
 =?us-ascii?Q?jJ2R2wHhDGte3kk2hYdh/GVTgQiTc8YTFRX2/BKzjjv5r8P6mYs7KUgZQdLU?=
 =?us-ascii?Q?f9VwZGCqDNFWRUH25BSJyK0T4ojaOrEQAyVK+cp4CyjbK/vHX58gJqg59Jyo?=
 =?us-ascii?Q?ueCISDv23bYoh6W1Wjwr/ReY5TE4bhwBLEAJq5ukUASL1QK9uVk+fUvlOxOj?=
 =?us-ascii?Q?rCcLeE3+jQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfeaf0e1-d16e-4f80-5b53-08ded674d5e0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR03MB5937.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:57:22.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxjJJNydKtDvyHk/FZRZ1eVZQhN4IieGKwqt0d04szjAQkUi9X4userJ4GnCvJIaz4YxBwI0V0eWY3gbvQ2JeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5853

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
Changes in v4:
- Restructure write_init() per review: return 0 on success, single
  init_error path for stratix10_svc_done().
- Do not assign wait_for_completion_timeout() result to ret; removes
  the need for ret = 0.
- Revert PTR_ERR(kbuf) to -ENOMEM change; keep PTR_ERR(kbuf).
---
 drivers/fpga/stratix10-soc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 0a295ccf1644..b8ec2e6f615f 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -195,20 +195,18 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG,
 			       &ctype, sizeof(ctype));
 	if (ret < 0)
-		goto init_done;
+		goto init_error;
 
-	ret = wait_for_completion_timeout(
-		&priv->status_return_completion, S10_RECONFIG_TIMEOUT);
-	if (!ret) {
+	if (!wait_for_completion_timeout(&priv->status_return_completion,
+					 S10_RECONFIG_TIMEOUT)) {
 		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
 		ret = -ETIMEDOUT;
-		goto init_done;
+		goto init_error;
 	}
 
-	ret = 0;
 	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
 		ret = -ETIMEDOUT;
-		goto init_done;
+		goto init_error;
 	}
 
 	/* Allocate buffers from the service layer's pool. */
@@ -217,14 +215,16 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 		if (IS_ERR(kbuf)) {
 			s10_free_buffers(mgr);
 			ret = PTR_ERR(kbuf);
-			goto init_done;
+			goto init_error;
 		}
 
 		priv->svc_bufs[i].buf = kbuf;
 		priv->svc_bufs[i].lock = 0;
 	}
 
-init_done:
+	return 0;
+
+init_error:
 	stratix10_svc_done(priv->chan);
 	return ret;
 }
@@ -342,6 +342,9 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 	if (!s10_free_buffers(mgr))
 		dev_err(dev, "%s not all buffers were freed\n", __func__);
 
+	if (ret < 0)
+		stratix10_svc_done(priv->chan);
+
 	return ret;
 }
 
-- 
2.43.7

