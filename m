Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DEA40D581;
	Fri, 19 Jun 2026 04:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842097; cv=fail; b=cfs3BblkNwD5m+3s+PZErpOZZEB8Yu2rufSE87lQuzEbXw6ll6JFyFVZCJLkvFAclWBDM3EcF8g2z7n+jFl/JucGLyzTUn2AfYafkvxuvWwQYZy4JyoiwgJWVwXit0duC4bLx/5atoPve946khsburA/jMpohgG5vpeSk2iu6jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842097; c=relaxed/simple;
	bh=QUntyHZjRo8rHuOzd8qRwFlnnlpEZWefa6ByZTwLWUg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Czut/SW12t8ANLIutAyeVMY/XVpjoE6Uh8oKGslJyoJg0Xfinv6Wc9DSj7uHHZUkMEIJ3ECa54j1z78J82Ys8iXNLPBVe029tCrpS1vCb236v69JLublTGt8PYMYqvXNYpjwcYKLmjBI1iBoOG+9EWFdRAyQOLgh4PXZevCr0nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=L4nD1A0d; arc=fail smtp.client-ip=52.101.53.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="L4nD1A0d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIpQ9+whPl2l0fxr8DQQsMO2X4pUGnzBWXssWPoS6WcwhZQpa9wQga5x/q28yZ/Tkoqy5tanA/mIERvfShPXDeDzfhUSHKo4LMFFRVCqdIr6BNtj6S1/c4d/RLecN6I+QR1HJF29KzuVRX3FdjuAELZCAMEXbEd1U+UGFCjpTlB6Qvzv2dqBySF11hgXBCro1ulvS5dOSGUmAMK7AwzGGDB4Gs/QV4aOiluFY8VMSyswq67kp8AfQgFUnvJ+1zgSe0iS/AzwsUu2+NNSTVyIotN66BX1Ll/5eEOnyAZ/gquS+gzpfwkvaVy4R4wI8OReee3/AIXbeRDxBU5l82KWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJMDMcFa5WSzA9uTgIz5VZTiQZOM+Dfwy+NTv7xOfTE=;
 b=IMHfe4c+ROngXPyo6pMlpmbap78PG59hCQHgRZ2AegMYUEGKEABQtO9XsyYRBKexIc3pnh6odQmlZSkZSf9i3NRITGcGahRB7zpSEfLVq59xn8pj8nQFUCxIwAZuQB8AdPEyCSG+Wj9ktYZ+MXtXtQaoF8oxAvkOWFLZh0z4WjthbVfTI1a3XDDwakHwbZCNmUiFSFpC16P+omKhFhCjhpOvzlugOBmkMADMwNxvm+3r9zPaLzqYhRX9hH1aPeNoS0nmlmKVDOkhKBjCEQI5QJcXZ1CW4B2U6b5SFpmaLnC5palgtNl1NxZaWsv1EahlEbvK/kJe3mjE6IKJnvJ3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJMDMcFa5WSzA9uTgIz5VZTiQZOM+Dfwy+NTv7xOfTE=;
 b=L4nD1A0d06wU1fKoo9irTObaDGpvvV5c+HD5rW8Gin3OpFztlAqLIrZwlNx2yh1qQG3echDRz05rRFranDbJCAzkAhcjd21PVklV9EIufQlMvchXn3bql6G32CosrBS2gBiAeKl0JTfBoqzpZC2jZ1aNulGA4MWXoXaRtTvOst1S1JLEiAriMISciuEMPFw4Ro1ehYLUz/eJn3rbyo13dbgY7NlMH7ciNSQ5lIZ7qOpkzbok+3b1/9dQbKzM1MVl/3VNg8HxBsCdBKygL3vkbFcMknt8y6oLbcFeaPZJf7Hmmpf68t1T6CV+yTULD0e0MqpJgfiStTsJFHwbafCUTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ0PR03MB5408.namprd03.prod.outlook.com (2603:10b6:a03:279::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 04:08:13 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 04:08:12 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: mdf@kernel.org,
	yilun.xu@intel.com
Cc: trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: altera-cvp: Handle truncated bitstream with padding buffer
Date: Thu, 18 Jun 2026 21:08:11 -0700
Message-ID: <20260619040811.20038-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|SJ0PR03MB5408:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cac41f-0faf-420e-107b-08decdb86186
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|55112099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CNSHlQl0foojNQIDILClwrbOslw/4J5AK7FLqp/6GFZfzx3JbSJ5sIvYmD4yD3BxrfMaUQxlH7JMkezvDUyUQAmKIWgOHOcDSU2WCshuOnT5nShnROoUZtCTTinKczkatXj50wBcioqjw/G3496ZDsgGDH/Zr7xmaykpGmGih3SdbU9DxxgZU+23SanpHz8EiTHHNAxV1LvXxVFEiAN16vRYUasgeO9WEAhZ2vBntmEbZ0EhDs6XSsK2Nst+k0K8KWnzlrwiCcLj3aGTl9hJknqhzISn97f618/PmlHK2cc/gU7hd14O5Om0Wv7mTERsCAkKVbpv9gbT1Fz3me6zjru5PFKnheazG98ws46rAUEFcdcdDSg8ksSRhvsm6vexfqo/JrUi+87Y86aJEuIBJLRX2nafoir6ss+y35iGVJH/fOFXzPBcKy/aAJYEmtQwGTyLE1QvjsN2kD4lvPnosqN6WBQC6oeKXiZPwa1TpFL8pTIG/ZDr58dYTGjvl23SBYHJfW+wzaQ9lTmJ4exMmeg+7YLgTS+Ih/chhZBLBSU7X55UbK340i7ycVZobS5a4DElsNKY0reJ6x9S+MTAef7iP9dNI/JYIHEsV2XM/iyS22/IewIH/yNz5nsOl2ccXwMElUhnE8EZJUT00g5yL2jUrMIYd5QFbM+BKVIS9T8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(55112099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5goqjvvOTCnH5ZXUZzF5s9L2qal1zfa7V2mP1Xpdnet6ig0TgKqHszy6krcF?=
 =?us-ascii?Q?prsK+fJn6slnU4gH5n0w57RM8O1Ikewz15WZ4pC/lf2uPrFRLbn98w/GvGUl?=
 =?us-ascii?Q?bBNyWJR5B1xHqbibSKuhFoCXbHXp5EKbg0tfKZiy4LD4pLqdGqkV7lz7zJaS?=
 =?us-ascii?Q?7ZKvRZzGwyZ+kNe543Io4Dq/5eUlFqwx4ES9hBsmY0Me14qX+96NVVyABHAe?=
 =?us-ascii?Q?XXxh5uHzQcynm/MfsdsizbsK8x0Rgg1yIVQwSK56XIAiCtg38PHKCej7HiQd?=
 =?us-ascii?Q?m/QOdoJ7/d0nkHse5cKVdLnOPWP+O/JINJ47R9PnpmdQqQ+gBUS7q/l2gZeF?=
 =?us-ascii?Q?2naIFWO2VrSb6+UjPhRwuJ3r8nPJNRkXk7MhMfngF4KtJQi2mzLV4ZMjFJ+X?=
 =?us-ascii?Q?UwwNuvWKb8JVmy8OX2XpT7BCEzE45HdPfwGKZX+6qqFDt31kktY4MnTzOaIL?=
 =?us-ascii?Q?MZCfO2eitCElSa04vgXwdmWk/FxpXlvO1fYauA9Kqb8g9LpKtt2VC/yo9WuV?=
 =?us-ascii?Q?r7ONB02CDGoatdBb8e0k6sGCVq9wAGyY96xp5NBhRZ4I7upjiWNjfAxA2QGs?=
 =?us-ascii?Q?pWx/B5dDUPb2AFEnU8aEb3JlvnrzvRBFtsczOPLmLKGYdAJBrx3chpVSyqiu?=
 =?us-ascii?Q?7fVfJpIR+POny1MY+owiXf14oFs+wRkEQqs+JTER8m6dtp834TUIRCI+dE+T?=
 =?us-ascii?Q?+F9ctIsaSCTRlWFwkv+rPLgIbloH7ldApi48PVl8RVufsxAixj0yknuIw6er?=
 =?us-ascii?Q?crBvWRMQ0MybqoFn7SV5zObGnPogdT9j3hTHK7jv4C6Qyb/9a5Lpk88dEKf1?=
 =?us-ascii?Q?tV7OFzoszdc4c0FF2sfqKlZwjwYfQN9fgGw+e6aw0qOdIPt0A1XA002oAed+?=
 =?us-ascii?Q?18ABG5D/mBxwyrd+bTc9+/V9kpf/fQiczmnLiaIeM3VTQJ3AbPIiTKUFPqkP?=
 =?us-ascii?Q?OxKOU154Hn9jWUrXFmVBsTO1gSIFQgFuhJPuv4jlrFbeCNhQ98uuxpkavdV+?=
 =?us-ascii?Q?30nM6ngyIWOOVtxZVumC0R8eTPQZo51RmLhB3+urp+p1NVYKeFl1M41tTisG?=
 =?us-ascii?Q?A9Yh7/gHpxuY6+JW9QZvFVZ7Lilz2++bGF+DQjYI6udI9q69D/Ih5IYB/S0o?=
 =?us-ascii?Q?EwM+pvMpcBEEVnxhULNnLYxxj8I6ciDlnFDnWvbdISFnctcd9NyVAlUi+/mS?=
 =?us-ascii?Q?/P/uGNr8760bcsuS5UvIkXXGK5n7mmjcL5sNBA/x5mqOaEZSs08B3jPJjcE3?=
 =?us-ascii?Q?rzbAFzdkRnWWlgenxoXcmK3vpzYYuDREWh8GvUwp+yYHKnytcyAZBT6YrXM6?=
 =?us-ascii?Q?6AKt6ybwZ0NngB3BWcT5EhSlSQfN/1UBcQI5LR3QQdb6wE5Vr3US63lt0+VF?=
 =?us-ascii?Q?WqxV6BfskQHt9wmakFEj0C7GSLqUMQSpTtN0a+zr7ma7wZ25G/Tpms1luqPc?=
 =?us-ascii?Q?H89Yj0i5SYHEiwCvnz+qQBalyvb8A5pMuu0n9uhGMDMS1WJZy/ruFTnEFoRm?=
 =?us-ascii?Q?MQ/ooxikdlJWBgFEA3YtoGTUSI3OPqSI5XOT2hmH8qGRqXfbMvbWsvclWj+p?=
 =?us-ascii?Q?c63vqMfJ0jn95mGNTb/EJAMzpbpuY8wEKY8mZxiCa3Pwj0lKct+mjPx5Ap+v?=
 =?us-ascii?Q?vutoKhvCEqUhosHhrd+2YU0tCI5bZHFhUzfy3PblfUBxh5Iy2NsAyi3PSnGR?=
 =?us-ascii?Q?AOzKVOUbYkZAIZeVP7fYN3UNYwQN3zlfJF2F4JZJjim0N6pI/tbRByQcZim9?=
 =?us-ascii?Q?Vr4mwaRVvlbjfE5+M3OnTNWMdDTSOjatpYrld5cELP5xh6HPmJip0rbGZLJp?=
X-MS-Exchange-AntiSpam-MessageData-1: /xJ69LcnofXVxQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cac41f-0faf-420e-107b-08decdb86186
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 04:08:12.8221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnTMQlaUYroWvghcr+FXw0aGHmhZ8lunPTUKOJ0D25b8M0SHGLeGORCEBpqf0if1KkJku5oPtVyeq5KGi/ttrzZ+GUaD/quiIe3+rLISmqQJZ6VX2zqzlk/21rioJGqJ3+g/Ni3sqVPgJctk5LpPTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5408

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
---
 drivers/fpga/altera-cvp.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 44badfd11e1b..36557c5a0c3f 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -77,6 +77,7 @@ struct altera_cvp_conf {
 	u8			numclks;
 	u32			sent_packets;
 	u32			vsec_offset;
+	u8			*send_buf;
 	const struct cvp_priv	*priv;
 };
 
@@ -449,7 +450,9 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
 		}
 
 		len = min(conf->priv->block_size, remaining);
-		altera_cvp_send_block(conf, data, len);
+		memcpy(conf->send_buf, data, len);
+		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
+		conf->priv->block_size);
 		data += len / sizeof(u32);
 		done += len;
 		remaining -= len;
@@ -488,10 +491,10 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
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
 
@@ -650,6 +653,11 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 
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

