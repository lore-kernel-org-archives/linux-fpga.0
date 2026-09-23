Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012068.outbound.protection.outlook.com [40.93.195.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224043711B;
	Wed, 23 Sep 2026 05:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141563; cv=fail; b=BczpXe5xoyIxxyQXXYy00np+i/+qaRhrQFIhkHWpxk3bH/mjVfgDK+HOO4elbJqQfyqdswv63EW8T+Q+E/knW/28EfuxWhk1fGm7BANfNPw7xABVSWkWAYUcVI/7oMYRbU4fU6/CA/AESu4QNSJmQeB8dKPR+HO2rHfYqbpiJOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141563; c=relaxed/simple;
	bh=RdM9RdrsuOaPyeQ2S5os+OdBRaleE5Nh7PJTHmuIvH4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Adx8RR/tNE/BZfEc2IzRSpoFi03VgRlGzDXTERP+ebAdK3EqknHQbfnGGM2wD8syJ8c+23nbJQHsdXpbEMzuQJ9ydb11Cnz09IJqIUn5IZqmaQ/cvM81bJz/BMzJ6ag+eXm0VxVtn5jGGBO65DsfsqgJAOXaO9d79VUcbNCXCNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=axw5w7/b; arc=fail smtp.client-ip=40.93.195.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="axw5w7/b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP9siIuFikYgGfXhL3r2EgqqgvfaSCyjXV+mICnX4aTRmBr9xCpDufQuA5ThHAr67gKvTzdsgijjZMmTWVOEesgKXvg4hFthsDgWrv7LJitxal5jetznfEO2q41m/P8mzbh9Z9WduqBwCFCLkYbnvr4Pez6MKRz37j6o6AsvrY0l6geDwR6XViXuu20qGeJ2G5gX5+r21xncGBdw4CvmbAoW1k3/k5vscqZSIX9LM4VSH30n4JJZXkhwnF2TSPIBbT1IpaUs8nqjdnLw4RPZMRj301Ggoim43pJH2TXT0ehzM/lv9s5jZxPySg4/QlNt1TGSrySYmxooJENoaiyoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ7KgCmOouSw5XZVDpbgHH3V+WOSrLhtHOMWjDdPtzE=;
 b=Nirx2MwOYIQyGqaR7nJPUE+auO8C8DLKCO65kZFlF7Gbz7bq/aqrjN+9soxn5zh+39iwEcKtcJeGsdDhH/OuBbi+4CZj1/nsf1AzjrQm8AJ+CuLaqx3mfvmzr3a25aa7QHtcjnnVXlZ0cabCrFb2TDJw2m3IaQ7YjoZCuZ447heAgvEZ4bPrrotayOoXiTBAe+kyN6JnFzV/O+2YJj5lJ6Kcq2xEXRg9zzlJkqZn09n3fA+FDgclpdSENxke35fJFP1ZGUsLDpKThvjpryrafssIA0WWB3nE8JeRnsr8vgRGoBLOQlBXE+jlZ2+zjA6XNehgJSi+yIJgtWVf6R/mXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ7KgCmOouSw5XZVDpbgHH3V+WOSrLhtHOMWjDdPtzE=;
 b=axw5w7/bTTQSK4x15SxuEWjGJbTWUm6Jm1AnIUGJynuTeTwGpeRFLEE8taEuUl7J//pnMdNp7bxJvrw6rymUaF44m5CljDsO3lY+iZfYidXSDvRGXHODB9dg36elVP7OZEV2wCNefFbmk9vv/ThirgO0TZeZa9pxzROYnqK2PEQASpimNwQEES7BlGUz4qKMt6mJ3yIHgykh3UNvdCtgA/4/0F0Uw8aUVGvdSYnZQyUfRmlOAe+E/V5aqaNNpEeRvOosw6Q6E1mi0ikg5sgmMBg9qbJ2aKnjVFKZmYcySb8BM7kPNTipCqymFqV8NtU3NKnE7/X1bF8j9llqIYeGoA==
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
 05:32:34 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] fpga: altera-cvp: Retry teardown on CFG_RDY timeout
Date: Tue, 22 Sep 2026 22:32:31 -0700
Message-ID: <20260923053233.10890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
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
X-MS-Office365-Filtering-Correlation-Id: 185d70c1-4d2f-4745-3796-08df19341231
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dCOE62Okya2dfth7VU9yhaL1daW0Lmp5sHgh2mQjchn6ouBsCiV+NNBCuKUQKFAVQJ51oBIHfVbKYOuEG+yTwo67x6MG6ghhWDXGX7/WMfG3XR7Uva68rBOHyw/9XgvggeWXM9xnUXr65K/pxbz8fFwLJWUt/AjNpENEcNrMbvRP1SY61P/VtSCJLyfvGxWaLONeecs/lQBdGzPKz4HbZXEU887uHv+L/Ct5RUszBiTrJ0AXPROD1FKRgvSeI23HfsmTTzKox/9Cr9aMj1edWsu2tbWsmxO9fWAJAq/7VrL7fR0pQGOJe+wsn//pPp7y2F30WJJZhjosZ/bi2dFfZPimJjShbdbvXdgchhW3pBC9HVZSeCaEs5HU04XQb7/6VlpD906GrktQrfOn6zggZY+H52GLa0DV+W7mykR9MtJ+uH1O17mUNPj9swd38lOiXPTo6+N2qVvCv4zBgEddvniu/YXjA1nbPaIKgssE2NUZiiI5cpZclrPgX6rMnzJk6I+jeDFoRwytoE+biBoZajgJZzgwOHBzmLcf7eW/xeFpVlJVLJ96bpuQ1LY4znGyuA7A8L8nJH2cuyTfNgLuvDbvteTrDzlDTSolDHH0/kITY3CtejjXYQpw6EpORdfdnN9h1LTPXau32q0cuNkcr+gWf6y8V5ea7UVmdpUSpnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ej4yC2FQ8Ci2PthkDM6JLgl09kbkQknD4QYmqTh/EJRMTgTQ1PEGcI90IC9C?=
 =?us-ascii?Q?8xxghxbHbMfrExcdvDQC2R5fDgYgZiZVsF2ZR71FuzdBeYBq6DrcgZKqlZy1?=
 =?us-ascii?Q?D7/saUFfUeYsiQvBg1AfHwaa6AxmYoDQWHXk4CSs0VTMMwatoP7Ij1h3YzF+?=
 =?us-ascii?Q?cGtU11C2s8IXNMHS6sLL3Sj25LHkCp18ZN8dJDd/lpM/zaC1SIMlbfJS7cqY?=
 =?us-ascii?Q?BNW/7rmRA9Z2GQ3xSPUgray4htA6jSJP3HP7fmn3z5NFpEuHNPpfjeas97gM?=
 =?us-ascii?Q?+urnhJiCsVzq/RMjOZfi37B1sl3y5RMkNwD4redFU+uTGxwy7YuwWf5w/ZRm?=
 =?us-ascii?Q?5dXavb++ND+OocsNe3G9RzCbAZrWC7wao3C3t7mIRSSg9FW1LpT4liG6HjxF?=
 =?us-ascii?Q?aak8j5eC9wFPyNLMYIuoZ4TQmT/MlAehfcCltKAgTIebK5/CSTgVqkq5+7Z9?=
 =?us-ascii?Q?1SxIu3MJFYQFY88v5QQ5pUYh4kpBlKMblyfUbF1kGmAM/LA0rAqYgf489tU+?=
 =?us-ascii?Q?Osefo1D7QeZXfchA5gcj0tPRUN1F1wsKn45GgFIVrFY+rxkv+QUEJNqyDWKS?=
 =?us-ascii?Q?Nkm5X2/Apv4Bh68vXgilNhN0dvh/ua+GALGt9o0vJp2rRGbozm3o9XzvOfCw?=
 =?us-ascii?Q?6+/LeDZ1sX1vX8pV2BwH8GRu7bZgfzKmWhcLhqSB/T/ntjEOnNvkge3mTS/i?=
 =?us-ascii?Q?wQnRbtsbLogUoOAceXhkf4OlS/MKMemBU65T8oaVWduBB/VGatCEOpCBoxop?=
 =?us-ascii?Q?s7pJR+Bl1Es3CRKGNNx9gO4DJQxrgpDwbUGGojdTq5pinqp84+3XnNd5/eaF?=
 =?us-ascii?Q?KpTmmLU9MnWuYXPJdQldCpYKGyQTVP9Tm9UiQtIMq6tZU+5FKc5lz29wq8Xz?=
 =?us-ascii?Q?r9f5+YFgugcp2rRNECzWTqifQfRMqChXXiHjitEPPOD2oZfRrsHLc8kgb20J?=
 =?us-ascii?Q?GUqIhH2FEwwveMIp6sCDjKZL5Bg9be9OCd68SWGM1gnaggWMAq8gOCdbdhrA?=
 =?us-ascii?Q?4qYfy+NOEUhgbQjRKMpOK+QMfHAq1OeKmFpFY51WtCvYiA2G9koBqU4tlv8b?=
 =?us-ascii?Q?w0YBrb3pL0lz1HJf6d0ikFRd0okrPtcbdahmYuTd7gBPSS1ZI6wcm6QDD5CX?=
 =?us-ascii?Q?M+p5HSkvhh5eJBdrOnUScwoVxsFNk1dLGhfHpicvEYshxVAMrEd0n8smMu+p?=
 =?us-ascii?Q?+Gh6nSNd3zimvdlj02+Dpo94C/nBGm/N6pTavPaoC7/viDrpPUxEhTby/4Od?=
 =?us-ascii?Q?bUhOj8zL8MQL/P23hz3P2Js1hpS5PkzPxN3i2AzIzH0dbA1driRgtXilYLrq?=
 =?us-ascii?Q?YtCvFImDFWAc1ML9j1tT6WejBmm0NdubMpOop+HNpIIN8RNHKlYb5bZp5ozd?=
 =?us-ascii?Q?tVnQZwxKzYrNuKSE128CrqPF9nRbc8Xjp5F34b50CECWeBMWgOJBa8MzkbRb?=
 =?us-ascii?Q?b1HnBv4a2v6OUN2brTyfeXZuI6zFG0twIsGS9HA2DFPNpne/bH6HzfUxLWCG?=
 =?us-ascii?Q?p9FlFP+mx9+OJHaEz77xioqN3KpamDBJpIUGR7mUWdKou+zQLBYBB1cw0GeC?=
 =?us-ascii?Q?Y9BU2c8OpaDcOZK69jKegX6dYBCFlkDCaW6DVhVPbDknVgIwvJQeDcOxXalA?=
 =?us-ascii?Q?Tkg4E7iz/0uZXjoNfH2zy4AMFNuhXV2HpP4UOVgkPUwWOBku4jBefl/7knrk?=
 =?us-ascii?Q?gWnkXA1QXDgXRHRp3/I7IXavzlEEGl45ZVY7zWZH1dZlSqZAIg9pJUQGK+r2?=
 =?us-ascii?Q?xsevSVSq5TWyEZ7pJ3yNvPJKX+RsXYPvvqfkPhO7bseSWtVDOGQO8snaNjdb?=
X-MS-Exchange-AntiSpam-MessageData-1: bqrZ3JFb+F4Fbg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185d70c1-4d2f-4745-3796-08df19341231
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 05:32:34.7541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAQGs1oVz8waWDJjAY26YgD+ZB2W4FQJjmmBlp8z9Q+PhwTvR9/xMAgrvuVHDlV2X9rps7xVvNz0BpVM9Tu0kKDzJyz3PACvJifJ+ze7xdLhzAxkei03g3U/Z9+GiSSrIdWhBdG9gGNaAstqD602zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5324

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

After a bad bitstream, the CFG_RDY poll at the end of teardown can time
out because CVP_STATUS gets stuck. This series exits CvP mode to switch
back the clock feeding CVP_STATUS and retries the teardown once.

Patch 1 factors out the existing CVP_MODE/HIP_CLK_SEL clearing into a
helper. Patch 2 uses it in the new teardown recovery path.

v2: https://lore.kernel.org/linux-fpga/20260915062734.42964-1-muhammad.nazim.amirul.nazle.asmade@altera.com/
v1: https://lore.kernel.org/linux-fpga/20260618112410.303-1-muhammad.nazim.amirul.nazle.asmade@altera.com/

Changes in v3:
- Split altera_cvp_disable_cvp_mode() into a preparatory patch and use
  it for STEP 17 in altera_cvp_write_complete()
- Drop CVP_TEARDOWN_MAX_RETRY and the loop; retry once directly
- Add a comment explaining why the retry is done
- Drop the retry count from the failure message
- Drop the success message

Changes in v2:
- Rewrite commit message to explain CFG_RDY timeout, HIP clock switch,
  and why one retry is enough
- Move CvP mode/HIP clock cleanup into recovery via
  altera_cvp_disable_cvp_mode() helper
- Reduce retries to 1 (first teardown + one retry after cleanup)
- Use dev_warn for per-teardown CFG_RDY timeout; one final
  success/failure message from recovery

Nazim Amirul (2):
  fpga: altera-cvp: Add helper to disable CvP mode
  fpga: altera-cvp: Retry teardown and reset CVP state on failure

 drivers/fpga/altera-cvp.c | 43 ++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

-- 
2.43.7

