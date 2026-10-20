Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792482591;
	b=EIDpfY2ATrEwjPQsTv2pXuT2i2G5uQtziTo+DopDOMfjRqIyvu5myI519uF1o732xxWB
	 ptxLjfWavoH21HsBOvapty97KJxILbBePEn6IVsbyjxyEuS65TRzkQ69Q3wNDvLKRpwct
	 22MSmgJPhHEIWtgvWcnwTUoumglfT4VZec+hJbGkQgxgjaTR9rnB2VcZk+MK8HoidsL3M
	 nermC9CAoIohyJZ6PkaPWGOuMEFj6Jw4wcFIn2xjqEdiVB/648u82qdb6FkLFi+k2FzzA
	 uMs0RopgO3z4qwPCM/lR+gXRFgOUb2p1NP6aY14yanTO9RKoSNOtwup4EoZ2efB46wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482591;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
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
	bh=ZK7drvz+7bjijml1YFkEnMFnefEPzFOO3HCsa6/dke0=;
	b=4uQik+nlXOn9XYrMubmBcnwx1qORwYWkfhBn0dYulAEDtDqOw0ztaCJHfoBA484nBCqv
	 60RoSfWVd6/cb4M4AoWKTYYMfv/az3frwA/dbyMHfmww/x0h8XKCjOqbDFrK4SMvO+HkN
	 VoiCUPUQOZ0HWxJGoDibNlb6NiCiFQ2IFHaP+7Os7RIFsvunfJD3cC6g052+1csmrzUhZ
	 8ndvp2ox5kHKDc4Y8r4WHDsVPYyDgj01NFFsuqBolwQBwcfYt+Ktv/FKGsPj60GT+h+Jk
	 KSnKHclvAWr8lt7lc8L/x4+tl3A1UHgieTKgdysPGSu5XMihFfjFvHCMFoBJty18d9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b="A4No/CEo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.40
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B0606A324;
	Tue, 20 Oct 2026 07:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F2B0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=A4No/CEo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+rMOnwOXxZYqmEXa8/CVeiPWWLeoMJOlfLB/erMAcOhL2ozsEDsbSaVMeTT/IL4qJWsSJqgU1usZwB7Dflhoz12hkXMfq/lkokvYkQ6p6UMPF/oMQFCmAX5U6xDRTgk0gJgoCJ5PWJZ6Tz5bZuYuQbLwiqv5aOfUrhRPg8YGWk5ZseaSZmY/6MPe5ya28l5Taw8aIoFtkwJZov7WN6JRNL2rEjWQp9+TgC+eXqZXJ5k2wGA8j7/MXQciG8XwInokUadaMIiuxu8TQcJKdXFv/1yzHUPySs0P9OobzegAiHxFKayEVXfGk2hiv/U5EicqeJd+XrkOF+vmPq0GhrwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK7drvz+7bjijml1YFkEnMFnefEPzFOO3HCsa6/dke0=;
 b=GTcnYkvxP4b84J7EE9jZfnqFf7kZ5panPPV81VdP/h8K+eRI6ovGnWn7R+wAJhzJcC61JgJ5PmkcTQI3MC22CRCLbuy1xwXpyXFlbk7NoKWgKmCnVCwt75wSON91/oWPhs8fZjcYGLB9w3JceRh0h6VKoKFs1UJ51TayBCZcIDFVYzpZjFCxqK+NlocXhxRG3ZM+SBokpstsqOZ7qExDc0wQTMj9xOpyI3lOUjls4lN+612uLCOcc/fIT7/FBu77YGS7hGoc3OHgfNJy//ZVVNM8IkI6kqtkEAUEmt5kZz2xwAIylrwpRhgy89JEx6H8pZFIgl8GXNv/1OT2IQXz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK7drvz+7bjijml1YFkEnMFnefEPzFOO3HCsa6/dke0=;
 b=A4No/CEoHFX/oneyryeUULNsAlzcPLEM9TniD0ubTUOHQje9KInS6CnE6HNwmtH3VtGSLtK8dANXS8BU2MKF/cAMxcRNF/ppgBVIFDpRRodZ8tPwF/8VyuPr5fs21aoFIPi/HRDZGAW2gFaJ4xlalYFWZgRi7mludeYSBB+o5Qzd2dyIUwpGuKbww0jK3HYAhFgytiaPbMyVmpwfyPgHZUrw9AxN+wJ6qafgcHM86duKYCw8cx2RKwAtuVWPr6M1W40dRwBXD88r4j05Lsb5vg+uihfo4CyPtMb5bAjv2e6+peAQe+85J9yFJmveKPSH/4H6E05rO7Ma6Jvi1cFHfw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12)
 by DS7PR03MB5382.namprd03.prod.outlook.com (2603:10b6:5:2c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 07:49:48 +0000
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80]) by SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:49:48 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: mdf@kernel.org,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Subject: [PATCH v3 2/3] fpga: stratix10-soc: use config_complete_timeout_us as a deadline
Date: Tue, 20 Oct 2026 15:49:31 +0800
Message-ID: <b7efa56cd09fb63d98692e8759aa9fd1a3a769f0.1792480395.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1792480395.git.adrian.ho.yin.ng@altera.com>
References: <cover.1790090287.git.adrian.ho.yin.ng@altera.com> <cover.1792480395.git.adrian.ho.yin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:295::11) To SJ0PR03MB6581.namprd03.prod.outlook.com
 (2603:10b6:a03:393::12)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6581:EE_|DS7PR03MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: c11f9763-fb4a-4dc1-75f4-08df2e7eb707
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	hIuS/8gTAFE2RZiUTv2YuSGoQr2WAth7wBA1LTyxY+wV85AgciB7QGVc43me+AzbsAWzGqiVTZz2/FEj7z8pIL8Kl9rYBWMlu04QLICvlEN58s8yCJE22C7c7kOCsjeX7v7NnxWX79Xq93b9QrBfzC56pW++swqSiE4YA1w0m4ORgIbHYn743buEFFU2wiqe0LDVRTxdhQjd271BTiNQTXHmD4ivAhIyYHkjbwIBk6IUr7beWmSo8ZljaEi1qQKk2Fjcy3VjO2HDVwTPNLGM6Plxhu3u0LfTdbTf1mMexSy3T4ZwSA5iA/Bb/GUjxB0RQDz3cojt/kumvas/X+gklGilp6nvawZFEJLjnay9QufEZlev+JR+ishEg5ujox4HGGs3khaLjh+9QCuxl3x3+k34EG8Wi7HcF9kQH2/8A+NwycPEV9GrhdWlq0Wi9h479S8GGaf7FvRIv3uMngFSUIZTfnPn6FVfsKGmdjN2rmzRXl/ngfVjnOx/N3P+fueFvMUQTWXDX7ta8H5V0gEWllS2xm45EzNX0AoZe4MX5Xl1yR7zr7h8I513ppxowE+6vcZcI+oePBSwkjpjPfhF9T/FBfqDadjQNDi31FUXueTv++yMKpwCt4ubP03CvSRAS2bchLzjk6DTnzu2QszyPRg4E1Gt+ShuQ/l3T/k1Akg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6581.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZN5fSr48ETlXcy+uDf3N27It3eJYgDJzZFajNSBp03mmyxweXvuldIWmDdfw?=
 =?us-ascii?Q?kGqEiXHDzyyrOR8f67ECf3QbVmAO6DTytNDXgskgXGgnqKkLQRGZMrI+OY1m?=
 =?us-ascii?Q?LsrhEZN6UpV9TI2ssBGyN6Y8r5SAtCsCOAY315t5SZs/fqQNXbsCdYg22+Za?=
 =?us-ascii?Q?6n15hPuZR6VO3Q/+zkoJFOMRXBdCTUWIbEEn84S6//wk8Gqx0v35Oo5MIbZ/?=
 =?us-ascii?Q?zn8RLyg18KhoEW8ITJlRBVVfz53DV3vYjSBsdWbTk0/AVliTuFaM69p18k3z?=
 =?us-ascii?Q?UO5oDtSQeDuCeq1WrruDKox3hTaJIY83SB/vwDrnAdCqQ8+jAsgMHbIJBKti?=
 =?us-ascii?Q?XfCgRXSVDauJTqq/f7EocTPvvNHRRC4rC7aQ6F8qCdU6EvaCIsXPl8uJ1LHR?=
 =?us-ascii?Q?EJ0MMMqQZOwOAZnCvcjiv1CgGBaXZc8s6JjdhKGtfNenqx7AD6/D+r/befRd?=
 =?us-ascii?Q?KXkv4JMm4LS5miOK3MZI1iFmsP+RKmov8iT6ofc7lc5iLXigUCnpM6NZVQ+A?=
 =?us-ascii?Q?mwaBSJoJhGgadQiRH2Ac3skMbd2MEm5kiuNroAiRM3LHq932IMC/DuUJW5OC?=
 =?us-ascii?Q?GckP4KUbeFYvmWNP/Z2dSkydZGpWXfp61RLlNpGLDGM84mWIMK6cnfMgcq0/?=
 =?us-ascii?Q?9+egN5nrE6wDRB+GlLN654Hl0a19cEJlq7GHMUhuGGrsn6E2rQxzVCFy0jXX?=
 =?us-ascii?Q?aYOzSwpMNseHVPG+luOEJoBqmovWzLq4l/Socc/6NNd1s+2SGWOE2fpq1ZtQ?=
 =?us-ascii?Q?UAo2CSo4oCSZanPuccmhHBH7dqwSlC/Bl+PnExysuUyTb2yV5xW9fLeHXSEn?=
 =?us-ascii?Q?dDoOUUiKwDhh3pzM24jYKb3BBz+m2eyoGBkpdZ48Nu9r4WiWRHmc+CPo05yl?=
 =?us-ascii?Q?4L1SdWD0Oz/v7DGINnNCgpOparuJwBEHZqCvNr+L/sCbZE3igZ12ZcNW+Gq2?=
 =?us-ascii?Q?9xR/Axwai9wY7wlxm0pUooeyR2gI4FOyE3OgMi5oEyDzEGACWaZVzp2tdHao?=
 =?us-ascii?Q?mylukZTLUjhHwacy3HCF+3vXz4Vo7IAnJA3BZcRRfDsbQ3dE7g2SmsA6tN6d?=
 =?us-ascii?Q?tu3ZyH8BGDZHE7AXpRJSASbJ1AqD69foTnjq0aCyrMVs4s7P6xtpOZe5oA7a?=
 =?us-ascii?Q?/JI3v5Li6gYsjhM+fusrY90GMXoaxkruQbOgNdcnXaq2J2tsfn0SoDUJAsHx?=
 =?us-ascii?Q?8fn2zEUJ8ERLfz2DPvYUbqhmAftGueFoF0a4Zp2VFRzTXU5uD0WQto9TRbGJ?=
 =?us-ascii?Q?aX0yyHzr2PwAMrQX4MOE1R7aC913DL78B6i7LbplFnnpMICYRKm1awSJR6XV?=
 =?us-ascii?Q?q/pAJmtfOMjrExeE9968CYDfAJEe+NiPuhalsDLnSQ+omRLPhZwRewT0IMLc?=
 =?us-ascii?Q?BsmhoqiUHrzbgAzugYmcWBJWpf4yhRxTmkwa1BXf8EmbpsATmertCarhBVw2?=
 =?us-ascii?Q?8OmCfXnD8Yoq2NaRs01gKvGGwnSvwQ9Cz/B4FvnY9RgNp63cMWnEtb+yD1A/?=
 =?us-ascii?Q?AX/txjkRbA/UfoRN2FY2ytEiNtyhsYB/xWtfGZx9EbjDCiM7W2hq4qKC8lsV?=
 =?us-ascii?Q?KLVXiua/4PD6kWiG5MKTfRzjT5XJY5hY9QozYfeLXxV9f4hEpiLuxdGNVkmb?=
 =?us-ascii?Q?vxChN/F49yjbv7vkIXxJzsrOzuzuOtdDgMPOQEpAMWPklGhcosxDI1Sj+mIF?=
 =?us-ascii?Q?5dvAeXFW7d1ElmA38EG+4PZGb+uyCj9AePo4eFR9g/L5Wsr1wod4iYcEF57e?=
 =?us-ascii?Q?z7K2jg8Bk2cXteGERBG/cR+u4paeRI8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11f9763-fb4a-4dc1-75f4-08df2e7eb707
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6581.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:49:48.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwcyIl9gGJFd8ac8WnQzQkYCq3eoGm7IzB3c7dQWhzmnzNF1MbVVfPx8O9OpVMWB1PQt4hCpv78zvhTxKxblkjDXu69XaeOalwJ68Ggwfy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5382

config_complete_timeout_us is the maximum time the FPGA may take to
enter user mode after programming. Other FPGA managers (xilinx-core,
efinix-spi, altera-pr-ip-core) turn it into a deadline for their own
"is configuration done" polling. s10_ops_write_complete() instead
passes it as the timeout of every wait for a service layer reply.

That couples two unrelated timeouts. of-fpga-region leaves the field at
0 when the DT property is absent, so usecs_to_jiffies(0) makes the very
first wait time out before the service layer has answered, and
write_complete fails even though configuration succeeds.

For COMMAND_RECONFIG_STATUS the service layer polls the firmware for up
to 30 seconds before it replies with COMPLETED, ERROR or BUSY. Wait for
that reply with a driver timeout that covers the polling window
(SVC_COMPLETED_TIMEOUT_MS plus the usual request timeout), and use
config_complete_timeout_us only as the deadline for re-sending the
status request after a BUSY reply. A value of 0 therefore results in a
single status request, as in the other drivers.

The deadline is only checked between replies, and one reply can take up
to the service layer polling window, so values shorter than that behave
like a single request and the deadline can be exceeded by up to one
reply wait. The service layer cannot be interrupted while it polls:
stratix10_svc_done() waits for its thread to finish.

Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---

Notes:
    Changes in v3:
    - Replaces "floor config_complete_timeout_us". Drop the max() floor and
      stop using config_complete_timeout_us as the per-reply wait. Wait for
      each RECONFIG_STATUS reply with a driver timeout that covers the
      service layer polling window, and use config_complete_timeout_us as
      the deadline for re-polling after BUSY, as other FPGA managers do
      (Xu Yilun).
    - Moved before the helper patch so that no intermediate commit can
      re-poll without a bound.

 drivers/fpga/stratix10-soc.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 3ba0ffa1d9e0..a69f63f0236b 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -25,6 +25,13 @@
 #define S10_BUFFER_TIMEOUT (msecs_to_jiffies(SVC_RECONFIG_BUFFER_TIMEOUT_MS))
 #define S10_RECONFIG_TIMEOUT (msecs_to_jiffies(SVC_RECONFIG_REQUEST_TIMEOUT_MS))
 
+/*
+ * The service layer polls the configuration status for up to 30 seconds
+ * (SVC_COMPLETED_TIMEOUT_MS) before it replies to COMMAND_RECONFIG_STATUS.
+ */
+#define S10_RECONFIG_STATUS_TIMEOUT \
+	(msecs_to_jiffies(SVC_COMPLETED_TIMEOUT_MS) + S10_RECONFIG_TIMEOUT)
+
 /*
  * struct s10_svc_buf
  * buf:  virtual address of buf provided by service layer
@@ -353,10 +360,10 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 {
 	struct s10_priv *priv = mgr->priv;
 	struct device *dev = priv->client.dev;
-	unsigned long timeout;
+	unsigned long deadline;
 	int ret;
 
-	timeout = usecs_to_jiffies(info->config_complete_timeout_us);
+	deadline = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
 
 	do {
 		reinit_completion(&priv->status_return_completion);
@@ -365,17 +372,12 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 		if (ret < 0)
 			break;
 
-		ret = wait_for_completion_timeout(
-			&priv->status_return_completion, timeout);
-		if (!ret) {
-			dev_err(dev,
-				"timeout waiting for RECONFIG_COMPLETED\n");
+		if (!wait_for_completion_timeout(&priv->status_return_completion,
+						 S10_RECONFIG_STATUS_TIMEOUT)) {
+			dev_err(dev, "timeout waiting for RECONFIG_STATUS\n");
 			ret = -ETIMEDOUT;
 			break;
 		}
-		/* Not error or timeout, so ret is # of jiffies until timeout */
-		timeout = ret;
-		ret = 0;
 
 		if (test_and_clear_bit(SVC_STATUS_COMPLETED, &priv->status))
 			break;
@@ -385,6 +387,13 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 			ret = -EFAULT;
 			break;
 		}
+
+		if (time_after_eq(jiffies, deadline)) {
+			dev_err(dev,
+				"timeout waiting for RECONFIG_COMPLETED\n");
+			ret = -ETIMEDOUT;
+			break;
+		}
 	} while (1);
 
 	stratix10_svc_done(priv->chan);
-- 
2.49.GIT

