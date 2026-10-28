Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793184030;
	b=m+GOwR2GRtKW5Qjrosc2t6KU9NJjDz07it1/TN2Xy/EOct7NQgQD/S/vuGnrg+U+eN/J
	 FrTQaxFpx6UeQbIpKC9ZhPGdHTA+MykcpM8vYfdHb6AxRez3/yZX9meyMgdIfVdwXzobg
	 LSmcoa5sNBueRmIgMEZbWzakasg3lOW2TZO/otWzCGMaPgeA1sfZtZ3nl0SJqWKrIx7+J
	 i2Pm5iWWzslfIJOOzQoyYBM3LeJgFUZD97gyYmlTQbRdrsy3oVfGRYsFX2Q7v+WHdcWer
	 2OevO3VXECFRUvaRXvMjGGUqyxFS1TCE0+6CoVJ4FFrG2WiTRWIItaHFcVaqPwGDXGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184030;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DeCDyZERf9uwt5VkYqNIkgoVrYd8ZUPsXRJ/hBYo8Uk=;
	b=cOkkSDSXdNdDAQgboyNGvjSeeUJoH9V3rVY2vUnfzXuqxlJRtjRpZavR6sB0tFwhkYvj
	 rNBLct5+sxIUzwspEZ2gHsQLFZM2XEbbbbO0IoMCptXZVfNdp7EkBLoyky5baf4OLNP7Q
	 c3inJ//cDwhlF8PbCH/5kFCgXfcxhkIz55mlMQJIMtzcd80uPq+/D+nidbzwbh6Q6Ls8H
	 IHmxtxE1f1co2ctt6RagLZqsG9XmUhClTX1cYHaRYxdwGbWO1Q7R9/OOEqx1pBzqTtf0I
	 mb9JCeMJ70pMQ7l9x3zZclG/pk3q0aNMDKDpuHI0f2nsYkhuJDKV/aGPsh2hBpu8p3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=UYvyEmGa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.62
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0618E606A31C;
	Wed, 28 Oct 2026 10:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0618E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=UYvyEmGa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ao44hjyzs+t9FrIkzKPd6J4bbzUd2pCV8bLFU0s+M7+tEekHs1PuKWuSeJKJLOSMKE0buu6GeHgh5JsOJ/CwvgCH3pHXnxLgzphZFfAKAWDRGzsdrnkVWxfFXW40f/kY7O0DoZLxB//ZhuAJDPIoR+yBEIRCiY4xk5/+hmHJxV+4fcVlVhV2gEjkd6w03VXCTiBpTQqe0zMZa0y40j0ttkCXP2frhyfIyDGV+C9Q0cRz6s2+SzDnGjt3ytACJAg37TJ4YGkubETcL3ORq8XvCRQh7u/ZHLy55hRtrBLM4EOI54aK12VJ5K4YVFweNRAcHQvluwj/gC1D7SaceVPh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeCDyZERf9uwt5VkYqNIkgoVrYd8ZUPsXRJ/hBYo8Uk=;
 b=IRn0/oudPrmvsBiyYVwM/RiCxrxe2N8tapjdTAEKhVxHwVx1FkmFn2gg9P+yfpWScHh0NS/oRLIpUMcXnco9VCLOYJOO9nHnr4jd+y9ISQkSWwWycs45VRdLCd/qtOj2fy/8ozjnYgUdRWYrwBaTS9WK90cMGxmq2RzYsXg9wTms3K1wYEey9+qNJspGsQxdoK5Kgr/Cc/EJWKwaRgcwJpGFQubpYxAZoKvGLhJf+H8vTkv8lHzQmx2Dpq9jswdyj/o+r2kziyj0+yslegTv+DZVz0jQsm3T6g6iIanFSOq7TMH+2nfXA5//j5DyrNn6we/MqSCr1CiMlEp/5+Jlxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeCDyZERf9uwt5VkYqNIkgoVrYd8ZUPsXRJ/hBYo8Uk=;
 b=UYvyEmGayIoq98n59edVCvV8tGEB6B1vJbbiwU15VWDzBn+Oh+3xdR6ximSPvyK/tOXuh3hOYH4SKL5bMUMbrWSSyuWHaPSOhVsdCtcMKqGQy9n/M61SIIlbqaCFNfl1YspjtLzY4OUIf7O4UX6NkVbo3STzde4kmzCozJMPNgwh1H5iXwO9gafWzyM9RixN/yHmnrVRxdIxpF1NLpyFa79hMlmq1NhgpFhXQpVmRZfz/EhCpr5JY1Y4DE+oL8r3Bpq8l76ix6I1M1wHVdkCcFXm6wqo7oVS/KgPx89p/wXoe6sNo8YU/FGc7wk9k3/vWDoFHn+qlJCA2E9Ss5EG3A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB7066.namprd03.prod.outlook.com (2603:10b6:510:29c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Wed, 28 Oct
 2026 10:40:23 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0522.017; Wed, 28 Oct 2026
 10:40:23 +0000
From: tze.yee.ng@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: muhammad.nazim.amirul.nazle.asmade@altera.com
Subject: [PATCH v2] fpga: altera-cvp: Add Agilex5 CVP credit register support
Date: Wed, 28 Oct 2026 18:40:19 +0800
Message-ID: <20261028104019.21225-1-tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH0PR03MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d87a489-6daf-4afe-2408-08df34dfded0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|261026140227099003|11063799006|56012099006|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261022113327099003|261009223027099003|261022105027099003|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JRsBg5lFd6QZFUxMxdTS0Yv7FUbKCNL3S8cUExajooHJWTsruKPudUk9QcEVPUvqwyn5tebn5ihsP3Qv0JSRTgkvnQUKu6U56bzS4sXVY7gnFx+ZffC1J+/vWYwblTe6cEkSXcMQpI1cwBq8GUlt2eu7nOrhN4Ez9nMfoD+E3LnmVpI3/5yIipuHkjpqLyOMo1cuy3dloO3pyviZjG7lc7YjP1ZJTPB1mEVzjTFkwyf9kFKTDWdp24QQ+KCVUzLhqWdyAvT3HG9ceRtOMfpOom3jcxPZcB2+Tu9Sg3zdcnmJO90XJBcsZ/pGuq/0NBRM5uu8OYX8k6MiZIx9ETKtEXE33uc9ccYbzH9fOSLZMGL2moIysNhLAmjHQiDuTm6aRZf68lN0C3sTUUmFnAyM8ktVnMYh0K0PKQLW9u9YGk5XVS2uZ0EYxtdG5Zza1yc0m7dQeJS02qcmOsOPxP7Z5Dk14owQPlsNtHO430Lh5/NGO6I9QJHJcnk0my7Op2KU+hrYZMJvbp5zBzKOEsq9mU03Q2KQafemiQ7IFUgqBbUKMS9nF5eBYKRyWSlI4Mnytv4G+JZ3s7IpNYrCJsobnNw2GMIxYjQrwf8ZDsg/8Y8hbD7sej/U26/oHY3Bwy83
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022113327099003)(261009223027099003)(261022105027099003)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p9N4d6q1CJTJuHB2sWGJIlZtSVaiHv/egQjRy/OIPSmbV5X4WQbzkLVQx85B?=
 =?us-ascii?Q?lEWXc/dZIknyDLuZMb2EBW+ZfjwiDNW/9GEXkw8sVZ6cnv7IA0XphHejFt7t?=
 =?us-ascii?Q?GRl7rQEobGpd80DOT5rwJBYyoIBR5H6H9np2WQ27kdNUSt4QC2eb474qcihM?=
 =?us-ascii?Q?XFY+4Scn508BWXEZ6PuN1JTJ2nPopevOIa3BAvAiaqQRQ3ttJfC5H/8I7nv2?=
 =?us-ascii?Q?tIIBe1/5+WVX8FuNG4uJX9QMuy7cjoDHkkgFv7g/6dIyNqKOlufRBvF8+Ozo?=
 =?us-ascii?Q?u9NjP6nEcHg9bBl1q4yrs8xLqzYplXUgUKYq12vU1qJXrN371JigynzsCFgl?=
 =?us-ascii?Q?fVuQIVLowFrKqHOFJxKjBHKbVw4ScsURJwZ4ovGBJZueL8+Lk71KwTr8uyNW?=
 =?us-ascii?Q?44cXJp6mY9fC6abPTquiQQ4e6zsyE6K0pfmJHiw8MeJKBKfJeMTpFUQ8F5C7?=
 =?us-ascii?Q?QHgetsveO1tyceZNXYN61+JBPG3nhyIE480kjT0tlsq7HeKWMwPbTpy6a7bI?=
 =?us-ascii?Q?xKMO8dQxYwZvDVhcrJeyNSNp9xi4H9R+0pyM7dH/OMi6SCdIfCsduJKgVEsb?=
 =?us-ascii?Q?EH2YRw2sWjjsw1FCcpn1Xq+xV9z03rRXqDZjoEusUTnGi8Y6PeQgN7X98HKo?=
 =?us-ascii?Q?K6ZPe6yDnDzOxiy1z5gffbjP28X3KD0a3X7+uy7tJTbYeqY9pMRpJfVXOutY?=
 =?us-ascii?Q?GDF/dHhcLQp6vLpkjJvU4dniHnxhER9ZNY69wdutqCQbz1cV1j3OAJyFsTU2?=
 =?us-ascii?Q?pi1fDiQ+7BP0SJl/QJ56GTnnly1jsmfxLg1TouTxIVOyKT++9qPuIw1MVOyD?=
 =?us-ascii?Q?czTVtPnmFxxK6mW3BFy3uex/vOU5bRiXPkg4u9lxULwgD8Ddx4s8Q/re2ZGn?=
 =?us-ascii?Q?TYnFucZJOnEkOIJDpr8pTo/zsm13SUyST8r43l/Tx0VRJKW8TxFW0U8KBdcg?=
 =?us-ascii?Q?gw2K5RavICRw4mKQtfUdt746MINs/kcOqnw/nwyViGEM8vCYjSOhayKm8AKN?=
 =?us-ascii?Q?ex3+vCnC78y2RIBKS/AjUgXTvHMdc2H0jWtxvitaq/Vx3ZjZ5IYDLxA+pU+5?=
 =?us-ascii?Q?3kZlR2CKbPS/uJ1XhWIfT2i+pYLIzhWFFnmlY2Cvve/m0JZmVcBV7GMmcKoY?=
 =?us-ascii?Q?a/YA3I0aPAjzMzWhpKPrs8qkui6XiwALPFZqwy8jOSsd+LfEC/kX5a9W8cWb?=
 =?us-ascii?Q?eaqm80igLvrtOPiavQlafGWPa/DxrmMvo+T1adnZPHoBqeCkF5euahs1/Iiq?=
 =?us-ascii?Q?CMFzr+i38nqL7QDRas2NXqHr0cNh1d6oECZXV2VhoLnXU8Pi0f5JEmWSa6lo?=
 =?us-ascii?Q?ie/aUFYqRGXuaPzpZu6j717jHsuAKvAo8isELq8VBvq4MOELrwhADYdWgZ6V?=
 =?us-ascii?Q?LbGj2NeUDaF8HnMOkMB4KmdxMgzG758Lvlt97zgt2knQYXT/Kh62jaR49EJB?=
 =?us-ascii?Q?q5meM6YL7NqQLe7Autaby31Wyw4Ehco93ztE5PYe820csCx+2l3nkpd4MLWh?=
 =?us-ascii?Q?BsPX820OwvsilbfbH2rigvEjsTgWwdZh2StPkF5syMZj6OMP9IGcu4xRbQzx?=
 =?us-ascii?Q?jTxxosI527/FIde7jsKId+RLmkcD0CqX81+k64+k+00i7eMicH9QuWC/GL+K?=
 =?us-ascii?Q?IGDckuoYe/pNRH0t8lbfKlvqNCtv/Gv9ltHJfInNEABvuMx6nzrH/OoaTBx3?=
 =?us-ascii?Q?6VnYyCh76DqM8Tq/8srgo1sN1SyDtjj8jtQmVZ+dFRuHUxwd4owR86tMlf/m?=
 =?us-ascii?Q?iEMdxiOrlg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d87a489-6daf-4afe-2408-08df34dfded0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 10:40:23.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usB1KGhPN1RsAJVpMfM7zyqJ5q9MvqHbX1swKx6/Xcotuf99eRv+EuRbp3udjIfgkD28ydEDfzwqPTuyNWj6GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7066

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Agilex5 uses a different VSEC layout from earlier SoC FPGA variants:
the VSEC length is 0x60 and the CVP TX credit register moves to
offset 0x5C, a dword register holding 12-bit credits, instead of the
8-bit register at offset 0x49.

Describe the credit register differences in struct cvp_priv by adding
a read_credit() callback and a credit_mask, and add a cvp_priv for
Agilex5 using them. At probe time, read the standard PCIe VSEC header
and select the Agilex5 cvp_priv when the VSEC length is 0x60.

The credit comparison masks sent_packets with the per-variant
credit_mask so it matches the width of the hardware counter. This is
the same comparison as before for existing devices, whose counter is
8 bits wide.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Note: I am taking over this patch from Nazim Amirul, who is no longer
working on it, to address the review comments. Nazim is kept as the
author.

Changes in v2:
- Use PCI_VNDR_HEADER/PCI_VNDR_HEADER_LEN() from pci_regs.h instead of
  private VSEC header macros
- Describe the Agilex5 credit register via struct cvp_priv
  (read_credit(), credit_mask, cvp_priv_agilex5); drop
  device_family_type and the SOCFPGA_CVP_* macros
- Keep the sent_packets comparison width-limited via credit_mask; no
  longer described as a fix
- Drop the dev_notice() messages
- Rewrite the commit message

v1: https://lore.kernel.org/all/20260619034327.26966-1-muhammad.nazim.amirul.nazle.asmade@altera.com/
---
 drivers/fpga/altera-cvp.c | 57 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 507e29d3a79f..d5f53965c744 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -23,6 +23,7 @@
 #define TIMEOUT_US	2000	/* CVP STATUS timeout for USERMODE polling */
 
 /* Vendor Specific Extended Capability Registers */
+#define AGILEX5_VSEC_LENGTH		0x60	/* VSEC length, Agilex5 only */
 #define VSE_CVP_STATUS			0x1c	/* 32bit */
 #define VSE_CVP_STATUS_CFG_RDY		BIT(18)	/* CVP_CONFIG_READY */
 #define VSE_CVP_STATUS_CFG_ERR		BIT(19)	/* CVP_CONFIG_ERROR */
@@ -49,6 +50,9 @@
 #define V1_VSEC_OFFSET			0x200	/* Vendor Specific Offset V1 */
 /* V2 Defines */
 #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
+#define VSE_CVP_TX_CREDITS_MASK		GENMASK(7, 0)
+#define VSE_CVP_AG5_TX_CREDITS		0x5c	/* 12bit credits for Agilex5 */
+#define VSE_CVP_AG5_TX_CREDITS_MASK	GENMASK(11, 0)
 
 #define V2_CREDIT_TIMEOUT_US		40000
 #define V2_CHECK_CREDIT_US		10
@@ -85,6 +89,8 @@ struct cvp_priv {
 	void	(*switch_clk)(struct altera_cvp_conf *conf);
 	int	(*clear_state)(struct altera_cvp_conf *conf);
 	int	(*wait_credit)(struct fpga_manager *mgr, u32 blocks);
+	int	(*read_credit)(struct altera_cvp_conf *conf, u32 *credits);
+	u32	credit_mask;
 	size_t	block_size;
 	int	poll_time_us;
 	int	user_time_us;
@@ -223,24 +229,46 @@ static int altera_cvp_v2_clear_state(struct altera_cvp_conf *conf)
 				      conf->priv->poll_time_us);
 }
 
+static int altera_cvp_v2_read_credit(struct altera_cvp_conf *conf,
+				     u32 *credits)
+{
+	u8 val;
+	int ret;
+
+	ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
+	if (!ret)
+		*credits = val;
+
+	return ret;
+}
+
+static int altera_cvp_ag5_read_credit(struct altera_cvp_conf *conf,
+				      u32 *credits)
+{
+	return altera_read_config_dword(conf, VSE_CVP_AG5_TX_CREDITS, credits);
+}
+
 static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
 					 u32 blocks)
 {
 	u32 timeout = V2_CREDIT_TIMEOUT_US / V2_CHECK_CREDIT_US;
 	struct altera_cvp_conf *conf = mgr->priv;
+	u32 mask = conf->priv->credit_mask;
 	int ret;
-	u8 val;
+	u32 val;
 
 	do {
-		ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
+		ret = conf->priv->read_credit(conf, &val);
 		if (ret) {
 			dev_err(&conf->pci_dev->dev,
 				"Error reading CVP Credit Register\n");
 			return ret;
 		}
 
+		val &= mask;
+
 		/* Return if there is space in FIFO */
-		if (val - (u8)conf->sent_packets)
+		if (val - (conf->sent_packets & mask))
 			return 0;
 
 		ret = altera_cvp_chk_error(mgr, blocks * ALTERA_CVP_V2_SIZE);
@@ -559,6 +587,18 @@ static const struct cvp_priv cvp_priv_v1 = {
 static const struct cvp_priv cvp_priv_v2 = {
 	.clear_state	= altera_cvp_v2_clear_state,
 	.wait_credit	= altera_cvp_v2_wait_for_credit,
+	.read_credit	= altera_cvp_v2_read_credit,
+	.credit_mask	= VSE_CVP_TX_CREDITS_MASK,
+	.block_size	= ALTERA_CVP_V2_SIZE,
+	.poll_time_us	= V2_POLL_TIMEOUT_US,
+	.user_time_us	= V2_USER_TIMEOUT_US,
+};
+
+static const struct cvp_priv cvp_priv_agilex5 = {
+	.clear_state	= altera_cvp_v2_clear_state,
+	.wait_credit	= altera_cvp_v2_wait_for_credit,
+	.read_credit	= altera_cvp_ag5_read_credit,
+	.credit_mask	= VSE_CVP_AG5_TX_CREDITS_MASK,
 	.block_size	= ALTERA_CVP_V2_SIZE,
 	.poll_time_us	= V2_POLL_TIMEOUT_US,
 	.user_time_us	= V2_USER_TIMEOUT_US,
@@ -658,10 +698,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	conf->pci_dev = pdev;
 	conf->write_data = altera_cvp_write_data_iomem;
 
-	if (conf->vsec_offset == V1_VSEC_OFFSET)
+	if (conf->vsec_offset == V1_VSEC_OFFSET) {
 		conf->priv = &cvp_priv_v1;
-	else
-		conf->priv = &cvp_priv_v2;
+	} else {
+		pci_read_config_dword(pdev, offset + PCI_VNDR_HEADER, &regval);
+		if (PCI_VNDR_HEADER_LEN(regval) == AGILEX5_VSEC_LENGTH)
+			conf->priv = &cvp_priv_agilex5;
+		else
+			conf->priv = &cvp_priv_v2;
+	}
 
 	conf->map = pci_iomap(pdev, CVP_BAR, 0);
 	if (!conf->map) {
-- 
2.43.7

