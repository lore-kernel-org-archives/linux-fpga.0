Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD0F1EEA54;
	Thu, 18 Jun 2026 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781855; cv=fail; b=jaDpXqY2Z5dhvTKIJsHRmgWDRvODXQGB6Nx2HZYIRhCvrK8l1NU11+5gKVHkxh2wIaj/VZyeMDHnIm0lPbj5BSuD+SFpxIa6K619RbGmv8khRxq/JxlUkreDGHDk5Mv695tshVyMo/N4XdfHiZl0i0clz2pSc8H05iGX+FWkYDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781855; c=relaxed/simple;
	bh=P/Wbr/1JALUVUDSxUbvXOR8Tmwtxl8YzcylIiX5Adds=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hdAXdGj3Xl0EhEcszPaE0OK7+HTBA7Mlfc2Epc8pOqK3/aZ+UpCxYlW2H0fI3SMMFzJIL0ZpInJfef1aAwr5xsPt5e9+L2tJFnvtaRhAHb3xa48qGmmwOhw4vwirYfJX56gkGlY8p8wgtpBU+sAQ9N52rl+qYbXi8CVK03LplOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=JNJkpZSA; arc=fail smtp.client-ip=40.93.196.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="JNJkpZSA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTHICrXXgZ89LBFCigxi570SFfQjb8KO//gi1o0vNte9OWNvEwcC5EkuQadaym/68nWrfM0E8ZqjuvTromxFROoyEfQVYC5c3GE1JcgKPYy0cStRIJ+/Vg2P7xlIk51N/Y5IZsgYgbAVtBYVxAeKaNaE/7+y8sM+qORhdvrsG5Ue98tCgWQmN/QrGPShcaDyzzNIx7tjAvSTqK5xLQEjuIp6a7gW9+Ghnv4LUs6f4Ku1BR3PnS0h/aVZye6gekLGvLKEjDeWmXkr3pW1YyS9i1G7Q5/Lq5OVVPkLemfAhz/a4d8cTKyGLNOTMWZ8tqJTKkp2INpoOAgWOVG/kGLErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCek+gouoZfgQWeYaBeUoSezhbxzvGdFvFW+y9SHtnY=;
 b=D4se0m24NQICTbrmNaW5+jZ8nBixI3HOg5WSfrBJHxrxTVXKx1hqRTZWR15u5iARHFP5JhJ5w0f6a+bLAGnPlXDsxTEnlnopL2+sUMU1cOFNJ/KFHEWHoDomWkPJbZtMCd8/IsJ2BbfkuLvzmCWJlJrBWHEmqiLRADB+ekLedMnRBDLZtuGB5tAXLCSSNabbM4Bl7M8gC7Ex+1sI+dALIkWzQrECs7JK2/8TvKEgMtwuLU4zQySDYrLEahjf07fRKlPIbtTjybfltCMnwmpXc5YiFpICafSLb4b1obtxoReVHT/vwKNS+Gyqcp/f0UJRxCUnicKsBbO3DrA28spm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCek+gouoZfgQWeYaBeUoSezhbxzvGdFvFW+y9SHtnY=;
 b=JNJkpZSAVuMqABVIp4qc/aJc+g3YmY8XoZ3XwDfZ0roKQKjN7svHP0haaQkwmtXAMNce3HaxKtLeIlsIoEpAZj/DYOzTPz147I57HfGkTQoGWEAJlqpTaE8Psi2HEMi43g/oWNz7ZnUg1DZnr2k5ov2AuXMEGDYuM40SyY4pgEo7jErUcPnVjNMr1UMVAX4c3CUfny7bCg8MmhmU0AEcWJSrLv8n6R2tqoS52pH168Q8fPvL2pdNYi30RSGrMGlqkzbPWbFEsMip8c+GK3Pggtt4a0u5QK0/pz2zijUSBIpXiIU9tfKpJ1h/VedB3AzngEcuPVw8LbztizOp3wsBRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BL4PR03MB8105.namprd03.prod.outlook.com (2603:10b6:208:58f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 11:24:12 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 11:24:12 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: mdf@kernel.org,
	yilun.xu@intel.com
Cc: trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: altera-cvp: Retry teardown and reset CVP state on failure
Date: Thu, 18 Jun 2026 04:24:10 -0700
Message-ID: <20260618112410.303-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::31) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BL4PR03MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: ca29bd4e-e73e-4fa9-93ea-08decd2c1ef3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	WPgKMQ7lFEorIqLXSZD/T4Nc1SXPS4wabtT+HfCC6JKc3yjEXzfev3steE0CaZxSLXkyOhMZ8YQwxUFL8So1ZY5GXRVv1FbGW1ucXTvBDcWjXp8AxULdvU8pvzRINMuQSZZthf/qUKlGzwWeDQkwJjaooDs4azuFlhDQt/0rrbmTAPdnPzoJPDwwkrzEVZjywmvuV3w5zq6rQ+NpAgdn/OQ6X4425Tk/WeEMDDA+PAd+AKGUAKxMfItIeIuDSMy60D46CuJpNgi1q+mSCQ1bXJrGv32swPMY1Y0Z+9OTt7SCFhgNO7skRNR0gE88QnBTdzS3wpYS4Ob3m8ImcnP5FXv7GlNKKnueH60/LAs6WV1g0kkjdM2lDf0eEawPIPCyeBU+6+JiQuBsgNBwgkOdHB/j1TXJ1khtJLQbfpRZzB9rOZjRpo++7phHjiCx0KMws5W0j2UdCCK+qLWbIG3Ayz9aZqTqKaVOfEzmEJYSM8L3uxlpCtS+R4oYIHwlIw7GtFTIX5Ef4cOc+v8PiVLCNMxMi3V0Hvp4tWSYuoCF4pCspt/NRM3zgmVZCOoF1BoL8u8F5sZQEW4St55gsmscFm1NXqfT4+t2G6ttHMcpSfkxZOL4jGaKiL/6WhzdN92P2TLdNLb9mBm8gb1TpV8tntfnxUjjhovbmSQwntGsvLg3bHqnXLaTmYPKTvM4L3ZA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DJuMsQBpIVPfEju9b32KFwLjhsYwVtojudFMxZSXQxTCWDFtxDU8/KoSIXSO?=
 =?us-ascii?Q?7K4DUD9Bvgg20S1t3w/K3dj20uIpTVq3Y4J/DDRALlJ2SO7Hcj6wwsG85e4S?=
 =?us-ascii?Q?9Lcwc6j3B7P+OrDxPPhzluVUGDIQ0yWz6iZMzza1MQuKXQAuv5IcOHKjpiec?=
 =?us-ascii?Q?VPY+vlSfMtR02Xay1hs0U0tJS0wFYZK9six2xelNr9nbLEzgxFHaBUTIU1FT?=
 =?us-ascii?Q?MwcACtIY/AAIEHBljF/830DhtR3Eru7Z27QIGJ4voN4sI3w7yZSR9l0ybajy?=
 =?us-ascii?Q?NmwJoGUbV8H/JLklpDJZOT9Kln5O9W5Zry37Ibr4RPPSKzwNQfu7jR3d1HDq?=
 =?us-ascii?Q?WUooUyRWq91zRRbPGdYbzz9/ZQsdRxVJ9vRrJctoiPs8xp4X/TMJZb4Bg5Qy?=
 =?us-ascii?Q?HrQV3WE/JSOR1EYbrZYmIK13Imhe5+IF7Cad5yJgK+9wC011g2jvKIfbVdYl?=
 =?us-ascii?Q?ZQOnZVjqHCbc8+Moix0HRID35t6V8nAl7A2MhDZfWDnLh+LkMmsoHHzpsEq6?=
 =?us-ascii?Q?dIW+eaMfS18dzJkgAilym7TWF1/iUiubS7hqj4Y5NM/LNmaaskLfLTc6mI3K?=
 =?us-ascii?Q?0VnfjdYVM8I4SccyMQCCoERVT/raaSAzJW3wXiGSnXwSJ/S7JisS2deeqE3S?=
 =?us-ascii?Q?GOLEcOK/7pr36+FRnGlvDsyybJgg6i2VQKP6B4/OACLQz8frF10tEDs0rqWo?=
 =?us-ascii?Q?rKkA0S1fUZuBZhl39mxyOgOrEPglKY9w5x++SEsKdW/YFqemH//mnwxtFrB7?=
 =?us-ascii?Q?5ufTJJyYxhy/hpJ7fEQsA0dnkLxWYIdfvDfJZAX5uyXphGapJvxwm9zwJAIH?=
 =?us-ascii?Q?RxEn2BS4qjdGmTWEYDyQZ7Ff0xdzFiblRz+eT98weYDAEwhqucUTTzR3v6Qf?=
 =?us-ascii?Q?KzPJtZhcDViSMIBSAafU2n0Wm52dgHSiXuQ9i9S7b0BVY4ekm6EYuRxsoGBm?=
 =?us-ascii?Q?+f+I9qa/xC/L+Jjaiu3ryG+GqwxxuGZ8Fx5V9dYhZ8c5GyLQnz1PxiDWMHlt?=
 =?us-ascii?Q?+wKh/KxRlSVpyhPGgxZl0dot4awsBeZ3yGxAjuAnkAXErd4998B+I1pBhq07?=
 =?us-ascii?Q?Ab4dX5IFIktNssrP92EfbYpQ4ey4il4XSy07atmx07pJTiIyU63HE82BkDx0?=
 =?us-ascii?Q?CNUZMPxYoBa37aMu4tcZCFKjq9IVEW6mGKCMNw+fvB+wmLBlYiUEZAd67izF?=
 =?us-ascii?Q?9QeXE2mAfMkghXt64bFKYwkgIP+Pq8G4WHo/ueOlFIeKsFZgVjpWQ52uZqrs?=
 =?us-ascii?Q?dYciZi6v+0Q8suzOe60+lP4gWxx5g0wmS8TB1w9TTUd99Am12CSpdE7groCZ?=
 =?us-ascii?Q?oGO5p3SMvKNkE3hz0Eh/QzObrZZqALsDS68HqGUkh3k2kd7m2O79m0bhi7on?=
 =?us-ascii?Q?hp2TOzw/63p5Yp1BICa1ZJd/1o0dsqgb1o0ZgLG4nCDcRYIXkC5Ysg1g+3n1?=
 =?us-ascii?Q?P2cFFYmnGIoCOYZsV8581vsT0d2bNatoA0zdpo11hi4VX+LGME8qIl9ltE+b?=
 =?us-ascii?Q?iP3gdpx666t49WbTRSw9rhdvYfpsSyMmf5HhLQRBlX0oECy06oiVtim2y5OE?=
 =?us-ascii?Q?Si5sYHCIUEbomYEvj4RfQiyNaqcV2eVdCKYhe29rElvvA8OEL8yLvIl41raC?=
 =?us-ascii?Q?amL/uvzRZ7C4ibvGHm11H4MP3pdDaV4kbhafiufpeAcFTtWsKyFaBWJJJqHC?=
 =?us-ascii?Q?UsD7bIp2RTQ+JtvyWhbdY5+wfFggYH5CH5VWt7AioB6G3ewK45/h9QxKESF/?=
 =?us-ascii?Q?LkqFv2ib8VANcvdpTSQ2AD46VGOtM39Q+f4yT8mtjm6B7h0G9z/T4ElrqCn5?=
X-MS-Exchange-AntiSpam-MessageData-1: OhVFxeHrcns/ew==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca29bd4e-e73e-4fa9-93ea-08decd2c1ef3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 11:24:11.8629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8xIszZ+z9nC40Vcr2QKe+Ya7mTJN4BPkWkf7Dqb3vP6pWd3yuOk4HjRKW96L74ZI6xqEY0kN7Jp5DYTEWzV5OdgpxpfpFCzybUb2NDR/UqSLjzGfqC8O9f2JBHV5P9aOiCsA0hG94L1n4E21uoF8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8105

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

If an incorrect bitstream is sent, the teardown may fail due to a
CFG_RDY timeout. When this happens, reset CVP_MODE and HIP_CLK_SEL
bits to clean up the hardware state and return -EAGAIN, allowing the
caller to retry. Introduce altera_cvp_recovery() to wrap this retry
logic with a maximum of CVP_TEARDOWN_MAX_RETRY attempts.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/fpga/altera-cvp.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 44badfd11e1b..29faf6f5bde1 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -63,6 +63,8 @@
 #define ALTERA_CVP_V1_SIZE	4
 #define ALTERA_CVP_V2_SIZE	4096
 
+/* Tear-down retry */
+#define CVP_TEARDOWN_MAX_RETRY 10
 /* Optional CvP config error status check for debugging */
 static bool altera_cvp_chkcfg;
 
@@ -305,12 +307,40 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
 	/* STEP 15 - poll CVP_CONFIG_READY bit for 0 with 10us timeout */
 	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
 				     conf->priv->poll_time_us);
-	if (ret)
+	if (ret) {
 		dev_err(&mgr->dev, "CFG_RDY == 0 timeout\n");
+		goto error_path;
+	}
 
 	return ret;
+
+error_path:
+	/* reset CVP_MODE and HIP_CLK_SEL bit */
+	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
+	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
+	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+
+	return -EAGAIN;
+
 }
 
+static int altera_cvp_recovery(struct fpga_manager *mgr,
+			      struct fpga_image_info *info)
+{
+	int ret = 0, retry = 0;
+
+	for (retry = 0; retry < CVP_TEARDOWN_MAX_RETRY; retry++) {
+		ret = altera_cvp_teardown(mgr, info);
+		if (!ret)
+			break;
+		dev_warn(&mgr->dev,
+				 "%s: [%d] Tear-down failed. Retrying\n",
+				 __func__,
+				 retry);
+	}
+	return ret;
+}
 static int altera_cvp_write_init(struct fpga_manager *mgr,
 				 struct fpga_image_info *info,
 				 const char *buf, size_t count)
@@ -343,7 +373,7 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 
 	if (val & VSE_CVP_STATUS_CFG_RDY) {
 		dev_warn(&mgr->dev, "CvP already started, tear down first\n");
-		ret = altera_cvp_teardown(mgr, info);
+		ret = altera_cvp_recovery(mgr, info);
 		if (ret)
 			return ret;
 	}
@@ -484,7 +514,7 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 	u32 mask, val;
 	int ret;
 
-	ret = altera_cvp_teardown(mgr, info);
+	ret = altera_cvp_recovery(mgr, info);
 	if (ret)
 		return ret;
 
-- 
2.43.7

