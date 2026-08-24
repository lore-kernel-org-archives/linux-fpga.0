Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A53AAF46;
	Mon, 24 Aug 2026 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561426; cv=fail; b=iybwobs9+piOTpMkUNbNYH9RKIdP+sBfFGY2kmpeKiqXYs4ePqdxmpcDnYTmQUDUYuw3KCaIarxdQQOBhw3OfcKH7wT9xu4n70uZ5wLByOQSWN1qTnkPKN5MfAZmuU2TLivJPhLfLiZ4WjG/tVbir/Oetz7EsC3oz5k5hEfzUdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561426; c=relaxed/simple;
	bh=Tx5viJIC2o/XWa4sDI/9gbu8JYf0p4MGuRWVehF1jPg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ebwrYLWIcNVHPSHTib/HW6+NAemVJCb6fny5pRdDZmqwLt1lf3SkU5Bt92h/b8OoDPSktv2dCQxEmKpiTZJDIEO9JXwA4Hq4xUl2aMG0WoFelZocSGmPv8zNSdV2EKnAt74zfYkvwIBDSpO+ODk8eXg8rTxwq0ZUAU2WwWP7hZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YNA5GZcH; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YNA5GZcH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq6Ick2Nng4mdynqiEqIUlmif2yxj5P0eQdt29yEogKumxzIy9Z7dR9ljW6fAvnFrXqCi2UXGI6p7kPyrhUM1vxuOZyPzsQkUQb2K9oESqfgk4k3+yyBScVc6lKw9ij9T474pnnih/hwbWudTR36pHnSyO7wRECjw28hxLkLkfIWQKpBaPVM/iLPKxLTr/9LwCaq4gLNiSg4b5l9QgAiItEaoKk3qj+ktWmJFVgInrBiTgDmVLszga0FHLOr5MQE7lhp+di+HeyAxVOZEmjd/DmE7fG26gZtXM3FVjAFjmvuEaEeQJNkLTShG9Y7haXBwM5BI7pxqUsbmmPNyDM7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLiXbPHRLIL1JGDEu1y/Nj3y3/wgKnsjMCNdR5dt22k=;
 b=qAEs0M2QpqMKeQOOnB+RzBe0tcZzrkEVtW35k9boEdStsN4HELcbW2ljMooP2KD2mnAZWthe8ej1MZTZpKaozy/swSfCyilnmX0pCsak/4xsC9qsB3NVr1oaVqITpZB6pDbyeHfFUeAMxB+mnC5/57MEw3B/dC2jMB8e9ee+Wt7mswhnZ3jubOjSLX6QUadfIPsuUzibkzur88l7rJT2bVctWmSe5Su3ErSlee+H/otJBj9zg1uUTCIezGw3B8WP1Lyz6kDz4aH5kWMyZ1uNe0kB8QZ1Owk2NBKws6MxNbGnMmePJImDk+AI0j+dS0lWjKB5L0z7scuMJw062jPoGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLiXbPHRLIL1JGDEu1y/Nj3y3/wgKnsjMCNdR5dt22k=;
 b=YNA5GZcHEsn08c3S8UNqlUZWhuwuou9Q+YZqSmh6m0Q7A7LyJEMOzCQ1LjLflqh9pRhtatBWr/Y5+ORKEQGhKUO/WqsYeBfxTIo57SUU8Dv9QVR/qAzbxg3GpD0ayf1kyOgLDjjb4Ll6uZyndRWQvsFNusQtEUjkHMHrnS42WOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 08:50:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 24 Aug 2026
 08:50:19 +0000
Message-ID: <e747060e-ba01-4d0b-aaa6-d4c619494f09@amd.com>
Date: Mon, 24 Aug 2026 10:50:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fpga: add dma-buf based FPGA programming interface
To: Aravind Thokala <aravind.thokala@amd.com>, mdf@kernel.org,
 yilun.xu@intel.com, trix@redhat.com, sumit.semwal@linaro.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-doc@vger.kernel.org, git@amd.com, nava.kishore.manne@amd.com
References: <20260816150734.2092802-1-aravind.thokala@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260816150734.2092802-1-aravind.thokala@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3eb5b5-f78c-4eb9-33cd-08df01bcba17
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|10067099003|11063799006|5023799004|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	77mFSWByfU5SH/Ya8EdOtDmgxtXsAZqVpwC9f3e8jukgqZDHjzM1VOHxpI5DONvj7TbJj15UNdQKMoNnqcZ88o4CRgR0BS2OTKmMMfc3T56/Q0xOvodZSiQHy+bUPzlHNXZbzsQ5On1zXJitq7CYEWmXH2+vDxmIJ2AAQbbrVYmv1IZit/jQvWJ242rpPDNrYWG9PB2snOPJY8YLwcfNhJkljJ+xtrhcoMwqdzt2k+SSsnOyYwAg2UuCLMFYEP0odt05yfkb3ITDj96G3oOlH/4Q9Pu9dv7yTxe/OXSkhF/8ig9TidTOcZs6292V/oCSQhislz60lXlCYAohNhF0q9+Bgpweqt6zX9vwVeS+FZt9q/quPnhDWs2pfCkYR886/qoMJGbd6KBoaIxOQ4TJNgsm3qexxwzj11TbcHI84scRK7ohz6ArMtmQItcI6nFEKXtgZq//U9xi3bkI5J/5zV40XpNqlIoM1Wdh8GCN80yvC+OIAg6/15nUDVo7LKe14li6k6chLU3sCBce1pBFcsLRwHQB/soZbpSl2qFEmoXXzshj2qyKc7joWx1g9ZWscF71qC0MFe9pJKegdHr8l4gHdlrQjyp9BP0owi3PPIlQWrzGqk+C8S9i0Pe9ECkVJvr9qgUr81rGSyy6CLx8pHvYk7l3dsBeCIfO/7xLpss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(5023799004)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU5NQjhsTXJFMC8zdlJuVjN2WUhEbTNqZWVqaHZJaXNvbm5wUWhBalNPZUs2?=
 =?utf-8?B?U0E3MWJJNTZCeGdINytqUy9oME01dDdnLzZaVzVNYzFPWkxicktIRHVZclJ4?=
 =?utf-8?B?RWJSRFBhU0lJanlMay92S0NvOS9lSkFyM01aS0tUVWZjOEsxdFVIOFZDVDNN?=
 =?utf-8?B?NTZTdWh1eW5kUnhROFRQREpEVlB0ZjllaXd1WHByZzF0M2YxNTdZNnhqc0tK?=
 =?utf-8?B?YnM4elFKN0p4MXhtMFluMHpsOGQ0NTJMOHYvWWx1RFpJL1hRbnN5U0UzTjVZ?=
 =?utf-8?B?SnNGMWtpTFpvRUE3S2lDNWNKWk1VUEQ2bjF6WG0zZHpSUVkvVHhLK2QwNHU1?=
 =?utf-8?B?MkV0czV5RkR6NUJjL0gvMFNONEFkS3FvQ0pManM4NmJXb1ZzV2FxVFFjL3BC?=
 =?utf-8?B?NlRsenYwUGVkQlM0YS9MQjk5VVRIVnNiY2gxZTJPSFhGMTBWQTZlNnk1eFVk?=
 =?utf-8?B?Uis4SW16QlJTeWxzNkpZVnhsOTNZK2RFMlY4b2pQMHNQK3ZQTkNXNGgyNlM4?=
 =?utf-8?B?dldIVTlUT2Jud0lNTHQ5VldZVXg0OUhKNmovR2xqZk9PNGZNaDBLNWllM3Bs?=
 =?utf-8?B?TGRMcEwrcEZ3bFdXUEFycFJzNWVxMkJMQmdHNldPb0lWY2J2QjRMNVY5YzN4?=
 =?utf-8?B?OVYwbElFdmNQYzVKR1U5MUp3MUpnZE5LV3Uwcnk4bHZSSlBhalJWSnZzcmNV?=
 =?utf-8?B?RDJCczZyTDlqb0J3bVlnRGtlM3NHbkgvQUtzNjdBcFYrUi8reTUwMk8raURC?=
 =?utf-8?B?d3FobUc2VE9XcEJmaGppRS9BVzNZNzJ2WWNRa0RpUVVVTGNBTVkxbk9OM3B4?=
 =?utf-8?B?ZStIYWVxRkZtaTdCcTIrMFA4ZTRQcXEyU2ZEVW05UFlTMHFQM2dYNk81VURT?=
 =?utf-8?B?TjlRTzUraHFTUE91bUxvWFplemNKTFNoQkw0NU12bHBGREUyRysvYytNSzJa?=
 =?utf-8?B?TEZkK3VYeTI1NlNldytBTmFmZnZBSmJRZGRUb2lFbGgrbXk1QnZvcDFrTmJ2?=
 =?utf-8?B?TUhsZGlIS2dUWHUxQ2RyWDloVFQ3d2ZYZkZjbDVILytxN21wMWloMDRJcTUw?=
 =?utf-8?B?ZkFtZW80QVBPT2V2anp0MVZOSzB1ODZtRlNVTGFaeGg0UXVRU05rS0pVNXZt?=
 =?utf-8?B?QUR1ZE1INzJCUEpTQ01yWmZZeUpmOTZGQi9MRUJBcVBMWE11SWU5cjdFdDNX?=
 =?utf-8?B?WndLSGJMQnNnM29qN0pzcms4OWJnc1FCdGtNR1hnZGpUT1BpSXNjbzc3YWUr?=
 =?utf-8?B?ZUVxMDh1N1VmODFVOWFYamQrU09uQWE1eUJqOG1VdXpubnRFK1pjaEN3L2hv?=
 =?utf-8?B?RmFZOWFva21CSGxjSmdjRWUyenhETDlLMWtNSzY2UW00TEp2dlhZQjhUem02?=
 =?utf-8?B?ZXRpekU4VDc0RlFONXZjQm9sYzJISXh2dmthdk9XcHhEOW8yNCtTblp6K1dr?=
 =?utf-8?B?WU5lRmJuamVSaUVTYi9Cb0xyWXAyZHJLWmt2aGhqSTMxL0lXbHdTa2ViWWlL?=
 =?utf-8?B?TzloVm8xRmR3d0ozV2ZuNmU2bEkrNG1xcml2VkdEbkR0SEl3MmhtQ05hMVZz?=
 =?utf-8?B?U0VlUEZ3Tks4RjJsenlpT0RrNzJXU1BndG9NK3pBa3F3Q2ZnaEN1a0NXdzZ1?=
 =?utf-8?B?RWJMMlpiUFJsVkNVdVRGeFozZHhUeFB3d2xCRHJ1UGxsTHF0TEJZaWdDM2c0?=
 =?utf-8?B?a0p6cCtsZmlibGN6MkkyRFoyR3hpRnA4NEpGNmFlUGxFTmEwRllWUEV0VVh4?=
 =?utf-8?B?WEN2bzZuT2l5b01yenZxVTVQWFFFQWoyRzdyMlRVV09lUE1QY2FJU2wrZTht?=
 =?utf-8?B?SUhoU1dWZjhmMXpVcFA0QzBwRGp6UlBIS3I4QTlaNmt3TGVvS1ZMRE1KQ21G?=
 =?utf-8?B?MW52bTJ2WmhsN2ZSWFRjV08zYjE5aU5uUWxOdkFlMjdKS1VjUk9QV2xpeEFp?=
 =?utf-8?B?azN1K1JTU1c0cld2cUxaeDhJUURoZWJsdEtPSGlGYTY2T3U5UEZtUU1ZT0tj?=
 =?utf-8?B?ZmgrN3M5RnVQVTFRM3lDVU8zSmFRZUx1VDQ0R2NhSDJBSTcxQldia1Bsb1Vz?=
 =?utf-8?B?RWN4a0JCNEdRbjJpWFFQK0dqSGZ1R1VtaDlLVmtJMmdtZVd2VTU1Nk5ZMHFE?=
 =?utf-8?B?Q3RxUHErUXM0Y1JNdUNGdjZUTHo5NWNpWW53WlJuRE1wbmtiUkt0L2pDQlE5?=
 =?utf-8?B?Q01ybzB5bHFvT3FKSXd5dStCVHVOVVUvM003K2JUQXlWTlg2cFhMdFE1Rjdt?=
 =?utf-8?B?b3M1d25KRisycUNMTExlYUxmMVRuSHF6bWZseWpTZTI1aEJTU1RjR0R2cXBr?=
 =?utf-8?Q?DKsIG7shnXNQyqbxWu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3eb5b5-f78c-4eb9-33cd-08df01bcba17
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:50:19.9061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Fjh/nIqscTUIEYmV5HpFsfbOZ+deSaPG+AJsrWVwoylYkdeT1aABVAxvYe5zuQI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774

On 8/16/26 17:07, Aravind Thokala wrote:
> Some systems need to load large FPGA configuration images. The FPGA
> subsystem allows loading images from the filesystem, but this requires
> the entire image to be loaded into kernel memory first. For drivers
> that need a DMA-capable buffer for programming, the data is then
> copied again into DMA memory. This creates needless memory pressure
> and delays due to the extra copy.
> 
> This series adds dma-buf support that allows userspace to allocate a
> buffer directly from a DMA heap, write the FPGA image into it, and
> pass the file descriptor to the kernel via ioctl — skipping the
> intermediate kernel buffer entirely.

Well when you have a device with limited DMA capabilitiesthen DMA buf heaps doesn't allocate DMA-capable memory for that device either.

So the explanation you give above why this interface might be useful is clearly not correct. The DMA subsystem will still do an additional copy when you try to import the DMA-buf allocated from the heap into this device.

Either you need to define a heap with specific allocation restrictions (e.g. GFP_DMA32) or you allocate the DMA-buf through your fpga device so that dma_alloc_attrs() knows that a certain device needs to access the pages beforehand.

Regards,
Christian.

> 
> Userspace flow:
>   1. Allocate buffer from /dev/dma_heap/ (e.g., CMA heap)
>   2. mmap the buffer and write the FPGA image into it
>   3. ioctl(/dev/fpgaX, FPGA_IOCTL_LOAD_DMA_BUF, &dmabuf_fd)
> 
> The dma-buf logic is implemented as a separate layer on top of the
> FPGA manager, keeping buffer management separate from the write path.
> Individual FPGA drivers opt in by calling fpga_dmabuf_register().
> ---
> This work is based on the approach discussed in [1].
> 
> [1] https://lore.kernel.org/all/20231122053035.3758124-1-nava.kishore.manne@amd.com/
> ---
> Aravind Thokala (2):
>   fpga: Add dma-buf interface for FPGA programming
>   fpga: versal: add dma-buf programming support
> 
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  MAINTAINERS                                   |   1 +
>  drivers/fpga/Kconfig                          |   9 +
>  drivers/fpga/Makefile                         |   2 +
>  drivers/fpga/fpga-dmabuf.c                    | 198 ++++++++++++++++++
>  drivers/fpga/versal-fpga.c                    |  33 ++-
>  include/linux/fpga/fpga-dmabuf.h              |  22 ++
>  include/linux/fpga/fpga-mgr.h                 |   1 +
>  include/uapi/linux/fpga.h                     |  15 ++
>  9 files changed, 281 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/fpga/fpga-dmabuf.c
>  create mode 100644 include/linux/fpga/fpga-dmabuf.h
>  create mode 100644 include/uapi/linux/fpga.h
> 

