Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794543193;
	b=cGaZgK3utaZxholrFUNNV6wPW9jYAjzlhYaiE1ixLCXO5NjlKJjdEUyhQzemH7ccp1qD
	 FK07Oi4TTLwdrzTUBTAUyjjbXt8JOMuaHXaUCdVfIg0cRddj34JSHUyI6jEd4Up3X+Pki
	 gcRDK8rry5Xc+AHs3Qby9cxwSq1i37r4P/jSoHvG1Wywtpr1/Akt9rlpWup09Jlkezq/t
	 8cJwhL/pPINZjh+dkfTuCxxPjeoYtR+Y7jObxaY3qjGYpt49GzCvPE1rRl0ww3BBrP7qr
	 zktFBhhvU6+Qic22DrhizhhX7iU8msZlKBX+9iutrsP667ZpC8gA6XhGvcQ0lgaV5pA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794543193;
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
	bh=HQ+EPrL4DmtROVjf9Xp4yEV3Z78ConHb97idzjvZOX4=;
	b=CtlzGp8EvSvd7f2xUkvh/pp6rqybgPRACYLWbIooqbtBcPrJHnVGHlcBWz84XWYvm28a
	 am6wikiLE9a3BDnMrCBHa3asWxJe9dUM9zO64D9bGxMClSAErhSDb0lsjeiN1gYHeo78P
	 pl5ON4ZJqideT5QykQtfhjxQstRcn0e/Vz2S/1PYjQEb6AnvtXf02lZWYgMq2ANZFPCyO
	 cBTHUZwtsyr/q3qTc/0Mo3ojY5ndY+6zNz1pOFronjr5GmQonAib1s0S1imFb52vtH5dm
	 HepYZXCGIX7A5yAkGksTd/DQ4Tmj5L5B0NJoyc9QoEv5AOG3PgeQmWVYn4I29qp75VQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=fmf9+vkn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.49
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77E606A31C;
	Fri, 13 Nov 2026 04:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA77E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=fmf9+vkn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhgqCUImo5EImMI4hjfXy0I6NKK4mzGDMLSbEvUZ911e7FjoLcxWNiYyJ0mY+q4V+VftuoDfX9OXOwAO2uhFH+9wa0HUOfa5o/ir4bF076VSQvHruCXqawVSLC+wJHcJq+L6djYaoVrxRp4b+ex2QVAcAxGrv2EQWWaJT08wp7XBXhrB/I4GsH9n//PwmRDExRQ62zvDhIbFkHajvp0uHJMo4vP+CEU+v0znpOLmmfKLdLQJvwJJEufeQVWP52iggcjAvYNgIBFuLGuMG31+leEnX5wzqWCHd5R8hDT5/yDzTcuUY/e+NMGwVGqDR0z7lAIicyBoFXf0eF4KMdEiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ+EPrL4DmtROVjf9Xp4yEV3Z78ConHb97idzjvZOX4=;
 b=NzzN0kdffsHflVtM8CaV0ag7WxNyUdvCOBZd7XxPGEIFh84oULSEUMb5S1zS5ev/520eaMh2DgC5tjpw376aV5o9N1XMlQXFBH8D28DoJu6FlmfBfsAXTKVDj3wP3mMHMcu9qCTXL/X30VmJJiXBa0b0Wd7WncQgd2OPTLZS+Dvdaz+VVixXn/iUJB8M+Za5YzgHJVDVkNqD+XywPORFovXgwsCtt7aNW3wcy89BnnF3ScQzelqpzD4g7bHmu6d2WQlIbGrp+1X+N2T6CYIZXzXBIPEk+eoJ2a6RaSbt+o07Vd1wOQ2WgkjbJfGh3rrnvHQznh2nfo39ZW4LiH9aGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ+EPrL4DmtROVjf9Xp4yEV3Z78ConHb97idzjvZOX4=;
 b=fmf9+vknRRq05z8ieSh39yULvx12xUGl+QTy558ZBiMwH8Lu+IvHJjf/Q0JKwOh1CAEcexIQhklM9f6aKejxWUFjXAzzWBjUF2yVperMgsO70+4nRlP5WHcTvKfatuYtxUzzpHlDM/VQgIho6zTtZlvw9krHNNjLK54ixnUKAVyPTF3iHOydv788MrbgPA9xlZwsFNfo4+oa+p9t+8507GVmOoJmOWp/kI1Zd883NjXrlni1eBINuJADH8hJccEZ3hSA75rRpQq6z8QC7V2dtYz/SxET2cBMMeH8GSRGF7Wz3AzB4VMonf+KeLoz7wFzlDcLRLzOMCFlFjJL+Ikmxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by MN6PR03MB7573.namprd03.prod.outlook.com (2603:10b6:208:4fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 04:08:08 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 04:08:08 +0000
From: tze.yee.ng@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: muhammad.nazim.amirul.nazle.asmade@altera.com
Subject: [PATCH v3] fpga: altera-cvp: Add Agilex5 CVP credit register support
Date: Fri, 13 Nov 2026 12:07:44 +0800
Message-ID: <a4d8640c6e758baa8a3b6c8a5643ebedd86c4d5e.1794533564.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0189.namprd05.prod.outlook.com
 (2603:10b6:a03:330::14) To SA2PR03MB5947.namprd03.prod.outlook.com
 (2603:10b6:806:11f::17)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|MN6PR03MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 04cf5254-5625-4970-5cd7-08df413bb932
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|55112099003|56012099006|11063799006|261009223027099003|261102123227099003|261022113327099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ChbmIFBOX/GKn8HeBSih118edDDjklIEojbM4kdqIcAs7ZsCAI3b76VTI4FlXY8iVV4J6sJ/+f/SbdhAM2fwqmj7q8Cr2LxJIvIyj9ex4+UgrYB5zghvCUbkfpszmPw63xOYHJF3X61/SlipJggJ0gfWPrmD/NTCQNJf8nk8T7SPC6h4EX9C5OCe8CfOMv7+mAilZPN1f0Ab+Y4nvBVzJ3bNOKjNKlRC5z/TFePHTvM8Yj7cwxdt8jLAo3hZbGrvFNKobprkEe5oT8J17O+Mh1TFK4UdlSOlrGj/vME9Oyjmo9mQjrDswVrvyoDHtjx9oMngp4xGAjqCIBzinFJRWPQh5Bi41UuOp/f8PUzljr6LPEu3yi95VgtE/8FeLJiv2aXxe0Bhtfzfz/VW1LefTiHC92VbNKUqTl/ZlqtZGGkq6E8ViiDO41g8rGzn6sO9OPOf/PtGbWnsJPVf3lZevnSpsT4lu5wlkhXUQQOrLso9zHuT7SEiMo5O2AIK1Hl9cI3UlxAbX/m3ZOzN6lBCwmaU6r2BecDdMc/rJBXEmqKdCcsS2LVilL7p0gmkV8QZ98/w7gyKrFQJeI+doaa52nAulP0OaD09hW2T3ZcrunwG+JqR4rJubIFXDCjGE74Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(55112099003)(56012099006)(11063799006)(261009223027099003)(261102123227099003)(261022113327099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r4Jp8I96zLgODDAAstOiARRv/YPcCijJOhTbN3wp+Crxohj1qb9PsTAVLxUT?=
 =?us-ascii?Q?zAC+p7yMg3Skj5Nk3wmTBZr44Ja6r7rQv0V+kYccOu2SEwNpIVXmPsKTMFnw?=
 =?us-ascii?Q?9i3WW4lrCmd1jZGHSiNrS76asW2qpTyDQrZSwgIXvpErEhtMUbMIqGn3/T0j?=
 =?us-ascii?Q?SG60lphLQ9ofgjeUDe59GxzhIpvH1ESR11tUIUI1+JnptZK7dP1GXilSXYH8?=
 =?us-ascii?Q?jq1uRHoUjFj55eQn0gCO8d8blRAENexLsLT/dcoaWMT4TxGzj7IgJwlcA1ja?=
 =?us-ascii?Q?Qqai0MfdIdLXFdW64NIaPZJmQ31EA9WwZt1UXUsoiI7Q9Rn/knRpieb5N0DY?=
 =?us-ascii?Q?6SszmOlnB0D+/5/RffS4IcQYgF/j6KHCE4Q8QkCG/TBWGsKU7mmJb41ZVPWd?=
 =?us-ascii?Q?o5L56deD8HrrsTdqfnYrJI0Fjknpn+e/YxW4Opcw4+umoa6NsxhUmgul5kuy?=
 =?us-ascii?Q?NVVPnTvp0V9aYseZDLdByWMruaxCUn96kTToovG0iPcfyfds1LbxsRg95Vo5?=
 =?us-ascii?Q?EvZVtlLqghc0P0o4LI2FYMIvaZ8ICGcZa4E0DXiuTsE1XjW7EFirLBKIiSWz?=
 =?us-ascii?Q?gMMyIKIhShGwg/kchj6lqsTZVcxdaEWElHwuY/KFlh/Tqwtd9OgvJ+ZLpcca?=
 =?us-ascii?Q?xNRZXx7VEAP65kUOh24wd23IwljCdm/k2SKx20RtuTVe2y+AIoqi4fcu27QB?=
 =?us-ascii?Q?n4Va+wwPCYfXEMdbZ/wBsSnLOcVO7NLdGqLQTbY9QN6VSfd8viVSNdLqy10H?=
 =?us-ascii?Q?voTCvYwJJOHmkIP0dK6ePLPdpVf3xUvytk25VTywOx6gRDxEV5/fJTqDTVs3?=
 =?us-ascii?Q?AFs3mo6Rr4B+9ytJCJZbJqq0xluIVES44NkD9cAV7trHzn0bC/8O0+67xkZp?=
 =?us-ascii?Q?M5nQ0eBFaowVbPmLbMneeuiRhX9M/IQ5P6l7glKnhJ9q+DuTFqzCTtHtuzJ4?=
 =?us-ascii?Q?So/13CwuL9fE1DhoSOfOBUvmcrUKTaS4Ig5rHN+kLOmfeLqGPoIbeu/lL2dB?=
 =?us-ascii?Q?wiiTb/POBHy+GvnQSzZpfiYG1qMTYeR1rrk7Pys/DshJWR6U++E/AVy6QOgV?=
 =?us-ascii?Q?gHyo6GEEI8rIkPsOnVRWQ8RkJ7EwITXUMeRAnHMaDQHS/xcFXEClyuVC7uXu?=
 =?us-ascii?Q?8ZpaFQ+G+E3H5JhWKMlYKDc2Yj8ouzxvJJs+2w35xpKTPqbgzbt05MCZqAcG?=
 =?us-ascii?Q?Xwavh02S38ODGaC2gMCcgI9s6GMI3O/650Ibq9jj1vo/Prgznc8e07JN5lB4?=
 =?us-ascii?Q?TTW9ce4+xcA+9GG3yg1tkLUkWoQNsbLp7XNTieepIkYu9CLVd06/xgN9h+l4?=
 =?us-ascii?Q?fh0laquPtCw8J09QzqscsS2C520BYtfsQi77Q7w+KYNPwe7Sk8Y3Rfjk/Ni9?=
 =?us-ascii?Q?sk2WCImqLtqhSzfj+P0APBPaKNlBpeO1V7IjciUTK6izS7N6yMqdFgs/5v4e?=
 =?us-ascii?Q?vk7wX3nTec6yeAvm720k26V7OsARk9BwD911FOzL3oK56x88mZSKm44FG8QW?=
 =?us-ascii?Q?SYP3acidVAW+3YEVQKW1cvbMHwbtTpk+p9oWdRilVz8dOMrIeJiiHPDWQHNm?=
 =?us-ascii?Q?bIS7C0MiifO6+Ko9UaKrYoAdBnyVibhTBiubHrVv0GKHmCvym3cQLfVkszgH?=
 =?us-ascii?Q?52yPs68a067pXhvoNLnFfwGUWIWh10b+mkag77j8Lyw+MXziyN0820NUdQ6q?=
 =?us-ascii?Q?aKKGKMAcJwRLiaZ5VWovQxx3uK+RB3iC9qjMhG8mZxGMXur+uaJgxlNLw8HH?=
 =?us-ascii?Q?z02Mc0LIGg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cf5254-5625-4970-5cd7-08df413bb932
X-MS-Exchange-CrossTenant-AuthSource: SA2PR03MB5947.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 04:08:08.7707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jq+B51dwO3VVDELyN+V2y34JcEF7+C1w/8Go+sYdHk7bbGrNEdhJtsCtc9Tj1NFa8g4AI50eLH+RQxVkDS/x5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7573

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Agilex5 uses a different VSEC layout from earlier SoC FPGA variants:
the VSEC length is 0x60 and the CVP TX credit register moves to
offset 0x5C, a dword register holding 12-bit credits, instead of the
8-bit register at offset 0x49.

Describe the credit register differences in struct cvp_priv by adding
an avail_credit() callback, and add a cvp_priv for Agilex5 using it.
The callback reads the credit register and returns the number of
credits left, computed modulo the width of the hardware counter, which
wraps while sent_packets keeps counting. Existing devices keep their
8-bit byte read, so their behaviour is unchanged. Credit throttling is
enabled when avail_credit() is provided, so drop the redundant
wait_credit() callback.

At probe time, read the standard PCIe VSEC header and select the
Agilex5 cvp_priv when the VSEC length is 0x60.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v3:
- Move credit masking into the per-variant ->avail_credit() callbacks,
  which now return the credits left; drop credit_mask from struct
  cvp_priv (Yilun)
- Drop ->wait_credit and use ->avail_credit to enable credit
  throttling (Yilun)
- Add a short comment explaining the modulo credit computation
- Update the commit message accordingly

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

v2: https://lore.kernel.org/all/20261028104019.21225-1-tze.yee.ng@altera.com/ 
---
 drivers/fpga/altera-cvp.c | 72 ++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index d736f9fa1898..04c1314a37a7 100644
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
@@ -84,7 +88,7 @@ struct altera_cvp_conf {
 struct cvp_priv {
 	void	(*switch_clk)(struct altera_cvp_conf *conf);
 	int	(*clear_state)(struct altera_cvp_conf *conf);
-	int	(*wait_credit)(struct fpga_manager *mgr, u32 blocks);
+	int	(*avail_credit)(struct altera_cvp_conf *conf, u32 *credits);
 	size_t	block_size;
 	int	poll_time_us;
 	int	user_time_us;
@@ -223,16 +227,47 @@ static int altera_cvp_v2_clear_state(struct altera_cvp_conf *conf)
 				      conf->priv->poll_time_us);
 }
 
+/*
+ * The HW credit counter wraps at its register width, so compute the
+ * available credits against sent_packets modulo that width.
+ */
+static int altera_cvp_v2_avail_credit(struct altera_cvp_conf *conf,
+				      u32 *credits)
+{
+	u8 val;
+	int ret;
+
+	ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
+	if (!ret)
+		*credits = (val - conf->sent_packets) & VSE_CVP_TX_CREDITS_MASK;
+
+	return ret;
+}
+
+static int altera_cvp_ag5_avail_credit(struct altera_cvp_conf *conf,
+				       u32 *credits)
+{
+	u32 val;
+	int ret;
+
+	ret = altera_read_config_dword(conf, VSE_CVP_AG5_TX_CREDITS, &val);
+	if (!ret)
+		*credits = (val - conf->sent_packets) &
+			   VSE_CVP_AG5_TX_CREDITS_MASK;
+
+	return ret;
+}
+
 static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
 					 u32 blocks)
 {
 	u32 timeout = V2_CREDIT_TIMEOUT_US / V2_CHECK_CREDIT_US;
 	struct altera_cvp_conf *conf = mgr->priv;
 	int ret;
-	u8 val;
+	u32 credits;
 
 	do {
-		ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
+		ret = conf->priv->avail_credit(conf, &credits);
 		if (ret) {
 			dev_err(&conf->pci_dev->dev,
 				"Error reading CVP Credit Register\n");
@@ -240,14 +275,14 @@ static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
 		}
 
 		/* Return if there is space in FIFO */
-		if (val - (u8)conf->sent_packets)
+		if (credits)
 			return 0;
 
 		ret = altera_cvp_chk_error(mgr, blocks * ALTERA_CVP_V2_SIZE);
 		if (ret) {
 			dev_err(&conf->pci_dev->dev,
-				"CE Bit error credit reg[0x%x]:sent[0x%x]\n",
-				val, conf->sent_packets);
+				"CE Bit error with no credit:sent[0x%x]\n",
+				conf->sent_packets);
 			return -EAGAIN;
 		}
 
@@ -473,8 +508,8 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
 
 	while (remaining) {
 		/* Use credit throttling if available */
-		if (conf->priv->wait_credit) {
-			status = conf->priv->wait_credit(mgr, done);
+		if (conf->priv->avail_credit) {
+			status = altera_cvp_v2_wait_for_credit(mgr, done);
 			if (status) {
 				dev_err(&conf->pci_dev->dev,
 					"Wait Credit ERR: 0x%x\n", status);
@@ -558,7 +593,15 @@ static const struct cvp_priv cvp_priv_v1 = {
 
 static const struct cvp_priv cvp_priv_v2 = {
 	.clear_state	= altera_cvp_v2_clear_state,
-	.wait_credit	= altera_cvp_v2_wait_for_credit,
+	.avail_credit	= altera_cvp_v2_avail_credit,
+	.block_size	= ALTERA_CVP_V2_SIZE,
+	.poll_time_us	= V2_POLL_TIMEOUT_US,
+	.user_time_us	= V2_USER_TIMEOUT_US,
+};
+
+static const struct cvp_priv cvp_priv_agilex5 = {
+	.clear_state	= altera_cvp_v2_clear_state,
+	.avail_credit	= altera_cvp_ag5_avail_credit,
 	.block_size	= ALTERA_CVP_V2_SIZE,
 	.poll_time_us	= V2_POLL_TIMEOUT_US,
 	.user_time_us	= V2_USER_TIMEOUT_US,
@@ -658,10 +701,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
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

