Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC333AB460;
	Wed, 23 Sep 2026 05:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790141709; cv=fail; b=o7N5kdLMFkgrUFCmiQp/KZoDUatQ85Qncxou+hwvzJSImjFIJizSF1xlDpMKTNtPaQUq9Bie1+niEFwrBHGjE1glAaooGEca+8VN0iTPr348/k1/A4aSIkcFbDU+/WclAjoWC47k73ntY7xhQxbgSPyc4OFHgcivGVVHhtJERtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790141709; c=relaxed/simple;
	bh=DwooncUPWVj+9F75yvO5IRLoOkdrJgc+KX4dd0fifGs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o2Om63z/d2nmuqYV9PnUN9y6Navom/GEN8NEMD4YTHwTAo06YbQYAefC4oQuQQJRQTG/FK6RWUDA0y7q/UVsU90bQXIyaH9KRZvFsECdWLGOVfuyzZzryTeF0dm85OatvZSX7FIHB7PyQ5Wtyz7p5/fjL2UhNTu5BQDXnVLPYWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=TJhOdxxI; arc=fail smtp.client-ip=52.101.56.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="TJhOdxxI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihtiniwj/uZoR0x9Td43RDwzUAiblGD7urtKLx1leOc5ao5uJMM/UN+ZiwWtuBGcl2C37+nM7x5edTLebYjBil0ul3slSLu3LF5MB+JOHUmLI6hZ1nWaWFf70pWhG5D1ZgHYdPfA10fBznuHFXSmNPmkjBVogTiUmeWavRXcpy+hoFqpXajv7xTjAIkWHt+tHeutEmahMNajx02s8dSj6jxfNV+qXeVJ1gS0j5NzTh42BHqcBXVW37Rw6sroHrhRUXATnRf+jr0HdeJRIC73jIZFt4LSOU3iIJcC0a3SvebhUJWDel24+krxLRvFqaC1e98Jcizp8ncbH4LmHHcwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdKnf1jYFo9CoTA2XzlCaFTbHoTGu7uc7fl0KFlebHo=;
 b=UpXIAFdSNHHE3tYsCCsy09z6WSZP5N7XfAMrrTUG0QSiyLgNo2o+okEneYXNSQuWwOhp52m3w2xoPJmIWMGKYvW8j9ujIZ+wPI8GT8LJOV/SzqyXrLsntnOB5q1xj12FURqqP1WCP1KZ/MNYZOnEsiuv/jmh9e5mtyUWPqk4XOB8aZNr1/E9BauDiJqBS8BDfZyUzIVP78/W2CZUfqOMJE20mxKpuPBrkRZcsfv7YfJ19O+8eUPbu0Snyn3oRt/Ap14J3AjdCU3ejKg8Q04UZ9IHesUDrtLc6Ns7YEvYCfDawNHXJ4l0Q/t137lPlr4q8quQ2Oyk6PslrxRR9/iKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdKnf1jYFo9CoTA2XzlCaFTbHoTGu7uc7fl0KFlebHo=;
 b=TJhOdxxIq3kXlTKcPS0sFD6lC2PESl4KAeRHnkl8N/22EXfPyOaJ4M7Bqbsyz7jzdmGWJfloel0tko2MiaI7R+FEhmUSGJ7IPQQNq/rpriskoUxVrxuNiRCwkU03Ra5bAQgs89T6cQGLcKGzbgGPhnlWZOoz7nzCfMCJ8ZSkSolt0xICXXasIlr8VIhbm84amRvlERSejBBPH66Hu3qCbX4CSNcrU6phQ4I/V7P9YlrzvTPgAeDVEE0jMG60DeDZnGorARTBJEpyR0Cx8mSvHnfmajJDAm5GGwXO9pzJ1iwbtwI2oYsGU+jxfnMNcEA8ujYeuDkfgZlNJKRLLGmGvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM6PR03MB5324.namprd03.prod.outlook.com (2603:10b6:5:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 05:35:04 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 05:35:04 +0000
Message-ID: <388fc1ce-4adb-49ca-bbaf-130a94ea03c7@altera.com>
Date: Wed, 23 Sep 2026 13:34:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fpga: altera-cvp: Retry teardown and reset CVP state
 on failure
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260915062734.42964-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <aq1som4bim3EiTO5@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: "Nazle Asmade, Muhammad Nazim Amirul"
 <muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To: <aq1som4bim3EiTO5@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DM6PR03MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb67a3b-69cd-4842-0060-08df19346b7e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|10067099003|55112099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	Jy60rjHRrqCGClZ/F1woX4r+hEtYa64X0I/2GXAvaXUp1SlMyKVv9INaj8icGktKC3+4bnRG/rnWoRW69i/3xc8UhT/o+MU9Vueou2o70qqxqo62BBuWnNAPdVlYk0B/gtTS88B4BEfA7pmEqrHaf6DbN+Kihw+EgvOw8MkaD8fEBPAklHcL/RE57O2ZB590kysffKLUPoiPM0h4u/wXyc+4Stjx100EtWg+RlJ7P8SbokWaTHKDHIEYwtXkWWtOL/HCIJqE4Naox+x6GIsLmgCO9HCkNy+8fmPqQOIPYM9kMJihOGILAXC2HnfzbRfc0YHQCyj34kAkxe3vbrlpuEWo8VKNfxRt81yaRCPRvXFzxCRV39Bm8jJENaUHtabXoWFmWjy7IV6QW7pveY2kuI4P4YrrrzdFIw6b6YaY0Nrr64Jbkne0pbGJOkb5i/qAxRYnFm4AvH8D6Pl7AG94tQ5fFuPe+Bpa+ExW1vZxkYsFXgZPvPv7kpDtmfo6SS4IzKgeES5OJz3zUM8C3y/grfxi1Sgcu9ZqkaTtGHeKH1ADK5TrNfQ2BWRx/7A7CwEzfFcqoUXz6pNMqKE66EeZ0sS0KwHfYbO9XirgVizpQkL9ftxPwBDwVSoB3DVUZR08Ru4sZ5zgyBA+eKpHd1p5/L+74/mSiAdY/SnNvhTlp3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(55112099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3p4K3J5V0NZbm14RVZ6VWF1dTFCdGhTYXAzU1hrQiszMERnYzRvOERPYVE5?=
 =?utf-8?B?VVc1RWlnbjY3WG80VDNSb0MvUDVjVjdKeHhRbU5DRjJ3bDl5eTM0TTgzUWJU?=
 =?utf-8?B?VUFmU1JmbVAxb1F3bU1JRjErZG1TaG0rUDdtTzNDd1ZmdkZWZlI1MGlsZEJt?=
 =?utf-8?B?SDhrNHpnbVFURDVJRWtXb0JwUWdiNDlZRDhWeFdZUm1nN3htcHZGSS8yYkk1?=
 =?utf-8?B?Y1lINlF3OTUvV0Eyb2FDUHEyRUhoWEVGNFE2ZFh5N0tqZkZJdGdZRmRIVEhZ?=
 =?utf-8?B?N3FydzRKZHZEaEh0U1E5WVI5UUc0b0l1OG9PTlA4N3lMak1rWmw4K1JDcEVa?=
 =?utf-8?B?UCtRa1pVVW9tQjI0TTU5alhVbFh5d3VBWEpsTlNqd3MycXMvNVE3REV4WkQw?=
 =?utf-8?B?cE1LVDFIVjgrOHp3K1VvN1JBa1hYcWcxclp0aGVXYjR0ek95S2V5ejBIWlBV?=
 =?utf-8?B?Y3YvZFl2VFdsTjVld1haVDB2dCtBL2dmOTQ0akhRcXpIVHg0czh6aTR4dlBm?=
 =?utf-8?B?TlZRcWJNQmhQNmhYSk1pdCtnZUpvTzgreWgwZk5FSDBRaWJ3aDl0OElrKzdV?=
 =?utf-8?B?czFkVTBiM3V5SVBVdFJTbjVPQjBlZm5EVUVmdlJtM1BoRHllMjdQUVpReUdl?=
 =?utf-8?B?b0xaRFdHZlY5alpua09tUHNuRkI3VzU5UnhTNTZGMUxwNHFvYUg5UExmMmdR?=
 =?utf-8?B?UlU2VWtlT0NZZG1DNUltd1A0YmtFTlZLOEVmVnBnS3dRWnhxQUIvREYraGNY?=
 =?utf-8?B?dit5bGJrMXVzdVI2MjJFNU5EeGxxS0duQnVjK0NDVWVYQ0pHQk5UN3VKNDFB?=
 =?utf-8?B?TDBvL2RMNEZCQVk5VnA3QjhtcE5iNHRGNVd2SytXMmlxYUoyZU1XUlpacm9Q?=
 =?utf-8?B?TGE1VFZpZ0NvUXNrMVRpOGRVSm1LaVN5QTJ2TEtxMkVUVWhkUGExT054MTZN?=
 =?utf-8?B?UEFWejcrYitiZDNHblFLMXpHWWFJcHdMaitFRXFnbDRDOFdkMFhlU0QvYWpX?=
 =?utf-8?B?V1VIUXFmOWZCbHVqaU1jdzFaVEpkVDM2MEFCbFgwbVJKY0dOVnRpU2lvUE9u?=
 =?utf-8?B?a0lDekRXcUhJSlRqdGtHNDFSQ1ZJaDkwbW56TnVHQjM5cXJsVTZtem1YUEFG?=
 =?utf-8?B?RlpqQmIwWXpOMkxUMm1veEVVczNoZFRmay9YdytycHB0WGo0NWJ4ZFlFR2tX?=
 =?utf-8?B?cmVmOC8zWmpwUEJPazhlV2pqanZqMGt0UVBEZlpzZENtODRVMVU3NFIyTFVI?=
 =?utf-8?B?Q3FTRyt2QzIvVWFhUGdlT3EwSE8xSXZiT01GdHBPYU1RQUhRNVEyOVBpOHhz?=
 =?utf-8?B?K0FPLzBKN25ISnp1TjJFa09iSzF6SDdCS3ZMWks1ZlRlUGFCZzlXVUZqTXlz?=
 =?utf-8?B?a0xxZGpsbnFWT2RmZGR3d1JQSnZpZXhNa0Foa1N3R3lYWFJpcExXRFNadEZR?=
 =?utf-8?B?UCtXbTltOUJQcWFESjRNZHJnb2oxZEpIZmpTT2s3QS9DcCtWNTVRV3NaS2pi?=
 =?utf-8?B?enZpMzlMUTd0aTVjRmx6L0hpODBWR1Z1b09JVXJZZzlXZ2duRUhHbFRMUnQ2?=
 =?utf-8?B?QjRyWUZvcVppSHVEM1QwcGpuNEtRRFcxS2EyTzY2ZUJKa2ZBUzIyWjBBL2Jz?=
 =?utf-8?B?dTI3OEJkQlk4ckhjSnRTckZZZ2RTWUZheGtOK1lKSWw2bFp6NVR5cExGRDdS?=
 =?utf-8?B?UTRNODJuS1ZoSUpiZEJpbVUwMU4rTVFsNC9HQUZHY1Uzb0NuZ3IxTkQ5VlJr?=
 =?utf-8?B?VWxRSTV0ZFRGZmhIWXFuWm1ibmE2T1duMURJN3JLb3BEVGF6S2FDRTc0ZHpY?=
 =?utf-8?B?T1NHWE42Q2p1RktDbFI2R28vaGc3VGdoVVJCTEFqa01nTE8zVTdUVTJIbmV6?=
 =?utf-8?B?MWZBdGhnR3hMTnJ4QWZmTEkvUldPZEY3RHlFS0lyOC9Fdm1QRVc4akpTTVNB?=
 =?utf-8?B?RklzKzhLUHpRUWRmMXhtTUR0R1VyQ0JnYmtJelE1aDNaN0xPcGVNTTI1TTNn?=
 =?utf-8?B?VVp1Ukpxa0lZK2JFRCtpVEFCZEJzOHUrV0w4eWVMNWxZL2NhSmNCUlRXU0RI?=
 =?utf-8?B?Vm50djhYNm1LajNMcUcrd3RzdG5xWTB4ZUhOOHN1ZTJuWFdBVWZvZTdFdk9h?=
 =?utf-8?B?NCtMV2pVZnhiaHRKZzB5S2JyQXRmTXRsNGUxWGx6c0YvempxRDdhcStxb2dp?=
 =?utf-8?B?amlRNEsrdSsrVXl6b3d4akorVkRVNk1JajJsUFE4Um9pclArUU5hKzdWSUc4?=
 =?utf-8?B?eHlqVDFhdnhpQUJ5MWUwRzE4cVFScmNVZ2MxMFEzdFpNNHYrcFBjQXUrajFI?=
 =?utf-8?B?R2dhbG5NMktRRisrZ0NoTXB1ZzNkcE80N2N0UGFWTk0rVzdYUGcwdllVRkpn?=
 =?utf-8?Q?C0PuSmB6dtuuDLS5JHMenOdQQQeICHL+HW0dTWlqFcEIt?=
X-MS-Exchange-AntiSpam-MessageData-1: SjxN5PDD1IuU2Q==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb67a3b-69cd-4842-0060-08df19346b7e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 05:35:04.3711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RCzorcovRX7COsK4V18VfPcl/vcZW4bJ18lA/l/ZefwwvRrdFeDWfXDRcz8m7YM5WiqWrNGcg/NnALaGNqJ6DRd/svtwuvW5NHdDoBHiCYqGadsuG70XV+2iUw03jOfMMcoAO1QzRaRdvyldKJ9Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5324


On 19/9/2026 12:53 am, Xu Yilun wrote:
>> +static void altera_cvp_disable_cvp_mode(struct altera_cvp_conf *conf)
>> +{
>> +	u32 val;
>> +
>> +	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
>> +	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
>> +	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
>> +	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
>> +}
> Use the helper for existing code, or there are still duplications.
> Split a preparatory patch for this.


Hi Yilun,

I send out a series patch which cover the main teardown and helper.

https://lore.kernel.org/all/20260923053233.10890-1-muhammad.nazim.amirul.nazle.asmade@altera.com/

BR,

Nazim

