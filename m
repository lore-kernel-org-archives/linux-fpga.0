Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E433A03A;
	Tue, 15 Sep 2026 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789453661; cv=fail; b=lPjJRNjPHjUMvV8cmL0prF00eh8AQsQ328CPPBx9KUc7U3inZUtszB/3wE/2WYWnd8e9bD/vykVVvZurEG6hD6gWqCI+MJDUlUW6lEza6kvDsP+hM+dTr4HlEO2RJ5fz15v2yC+MDjtqqjUk6+kvZPxiElIP3hHvPV81u9JcFxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789453661; c=relaxed/simple;
	bh=CYRcElW+fabbS3WC18LniDF0t95hUbzZrOmpbG8zhYI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=blJpuKNTD58nrGjWjZX+U5yRmg7MNUCBFdoFs9iiulXTCSVvNwLB2w4KGDaxhlNF647U54oj2uvj76I+CpmRyWCZSrZVerDvr1z50my0uaM7dRxUGPTaTT3m6biCaWr7PyESI2nkPR7SGmMlfqVBAv1FAP8+pugR0Szp3b07DKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vwiXWqmp; arc=fail smtp.client-ip=40.107.208.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vwiXWqmp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l44jldRxBQnFqkyM4l+x5fwEEYhwWTtDniICVIrb6RUJ+fBXWPIPz8CW6k0plcceocxnxPO2T6SGAYnZmIq45Wso5GhC1ogH5fF/aWEnZ0ArHllLY2rIhEJZgoznN0OYl4XmhpARPbUNky91rf26GUMuKvwavGjw60TOyGANfOTJ0dbzMaS0mMT9A8GiNAwKazKBKnWD/r+PSippkgDSoxetdxnHN0uTLtOzYlbZObENoiJPeCmSrZGkRTIrSSJV4lRP5xvB4l65BVmInKDy0Y9UNR1biAVwpTwb4mKvEasSXxRMYs/2iBsKqnAh7zQQL8bSnaZ4Y3kfxntIYL6UGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO0gNGnaZ2HQzt1cEWPBNx2iWIgJilRIm3QZ13BoMz8=;
 b=scNjfgyAK0Yh5+MEvh3RGAGHqcDFXsHaAvap5lC6bEe6NH7JaQLnMTHLe+ePARL/vhcTIYfBjEMmCtF/CDWR89revco4W9XchIEiGZUD1vnMcWrU6Oj1nouYTyBhmRKEzE1vorAhDcKeILCGhYJ0zxX//5K1bFcys2ZYY5kwyVfUsNReDjY9FT/yDLkUJDlMaehTodht6Q18nq2Tcn6YF4Y6Vfzhg4ZXvOVL9zXY2LLkH2jMm7tOXnbfd+pZY12Wvh4v/rpI8AD00tWpnYpHMyxZh4dJg3Qqgt70TgkY1YwVYObE7bnN7lttvoDbWq8zZd6ziwaoCKSsKs8KlZrWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO0gNGnaZ2HQzt1cEWPBNx2iWIgJilRIm3QZ13BoMz8=;
 b=vwiXWqmpb5LAf2/wO1e2JVizHEbcaqmSn0G/W54JovKYMRLi+D8USDsLL5iJHr+G3LRjSgyBAf/laOkQ/6KU4uq11q4GgP6WdMY5n2pVCFtTlDjZYKF7OiE4RKAYC20Xc8kDsNNq15yK72G4tBrmTtDnGvEqFS15PkeGTO0QRn5YxUlDujPAELH2bmQZ2v18l3y14XxXOkPx3eCnFNkz1hHJDxWiYylDS9IgVhVAuiGP5ex5FcxoroLHO6ezF4T2e7bYKLUTUgUGhoIIVB5LkruLDNuTHn9NVhzOZus3AapezHwse9TAUZiiAeQca2MGWPuyNSzBFD6B+aohTuIxRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB6939.namprd03.prod.outlook.com (2603:10b6:510:16d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 06:27:36 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 06:27:35 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fpga: altera-cvp: Retry teardown and reset CVP state on failure
Date: Mon, 14 Sep 2026 23:27:34 -0700
Message-ID: <20260915062734.42964-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::13) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 3589e4c5-b2ec-4147-8a3a-08df12f26e96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	E5gZXHNmOgaTF5FfyrVqdG0azCiMfd3/97egisTxuAdhU60gjabxI3WkUq46YRW5nWCSZsWsPrAdPjtl6dD9i8RoFQpuZjnGZXqj+tFHvVjm4cyDYpa/pF+nyt9OzL7xpQ1PrH/ohPKgMt1TDK/np5BJfhW4NBbha/NetJmOnqoktjVudE9cXF8qeVcTLx5gsFw5sFbUUw2ls4d1ArZ5gGBmgGlNz5dACWHfXwTqtaxKi2L70EGKpoau8CIpjV8IyLZD5RGuMiDB5a60OgAdOYMrFP5+Zh5SKV9z8rVlIo0Llr6LkbfJOm537r01eEdRgeYCe3VTAJHF6Cky5umhnKjkwoSx9Tw9VnuBQ2nzVnHuL61EtaoT9ATqD2CSQHGz7m9qNdmJC3jVDm59MeL/bYQxJgw104ex1INJ83YB1kFmrmsMxQb2RshproTKvFHub64jDKjhatW0RcXC515iogus22wkzd/2irJrMC7gahtz00sXyfXCRGgEtMJ3z9jzpR3a9gnlahHq0uKIPw7trC9W8Lh9dsuJj2HoxY/pqeI/IvbTRbKfGxJ0wtCNuCgDhFOubSEgJXiyYFm8q2AecoIS38M3e6eh+PP6lq97zTFzJK4sX5ppvyBQ6KvcNDj4HChbSIXK0oY7iilMuv0ISXkTf7KRmvAuGLvzpUsPIo8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sq8DNmunFrWxEf+/4dd/wrvPOspjrbamSzwmlU5e6Xw0VBEdnHSZyeqASjO6?=
 =?us-ascii?Q?Kx/3uk8JfWM51DX22r7bLQG/R/xZ2K5bznwEzHGQHw+q3liVcbXN16paPeTi?=
 =?us-ascii?Q?8RuWU94QrFVutJlEY1aLr8oU/sovtokh0ChmkKBdSKNlWEmqnc9SjWeGpJYa?=
 =?us-ascii?Q?Ul6ulu7JsQ2QgsBdGq/SjaiF61BhBoUGlE7bJfwC2N1VyCALYND3rgaVwmY3?=
 =?us-ascii?Q?LjS2o0ZcpAmtawh6WaEVu9JpnlL2HUgBysz6Gg0x+mkcP9Cu0cHZBBiABdZY?=
 =?us-ascii?Q?kaaTPMaHyBOMw3PUe27W3a6oStIV1RfeDPEHzmY2bPKxcj6f2r4Pelhnl0uR?=
 =?us-ascii?Q?Ksc7yZvh/RJzMSVK8Qpn0fQJw/j6WOPGK3WSbN6esHz3GSii7jbP6ddX4QU+?=
 =?us-ascii?Q?d56MQdCkew7tvJoOLzEm8jKmCY4s7kVaeoH4edVdFlxRtzinHGFAMzr6DeiL?=
 =?us-ascii?Q?gbSXJA4zz7BKB87J0TUc86KsvfcsrFld0G7mZbDJqAJpVBSjJLaiUJPh1nDp?=
 =?us-ascii?Q?bC/ynjAp/oouFZqXZdqTjLw2dEjLGzT0bt00oc+TcOph2K35Eus0hDe+H8w+?=
 =?us-ascii?Q?ZSVl8fbslwcqf/o+NPKzaD6T4w5dB5sDaBrgRW8ox3ZEC2OVv6hSKsmW79Y0?=
 =?us-ascii?Q?lfYvRIEKxhiKvMA01y75eTjt9wrBaVEy5eOnFVg3pQi86htN5Sc6OBVWQmzJ?=
 =?us-ascii?Q?fMXzNlm61RBj7wwZuk7LBWyPvwM6eowxUKNyH6kBrLP7uI9KsmOcsVMqwP2e?=
 =?us-ascii?Q?JxA7oPS17QthiLGfjMw/l/I7YaYwo5T+D7/qgUitXVzdKSkB9QnaScIJ5ngQ?=
 =?us-ascii?Q?DpT7ChK1KzN5IsYYMXXF7Wbt2w5YmeV0Ku7A4MBjs2fPt5xjN39mLBvp7HEw?=
 =?us-ascii?Q?U0TWHopHE40+G3A2CwxGk2cTVvsabEl1fwwyRDGaf3ovtDgLuLiLBYquHcUV?=
 =?us-ascii?Q?DFTPYcQVgmiNdsHiAZZfUiMC4LhgBaoQaTgT5hO0m3unuJeVSjODCM8c9ven?=
 =?us-ascii?Q?LRAJdZrHAaO/ehMU1ZR18uv2nehN5rBm4L7BZTFboGxqldhWwI813hdKHeSH?=
 =?us-ascii?Q?pIg6FzDU+0rDbvhacu0wnC70Vj6VWpOweOXKJUyb6+VeLRDvbQfgUpwBBWne?=
 =?us-ascii?Q?cpNSbQd+h7F0GxaMSBDYwD6G703s5+blnoJKSaFQQcGbcNkyvAMZdS+L4GGh?=
 =?us-ascii?Q?vNncCaGN5qSI+zbB58qM+n4zMUaB2H0AL66ZCkpZoSw6Fgvrcedh7HmC/jzE?=
 =?us-ascii?Q?yIgh+mJXGtVgh9WxILo7l9CB+fHEfCqSLxmaMs2uyWGR75KLMLXoOx18BE/C?=
 =?us-ascii?Q?yOkEKZlkwAUO5SM/4ct5csgvLF8FABVUaBYbehn0H9uz8pqqASJijcwfXui8?=
 =?us-ascii?Q?SLWrV6mWsBCP6v/XVsFz/zUabkGkOlEscrMVmmbjd+I2V+hAHStZo4Q866Pz?=
 =?us-ascii?Q?GaLkODNwxyJog6gm5vfmOmcfG0FAhHMGAEfMesRFRHE35NJdrKArLheRPy4c?=
 =?us-ascii?Q?RYXo/SZKm8bxI82ZZ0INqOJl1Dw6pkNqmzYsTI5HhQuiOLGDMMXwnwktxtN9?=
 =?us-ascii?Q?4JhzD/NgZ0OeSHUxD+ArIOdBuqYOIeLCyVp2tvdBjAaNiq7OH/SxfSE2sFUn?=
 =?us-ascii?Q?5bayS/JhcVvAN7FbcIDBV4BGwbRqna+fXpML5Os7Znacv5viecr8JVCMAhuc?=
 =?us-ascii?Q?VvMq3JrQVs1cThcyFr8LPifbHY/GnK0NKCF1UkjB2dyZ6Rl5tVwxVfAnbN69?=
 =?us-ascii?Q?hMLKy2LsXuCxtufyrZp9PdBaH/8i7lGxvFySIRWLYyoAQVBEKn1ai8Sq6QOJ?=
X-MS-Exchange-AntiSpam-MessageData-1: huDBO4aI/O043Q==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3589e4c5-b2ec-4147-8a3a-08df12f26e96
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:27:35.8221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhXlc5vXUqyMRa3sGpvsjXoD/rBEoYk6og8RuL/XIoHf7TvG/hKfKQ+fLUy4nhytRmGQQVD0YnOdWnBJX4iwGR2jMztrd5uQXfgmxwSQ2bA96rvEjXly3nQj85J82UtzzsoAkvCG/Ggd+9XO0BwDMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6939

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The driver polls CFG_RDY for 0 as notification that the endpoint has
finished teardown and a new session can start safely. After a bad
bitstream that poll can time out: CFG_RDY may stay stuck when
HIP_CLK_SEL=0 if the device has already left usermode before the poll.

Retrying teardown alone is not enough. Exit CvP mode and switch the HIP
clock that feeds CFG_RDY so CVP_STATUS becomes responsive again. The
second teardown is more than a plain retry: it runs after that CVP_MODE
clear and clock switch. One such retry is sufficient.

Introduce altera_cvp_recovery() to wrap this cleanup and single retry.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
v1: https://lore.kernel.org/linux-fpga/20260618112410.303-1-muhammad.nazim.amirul.nazle.asmade@altera.com/
v2:
- Rewrite commit message to explain CFG_RDY timeout, HIP clock switch,
  and why one retry is enough
- Move CvP mode/HIP clock cleanup into recovery via
  altera_cvp_disable_cvp_mode() helper
- Reduce retries to 1 (first teardown + one retry after cleanup)
- Use dev_warn for per-teardown CFG_RDY timeout; one final
  success/failure message from recovery

 drivers/fpga/altera-cvp.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 44badfd11e1b..ce9d2ed68b55 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -63,6 +63,7 @@
 #define ALTERA_CVP_V1_SIZE	4
 #define ALTERA_CVP_V2_SIZE	4096
 
+#define CVP_TEARDOWN_MAX_RETRY 1
 /* Optional CvP config error status check for debugging */
 static bool altera_cvp_chkcfg;
 
@@ -306,7 +307,38 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
 	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
 				     conf->priv->poll_time_us);
 	if (ret)
-		dev_err(&mgr->dev, "CFG_RDY == 0 timeout\n");
+		dev_warn(&mgr->dev, "CFG_RDY == 0 timeout\n");
+
+	return ret;
+}
+
+static void altera_cvp_disable_cvp_mode(struct altera_cvp_conf *conf)
+{
+	u32 val;
+
+	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
+	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
+	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+}
+
+static int altera_cvp_recovery(struct fpga_manager *mgr,
+			       struct fpga_image_info *info)
+{
+	struct altera_cvp_conf *conf = mgr->priv;
+	int ret, retry;
+
+	ret = altera_cvp_teardown(mgr, info);
+	for (retry = 0; ret && retry < CVP_TEARDOWN_MAX_RETRY; retry++) {
+		altera_cvp_disable_cvp_mode(conf);
+		ret = altera_cvp_teardown(mgr, info);
+	}
+
+	if (ret)
+		dev_err(&mgr->dev, "Tear-down failed after %d retries\n",
+			CVP_TEARDOWN_MAX_RETRY);
+	else
+		dev_info(&mgr->dev, "Tear-down successful\n");
 
 	return ret;
 }
@@ -343,7 +375,7 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 
 	if (val & VSE_CVP_STATUS_CFG_RDY) {
 		dev_warn(&mgr->dev, "CvP already started, tear down first\n");
-		ret = altera_cvp_teardown(mgr, info);
+		ret = altera_cvp_recovery(mgr, info);
 		if (ret)
 			return ret;
 	}
@@ -484,7 +516,7 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 	u32 mask, val;
 	int ret;
 
-	ret = altera_cvp_teardown(mgr, info);
+	ret = altera_cvp_recovery(mgr, info);
 	if (ret)
 		return ret;
 
-- 
2.43.7

