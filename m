Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945D3A9D9A;
	Thu, 23 Jul 2026 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785471; cv=fail; b=XSu2WMS9mzIi7L/cBOplD/8Nto0dess8u/sfv2/YKmP7CdhJyMK6WqgUm5rEfaw2a/z5ULdBfxQbJbBpawpMix8vw+O6uAIi6O7IkfqKldHR7AHlRmGyjtnJXIgNsaJFp/mKCc+QgGhc0FQITcXDU340q9T9fL/mdlOEKLcy7hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785471; c=relaxed/simple;
	bh=I8yptN3+wQ1QF0IffiyMXcq+PD4RYwiSreq0PTJfcoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=My/cp1qzvjPN8iZi+PRpxhKks6hSPHd62puVbG3Ux1ex1sRYmgKwJ1HO3HYFtENiVUV42yhEGwp4Y1A5E4KzhEZ3coTQFqWkZlJUJYneWXi3/npa0xlAHpTd3JP25zVyhfi1rYRVZ+IjGp2xBA3zuhy7GISzDTzHOJ0terQ52vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NlFAR3sh; arc=fail smtp.client-ip=40.107.209.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NlFAR3sh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqLHZsAxQWvV/G9gPiYZQldvqUWYkTbD78UYceEGNBq5fQVN0RwYqysiWTi0x7pH1n2uwe9OfKbKBbZWdTuO8rtbH4bUXgNleURxuWLqpCY2vytEtEu/AmJCP++OvWVBcW+J4L6o7ohUcrH4tYPSC58+Fh39EOxQh9G4kG1TurcHWUFdZerqZ1Ykp1+mk6gz2qfXKOrgG+tlaq0kYFLDJuDOnwC7D4X24JK7ZcokHqMr/4eUrVdjvlysUdKTpWog9eA9Dsqr4M53S1EljLh739wC3iphuh52XxN7n7e7H45Z/ncX5FNucJL28fBRQqYpdpgeQtF/SUL6XnuAtpnztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ywhcr7bw9efB0E3D0EXiysakZzv820F7Q0ZVijDoXD4=;
 b=vi5sV9qC4biAfCHu9RmEx336eYt2s6HvpE4wMFJg/OIviXomIr68dUY8mSAmRfMZvkndErssIY0CJNuOJPwmUrjexSGXFJ2V/j417GMrJd3pG3r1alSPn30WOGjFsKgd8Mr3UB+tLQ6RIJEyOCY/f+vnFOBecatHsrkIf2gMrkNR4hIb6lowfJiQhumfmCIZK4if916LuHoe64NWxLBbFKxk/ve1trX810D69D0wEBX+FFuQVbtUVfpuHUSIo5p73I1o9bovhSP3f7MUHrCe91NypG8i6EekkOqSTJcHh0cl1U3jKJKtRJeIUXSbeZCqkZZUF74hZu7yUVe+KiW8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ywhcr7bw9efB0E3D0EXiysakZzv820F7Q0ZVijDoXD4=;
 b=NlFAR3shnUCgmHbGEUGmJPpT97J4NjCUCdfRZLM4ps6ZGSflmkmy6iQ9sghAmZPku6p67lXI1d4gZcNjVsMfQwoZCIEngR3tmSMu+SkN88uNMLqu6PyK/Ira83l9HAbxLOgh5FiJlId0suqts659eEpoOmWZLTMKGXP5R4M7E40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 05:44:24 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 05:44:24 +0000
Message-ID: <98e8e7d4-38d9-4587-bf11-0e862f87928c@amd.com>
Date: Thu, 23 Jul 2026 07:44:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver: fpga: xilinx-selectmap: add csi and rdwr
 support
To: Heiko Schocher <hs@nabladev.com>, linux-kernel@vger.kernel.org
Cc: linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Xu Yilun <yilun.xu@intel.com>
References: <20260721114258.3324794-1-hs@nabladev.com>
 <2758c5dc-91fa-44a0-986e-1258afc3dbd5@amd.com>
 <855f458a-60d7-931f-9ef9-5dba2b2d916d@nabladev.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <855f458a-60d7-931f-9ef9-5dba2b2d916d@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: b91fddd6-2d0e-4558-d60f-08dee87d739a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1LNW2TP8SKQ9oXi3jnPNmUprmO0GXPlBwjdr5+jV/O52NyIHn8BJVt1mqR3C0Q44fu6DmsKRWz9uoZQE6rffyU6tGmc1+NdAzfW47ucOcSiupJUklh2hjAiT2UpmQaqsltcwxKnV16HuDuA5lulO9OUxn4UbNRMTfqAcBwJpx4ZPGKb6fsTQLI4GMkIgMzEPz4xFOPkWrdumaLdgFv0DJ3tr1K5y2+2Ln7KdSjInAszzyAphvzvL6W3QHGJbqngGHwDbBGUs8F3op0pkohvznO/ZnFMrdb5q2hVTehaRuvyWuz1DCw3ZrOxwtcubH20BjspLdCrCHaKD33sN3KhCHM4EhsEh3mHrOYKvNcdqpY4r6+KY711AYa38tsyCCv/I1MifNKpaQGbUzPHkLqYMBmPgaork5peSQl//QTKFNrdBkfcBadWcdEvh5J2SmM2A1QQ7WW4ARxIzHC0yOZyKrK7w10+ZBBbj9vFzX/85sk/CvCVKSCEmtLkK5L2f00/QePqR/jPFESTufmBF5wOW94/cn8V23P4a9T6mt53lwdXR0K9oIizPPJeo+eHHY/4cfkINm2rr2VjWyk82gJ5luZ6dROyPG2i1SJNrf3MC/9+Phcy8zNuVLgfttDLoo1lVptGt00FXbqIDxiT7MngTDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qmd3QkhMK1lUa2hmZ2pwdHJPa1VwL0FuV2RLRTRSelI2VytYS1R0VHBiSk50?=
 =?utf-8?B?TTdWWHJyRnBtNG51cXNzRVhHWXJMRXJGQ0w4RWt4TFd6MUtjN3dQMzF2azVt?=
 =?utf-8?B?c3JtT0s3UVVhNkRiT2dHVVhwMURrcUxyclAyVysvMk5uNTNYZy81OWJqbmFN?=
 =?utf-8?B?dkhGTHlXRzdjQXByOWhiS3Ywc3Bhc3lnRmltSUhvbzZqV1pSQzkwcDA3R05S?=
 =?utf-8?B?OVNSVnN0c00yS3lnNG1DTVAweW82Mk9aSkYwVkVuWlE2NHdlR2h2a3NlN2R6?=
 =?utf-8?B?K21Ua1hocFVCd09Mb203cFhoWXNuc1VXUUVOUDdsSXMzRGNYdjEwT3lHM0My?=
 =?utf-8?B?OWxiNTlXaUtxdXdXUHdjUnBmdnlIMWsyN1Y1U3UzWTJLNVZhdDNWWFF3bndZ?=
 =?utf-8?B?OCtZOElNS3JUSU0xQm5jNGg3Y2dmbUV4bk9PYnE0WmZvNHd1ODFmbzMxcEJp?=
 =?utf-8?B?OEYzd2FjTGxmdGdraUthaEdBVDBsbTErazQ2bVBackE0cGt1M0xRTWNzdjlR?=
 =?utf-8?B?TERzZ0F6ajM3cjFTVnpVTEJNUFpLUDROZUxVVndxSFlkbG9iSzNNNHRJQjdh?=
 =?utf-8?B?aUozUzA4VVF1UDFsSzdNdnZKWDhVQXF6THJma1Q3Q043T090S0hyQk1BTWdU?=
 =?utf-8?B?MjdHYU1vMzVMSkgwMHZYcDRRbmRoMDh3dE5WWGlRTXNEQ2dNSjZjK2hjZ252?=
 =?utf-8?B?U083K3JoY2Z5V0xLY0VTWEkzZnBaMFR5L2lSdzhIMk9nMVkyaGI5aW1jNmZW?=
 =?utf-8?B?dDl0YzlRN0NRc0Y3SXA4Sk8wczFBTmJjME51OWpsTW4xOEdRT3Y3dDhNNEh2?=
 =?utf-8?B?ZmRTVmszbmNTai9HS0J1Vm5WZ0hvdTFJS2Zzd251NzlTa0hYRDdRNTJ1SkQw?=
 =?utf-8?B?bzRMMHVLeGw1NEQvTlFXRnhIWDlUdDd1ZEdqRkhVSGtKd3ppT1pNSHdITzd5?=
 =?utf-8?B?T1ZCT090VWpWVWpiM0swNHpxSC9FdVFEZksxem9qblFsUXhQT1huNmN5UUJs?=
 =?utf-8?B?L3ZnODNkM0p4MTN3K0I1SGpuVGNud0ZuVDV2eTM5cmxVNjR4ZkEzTTlGSXpO?=
 =?utf-8?B?YlVQV1ZUOUVQcXZCS1RTaForUEhBSDduWVV5ZlFGMWRpN1NVckxnZ3RTdm5Q?=
 =?utf-8?B?dDNNNzZHNHlQMlc2RCtmbENPQ3BjbEZCWUpJQWdLeUdLUXVSdjY3eSswcE4r?=
 =?utf-8?B?cmRYUFZNcXY1WlREbUtDZUt4endGSkpEM0Z0TVFoSzVxamVDVG5iaWZaa0Rv?=
 =?utf-8?B?UkNIY3MrYUkvTlBSd3ZsT0crQ0JQWkVBckxYZnhwZVA5Y2dHdnFBd0xRNCtj?=
 =?utf-8?B?c212T21VNDV4VDR1SDZXSWU0aWVmQU5kcUNBazUvZWJpUnV1R1lCV0VsTGlG?=
 =?utf-8?B?VVNXTlFjV2NCTng5R3VxWFlkUUpMaDZqZFRiYjZxN3A1cjNIY2hockc1RXVH?=
 =?utf-8?B?bFM4WkZQd01zY3dyc2picE82TWdkREhLVG1UNGhYUU5PNW5hanp3T05BZVNS?=
 =?utf-8?B?Z3FQZlF1QUtIMy8vbW50cDRPWTV6OEdXSVpHcC9EOWhGS3ljYmdHb2hXQU1o?=
 =?utf-8?B?SDhoYmpQdGx6ZWZGdE5ENFBCTmdoNUh0cVhsQXF0dVM0K203R2ZXWE44bWU4?=
 =?utf-8?B?ZWZMclpWVlBQZzVER3R1WlVZQllQNk03NHowWEtNU21KbmVnTGJQTFRra1ZN?=
 =?utf-8?B?V3h6SUYwQXNMdWtsYlVnM2dvUExHZk0rZExPOUZkaW1BQnYyc0tLNXJ0cFFO?=
 =?utf-8?B?VExJaDdkdXNMem55K09YMUFRTlV2Z3k5VW9ZMkJiWnU0LzAxbUhpVHZpTjND?=
 =?utf-8?B?V2ovRjI0YTU5TGswVlBoaWYzKzRQQXk3OGdBNVRiQ0V1YWttNDlubE1jTmVw?=
 =?utf-8?B?T3RUZGpjRmhEN29yT1FTWHMvb3p5eTZidkhQY0p2L0xQdHBKVUFsZ3lrMmFB?=
 =?utf-8?B?QytPYkVRM3RkUm82cmRVMnFxWnh2MUthSGU3ajV2SDgyc29LVXJrRXQ3NjNJ?=
 =?utf-8?B?SmVrdzJXSE02MDVkVnFhSkltcnZ4TVlxR3RRQ0t1OHdrN1pKek5LdFFpc0da?=
 =?utf-8?B?dk8xVTJTWTNQZWFjUktIZlRuVThpV3lqSEV4MTdocFg5T295Vkc2R1NyaXJh?=
 =?utf-8?B?cWhPTmRpUWNSVXNYdCtoamFVQTFmSEFHbU9aa2dqZ29BOTdwb1pvS3hManJm?=
 =?utf-8?B?dzFsc3lVNUloRTFoZnhBbFduRkd5OUhXZCtBK2RGSmFmNnB0dlN3L2xCWS9S?=
 =?utf-8?B?d3l0ODFFRE5rbUJUTWl1VzdKd3h2K3huOEM2cEVBT2JzNE0vWHVlQUZ3Qncx?=
 =?utf-8?B?aDMvRTZTQ29PU0o4QTFuUTlzM1pzekNLSU9nUmtBZnlwa1dEK2JiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91fddd6-2d0e-4558-d60f-08dee87d739a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 05:44:24.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMkq1J0KB1/YJGtW13pkeSHNLD9fZ/KRO2wcVKNxfNfjGcuolgvv4mGbAPXkrQB8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828



On 7/22/26 16:45, Heiko Schocher wrote:
> Hello Michal,
> 
> On 22.07.26 08:55, Michal Simek wrote:
>>
>>
>> On 7/21/26 13:42, Heiko Schocher wrote:
>>> Add csi_b and rdwr pin support for the xilinx,selectmap driver.
>>>
>>> In current driver the pins are configured from DTS and set to
>>> GPIOD_OUT_HIGH. This works in case you have one FPGA.
>>>
>>> Extend this to really implement csi_b and rdwr pin function in
>>> driver, so it works with more than one FPGA.
>>>
>>> Tested on AM625 based board with 2 FPGAs connected to GPMC.
>>>
>>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>> ---
>>>
>>> Changes in v2:
>>> - add comments from Michal
>>>    - skip check if gpio descriptor variables csi_b/rdwr_b are valid,
>>>      as validate_desc() checks this in gpiod_set_value() call.
>>>    - initialize the gpio variables csi_b/rdwr_b immediately with
>>>      the return value from devm_gpiod_get_optional(), so we can
>>>      drop local gpio variable at all
>>>
>>>   drivers/fpga/xilinx-selectmap.c | 23 ++++++++++++++++-------
>>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
>>> index d0cbb5fdfe3a..d5175f9430e4 100644
>>> --- a/drivers/fpga/xilinx-selectmap.c
>>> +++ b/drivers/fpga/xilinx-selectmap.c
>>> @@ -19,6 +19,8 @@
>>>   struct xilinx_selectmap_conf {
>>>       struct xilinx_fpga_core core;
>>>       void __iomem *base;
>>> +    struct gpio_desc *csi_b;
>>> +    struct gpio_desc *rdwr_b;
>>>   };
>>>   #define to_xilinx_selectmap_conf(obj) \
>>> @@ -30,16 +32,21 @@ static int xilinx_selectmap_write(struct xilinx_fpga_core 
>>> *core,
>>>       struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
>>>       size_t i;
>>> +    gpiod_set_value(conf->csi_b, GPIOD_OUT_HIGH);
>>> +    gpiod_set_value(conf->rdwr_b, GPIOD_OUT_HIGH);
>>
>> I think GPIOD_OUT_HIGH/LOW is wrong in this context.
>> If you do "git grep gpiod_set_value" you will see that values are 0/1
> I will change it!
> 
> Hmm.. while thinking about it... CSI_B and RDWR_B signals
> are defined as active low...

I have never worked with this driver but values here should be 0 or 1. And if 
that means active low/high is said via DT.

GPIOD_OUT_LOW below should mean that you are starting in deassert state (if it 
is low/high is coming from DT). And before write you assert that line and 
deassert after it.

Thanks,
Michal


