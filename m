Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49566375AAB;
	Sat, 29 Aug 2026 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787989975; cv=fail; b=WZzz7Yn8VtBV5aLYhbvH4giVi04MBB25MQezoFOuJFPY/KEi8gAb63UqnvrxUFaiACXfMeyJ6C+WmcQCrr9ZiiSxl8q6DMHOUv66+64SCHswLevXwuG2HLEfO0d7zeOM/GeY9UrQWR18GxJKkz1ysvlps+MoL1np8RD72kjVQIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787989975; c=relaxed/simple;
	bh=GmADziPeeBYtOmGPP+TLmeXk02/Od5loVIwAQcQEWi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D/5vqN123KJCN2YvaGAPrrHpS6MPLYkRPPo+BpqAfUYLldTFXmv1QuRuGB2dj34b/1Btvq3l/230mzH/lP89RNCpj7W4bAyyv0g0qjitkvCLAkM9wx3xIe9Xdt/roWzD4sWJIo5skpFE2R5RMohaspAhHUwqi/gDgfq1S0+PR58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lddIhLbb; arc=fail smtp.client-ip=52.101.57.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lddIhLbb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSqtZkdgj2ErPArzhMhGHrvVKON+MJW07Tw9wWq8Nfi56B9RlT2bZR9VyhGAs5DEDLpl5H3vk11ZZIqVacsUaY2T4wldP19s2u+BD1EIzDRg6mZnTNhBI+w4TJ+bVZMCTQ1BBMoXm+ausZVu6o9khLTY/EqtU57WPgJI9D4Eq5RnuCQN5Xw+7QuLEY6KuMKwGgvH+Bd++ZKWU2BUHPxmLwBgzSdiWxzVAqTslvQZTtG7OApVXPYx5CKroPXy3PgEnouxbSjzyh4OJ4qXPcIyqY7ZgurMZbqMimYWo80aEhWu/ErnEX+RQ9uZ0F10dK8aN5mTzhY6WO1HxH6p07ReLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgVOC3/s5mAHw0OrYm7J9ivEDl7Odqyp36Zy4du+xVQ=;
 b=C5DMgFNc1stJn6akTQwyeurg3WBNx/xwt6aTjVF8wesOner/YVo0KMep3QYCb8Wa4xY7WX9FCkexiySrVhofuzBDYTk2V08zKfZTVvwVFneF71ByR4LzEp2kdhO+YpSuPixJEzOXPAM1pWwfcGf120ZQ4wHXNhYlPoYnfbD5BPrVdfYfcs13hmTPdy1i0xmTC8t3jD2E8Mzu+E6P4vp1O2mQCMryJi7Qfhj5rnXTqNv9Q+3DX+L+M+4JzwARdU5AWmsczq8mK3LQiSqYd2L5l2FHDGdfamOjFPX0Ns6QeZ2UxtkCmctVyjBsLJlHHnuMsbN0GPi3ntM9YdKTv+3IwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgVOC3/s5mAHw0OrYm7J9ivEDl7Odqyp36Zy4du+xVQ=;
 b=lddIhLbbDozUkUJJxWAC73w2g6vg0ouLuaW9fk7O9R+vfVNGGQZTB74TKaOOtDWw0xyCadb4Oye3eSVQSX5tNeP9WBk205IGZFOTCpJ/GQJeuv6bpX2y2p4uVW5nwjpRRPlbLG6e6suqD6Int0ss7GhJMcjFhqr70dqK/E7KgyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9566.namprd12.prod.outlook.com (2603:10b6:8:279::16)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sat, 29 Aug
 2026 07:52:47 +0000
Received: from DS2PR12MB9566.namprd12.prod.outlook.com
 ([fe80::2d07:1044:6ee1:830b]) by DS2PR12MB9566.namprd12.prod.outlook.com
 ([fe80::2d07:1044:6ee1:830b%7]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 07:52:46 +0000
Message-ID: <9c6c08d3-9ec1-481a-8d66-4b0183036c39@amd.com>
Date: Sat, 29 Aug 2026 13:22:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fpga: add dma-buf based FPGA programming interface
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 mdf@kernel.org, yilun.xu@intel.com, trix@redhat.com, sumit.semwal@linaro.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-doc@vger.kernel.org, git@amd.com, nava.kishore.manne@amd.com
References: <20260816150734.2092802-1-aravind.thokala@amd.com>
 <e747060e-ba01-4d0b-aaa6-d4c619494f09@amd.com>
Content-Language: en-US
From: Aravind Thokala <aravind.thokala@amd.com>
In-Reply-To: <e747060e-ba01-4d0b-aaa6-d4c619494f09@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To DS2PR12MB9566.namprd12.prod.outlook.com
 (2603:10b6:8:279::16)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9566:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec8bc26-b0d8-4af3-3b28-08df05a28396
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|10067099003|3023799007|6133799003|4143699003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	gSSSIf/FDXF2ZY54djwV232NQ1js/FlNWaQ3MSv/AMezu3IwDot22jhAKL3tuB8TFqtbbDu3/j3xgi5HjBZfB9j2A4nFYrzAHdjA00EKJeksMakg2wYY/Mj7MWwILrBUi6aP5XX7VDpv+xGqP5Dhhzkzch0Vk4kAtyNwq61HQGIqqf6ILB70S+Ijazsrje9sFO7j1QNKWW5oyP6ZbE1fiJj0mT911aEbBhNVu80PgbqY6PVA1cikq8pdUm/EY8vX+YBFmxXwHdU2B4YmqwQNe0Jyf+D4+on1GCQuNTPbfZ8Cf8ERUSjnrMruK9n+19OOpd+tckA+wIAeTmBjAQ6AwlkIMBRGb0dLmXIyXo/cSFOWCtPxlWtv+VcGNOuGDTIOXq9zh/rag9pv1zQjvVrsfRyP1v1OOsX+9xvI17aFMfrOfmR8Z5Trqmgcr44pkEyI7c3RmpqAaU0aZu2YsdY4DfaBWEJgVCaqbh5Vd3mxcNZiOWU76pO4kLVi8OKJuhdHrpbfH18OE1p9Zx4q+r1iOwr/to+08SjiE0CX0si5aa7hstrZrFv3lUmQGy+moIspOTuKSZdRjfuCpHHFSYDHaD/OTQ1Tb0bvIkzYm4P8EHtvL39hYUAHQnrGP6ppT1L2HU8Os8ynxZGiMTqgvd93a+b6BoONvRLYlf5E9tlhciM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9566.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(3023799007)(6133799003)(4143699003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlFCUmt2YkJadEYyOHpKUlNtaXprZURDbkxUaTIyYWxnenl4V3B0VFd6ZWdW?=
 =?utf-8?B?TU9Cb29HUVpRYzd4R2k4NGdXSDNBWVJCVStsckV2TXowNDBkR2VJdzZsSGpm?=
 =?utf-8?B?WEZxNUhQMFdlWEdSZ243dDNWRis2Sm5od1EzMkQ2aWtkWmxHWENSamxmVFZ1?=
 =?utf-8?B?MFZ4dFl4cm02Q1lZd0RtbW96Vm5KUWk3dVFiR2VUR0xnT1JLdlVHeGdDbGpm?=
 =?utf-8?B?ZSsybEV4MnA5a3NPRDJhbHZZWmZYc3JoZTF1c1lnaUoxaW84eDJJVkdOV09y?=
 =?utf-8?B?dmlYVkdydGJpUU8xUWRQbXdFT1U3bWZLR1NnTGVCd3ZFZDNuUWNrV1RCVXB3?=
 =?utf-8?B?RkRIY2laayt6Um9oem5nQU9teW5sRVprYzFRbm5McThlMmpFT3lBRTFxSjZK?=
 =?utf-8?B?VloyOGl6ZjFGNWdvZ2hSKzRWa0lYR1ZvYmEzOGwvZXJVVzg4ZVBTRFgzRlZT?=
 =?utf-8?B?ZXNWRXJmYURYTUtkQzRNME5rQUxqM1R4TTFlQTdUSFdRcUt6UEV4TnN5SXYr?=
 =?utf-8?B?dGxyVzhsMHpnNWFaTXprM0dDQys1YjFFaERYaTc5cTJkOFZvdDNqMTkxdzdz?=
 =?utf-8?B?QUJqK0hWWldjU3JaSVRZWWw2Y2phQnJYZzVUZys1L3NNZEh1eE9EMEZXZW0x?=
 =?utf-8?B?eWxMMW9pOWdva0srVURGWEZxQUZvNWZiUUFVbUxkdTJocUJSMWMzRzROY1Za?=
 =?utf-8?B?d1hpTFZnTlgvcllhZUxLZG9LTnBJNkd2aTg3TFBWeG5TTGczc2ZPamM1M0JY?=
 =?utf-8?B?eTR5OG00UGIrWkpPRkdJbG1kSWdZRnQwM1JaVWZ2NGhPU3hmemh5WExtQllE?=
 =?utf-8?B?akxGLzhSZTdITVZYWnd4OVJhMGFUdzNraUdaUnlibGg4Qk9qL2pBZTBvcDFh?=
 =?utf-8?B?TGdHaWFwd1R0YXUzYzN1VzZFdzJWMUhZc2VNcTFoTEV2bVVhM25Kb2hHVmVG?=
 =?utf-8?B?cklJT3hsSkFyWVRsc2QySmhDUEd6V1FCQjdqTjVvbC9FaksrZnBxUHIzSlhn?=
 =?utf-8?B?eUswdjd1c1BYOHlJVXhFU1hEbVBmbFo5dXVubzhnU0FDOWlrQ3dOMjk0VEJW?=
 =?utf-8?B?d3I0WXJXSHhPYytMU3ZmVmw2K3l3UjE2ckRQUmtGRUNZelBiSENkTHArbE94?=
 =?utf-8?B?WG0rV0M1OHVoWHpmZWJpZjFJbUVXblU1d0p5V0kzNkltK1J0dDRhclB6dVh2?=
 =?utf-8?B?d3d4b1MrSEJRbDRYSVZ3UVB3NExBSnpxeUkwSHFrWnNyYU1pdktLNE14YUtN?=
 =?utf-8?B?UzdJclhqbllreXBnZ210UElzeFpJckZYWlhjajIxdmlpZzA2bGdVSmcyUS9j?=
 =?utf-8?B?eVFqMTZrN2xSenhVeGRtbkVNME1UUThMTHdOenpGbTByWUdmUmNZYU90VHky?=
 =?utf-8?B?TW1MbWFRbitmcXpiRUJLcEZYUnhXNExST2QxdnpXa05LcVBuRjNlb0VHc0NI?=
 =?utf-8?B?TjJLdG5VTmpaMW82ZW54TXEzUnhKUFd3MHA4dHNYd3ovaEZCQ1U4MzNoSDln?=
 =?utf-8?B?Vmdlc2dFQ1ZncU5lcW1kTjZJVVpocmpqa1ZyYVRtV2xEaXppcXJDQ2FvckhX?=
 =?utf-8?B?U3hqTWpzUi8xTTZBR1BWbllsMWRNVElXSjB3ZHlJZlg4aTdKZkluRTAvRk1R?=
 =?utf-8?B?dUxIcVhqd0JKRG11NTBnb1BoeHlXR2tTWnVGb2FwVnRsS0Y5WHo3YkJQMmZj?=
 =?utf-8?B?UEFQSHNoZ0lKbTZjYk5sV2RWNVJna0FUa28zNUVDOFNjMXZvcmRaZ0VtenJX?=
 =?utf-8?B?TlI5SXdpSHNoc0tpM1FRQmU2VVpxM0FRZ2JDNzBFYVFWM0RTeko4VVJkR1Fs?=
 =?utf-8?B?cVo3RkNwVVNHNzR6ZVZKaUVLTlNta28zOTEzWXF0QWxqb3A2dkRJZXlMOXl4?=
 =?utf-8?B?UlhNeDBFTGQyTC9zZXNjdTZBbU5ZVlpyeEp6dzRIMjZrNmRTc3plNlBNdW0r?=
 =?utf-8?B?TnpsR0t0WGNTT2Rob2I1TVlWRG1kVVNLQXAvYlRaZnNicWgzSDJVVFJPRUJl?=
 =?utf-8?B?alcvbnJEancrSHMzdk9aZjZjSzRWbjFZNW1pczUyZkJxcDQ0OEpDamR5Y0gz?=
 =?utf-8?B?UjNvcXZJdDNSRS8wM2x1NmtCZ3lnb2c2ODdnWUtITDBXVkdMNklpSFJDdEVz?=
 =?utf-8?B?QUpaZGtMUE9JaHJyYjZ6emRDbVhuQTZYU2VQbkh2RUxBZFFGOWVuVUlod29q?=
 =?utf-8?B?bm9ybis3NkNyOHQyb3lSK0hzWE1waUtRQnp1ZjdZUzFwU2tPQmFIV0tZdkw2?=
 =?utf-8?B?VjMxakpSTVFhQ0VSZWg4L0w5Z0M0UW9RVWFUM0pzU0Q5NjlSWXIwVURkVU9u?=
 =?utf-8?B?by9GTWVHdHpMSFdlbUtQS056YjZjR1hJOGdJU2VxTWtwWWNwNngxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec8bc26-b0d8-4af3-3b28-08df05a28396
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 07:52:46.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTj6khviDJkZKmqWDmVqcGKfb9IIrTKousxjFZ32zbu4/P8OxY1+NWKr5dmTi5MKTA5gq8OFkXJol+gTgigjPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536

Hi Christian,

On 8/24/2026 2:20 PM, Christian König wrote:
> On 8/16/26 17:07, Aravind Thokala wrote:
>> Some systems need to load large FPGA configuration images. The FPGA
>> subsystem allows loading images from the filesystem, but this requires
>> the entire image to be loaded into kernel memory first. For drivers
>> that need a DMA-capable buffer for programming, the data is then
>> copied again into DMA memory. This creates needless memory pressure
>> and delays due to the extra copy.
>>
>> This series adds dma-buf support that allows userspace to allocate a
>> buffer directly from a DMA heap, write the FPGA image into it, and
>> pass the file descriptor to the kernel via ioctl — skipping the
>> intermediate kernel buffer entirely.
> 
> Well when you have a device with limited DMA capabilitiesthen DMA buf heaps doesn't allocate DMA-capable memory for that device either.
> 
> So the explanation you give above why this interface might be useful is clearly not correct. The DMA subsystem will still do an additional copy when you try to import the DMA-buf allocated from the heap into this device.
> 
> Either you need to define a heap with specific allocation restrictions (e.g. GFP_DMA32) or you allocate the DMA-buf through your fpga device so that dma_alloc_attrs() knows that a certain device needs to access the pages beforehand.
> 
> Regards,
> Christian.
> 

Thank you for the review. Agreed, the current approach does not 
guarantee DMA-capable allocations for all devices.

We are looking into the device-owned allocation approach using 
dma_alloc_attrs() and plan to follow up with an updated series.

Kind Regards,
Aravind.


>>
>> Userspace flow:
>>    1. Allocate buffer from /dev/dma_heap/ (e.g., CMA heap)
>>    2. mmap the buffer and write the FPGA image into it
>>    3. ioctl(/dev/fpgaX, FPGA_IOCTL_LOAD_DMA_BUF, &dmabuf_fd)
>>
>> The dma-buf logic is implemented as a separate layer on top of the
>> FPGA manager, keeping buffer management separate from the write path.
>> Individual FPGA drivers opt in by calling fpga_dmabuf_register().
>> ---
>> This work is based on the approach discussed in [1].
>>
>> [1] https://lore.kernel.org/all/20231122053035.3758124-1-nava.kishore.manne@amd.com/
>> ---
>> Aravind Thokala (2):
>>    fpga: Add dma-buf interface for FPGA programming
>>    fpga: versal: add dma-buf programming support
>>
>>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>>   MAINTAINERS                                   |   1 +
>>   drivers/fpga/Kconfig                          |   9 +
>>   drivers/fpga/Makefile                         |   2 +
>>   drivers/fpga/fpga-dmabuf.c                    | 198 ++++++++++++++++++
>>   drivers/fpga/versal-fpga.c                    |  33 ++-
>>   include/linux/fpga/fpga-dmabuf.h              |  22 ++
>>   include/linux/fpga/fpga-mgr.h                 |   1 +
>>   include/uapi/linux/fpga.h                     |  15 ++
>>   9 files changed, 281 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/fpga/fpga-dmabuf.c
>>   create mode 100644 include/linux/fpga/fpga-dmabuf.h
>>   create mode 100644 include/uapi/linux/fpga.h
>>
> 

