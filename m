Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012026.outbound.protection.outlook.com [40.93.195.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A22318EDC;
	Mon, 11 May 2026 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477944; cv=fail; b=LCDHm940I7qbHlSf3b7irCPD5IeSKqGxLZ3TojF0oE335maSrTWREmCmcKLCYUayuLln8GJ+e57ITB7J3kw+amel8843nU0KCHWzC0xqVjc4Tl72UqKkVVbs6TkHotGOHWz+ZRhsQEB9Cw5HG7I8Mg83xaVGQlogmj9k2pXAU/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477944; c=relaxed/simple;
	bh=0QteVCeTsmJfBt0oXP0o+3QFURz9gtTbmYti2yiLpNc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IrHceCG5lu1aijabI58BL8TPH4X4d0qfpzLs0sw3YLnXOGl6WPDfwLxPXeOHHfCbp5MW8dQD/ygK3HqOzKGlrohxB95p9zDSK4Bmo5cpKyVC0gJFnuwljFGwGd1xYnNLCgJehuFT2+N8iIb7R/64ehuh0hxbu748XuskqnDBGqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YHWFkEpV; arc=fail smtp.client-ip=40.93.195.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YHWFkEpV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMxphLszyeG2IHH70puBDYz4Lngi923G2rhEPTb/9LtMA5/FSxIQLsTwFLAwjcxte7kjmdAe1a4RV6EHV234LglL0Hr+taHpKhxT58kjNk80Mk6Z448ArKof+nFgXqhiC5oWV0OYS8NNNA356p+wSY6OitC06/QZLruBVOeShOxtmKroP8/smKYfYZMINjrGYyo5g7PT1mXltLYAkNgTdDk6lgranC0dcBsa9UihprzAp8elLplvKiAm2EbDtUv0BcvR4pzDvPE098y1HlqIpEDRxebyQ9XruyHYlSjxpc6gztUEDd3pW9sRJr0ruhA+ppVWqaUAtOqivWi5CaQ+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EtKc4/ObMD9prqAFshh9FvdiFAw8wNqHeMjJDUEVeQ=;
 b=aXs8roqEG/s//ogmFR4fNj6OJzy3yuiE8/LjjDtYVy7Uk9vDewZEKF3HYb3PL1TtrSW69T1vskWDc2vdMFAoNk77Wz36ahivfzUn+xT7/KPDDxchFW6NDqpXc/at7WkhYy46s3PlDacKEGbZHEACVVPa4QSDuWa7PtmbmMB+kVb5SkVVFvgotkyXaURE7HOcjwMVo1Qt3mkkX85QPtzZwhYYGTh581utyo4JTCLGk/GtYrX6N+JZxz5qeIwpjkM5Ls0iSlarzvHrGyowoEDdiWM17wgNPJvvxEtazCboGKq3xuymLoj6EOlwJr0Q6D3P257pLpFHdD8v2fg4w61E6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EtKc4/ObMD9prqAFshh9FvdiFAw8wNqHeMjJDUEVeQ=;
 b=YHWFkEpV47Wlaa4yxqLGJGBr26gSzAkP/B0R3+reSC6Q9EaCbQu2GUhkdyMGVKMu1cHRP0/qdaYMpe2JX1kw9+5dlcSct1p8prAU8PNcSqdBA1zM620jqpwmx01XKIHbspTio4DNPpgazbIyHZKtDD5KshgeiwRHaXSr1sN2a0rjn4uZU7ucfCUDNU3u+8JYbOIvHO1jqsmfCb+IkeV3topyOehYcspUHJcfO+qAUo/CyQU7kqAxt96D6RQxLVg838sBOTgVpOX0MBrQwGjwdN7Hl+HTRn7yiv6getzZq4YYXeNw+WMc9tcEeFiLUUjxm/AftXRvjpOeJFwyEXpo+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BN9PR03MB6106.namprd03.prod.outlook.com (2603:10b6:408:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 11 May
 2026 05:39:00 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 05:39:00 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: altera-cvp: Extend wrapped HW credit counter in software
Date: Sun, 10 May 2026 22:38:58 -0700
Message-ID: <20260511053858.30921-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:a03:333::35) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BN9PR03MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e9b9f9-c280-405a-07cb-08deaf1f9a7a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+4h28jP0q5IUZfGbJCgnD3wLzliosuKFc4jB57NmXMyJCHqYFiAFR2knaIIi/tbDaLYwMWCVN1eWLwsCso129LCF8AMppT1XqAMugSbeQ6/RqV+dv2u0CipJHhnvto4GS4x41YILNg17vSM1W1drT/cXnOeVU3UaA5M5tNHbiQZwyMNHwcEvQazJiDIoM8fTYEQwLg1i+JXAathvzzL3B2RH7LM1nUL/obY5HS4t5r+PUwchvmUDYzWipSg26a0LRi4gRXZBQr4z0gXrywF32UWPd6LhKKlrZjZpF98OSTsrhUHNRf2IdHWuLVDqt5r564B98HPSnwnIRBQ64u8tu+Wxd/N4+WjpXtkfXJUHIoXTeHIDmjJZnJHNij7rM/XOAwTM+iMZAPHSWz7kSsbukgStgUEFSfNjeQM4gtmEwEdaFxyg/m9nstfuqYAY7GSR4fDYxH4Wo7fBFV1jw3qrzXhTzfj6hvZ0Yj3B9WYt+1VKEhPV5PXW/SkQ2f4tOg7rKQWnbCTounyu3IlCb50koVj1DbwdHcWPYp50XROp/M52zZ0ie5sOgmn0SpmeTG1vtkVyU4wLXUspR3vGaDCMfmOjoi3NrH6qShtTaTtSvAscdXddo8vnfqcY9dc3HK9W5j19X9d6HV+yD4mbfhYRcy/osnCDrQJWvn1w+mc3nkreqmfP86TpwLZktiUP7xPq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jK9MTqNvCzO72pSksDTQwtwGLZqgaucFr47Gi1SkPspLuy3GLvILizUL2NAm?=
 =?us-ascii?Q?bj6AvaWjNJ6fjwLj9bEJQqq1frcs08UrHxo08PKdJMmiM41baid3V4Kt1URx?=
 =?us-ascii?Q?/G2aeeSpQlsHrP4rpOSsge4iS8hsIKAh0Sf8c5TF/KfI98vx4OxoM11krEdP?=
 =?us-ascii?Q?xuCtqUcrCQyeqXHv8FBaz2zN0e/TKPoJ0HT9jyZdvJKZRCQlgn5qLM2bW6UW?=
 =?us-ascii?Q?s3Np9jrQPzRgPgHK3JCBncObDhXYMgv200FxJRI3ljmYTRYmeQ5gc3KqMMy1?=
 =?us-ascii?Q?pi/n1Fo5KWnG7P4nv25gWFnlbEY7QQcEx/ilFzJRoDlyjE32hxHDI4VZhLsW?=
 =?us-ascii?Q?RTNA6PXDkJ5q2rxeOYb7ikbz9d13zCvKvZVWPT9nRL2hyaU+71swRBI07qsx?=
 =?us-ascii?Q?X8L+V6wfKT5rc1YGKcr6qu6NeL71j8H9wbrWE5o3C9sWjVqBo8/9FXiPlrey?=
 =?us-ascii?Q?vVF5w/Oa78YqSo67MFn7E0xe0kb+pMoXZLWhQ95+SoAoW/gJOrzekDRhiKt4?=
 =?us-ascii?Q?lq+8tC8WZ1nxaHMVx78W0KqAA1LmyD0aLnVICaqoTx5/L7FYutxtSG7lpTD/?=
 =?us-ascii?Q?D0wwjeHoyQ3dauxImTjq6ilJOya9mcZsD2W8neZ0zbIfJh/QWK4mz88S7DEU?=
 =?us-ascii?Q?QYLzOHF9ONI8iVTCDVjX6i+cFnELphfu3hT87z83jVhkqCs9ufZKgRDCUW4q?=
 =?us-ascii?Q?Sl5Q/d8bdhrvbCXzCYfgD/RV975K2sIKlaL5Eb9l4jeomnx0LFdfO34s/5HK?=
 =?us-ascii?Q?0yoTX2PPpxZDWt/1ra3qCecT1Ozjs6TjMp+o3CKd32WrM4BMpBhFNPMDxZ07?=
 =?us-ascii?Q?9AicSEbmxir647VY9kRJVbHHUwdPwFVix2XDWvOqkqFmyqB52u+JlVGZNLwN?=
 =?us-ascii?Q?46ApM9OX/+7nQfiPOYhgrYJfCGX76TWWRsBC/WNNcnKpOemJTPMasy3hLViL?=
 =?us-ascii?Q?IRqsCr4KQx4+3O1Bp8JOh9hDIUWXm+gsyiXH8jRu7ekBgRmXNpVEtcBmyKp0?=
 =?us-ascii?Q?94FjQfKSS3sa2Ul9O6I8kZ/MCloDuKsw+Xx3rPlj8c/Xy3MK0dBReWPDxLjw?=
 =?us-ascii?Q?Imz2d6qwW1keLKEG6Ne56298TuQBoA+vmEB9WzMUd3fpr1vHtVsm9KEFHr+r?=
 =?us-ascii?Q?fmPEqbvMIxRW8CKi5+Uym4XMw5D/v/9JQQKqjWn6UDc/dhFObHExjR1wa/2O?=
 =?us-ascii?Q?BWKkTnXrl/IvT4FPbVwbSqOid+iTHwrhvhY6bRsoh8DopVy53XIs3xGO0Xh5?=
 =?us-ascii?Q?fGBIA0z3nfmNMY2rzTOBWteFS+8hHHeUyR+jKXpJL4NPyDczQw8fDNGIkfop?=
 =?us-ascii?Q?64s0ce+4umUP/dvpu2zoHzJ5HecfnrlusqE7GARZ92RMesboAjdwMsk6haQg?=
 =?us-ascii?Q?YbubSIXKJ4o5GupdrsdMm8lE8cLCxN8/dwVaen84JGx5qWcMyPypjFziYX1v?=
 =?us-ascii?Q?Le42ibPFqdajoSMi1lX030c3Xpw4gB4xIsQEPQnfHjpnG/HUlmS5D5vZB1Es?=
 =?us-ascii?Q?pnlWySAU/5fXNBIFGTQWWqgwur2YPtWDafFePR0ISdCIYiiLzVZwg1i87O+n?=
 =?us-ascii?Q?2RMfvhiQHvzFDwqqGBeIpxVV+p7aiaayTIkHXvAVui348EZkUhb7W8tFxJ5L?=
 =?us-ascii?Q?Zcuaa5XlY6R3ZCL9A8gymObkkp5Xg/SRdd42cdOsy7CAYgjwdl17x2pQ1MIn?=
 =?us-ascii?Q?Cfz+P+D+9obY6gCK1BCQqP04mQTPqjfjWmm1w/Qx0ek/Xip+Y2GRI7it3QV1?=
 =?us-ascii?Q?m6ZoXvdrsO8xWF6DTQUcec44uUa8cyMyrcxaXEkyGGofkkRQ1ebt9CMa8UXH?=
X-MS-Exchange-AntiSpam-MessageData-1: t/PIy4je3laZRw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e9b9f9-c280-405a-07cb-08deaf1f9a7a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 05:39:00.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQU3LYpRTY85ODaq2D0+61MFO3yXmCpRppLe0pgh0Lwthgy/Lu65lmjPltZVArDcFKlasxQUNZszHjE3/7g2xR/QwFKJ0tO4F4FGSXlFzr7xpehwxHkSXt+cA/UrNdtRd8QR+rgMCNERp3nqrOeklA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6106

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Mask the hardware credit value using compound assignment and replace the
simple masked comparison with a software-extended counter that handles
wrap-around.

The HW credit register is limited to n bits and wraps naturally. The
previous logic compared the masked value directly against sent_packets,
which breaks once the counter wraps. Extend the counter in software by
tracking forward wraps and accumulating an overflow counter. A wrap is
detected when the masked value decreases by more than half of the modulo,
avoiding false detection from small backward glitches.

Compute a monotonic real_credit from the overflow counter and the masked
value, then compare it directly with sent_packets. This ensures correct
FIFO space detection across wraps. Also add error reporting when the
credit appears to move behind the sent count.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/fpga/altera-cvp.c | 58 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 44badfd11e1b..6e7a8ced2d68 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -76,6 +76,9 @@ struct altera_cvp_conf {
 	char			mgr_name[64];
 	u8			numclks;
 	u32			sent_packets;
+	u32			overflow_counter;
+	u32			last_credit_hw;
+	bool			credit_ext_inited;
 	u32			vsec_offset;
 	const struct cvp_priv	*priv;
 };
@@ -228,19 +231,64 @@ static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
 	u32 timeout = V2_CREDIT_TIMEOUT_US / V2_CHECK_CREDIT_US;
 	struct altera_cvp_conf *conf = mgr->priv;
 	int ret;
-	u8 val;
+	u32 val;
+	u32 credit_mask;
+	u32 vse_cvp_tx_credits_offset = VSE_CVP_TX_CREDITS;
+	u32 mod;
+	u32 real_credit;
 
 	do {
-		ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
+		/* READ DWORD is required for Agilex5 but READ BYTE is required for non-Agilex5 */
+		if (conf->device_family_type == SOCFPGA_CVP_V2_AGILEX5) {
+			vse_cvp_tx_credits_offset = VSE_CVP_AG5_TX_CREDITS;
+			credit_mask = 0xFFF;
+			ret = altera_read_config_dword(conf, vse_cvp_tx_credits_offset, &val);
+		} else {
+			/*
+			 * For the byte config read path, val is zeroed before pci_read_config_byte
+			 * so only the low byte is defined before masking.
+			 */
+			val = 0;
+			credit_mask = 0xFF;
+			ret = altera_read_config_byte(conf, vse_cvp_tx_credits_offset,
+						      (u8 *)&val);
+		}
+
+
 		if (ret) {
 			dev_err(&conf->pci_dev->dev,
 				"Error reading CVP Credit Register\n");
 			return ret;
 		}
 
-		/* Return if there is space in FIFO */
-		if (val - (u8)conf->sent_packets)
+		val &= credit_mask;
+		mod = credit_mask + 1;
+
+		/*
+		 * HW credit is n bits and wraps; extend it in software so we can
+		 * compare to sent_packets directly. On a forward wrap the masked
+		 * value jumps from high to low; require (last - val) > mod/2 so a
+		 * small backward glitch is not counted as a wrap. More than one
+		 * wrap between polls is not detected if the low bits repeat.
+		 */
+		if (conf->credit_ext_inited &&
+		    val < conf->last_credit_hw &&
+		    (conf->last_credit_hw - val) > (mod / 2))
+			conf->overflow_counter++;
+
+		conf->last_credit_hw = val;
+		conf->credit_ext_inited = true;
+
+		real_credit = conf->overflow_counter * mod + val;
+
+		if (real_credit > conf->sent_packets)
 			return 0;
+		if (real_credit < conf->sent_packets) {
+			dev_err(&conf->pci_dev->dev,
+				"CVP credit behind sent count (real %u reg 0x%x sent %u)\n",
+				real_credit, val, conf->sent_packets);
+			return -EPROTO;
+		}
 
 		ret = altera_cvp_chk_error(mgr, blocks * ALTERA_CVP_V2_SIZE);
 		if (ret) {
@@ -378,6 +426,8 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 	}
 
 	conf->sent_packets = 0;
+	conf->overflow_counter = 0;
+	conf->credit_ext_inited = false;
 
 	/* STEP 4 - set CVP_CONFIG bit */
 	altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
-- 
2.43.7

