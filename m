Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B81563FA7;
	Tue, 22 Sep 2026 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093001; cv=fail; b=g168M5s7e1GtZDQqKlJsxVwz+sH0ULFJtok6rjY9Rz+4ZZadL3AuUNW5wqknwXti+5bIFLdoWnhCFPFUR3Un85h/HfP0EyzSL7O+iWoqblm/Xsp7L0RcFMYaq100t8Do9z1tAKN2/1T2zlvfV1NILrlpIW7BoZtMvKbWNlop4tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093001; c=relaxed/simple;
	bh=tpk7nb1O8UvWMbyIIDaB6zea6/ld1kfa/UHbXj81OWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iamqjAIUp5r8faJMxsMjPyqy9KCI+7cfm0pN+bR1POC4azyZAgvigYq2JuqnlD6doMrX2QlBkHqFTq33XGZQs2ltWfk7YDRda78aMvZNilTTQ8nwKEjB0QV4aX7g8mjqbAlhTipObCQwiHF0oUT9gPg7fLOXfW53OE0Oqh4gmYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=egvWSG8U; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="egvWSG8U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ik6ZawNuUnr5YLcNmXR+zImmub8U+FoOU4lngHL+YVQjee1yku/XWpSSN9pvEz3LElesdg0MBtwdVC41UZLGzUh9StxlS+ZM02NWKj3hUhohKsri8Znh+NDESk4pbNS4qgni0s+SVhwxbt2hfFDNtGvN9DolPIz/0w7iNlI2TWxxP3u/t9qjd4OPvJ9oQS/DFuYOBU0pVBg1MKUYJWRuKKVFTqynXqqxhJD2Bl10lXArSJShrZkR+YgSwQzzyjppH0wiHeAQ0nJ+2FLSeZZovPa6veqqVXjMo20yJp94OmygZV17a1vQkKMo6TU4aW5rQPmDw6LSfA+HsShKxWaVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzqh5tx0Re8YWTO05rh2TKHGDFkQ4HqLSaHb4+vsb9E=;
 b=oWuQSZXGHWCC33K41pE2uu/AAKgNF561agbuDFvkn9BPFyPIOkzQiL/4x7AHg51adxqeZ79qzXClSWwqw4iQcqFu9Vvhpdf5xO6XpgYqWJ0MyR9GGUyGsZWV97PPDt5DVrEnp+OBeFWHiH/mW2xXiOf8ix2HbgE3FadNyzLi+EAosVzXHJmpWlo96AisMWDX2GuZxAJ4cFryj52Z3q7+VaGwijAeolF3z8n9cy7iOabNMhQ/dqK1YlhVUpGP4cLSqNXnzHeqyd9HSNnPlxVYizvfo6dMP+LUF/OSrjeyS2BPuOxIT2M4+/RryP1hJ1TV3QnckiFDL+988tsCxnwfbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzqh5tx0Re8YWTO05rh2TKHGDFkQ4HqLSaHb4+vsb9E=;
 b=egvWSG8UXiNpk6dpUSeuEEjkBx6QAqyl3VXdPkvTd4/PQ7h8nyTS5jwSSV85ZyK14rPEJkrfne4VgEc3qyxFpFpRsHxQqlod1SgWld7FHtJJMKKIhpq1Qr75ueqUQtvDTQOaNqaz4qAHLWIJcBuMhzO43yZKw2IlpiVAf0oafzJ6fADD3opbOD9if2Osig1+rWRcj9GLUO234n+Vl9dFYw+FkM1dWJuMokO7aHa2+FgtEWEOwIvEz0zVdNiIhEZKyLV3KwgVQ3+OvhLMWvMeQk5X8Ps9GXzNn8MxXxJNrMPG31pYEqPmP7mJFYsc/cR/e8vc5nn3zuKt0WagQwe41A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12)
 by SJ0PR03MB5918.namprd03.prod.outlook.com (2603:10b6:a03:2da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 16:03:01 +0000
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80]) by SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80%3]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 16:03:00 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Subject: [PATCH 3/3] fpga: stratix10-soc: floor config_complete_timeout_us
Date: Wed, 23 Sep 2026 00:02:43 +0800
Message-ID: <c2dce10175d54bd39fe3a9dd1a0ab783a62095f3.1790090287.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1790090287.git.adrian.ho.yin.ng@altera.com>
References: <cover.1790090287.git.adrian.ho.yin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To SJ0PR03MB6581.namprd03.prod.outlook.com
 (2603:10b6:a03:393::12)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6581:EE_|SJ0PR03MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e115f37-4e1b-4e12-84cc-08df18c2f9f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|55112099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	0fY0u38slfWSI4J0oj7USWfqgnf9q6Z5/l1pVHZFpU7POJd8timEch1k4aAfZert6njU3JWrx0OdzQs1z8AHcgNseDFb7jV71lT1+gj0k/dpNv8DpGU3B7S+0TKNxKE8Q43qnLMYdbIKCUA+uMk9b1DeFAbydQoZaKMg1FEBWcatIreazvP9Y+GtSdLpOlm2UFExCzTIHuyOSmdyLtxBMIDYKFR/aTH9zqAfBPhVE6tK/dXvgSua1bGW7eX9+Zb0fHaAL9dEeD46HAr36OMYtYr1Ed4xlGNrjQZeSj51/o2xqmtAy+G/fNAdGrbf8f2g4bi2wWkw8AJO4EV6n+tDT6U4f6BRjU1pGsIOH233e3Yn8MYnAbzAmj0BhoG8E+5yc7/P77c7Lbyvf6N+4dY99TBG6Btj4+sZyjQIe9GQQrEPjgiOh7RYCB6DF1ipyMfR/SzgKL0XiPvhspA5LAevriLHqAyEDWnFif4ohlygEAqbnrDdH/ZUteB+1XlQPx6EMtZ2nD+/JXZCh4HHO40Tn5EFrTMnBlMH9jCy+yQYEP4owhH9vB69MQb2YDYqJog4a4mZau5f2rzIZB7p6bFVAyMeOBn4ugZHZE97h/cIiqDiU66W1hSfsOAfn6WZXxNQUZwbrhcaANpCpywhKfUwtMRsdgkquHTyrtlNzTEepW8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6581.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(55112099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GfvjijtobL2S8r9LuIVQJqDUqwZzkRu95UQdURFjk3oihBMRXYgXurDUVzYo?=
 =?us-ascii?Q?F9nlnRNKRX/10bn++M/jZPxyZ5pdPRQaYmDhliWk3N6BCQSV2qc+owmWzguA?=
 =?us-ascii?Q?p/c1hfckpDsehCsb+NdkzHTK2ZPKNFnKY5UyZsUmL+QiFBQLANTCusrg7OvU?=
 =?us-ascii?Q?jHJSTvDetyBKLZ8lt51+8oNFHF1ZNqLuwstW0dMOaBUstbeBiTUHOpnx8yE1?=
 =?us-ascii?Q?23QGRDiO8lIVSPj8ZtEQXqMP7cbcRyh7XJAifkywBoKv5EDVhkJuc1K6NdIl?=
 =?us-ascii?Q?+94NMaUIqsmleQo80S4a/A97Vl1Uvu9Kj2KxDS3C6x1yadcto4Pq9tOGsEZg?=
 =?us-ascii?Q?R+j6qPrO1yV5F2ryfws/unQznZrlD98ZaBRToFSC674plSip/POBECycxZG+?=
 =?us-ascii?Q?qFRig5a89KNkkT0Ad8zaQaA9omI/dmJZCLkK/HYeU7tde6lw3u53g8ibB0Nk?=
 =?us-ascii?Q?shuTcH5+WkEAudsf5eGnBQQP0yPecHtYIBWLu0VNBQAJV5mN63J/SeSwqjHW?=
 =?us-ascii?Q?Lu32jDo2acXQvGrOQ7rGI1dZfDUw5TGu91rmpemHB2eyRC9saR/WpdnCi6vs?=
 =?us-ascii?Q?jMRLByd38Erz5/wJ8B78w4lMbjs4pj4j3hv++Knji2zcE0Y5FMkYkZSsSsVy?=
 =?us-ascii?Q?wgqKTOCreWui4djStomRGpnGBWLi5wlu3vrA0ann9E1bGJdfHUuPFyHrfigR?=
 =?us-ascii?Q?J1bModSc2B+wKs6XSFGlWnvsvsC1lxvvQ/iXwKBSuw2QEv/17idEeurOUyH7?=
 =?us-ascii?Q?myTdIeTAkCf8dgLILE3HKL/KDGRk0BsKVuwkMlMEC3cDrFhiPLZViB1j2b/I?=
 =?us-ascii?Q?H2MP8o/ofGklT2UVUNg7rvMfhKn4hwhJDKa/KV/HT8lZWjDUTh86WrsRYjHN?=
 =?us-ascii?Q?K71xwEikTVfyJt/uqEPoNujohAV7Z7gt7o8rvwW4m7HyaaEE2wsmhPd2/6j8?=
 =?us-ascii?Q?RCabKPiMzloR/4M6P1VYCe3DQx5d7LO0P3BrIA0p81kmCwIQRsYcRUJo9Lf9?=
 =?us-ascii?Q?QcVQrtknRd7JyhNOanaEqYtbFCCFgxIK2FqCbL4S+NlGTHIV7K0sfh1IaWEJ?=
 =?us-ascii?Q?QQOXyDvlk1bqmI8zh2ItExzEcIeUUif3Srmg/7/rOFu+ExAYgRJ6ro7VEf70?=
 =?us-ascii?Q?zPMTlt7wLxmz7c6vd+MyP8pKnyO5DBY/dW3gz1jXDgVDW419OMO1s49yPbhG?=
 =?us-ascii?Q?wmuCNwvXjIBljNizrCMkUSON3z18z3h33Evw7JvKz+f9DCHUNwqvy8Rf3mcA?=
 =?us-ascii?Q?pwvfJvxX8MJtO+68J5Nj+PQsSQg9WV2GaDzPAb914laljCcVdqPIwwOCvpkg?=
 =?us-ascii?Q?1RXBWCWAMJmbpuXzRwX7WswsHb5heELBvMWP7ie0wo+FWWj+6L7s5X3teevf?=
 =?us-ascii?Q?82+DgmKt1NVkWWnrC5ZeI5Li2KWybLjfzGlegnBeIPeyscKkwrMOPsJZoNy5?=
 =?us-ascii?Q?ZHN9k7Dh7DEAFEqDF2q3YyRFd9zR9SHBlq1hg70Dcnu/Kmt0BKsEgsNLmuWa?=
 =?us-ascii?Q?/akW9/eO/UgoqXkr+UbhhyvaNjnBU5Bv5fJmAFXEiYWHJcWLdURYUbh0FTY1?=
 =?us-ascii?Q?V6yXCTZ9WeP1wzftiCQupTeD57VOzbGALNV2X3/YifLLougt8vWkN68PemS4?=
 =?us-ascii?Q?Rp6j6u9BCQzketeIdgqylfBaXxSQPqJ8tBxizDsKhXM3IJpdudaKrRiicAYx?=
 =?us-ascii?Q?wdc8reDIPyXFHAv464ZGcKTEx9jNWZ39sgfTnwwMKWyDSNq+dB16EjbiO/sY?=
 =?us-ascii?Q?hvbuUTKfpTZgA9JGUUZkpDtO51AD5IE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e115f37-4e1b-4e12-84cc-08df18c2f9f4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6581.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:03:00.8020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVrJu5IjfGAp3fxi9ylutA2A23kaz5bLDzKFSILJ/h7r2LjBIKBIUUOJs5CGPSvZmu3LdzqZ7oQhwdJd2ttU5S/oolSgkjQGPMCCIzhdV98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5918

Keep info->config_complete_timeout_us configurable. of-fpga-region
leaves it at 0 when the DT property is absent, and usecs_to_jiffies(0)
makes the wait return immediately. Reconfiguration also takes ~600ms in
practice, so enforce S10_RECONFIG_TIMEOUT as a minimum floor while still
honouring any larger caller-supplied value. Note this prevents a DT
property from lowering the timeout below that floor.

Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 drivers/fpga/stratix10-soc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index c16ed571630b..83590e6b405f 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -7,6 +7,7 @@
 #include <linux/completion.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/firmware/intel/stratix10-svc-client.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -360,7 +361,15 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 	unsigned long timeout;
 	int ret;
 
-	timeout = usecs_to_jiffies(info->config_complete_timeout_us);
+	/*
+	 * Keep config_complete_timeout_us configurable. of-fpga-region leaves
+	 * it at 0 when the DT property is absent, and usecs_to_jiffies(0)
+	 * makes the wait return immediately. Reconfiguration also takes
+	 * ~600ms in practice, so enforce S10_RECONFIG_TIMEOUT as a minimum
+	 * floor while still honouring any larger caller-supplied value.
+	 */
+	timeout = max(usecs_to_jiffies(info->config_complete_timeout_us),
+		      S10_RECONFIG_TIMEOUT);
 
 	do {
 		reinit_completion(&priv->status_return_completion);
-- 
2.49.GIT

