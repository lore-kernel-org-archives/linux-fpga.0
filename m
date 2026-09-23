Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012068.outbound.protection.outlook.com [40.93.195.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6940A21A459;
	Wed, 23 Sep 2026 05:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141560; cv=fail; b=szzEEknycX4xOD6faSvRkwi8PtDZ4J0Y7N766ZXtqjq89cdD2AG5FcniOwy6HXMGYGsngGvkJxBzMOMRawfKGXMDmFUOx0lwOnA8EZuIuiHp9VNqJDl1RWq9Tdi8ybR1wx9L8oXR84Fuo2CrRc+D71pDWPLoRh1aUMCm+3diAok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141560; c=relaxed/simple;
	bh=fE4p4fzylG6LVvBPtuQABKDHQbrmb/uZCVA8O5OzWlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X1HUf/N/lalx8szxVvrcoAndLBgXn0L3hx/fVpJcqJilkYS2a9JF6FZJ5q9WjuurC+De+PXOKQxUh91/Wf3wNtCwXQFdFYnwwYnPf322TKDy5xrtlGIfULiTtfzsPgKoA4TGjE41B5t6xqKwJtqoK7DoHR7yjT4Vbq9ADSWGsjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=n8M+v2lZ; arc=fail smtp.client-ip=40.93.195.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="n8M+v2lZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMm8mc0K2wGtWuhgKNvih0jKmUpKd94w+vu0IIasoy1C7tmRSZJfXLtck7gJdgB6xvk9ytWw3VomNFfIfXecUT3vo624zkWHpo77nwFef8bUJwxgQ18M44ihaxyncxXymExv1JQz9IbdBO+pfD39sgK89DHpE01XjZOe8e4XZ7IvRyMdmLdzm19EfSez+w75oHMw71sEV/qGVRSEJGSNIdPWanoMVBUd9NWnCuq4l0O8piJGzHz5uzx7Ll5RoQCLsODGjqnxd+YoHEtf/DTWoKsSjqViguA+y/ERFUuauhj/5PWD1tQ/ZtxX24IhhpcqiEbybNdqj0QUP03Qo5DdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dZ7vG1dSdFoYVCfd4zDlq5jZKysQCPxsT/ddwDik0o=;
 b=VM2LR7Zi34eAlajMK47awohB6eDAVtZHs4ZckAAp96VMpEYdoSd2S2uWa8X9Ou9kI7Ts81nVu3CZDJezAJIo6IXYgHoHLw5Rjk9TXOkfSqZKsgC0mCIs2FPJwc6IJFX+np7TmfljBDFRvhemVTa/ts1zuVXb53HyZEibCMnM7dOI/p/fGhslmzG6tsComLNZkBzVVrULPkm5S8fmt9OGQNd2gd672Tparbx14xiBXdSNn0HDGr7F0RkgL5GuTO9IW3wfBQZWRX28gm2OJ3puJGL4F2M9+BSR3uW1AVqtq0yhsBO+kKJMWknJen0tUGceYhg/Glvl+Ta7Eo6RVb0RvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dZ7vG1dSdFoYVCfd4zDlq5jZKysQCPxsT/ddwDik0o=;
 b=n8M+v2lZdWA7ctDLnWx9TN1BmYZJpNbLYmOePkELKzJFiJa4xGBpWe65clQNPYmRzqC6tcPuTjcF1wDsL0YhsbenJEzBWKx9Z0f0GZO/dJ8sksSg0zqcCrAPcTklOTZtXnEq8Ekw/QmY0mhUbFvv4z8Iu1I+CJqwvEV//VFI3dreYtoNnE4G5aFiqOk3FcQLRgu+XAAs1Ps+gHeFGmsF/5JVumzsaBYBg4/F1a7MdmbFZz6HiyHVX2iYryLC+oExSKQHWhCc947rj/chv7HtbglmR5ZSpUTYyifXs6F7ik3kn0oJjw4OL2J/zxMnFDex/nLtFxt9iU7sxgSS/xnOKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM6PR03MB5324.namprd03.prod.outlook.com (2603:10b6:5:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 05:32:35 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 05:32:35 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] fpga: altera-cvp: Add helper to disable CvP mode
Date: Tue, 22 Sep 2026 22:32:32 -0700
Message-ID: <20260923053233.10890-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260923053233.10890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260923053233.10890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::10) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DM6PR03MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: c5992c91-dde1-4016-9254-08df193412bb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NFstlHR5RNXIbfo4cmlSGe1tZ0CS61/cY3Mwje+8O771j6+a9xE/4SU9LejK4SSjLf2CDfDexIKAWyDlIS5QC3XzZjprTUxumJvDbI3ajNQ2ieSrQaY63vntVwak6zsGPLmSBymAwMSNDjtZOeFVZLeUIp/UcGbmMbpQ3l/dSAXEnve9q0xIE1C+A2sGhcg+W+kNmxweVLHEGrqIdllGHn7WNQKPXiQrXV761DFiFHc4Q84oj4bC02XyYSJCVFgZ/3mKVvJ0hrG/manYcnZPFREJ/jPEzCvcdPkKIuZ6tAjmhG9NRalLysjl3buZVpzr7rDvPBTAUMyE5m17+w1kbadoit6vYRwxfDcJ8/SGSJHZx1WzRpwzG9FkTX6wftcb2HAGMwokoLzDzNuzL7LSCDn0kmHTmODsejeyXVrxeZhNr8ZTiS9wM0DpzgbLd0q7VtIA7ik+YQXr8ISbct/4AGEmP9tFkuah+yUMyYgQ8RbW7oRBznMv5gI+Qw03x7ofvFGhyf2c6arYWLVoyCJ79bWgfZZcAXgJASuuvQVgmyUAWGkXlYnKoAB5J8V7eNOTbLptCDGwUHR3jYP69d4L6Txox/f/sod+u4r0JR7318llNjVmmJ8Ea7VNYIkXr8DH5FzmhbAixs1NSWidA0ccbM8/Zyz77Fq9d0RA0cryJ6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c1v2bt7nGIeHTde3UOCwWlUGUtf7lbybK9o7vAmYjdlEUcoDBoe7oMqha0xZ?=
 =?us-ascii?Q?r62QL6aW6CbWPbBstzrugxjPG3gy0avSSHvgiy7owZlPXofRNQtiJFc9ESMl?=
 =?us-ascii?Q?0d9fWGBwj5Nl3NZ8A+Wz4RUfEoJvK2Zbh+ysaQOxS4FVTViJQBkjOp97iDUV?=
 =?us-ascii?Q?suDQW/0wIbzfQ6G1A5lHBlmBcT3qWbNB+dSlm8hfKw7emy+c7IkE0FMp2V2F?=
 =?us-ascii?Q?evBeWTGQTJyoESFZgWC7VH2d3gusIyQo0avbB8iiL1Mqf4Urd3wsgi4Fyo51?=
 =?us-ascii?Q?Nu4PbYmBuBoDSV5jsyG08VWjF/+Nq14feikPQmZHo+gpiFyXa1bG83we8ky2?=
 =?us-ascii?Q?JMSw7DXDUHyWr+v+OVXijA64+7z00ZAvO5nA/zxmWD6H5JauF5R4Mkl7DuVb?=
 =?us-ascii?Q?bOPPtUYA7L0RRy482TcGYej7g3ea16COe7+eOeVxGRBWYQu0By/VAJ9aiBD1?=
 =?us-ascii?Q?lRz/vcIz/WXkgN/+F/ZchQBc44zfo4v/x7IDQCDYg4cAbj/xDPPCbIhfAP7X?=
 =?us-ascii?Q?E5HOC0dM3GXfcMct54V3r1IDTmwyXA07OdXbWpk78TrFPPmicS2LZNyvWug8?=
 =?us-ascii?Q?FSOs0BXLYYvFKZ8sp4PY9iGKpv0RbbUl5/WO5dZOTYEUl44+VGGpIF2FY6fC?=
 =?us-ascii?Q?X1J4JDvAb7/gER/hRAtQjfndN2o++R7pcCTWccl/LtSFYbq2d76zHjnhdkd2?=
 =?us-ascii?Q?dzHzmXp9YLlPN0vdQdQ0YuPTwIVMfqaws/e1tRixnwW7GRi51K9gVdojSu8a?=
 =?us-ascii?Q?l2l/6zRtYVUoCcQBGlVLvK7ieoO2abEr3+MwS1UtIg84bTeasW1SBOra8O8J?=
 =?us-ascii?Q?kmNcxXIden6AWH23V7C0o7IQzGStZ/R8rgTht0JTV1/nWGfetg3r5ZNmIKEX?=
 =?us-ascii?Q?gyAryOXEHpMmNYgelUU8c/8Qc467XPlL0tZPCiNwM3UeSQ48wv0/Ec139uc5?=
 =?us-ascii?Q?8dE2zjIAVsH0XvGrsi0TNcmWYVdBmuW1Wx+kq144MXtK+3io9JywUYe3G9ve?=
 =?us-ascii?Q?o+cGBYqmhHCcA3+I58oNy8qHA0XdtpL8KjvdvrdClk7bJnvTIOFobZ6p6L0j?=
 =?us-ascii?Q?4ffs3gVjQPv6Wajn3qED1SlxSrFYqKi5o/pkgXTzTbocCGXW868tub1rvDGo?=
 =?us-ascii?Q?hwqXSMS2EFdwlzA0XM5FCglBpTRob6wTxO/WCEx3+rh1fbz7ZZvE3E7kdsKR?=
 =?us-ascii?Q?c+VepW9UwlnY2dtsIUMvSxNhjGjfXYbONRZFbjnSNGV0CiRJkCHKsnWK9Xo5?=
 =?us-ascii?Q?8f22DmFGOg9nEChi656uJA0DPeitzgFQsMsoqN0A5hOt8v42bYy0cHjyaDTL?=
 =?us-ascii?Q?7sGydalrKDjsugQPOPhGsyClFCRtgwRNO1SCcJTrIZ2nwuL5k0FsjEMxoxzj?=
 =?us-ascii?Q?o4JapKQl4e5Fv6dLyo1qz48f9IHhMuCjsFwG888oJImckSVz4fQpeGZfBDUz?=
 =?us-ascii?Q?+tNFSHaupvyBwK4sEeZ1Ork1HQbeSEks7TVxhzWhsmgbIYNllNQmvh0ZB81n?=
 =?us-ascii?Q?o+VV2sxR8fBjqJYouLF0LUoQqov95HjkmMPQP0qKcST7aSzCMUvhk6/7LgQ4?=
 =?us-ascii?Q?N3UH1gew9Xy6uEl9g5Eixzg7Je/sMPGZJkr1E71M1xOm46u5j5J6Uj6urZPy?=
 =?us-ascii?Q?GCM9NCUBjgz+pJtNQk8yM1XpsJ/Gv85SoRhELUHMXB++2bB/B4gH1xnDaK+L?=
 =?us-ascii?Q?ZLKMAXkvDgP59z0v4EIa+ZXwEjWmVq6G+W2o9629ujr7flglIDpr32hn0T0x?=
 =?us-ascii?Q?3a+Ua8OAk08KjdfgDcZqvOwOt3uHw3pcKvwpH9OZi54dtueWqhkanywk57Nc?=
X-MS-Exchange-AntiSpam-MessageData-1: QNaqVq42vrLFFA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5992c91-dde1-4016-9254-08df193412bb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 05:32:35.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dS20IJac5b7EFtEWBC3CSCgx+EhhQgcD3Jgm2NhtCbWyIPh08HdxbIzpjXznAk/YhlUZ52RoASTs2MZn3vMAMbDg+lvBKrW3kBw0kKDg5TyYqZd5ICEmdnxDyREaTyqvDpev+Na9hnSc1FqLBRrDfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5324

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Factor out the clearing of CVP_MODE and HIP_CLK_SEL in
VSE_CVP_MODE_CTRL into altera_cvp_disable_cvp_mode() and use it for
STEP 17 in altera_cvp_write_complete().

No functional change. This prepares for reusing the helper in the
teardown recovery path.

Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 drivers/fpga/altera-cvp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 44badfd11e1b..559191180825 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -278,6 +278,16 @@ static int altera_cvp_send_block(struct altera_cvp_conf *conf,
 	return 0;
 }
 
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
 static int altera_cvp_teardown(struct fpga_manager *mgr,
 			       struct fpga_image_info *info)
 {
@@ -496,10 +506,7 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 	}
 
 	/* STEP 17 - reset CVP_MODE and HIP_CLK_SEL bit */
-	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
-	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
-	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
-	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+	altera_cvp_disable_cvp_mode(conf);
 
 	/* STEP 18 - poll PLD_CLK_IN_USE and USER_MODE bits */
 	mask = VSE_CVP_STATUS_PLD_CLK_IN_USE | VSE_CVP_STATUS_USERMODE;
-- 
2.43.7

