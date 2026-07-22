Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E72EF653;
	Wed, 22 Jul 2026 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703352; cv=fail; b=f3N2JAxh7DNWy46ENdldS2i6MkLN9LBScQZRPijKZSeUvOVJVKACHaXTRyFlMIY76d/MosIuyPGZwAQfbK3xsVUMSIdkFu34Pe5IULbfViAbGobIPJHQzf2pmH46b3t7aQ18IKMRcd0dfyLD5CXC3FGFQN12z2noWJ9SgrEGJrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703352; c=relaxed/simple;
	bh=yKquSCU1H0EoKh0ztEtjiW7LJ90Vmh/urTKWUut9+jQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fTleQ//CSMv464YfXkodDHpt/Skdvl7bYC9s0Vy7OD4EYXtpzV7tzGuQLb1tz3C41tuOP4xIoQro9WrL/XO63BG5Fd69tS2Ruc41djj7RbUx/Xw/LSahMjoTMlelEiqfAQ0urwj/0TRxymW+QWte8q+0SsMMKrlkOktdH+Vd/DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sJ+IWZig; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sJ+IWZig"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzUpitPyHDV6diOAMfl/UALiyxc3uJJmtZ5pGzFLLOpdLn7EDQvmT53MKmhcV1h6PZI+hWUQFV+zyH9FNrRvyxOIc/45I8p9NKTlmpy+B0jUmgxljmMXM1WcaQsLj5DhonFWFFc65m70a1NQtGekc1s5LgfAV9L6JP5xAdrBvZ8uG1YNM2XMUNQ01HoPWcPik7km0yC9GjD0gzdbcN+ONcpvyiXal5fDrHEC3aZpYCiY9Q7mYtyqJ913S1fNZ0s+QO1OpRYsgM+9f/XzfOoNKmjCHou32IbqoLynhEku4XPFjgL1XyPO5EbxFWNBmz6LWBdoaAa5gW2R4RTVhRMUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQBOr2poJttro39Cb3HggGdC33cUuYg3JzVnquJ4Hyw=;
 b=fFuWSAnDylp2SL8xem+UDHq+dsBTwjRBppG1AUooRZxgMY9yzeVJ+jA8G8XRq4o4/m87CbruHLpqVvCYa8Ro4TNoz+PyKvSlOMmhRTJpR7BzySDSj/0YE14B8MyYoaRQy2s1FCRT9PtgmmfU8UimPeDKMHwA9vCwxB/EoDCIO9xRqyeRHOxf7+d+hRtaVamNkFRPoruDKuF8Pw7ZhDMp58yf15PzlX3s+5jBStQTf9OEhXHEZAaN0ntz8jFol50zs5PwVwKkZrt5L/cOK5J2ZfnlnQBY8NrnGlm/harq8k1vUU8j+GQh7ulbxeH16pHHXuK5Ud1+2g7uMdlSTTQYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQBOr2poJttro39Cb3HggGdC33cUuYg3JzVnquJ4Hyw=;
 b=sJ+IWZigI2dvEO9pKbxRrZiSQzbvYD0R36xUYVUl5mCIgZ9Or7PoN8f0rW9BzsVrloVeYZVoQACsXerE4soz6t6JM+E3YBiDctHiPp0O/8dhYdcYfd8cnEj9DgXTrGDuLKaHuPEfzzrn2we3sXSLatXUnL8sDCDKfr21X8i4mAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 22 Jul
 2026 06:55:47 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 06:55:47 +0000
Message-ID: <2758c5dc-91fa-44a0-986e-1258afc3dbd5@amd.com>
Date: Wed, 22 Jul 2026 08:55:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver: fpga: xilinx-selectmap: add csi and rdwr
 support
To: Heiko Schocher <hs@nabladev.com>, linux-kernel@vger.kernel.org
Cc: linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Xu Yilun <yilun.xu@intel.com>
References: <20260721114258.3324794-1-hs@nabladev.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260721114258.3324794-1-hs@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY3PR12MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 5485884e-80e1-4da0-5807-08dee7be4271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	46iGPLqMSJ65iuHGgP6mJFF/aRUEVlIwQKIxogrY5qxtWpNUhu4Mv8k/lGSge3EzGVtD6JHE51q+X5PWWsan3TNfciDwyVWDZqMvkm3HYfK3t6RWyXfc0seUBbUhKptFijtHjcM5Yw5inRz5+8cMcThkPgMqI8zFQe5jnwuPGUMK7BWv6GxfBsttX1ImRyPuAx5h16CNhRXnjebRto3Myxf/qiOeUC5pc6IRQGSIlXCorHzlUloXSTMXQh4a03vXeI89QSKu7V7KAjdo6H7MUQ7RO86LqheKQLLnXJ44z4FZQvvtHKZaO1wfkV74W25Zery8UX5X6Fu92jgVH0g70pGIMsdknlxEhUMpRxrCbL+4NjxTCC6tKNqSN7yAe0Et4DDoWE795IQ07QNUP+WByu+SnHlUV6mwWm5HxlTqWWGvySVmXDfurq2S0uH1nVYtKkBabWcm0cd7RbkYB68Yu7ZeYhZ71ywT16U0H69D9Zr1U4P5WchEqFfc1+mGlpS0SjBxCuWpbG9N5w9xKXr6+NbKUTvZH/vhXi5TUhgKHAqhfaIatYqgP7PvJ0/MLlsuS3PdKKdC719kRMUdj2G1sLhuIRA5JJk0O3qGxdJ5H9ooHX4ltgBVYvTAxPkBLxmszkOy8zmJVTga6jSvHRi+q7CZ+PAoEByamiGNPJA935E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmM3ZHg5SkpuYTk0elg5ek1ERWg3bW9ENnN2MW04YzFlNlFwTU5hU1Jlei9E?=
 =?utf-8?B?N3RCTm12NHl2SlYzd0w0SjNoWGpiaGV0ME0vL296ZGc1a1gzZ0JXV3gxbmI0?=
 =?utf-8?B?UUlHM0FzZGxpT0FRZFFkQXRqdit4bCtRL1NhUVdNOVNzZWhtVDMyL2xoZk93?=
 =?utf-8?B?RVVlajQ3RTBUNmtjYm1qTmRwenRUbEt2SDRqM3JkS0ppMFNlTXpJRmNwQXBN?=
 =?utf-8?B?Mk05K0FvWDBSNU1QNCs5KzZjeTR2ay9FazNNM3Uwdzd0WnM0MWNzTFV3dk91?=
 =?utf-8?B?WHdLQ2h1cXlZZ2lqUkFhL3dPSFJEc0hPc1NWSzIvSitVSFVEdXMydHpqMGRQ?=
 =?utf-8?B?bGpDaFhuM3g5NE0zdEZSSFBTeklhNjZJSjB6ZXdRUWdRMXQzQWYybXdCTE1t?=
 =?utf-8?B?c3VsNm5tUDRERS8vUFhxTmVZZk8xNmQ3SVVTaitXOHd1R1A1NGwyemNBK1Nr?=
 =?utf-8?B?NHpzWVFEdEtVcE0wV3hyVGFMNXBwbStCN2ZsRjQ1TlIwUzlzMVZhYzBBKy9G?=
 =?utf-8?B?UERkRUN4L3AvSFh5eFl2ek9yOE9uRXdZc2E2bDZSd25KZHFYT2RvcUdZRm1u?=
 =?utf-8?B?MXVPUkFBbXhMdjZ6cGc5UzYyRDQ5REdlVHM2eTNIblpvaGlETkxQL0c3Y2JE?=
 =?utf-8?B?dG5vbnJUektuU2l6L3BKdHhFRFpPU2V4TjlNaGFnbmdBNmpCTkdyeWc3cU5n?=
 =?utf-8?B?R0kwbVZ2OWsyS2Vlb2ZPNDFidlhpTklCa2ZaMCtqSGtrL3ZkT01rMU5aYlJq?=
 =?utf-8?B?b1ptVkptYlVXZ1I1dEdnNmtjdGpBeHZkS2NYVFJsNU9lOVBxYjJzb2RPYThP?=
 =?utf-8?B?WDRMazkwK0FZTXhkWEVIaWl1N0RDMkx2QllPSkl1aVdkRlNCZmlxdWFHWmRk?=
 =?utf-8?B?ZXVOMHUyaHYyQmZwbXFlUWphcXhoRDZNRkxmZ002VnlkOG5BUERHQU4xZmI3?=
 =?utf-8?B?WnJZS2kzRUsreDdadjBzWkIxcmw3SGJCdTMyL2J6WjBieXFHLzVWRWRCZTRT?=
 =?utf-8?B?TDNkYXZmek9NQzFPTXNvd3htY3p1ZHY2d2xvQTZIenNscnFVWmJPY0VlK0lF?=
 =?utf-8?B?YlFXaEw5aXIzSWdqK2MxRzZQSU5KZWhvcDVjOE1NWXdPOE1Tc2ZjYWMzWG1C?=
 =?utf-8?B?bXRudW0yN3RQUGVDd3l1cCtOWlFiSWtpYUpnanE1Uzk3S3RMOWtac3lJN0NK?=
 =?utf-8?B?S1cyREI4U2dmd1ZxU3RFNEJqdXZGblFSU2UvV0M4VWhuT3ZkMVBZRmhVMHZz?=
 =?utf-8?B?Rk9ZWjZIOVF0LzIrdzk2VHFmYktZbFpOblF4bktFNnM1c0N0a3B4MTl5VlVX?=
 =?utf-8?B?K3N4TEhXcVJMaklhc1BpR0tQcjBBV3IxYU1OU1lKZHQ4UHZMeU4zVUNkbFl6?=
 =?utf-8?B?UkRvcklvdWwrUjBnOU4vS2J1US8vSzVyQnQxR2w5QllNNlQwTnRPZzRiNW9R?=
 =?utf-8?B?Q0JjZlovYU93ejl3dzM5TGxCcWhMT3ZWWGJEQ2FSTXkyYWxxQjJMUmlhTlZP?=
 =?utf-8?B?dmF5dzZiRFpEcmVySXduWFV5OVFzKzNyN28zS20vdTMzUjg2WjdQUG1maGQz?=
 =?utf-8?B?QmZJUmhEdTdpTDJlNnpUTVdiRDFyYkV6b2RkVFQzbXNiUVozN1ZsNy9oYzRJ?=
 =?utf-8?B?TnVpQ0dsZkZDY1JEUjJlZThRLzlvK0JoOW40WjdrMElaVzJzOFZ0TzczTVdR?=
 =?utf-8?B?ekRIUW9scXFaMkRZRThGL3FVV1JsNDdiRVZoT0NFaTVacXhTbWYydmtmYVRh?=
 =?utf-8?B?SFRhaXRkdGFlMHdVVURhRGRjSWFNYmVad2VYejh5TVovZThDZFVXUHAxcWp2?=
 =?utf-8?B?eEFxckd4bnQ0Y2dFVmtRa0ptbWdEVVB6WkxYc3dVYUowbnBVK21VUE5GS09l?=
 =?utf-8?B?WWIrdG5sQXJiTkVjeHBKcUpwWkxjQTNQK0RjbzZQQThMMXF6YmgvRm9oS3hU?=
 =?utf-8?B?SURpYTQ3ckRYRnF0VGdFckNLNDM5MXF6RStMdEc4N3YrbjExU205bVVRL05x?=
 =?utf-8?B?MmFPbFgvREQ1c2dyL2hzb09uV2pyaUU3QnUwTkRXYkpBbVZTdVZqbXRGN0o1?=
 =?utf-8?B?UmRWaWN6NUtheTdmT1BhdWxYZ1l5ZTZEMGtUVGxhN1pER1B0UWZ0L0xYeElj?=
 =?utf-8?B?OHlBZjl5Wm9LTk96LzFxVWptamRFR21OR1dIQXVHM1dYZjYzcWtMQlp4TG9T?=
 =?utf-8?B?OWtDZ1FsclpLam4zS2haeUlMcFhRQnVnQVhLT3JTUFJuSnpCZldUK2hScG5R?=
 =?utf-8?B?QTY2ZnpoNnN3SEdZR29PUDN1Uml4MXhZS3g4MDdialFqT2ExMXUvRTNjdWhn?=
 =?utf-8?B?T3FpcFcxb09FNHZEdTZDa01zb25rZ1lhRzFMZzVuM05KS3VOV1BOUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5485884e-80e1-4da0-5807-08dee7be4271
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 06:55:47.8869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVk+fhiZ6b0mch/bmNHpp8i8CWz9SmzI2YzoZM1YbvCi9t4u6W4nb4ahL6W0UUXf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677



On 7/21/26 13:42, Heiko Schocher wrote:
> Add csi_b and rdwr pin support for the xilinx,selectmap driver.
> 
> In current driver the pins are configured from DTS and set to
> GPIOD_OUT_HIGH. This works in case you have one FPGA.
> 
> Extend this to really implement csi_b and rdwr pin function in
> driver, so it works with more than one FPGA.
> 
> Tested on AM625 based board with 2 FPGAs connected to GPMC.
> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> ---
> 
> Changes in v2:
> - add comments from Michal
>    - skip check if gpio descriptor variables csi_b/rdwr_b are valid,
>      as validate_desc() checks this in gpiod_set_value() call.
>    - initialize the gpio variables csi_b/rdwr_b immediately with
>      the return value from devm_gpiod_get_optional(), so we can
>      drop local gpio variable at all
> 
>   drivers/fpga/xilinx-selectmap.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-selectmap.c b/drivers/fpga/xilinx-selectmap.c
> index d0cbb5fdfe3a..d5175f9430e4 100644
> --- a/drivers/fpga/xilinx-selectmap.c
> +++ b/drivers/fpga/xilinx-selectmap.c
> @@ -19,6 +19,8 @@
>   struct xilinx_selectmap_conf {
>   	struct xilinx_fpga_core core;
>   	void __iomem *base;
> +	struct gpio_desc *csi_b;
> +	struct gpio_desc *rdwr_b;
>   };
>   
>   #define to_xilinx_selectmap_conf(obj) \
> @@ -30,16 +32,21 @@ static int xilinx_selectmap_write(struct xilinx_fpga_core *core,
>   	struct xilinx_selectmap_conf *conf = to_xilinx_selectmap_conf(core);
>   	size_t i;
>   
> +	gpiod_set_value(conf->csi_b, GPIOD_OUT_HIGH);
> +	gpiod_set_value(conf->rdwr_b, GPIOD_OUT_HIGH);

I think GPIOD_OUT_HIGH/LOW is wrong in this context.
If you do "git grep gpiod_set_value" you will see that values are 0/1

Thanks,
Michal
