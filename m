Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE683D1AA6;
	Tue, 23 Jun 2026 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212504; cv=fail; b=sISEQ+nkeAxGGRN1s2xA2FoN+1o2vSPTZPO4vE8II0al7R09Ydv02Hg3zSLepmfEGJEXeeGLjSF9DfC5M0GTRXVd32rqvXBGjLguRiBfgulwWX5ad74z+qh5OI/DpqHpNQO56dC07WzljQ+hU5Zmy/9rmVMFnRXyUI6nf12o9g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212504; c=relaxed/simple;
	bh=m/vknN2OoFH3i06+AcSAzU53KMGcuMBidsthVTepDxI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AN4C3+urcJJ3RGDDeN1cLd/+I+TqkWXR+ROh1wOCX2YNlHExa0Aeo+Pc7nMEPieheg7YqKOsMV0qmeKAabtAA3S988Mxg3XAs7e5W/WeJ5Yilfa3JQJyzZUYxyOHdYMUMdHbip96S1leNEG7dOrV5U6rXO4/VKIYYW6VYWepvIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fMAT0FPT; arc=fail smtp.client-ip=40.93.196.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fMAT0FPT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRSYH0Jgfgrg8/dVLrnIj0hKZHzQZNNj6ktDHZRwCtGM8g4iJTgtQlx7A8R3o6uhVil+cU5BbtpfiB8nf5AROOIXCigzgrQX5fBHpSdobEcwCcJ4LOV8fqBgaAr+iMZcteWaa3KlOy9psDRmdMleXzRVxhw2TLp+CZxSHVh3F7Lx12q2Q2IE4SLGUmaSUWBHNdyKUCzmc4ntgNBq86u3DFTofz1tG8f0k/HSRAvRMItA6NR4SldGwAiZS4rwyULi0h2Gh65tAie0a7Pfk5mhuzzNX8IJYDPEWcPqIeGsKlbiv5GMrPL8QTPOmgs1r3xWsbaIAo04APk1nX603N2Biw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suCPLslhsk4q/H0Y34hMT2A+/oivPSF6295VdXXF9F8=;
 b=r1mG7M4Nr/Jqz4jNSX6AOlKvNooFUYwcQIgMneMOVdHDljjowoUAK22pKJi1kma9KAyCun2Z1UQSO6ZEWxvIAp1Lzx/ivyuQZV9xELYzsXbZSj02tE4NlDYfetsq4LUKoRfwRJ6YZkSTbkjZJWdATVcmPI97EHhiljrEfAFJmcHfo75XhdPLif1djk6rjm9Aygh9vexq+PAuPaQZMtR/sa/E9j53gOsyPzH6zxmM/YmwsLx93QIDQk0KuQX4TlbQ8irrRyvzOpEZY1IOsayz1LQ1pwfPMXye0QeUmCVF+5/Dd62lgp2AMEkq9KIhFAWNEyG7CxAAbHEEXKBwQbY89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suCPLslhsk4q/H0Y34hMT2A+/oivPSF6295VdXXF9F8=;
 b=fMAT0FPT1jOrLeZbH5iXa98AIMBvHo6ITUKqqQjCS9rW1mXuh0dL98rF3+vCARnBA/0eIdOzTaZZAIPpHYjFM1RuKP/ODjS3LZrZVpR1tB+1ovjLK1SneZwQ5chdq75Qjmo54UR94v9FfLdaLbjOfuWdKocRIZXSSMGS0BqaK/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 11:01:36 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 11:01:35 +0000
Message-ID: <5bd0f7db-7ec0-4390-b6ea-1edca46e1ca7@amd.com>
Date: Tue, 23 Jun 2026 16:31:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Use devm_clk_get_prepared()
To: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, git@amd.com
Cc: Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Xu Yilun <yilun.xu@intel.com>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <8ca8ee5ba720b608a41f842d2b743302e5500ad0.1782205286.git.michal.simek@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <8ca8ee5ba720b608a41f842d2b743302e5500ad0.1782205286.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0122.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::11) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d538153-659e-4cce-4526-08ded116cabd
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FLCXPSn1GhcOX5ObcTZiozERMiDK9Q1v4lhZu05wh+Hj9lwff3snDFtGr4jZQQ1m94+mQAucUbeEWULLsjhDvaoGZke8KsoJWyiCS/zHqpKKOZWL81jN3w9+J4NQFQ8kLhKOvWIC0a6uH7+/8X17gztMXQBi7+cxcPhgF6fqnEkPDEPF1vBme0X5Ug4dIk1vBxpZehw1BEWh7WmFU/8NOP1S1fojf9Ou3ba5PGKYgFD3ZazWURikkxIj/+55pcATVzUMm0dvieJ6EBfhxK7iucy+xcN3MoAyRDxjFlbbXOVaWma/Q23SHyaA/inO6RB+4BdI91xcS/9iWV4ej+hPvc0wZcwKb8OltrXlNExJtwd7YIxJSRhr2f8dmcPvZX+U+Vgu9Nl0GLGZ447XwdpRM2IHbJPXMgRdlCoqO22Xe1Hqt+sklU3x3XwGjslrcQINy6mZs2G3kpIIQrW0aW3Hj6TeotKSJdwuAF43r8lbV7T/KViiYUteApkLkiz12JLxaiZtpwSn0sMi30S9vYypi6nig9NQhZ/XO5ufDda6URWfK1eSdh8bCavrnMDncbE/WWt7XOjdhvGH5UCcQPExeXH/QS4l4VLSDlpDwezZTj/5bRpk5Q0I36PhoBOdW23gll2D0sl9TFkZVBaKpO4Nd3Pk13pSb80rQQZkNLogxGo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUl2YkNsMExUcEdEOVVLMVdlcWF4c09XL21oTUZ6S2FFWDBnOWJWL1RpUXN5?=
 =?utf-8?B?SkxnN1g0eTFhcERsd3NvYnFjdyt6SUV3MkJGUGFhQ2U3Z2dlQWFpWmU2SFZN?=
 =?utf-8?B?RHg2REI4YlNybkJzM0VmellpdzFZcW4yUkRYdVlqazM3OUh6TlJscVFsN09B?=
 =?utf-8?B?c3pHTm1BUjlNNWIzWEw0M3RCWnhFL3U2RDFLRzZ3RlR4OXdXU29XT3ZNSE9n?=
 =?utf-8?B?amlTdmRSWUlxc3ExYUZKc1FpQTBPdzBPR2xLYWdma3dwYmtoYVF6ME8yUWk4?=
 =?utf-8?B?cDBPWEgwc3YyNkJVNVN1YzFVZ0RSbWd3K3lkWWFnVUpueUI1NnVadGt1bDRY?=
 =?utf-8?B?c0ovQUpSMEFZTmdDYUY0SWtCV1lvamRsM0ZpSnloRWF1NkFkdVlWS1FoYWNX?=
 =?utf-8?B?SkJSR2NPUWNjWURmeVZsZ0FwZXlmN1VVQS8zc2I1S0dweUZYM0tJNCtkY0ll?=
 =?utf-8?B?aWthVHozWnVZUFhnalJPQnhDZy9JZEdIcVp2QVg0YkJUOUNBNmxJZDFhSU9w?=
 =?utf-8?B?bmdsc0VlR293NWVabHNIOVhWWnFNNWRSUStRRE9WZUFGOEhDTnd0R2hLd2NG?=
 =?utf-8?B?bG9KbURQTHZGNFlFaGlxNGpINlVYdVlSZ0gzaUw4dU82U1B4SjBPMUVud3lu?=
 =?utf-8?B?bEVDS0JpUldxVVpuN1hDY1ZiVS9KbVdKMXY0cyttYzBGZVpBTWZGL0Fsd1hx?=
 =?utf-8?B?MjloZXhBNFRpUVc5cTVXQnora3M0Y1FWL1VONHc1dld4bVpBUEdJUysrWTZ3?=
 =?utf-8?B?cXFsVzdreUR3RlJmcXBVMjFXcDd3M2RhZ3VpalAweHBrUEJXaU1lS1hXemxP?=
 =?utf-8?B?UU1nNjJWbjNYV0JZTVU0VmJPcUZRYllRajdCTHM4ZTI5VmlnZWxSajliMStK?=
 =?utf-8?B?ZmJIL3pKRHBhTEtHV2FEb1ZISEpxdUhwY3JsMFF0Z001U1B5YUJYeFNaaDBT?=
 =?utf-8?B?RENvWE53QVJjUXZCcUpHMTV0MHloeWlkMG1Ec0hSbkhVUGtIb1RmVU5JS2hu?=
 =?utf-8?B?QTNSNGZkbkYrYXdiSnVPaVE1Zm5kWSsrYjNkM2FGbU1TNnFXQlZ4dk0rN3Nk?=
 =?utf-8?B?cDVETkMzNllUbzVuTVRMNFphdzVDZjJDRFBCVjR5TVhPZXZvVXVmanhkdkR3?=
 =?utf-8?B?MVovNDBhcTR3MXJDSjJ5QUlVS0k0VGRXelZxMVVjNXBYL0NhU1N2c1hmMGJp?=
 =?utf-8?B?MkdNUGk0RUVJVEdSVmM0WElmZUlBaHZZaVMzYXdIejMrS1dYRWtteEl5RFBz?=
 =?utf-8?B?ZkFhWWwweWJScXBZQWtNVXJHR3Y2Y3REY1ZZTHBtNjF1UkhCM0VwdTIwVDJV?=
 =?utf-8?B?R3JEQ1F4cEFUYVZ2cGJZc0VybkFWMDZ1NW8zMEUxQlRPMkpIdjM1UFVYNEJV?=
 =?utf-8?B?Nm1RbFBJMGdxajhQYWxseHlLSjRUOHVZa3pMUEoxV21tcHQzV0NvblpjMkhJ?=
 =?utf-8?B?cWgyNmdzNEpoM2dpS1FkMnVwUjhKUFpnOS9jaGdzWmNsWFVvYmZwQmY3YytV?=
 =?utf-8?B?S2pPSmdZbjlhT2M5T2haeHB3a3lBbVEvTEZlaWl4bS9IelNnRVZvbUF4a3FH?=
 =?utf-8?B?d2tFMVRmU0YzUlB6ZndRY2dIVHJiVFRSMmVyajFUM0s3RmJXam1zVFczVUkw?=
 =?utf-8?B?YldhNjh4MC9nS2YzNkVaNDZ2R2EvdGl5MUhzc1o3ZDM2OWlISEdnMXVWa1ZN?=
 =?utf-8?B?cXZFMGFXQ09ENkorT2x2SWlzL3FqM2FSdzFrcEhLTXFUSHlYc25Ka1FNMjl4?=
 =?utf-8?B?QTNKNGFTeVFheUhoNnZIV2d3MkhFUURnZ1VYVmprK0NlcE5Bc083UTkrL0o4?=
 =?utf-8?B?bXZuOUNETk5Da25GZHFUL3dnY2lLaExFVEpYN0FwUW9pcDE5Znl2ZnozeUVV?=
 =?utf-8?B?RnNhZFNOL2NPR3pNbzdBVTFSODdnTVNscmt4amtzMGZsRERtZ1N3aE1zLzNk?=
 =?utf-8?B?cE50OWpxeFJaZlJjenhQMGoxd3RmUFg2TldlUmZXaEVURFo0Nk9TaUI0Z29E?=
 =?utf-8?B?SjNQR2E5UXdwQkNvbVJqOVJkMVRrZXRuZ2Z1UVVzMUhFQnBQc2hCdGJpZ2VH?=
 =?utf-8?B?WmRFSGRIM1o5OFJ1N0xFWGcvTHBqcGg4NDVOcEdyKyt5VzRNcTlYYlB4UXFx?=
 =?utf-8?B?TU9nemhxY0k2UEwxbzJMSWVCTi9saUVocnpnWllyZW0wNlprdlhUL0U0MkU3?=
 =?utf-8?B?bkkwT2NaV0FpV3pPZmNLZ2p3L3VocFBMZklEYXVQRWNjR0lQQkNrNHZ3TStW?=
 =?utf-8?B?TTZZdHZlWnNWZlUzWUlEbHlXYUpkWWlKb2NSWnZMMWNQaXhONlNmeG5CRVdH?=
 =?utf-8?B?dGlrZG9ZMy9ObktEdnVNd1ZnaitFdlRLQ0hNNnE0S2ZXalVqdDdFZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d538153-659e-4cce-4526-08ded116cabd
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:01:35.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjK0dkzew5jgltfhE++GFRHqVQa+3kaqq8jhV64ezdcAOKpx+CESntCEPEuF6fup
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871

> The driver keeps the "aclk" clock prepared but disabled in its idle
> state, toggling only the atomic clk_enable()/clk_disable() around
> register accesses in the bridge enable_set/enable_show callbacks.
> 
> At probe time this was open-coded as clk_prepare_enable() immediately
> followed by clk_disable(), leaving the clock prepared, with a matching
> clk_unprepare() in the error path and in remove().
> 
> devm_clk_get_prepared() expresses exactly this: it gets and prepares the
> clock and unprepares it automatically on driver detach.
> 
> Use it to drop the manual prepare/disable dance, the error-path
> unprepare, and the now-empty clock teardown in remove().
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> ---
> 
>   drivers/fpga/xilinx-pr-decoupler.c | 20 ++------------------
>   1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 6994d68e9036..45b65a3264af 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -118,46 +118,30 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>   	if (IS_ERR(priv->io_base))
>   		return PTR_ERR(priv->io_base);
>   
> -	priv->clk = devm_clk_get(&pdev->dev, "aclk");
> +	priv->clk = devm_clk_get_prepared(&pdev->dev, "aclk");
>   	if (IS_ERR(priv->clk))
>   		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
>   				     "input clock not found\n");
>   
> -	err = clk_prepare_enable(priv->clk);
> -	if (err) {
> -		dev_err(&pdev->dev, "unable to enable clock\n");
> -		return err;
> -	}
> -
> -	clk_disable(priv->clk);
> -
>   	br = fpga_bridge_register(&pdev->dev, priv->ipconfig->name,
>   				  &xlnx_pr_decoupler_br_ops, priv);
>   	if (IS_ERR(br)) {
>   		err = PTR_ERR(br);
>   		dev_err(&pdev->dev, "unable to register %s",
>   			priv->ipconfig->name);
> -		goto err_clk;
> +		return err;
>   	}
>   
>   	platform_set_drvdata(pdev, br);
>   
>   	return 0;
> -
> -err_clk:
> -	clk_unprepare(priv->clk);
> -
> -	return err;
>   }
>   
>   static void xlnx_pr_decoupler_remove(struct platform_device *pdev)
>   {
>   	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
> -	struct xlnx_pr_decoupler_data *p = bridge->priv;
>   
>   	fpga_bridge_unregister(bridge);
> -
> -	clk_unprepare(p->clk);
>   }
>   
>   static struct platform_driver xlnx_pr_decoupler_driver = {
> ---
> base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
> branch: xnext/pr-decoupler
> 

