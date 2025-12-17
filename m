Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973E2BEFE8;
	Wed, 17 Dec 2025 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765951156; cv=fail; b=T6gL3Weg45+MhfgUMr1/kqFX4K4GOZMWQ1oZp6Y9rb1lIzYY/llNzPXV517BhQL9skCrrR7VgR5CaOWTN4zOaELbY47t977ziQAj5ivHb/zSry8xSCjgiwq62ojqVWQx14sGt3k5mpcuLeOZ+JUon4/mk0/0KMN9MgwrAs2mHjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765951156; c=relaxed/simple;
	bh=XrifncpW3zh8v7k6U7WQNFaBywBZCdJQI+TYI5ID5Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ArDbqlxdfYefMMjWM6MFMbm0syhUN76+0wbzkkOMGm9pyR4TulOElWxnUgSIKMfWZiH9DQhf2EWWJbDBqny9x70y6RTuC6wtWHa6nIbXH3wvmEgPaOnZZ6rKH4m9fjd1bLw228EkRYmSqFdWQYAmsqynBUp10RKpQg/Zxbg2Rgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=hYG/0fDf; arc=fail smtp.client-ip=52.101.46.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="hYG/0fDf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PngjSnEWAmMchWruLZ4YVcua0w0NWKNyYbZRO2jlqbQwQCw0tyc0RSZW5pFqGBdgHiQz+T2w31U8HLDsPufsPgvaJsTsKNX9+pHmJ7BzZYSt0zudP2GT4Tb+yafAV7kygKAINPbotr7RGq3riF9CkCQ+09X2mkELf2OVjsR7IlbXuD6cI3/YBsBH16Mbvij3OK+zlwduIh2vhdJbo7VecKNO8arZtksuaF2DQpWJpwU6XGv15BVgaXznG30RoYw0+sbjpEyY09iBnylLpMYbMHEdzyarKqQlPidzlvzDSQrisEleXZ4o7MXWvvLb0/+GQD7N0MMORtCzQZVhOvPsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNfAkBfH02ti6knVjRqr1s5Kp3vSR6/eJN81B+Tp2ow=;
 b=JsDrEfLcVr+Z++2w1FPRBTdBVDpO9k9qF61SCmKGPAmOht6JeUswrWYDO9aNdF+G0n4kHSXOm3HpuoTkGueoXWktFSs6Jbw/NMXYJPfGFArC4HWFVq16OWppoXEO3L1q0mMQK/NUHq9JTa78B709brRj8nD6W3JyE/JXfSsz8rtsalzqCfbOZD0ttfeR31wqOOIsX5utDFKpBBqR3We7wxK8n5SQVJ7eOIcHD40LG9+hJJKUnUe1JxJbaVCxL/1UjWBLgie9pAPqG0Xp498HSPOlGTk78CICP6OK8T1t5Y66VO8NNUeolRlnyghmdSpufqtfionQdQfjtEnq5CEHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNfAkBfH02ti6knVjRqr1s5Kp3vSR6/eJN81B+Tp2ow=;
 b=hYG/0fDflwLOPq/yi/MMDWR5zEWNeLfzkCQOaQaT39KDnoZjKBzTf8MFGQAyySRfW/eeuA5qLY5ppWrTX1tNT85R3qRypdyeu/SzmPeGnWUTZoXqc1a0mdD8UykwNjucoa91S+BQe/RLiMXYYATwAJQxkEmpQ6VCjUpy0vgfQ4lih/c8LrZE3PB83h3vKdqlj03Ul0pn43EVf52a+UsmjMuymOlFCyDyr2PHqWUMQKJ1qxwNhgaQB/p+396hqrexfKn0vLFONcMR4twYh7U6DVkhWWVD8EactwqnqLVFNguQMq2LfAwaPE0TixbPoe9dE811AX8tymiqn+7dyTMgDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB6235.namprd03.prod.outlook.com (2603:10b6:510:ed::16)
 by DS0PR03MB7582.namprd03.prod.outlook.com (2603:10b6:8:1f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 05:59:13 +0000
Received: from PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030]) by PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 05:59:13 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	mdf@kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 2/2] fpga: stratix10-soc: Add persistent SMMU-aware DMA handling for Agilex5
Date: Wed, 17 Dec 2025 13:56:32 +0800
Message-ID: <20251217055632.1776206-3-adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20251217055632.1776206-1-adrianhoyin.ng@altera.com>
References: <20251217055632.1776206-1-adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::30) To PH0PR03MB6235.namprd03.prod.outlook.com
 (2603:10b6:510:ed::16)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB6235:EE_|DS0PR03MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: a58072be-4e49-4bea-5b46-08de3d316753
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wc4wwYlfj0nTPOtbOlGPF3159rl8HL4v1w0QSD/RqqB8YZBF2dwH+M4T7iWD?=
 =?us-ascii?Q?j41f9BS3FIe3KdaXGkYIrPfnImWF65bjAlapQ+ZvnCw3J3kFJ0/GO7NZtUf9?=
 =?us-ascii?Q?IQwie5SR7j9WZX3V9TID/raWGQlItjFJ3kOWKTuNVRD/csSfeFse5VkPTqUE?=
 =?us-ascii?Q?s2+s1+HU70O3kZ4Nzu+aqhYvcIATppriQG337ysgbsSfASeiqEErZoGqCRPm?=
 =?us-ascii?Q?xHY90XvFlVDoA8I/CtIplRYto5qBeP20JXC2E4DHAhSZHXLTVyL1bqfJUdQG?=
 =?us-ascii?Q?dNGyByrfMswddAtKwoi4H+ds312JvekoTkI3+DPdqt/DH9TKzJVrOHEXWgl4?=
 =?us-ascii?Q?hhNKJgLhgDkMPYmPbw5Czj7zY+HmoAx1C7EPU1RPaVH5u3OzNZ/GX4HQtdDx?=
 =?us-ascii?Q?a8nxxoDozLsylzCX2LNZ2COUl3D9Y2UpihBDxAehZA7laZu+BIvj/AHpFv9I?=
 =?us-ascii?Q?VskeZKj33iEHdqZeoXjUZuKP20XBfw2zWpvZviu5m+POpCL5T/arhPx73V8c?=
 =?us-ascii?Q?HGGf0i8vvGtuaXmw/9cjkPRG4hHMIyLJ2QU1NZU0MTvhvxh9orslmjbDUDmV?=
 =?us-ascii?Q?SsOQJH1vkgMr+ioxAe4urznfBNFnQyGW0pAG5Pub2iEkTgfdGOx78ShwvAwY?=
 =?us-ascii?Q?2F7Cf9jRRx69y0/WJBce1lwebXZ/R77BNG2KScoThisbmo59jlgv63R4yEK1?=
 =?us-ascii?Q?y9uzsLiN/Scnva/KqylpYS3Sb3j9YJ/ATTJRzOU7aecSF13OXMs10qiUWuKw?=
 =?us-ascii?Q?vmOnSddT64LGf/jE7cbmxCb4cAsMwIqJeJfd7TrJ0zVYEIPPM/e1gI/Mp3Y1?=
 =?us-ascii?Q?leftlOlsh2EbOvX0HMEWG4jXcGVO78CybCptQFFEiUF4q65wPm/ZMuuy2hRB?=
 =?us-ascii?Q?zd6BNA4wBDj+YxtRclDaWKhU2yTvH+7rc5HodbsY6SxzL3DS/zUjgwvd6j2M?=
 =?us-ascii?Q?vS77RLyOhTotaJkRjDZwop0swkbBeV7KSJ4VPbrXf8S9kLzKjokaKvEQEGnA?=
 =?us-ascii?Q?VZF+LyTiYL/cZI6lxY9DasHZ2+dyYH4qDFi5/EvQPw99sxr4T28t5/ebYWJ8?=
 =?us-ascii?Q?Gt+n8c881+UpRe3Lu8f//UmdwhQFpSBtndqLykmIsqGj5fcnc4WhxktleOpw?=
 =?us-ascii?Q?a0UYyEFNwi5k2PlNMn6xmZdCYZTpEualPZ2HN8zD3bJroVfQgzhhUxcsZSy/?=
 =?us-ascii?Q?EL3tB1UmjYRp2eS/nwWyf4EzDgo0RNCfj38NZgoxZxmsSBOe8SdNCuDj1uGQ?=
 =?us-ascii?Q?93KQEVTwYHzwWexTWcyrJhOJZJvXnNxFySeYjSBoDSHXnvf/LB7BSMs6P0Jz?=
 =?us-ascii?Q?MzM/5MU0nz+xfz957BftkGcZU1oQYVHQLXxs7Ph7jGPYZtlp+4G7rrezGxQW?=
 =?us-ascii?Q?mxaTb6jM0a6LcnawMHlC9uhL27M4ckmE5sl07jVAe9ROQ0zVQMmSH6jItb1V?=
 =?us-ascii?Q?/6H9w/Sn4/VkJwi2ZB/uujmnJlYNTwjx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6235.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XDZoGjFcnJS3RvYA4eMthd8btBN6mxOvkWt5JDRbBqqJhu8/NBQEpXKKJKDT?=
 =?us-ascii?Q?shkZjF2b8s9M5ODPrp/dCOOAUqGpHYb6VKqvWgl556C8RqxYnEOD8abQG0qa?=
 =?us-ascii?Q?3KAWNjkeH70fBoA3zcWPndaYD81cvC56hSOGXgdgMAUPKHl6WJwyQvILVScT?=
 =?us-ascii?Q?FyRVXT6mrVSq6yKQWlKuG/4XrTtcplxg5MXL97tYMomEWapk8APGxU5Fu2Hd?=
 =?us-ascii?Q?v2uXLY6ExyfiqFX5h0lmWmgr2BzhT2s+vICMNrX/1j62sPD5QSf9cfcQli5v?=
 =?us-ascii?Q?UwkBdDQC1uhh5JhvjnST8uJKpen/HRfV4VH3qNtKphM22hCCj3hxTOL2scc8?=
 =?us-ascii?Q?lu2s+2J4CLtj/FBxXfUHW+8NncIPxY5a5sdjmzp3sJcJDyCqZPMksL8sm52q?=
 =?us-ascii?Q?+tByAGnVc77baNQqmaZBjasOvmrIBExtxgcPCIs79h4KLTOceO6/msZGvYKo?=
 =?us-ascii?Q?IqWT2KhSNglilSjEB2byBaWdia117AYp8260jsCvRz6GAHGaoPKJcn/J0C10?=
 =?us-ascii?Q?Wc8s05wVDN+zyJ4GrXDqctP65wcZw655RXryjPDcrlI0YjItQ8KVW5o8dmtx?=
 =?us-ascii?Q?gjcw0wIJ954fPxS4Nk1t0px6nV18IySJeZPOJr3epTzS/EswL1VE0x7JpIkH?=
 =?us-ascii?Q?W5szcAr1tTDXzMxe+Wi3rFmsZhbWEIksLv94yAxIhi9lIrEXIist8E8kSdOn?=
 =?us-ascii?Q?OG5Elex1SwgB5zQqUBLKfhllProoOEPlV/nrRbZg1xKYYkRG3LLVBXMr9erR?=
 =?us-ascii?Q?pn6/lx9/vMNFBvnePrhIPruUhUyDvIQ7Jt8g9gvDQQDd+fpRgOix5bB2pdkn?=
 =?us-ascii?Q?s3zeZEbqn/FmVHBfjbbVdeHPlkmVdGpF3KFViwQKMEOO31LXmv+7Fd2DLA9i?=
 =?us-ascii?Q?x2X67U41srIxwQAS/wrTrzRqe06P36t2EVugXbeHorzR2QGiCKcCN4lHsLOD?=
 =?us-ascii?Q?/rnrEWdInvx1/F+eNgi4EcMKzOus7T8SeN5/tvXlu33gLo3Z7QU4zHqeePf6?=
 =?us-ascii?Q?nyiNRWIW3KNjHZjhdy/WvfajWV4zq2SPpT0xHgj6fj65smKziZMdsPO6s9IU?=
 =?us-ascii?Q?DHoi1dmwUWRhdeshHZDneWPjG/ffs7gwVg5g3nKiKw+sVDQT49R32iTwGVbm?=
 =?us-ascii?Q?d67DsBIyR2T0Hl05qRHj3CpZwAH4J4VrghPnv6qCGH+W6RzPVR+OsklF2ldw?=
 =?us-ascii?Q?aXsRF26Kkc5HJa3Uhrvvc7RS1GpJSOhDuxwAzuJvMUncZVTk1Nx8R13PoLtC?=
 =?us-ascii?Q?UNosIjfnAtdz8e0tdO6Cr726w1UnyHYbgrSfa2r2oBkJGx7NHwuQD5bNPZ50?=
 =?us-ascii?Q?dFSWG4zCszsi5MSr/XRMqnqh9yBah1S7gmgV8bptuuOu+fZpWWv9XSKk6xhs?=
 =?us-ascii?Q?1lDzkZfQy5RBdN7F6D86JaVkiCI0s7zLCTeKAjjucBl/DZzuauTXHLR4hP1a?=
 =?us-ascii?Q?3NAId2wgCdPLZvsA/lXRV7G7Ua0CgAYoVCSfdNi0kJMDaNQkB3+0E0Bp0yQj?=
 =?us-ascii?Q?1gSk1BchFC3JyMQh53nBVia2Hgw1bbPtr7G+cvLwVrcZ3naM9xYu+KSfUlir?=
 =?us-ascii?Q?Oy9mFKMB66X5cOVMSF036Wd95PX4Fsbj9jJd7SfmllIq2ozaB9eBIw+Mq1BY?=
 =?us-ascii?Q?wyAdxfeKqufqjx9bshFiQd01XYPMfNWjnKx1sFQsAI+JHnWAqwpaslwQjmUI?=
 =?us-ascii?Q?0aglK8haFlbr9GjaZ5pKcCaSm1mr5EMCjUR+0iDkQeusvqPYY4/5qwWoDNSk?=
 =?us-ascii?Q?F9UoQiXZIZE7Vhl8/bWw3a4Ae19KyfY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58072be-4e49-4bea-5b46-08de3d316753
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6235.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 05:59:13.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mWiuRyAY2uWggcWBdAqHMcpMakYgO9KFqfVAU6gxZur468iGLn8R9GCAPgB9gu/wkt4JptVtmlqVz2QU7swVkk5LNmGpT1KVzy3WJXqpms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7582

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Agilex5 platforms require SMMU translation for FPGA configuration
buffers, but the Stratix10 FPGA manager previously assumed direct
physical addressing, causing reconfiguration failures when SMMU was
enabled.

This patch adds SMMU-aware DMA mapping and unmapping of service-layer
buffers and introduces a dma_addr field to track mapped addresses.
Buffers are also allocated once at probe() instead of per transfer,
reducing IOMMU overhead and avoiding timeout issues on Agilex5.

These updates enable reliable configuration on Agilex5 while preserving
behaviour on Stratix10 and Agilex7.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/fpga/stratix10-soc.c | 67 +++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 0a295ccf1644..e5128ede8fa6 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2018 Intel Corporation
  */
 #include <linux/completion.h>
+#include <linux/dma-mapping.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/firmware/intel/stratix10-svc-client.h>
 #include <linux/module.h>
@@ -32,6 +33,7 @@
  */
 struct s10_svc_buf {
 	char *buf;
+	dma_addr_t dma_addr;
 	unsigned long lock;
 };
 
@@ -41,6 +43,7 @@ struct s10_priv {
 	struct completion status_return_completion;
 	struct s10_svc_buf svc_bufs[NUM_SVC_BUFS];
 	unsigned long status;
+	bool is_smmu_enabled;
 };
 
 static int s10_svc_send_msg(struct s10_priv *priv,
@@ -94,16 +97,16 @@ static bool s10_free_buffers(struct fpga_manager *mgr)
 }
 
 /*
- * Returns count of how many buffers are not in use.
+ * Returns count of how many buffers are not in locked state.
  */
-static uint s10_free_buffer_count(struct fpga_manager *mgr)
+static uint s10_get_unlocked_buffer_count(struct fpga_manager *mgr)
 {
 	struct s10_priv *priv = mgr->priv;
 	uint num_free = 0;
 	uint i;
 
 	for (i = 0; i < NUM_SVC_BUFS; i++)
-		if (!priv->svc_bufs[i].buf)
+		if (!priv->svc_bufs[i].lock)
 			num_free++;
 
 	return num_free;
@@ -126,6 +129,10 @@ static void s10_unlock_bufs(struct s10_priv *priv, void *kaddr)
 
 	for (i = 0; i < NUM_SVC_BUFS; i++)
 		if (priv->svc_bufs[i].buf == kaddr) {
+			if (priv->is_smmu_enabled)
+				dma_unmap_single(priv->client.dev,
+						 priv->svc_bufs[i].dma_addr,
+						 SVC_BUF_SIZE, DMA_TO_DEVICE);
 			clear_bit_unlock(SVC_BUF_LOCK,
 					 &priv->svc_bufs[i].lock);
 			return;
@@ -179,7 +186,6 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	struct s10_priv *priv = mgr->priv;
 	struct device *dev = priv->client.dev;
 	struct stratix10_svc_command_config_type ctype;
-	char *kbuf;
 	uint i;
 	int ret;
 
@@ -211,18 +217,9 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 		goto init_done;
 	}
 
-	/* Allocate buffers from the service layer's pool. */
-	for (i = 0; i < NUM_SVC_BUFS; i++) {
-		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
-		if (IS_ERR(kbuf)) {
-			s10_free_buffers(mgr);
-			ret = PTR_ERR(kbuf);
-			goto init_done;
-		}
-
-		priv->svc_bufs[i].buf = kbuf;
+	/* Init buffer lock */
+	for (i = 0; i < NUM_SVC_BUFS; i++)
 		priv->svc_bufs[i].lock = 0;
-	}
 
 init_done:
 	stratix10_svc_done(priv->chan);
@@ -259,6 +256,10 @@ static int s10_send_buf(struct fpga_manager *mgr, const char *buf, size_t count)
 
 	svc_buf = priv->svc_bufs[i].buf;
 	memcpy(svc_buf, buf, xfer_sz);
+	if (priv->is_smmu_enabled)
+		priv->svc_bufs[i].dma_addr = dma_map_single(dev, svc_buf,
+							    SVC_BUF_SIZE,
+							    DMA_TO_DEVICE);
 	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_DATA_SUBMIT,
 			       svc_buf, xfer_sz);
 	if (ret < 0) {
@@ -288,7 +289,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 	 * Loop waiting for buffers to be returned.  When a buffer is returned,
 	 * reuse it to send more data or free if if all data has been sent.
 	 */
-	while (count > 0 || s10_free_buffer_count(mgr) != NUM_SVC_BUFS) {
+	while (true) {
 		reinit_completion(&priv->status_return_completion);
 
 		if (count > 0) {
@@ -299,7 +300,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 			count -= sent;
 			buf += sent;
 		} else {
-			if (s10_free_buffers(mgr))
+			if (s10_get_unlocked_buffer_count(mgr) == NUM_SVC_BUFS)
 				return 0;
 
 			ret = s10_svc_send_msg(
@@ -339,9 +340,6 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 		}
 	}
 
-	if (!s10_free_buffers(mgr))
-		dev_err(dev, "%s not all buffers were freed\n", __func__);
-
 	return ret;
 }
 
@@ -400,7 +398,9 @@ static int s10_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct s10_priv *priv;
 	struct fpga_manager *mgr;
-	int ret;
+	int ret, i;
+	struct device_node *node = pdev->dev.of_node;
+	char *kbuf;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -409,6 +409,10 @@ static int s10_probe(struct platform_device *pdev)
 	priv->client.dev = dev;
 	priv->client.receive_cb = s10_receive_callback;
 	priv->client.priv = priv;
+	priv->is_smmu_enabled = false;
+
+	if (of_device_is_compatible(node, "intel,agilex5-soc-fpga-mgr"))
+		priv->is_smmu_enabled = true;
 
 	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
 							  SVC_CLIENT_FPGA);
@@ -428,6 +432,19 @@ static int s10_probe(struct platform_device *pdev)
 		goto probe_err;
 	}
 
+	/* Allocate buffers from the service layer's pool. */
+	for (i = 0; i < NUM_SVC_BUFS; i++) {
+		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
+		if (IS_ERR(kbuf)) {
+			s10_free_buffers(mgr);
+			ret = PTR_ERR(kbuf);
+			goto probe_err;
+		}
+
+		priv->svc_bufs[i].buf = kbuf;
+		priv->svc_bufs[i].lock = 0;
+	}
+
 	platform_set_drvdata(pdev, mgr);
 	return 0;
 
@@ -440,6 +457,13 @@ static void s10_remove(struct platform_device *pdev)
 {
 	struct fpga_manager *mgr = platform_get_drvdata(pdev);
 	struct s10_priv *priv = mgr->priv;
+	int i;
+
+	for (i = 0; i < NUM_SVC_BUFS; i++) {
+		if (priv->svc_bufs[i].buf)
+			stratix10_svc_free_memory(priv->chan,
+						  priv->svc_bufs[i].buf);
+	}
 
 	fpga_mgr_unregister(mgr);
 	stratix10_svc_free_channel(priv->chan);
@@ -448,6 +472,7 @@ static void s10_remove(struct platform_device *pdev)
 static const struct of_device_id s10_of_match[] = {
 	{.compatible = "intel,stratix10-soc-fpga-mgr"},
 	{.compatible = "intel,agilex-soc-fpga-mgr"},
+	{.compatible = "intel,agilex5-soc-fpga-mgr"},
 	{},
 };
 
-- 
2.49.GIT

