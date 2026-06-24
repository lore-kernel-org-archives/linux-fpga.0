Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A63AFD07;
	Wed, 24 Jun 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295920; cv=fail; b=F2oO+i5lwIDb/Gfw/Rc21uArUqgAKudOO16torHnN5TTS8/hcnFzzB3pox0slZoFjnj3hdsEcpa8hRiIu33iye5qRUzevqg4SIAjMcjR3V1OGsfb6pijkba6icKSwCQz1MI+nsjDgL5Jxl8R8r2Tc6ATnK7fC+8OINDA3TTnc4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295920; c=relaxed/simple;
	bh=fqNcJR4p0NEglqpye1KgV96XSY5DrhOhyc6gW55L3jg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F2W62G7hKO+UlS8HcoidG0tqZu4CT3pXY56KvuX9/1OmOpAiu9qEkgJ5F88TB/HY08aP9sA5nEoOAtsMojPdpATEyhqzRFI7SUqk23U1uu2bw9ehJomg11gNMQTiqXaAbhDSUfDQidCnHp437MGHaKitFUtJt9OdNVK8JsiPnoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=dylEdmaF; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="dylEdmaF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snbn3PrrwWuSym+iaWxff8To++oC8fLUG1cxKqUTTUR1Hbjcr8U8MNIgXL9W2uoOOlu478201Q00Ri3jxR5zmYXXdHgP39Qfkimafihr0o6HvSHikWPu36MjkUDQYvH5OV6GmzD9WRLnboCrJFimcaZHYabOGqAjq6RNIRQz+ApSe9NaJPWiEWWkpAEko2qbDu1TbvPpbNNvSsYr1vmwA7uZeXIl6+wACd+65Nsxs7eeCsjN7Dp7JnR6ADZ2WT97V2yHhvhSzzg/mEPPhxKgtrGRodhP7Mc0M41FiRPQveFHF1RJAZt0KdkkSl9aWdaCy6pw++gov7/y87SwDcimsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ktlW/Bji4iHWxvEY3k1VzFaBzz9O8O66Cdlq/7DIf8=;
 b=EQih+XbSs0KHBnK/cuKxKPpF7wFN24ZJ+eYVXzSCNeNVfviKZ2bAcRGXv6hCCq4yYQKqDkMDXdBSGk5648feiNlniD7E5T/hmeKuJQ1XB4bZpDiHUxTS9ekB+2l5+YnA3NaRIRoSDoti9bOry3J8IdyZaIFohHBvw/hn3tmRYYioEhoDtKGsURtmz78UhV2m9V2DPAE7tMXn1AUrRi8Po6J2FEbRpWpU2nafpjtfReLJVqeKvehorqsQeKdnfBPZO1Q2YB9r8WBFn38rZginCzCzl2Z64nJY2zQBRLSziC7nPlhBsuBtousgz/SHfpZ1cXRuYTu364HQbJ8TixJA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ktlW/Bji4iHWxvEY3k1VzFaBzz9O8O66Cdlq/7DIf8=;
 b=dylEdmaFmu5etmhEuOnyriSJwCeJKhpk1f6UZaLEWu+PJtGGv+qckVvuuliq02snuyntQnyeQAGG1vO8O+nTx4RV+L82jiW1aFzJJy1NjGbI/6s1QhPRKyplQO0ibAKaRV8QzPTArubaXq/g8TyyBV5r1vsaVWxG5VWGla3Y5Sevd3CzAhsdNsFfZ8uqQvVim4sGHRb8RPl08ORgayxA9OyerKsn+a4eKaOv7AkIXmJNTIEOGWE+7KEsOey+owv0zpyuI02SW34/M2Da685kFjkUOBxqlpK29bGv9exhd4dlffgo6TZiQrHNc7knkI//5pUH1QfuxRLFINkMpOrnOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CO1PR03MB5937.namprd03.prod.outlook.com (2603:10b6:303:6e::18)
 by LV2PR03MB989134.namprd03.prod.outlook.com (2603:10b6:408:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 10:11:57 +0000
Received: from CO1PR03MB5937.namprd03.prod.outlook.com
 ([fe80::f970:684e:8c80:91c3]) by CO1PR03MB5937.namprd03.prod.outlook.com
 ([fe80::f970:684e:8c80:91c3%6]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 10:11:57 +0000
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
Subject: [PATCH v3] fpga: stratix10-soc: Fix SVC mailbox handling during reconfiguration
Date: Wed, 24 Jun 2026 03:11:54 -0700
Message-ID: <0119f69b467e2b90240ebaa3aee3120f621ddee3.1782295811.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To CO1PR03MB5937.namprd03.prod.outlook.com
 (2603:10b6:303:6e::18)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR03MB5937:EE_|LV2PR03MB989134:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff313d9-2bd2-4530-e301-08ded1d905e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|18002099003|6133799003|55112099003;
X-Microsoft-Antispam-Message-Info:
	YYCYW+7xqwYhem9hezgSLxvbnE5iAzZV3ZUz2rNGmdUj7OwCwx2k+gC0HUsUuNJsDbypu/6ubJtAOOsTxHarTN60Bt8WlDrn5NX0AaOkYfozj1Bu2Mrgg4hNgDzyXKyAXVeBzSsTh/LK8y0Zrgozrd/InpdSpvPTvZyIyRB5FdkgFjM16hZaXIk/lJfcXvH46CyC/J3S8z0vBYed1FM+4YT7+F30EVHENuINd1b5T0P7ZXVz0yfZqVPbzFIm/Zcup4xfOom8fIaMSy9cvk30WCyMRh1tabKjbJ6yev1hntIV2nw+ga1xUT42QcOhNx4NcBKXTCLFi3y4VxHIQFsY45uxhlkpS5j5jm6mxoqVTnLaOmgty0u4Ds754ZsOh71eVDxpwtNI8QoXTwdNvq/v6BFUH8Trtutq4ycdoalrR2BQIgbpKL9GrRehev2FOkb4feqZ08InyDC8q0XqZcKfd9RGI9m6UKgnCgJyT9JHKZCJKQE4q1MRAWLCGtNFpNso14dPJCz8wawDaPXJ0kW6FUgMTKGjBLOcHxkE5ZwVn1eMCJXu3QVpBFn8z+r2VW9EzMHFdX2WZVrdNpC/57+EBXa8fqOYJb+qCPZPRaMKduSekJra6rUMmZWaScSS3DP6tCVV1cf/rr1MfeCgb3oVoIhhpy3STnGzuE22snywmKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR03MB5937.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(6133799003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?prlt8nhjlTbeML/0qPqjk9voSPiYHtdArU5vcl8ow0DkKjbS5lQ50DNASde2?=
 =?us-ascii?Q?0RlQWZdRklOKs5Gzu5oN0+eVCzGCd5tnJ78ooDpG5fsx9Mh0ySqTzqZm2aQC?=
 =?us-ascii?Q?5x0TUhyd5MYB66y/fmWiAA6H6a2TBlxa9KIsWC4z3z4+ep7qK9AX+GtYtrj7?=
 =?us-ascii?Q?tv5mBzNz+rTCegqdNz1pn5Q6Rv6mj2cy2Dc3XlI5etwm9P+GkBE+odY+Sd+X?=
 =?us-ascii?Q?yTSiSqqASJ4WusZuye7DWYd1M8+tPDqp+UVKo7+8oUTMI4RRXVK8CTOVd/I+?=
 =?us-ascii?Q?rJNHAjCH8B+CQH5q2YvXXYAZXzi2qCffVhylYeE5LXdlEx3Cjz4yzqyvuS1n?=
 =?us-ascii?Q?kyA0BqoS98/TswXzVOCY1aeyu//4VFYIJlttHI28Jv8JR2bDAC8JkxgMlqNf?=
 =?us-ascii?Q?/QnZ3989ByNWRruFVtlIlbdq8BDDcOcehWlc21LT7utrVeB11CsjKQSgCR8v?=
 =?us-ascii?Q?EWp9VSl42WGmJP7SM3DV4nTCTUgVP6xFbtgAYbr2J9GQgP0lPMBzmNXtnjZC?=
 =?us-ascii?Q?U+DIKd1rC5ELXcLFGkXoel9jwGqLH0/E6aY46inlp8Wlzz+t/756Sowxk++2?=
 =?us-ascii?Q?JrUOkdhosspzaBTY1WLCteyQkY6OmvO0wuE9whmvj9nSYhohKs1OFptxkoln?=
 =?us-ascii?Q?6e8EG3VipZHVzFrjIuu4385oFoRuTte1kh2iKCVrc30JwwLUZ0MXNv4DhT+V?=
 =?us-ascii?Q?CrqJJUxyGMrdX8tGYzpp+DALjiJxXm/rwLSPWeKkf6eDh4IhjlB4IKkAaBsg?=
 =?us-ascii?Q?pta1KYEd1YfBB1VHYDgB+w7zdupGJOdtZ+2pBwCI41soLQmDDweJlFq1Mq6W?=
 =?us-ascii?Q?s8jc08LHzEe0J8vb8l/1BPeZSNIIn3i8qPCjSlQrKkNjUj967VBPSAgpLMEA?=
 =?us-ascii?Q?+j8Nm0YqHvx5JdhVavw4FvQu9BbUbqfQNyS1J6coHJMJeRKoWX31i+HTpgvK?=
 =?us-ascii?Q?fCH8efMQynexaepUmsXaggZ4FNZt3I0KUcNc29R+80Lu1i62p92qTZgozFow?=
 =?us-ascii?Q?BWekVmF/rBQJP/nN4szdXiAVjQUwB5qeqnrjOekEiUuTdgLwjAuP8X5NfoWa?=
 =?us-ascii?Q?gI0BZxk2mdAJojtPZjg7Cfb9grT7Z3k3SEcCTcgnRVYxzpmwaISKwRWzwWj6?=
 =?us-ascii?Q?g9gULUY4TI8qhzuWjAGN7doPSze1SZA4I0uRbedhtfHAZ3LYwJ5PrAUUiC/3?=
 =?us-ascii?Q?RjKHvNU8iJ/erE0rlhdPMIwzt5NvS+BcENRDQCUKgNxDwIEZWI3K3ZHI+ZB9?=
 =?us-ascii?Q?SP6vkGcCmC2xLCBpCNvNszCCUX5OXz4cFjZta838Gf/JUM/Vfr98WSEfkRm4?=
 =?us-ascii?Q?/fROWxb5s9jRcMXm1FmnEBsFJkBXK/wqvmFRFlp0RiPh4l4ouSraQncRI+fR?=
 =?us-ascii?Q?xZE0hTlnrEhKAgVt/GP1n0APrL3K81AYPKBSnOzVYLlShRvHNGihMAimETt8?=
 =?us-ascii?Q?t9aFUb9brecMU9dAG+6B+EDmJq5atoD8MXHrEWbE+idBGlEB5bR0fPdaEs4T?=
 =?us-ascii?Q?cW47nrn37hE5FPmS6jy/qDYuWTdmnRnvH1W4aakhRU1U8IbPBjOrFBYQ2G0o?=
 =?us-ascii?Q?4GagEdZD/BibbKOAZie+m+1Panw3qoueZey5B/dK7amSyVf2rR/IOJnXpo0n?=
 =?us-ascii?Q?duKXcT2lv+pttD0cOAosQagxnc4QgkpGtmsNh06yrpaM0HJK0G2D3Tj0F13W?=
 =?us-ascii?Q?/9BUAtnCF+Wg+ayhW/bgQlMXrwe5Kn7+Cs6uNQ4JfMPtdt74geHSfsDSjOBp?=
 =?us-ascii?Q?o1ZIt2wgUQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff313d9-2bd2-4530-e301-08ded1d905e9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR03MB5937.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 10:11:57.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPkrkZKttBMdPcNB6N59thIviOAjoXLcjlwh1aTxzPJULjT+4dnPQaHrvV4zocE+ESLhf4A1/Bdc3ah9vszOQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR03MB989134

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
Changes in v3:
- Remove blank line before Signed-off-by.
- No code changes from v2.

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

