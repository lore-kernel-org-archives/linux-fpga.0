Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794455019;
	b=nzjNynEGiNyQbypnPFYiBDJWNoEMng4cPtab0RoHo0E5vYNfXXzjDSKjjveKEGeZVOTZ
	 JuxgejI+vb1XiESvaMYzIEm6nH3CS9ArMcKb7ZkQCoaQLQxjHlp/SfmU3u6SdF0dnGleO
	 45a4MJycvjW2Ekt4ED7x/wTj/l0wdOq7xr/zju3jtDb++wlTadGAOF6moLSuSqo4wTiBz
	 AEjYFQOrwjPwsQAxZ0zbOX1ui5hdSNqaYc7vKaai637VjXCWLDn4ofbZApC/qHPuTf/Vw
	 Y7VnoZ5qkuYU2PnP8SaBFPvcujwu1BlSA1vv5RohrHjs63uNf5AHuZRqyYgq+rUXPuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455019;
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
	bh=NJMwcWoBbRRwdFVEIbPy/4zLZPiPK3HDQkAF5jZ5Pws=;
	b=bHRw4BTVULDQeDcW17vm2yoFNlHH2nH41Yn/87wPszUDTMnx23OjHGF9+Pzgyyi6ZWlM
	 X51VTSAMb0KHfQ41Si/NlgpWz+MmKXQxP8HG25YK5Adq4voyXS/+Vg2KmdF2mVuO38IKu
	 w3qsoGd5ZxCpQAQEiNEvYu54k9xnuZI6QZUW6h3kXHBwDWkGWVZO//ZRBYVxAQzSMp6kT
	 ulDPbei3iKiEkF/Dx7ekc4hNELVXXjfbZY+5Wdcj8m23LYqWMfwOaoW7Uyrn0jamwbMAF
	 vzNdkCCrk+B53OGCwnYRooY99PHFnD3xpbRgDDXb1Ivy/l02jKqJl3/pLa4qQCTEo5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=aWpcx+MZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.28
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4B606A31C;
	Thu, 12 Nov 2026 03:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00C4B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=aWpcx+MZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rk79N041xnOIhzLncRGDbiZs6R89TS//fbGWYvhoPPjI4p/u9TAxQpTiOlJg0LFNqB4aRtpSz56WC2boJR903GwvBJmK8cjzvm0hBlVuLAPO2GkuJpb01Gjwb5+rEgIeIsMhkSood6UCYBvFx4+R2X9qqHdotXmnY/dVsVSS5h6svWoIhTSLwrBnc1yHKjwbVifCzjCybJ/iY1Q1Jg0bl/abC4ALZVlSjUrMaX5QxVdqx8Rzk3ds6irZ88w+LHSi6IQ4tF9HMqQPItr2gkqFjUW+1beJYo1dp7pB30YZlyUnuMzwbNPQiu1I0O3fsV6Jw4ZFCMe6j+P0Tl+bhgo8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJMwcWoBbRRwdFVEIbPy/4zLZPiPK3HDQkAF5jZ5Pws=;
 b=wFtP65m4L3kC7+gdD72EABbMZGiTF8uPdZe8gJUREPk+WMxgavizfIQMRCIW6hxO21quwdcDxNIVRzLZTuSIx4+GRxGMhODVGtjnf6RJV1smy4IHbd0WDk6nS7mblARbLtdbBOEL/VQEVjYgCA3eCEPnfxJ1j/RNPnXhF+Lw84rmLqbUrlCEyp2LdlNsa04qKDNVTu3NPaDcK0ij1ItWsmDStKn52ccOPNWtzBdvdqruR5xvzCCGxRae7LRTyRn4MbY0Tg2Ch6VaOxOZgN9wpPMB83ulzX/sDyO49kSK7diNM4VgzSODzsG0N/0JrsVr47KzK4BlnvFc9yJv0kqlEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJMwcWoBbRRwdFVEIbPy/4zLZPiPK3HDQkAF5jZ5Pws=;
 b=aWpcx+MZ5bnyoCnfhJKO79tfCJM2XtWDJx9HH4W2gUqih8mspLfSSB8RtvNc3Xrsk0av3iDku+ueXkjdvDm9Xq5CJSD26dluDIxo0FIRhf3xZdetBiGxgqJMPnT+erZ2AsdejEXDR+84rg/YucnRP6wh6Ur89wkHLR+cSjXsLRv3RHAEsVIwyRtZy/ubVB8AH7F39O+BN2ZcHPef8lbgQfIOOkKQbYZZTV9mqtVXNQxODy13GiMeFk3vNlQtFGGkgSfZ4pqgCbyRl9zr6+ZrotjNbMub6EhEYftHNIuZcG2Enb8xK8IX0jj1UtjwFwLsHRmzSzjcE6ifwEGSZJV8vA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SA5PR03MB8477.namprd03.prod.outlook.com (2603:10b6:806:47a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 03:43:34 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 03:43:34 +0000
From: tze.yee.ng@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>,
	Matthew Gerlach <mgerlach@opensource.altera.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v4] fpga: altera-freeze-bridge: clear all illegal request bits
Date: Thu, 12 Nov 2026 11:43:30 +0800
Message-ID: <72504835fca6acc0c6bbed589f5917c8e60ffc74.1794453791.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::18) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SA5PR03MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 5801aa7f-47b8-4837-349e-08df406f20ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|6133799003|261009223027099003|55112099003|260925022911599003|11063799006|56012099006|260925021911599003|261021121427099003|261102123227099003|261021123027099003|261022075727099003|260925021311599003|10067099003;
X-Microsoft-Antispam-Message-Info:
	KEJIneQEdtE67rPoRjLPo5YBwBkV08jGJXwzv55AbtwU52GxVsvBuXQLRLi/JunZ7soDNPym5yS6ErSQ5ZPBSYgLzjtRqKtGkBFIVZ0tkpqihwfGAZdXLnP2PIinnXcPK6eMKkjX8RQiqG8+sffLRtJH98oRhjpkExnvj4fu8NkI27y8saKN3qcCrRKcLdE8IfCt/rPbFCPS2L5Zy3eNHfh4vzgq48ig5bJ3P8qEc4DwqvwuVTyxx58uwGvciUQUzF42skqisGdhB+C4Jz2PfM5tUYhQ+ed6ARKn+mDVTqVhW7ny/aOlnIBKDyB634oBnhh7meB9CF8jc8cqmnW0RasQwujFbiHwmaikLt+EcxkxMvjEMkJx6mAWZJjMwjqn/jzf0vzBaQb6PEsvwDyDukDOnch5FV74Cf3Dj0EMD5BzCAuDfFsjIuKwAGU/TrjQ3I7dbvdzSyICTHWf8fCFHvDL0ecKu9Symd/KUiof4y/K7BeBHpLQK7cv9GDKCI4kWlBwpvlVX1N2KR05whPmR05Nu9x+/8+KFESdJ3JPpbR+tjLWj9U8OPfZvAihmjypBP5jhqkgNscza3PDs34jESuUCfcdzos76zldUn1WtVmneiV3GLPQkAP2FzsjIG1Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(6133799003)(261009223027099003)(55112099003)(260925022911599003)(11063799006)(56012099006)(260925021911599003)(261021121427099003)(261102123227099003)(261021123027099003)(261022075727099003)(260925021311599003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gl+CAYmT93hLYAeRnqGa3Y4OeJykzLadJD1bIs0JBegrGF7LaUGoRhcIFN92?=
 =?us-ascii?Q?uRqnQh6LAh9F1AeuqOLDFbTQP2n2T5DAPOZJX6570jiTq7Ni1kzbX0Pv3tCl?=
 =?us-ascii?Q?JK5EBMqzK8LAHojBdsr+M+vIP8GpnYiQxY/RkgDV2FyOAHHrIH9fv8DkPifE?=
 =?us-ascii?Q?Bhofa3rrYj4QUOFzeu0M+kaRiLASJ6taFYf29oLdkOKCJ1Eo2Jnkl4ir59HJ?=
 =?us-ascii?Q?lUzyznSl80BWZVgA5KJtZY3xuMSL0yFvQjD4X4TyqcFE4DY+8cOKNE31YsTe?=
 =?us-ascii?Q?QtNXZWrlLVOG47AL1tRSKZdYHoKT5/RzmpFFvhi/WdIzxEk+DSm0DrtoEWOy?=
 =?us-ascii?Q?BiAWmsMmYZvKS0nDsdTuKeC938Eu7iZRRELb9WwKFFCXUWVd57Nd2fbuSw2J?=
 =?us-ascii?Q?C9PZxRngvY7uQToKP3klcDLRVNyBneaiJAcfRO7Ap8aI9XJy3qE9vHiLW5/f?=
 =?us-ascii?Q?nFtldf5rTiPSVs2yikTODVquKgwrgaFHIydGpEzVC27JRnYd85Xn2B+UpTbQ?=
 =?us-ascii?Q?F6o1klHOiCVrXdmPs7zmwIgr3hHD2nNOlOE9t8eF4gsk43qBNLt2V8Jik+Gg?=
 =?us-ascii?Q?TEzWMiSeZqFRxoGeoWmx1uPLnhO2M8Id28l7RG15A9kY7dUgU0L4I9aFOtJ6?=
 =?us-ascii?Q?qfaGP8eAhqY8/MG3mXpruXgVLxcnxvxDbsEbKObaBJw5Iog6WVBusRy8BIoE?=
 =?us-ascii?Q?xTpMQCrw0rZZjlZQub3pQw0bQw9ADpZFa9xC0y8pOvVIlHD5cogDbAtZPjtW?=
 =?us-ascii?Q?bCD72lV/ynTOXvL9uDe1RJW9Rx28Q9sFVUYV15pFvCwDP6oXYAkSsylzMYOz?=
 =?us-ascii?Q?dKAjGuNU3bMFdNidwf1r7JgnekBi6yzcNWTjjI54Xziytvp7zNHutpwBE+UP?=
 =?us-ascii?Q?CSmdKjznqBagImr9huQxoepwcxwzgZNrvFOFtKejgaU5IDjn5Hj93FosJMsF?=
 =?us-ascii?Q?Fi55mGjRB3TkHqwaquOyhv5s/THlD4keWbGMmyd82rratlrtOQLDNST5BddD?=
 =?us-ascii?Q?7BTrOqaUCDl2QMLAKUxufYjd95jtee7XqlhDQZxUefyP5hFJ7oFFHcLvqQr0?=
 =?us-ascii?Q?mzlj/jNMg0M0Hh4iC73Jz1LdClJl8fbDor2abcWq4hrtHPps84iYLGPRj2r3?=
 =?us-ascii?Q?X7TLz5HkoM16cAIW/9vFY6Cq57If3Rkh0gntdfDOvsocwxF/GtHeailQ1X06?=
 =?us-ascii?Q?V7S4kq8KOz6HLlorNK9utE/ezfCnmwfE22kaGR/r7pNY7xmFKxIT+/TqHo2N?=
 =?us-ascii?Q?9BBhjDD3P8hEYsAN3K4meZxGyjQhraUgrWdijralt2Akuzx7W69arcDLqyAv?=
 =?us-ascii?Q?2DRDMEeEh7Bvc+LLt9QTkiUSaW95ATJ57oVBVGMtClB2bkwj42XPS9stKfkk?=
 =?us-ascii?Q?N3l1kNIfDvOCsqlpNAqAu8cEeTd/tm3wFOx8wVsP9kKgkzifY1MbEBuG7phW?=
 =?us-ascii?Q?QmXjBMFL3Iw3lkh/8N/ACxLo/BRjdl4ImYFIg5TXjZbTLZeIQ10/lk9QS8YW?=
 =?us-ascii?Q?LH8EiH/SXo9oKDvvI21YS0bVVIRp22nj0FDI+ILL+MOCBZds5HqnTAg89cE/?=
 =?us-ascii?Q?FMRNg+CL3k+XTczuwbfRQMolqFEl5uU3+8ek30W9K354+t9gP8WCVGosrbN/?=
 =?us-ascii?Q?evBfjeQtUZH+uc53bpURoGshGbe+XQpBwNico+pQL0Ppgx9rb1r+AeZ6r4IE?=
 =?us-ascii?Q?GJs67YrMc7sndi44MAnJD+tQh7i1R+S7vHRw1KnFBW5GzGbZj4M3XVdGrBAu?=
 =?us-ascii?Q?DusUN+rj0Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5801aa7f-47b8-4837-349e-08df406f20ba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 03:43:34.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWkE/JzMms+UQ7omQNl08yymQLNL09vUfKHpEirjnH9G5jnOlDcmaXxYeEvEtwt+tjV0ka+qKeVPMu+MkMTOYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8477

From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

A Partial Reconfiguration Region Controller can be connected to one or
more Freeze Bridge. Each Freeze Bridge has an illegal_request bit
represented in the freeze_illegal_request register. Bit i is the bridge on
freeze interface i. Unlike the status and control registers, which act on
all bridges collectively, this register reports each bridge individually.

Writing a literal 1 clears only bit 0 and leaves the illegal request
latched for every other bridge. Write back the value just read instead, so
the set-to-clear applies to whichever Freeze Bridge reported the request.

Fixes: ca24a648f535 ("fpga: add altera freeze bridge support")
Cc: stable@vger.kernel.org # v4.10+

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v4:
- Restore the narrative opening sentences from v2; the earlier rewrite read
  too much like a dense hardware spec (Xu Yilun).

Changes in v3:
- Reword the commit message in imperative mood (Xu Yilun).
- Describe the freeze_illegal_request register layout: one write-1-to-clear
  bit per Freeze Bridge via the Conduit Merger, versus the collective
  status/ctrl registers (Xu Yilun).

Changes in v2:
- Add "Cc: stable@vger.kernel.org # v4.10+" into the signoff area so the
  stable-kernel rule is satisfied (reported by kernel test robot).
- Remove Chiau Ee's signoff as he is no longer working on this patch.

Link v3:
https://lore.kernel.org/all/13856736bdb808b64826aab337d9919abeb3ea5c.1791253862.git.tze.yee.ng@altera.com/
---
 drivers/fpga/altera-freeze-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index 30d03ba14481..cc0c320538da 100644
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

