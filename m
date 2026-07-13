Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370174307B5;
	Mon, 13 Jul 2026 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950549; cv=fail; b=RBE2dXeJSW2DcP1Msbe8lnrDGnf6eKB3ILd+8Rrbqv2v3VEihCQ4dtLvrZjg+rIdR949/SV6KPsATDYu7qK5ydc3z1mMAX/xIGb5OvCSm7BT86PRyrxlZLG9B9XSv0GEaCBobiuHYaoCIV8dlMbX3BPG4iw/cMegUxxNY9C708U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950549; c=relaxed/simple;
	bh=gLwpDRbRJuFWmMrSMakpei6AYeMK3gbL3ZObqfJMUyM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LEFwaeKK5FQCB4BqmbWd3RHa0SYehRkhqSYS4jqrAWObt38uns1LVhwA7OgW+sOt0PWjj5mbtd7ds0nywvQdgzOoYWnCFkPxMMbZ9nCbb8AjR7sd/hmIjV8FrpRrcPNxxDNpXsJIXclfi3FjV2eYSLRcxW+UQTR8ZoP5jv6pQ7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u7jvtfcV; arc=fail smtp.client-ip=52.101.62.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u7jvtfcV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIUo+46fNolKBxd736psB+YaSspX5JPWQHOc9Y9LxoUXSX+NPcZTlEFQ8I+slbli/+wSPNH/DTgiEB25kz3StqOzfZ/nRfiSA2UproZtGKev8YFiExHYd0aSVEOffT1lWa9uGL3iu8zoHwUD0XDaxs73BDoX2bFDKexnefOrIxxEUqLkQ/C6fLmoWxgMo3QHHKphgtDcHfkWPx/GN6NlbJim11aN8IHkk4LPWOk9p2S3dnnDGSIsIBN3Soc4Z9tWXI3KOpBFXeR76fM3I1V35nVXdQMIoub0bMeDCZGIew48Ru7iDMIg/XSewb5RuRuGFx9vtMvMIjUDsa16FMXGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkLVTHGGDkpG5k8KNi/h0dkbrCpO152e04hb2XPCv7Y=;
 b=xkKknBArxhVXVMLeXvLLgIblIgLQR44uJwYeNOIOkU6IHFA4CgWfltJNAeJa0glJwZdQx3R8YC5faZY0RC6aANDfu4Gix3Lj9fGFraxcmDtUQQOAOzGifkjoDQKrWuyOs4qCJ+KubGr8IXkOTLm36eeus2sT5rr8Z812rayS8HPijXTW8i4Yfyhbsbjg4Y+LWupBaRHBUGhQ2+t6uQF7TUPqD+CuGhZtQBvJh0d9CN+7NkZmqN84lPWoLbhAozoxiR0QroWEvrGWX9at0i1eAVvK8FNsmsJceXKaaft9Uvw7c42kFDHtATGQtNtUcwvm6Q2sCrUnc5MJBjISoFbFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkLVTHGGDkpG5k8KNi/h0dkbrCpO152e04hb2XPCv7Y=;
 b=u7jvtfcVoCmfzJUymWnyGPn1e+TaAwfTsVRv7wejXArlkcCAULfR7cf3fS2dEmMy7IZQdTCGM/wCuDurIzs5XUDBRmpfRWnTZlPzPBKirRb3QK241nA9CXA+NMPiyEytLdCuA2rACMkMD0LBSmm04XeKNUlnBMZ5+4gvP+45I8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.19; Mon, 13 Jul 2026 13:49:04 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:49:03 +0000
Message-ID: <701a4078-721c-49a9-90ac-d59697fef82c@amd.com>
Date: Mon, 13 Jul 2026 15:48:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: zynq-fpga: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260713132237.370272-1-panchuang@vivo.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20260713132237.370272-1-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::12) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: d26b3055-68b0-4ace-e8a5-08dee0e57fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7dZEDuZDcyqRpyq0vfgodSna+3R5eWu2n6PVb1Zq67pqT2Lxip3junZWPGd11rO0s+w98Qn7DKzRkciSHc4xDZNxNu8zmkIql2UQIhLJ3R3atepkZt4ikz+06SiUUXTtfGqMOgZVt38wZKkdYFaptUULRq9VUVfMh+J7pGSAgHZCWYFZCLGzXSX83KpOfeDKUq2hb78863zTcFHETO7/lYMsha1ZyPj5rwuUDADLBSdjYTT5xGpOQsuAnZbjeIoGMrxylL/uM1AnaXYH1LhITGXQ5US1ZVWETj6dP+Sf8tZv1IAS0yST/v8b/gIL3guh5LeRbagkmp2YszykmgFxFkP2Z24HX9yPffvTxqkoj2AWk30YlXl1qy0DNQ4FjbUxw0HsnwROy8IfYuiv6yhN6nRr1Uz7gQ3pw2v5G1l6PB+wfMZQW470d3Ys3PbfLsxTJZCrjIoAwg4CXhsz0K+6dIxqt1z4VvirZM5264akqBFxMjArRnmlOG/x6hPFSUssTbfUsnmAJZjLbAg3R0Hvpe9DBEvW7ky02SYWD8L7hMfqx70y+Ydr39WQS/0ouhokdQ0LGg6umV24mzPLd5gLd2bYWfKqR66pPEmbvCVL+S54CKUHewGZnf9S1cqwgOH6NLycS+aNFTrloxrj00VaP24nb6elo9GIWhmzUE4tAf8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWRiSWJyVG53dHlGbjJYQytoMWlib05nQlpHU3FuRmRMVWRXempyNHZxajhj?=
 =?utf-8?B?c090ZFcxZmpoTzJhS2tac0tBei9UNDdsclNJclZtejB2NXV2eVp0L0N5NEVB?=
 =?utf-8?B?MVlrWktXVGRCeW1KWWZycGVZdDVvcm01aVFLQlBjNlRUTmc3L3k3OHFRLzcr?=
 =?utf-8?B?VGRSS0trdEpjZGZSK2RqT0F0WjZnOUQ0UjBOSEt6eC82ZTRxNWNXVHlCYW5D?=
 =?utf-8?B?OGJYb2w2WE1vU1FaWHMwYzhmWXdFem8vaGVRQ0tBMDRXajM1SHU0ZFh1dThD?=
 =?utf-8?B?TkxWV0dranlwc2lvMGVScmxpVWxzSi9aSHkyQjVteCtkQkhkblp6MzhORmNk?=
 =?utf-8?B?R3QrOGphSHliL29kUS83T0FlQ2pIdDVLR1hwV0NtakJncWIxWktLNWpuOGg4?=
 =?utf-8?B?N1VGN0VNYlhSYXBoczFMTGxPS0FaQ1owUXNwQzlWTU1wR3hpUHZsQjRLQ0hD?=
 =?utf-8?B?MmFuTWZEa2RlYkhWbC9IZld1WnU4UHdFMXNmeHM5cVpoZ1dhNlVkMGZpMktU?=
 =?utf-8?B?OHQwSFdYdUwvQWRudDZobEg3Rk5GVGpDVk5xVitCaVFDYmxUTTgrdkpsci9a?=
 =?utf-8?B?WWExZEVwODZHWWRKS2V6MndKTjNnMjQ5Yit5b0Z2azlTbVFoT280eUcraklR?=
 =?utf-8?B?RHB0VUFRVVZ1d3ljaExKNDBmdHphVG8rSFlWMlhrdEJ4ZE40YlVxRk9hVGc0?=
 =?utf-8?B?bHdqZlU5anRvSS81UXRiVVpGelpGSlYvVlFwR1lwKzQ5VWJDNUo0cEJacWFy?=
 =?utf-8?B?RHlzQ3MrU2E0eXFjRmJacmZicFo5UGs5b0dPU1g5YjV5azZ0clpjRThNTjdo?=
 =?utf-8?B?VUQwa0l2cXhXaHJ5QkM2SjROR1JRSE9vbWdrU2RFbmlKdmMyK0xzV1JUQ2gz?=
 =?utf-8?B?cWNlK2xyVmVES1hleERwNGx5YmhvdTNKcy9aM2c5YkNxN0hxdkxXS3Z3TjV5?=
 =?utf-8?B?WFk4UUs2Q0pBZlI2Y0tTdUFPNHI3TUp6clowUkI1TERJZUhWV0JMZEI3OTM2?=
 =?utf-8?B?RzZDRWU4WUJlalR6WWZFVWNMQjRQbWRmNVg0TnFseWVhUFN3ZVRSa2lrNzEz?=
 =?utf-8?B?Q0xHNVgrOWR1ODExMVBIa0kxUitFc1NVMnBqZDVhcEk5bGJZZjN4a0dqRnlM?=
 =?utf-8?B?MVVGUTV5S24vbFhKV3NmVXpXMTdZZjUzTUxPQlU4RXhPNmM5bG92TTZOUHRQ?=
 =?utf-8?B?VmtJSFpSL2tWWTN6Y0w0bDlZYlZzZDJITTZSdVFiMzdNMW9QMkx2dzZad1VZ?=
 =?utf-8?B?T2VQTitDU0M5aWtHNXdtVnNwRXNQSDd4NzJsUVFobXl6SEs5elVQc2Q2d1Y2?=
 =?utf-8?B?ZFNaeG1wWHRZODVjMU0rTENxWDlMa1ZIaFFaWkIwSGpqZS9ENTZ6eXB6dVZD?=
 =?utf-8?B?eEdqTEVocVNDampXOGxSTENDWGFpWlNSaTF4OFVDTm9oVVExV0RpSXNEb3p6?=
 =?utf-8?B?TzRGc3JuZ0l6S1hHRG1PYjBJRVBPNEg3NmJCdjYybG5iS2FlcGFHdDM4U2FZ?=
 =?utf-8?B?eXdLem9FQzhWeGt4Nkl6UnliYUt3cHJKRzJQay9GS3QvRUErdi8wbGl5R0RP?=
 =?utf-8?B?aHpTOWhpQWo5d0lHYkFpN0xkRSt3eU5VazQ2akpnN0o5QnlaOU1nTUxaRk4r?=
 =?utf-8?B?YmplbDBiQXhxOFFTR1JLMk5hQ2JEZXB1R3FmNmd5TC9WK21sRld0UzlmWDVs?=
 =?utf-8?B?QlYzUjRDZkt0LzRSNVlJdjRLd040MkppWEZnTk0zQkRMbDFPQUxYMi83T3FM?=
 =?utf-8?B?TU9tZHc0cDZvZEF6QXlBQUlmK2NyUis5WFUxZGtVOUJFZkN0UkdhWHJqYXJI?=
 =?utf-8?B?YnR1QWZxSzVPTFMwcUJoSnBQUTkzcmwwYzk5MXdvOHhPeUtiN2ordEVwRmVE?=
 =?utf-8?B?NGlZcXJqOVpwQVR4aWU5WjdXWUR1eUFwaytEOEtKald2NGdjY1VzdG5hRjdX?=
 =?utf-8?B?SFhUSW53UDhsd2p0bjlFSXJLWUlrWklmVFFHSHFuNWZOQzMwdG1tajRBU1pK?=
 =?utf-8?B?ZUlFZkVoT3JHU3NTNkh5cjZpZXFJRU1oMFo2VlpMNlRPMUtNS3lHQTZ0NzlM?=
 =?utf-8?B?d1BsWTJGRTZmcXhWWkp3MnBRNS94a0hTWXdYeU0yM3J0cWx6ek82UGo1cXND?=
 =?utf-8?B?a3U5dTZ4NDBmd252M0JSSVNxRHZ4OTZzT1I2S0JkN0NaVEJsS0pZMTJqZXl3?=
 =?utf-8?B?T3NNSUVOUUxWQXNGTlAxVTdtZnE2UjIwUWYxSDVCaGdKOUpmTWdNdGNuNnlE?=
 =?utf-8?B?Uzc5amNyaWNpWlkzVUxKZVFETnRZQkt3ODdvWFNSb256WEtuUlZVVHdsanE4?=
 =?utf-8?B?WEVqQ2JnN0l0U3orNUFQMU4ycTdjeXRGdDk1OVRGVExpUGtsS2I2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26b3055-68b0-4ace-e8a5-08dee0e57fff
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:49:03.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlXH1eKkVbsTiT8PGkScR2K8dqbOzEbgy2ltr7q3O+To+c20BoJaXCwin2FTtqAF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964



On 7/13/26 15:22, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>   drivers/fpga/zynq-fpga.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 9d1d599ef718..2f8ba32e4002 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -598,7 +598,6 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>   	err = devm_request_irq(dev, priv->irq, zynq_fpga_isr, 0, dev_name(dev),
>   			       priv);
>   	if (err) {
> -		dev_err(dev, "unable to request IRQ\n");
>   		clk_disable_unprepare(priv->clk);
>   		return err;
>   	}

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
