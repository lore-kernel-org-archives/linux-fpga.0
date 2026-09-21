Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0802571A0;
	Mon, 21 Sep 2026 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789957440; cv=fail; b=psfpr9KK6fxmaISDZdRNldfSjWho032Jiih7a4AlndzsdWwWM8NX41zUayBmm2wJ+V1ag78bFFzt5taBh9z17cynAMGaXwCOciN7hOxgdWHXiDYaaxsFMoKVt4GWNYi4U7M+bP4JbVOH0B7ffo30RWzsiSfbckqFZhTe8qc3bJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789957440; c=relaxed/simple;
	bh=+hBMfKLNdjZ9AgM6RmWAS9RQ18j2nNekK9jBKdfslKw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Au71aEFMiQpBA+4e66oRFADSljngF3LKbWIqZnbi0D2IcqXc1M9j0wdD9gAH6xjM+HT1n0okBBxGBCgqd4LTEGRCCeJd4UYY/xWpUJi2DJBg3zNQtI6xgnROdLRgZwkphT3ggbIv7bqcRFjbddXPwlND5pJPPaZR2iZ0wbq/Ius=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cW9BgSm6; arc=fail smtp.client-ip=52.101.46.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="cW9BgSm6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1HZNsvetYC3snmuklczzh3eoVvYL2102IZxtIDx9InUFtIL8CYvdYxGx8icFKCtNSMleZyAVBd5cK+AYIyh+7dvNL6v3Rq3Fd66TsEJmqsZGmbvElFkeRk82Swt4keCHSbxvKBV/L+7v82VrzYzKHP6Fo2l1QVMcCVDgAhKFMJMXkJ4JIdDhkHAcSC6Alcl2spDho6Garq/DEx7sp8SKXgpjLS1kvvEdHyq2eFmpEqhYFG8U4F6x2OESTsQLn9L+vBdkiE5ZK2GVn4tdE+SwVcrJE/J3XLOd06kCOe4NEzrCZ3/yuXCTyKu/s93z0y82M4xLRD62527KlWtXNTb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnuoSqkVvgPqfa9qXckmJ4HB+hpcqlJo+DM6Xcrd0aY=;
 b=DUgK4POaTxf4AZ0gxBNRkuw4A4VwhjKCFgBD6fZXOT1ylyS/920QIl8ZP9cewGKIbIgMnpKaq8wp9DsfMTC9gDu+nkxKOAzq9j8RgPViSfY/EmltwaUhnXwkZzI85+0vWmFBQz4e8sp6CpdKDH0bqg37goGfEhyPZ2cJ01EsvBVWSG5EU7B+Y4EJbHDNz0pqh+6tyeHxzm+idqPU7RzHUlVA0Q1nryMTVsI4rXyoTxlUiCH/Mal4erYjUKAPGYEUPGyVAlu4q88YePMkG7WuwmW6GygkLOEi+yv9t8HgJ1+VlijTp6BLRNEL/Zfmo0G3gMcCD12OXqD8YADhVag1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnuoSqkVvgPqfa9qXckmJ4HB+hpcqlJo+DM6Xcrd0aY=;
 b=cW9BgSm6laxUqUrOURQyRVrlZXKPBzlkmAyR6UJQo1KQY4dldW8Z/E/Dx9OPgBAlpmaFzlDjdL/XkCJDVtj1dFktVofJWKI9xJRzCE0hi/PKKbcanu/ODsi+i6gEHUYrBWkUUtmQoUZkl83c7Sjy0LAinbBGSPOpZaSR7ZOi2vissZNIaAJnCHKArqgLr8u/WutDZNyr9/FX1vKyyvxJbpxvkS43JmsVVOM8+tnuHKaHSdou08yKXdu0FY80CXHOYz2G0sxdSyEbH9KYSG12oQ1Lsu8o3p3Dh0VkN36nJtCrDm30lwdS4EMOeDDA9mnO2pOFn+eqz8VnHXA7fGoT7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by DS0PR03MB8224.namprd03.prod.outlook.com (2603:10b6:8:28c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 02:23:56 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 02:23:55 +0000
From: tze.yee.ng@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Matthew Gerlach <mgerlach@opensource.altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v2] fpga: bridge: incorrect set to clear freeze_illegal_request register
Date: Sun, 20 Sep 2026 19:23:51 -0700
Message-ID: <2fe34c2dec61150a39d21e067521b0acc031247c.1789956938.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|DS0PR03MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 769acb74-00fb-434a-a884-08df17876224
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|55112099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	0N8Qw98bwb46mFVAmx8gzF1i50PonmCOtDNY6a9Mnn0SN1E4qrsKp06xi5YFJRzklspi/YKUCDN+lVX9KtLRfZnbb85XCg5VqL1/0zaYii6EkhRKUmHurSAqs4APc+4mmh+GAod9OJO5mTNfTejJtZMYTKefPKmjmBIpojP6IZZ9m74mUdqoelrSG6svfa8vY60A2tN9ac1XAFrGQwkwwQQGI+pNGWJJKnH3Ay15C42d7iAkfvphav2mxeecRK6kUPNQFaKeIHr1QXKS118RwrQx4/Y0GraZuY/onExt0vgvhQSnwoOZk+8Kf4yOebgwe1jKz3FoESfb8LCQ197GqkvyD18oFMeSAgwY0QZzJWOwsQQziacbmsmMqfklBjM4yPuvx3G208bn9Nv/PwIgCCI/h+ONPcle5qnO4hVhNkOAVzFBmIu+rK8rqfaSY5GVrds4cz8qfIsRPVs3sFSwcJM61CH9z0V2L/NTM1Q2OuFabKi5WAZ3lD/U9UztB59RJe7YR/avDSr8iOC1fCTsF1I208Z24Z5l/q8MBQuqbi8MOk5bEbwrXvIGfJVp7venf7+qYltbFBMZslLhbrsK223Qd0oif2KAo/3QHi0E65x50q4t8Ik4p+dQHbhKHvidn5SltIXiqXJpUemqyU96B9S6GNmgRBce2AZaiVtZM2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(55112099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pyAiZ42Tmiib/fRcVjOCWqB+BbEp9sNMpI/9KJXyCYanmBTedziZPWOQYs3z?=
 =?us-ascii?Q?7i0eJk7j0BCBmt6n5oiFEEFxo4yfHVYuG7VPQkcMFKtvBL+yvR0dloswTZ1u?=
 =?us-ascii?Q?cv7v1nWFaP2Q1dVrfM68p2D6k8C87zyYlSAaIc2fEYMzRzQIEB5Uj/g5PAXL?=
 =?us-ascii?Q?pxoSpRnmLmX7djuSIWMgnSa0+sLKrvBAaNsInmNeADTvQNxUp2QrcvliXLgz?=
 =?us-ascii?Q?qNatYbV9Nc3NmGCXQxwugeWaVAVSDC7geLwliWOvI2D1+TSUZhHmmz0/Sh9F?=
 =?us-ascii?Q?PLxnA8c+8YIhvDe2g5N18VF5/UueMnywn6ijgtHDaFKJDUPo6Ri4FuIZJAPw?=
 =?us-ascii?Q?zvsFkLPsOJWmrk0uueodvI9RLNo/vZjD+m5zcHxA1REv0UrS6QLVLYkDIAmZ?=
 =?us-ascii?Q?ez4Lhmaof0eWx+1Njunzb0kM9D9NgHYEyEyTBT7rQ+hP+6j3ZQ1vQFyk0GoG?=
 =?us-ascii?Q?x94emeA9djnvkLgGkBkJZvghGww4PvCV4giBRc51Wqxu2yKcFvsoZ64zR9ZL?=
 =?us-ascii?Q?gArW9YAaCogq3aeoyKkNO89nr2jYoqV2ncsrzdmFh0Uf06efXxztLufRNe87?=
 =?us-ascii?Q?sC1QG9nA9SzdKGqgEmvHgtO/emEpDQql6LtuWUp5EUbDlXvtKa8RuDWTfOdS?=
 =?us-ascii?Q?GZf/Q9DRq6A2x7hpaAtIGKGUwX7bzjMjAUYt6rVDJv5WlLbU8pzK0+IpAq41?=
 =?us-ascii?Q?pDCkHWCR8dJz1H9bXgqr9REcayo4owoxhzRVIAmo1wft2Do3m2XaiLEz2+sc?=
 =?us-ascii?Q?pRoPnVYjkxsM4e5Wk8QmsVejevyfPtKXYLpF0mcCt/V0J9hT7K0NsxZs6qPe?=
 =?us-ascii?Q?PeQXs/yuy7poPY4a3PN1AaVY+NSX8vU6aGhlNKOTxQK7JlhK8wSr7bLjCdT3?=
 =?us-ascii?Q?VGfthllAmuvPPd8yylD6DGwhLwoaI89SAzvlLgdMmYKjjqlf/gu8zL8ZFOx4?=
 =?us-ascii?Q?eN+miJB0z8PczntS9ao+jhV0gCKAcDzjcWhmoyMXYh4MhzB1Vpr8cQEoyxyF?=
 =?us-ascii?Q?Bc+4UI7ofb+yIIu6LThtB0oA/A12+pYQWHtoq15uE4bvM0u1RMnlnL7XqpuZ?=
 =?us-ascii?Q?9zjyKEQB8KpXZK/0hmhPjfi1vzMyr3JJnj0ApZFdbOWzMnNhiQ14l8oI1K5I?=
 =?us-ascii?Q?LMMnOFuujwjD72PSjKIyh+sR67tpZp1dS0xRxgjEScRlXnLSHVOrrn9T9Dk5?=
 =?us-ascii?Q?5EK1q6bkIwpDJu5cRnJFH63/G4iZsuwL8chFb5/CFzHdAnTA56dwb2U84QYr?=
 =?us-ascii?Q?xPyeoK0AlzgUXcgoC2F46M1P/LpN+EgC0rkZHTTWtfC5QxQvzTUzcuYvRsU+?=
 =?us-ascii?Q?ttOAZyt4BMsy2FFpVmq8/m6j964eNC9EkakmpZWqIue6MaTqOxN209ofoHUg?=
 =?us-ascii?Q?wWCr1qPhgvx2gIyFshfkprUXqqN8XKBgtHz5jHUpxglLp/bL6MaergdvuiE6?=
 =?us-ascii?Q?dSsgK2LaM52eFcwFMSZOfrPTWjT8wkz5KUb8Q7BRqYxaIrUf7muNASh5Gjye?=
 =?us-ascii?Q?V/DBKdMKh1Ktn5Piwejycldu3CapnMkmubAcjHsNJJtwjrpKybd6enaTeoD3?=
 =?us-ascii?Q?btgTUs5b3CwXElk9oilWdnAv4guOJWbR5uONd5TIphlwFtL5yWNwEucPFNX2?=
 =?us-ascii?Q?SLeXmmPv8/3lqK7NQDYo7lBQy8rmiYJOU5nX0uiSCR22A8Npa4GgXTPWUSWj?=
 =?us-ascii?Q?8IEkPWQW9+850Q4j8cDGkmuRG/2efiYb/Rb6JfbjveRU+wLqY9S+lza08HP+?=
 =?us-ascii?Q?tDqF6ByjRQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769acb74-00fb-434a-a884-08df17876224
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 02:23:55.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wwr2OAo6mDrwDmqVm0V17hTLPROSra2KU9LuMYAnqplw/6XMikMu0vb8m6PCWDvlAbPSo7sSMGUDgGLuW5jLSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8224

From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

A Partial Region Controller can be connected to one or more
Freeze Bridge. Each Freeze Bridge has an illegal_request
bit represented in the freeze_illegal_request register.
Thus, instead of just set to clear the illegal_request bit
for first Freeze Bridge, we need to ensure the set to clear
action is applied to which ever Freeze Bridge that has
occurrence of illegal request.

Fixes: ca24a648f535 ("fpga: add altera freeze bridge support")
Cc: stable@vger.kernel.org # v4.10+

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Taking over this patch from Tanmay.

Changes in v2:
- Add "Cc: stable@vger.kernel.org # v4.10+" into the signoff area so the
  stable-kernel rule is satisfied (reported by kernel test robot).
- Remove Chiau Ee's signoff as he is no longer working on this patch.

Link v1: 
https://lore.kernel.org/all/20250311151601.12264-1-tanmay.kathpalia@altera.com/
---
 drivers/fpga/altera-freeze-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index c24c976117c8..2591dcc53d83 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -51,7 +51,7 @@ static int altera_freeze_br_req_ack(struct altera_freeze_br_data *priv,
 		if (illegal) {
 			dev_err(dev, "illegal request detected 0x%x", illegal);
 
-			writel(1, csr_illegal_req_addr);
+			writel(illegal, csr_illegal_req_addr);
 
 			illegal = readl(csr_illegal_req_addr);
 			if (illegal)
-- 
2.43.7

