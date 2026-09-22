Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20FD563FAD;
	Tue, 22 Sep 2026 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092995; cv=fail; b=t5j87ZTPhDIsOXbnlLB+1nQxl1envPpwhrxaPMGvpFyi+ptMsARz8+ZnJkfT7+ANvC1k0gm2HffJnvIpOP2Cp7ouHje571NgjsTuHQ6faiScKKYd4coILfRqOgYvxEYc55LZL3WIjsCwlwiSqYxI5H10CjDf8Z9j4npPjY8guug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092995; c=relaxed/simple;
	bh=f6odyQcRMKVJV95ET4TXVlP2QNyw9yveo8Cql1+c8ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9bVsC4QlET7dyOopxZ4PfvHEY4/5ctes1D+Fo5X+UVYMVy5eoQydiaUGtgdCN4/PEU1HwcOHprUO+kvmUzqFlMrRNK4CpgYlEp/th+lLEzRBGLkSusMn2S4r7ClBTXDMAjJKTIQfgdwiNDCwWq71RBTgRIAvTfVsf+qoWd6cw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YhiKVOPt; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YhiKVOPt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJuED6Np9FO2BB2oyYfutrYShdXgXwJiVPkzQpzTv73KJNQQ0gF0leMe1NDtqccA34DeApF0eZq9yDOZPHrTa7FhEgpgLIj31Q5NhkUOVCgNSoaHhbk2uh0jOWDuucZvJr/TdlZqnb68MbYYjXNKGameVlJPWKJhwNt2b9X97rUk65LhwzTHyQgvXXJKMGFI9twZ/YtgAQ7NIRw4zDqPF3Yqexdiwc1DcTDB26CJN6o5X7xGgqDFJUHRPPOdQKD8PHClwB7f16RtATW0pDAkgo7/qo6QxsVnM0dmpcFgkgCwKjD45GthJ5AuGsi3EwULck1Fn3jMHzd2/l28zFJouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL5E6pvKeetbKuK9zrlexoZTupR20YXA2AT4T7c7En0=;
 b=ckSn6/XaYhJ/AplX7OkN4bvQ/0JwDuwtHIILVi6o8VCAm9TN/RwsW4QXMuKqyxoBT+XjmRVgiGYz2ijqPu2aqhzz9hYQRJggutb+2ddrK+1IqKMjLk5JByhvyHhhcpdPzLlX/isrxIQpzFK4UVCOrMRBAuIFmTn6/nv4z0Xc8vCeNCAumClkkLf2x1/zwiNXK8hcuwaPlkq1RAfsjw0lGVkuHoDA/Qd5vFOaIIx9IYo1EKtrUEXa0Zp8jRnlURyoRiLqOA8O4ybTGDKxvl4WmNNoei2QL8SwVJV2CuG4iTCyeTyUVAbKrsM8Oi4j19M7Ohnq9KBZVGvhcuye+3EZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL5E6pvKeetbKuK9zrlexoZTupR20YXA2AT4T7c7En0=;
 b=YhiKVOPt6zjevgEslK0JaGIHB7biEOMfCFcjvQu8QMmcaSseNgRa7OUpT+HNFn5m61GptVTfR7uJT4EoLtP1NnmkmI1W6dXFKrTLKfDEjxYtu8HkbQN/XfTjSOvustoRQULklIBFjDiUQvh8gH2yA3oXiS0GVHXzezkcTVOidDQwXGrnNe948ge69s+ComExl0BmtrtRhCrwrLUcOXcapfk6qLjWZKxZ+rViRbo/humyhJ9ZTrOa4F1XBWcR9WZG+K+SYtjQImzug+4jHyJtfPc0dvvhsAVDwNS/wykbUnYxZdVSXD8nG6SzAPYYJsYKCxbSC//J0WjKLkQN4UyTrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12)
 by SJ0PR03MB5918.namprd03.prod.outlook.com (2603:10b6:a03:2da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 16:02:59 +0000
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80]) by SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80%3]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 16:02:59 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Subject: [PATCH 2/3] fpga: stratix10-soc: prefer ERROR over BUFFER_DONE
Date: Wed, 23 Sep 2026 00:02:42 +0800
Message-ID: <77007ef350addaec2d9a9e3bfe90f4c303281893.1790090287.git.adrian.ho.yin.ng@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7b21d37f-8042-4f37-8b2b-08df18c2f8c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|55112099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bwo58ek3GEVsUG/kxabZcoCvx2HaN8QC56/t/Itq73ddzqb8baMbgMEcmvcgixizH3yE0CVBSNt7H3tEZ+iwSjXpUI8xgMy9Xq+HgzAMr1JKOr3RaDXpsl4LKedQVq8zV7pxdIIIJPPxMOJ8ogaQes3l3eFxjYaIN/KHkolpio1qDa4/A8XbrZ/cG5Rb8SDaLh1UMGlcmt3JI0NSqm2aGCLF4OkRFSbhsTxe5xpEcUhlBH3Du07BilJx6GcH8m9MrhvAYY5eIrbc6Gb39BN+caTFfcEcGOmtZbhg937Mzeak3W8S3a4LsBswOyyiNY/9lg5eU18IanhsqqYrgUWDNUv3Y8V1hq2/tLRM3JUwLOHfWEla+9gxXW4qRl9/mnVYbNFo+y6mnsRxnY3+v7lOB5Z/X4NPFk83PtnJ9nOIeYSwllggeNm2kxAn6aN7vWpACKcHOPU5v9tBMinbc0dk1s5joZM1nxhHdynceMMyswY/fiOvXG+7WeN9qG8OvDTGt3uG7d0h7MX/FN+Uh4lIfu33rK81HCnXw0L2J4ogF/GyyrN6Au6ZmJjzLDi5AyRKz4lN3AHHBUtKx9UdnIDQGCV+rciTt4Apq5D2AaTzsBwUvD1RXSgczlmiB16McYyulDA7gPSoNjg2tgVJNmHoPa/7rop54gDiysLQKzY3nTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6581.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(55112099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PNXmsMH15/y9soBc8gOh6FJzi6Snklm3PlPx7s+SyoDyCEUcVdZ5ZIOMGuOt?=
 =?us-ascii?Q?zq34XzOiu67FTfXUjwRzeiCbXNIIOT8EzK3co8PQME8eOb8kpvbiVxrCYlv/?=
 =?us-ascii?Q?nHoJbefziLyd49BmoTdjY9BTCk33645R1VZGXyRw1d44jFt1czjog4Nh8o7u?=
 =?us-ascii?Q?KcLkVVL8AvKNKWEuKFVHnK7UvqMpZwhylsUYMhMEdIafVzwgauOuErF1CuNQ?=
 =?us-ascii?Q?CW6Z6WO9ZgKMnerf4I+076roLWQ+K39Fp17lUmltmjhsGgue6PNEQ2et4SNv?=
 =?us-ascii?Q?xEgzrMxqgzbhDIK8rOTfh1F0e/AFPyZHVoL7CYPxn86+jYN/oZXgaZbmfMwv?=
 =?us-ascii?Q?qrpHtApiSueRcZ1e8uHGfw2/gAP9Ly24db5pQcN+btCP+O0LmqrZUoxA5d1U?=
 =?us-ascii?Q?oLzHN4anEO5BU8mQM0GTOdF7e7TNCBIzwRbp2tZhLr1ZNQQk6if/GDfdOWdx?=
 =?us-ascii?Q?rtcFRbFxTmHes/uLQDN0hhds2AIxV+MW/x7naq1u8b1OsiN3jp0QqskMYJsG?=
 =?us-ascii?Q?nWb+j4am1kQ9GnbfS5HaaEdXupso2ssd86cmhvQF8jCQBDHQlnlxSfLL+NLa?=
 =?us-ascii?Q?2gy6sOBLdWht6H7CEIwu/VQz5n2OYigAIIr5/K0tTlmqnLsMrJwfFkk2pRLC?=
 =?us-ascii?Q?fccR58ao9TtbUz3+rh5LFqnLOVI0WubQif0xsTxkXipeLjWTmo++HZ72/00/?=
 =?us-ascii?Q?v2HzVYHl26dN8MAvxh2RBfnpEu3CENrXZdHhk3T94EuLtnZDUjvhj9XQsSTN?=
 =?us-ascii?Q?wSDwGOqHuQSub7MO7P14QshQDzfKWdd7qS+KokA33iuEE99eblnQi/fGJhgt?=
 =?us-ascii?Q?TEbHUyzWHUByEKLH6UdWijYJibLQ3bKCsUGMde6Z066AoWl4qP0QR2dpxy4p?=
 =?us-ascii?Q?jCO6PP0X1r+6xdepiLLMSZ9Z5THOnWRzH2YX0zZ6NavGjGnJYelCEiJCNlqH?=
 =?us-ascii?Q?bipusE+HydkkqsbksFxa9YQ4TeA13yr/9zw69HXa19Sp4dn47YzYzNim8Rg+?=
 =?us-ascii?Q?xvuG7mbzwRvGShjSxZt0kxDvTIJAu3kQ9+GdoZoi6EmKCHHci4CpywbF49tI?=
 =?us-ascii?Q?iQ0nuUVfjJMPOqpbNVP0uZvX3eHYhCOh6ya6ppu0v03w4AjdP9wfnu3qumKs?=
 =?us-ascii?Q?JjwSImxJTZ8LMVn5o7DQQeLBjr1/rXxsR5bAl1glKuOwqmfbltJ0ap4/P/2q?=
 =?us-ascii?Q?aIl4RIUGzAzXVL34SOBjKBDvsCmSoYvp0WHFM0JFpTTtHr1rdtaT6MgS+5n9?=
 =?us-ascii?Q?sV7P58IKnb3zilwaVLBeDXORsjent2uXcQA3zkNP2EoiKEQKtGrsoPZwT/e7?=
 =?us-ascii?Q?DeTgo5/Uw9qK1hctsdL39CGZydcI/wX0fEtzGaPbxOGV0z7lFYcc08UUtovr?=
 =?us-ascii?Q?sW/u9uxCgxTOMdOzhf21LtRFw0wlKfZ4awjgSCAPwyaorq3ySpZa+tyZ/CjC?=
 =?us-ascii?Q?pEEIAMjtx+WaUGdNyFyL9swcUi6vgRzuKCGO1PLolNZ73fEH2rNBejPaqoid?=
 =?us-ascii?Q?PkczvVMShuSckJnlwuLBRD0DH9X8GFO0xXnKXClg2GGF6MV2EukIub2vTOBh?=
 =?us-ascii?Q?7+WsHeH758zr1OgxMjf8H9ROOXriA1t6WTAnOS1Qyd9VJkPTcUZcWXEg5V/B?=
 =?us-ascii?Q?aZVky60u6zMR5iIdlLrROKmKJzbz5Ivu8ud6sDUHpkB2viEjDG0cHYtSQ8s+?=
 =?us-ascii?Q?hciqOOsttRKvVYBaK60sSfiAFZ/0UQImzh7f2L9urKF8Qmm69YvqQ5ZFp4Tp?=
 =?us-ascii?Q?BRfwRtjnKwIkhjs7UIPxH8dlXIpvDPo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b21d37f-8042-4f37-8b2b-08df18c2f8c5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6581.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:02:58.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnJM2YkZNY3rkwyspUhPd7n4pISxcnlXRac+RWFWI0pWj/6+DTCsE17Egx13XpunPBT6K/INIeF/ogCOG3p7N6uiMIZ70JAcT7wBYMmt2yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5918

Check SVC_STATUS_ERROR before BUFFER_DONE so a combined
BUFFER_DONE | ERROR callback aborts instead of being treated as success.
Clear priv->status at the start of write_init so stale bits cannot leak
into the next reconfiguration.

Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 drivers/fpga/stratix10-soc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 3ba0ffa1d9e0..c16ed571630b 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -183,6 +183,9 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	uint i;
 	int ret;
 
+	/* Drop stale status bits left by a previous aborted write. */
+	priv->status = 0;
+
 	ctype.flags = 0;
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_dbg(dev, "Requesting partial reconfiguration.\n");
@@ -319,6 +322,13 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 		wait_status = wait_for_completion_timeout(
 			&priv->status_return_completion, S10_BUFFER_TIMEOUT);
 
+		/* ERROR must win over BUFFER_DONE when both are set. */
+		if (test_and_clear_bit(SVC_STATUS_ERROR, &priv->status)) {
+			dev_err(dev, "ERROR - giving up - SVC_STATUS_ERROR\n");
+			ret = -EFAULT;
+			break;
+		}
+
 		if (test_and_clear_bit(SVC_STATUS_BUFFER_DONE, &priv->status) ||
 		    test_and_clear_bit(SVC_STATUS_BUFFER_SUBMITTED,
 				       &priv->status)) {
@@ -326,12 +336,6 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 			continue;
 		}
 
-		if (test_and_clear_bit(SVC_STATUS_ERROR, &priv->status)) {
-			dev_err(dev, "ERROR - giving up - SVC_STATUS_ERROR\n");
-			ret = -EFAULT;
-			break;
-		}
-
 		if (!wait_status) {
 			dev_err(dev, "timeout waiting for svc layer buffers\n");
 			ret = -ETIMEDOUT;
-- 
2.49.GIT

