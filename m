Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E833E346;
	Fri,  2 Oct 2026 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924029; cv=fail; b=ozqtScKTgFVdmeP3KCT9+JRdJQifa50de7Yr/g8T2BRusjZSCiyEzzA32rlsGz8uVmQLjZEDRYpEb4efEwhl2ukzYOPtgLnybKWKOOfyTcx0aciYq9Czqhc7wKNUbKQ/AXmWY7rrUMvDfwzIEypRxSUHRlc/QiGqsfISgiilPvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924029; c=relaxed/simple;
	bh=VgfoVIAzOEUivfSIGQT7RwVE9xni4jfHjGpyyVqfqrM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kf1Px6qfiCCtGHiLmn43h2YHjtyOg1zVzp7803m4oUaFDzofHYSbNbxrBVITPGzaP0jExoP9HclroOwHyA/WkQBGUg0EWQ+qrZw+FUR8xczabgFZOgrthRdVXwBt8z3mNFcgSWVGV7ynnVSLvSgRGH3FM2gMhdTngZ1PBLqmo3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gA8izabn; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="gA8izabn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvN3W4H4ke6Ld2aFSf3vnBOrf/d478yQx08kFrwvHEKR0eKUqW/X9WZojzEbuHBNBP5Ox55SDrLUOt72LBhVl4jJxm+qGCRa2g2+nvRxYEG+MockxpK/H7XErc5jqrRRBdwYA2VVsGUoN1Hx90+Ymsa9Zefw0o4pJrZvx24j9SWBmI4QvrAj2i5hCvI/fu00DQoY10k22M6pk6N/41zDUu035wAbcIia2h2widVAjzMZgreyg0949Y3Jh72q5G6hfW9Q4orvTzS/LimXCmYYghUXaFjmGSBTMkVIxDfRC4ip3CyuB5RRaUIlPY1H+Pvxb1gYUCyFZ0N/mzdwmXwj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BJUzPc7I1EVU0LHiDEOLID2e51QI0KaI/5h3/UKMrQ=;
 b=siRfoUXeEOBpa5DF2dTrnCLbqsXbCESTlCo3V8M0f5k83yJWsbmjPqt+dKtZMPo7Z3MtFqbQ2tpjQXOfSLURF+qxm/7Xy/+WG33xqP4KATYhaIUTaw61hG7/8mKxKAb068BKdGFYN4rw7XwRHjX3NRz06tRGmxPBnXA9V+F+XSMskIk83hGCGqsKcXGNKetcEM4S+UYh+ExxNG1nqMhKzeF+ko/ir6NX/DVSm4WEc1Sk+j9Tc442VTezL5XMZx39s4vrd1FmcUd0SkDPn6Lw8SoMBNu6aomvy7fziiM126Fc9t71YNm6QNaqSNmlcbXLIMW+F66IgFFQRCAL6HIRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BJUzPc7I1EVU0LHiDEOLID2e51QI0KaI/5h3/UKMrQ=;
 b=gA8izabnuQSeVVUb8tq7JBARjPrLGHh+id8Kz6fZT1mitHTxyl+v3JVe5Pu0A+joarNqA5MG+40HEXAR5ZwBtN2NzVzqsNeFdZr0V4Wz/RLQviR8ojmZdQJdQ31yu16lCvGD52M3+VaVwWnpsRU/8sUbVfnev82T/aPZH64B2m9h8/hgmYccPUq9sTFfL52K1KoIZfM4e8H1kfYRCrDseM4KzFhp4rI8BHUXicFCtdzzWt886rEagWo5s95JF843O9WCLgw4uUJUfHWTjrJ0XFTqshNWPVNtbFuFv9eN/1QAL1DA7LD3Co/f0toyGnKEw2GNjxQkWLXI+Rm7Uj82mA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by DS7PR03MB5573.namprd03.prod.outlook.com (2603:10b6:5:2d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 06:53:43 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 06:53:42 +0000
Message-ID: <d7dc350a-1b4f-464c-86c2-f2a58b0fe53f@altera.com>
Date: Fri, 2 Oct 2026 14:53:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fpga: bridge: incorrect set to clear
 freeze_illegal_request register
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Matthew Gerlach <mgerlach@opensource.altera.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Tull <atull@opensource.altera.com>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <2fe34c2dec61150a39d21e067521b0acc031247c.1789956938.git.tze.yee.ng@altera.com>
 <arpAqkvuFSB6+EAn@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <arpAqkvuFSB6+EAn@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::24) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|DS7PR03MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: d2749dde-af5d-4812-745c-08df2051e587
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|11063799006|56012099006|4143699003|3023799007|4133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kZ8jY9JIJiIhc6ADrzQDtCzA3huXLQ4sTa5rGv5+2W8th5TS3dzmL2FilKXH5J5M+IqkUzzxhIjGPoLzagyu9Md1iRDnUpLmKe50FrcDYsCDQu+WqFpzYJvF6mzhwll32l/zB3WVWBNpXV32lVM4DC+tLHfr4Fjr7Eb61VBirJJJAA5b1pEOoBzppWRGBEV0gULLYVNAhGAbR8T7Hxp6Q5iYP6AvO+jpum484ULeA9cLptemJ/tGXUOe2S6qFSOgCHfZxmRAmf2QgoFASiULoSGnt3645PYijJMlUQ5II41fadKzjjFvZe9jU1EE1f69JPOAl6RmT+EooaKnJON39aueIosNVjSfp6G2QdJwawAwwk4PW0DG2mPft3L/p0yTtR+qbuNYhiQ1r5V9k9XVYTcJEStfl7mgqjblY3wEhxgYbsRY1oGSqKGGrksZeciiJC0a1R0aF+t3Nys9ze7w8jO5Q61DlUnoSqHLuQbdBPRTbQAfPvxcB8TkS1YjGYKE1jHATFpudhqPktROmfry+sIVmJNQtMizwGkEXWZ+NOWxkZci/fN3wTejhVgug9q1eZ3fpJGckb3h/8BkGJx4DPOB6O5zknn+czZf95HfezGZCjbT4lKi8dETYbPNwXwdVa7jUjWDjmg5WNyjSYOT24eANULTf8wKsYv7vmaABCA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(4133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2xkaUZMaCsvRjljdElVaDhWUUU0R0ZuR3N2VjVvMVhDakQ4WUdjNzhWQjhH?=
 =?utf-8?B?RldoS2EzUkZMS0d0QXlUUjFxVm95dzVrRGVqSC8velRiSW44SzFyeXd0WWly?=
 =?utf-8?B?Qi8waTg0M2hEcGRKS1VlcVdlZVRZVWYzMStaV3J2VUQvYWs0Y0VidTRGZ2xM?=
 =?utf-8?B?NjBqMy80MHB2bmR0cG1yTGdZOHpjL2ZoQkdoblNONEZ2UnM1aEFucWViYlZz?=
 =?utf-8?B?NHpxa3RzamYxOW15dC9IMzlGcUE3TzFBKzI2TnYvK1NVZnRRbzZ3KzV2ZWZs?=
 =?utf-8?B?ZWJyUCtkUmZpaE96VkZaWHVmcW53T0IxclhLdkduWWVOMzkveldJaDNXY2JI?=
 =?utf-8?B?MjE3V0ppUE43OEFoNWZlUnNhaHpwOHdsSUpUbmxUVXgxOWhLK3c1MC9vZGFE?=
 =?utf-8?B?dTNRRmVya212MGZ5Q2gwb3VGOVRUVUJBbGlnU2xybnFxdWUxTXRLbGFnTUpR?=
 =?utf-8?B?aHhWdXVCY296ZXJoclJHZ3M2ckMvMlRad2N0L3hONHN4NlYyeHV1T21MWk9Y?=
 =?utf-8?B?aVRST0hsd083ZFNSenU1K2tOU3hldzhxWGlreFBsb3ZKSFJBbTdURmVwNDRt?=
 =?utf-8?B?d1E2Nlp2M2JNOHJtcENtdW1uTUtod0VFc2pyNnVzbXYyZmJmZmJJeHUxVnF1?=
 =?utf-8?B?RzBXSTdnbnYxdzNOVjRnTThhdzE2N3V3azgvZmlEUTd0WTg1eUZRdmtTMFNn?=
 =?utf-8?B?M3UrQm9wbktnNHhNY0pGUmdpaG9ZWlFFZ1dtV0lieDVLaWxhb0tPSHF3UWU4?=
 =?utf-8?B?cWNQUTdhSmd5VXFVd0c0Qyt4dlJMNm1ybXRQMGpWaC96QVQyQnIzNkxDQkt1?=
 =?utf-8?B?ejRtbXN0RlB0QXNpMm1MZWt6RDFpOTFjRzNxbUZ1bEllMW5iRVhrRGhaNU0v?=
 =?utf-8?B?dGFOUkZyUlFhSGFnZ2NxMEMvVWo1SlVkNzc5NlNoQklSVC9mVE0yNGFRNVdI?=
 =?utf-8?B?ckllckl3RjN6RFJwc1YzUElXVnVRUXdnK2x4eTc5VGtmQXZoUnNyaXZxMmFs?=
 =?utf-8?B?YU9uRUxKYk1Xb3NnRGVlcGlsbDZCRXdWMXhVdUVOdGp1RTd4UWlnVEJPWk1L?=
 =?utf-8?B?clNVWW80WFYvMmx2LzZ4UVU4MWhSbUtDdGpOWlVIMFJWcUZnU2RadVJwOE9k?=
 =?utf-8?B?TzUvNUsyU3dpbmgrZXc2V1c0enArNnF2UElLTFc1NzVvN2twN2dWYks2cGtD?=
 =?utf-8?B?Mm9McTR1UW55RG92Nk5RdWFoaUhWazMzNEpoaXNvVEN4cTU5K3UvenFpeElu?=
 =?utf-8?B?dDZXRm9EakMrOFlJL1R6WlJEMUpSdnBiaEk1bnN6K0Q3RkRubzhRYVpOOWg5?=
 =?utf-8?B?ZmVSUEwyd3NyNkV3R1dXT2FtVjAxSmlNWmgvamwvMGFxVFo3MVRoZWZGMUQ2?=
 =?utf-8?B?YVRTMExEU2QyVFZUZktvSHlKd1NPZU5lVllSTXdIbDZPRlJ3QmV3Vy84OUF2?=
 =?utf-8?B?bjNYSElCalMyb1NDeVU2MU53NnA1SHBXQnJyUUpJVXQ4OFJjanowM0NKb0Zl?=
 =?utf-8?B?Y0NRWE0vd3BML0ZGUEJHZm5nS0xvOXNsRExYaGlYNHU2Ry9iNERrSVg3U2Ni?=
 =?utf-8?B?Um9Lc1ArK0FKdGV3dkhXSkR0MnQ1cHcvSzJXblpKZjJYV2Fka3djQlJJdUhO?=
 =?utf-8?B?Mzdqb1BrS21ybjdJR2FtREIvVjVlL21EQ0s2ckJKeU4yM281NnlYMnpnUG00?=
 =?utf-8?B?aFNNcWpDN001VFRmN0xpUVpBOTZQZUxKYVQ3MHQyTmg5bFVLZlREOEM5R2RV?=
 =?utf-8?B?UUJNNHlZUkltZWx6VkIyZTZLUjRsUXFxQlpYZy83WXNKN1NpNlo4TFo1eDNo?=
 =?utf-8?B?bG1LN3NIWEtQNHVVVXFORUtBeWRaZDIvaTBzOHB4Z1E2bXVCK2F6ZGg3UjF2?=
 =?utf-8?B?bDhNTXJoR0Z5UDZ2dW5mdXo4VEUvTENWTkJjSlQ0VXZBSEtWaUp1a0pEMy8x?=
 =?utf-8?B?bXlKdDVHM2xXUGRKbVZQWStIaUJuSnJtUkZIRkRwQldOWnBGWE4vYjhleGVt?=
 =?utf-8?B?QnFBTU1wZFZJU095RlVoaVFyUDAyd0tSeTFpSnpKYVA5RGduZmcyRVRyOXNQ?=
 =?utf-8?B?WjdiWDhXQ1N5SitHeHUzYmNPcnVmNnFXVk5pWEVZVHBoWEtLTDJNMkh2VU93?=
 =?utf-8?B?dXJrWEpxWTN0WWZ4bmNLS2pSRGRubndXV1RTeHB4TGptOGM1RzZTYlJGWnY3?=
 =?utf-8?B?R2xlWVphUU0xbm1FVzA4NzVFRjZrcmFzR1lITlk2a1FtRmp1dG5oTEJYeWw3?=
 =?utf-8?B?UE11YU42U1pTVzh5QS9pem1xcUZvQUh4Q2Z2anV6eDY0YVBQMTNsN0dSOXBG?=
 =?utf-8?B?V0dDSStVMlVKSlhsNzYrd0hURXAxWkdVNTZGanRpVldYd29aWitpdz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2749dde-af5d-4812-745c-08df2051e587
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 06:53:42.8124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB+P4nnXEZOF2MTaNi5Kb8OZjGgwRfV5IH5/Xwa6VPShWush39S4FYqiQZIdIUsJ2+CmrJVzuGOjJGKOmNKnsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5573



On 28/9/2026 6:25 pm, Xu Yilun wrote:
> [You don't often get email from yilun.xu@linux.intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Sun, Sep 20, 2026 at 07:23:51PM -0700, tze.yee.ng@altera.com wrote:
>> From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>
>> A Partial Region Controller can be connected to one or more
>> Freeze Bridge. Each Freeze Bridge has an illegal_request
>> bit represented in the freeze_illegal_request register.
> 
> Why only this register reveals details about multiple bridges, while
> other registers always operate on all of them? And how can we understand
> which bridges are actually in use.
> 

Hi Yilun,

The Partial Region Controller fans its single freeze signal out to all 
bridges via a Conduit Splitter, so the status (0x00) and ctrl (0x04) 
registers act on them collectively. But each bridge drives its own 
single-bit illegal_request, and a Conduit Merger concatenates these into 
the n-bit, write-1-to-clear freeze_illegal_request register (0x08), bit 
i is the bridge on freeze interface i, n = number of freeze interfaces. 
(See the Quartus Prime Pro PR User Guide, Conduit Splitter/Merger.)

The driver need not track n: the read value already identifies the 
bridges flagging an illegal request, and writing it back clears exactly 
those bits. Writing a literal 1 clears only bit 0, leaving every other 
bridge latched, so this patch fixes the bug. I'll add this to the commit 
message in v3.

>> Thus, instead of just set to clear the illegal_request bit
>> for first Freeze Bridge, we need to ensure the set to clear
> 
> Imperative mood.
> 

Will fix in v3, e.g. "Clear every illegal_request bit that is set, 
instead of clearing only the bit for the first Freeze Bridge."

Thanks,
Tze Yee

>> action is applied to which ever Freeze Bridge that has
>> occurrence of illegal request.
>>
>> Fixes: ca24a648f535 ("fpga: add altera freeze bridge support")
>> Cc: stable@vger.kernel.org # v4.10+
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>> ---
>> Taking over this patch from Tanmay.
>>
>> Changes in v2:
>> - Add "Cc: stable@vger.kernel.org # v4.10+" into the signoff area so the
>>    stable-kernel rule is satisfied (reported by kernel test robot).
>> - Remove Chiau Ee's signoff as he is no longer working on this patch.
>>
>> Link v1:
>> https://lore.kernel.org/all/20250311151601.12264-1-tanmay.kathpalia@altera.com/
>> ---
>>   drivers/fpga/altera-freeze-bridge.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
>> index c24c976117c8..2591dcc53d83 100644
>> --- a/drivers/fpga/altera-freeze-bridge.c
>> +++ b/drivers/fpga/altera-freeze-bridge.c
>> @@ -51,7 +51,7 @@ static int altera_freeze_br_req_ack(struct altera_freeze_br_data *priv,
>>                if (illegal) {
>>                        dev_err(dev, "illegal request detected 0x%x", illegal);
>>
>> -                     writel(1, csr_illegal_req_addr);
>> +                     writel(illegal, csr_illegal_req_addr);
>>
>>                        illegal = readl(csr_illegal_req_addr);
>>                        if (illegal)
>> --
>> 2.43.7
>>
>>

