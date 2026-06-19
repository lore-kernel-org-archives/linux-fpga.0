Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4901132ED34;
	Fri, 19 Jun 2026 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781840615; cv=fail; b=AgbwWwFhPsxILEGmJ09YBH98opDRvOWnn9g7cG4A9h8CkJWsfK3gExO3hVNEmA1ez9K2OD3RDssMUR9Dh+CtRmVBb8vobU8LYmx1AQUQAt/t/mJE/EvC/OsLP8+czpdHkHmlyxlBoiuVLzj/k2ghd5L4Ns5OIDVvVCbGYrPgjyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781840615; c=relaxed/simple;
	bh=//vSsTUz9jQEmhYJlhNZe2j0F2ex5YiTntFFKMGta9A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n0J+HCPZj9vqx1TXam/NuZwtm0qiH/MGKSF00IBysdQqxKgiiMVp2rfG/pkP827kYaoHIT3BgwmUfqpgCoKPZWBIxGHzW6w7AjUKTqNDiZV0hxwP+uwiCL3MTRl+eItEFpMlz8WTDP5ouPE9c36EvvdBjKa9LYuwm860bEESpDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=n0jJhqQY; arc=fail smtp.client-ip=52.101.57.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="n0jJhqQY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuCPHBGh5IAOdYPdXyKEMu10PoP3Oya/Xy01Pk5TJaBmuKym8NNshjOf1CbSA7XOZ8Uihz7q2be8BYhbT8XI0WEn/4vjut1dFAD6ykJqLZAoFzW+VYQuGJaHO1FU/U+suqOyM87O6RuBOBgxXynB/YbCHe7EcPUY/qeNAk7LpxgylSuJ1Y5Rho9lRRygbdgUdEt8oXfn7kAS5LHsVXTyEtg3pp0ybwPoWaBnPl1mc/Zdq/2LhEDagrCVkg7Bw5UD0+K7hGUvm+4C/HBnL6p2sCrfhSGJlFI81aPZp88Vmf3P8fHw+SUn/E0vXqTrKV07T9+ZhrV3lSbHBvhE872HmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynNQheunBQIa8UxLitZ/DG1Tb05JSQkKGzL2iWvd+n4=;
 b=t56GAcdAcTzVh/00MHkLg08+Y9kQ1gaO+snd5hSeNBFadPBCTvBaw3cSjhW2izRg1KWQadhi7z+8/JHUm/ZZQp5M4/bu3SYcWcDmLhHirD7b4pEea5Y0MqDN9w9x4N09ZYksVeyPKE4KB2NjI3bOL50ebpBtd7bnvolSdcgDcvRozhKlmVcAwCVQn3R83x1UBS9rZUaRdqu9sdxAOBCmGDmUH6pTMClYeI6Okd/qM8UGZQUZLh7CSiHbUZUPqFeu3ESk2HGcLQBCvoovXVgPydDUiUidH5wux9ukfI4XQYOgldaTnMCXwganNIN4cUoi6pL2tEUJPxd4CfUkV3wrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynNQheunBQIa8UxLitZ/DG1Tb05JSQkKGzL2iWvd+n4=;
 b=n0jJhqQYBMeTglIuSMXuQk65bB0SoaU9trHUClApJXlTij8Qy16xaqjalYs0rE1TswWU5T8AQuwiWNRpCRTs8/ShUD/iBkl0JaVDOtkzZ3/+s1cf3c4flqonFJ5/M42Y8gTsrUWanSWevOlxYNiM5ROctfoDSIDM5JiZXsIz9M66BgCjtzZQ1diwAiRJLjUZmsrR0YxRO69pCTHLEM8F42CVuJar3OrzEutnvXInCtSW/hCu8zmwVL8CN3d9H3z2pNj3f9fYXvATgvdSwrrdO+1/zhvQW1XR/VAg/82x5wmpOQGWnwpMtxtbLPoucr1GTZCaoLhmC7ZjC2WAYCD/Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ2PR03MB7476.namprd03.prod.outlook.com (2603:10b6:a03:55d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 03:43:29 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 03:43:28 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: mdf@kernel.org,
	yilun.xu@intel.com
Cc: trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: altera-cvp: Add Agilex5 CVP credit register support
Date: Thu, 18 Jun 2026 20:43:27 -0700
Message-ID: <20260619034327.26966-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SJ2PR03MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6db5f9-be6c-4f44-acc3-08decdb4ecf4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	x7e4SSvpuq49tDioyBeexy74qjg5qNribQRl8r+Et5OdQz8DQKSyqhlYCcEcjnsu0hndVfHOvQhHYTUdQN+I0jdAjpSqvbViwFw67MfOg+xUKOxxfMwyxl5n0/vTkQnnJ3eJEaA4VIjQVireLsEfQDfiNqTUW/EFeK+3zPSXWkGIO9rIbIE+f3zIfoTysTysWDseAJHbJbi2gX9/peHg1QfR/+ucPDs3c8cZsZu8703ZClpLSHaTndKjYB8/iFucz9WI2FehrlxLwZsffRm3x8XlEx24aUri4jsAQorRT/MQqESbgtgSECaQFuZhJ3X/kfMf5taZ/eXK0CG26Io/XkKD9q96ymHVsP8dpq/tWr/vDuyhOPMWePVaYHZN+ZsrVraPcb29NflejIt07gX73sPQOZ3rF67WySD7T8pTIsltWxIiPwOGg6Bm68l31v7/n6LuGVBaOEKQ3bZs+U6xN32uDCAIbUpLr0UAiazebLfuaP/9BKXfFTQXeq/sXtPzeCitoiczpDzOqY4aAtH/B+mHzOYr1HAlElFBn3TZ08V/2v1In9dZ8+tTk/3l4mIiUKyPfS+J+LggIn1vHVAaDIMfuLhFDED2i4TtldGrUJhibz3kLtjF7sU0KIig3GV0NqJFxIR3s8p4dlkyoHxTM0fnir1EJFPGRf2ZYvbIwhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZLfo8uadu3yNfEFT2ZW/7bgUHWsEo+mDSU3XnMD4mDJxvfphuEYbWYzL5ZCM?=
 =?us-ascii?Q?7rqmZx+6fP4W1CeEm+LX67q6gwq6JBVBGwwMZ+YARET8k0AcLwhD20ylCwXX?=
 =?us-ascii?Q?5JH57wmvTcx1SPKrE2Hcft6qYZxKOmCfgHOBw/6f5Wzu+LRsRIjjLE4Bb1cq?=
 =?us-ascii?Q?hwtbnOO2aodpH+9eIe7DGeEmMr2kRu75ry4Lai58RVmxu8MYvHfkQ2m75g9F?=
 =?us-ascii?Q?Jlhde6brKp4qmf5u5FY+0TS8zyjo4AlwcMxEtlMsftywYOirc0yAaI5KZSqy?=
 =?us-ascii?Q?6HbuxzZHiy7FEVronWyrZqDqeZOUR0YuTpAhv/fwQWVxGMtIWjXNTe6eJmoz?=
 =?us-ascii?Q?G5PcIqd6tSpSKdCfFpo2fRyePtArnExBK7Nzhg7f604lMY7X52KkTz3BZCav?=
 =?us-ascii?Q?nsa9a+dcddr4Im7f0TEk4Zrlr3JbZTZCv3Kv1L3ckl9kb6Erk3dIrPgPv/C2?=
 =?us-ascii?Q?1jlAFR6o7+/giVPhpH0vsqI51+STFE86vmRiELKGJtwMkt7aYunqGXv9eIw3?=
 =?us-ascii?Q?k2/mkrjrSeM6JEcdalJBmSMfX1VsGXFuoGSwPD0aHknT7Gm6Ka0pr/0mRJJ2?=
 =?us-ascii?Q?gxEWi2qV6YLztxF/xHPHA2Xu0Xsk9xOQdTUd/5Y5gP+fcikpoMwIJGk8DSxP?=
 =?us-ascii?Q?XUa1nR550jWRSU+Xdk1oot5Vc5t63971pLQZP9zBDivps7L+Yiu/tNjCuV03?=
 =?us-ascii?Q?TfX3E0GEc8HgdRviTdmJyvWGa1wDuJv1F67kbbZxlIUrMiod/okJcY3MRz16?=
 =?us-ascii?Q?eXdvKpmlCOHV6NsfaJ97FfdcXE/lmXFY8qBxivirT18AJCPsfFWLpZrv2itW?=
 =?us-ascii?Q?7Cul3RzI7nadqB4rqtSlps3rP+7dKSX7cSqM8dUzScP8eNXf4rsobWBDDU2G?=
 =?us-ascii?Q?Kyl1laRHzm6rCYhuwP1Q9mlozz94DRCIMM+lqr1cL6+0A0nZYypva+oNuMXs?=
 =?us-ascii?Q?ekeVOyNy4NaLEmzr0P4eh8AzWcX6j1L7y6So8Sx/u9EwCKfMr16GdwlrzMa3?=
 =?us-ascii?Q?fOXH69PP8fG0F11ZNxMivnukCoI4X6Nt4LjX7w0JamQHV5hCO6dZZfaGUlCz?=
 =?us-ascii?Q?ljSNH2zX3A1EXUNB/UT1GpUtTpG4uyniIXkWscyCbMqGC76H/Rl8b1jWScgs?=
 =?us-ascii?Q?MqrRYwuDHgEQrOW8EZ9xXCjTWqQCb5GR+9UE2l7XLCxmkLiZsWK43KfsIoUF?=
 =?us-ascii?Q?iBpKDj/ZJa1XCon+gIg0t4ncPiQgJR5VWUtGtBhZmQmWztdMofD7FE55hTwt?=
 =?us-ascii?Q?bZKAjHAWgG96XbJ0M1/jyOMQ0s6b++bcMGW5c77fThWEBeosSWQ6uGWhwa+b?=
 =?us-ascii?Q?JEuTMVdQ+Mvc5vxJ7bzp1sPwtJUjFlid3iSVvbaJq+IJaryFQlobyhLuMiC6?=
 =?us-ascii?Q?Fzrf4jYaUyoG5B3HAIHH9/V8fs3Z3AoEzwHZxKLpT8oB2fszSe2V0yw0f158?=
 =?us-ascii?Q?mVCRfxcoMaFxzFG0dSggHXuJQbEeQ7UDCVBqe884lkIuTuwQ9oOkH+ziuFx5?=
 =?us-ascii?Q?9lEpdq9ISwQDVJn3UZb0B6fDDfkgLNRx5+KniMfvtPKIYxu9WJNe1v/cqbuh?=
 =?us-ascii?Q?N7N27f0ejnDfLEhNtHWhpXLBL3nyiR5FeXVVSJtrBmeKJvBm+vhz0hUB6ptI?=
 =?us-ascii?Q?O5Uor/ppVH3Kn278Prbz6Mt4Sa9/v9GWewcYSN/5bkRg7SOTaWfmbsaUQuyi?=
 =?us-ascii?Q?3XMT7p3MlrBKMcpxt9JoBgn/y0ea8XynboJu4+VYtRfonlnZLi5RIsdMJqMD?=
 =?us-ascii?Q?lN96sGTk5j6mw4QgkwQj0wpuxzxFV5Fix4JroNTyUY6kwQVBA6ysUdwa/IeO?=
X-MS-Exchange-AntiSpam-MessageData-1: d7TP12X3TBWing==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6db5f9-be6c-4f44-acc3-08decdb4ecf4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 03:43:28.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoJVKAbWGXl+niUJonauLAOTUinWnSFy0NLdSdZJ5H2Kg2no5Ef+AOZpARTBxQE+dG7ZF4cXR1p2kxvpk36uNZPi/6QOmTmco3uRp/5gklIjorts2OG/0x39IhsvcNEIzfWMZKTgycFkGYlg0lOFCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7476

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Extend the CvP driver to support Agilex5, which uses a different
register layout than previous SoC FPGA variants for CVP bitstream
transfer.

Agilex5 uses a different VSEC layout (VSEC length 0x60) and a
dedicated CVP credit register at offset 0x5C with 12-bit width,
compared to offset 0x49 with 8-bit width on other platforms.

Detect the device family at probe time by reading the VSEC specific
header and checking the VSEC length field. Introduce
device_family_type to distinguish V1, V2, and V2 Agilex5 variants.
Use altera_read_config_dword() with a 0xFFF mask for Agilex5 credits
and altera_read_config_byte() for all other devices. Fix the credit
comparison by removing the incorrect u8 cast on sent_packets.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/fpga/altera-cvp.c | 48 +++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 44badfd11e1b..58128de2a8c5 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -10,6 +10,7 @@
  * Firmware must be in binary "rbf" format.
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/fpga/fpga-mgr.h>
@@ -22,6 +23,9 @@
 #define TIMEOUT_US	2000	/* CVP STATUS timeout for USERMODE polling */
 
 /* Vendor Specific Extended Capability Registers */
+#define VSE_PCIE_SPECIFIC_HEADER	0x4	/* VSEC ID, Revision, length */
+#define VSEC_LENGTH			GENMASK(31, 20)
+#define AGILEX5_VSEC_LENGTH		0x60	/* Agilex5 only */
 #define VSE_CVP_STATUS			0x1c	/* 32bit */
 #define VSE_CVP_STATUS_CFG_RDY		BIT(18)	/* CVP_CONFIG_READY */
 #define VSE_CVP_STATUS_CFG_ERR		BIT(19)	/* CVP_CONFIG_ERROR */
@@ -48,6 +52,7 @@
 #define V1_VSEC_OFFSET			0x200	/* Vendor Specific Offset V1 */
 /* V2 Defines */
 #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
+#define VSE_CVP_AG5_TX_CREDITS		0x5C	/* 12bit credits for Agilex5 */
 
 #define V2_CREDIT_TIMEOUT_US		40000
 #define V2_CHECK_CREDIT_US		10
@@ -58,6 +63,9 @@
 
 #define DRV_NAME		"altera-cvp"
 #define ALTERA_CVP_MGR_NAME	"Altera CvP FPGA Manager"
+#define SOCFPGA_CVP_V1_OTHERS	0x1
+#define SOCFPGA_CVP_V2_OTHERS	0x2
+#define SOCFPGA_CVP_V2_AGILEX5	0x3
 
 /* Write block sizes */
 #define ALTERA_CVP_V1_SIZE	4
@@ -78,6 +86,7 @@ struct altera_cvp_conf {
 	u32			sent_packets;
 	u32			vsec_offset;
 	const struct cvp_priv	*priv;
+	u32			device_family_type;
 };
 
 struct cvp_priv {
@@ -228,18 +237,32 @@ static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
 	u32 timeout = V2_CREDIT_TIMEOUT_US / V2_CHECK_CREDIT_US;
 	struct altera_cvp_conf *conf = mgr->priv;
 	int ret;
-	u8 val;
+	u32 val;
+	u32 credit_mask = GENMASK(7, 0);
+	u32 vse_cvp_tx_credits_offset = VSE_CVP_TX_CREDITS;
+
+	if (conf->device_family_type == SOCFPGA_CVP_V2_AGILEX5) {
+		vse_cvp_tx_credits_offset = VSE_CVP_AG5_TX_CREDITS;
+		credit_mask = GENMASK(11, 0);
+	}
 
 	do {
-		ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
+		/* READ DWORD is required for Agilex5 but READ BYTE is required for non-Agilex5 */
+		if (conf->device_family_type == SOCFPGA_CVP_V2_AGILEX5)
+			ret = altera_read_config_dword(conf, vse_cvp_tx_credits_offset, &val);
+		else
+			ret = altera_read_config_byte(conf, vse_cvp_tx_credits_offset, (u8 *)&val);
+
 		if (ret) {
 			dev_err(&conf->pci_dev->dev,
 				"Error reading CVP Credit Register\n");
 			return ret;
 		}
 
+		val = val & credit_mask;
+
 		/* Return if there is space in FIFO */
-		if (val - (u8)conf->sent_packets)
+		if (val - conf->sent_packets)
 			return 0;
 
 		ret = altera_cvp_chk_error(mgr, blocks * ALTERA_CVP_V2_SIZE);
@@ -507,6 +530,8 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 				     conf->priv->user_time_us);
 	if (ret)
 		dev_err(&mgr->dev, "PLD_CLK_IN_USE|USERMODE timeout\n");
+	else
+		dev_notice(&mgr->dev, "CVP write completed successfully.\n");
 
 	return ret;
 }
@@ -627,10 +652,23 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	conf->pci_dev = pdev;
 	conf->write_data = altera_cvp_write_data_iomem;
 
-	if (conf->vsec_offset == V1_VSEC_OFFSET)
+	/* To differentiate the target SOCFPGA */
+	if (conf->vsec_offset == V1_VSEC_OFFSET) {
 		conf->priv = &cvp_priv_v1;
-	else
+		conf->device_family_type = SOCFPGA_CVP_V1_OTHERS;
+		dev_notice(&pdev->dev, "V1 target SOCFPGA detected.\n");
+	} else {
+		/* Agilex7, Stratix10, Agilex5*/
 		conf->priv = &cvp_priv_v2;
+		pci_read_config_dword(pdev, offset + VSE_PCIE_SPECIFIC_HEADER, &regval);
+		if (FIELD_GET(VSEC_LENGTH, regval) == AGILEX5_VSEC_LENGTH) {
+			conf->device_family_type = SOCFPGA_CVP_V2_AGILEX5;
+			dev_notice(&pdev->dev, "V2 target SOCFPGA Agilex5 detected.\n");
+		} else {
+			conf->device_family_type = SOCFPGA_CVP_V2_OTHERS;
+			dev_notice(&pdev->dev, "V2 target SOCFPGA detected.\n");
+		}
+	}
 
 	conf->map = pci_iomap(pdev, CVP_BAR, 0);
 	if (!conf->map) {
-- 
2.43.7

