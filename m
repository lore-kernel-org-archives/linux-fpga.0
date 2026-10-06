Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0C1C28E;
	Tue,  6 Oct 2026 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791254086; cv=fail; b=Ug+KYpgQHRoPJfxt1vhjVrFTI/wrGMtrDbunJgYzJUYv9Gj43PZU2NAAobVziEi7rjUhMX5GpesYQhX9tRelhynnAxBuTv1YXnQiZZiobUo0bF/Q0AK23votY7jpRbG78hNBXWCvEm2SqDZjKIkMttlMrAphTCGtAYxuM8/1dsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791254086; c=relaxed/simple;
	bh=EM9m1txEsT6Imw3jBQuPKEo3f3KBlfkmvGBFEqkvA1s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c0Lg7JqRdjfpSn6Yl0QgOQppaymvuucOBSbG0DYIa9i4r5ZN4s4EjbhTLMCw6ClELwwXqFh2Zf8u1mnx8KBj9CzORO9n9STPkDSz2iGc1ejAcvHcyeoyukVXINfFuxD97/+W5/Gpv1/qHTdUoq9BicTiQ1PvHcCH2I924eQABFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=uTD7Kszm; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="uTD7Kszm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1a0uSxmtKMlmYd88uN/7A/k9tUP7ybJoOIMEoSLRU6/bZNaBSW80vHpP7PiiEk3zPTfqqxHHGefgEZUH7gtf3bTHIWcYgSSmTjucD8V6NJhQQPp6iWoT+a662VP2KKhNu+E7WI1kC3k1ZcsjF2pfQDj+VQjtAttdOLmjozB+I39ts2DU06SC4HIpS3AkfwKNHJk7kD+zWIAGHng7FkBuYC1P2Z8+NQFOdNU3Q5oYXxqJHqDNt8u/dJMOo98YqYzm8dEbyOrQ/zaodZPVdenG++UAl8xStmKZD4PggUXcaX3M/rjqZWYR3CgHcigmzJp4jfHbXNhFzMU0pROgI/qQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qJDWTqmvyqtGHD4M4A7Hq1AnyLvTmHM3XnZ//+WxsI=;
 b=ZNT+qolvtIJOwQu1bMa4wkl0aEFQFv2gvNnGCezLjkQgT9WMpLnygsjGgWbftHJ7W8w+toRG39jqZR7brdluLgSl+8KwWW6wXjNXS/+9fhLitba/CA+7xVNBtmbVh22RQFrrq2cdk/I93oEzLwvug7xFQo/OwhGSbR/Sp9BvXIl3ydvSsoQsugfPI858ObX2ijKPGPCgJRDUIXcmtjzloNxQgl4R+iQNqPkmG26bNMXXKbrS9pOts6nza6JlPtkPMSu+daWspp/+8rQAgM1P1y3YBY62srFj2lrvwHpWtZ/rthiWDMFcdAbZo0rviZ5rcXNlGe4urv1Fj8HDZabGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qJDWTqmvyqtGHD4M4A7Hq1AnyLvTmHM3XnZ//+WxsI=;
 b=uTD7Kszmyj98nu5urdxf/7QDdOBfUaSmdQB1mMtP+ZvybPtsezcMb6IrGQEKVMAxyYOQsdTjEuuvowtQhdPW5RzLuy8MvWm9y8GUuDV+0o4PFpOa0pBTRQDovlFeEFMXMQaUEUZv1fmOyTO83eW1foHhSUDoQFjmRp5n/uXxykH1Q7JCHsX/OmVSonW08DUVHZ5megN4z203aY/q9MY8A1kl0W2A9c9ozKfYTyARyKyiA7NTgAY5dYsmo8N7LOVQnNnbhoBlBlwI1yHk4HndZYV7JfnKKl2uEz4NBd6MX21pDLpHZrpgyhrWnsgNkOwreih/lvioquAJZ6qJFeRwGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ2PR03MB7378.namprd03.prod.outlook.com (2603:10b6:a03:557::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 02:34:41 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 02:34:41 +0000
From: tze.yee.ng@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Alan Tull <atull@opensource.altera.com>,
	Matthew Gerlach <mgerlach@opensource.altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] fpga: altera-freeze-bridge: clear all illegal request bits
Date: Tue,  6 Oct 2026 10:34:35 +0800
Message-ID: <13856736bdb808b64826aab337d9919abeb3ea5c.1791253862.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::8) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ2PR03MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7aad66-cbef-4167-5aa3-08df23525ff4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|18002099003|55112099003|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	MxIQZmwcbFQyzOBULF6jazlDt659tW0CTVU886G4yeZ9hQdKJeflE7kCdO1Vi9fwF/lZZSsfKqH5ln1oqYvQ6FNCq9kIpJA1H2v3slrNQiSJDXtDMZ1GsDeHKSRTl9uMmzqR1mDRzV0GTakIrGTpQ3SmQ+eJBPe8xHXuUGAubyQicWdP4b534Ksl4H/B2RW+mGi/eEQ3T2NSABMkc+5Bn53jTGix1pUgZ+GmOFglhIyN1xRVRCyABzgsnpStdeA7BD0dTXKKe/YK7pvh5kdOiWMlNy/GbVt0mt+0GSJKG8G62YgHUT/rTnfw4nizk3CbJVxjtXCDE62C+Kgt2YSNPuS4Be3WNZXihHqpbSpDlmrxS9poTfAXcGhbAleAfm62mwMVy8yK7GDOW7Ta49/alqUefDYbyKga0TqTz+K53IHJRG08iVyPJPI2OaXfRjRn0X6S5Xx/hXj8/A1ARCHlYlmK2VASbn1pjoNhPXTs1NQCwEn3xjbpwlO0KQkEAvQe9P8hLS3QJUml6MMdiT2Am1znoK0g4bBRutpb6r5TD1vLpdcRgYDQ45KDmytLBtnkAklXd+NG0uFujRO433p5a8mYuImLyh7+M9EIi1IvpVev0GVofPvjCPAjSJQmqIYK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(18002099003)(55112099003)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hv6TNbmTmY51ML16RVyo3zhyyhdTb86jKcQAXzrOBVEEWgrjmHe+4KMpNwfe?=
 =?us-ascii?Q?4t5csPSu4cxABbInYgzLCordPD2w+d8kLtPHqHiSI5kx4Za3RFe9uBZiylyP?=
 =?us-ascii?Q?GOjxgqB0oRVF33jyFpmaFJJpgduPC9+BEw+hhpuG9SzYa5Ig+NnBAZOP9g/q?=
 =?us-ascii?Q?d8lmK6KYrTIhCvgWfJHboku1vk1vaMw7H8Qpeme3eaVVcTWx0sf9qW2R/QcY?=
 =?us-ascii?Q?Io8FevoC8PbVotAUhJKf008xzWHGPmEi6TieIaweVOYahOL5FeCi8pvSys8R?=
 =?us-ascii?Q?ED2BcBCUVVujfHwcFaiDOMxBgz64Sq+KaPrqQSoECmg5uNcIxbC8xZIY0vdT?=
 =?us-ascii?Q?GZI6iKheQQBgHlv202jmzfpNdU/NpERwWFc9eVwIIM2/NYm1flBMtM6yUthC?=
 =?us-ascii?Q?7TypmBdNx3R1AD43kEIpQi3DQCCVPFhBAuqP2uE1Ow2hQ6Wo1bR8JjJBmyx6?=
 =?us-ascii?Q?TiZ9TOaQc+VH46+Gbpx8sCfTIbZNMEMGojMUqmTHvIRYWF3TyN0WbcqpeLzY?=
 =?us-ascii?Q?fbjzcLZ8XoBNRjStoPxIN5LlXvoxeU3SgJ1b6SFaVod3xSjBu5dfw7wHbprY?=
 =?us-ascii?Q?DYzQ2bvn1FApJeTejZXcd9KVCLnHbURLsywHkOIlQUUC1OZ+Rcr4QWPNUwqv?=
 =?us-ascii?Q?rJ7s47tJkVM15ZyOO6q2boO25fG0BppPzyp0aSn2iCW0CmAcpfVly85v+TvD?=
 =?us-ascii?Q?GeopA68xdo+nlG3ii00ItPL6PF8uO595pOXWKW+BlGNSrK2yoAMztla9fSK8?=
 =?us-ascii?Q?GqRJweLa3++fKGaHXpzR90GK7ce/8kYny9Ztb2jwkFqYjG1IF9KUGZvJh5cs?=
 =?us-ascii?Q?WW4+IA4ScTFu/547tE7SY15z/S41vO3cv/785dHPmbenBLj+iAGYPo4E1fSE?=
 =?us-ascii?Q?Hsopq6lZQhpwwNHqBNIuv+Rxokj+FZEex/NnsadCwb9jO/380yf6NHyj0om8?=
 =?us-ascii?Q?mrpmbIkKcmODba5GkgqSHbz8AZxkI7WOh4hzyTS+1hORaYfSwH8lTwGYA7b+?=
 =?us-ascii?Q?jr4TzMseRmf0U460yo+sVg19Vaz5LggJVnev6majV4SpG8awl/bcLl0kwv/A?=
 =?us-ascii?Q?Tkj2uRblMEGHBuIVwocwLUYT1db98CCAtz9yVCpMDJlftnY9Oc/x7/kAQevO?=
 =?us-ascii?Q?k3FOAfE9Q6i3KiMMOr0rpF28DbSqEMbl3UzXj7e0COvSjQ3bqbBWPN+5huq/?=
 =?us-ascii?Q?6wQ43Jl4fDb28zFH7+vZezCzHSyZ/SEX5/a3t3Fr2rrDT3GKGFIlaQ+HbZte?=
 =?us-ascii?Q?g0nz0Pvl66rVs9n4IknanZLAZuDAuFDVEixo8/lFGVU71Rpcw8avSkVtUmTR?=
 =?us-ascii?Q?IyUb2tM+FE0TnyJbpdcys+Eq8NA59VIxqikbumhkB/sP4cRbr2Pqyx9sEV8q?=
 =?us-ascii?Q?TYfBOiRKMQii6gzJlwC7ObC2cT1Lrdp/dDZeNxAWUQpoaibN+XqZWO0BjLSH?=
 =?us-ascii?Q?I0zOQ4Gezl36K/F32y1Uzivrh2Ya9HNR/ful1HD+YTWRkAoMdVMQg6sIGZkz?=
 =?us-ascii?Q?U3FxyFApFzUARmMR4kJBi8HNDeoY/7Wt+sOMRMisbC/guv8ebIN6Qi+WO9xG?=
 =?us-ascii?Q?uk7Y7Blat52sW41d6+kJQAc+hfbNTBpzq3Q8Bi4FiaI7p+SJpZwcnOrmRZCu?=
 =?us-ascii?Q?IHtiGG1Qb810Z0DJi4Sd5JsxTaLG0u4IBWh2cUPaUvnXidKoFuDtAvi6rgH7?=
 =?us-ascii?Q?tG8v86jIiP4oANYh5fHvVZd/sO64+klupwZe04XMJw8weirm8xlsACgDnmcm?=
 =?us-ascii?Q?TcqISasUQg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7aad66-cbef-4167-5aa3-08df23525ff4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 02:34:41.6680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyyVarPzO1iGqS4WpWIrhK6/nhRaaek8hE0wq2flGSx3qpsF85wiGH+r4yV8dqxLp06W3gm6OwIQQ1METIyPzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7378

From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

The freeze_illegal_request register is write-1-to-clear with one bit per
Freeze Bridge connected to the Partial Reconfiguration Region Controller;
bit i is the bridge on freeze interface i. Unlike the status and control
registers, which act on all bridges collectively, this register reports
each bridge individually.

Writing a literal 1 clears only bit 0 and leaves the illegal request
latched for every other bridge. Write back the value just read instead, so
the set-to-clear applies to whichever Freeze Bridge reported the request.

Fixes: ca24a648f535 ("fpga: add altera freeze bridge support")
Cc: stable@vger.kernel.org # v4.10+

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v3:
- Reword the commit message in imperative mood (Xu Yilun).
- Describe the freeze_illegal_request register layout: one write-1-to-clear
  bit per Freeze Bridge via the Conduit Merger, versus the collective
  status/ctrl registers (Xu Yilun).

Changes in v2:
- Add "Cc: stable@vger.kernel.org # v4.10+" into the signoff area so the
  stable-kernel rule is satisfied (reported by kernel test robot).
- Remove Chiau Ee's signoff as he is no longer working on this patch.

Link v2: 
https://lore.kernel.org/all/2fe34c2dec61150a39d21e067521b0acc031247c.1789956938.git.tze.yee.ng@altera.com/
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

