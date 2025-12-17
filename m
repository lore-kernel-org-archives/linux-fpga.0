Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC681F099C;
	Wed, 17 Dec 2025 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765951152; cv=fail; b=qe2MoSFGAnr2tLrfaEO7EqzIK8x20g2cwgy+t4Vtxwf3jmL7H+2C6fyg0j8L98mEKiUFtbgNxNW8F+dMpFyI0Zx/c+7q5rVRs73hEI3NII50qkfx0h2buAbyhwCjwX4xjBpC1n6AbBsMbiNB6KxiL05C8/gFQR+Iye8B3ekpyp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765951152; c=relaxed/simple;
	bh=1XyVVs+IzCrldt0/Utxu7UL99Xhd/YzfhEL4ztt5SVs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bd3nJBBdf4bmR70gy0fpnBOYxYOUwXXPeHyKgj9VkdSGKhwTVXdqh5geQbN7ZZLQBjeo0xVgS1a+QzvXh6e5gL7SxjhFDMWnE1ZcXmo3vui68bMRVJWz7fzP/FdXjq+zgOUGseA4npy7eAJ+zBF+IzVel4cPAbim37y/VEsuiVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=f4J5CKbD; arc=fail smtp.client-ip=52.101.46.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="f4J5CKbD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPxzicqVC6QrlozsI+p203seZ5VqKPkGn/Qb8Jb40sYxwMyhCsrRc0S52aZzBXNgxUSeOFBGj2gzJNnj5Ecd6YFs9GMywNZcAyn3SrfeCTdnLQjvn0n4H9J5s+tNv33KF/eH+L6iTPhf8SPcioTR9sGhHjt3eP6VScRVEEQgzfGSFs5TSc5yLYMA5xPwGW8Ru46/eabid/SyigqwUxgiKTGSihX8oQ41iVIaBEUWqk7MOSzXplbBnXnkFEf0JyCrUD2xBOdJJ3dzA2/+/wD06Zq7as0NFrZN0gz2x3xFybOGJmKeRTeyTQL4zf0pjls6DYFBTevGBC/C/sxxsF0I8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vz5HWsDuMeutVnLtLiOOdr06aozQvZ9knVPf+lD7vPs=;
 b=Z0zc9BnJdIirks+oH2Gk52vqmhEkH2syrRLw78JCxLb7ZOayovpljpaHCbUs99t03hYV6E9OK757CmQ9m+BIAPiSuExmYemjrc4rFNwOmNf2oYSFYuHIz0CR0zqVNsaOunp8fqXYxNjCtUiKL9EtlLprjahMq9UiVHWtQNfaWDvohEyTDn7HIOb5lQczOJqj9rtoOl4BXVsefwrgsA1/CtV5jfb48jdiV/k+qvSxGg6wl3b/YAnLxPHFyJnGSGTY3zMRk9RwUdDkxSvj8mxs95m9lxefkzOoWJv12lm5XFAt33NGg7OVO+/WJh8RLCKkjTQSyIeJpV7ha26ENzwxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vz5HWsDuMeutVnLtLiOOdr06aozQvZ9knVPf+lD7vPs=;
 b=f4J5CKbDh9IF5AaQgmPzaYFgvEMTerQ8rMj+E9zmm9hkLdRXIGuJ04EN+FCm3eytkfr2gKXXE3DfJmhr5VL65eOLDruIvTp7352MgmMJSw57fi2Y9v+APscz4yLBB2aKgVAY0ZxnDayS43OJD2jk86B+TIriYIRIarFIMryBK4xyL2xVGFmPnyGkCQF0bQJVeXSKIohBF/5niTP3jKQVVRmFUQrNcYcmL32hT/a+1LQwhk3//jBlAVNVv05Vy+raH+Iz59MrvALUYAkBlzxl4wgP71lDTNmvjQbotp7ZWHXpacT1TTM6IVgwimFiFjYS2tHJUinM27ZYJJlHYHaMpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB6235.namprd03.prod.outlook.com (2603:10b6:510:ed::16)
 by DS0PR03MB7582.namprd03.prod.outlook.com (2603:10b6:8:1f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 05:59:08 +0000
Received: from PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030]) by PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 05:59:08 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	mdf@kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 0/2] Add Agilex5 SMMU support for service layer and FPGA manager
Date: Wed, 17 Dec 2025 13:56:30 +0800
Message-ID: <20251217055632.1776206-1-adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::30) To PH0PR03MB6235.namprd03.prod.outlook.com
 (2603:10b6:510:ed::16)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB6235:EE_|DS0PR03MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0c89df-43be-4910-99ce-08de3d316433
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MS94SHUyL2I2SlkvSDk4ZURRL3krZHp2SmZreTFUZ1hrWTNsVmU0NGxkZzNu?=
 =?utf-8?B?RmZVbXFwcGJkVnd1ZzJ6cXRXc2RrK085ZkUxTzVLaUZuRk45eklkM0lCUHp2?=
 =?utf-8?B?S1hDQ0JDMm9EeTlYTjhHdkZ6eGZoc1dMSnNDUEVBR0d0cWJOZzd5aHFqUyt6?=
 =?utf-8?B?MGZhRDNuS1JvV3E4bEhucmQxUm1ZUTh2MHpzOHoxazJlRnBscVBka2hKdDBj?=
 =?utf-8?B?U3QvUFRTUks2THNwbCtScGxhbXBZSXpMeW9CNHFjY2h2N3ZWcjV5MTEzVTQ0?=
 =?utf-8?B?aUpweFRhVGZvT0kyaFlQNWxwcE44Vi9DSzJBSlY3MkVNc2VGc1VsaTBLdDNw?=
 =?utf-8?B?TERHUWs2T2o4M0JoT1BQRjlwODZUYVVySXowbUQ0V2pOTTR5R2ZGb25rQ2U2?=
 =?utf-8?B?K0lNZXIwb2dJZjI5UjQ0V25ROHhxLzJTTHoxV1Yrcm0vTjVtaXM0bE5xcmVE?=
 =?utf-8?B?ZFNCeVBmUzhzMTlJTUN0TnhKVWUwWFFDVVdVVnZ0cmxXMTk0ZWZnYmdJMjg0?=
 =?utf-8?B?S0VZNXlmOHdrWmxjOUdnRkpBYUFNTFFzdWpvOWkyQjdXdW9EUnJpUFBRR1Vx?=
 =?utf-8?B?dEVLVlBaL1lsNHUzNXVMNWRlaU9GYUc2UCtxOWxobWdCTUk5SzJDTHNMbXVR?=
 =?utf-8?B?QWw5SUZxUkJJU0g5UjVYWjU2MXU5WDBlOHRsbnRjd2ZTQTFXKy82R0pjVi8w?=
 =?utf-8?B?ZTMxU0YwVzBLVVpxZWc2MTFLcmUvL0tVOHllQ1pYZGwrSHY5OHY0YlZ1YTlK?=
 =?utf-8?B?YUdvYTBpdGtBNFpVVm8zOWdvRis2U2NxQmYyZkNaZVYrRFhUT1dmS1pyZ1VN?=
 =?utf-8?B?eU80R0xoMkdZUlh3RkM3OHhOMUh2TXJPdlBSQkhQdHkvaWY0aFI2QldEK3Bh?=
 =?utf-8?B?NlBvNG0zbHBpSkQ5MlBwV0ZHMDNrSlRrZWtRSDRXOHJwQjdkSUVvQzJqMk9j?=
 =?utf-8?B?d1ZnRFBVc1pPdFRTck9GTDVvazJQLzM4VTlXTjRyU20xVEhSNzNOazl2ejB5?=
 =?utf-8?B?ZitYa3BMUFlVeEh1MTU1YUZsZ3ArRXdSaUZndEJIVmtrNmJvL25TdmlNWURG?=
 =?utf-8?B?b2VqVTBNTXVPTWJXWSs2WThmZmEyZEFwei9LVnhHbmpqVWNMKzkzRGVPam40?=
 =?utf-8?B?Z29XOHNvbEFSMXJLbFlKTXh3SWlCNjhCbks0SUNqV2VFeURzWXhEbmIzTXAw?=
 =?utf-8?B?UC9OWHpxdjUwZW9mK3Q0V0ViZzA4WVVabTJBNzRNN2VtOHc2K05QMHZ3S2VN?=
 =?utf-8?B?dWo2ME5acHhHdTFKTVZ1M0JhMnQ3UDEzczlDOEZSSi8yNDdyaWw5R2dkbXFJ?=
 =?utf-8?B?UDFCV0JsQmRjc21wTHh2V1B4dGlTdjU3ZmFXQ0FzV0NDVUE4QUd6dVNHL1Vy?=
 =?utf-8?B?U0hLSlVMRTZpcTJFMi92eElBSGJzOGR1dWNwLzJhTlYvSE12eTQxa0xRcUJt?=
 =?utf-8?B?aDBOWXpkWjducU9iTnJxNkpmYmp6Wlp4VTFLbG5XWVVOUURqa2UwNWR2ZU84?=
 =?utf-8?B?eXMxNU9yampENzI4VjN0T3RRTmx1bXZEdkdpcGZIT3Izb3kvTU1YQ3NmTjE3?=
 =?utf-8?B?REtPNW5veWxiSlhJamRLanJQbmg2ZWZrVTdqWnFWc1J1Y3FFN096UzRHSkxy?=
 =?utf-8?B?RFpRdy9XZ2xqU2MyZUlYdjJzZ2NIZjBrTFlkL2kwZkZJcFZLU3VRZ09ueFJa?=
 =?utf-8?B?aElvdjEvRW14NWQzQVFnVWJBT21TbnhKQlpvVDBEM1AwUXFEcHJaVWVPZHd0?=
 =?utf-8?B?bjBoSFBjNjdTR242eHFoS1NaN245NFJEVUZqM0x2MlZNS3l3TmUyVis2UlYy?=
 =?utf-8?B?TmFXMzErVTU2WDlnSnBtb3JRblFnM25QUFpNazRaVkNwQ1RKYVMvZnRPRlQ0?=
 =?utf-8?B?OFRNT0pscUk2MjhYc214cHFJZXZDbFVDMHB6UzVIU3ZPVXpDakpERFBySnR5?=
 =?utf-8?Q?AxhdSRpeuIWyxdRKHKU76Nk99z+LQB78?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6235.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFRCMlp1TnRFVWlEcmw3TmJqditlSnpEN1REU0p5c2hLdzlpWWR6WVdWZjRY?=
 =?utf-8?B?d0JYZEJpYWdOTVlvRlVJZ1EyUDE5ZDB4Y3E0TmFEeEtZdyt2cE9lQ3hSU0xP?=
 =?utf-8?B?MzdSQy9GSXNTYi9mbkQ2bnF3REMrZ0RuUWxkdWVaRkl0RjNJKzI4OXhzdHdo?=
 =?utf-8?B?a014OGhGVVB6UWs0R3pUNmJwdWRMakY4NC9pcGpvanM4Q3FpNG0rV2lpdEZy?=
 =?utf-8?B?VGZyM0tuWVlJd0RVajlwaklMV0QrM3pPM0E5WjhKOEkwUFZMZ2NQYzFQR0hl?=
 =?utf-8?B?VkJESlo2cTArYkphUUhQTWxxRHAxU0xXVlF5MGsvZXA0NlFpNTBxc0djU0VF?=
 =?utf-8?B?NXM1ZUdqSE1YUjdtbTRnZytEQW9jUUtTSTNRbFlzNi8yUW1MNFpLSDliWmo2?=
 =?utf-8?B?OWdKbURsVjFWYk5vZ0piZ1BzUkY0MU5EeWswMGJzbmJSUjQrY0JzWHBtYk43?=
 =?utf-8?B?bFYxelFtZXhiRHJseWhJaDNoM25rVTZQenVSdkJDWjMvdU4xTThtZmtrMEhW?=
 =?utf-8?B?SHZXMHRwMThybmcydERiYW5vbkNVQmNON0I3Y3VzZXVBS0RjZkNQU1I3cGtK?=
 =?utf-8?B?MHVpWE5OeFp2UEdpbmllQU9UbUVFRFhiUGdoNVhQUlo3NnUzM1JEWlRCc1d6?=
 =?utf-8?B?RkMvUVp1c3VtQWRJdWp4cWZTcHYvcERtellVbWxrbFZGZE0wK21rT2xLYldm?=
 =?utf-8?B?Q1YvQURRYUZkSFcxM0ZlSnVKTTFmSG4zeHFFdHJEZDlWRTd1RHN0amxOenpO?=
 =?utf-8?B?L2w2MGRNWmFDSVY4ZmNDc1JVbkt2V3FQV1hiK0dIbXVSak9weEpOUG9uUmdK?=
 =?utf-8?B?U3FXbkIxNTE5dThwY3NnNTBOTUNEVDI1TjdZVVZDM1JnaDR2UGcyd1g4Wnl0?=
 =?utf-8?B?VGpna01DbC9CNnR1NVQrQlM3WlFBVE9reTFaWWprYnFLUmxUL1VWcGdmaTZ6?=
 =?utf-8?B?M0ttTS84N3FUeWtib29JbHdmTG1nTi9YYVRnTGhKc2ZVK0d0cGdnaUJHVU5M?=
 =?utf-8?B?SkZwa1pQSXFta2doakxYVC9DUjRTZ0tOWkcxMDJWRDZqL0ZnazNjNnJqWG0y?=
 =?utf-8?B?TEtMekd5NWlJdDBid3dyWkVzRk95Tnp0cHFralJFYm5WdFN6QmQwcmdNVi8y?=
 =?utf-8?B?RytlTlovNEZyOFRxZXZCNmdxQThjZS80YTRxV3o1Y1hqd29WOVBha2pqc2Zk?=
 =?utf-8?B?KzBOTDhabEZaeWowZjdnblY0ZjltTnNqekdGYjVLZTRqRG5QQzZrVUJNQ0p2?=
 =?utf-8?B?cGFydVBwb2RPeWN4dldaOFRYcnROM1lPbHJtQm5uZDE1V2QwTnNqeTZUS3Ro?=
 =?utf-8?B?L2w1RmZ5THN4NFVLZU1JRVliWEdrd29yOGNYeC9OTzJuT0kvT2V6Rk8zcVdn?=
 =?utf-8?B?cXE2UUpzZ2VnRmJsejR3WGdwOGVxL0hkTHlqc21sVXpzRFlkYUFreCt4b0w0?=
 =?utf-8?B?cTRrNUpWNCtwRDVKb3dIeWFjV2xCc0VQa1lLY0wvallxRnpVZUFZMFY3RWI5?=
 =?utf-8?B?L3dnMGYrM3VxWXZUTGlpNGZaUVJGc3U5S3hKRUdqd2pCbGlkdXRoMFFFVVRF?=
 =?utf-8?B?ZGptTU9UQS9RVUhDQkZkcEhrSk5QOHU1L1lQd1g3V29VZ2ZpWkdUTUMzR3RJ?=
 =?utf-8?B?TDR5VnZQZU1ab3RUMXl5M1hTZ1dOY1R5STlKVnpiZUJrU285M0t6RGdnbGQv?=
 =?utf-8?B?Z0tOemppWXIydnpReGttMzJqS0pzWXJ6YUZkNFNSUGZFcFpaa1BWbG5PdUJn?=
 =?utf-8?B?OS9YWlUyV3I0VWZtSzBXWEJRa1JSQTVxdWM0eDQ1Y3JtTkpyb3RKa0N2SWJW?=
 =?utf-8?B?K1ZabXpsLzFwbGpudklXRW56QUZyNlJoQzdRdWNlLzVlbWpHYk96SjRPTXJ1?=
 =?utf-8?B?MkpYUE85dWNyMTVKWUduYkpHVlBiMlFXOEJnZCthVEJLL0lNTkF6Uk9YMmc5?=
 =?utf-8?B?T2pIRTRkYWhBd3U1RDlOTER5dmxpQ2dMNnRHNjF2dytkdnRJT01oNEZLaHdB?=
 =?utf-8?B?VkgvK2hrTlpCMVNNM3ZzUnlhZHZhNk9wdnB6WFJlejU2c0VaUzhaQXpIajh2?=
 =?utf-8?B?eGcwbnhiTG04VWFkcWV5YnBFMTcyV1czWVJUekFpcWZKWlptaUhiSlNCV3FU?=
 =?utf-8?B?elFxclhGMnVqMUttcE1sM3pIdEFmeEJWbDhtenAxMTdicFJmTWlZRGkwTGQ2?=
 =?utf-8?B?Y1NacjdXL0lSY3lFKzMvZzdkemNJKzFDbCtwd1dIaVVzcmx2YmlEOUVQMVNN?=
 =?utf-8?B?Y2hBcW5FVUNIY1lNb3d0UGJZMytqK1JBdDBadnRIV1ZCTjM5d3dxMThMM29m?=
 =?utf-8?B?cEd1RjBYN2NRYWZ6T0J4Y3g0NWxCZG9ZNDJ5bWV6WHFWbEh5U1NFVm5XcHVT?=
 =?utf-8?Q?Pjfcgg1oSZvLG/C4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0c89df-43be-4910-99ce-08de3d316433
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6235.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 05:59:08.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHS0zJTLidW2vTkJ9MC3eaxVasvuAd1JZAZOGxucDFuwIOLKsvqGjsH2eIFGzB2KovbmxHvYGwfq1zFmCkvj/5VZin/SmTMpKax/E19fl0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7582

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

This series adds SMMU support required for reliable FPGA configuration on
Intel Agilex5 SoCs.

On Agilex5, DDR starts at a high physical address and is inaccessible to
the Secure Device Manager (SDM) without SMMU translation. The existing
service layer and FPGA manager drivers do not handle cases where the
SMMU remaps physical addresses to IOVAs, leading to translation faults or
configuration timeouts when SMMU is enabled.

These changes make Agilex5 support SMMU by enabling SMMU-backed buffer
allocation and IOVA remapping in the service layer, and making the FPGA
manager SMMU-aware with DMA mapping and persistent buffer allocation to
avoid repeated IOMMU operations. Together, they ensure robust FPGA
configuration on Agilex5 while maintaining the existing behaviour for
Stratix10 and Agilex7.

Adrian Ng Ho Yin (2):
  firmware: stratix10-svc: Add SMMU support for Agilex5
  fpga: stratix10-soc: Add persistent SMMU-aware DMA handling for
    Agilex5

 drivers/firmware/stratix10-svc.c | 160 ++++++++++++++++++++++++++++---
 drivers/fpga/stratix10-soc.c     |  67 +++++++++----
 2 files changed, 192 insertions(+), 35 deletions(-)

-- 
2.49.GIT

