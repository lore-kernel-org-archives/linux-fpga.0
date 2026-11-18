Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794987805;
	b=ALLdcXmUlKwcwyWoLUiRZneRJ5YlW6efMCIlYqiZoRqrg4ZEeDUF4ygojcMOXbLgAYkF
	 SIdeLAa0jhmvoJnEXIEjQOeKRXxjsZDKES3Xsjkdszg3sPPCSjgdgGC2GuBgz5j1PdprV
	 occHeO5XsXoCAvVawgcP+J+W7vaDRcADf5CojxDAmy++VDr7jU8lJS+mTvbx4ft0mPEvL
	 av2YndkyvLPLZ41lwTy/4+kyLU28uGFgcp3i81nLUaUnnWKBBIihnHw3p8nRrDCyFZewm
	 7zwS4kLIqnBppX8k7VVjMMgZfq9c0l1TZiHode6bj9azuWTx6E9iAJDpcJJR7+so2cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987805;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
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
	bh=QQvN16al14jcHHyU2MPa6xH/jUQ+sHAAMOR1IK4FfQg=;
	b=XK7SViL5i5G/9ex36nhSTLO85Y2JaRxti1+S2vE9nmBydfs80RiRzCoqvFJxx09Z2Udf
	 Qeh6BzYUClutVMMFvTSyHCjQPIwMMUJryj42t/KdhY1pkbzA3eZLZXAjd6AnCWIy9HpmI
	 grQ7iFrO7yoczehT/BV0QPQfiUVGOzPO2vDpEtMQ5giRzNWWPZfA7h4uUUaXE12W/xmwa
	 jpWzf1E82Fp/bwP1HFUq7dFqJ9p8ZjGo+yJ74Fnnd3y5H1PoHR30OAxhdeSPw5xNJ7qm+
	 vmuExaT3/rmPE9nVhQa5zuUNdZmAW1j0GE/K1Z/n08CKaOTa7I34K4o0eL2PeFatTnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=LiCALBAM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.40
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B148A606A32F;
	Wed, 18 Nov 2026 07:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B148A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=LiCALBAM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAJx+vvqivkSEygCcYxsjvDUJWLWwlDvfyMIjj5oZF6AloYRsj6/zGh0QesD5e/XXVcP/b14IOEyFnDIlWk1J2m2B+KjCXmXPUaCbxKqRYJwWZURgp7GOQknolBq8yYf7/3GUR6frd9FNZcEygrPd2TB+eRlugia6+y7nccctnPqEalqD44hCXOaVj0w+rEjg9gNq0nSnH4WWoR305Sc/EmyVqZiwmtakeIXMD7UyRlG9gWbrmcMCqG0ZolgsbxVQpnrKY5wSpHuw1Mq/dCc1zbMzVVMBzLsI4qiArLXVfxTthXlWiIwG79saA77S6uofb03PrMbx329CHYIP77avQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQvN16al14jcHHyU2MPa6xH/jUQ+sHAAMOR1IK4FfQg=;
 b=hDk3FvCVEU9sUDMBro+0NmpxetzD4dUjsKUcCzUTY7qH5OoInM06CA+VQltquvabs2u2ozBOj7v52NXKibQAeBPghvz0V+xwizNDChQ5XT2+jZ48QwmiknRj8IqCx1e1C5xMw2K5XglzhW2QbcxUZO8xLjFg9q2XkSZO51TSC9urWm9Kw5FRSnOOWuCGQPuMWhNryAsLwb526gzQIs+AMY0IrmX3AOkqFvRRNkI9zhEFmwt0woeB0Jc9cpk4TISjjbknQxded2bZFBIKCIfLfY8de3ONx9AukxEwxkgfG7EGhacP4o5g1YhSOyhhb5eJIfXDVISw28s+tQHRsFzeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQvN16al14jcHHyU2MPa6xH/jUQ+sHAAMOR1IK4FfQg=;
 b=LiCALBAMrYNcAyulcm6jIzarUm7rBTLcDYwZ82lSRRVbV1XNDNF62vRCCGUpIPluXqIoP/8dN+W/sK3RAdhRDrje47rT3bq7zDfEDmAGll3xswEL9A5QkpP0x4nRK1V4/AhgHCIBdADgzW92D4IXiK/riiTgDXiYZ4gboNc80QNB9UDziLwHBjLJNoqdbNn17LD9Wk5Xnh2KQo4TyWUsPo2zw9DsrHFMv8qCG1rdkMZJZOlzaLtPhogIiF3+wZRpjQ6pnvZdikJbAk97x1+LGM0n+s6vcCGOvUzz0e4oZa79Hb784dhIFoMaMwI2K2mDfR4004KhnFV57cucNPxlaQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by IA3PPFE20549554.namprd03.prod.outlook.com (2603:10b6:20f:fc02::2db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:43:22 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 07:43:21 +0000
From: tze.yee.ng@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fpga: altera-cvp: Handle truncated bitstream with padding buffer
Date: Wed, 18 Nov 2026 15:43:15 +0800
Message-ID: <3c1bb384cb9cd5bb35b3c7e68a4feab95ef4ad60.1794987679.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:332::31) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|IA3PPFE20549554:EE_
X-MS-Office365-Filtering-Correlation-Id: 1431cabe-d5dd-488c-835e-08df45479e8f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|55112099003|11063799006|56012099006|261022115727099003|261026135527099003|261022075727099003|261028144727099003|261022113327099003|261021121427099003|10067099003|261021123027099003|261009223027099003|261021135927099003|261102123227099003|261021130227099003|261021133027099003|261026140227099003|261026130827099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	NFVO2Mf2cb8tpp+gqr5AKy5Oad7g1BqxGwPwf9E/8y1CBVTme6bvu/OEsU5gJ3zLmgNkrOEtC7LbXHYW8QkWaee/1jTO507/o787BpNiKyjOhSVbqM0XhW4dzHwG2JDiZp76y7biitE8hAYVxxUbNOM8qIZsiP2drrdwrHcukHgp6qrgb/bMf0l/kGH3jLQwdmMe1qcKy+Xq8Wlhbi74OQFDoqhhzFeI1plTQMdARVxqKci34SP34VUPEz+zVr75IKHAZcatchDsSM0IYkNIFOs/JAgDcyfkHBn48tXpxVPm0RKfl/dVIMYq/c64DWB2x8kr1/zRLOrBDej5ffB7I7XqyDpZgCaWqfdIyd//MXfNjvNVcYOvv1+rsaMIqu4/zahC6oDPEbtSCNzGUQeJupib9A3re37VCPxN0Tq0eIQpF+cqbHx7bHWmmpSWI7Pl515scV3u0725VSeBltbjT+4ONyBj0Lzr7Adp9H+mBHBAIDbJSl7vCpr9ZQLI8gZzSmHotW7pHhIP1TTzK4exPP230fkfWhNzuxjZx0rVWvwNOe8+tRvLQjwJHJm84g7PF9OBGzFWTU7DvTpxhfq2dJ+7cNfOMSG11i3pxc0IF9Ud2kUPudAeflVeGCqv3zih
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(55112099003)(11063799006)(56012099006)(261022115727099003)(261026135527099003)(261022075727099003)(261028144727099003)(261022113327099003)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261021135927099003)(261102123227099003)(261021130227099003)(261021133027099003)(261026140227099003)(261026130827099003)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lga1bB3Y1Q1vco3MkSzcUYGfyxs8zm/DYMgmjY0/bL93TiOSQyuhTxOplKKf?=
 =?us-ascii?Q?M8x0eL6h3eg5blXNoQFcZfn0XAZPHktrJ6cPHi4eTG8Dcra5OBV+p1XRjVfs?=
 =?us-ascii?Q?Ims/dobS2hN/mHVKv5wN8gManb3AFp4aA87PTjyU+CgZX2fsr5xJUMuJ3S1f?=
 =?us-ascii?Q?jB1sIlC78wTNFrsWwRUn+IfU3JVrvOtyTDE+LlAs2bMbSj2qXRAx18R1Qty1?=
 =?us-ascii?Q?rsoenxydyBZwPQvbQ2mUZNQDKvCbGBTRkVlqqUSZ60A/st1FkfI98fn7AfMK?=
 =?us-ascii?Q?uL++NihVjSIBI1P4+Sl3umMkFzW5nXRyoOjTyRoOdDek+PnL4dYLZ2bLPJg3?=
 =?us-ascii?Q?k/bLcby0kX/RtVshHMkM5+xNPx/dFnb12XDHARHSkeSPTMrwQ+6e0cA5ptXg?=
 =?us-ascii?Q?my8Lj+kwknW2+RhrV9PPLfwAy0HSmH56dWN0XWuh6jHGd2Xqgjbb1d+gl4+n?=
 =?us-ascii?Q?YpRqAhmtijZKO7jvYERxp4FZyTnRsnev4LZ/BsaQ/1+aPnNX1Fwt277Z0bAf?=
 =?us-ascii?Q?tGYdzkmipN0WJZ6Wv1n9OkkLx90Qczesb9WeZZllgK9ynWIRfUG9lbYx6RBN?=
 =?us-ascii?Q?4nn3AA0QDxU4R/W0NyC1b8yvEHkOiKYmasIuJTldNr6yPmxttwgYZBgOReEV?=
 =?us-ascii?Q?Jpow9aAMw1qtwNCpE/2AL+OFyC1E7mCf6CX2rImvVXo21Dv8afgycIOfNn4a?=
 =?us-ascii?Q?JEGFIrCqKQFdOhrOzzdSq1G0Xzj7G9tHH71cYKZa1Tsckv9Fk1n3ciP7hZhY?=
 =?us-ascii?Q?cKHoOw/dWjhf9Kd07VBkjGVhV7XllroLLseJUqmMTDQcnVRhOfdsephdM+n1?=
 =?us-ascii?Q?Wznd/wonaoc98lUUY1mzv7Ujv97kPS+OrfOU9oeFZYPinb4u7E+w8gSrYjqR?=
 =?us-ascii?Q?2um7HrueXpIxZTaGaJlwo20/3DM0HJJn0CEb9R7UJts8ebW+PPNXDfyjFj25?=
 =?us-ascii?Q?oJohmiJgiYlfv5EDK8TLx6KTbep4kMe8DVZEFD59j5ujEFS1odRzNoQOsmQI?=
 =?us-ascii?Q?WUEl9YqqbHYVVqz70mYIiLbVnYWLu9eOYdb6wAZobIqhWruicdiIpLxaFzUN?=
 =?us-ascii?Q?H+arZhdPjoIT1jX1XcPzENKBj9bK0VyNUSuVko83LfjxgJNp+b8mzRY6Dq5G?=
 =?us-ascii?Q?M29QjQbB1tMyX5gTbpUXUNhHWvn+fvU8RkxEjRNJ6gu6rdtEOFm9Jq0K4Q0A?=
 =?us-ascii?Q?bdr6g2qiJUEVrD9nN85BHCFRmF3mkmjSoItm8JYmmZeqI2ityVyacSESmeQH?=
 =?us-ascii?Q?dGs9ebukSIPXEbUf3WeP1j4ibMYlOOE7iwwlwu3fRikfTQNn+8FGUQgwnNpq?=
 =?us-ascii?Q?I1tABPB8WW0jj4ToIW6nMQTvTPs5axy3FYE3kV8JmnULnjzEhy7OmbMIGSSl?=
 =?us-ascii?Q?sLqwHhN6Itf7JHvpngoNlqPBdxHTnjNp/vxY14tLCC6F5+9NENxfA7EqtE2p?=
 =?us-ascii?Q?4jvs5xGQja56musQspElZ7nF0PHZ7mThTrCm/V0g209Eof406+stiHQHvncf?=
 =?us-ascii?Q?xRshQyYvIJTOhAVnnaYbNdygcZRnCznA4banYGllIJNJuMcV/sToaVLc8juB?=
 =?us-ascii?Q?+OooLD6bdB95D23ua7Ze9qC0bdNneTZCbO3rHbTUMUBCsgDfCcOPqJQywz54?=
 =?us-ascii?Q?wY6Ef9fJpHoCiiXesNwRiQGpYJscWt2ccZ/a6DFYMpwH2TB96x++C2Iy4I3h?=
 =?us-ascii?Q?dgUOcRkpXoGHVtV3V2XLUyHLphmkEZskJqeMdWq1IqTme9bDR7cymB7c/nZx?=
 =?us-ascii?Q?g6qJts5y5A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1431cabe-d5dd-488c-835e-08df45479e8f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 07:43:21.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdKBHasm32SXwwRYKcdFFk4uKJO4RSvf8C4GmxBywrSrrxvE3Ya23o43qzdQnARTjCGGk1ii+6DP4j3HUMUAbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PPFE20549554

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The AIB CvP firmware requires a minimum transfer size of 4096 bytes.
When a bitstream smaller than this is sent, the firmware DMA engine
stalls waiting for the remaining data, causing a hang.

Allocate a 4096-byte send_buf at probe time and copy host data into
it before each block transfer, ensuring the full block size is always
sent regardless of the actual data length. Also improve error
detection in write_complete() by checking VSE_CVP_STATUS_CFG_ERR
instead of VSE_UNCOR_ERR_CVP_CFG_ERR to catch truncated or
mismatched bitstream errors.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Note: I am taking over this patch from Nazim Amirul, who is no longer
working on it. Nazim is kept as the author.

Changes in v2:
- Rebase from linux-fpga/for-next without code changes.

v1: https://lore.kernel.org/all/20260619040811.20038-1-muhammad.nazim.amirul.nazle.asmade@altera.com/
---
 drivers/fpga/altera-cvp.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 103446465e0c..c9357cbe7fc0 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -82,6 +82,7 @@ struct altera_cvp_conf {
 	u8			numclks;
 	u32			sent_packets;
 	u32			vsec_offset;
+	u8			*send_buf;
 	const struct cvp_priv	*priv;
 };
 
@@ -518,7 +519,9 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
 		}
 
 		len = min(conf->priv->block_size, remaining);
-		altera_cvp_send_block(conf, data, len);
+		memcpy(conf->send_buf, data, len);
+		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
+				      conf->priv->block_size);
 		data += len / sizeof(u32);
 		done += len;
 		remaining -= len;
@@ -557,10 +560,10 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 	if (ret)
 		return ret;
 
-	/* STEP 16 - check CVP_CONFIG_ERROR_LATCHED bit */
-	altera_read_config_dword(conf, VSE_UNCOR_ERR_STATUS, &val);
-	if (val & VSE_UNCOR_ERR_CVP_CFG_ERR) {
-		dev_err(&mgr->dev, "detected CVP_CONFIG_ERROR_LATCHED!\n");
+	/* STEP 16 - check CVP_CONFIG_ERROR bit */
+	ret = altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
+	if (ret || (val & VSE_CVP_STATUS_CFG_ERR)) {
+		dev_err(&mgr->dev, "CVP_CONFIG_ERROR!\n");
 		return -EPROTO;
 	}
 
@@ -729,6 +732,11 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, mgr);
 
+	conf->send_buf = devm_kzalloc(&pdev->dev, conf->priv->block_size, GFP_KERNEL);
+	if (!conf->send_buf) {
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
 	return 0;
 
 err_unmap:
-- 
2.43.7

