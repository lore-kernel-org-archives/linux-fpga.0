Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795659103;
	b=W5/26F0yQ9DvTto+BnTU0LnI8yAj4buFz3I7agxfSpeL5vYJTuIY81wDzROfvSda6fpF
	 wqJa5g48nJTrmy8FGp82kbG+JM1UUgB6H4ZCFqMOpL6tcvddnkVvNb6e4ZieeUeyMRsBk
	 6fTySjwXnEd9tTvTOssWz7EbKTgMiGT3GSyU8qqRWWdhSpV9IodkY+2AQCUI0amTbIrq9
	 vmXMKMCCaGPFzDHXI5fovNdv6xPiDNp6yPUcQqEAAKZ3IVr0fzkI31QHC7RiJXRFmjmBU
	 tpmCTcpaq2qQ/HQHFR6PMAjDBZZ3GCf4S7SyZtnTkAdIelZhJXSFxYF5Fsk6S25IfrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659103;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EYtn17qrEslpXSRpyhlXqVUMMW6qX3QMJ2tUcKqmTxE=;
	b=o4o82l4up/0aV/dVAa0g0cla31ey+H/4JBu607Jr+T/XyMPLenPWeNgv9d9p0pqZrero
	 DoZxBhGFlIDLAUHxvvgxv/dJ9uVYVRNcT0b4TZdM0ZiJvbi/LXabhd2mLm213/tvd1CjM
	 8UiemMTImOYaGCgrIaKkfu+3wn9EtRZeaNVubWBV4xojY60JyOQRrR2wQlyBX0uWWxQmz
	 XxK8pqUT4U4GN2va8Uq1CG3l5qgq7Zte9yEy3KXpMlaO9h3VQWjYZ1fbOjbO2GgcHrtPe
	 1cCw/N9H2fhgbRqnsQmdoJtR1xcBqYqhsKU3CaAAHj7l4Fl6J8y1/kx98JWFxTXYgGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=uTK1wYYT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.70
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC0B606A31E;
	Thu, 26 Nov 2026 02:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BC0B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=uTK1wYYT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWfGfZ1LkvuOnUNOXmvQBHevfPcQS0itnqLpY3aK/BPtP4SHskP4lpV4+RLDYvKTRQ7LFG10wSuvpvQh7s9nEpAFEBR5tDlJipS5kMryTOGNoT7K7Uho4G0sVGlWEV54GcGlG0Xfj3QAtxtb/F7nzTdfTNI5Ov0UPkIMvT7Lv2Q/ylIHS8nne0xY71j+FGqU5f6/QZHurO1Xb0TDml6qqUyoMCKIDrEd0ZMNR7ki0NdLmevsqjD0FQ48cxmFAZ4AdLhi+CS00ngRrknzW55BKUhBsl9KBqGp9nX+3bUurZT+ADL91263DhgkchSYqoJ7VazUNryFhTo0nugcv4kA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYtn17qrEslpXSRpyhlXqVUMMW6qX3QMJ2tUcKqmTxE=;
 b=xTtc00FNIvvzDsPJ5EFNGaAroj2jW+jS4ocV1NeJNE966A2ngdf24Z/4ZVDIJyQGNsqFVFy1H7F4J86B01ayw9gcg7mWcaIIWvO0TELsePgm3TJkEK8h4F/bE3GMo/JfFUD8Nz5YMF+s/pcWppRq+THK+XQey0KMqHugVW+dyBIK84+rpOQYN62CRzU1gxHn0hIVlJtafpEVgLX2rNMarewrYP1u5t7+Z5UU6RZlY0nSYZMhJW17/rswggQEWmI5b4Qj6g0fbtPP525dIne0SxUrMvqMCkW82HXu52ZlfEgWO4bmKpHbS9QVNutBbf9cDXZT+wN3uVp2+i7/MH10Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYtn17qrEslpXSRpyhlXqVUMMW6qX3QMJ2tUcKqmTxE=;
 b=uTK1wYYTof35iGPoZgTN2IrwjSy0XSfyZKIIgnuej0dB1UAjYX+WKDOLvtwU6HWqrZb/qXGMfV8QRN7ccKzcviTSgTxYQmmF/6/h31aPdY7tiEGPOS6ZnGuUQodxJB05M+0kMlCo3Oqb476nbkHlFKnlvzCKUbB1CbEDGI3b6q+UWO0V0zinBtfq3ELHpmrsdhrS6xL8KBMXk7r3zEeY09T7EuizH4Mkw06Y5Wq1muBNwgvZtFb/sqy18TWlLzh3CqRVXgBvRLgTjanohXt3tKvBCAZiEafk8hvGVDrPXpMfHIpTTVwm+VOVq2WtzcQDdJruObtQ1AQjjfukKJPnDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by DSVPR03MB989565.namprd03.prod.outlook.com (2603:10b6:8:41b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 02:11:41 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 02:11:41 +0000
Message-ID: <8284a6e8-733e-4338-9160-2d9d79ceac78@altera.com>
Date: Thu, 26 Nov 2026 10:11:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fpga: altera-cvp: Handle truncated bitstream with
 padding buffer
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <3c1bb384cb9cd5bb35b3c7e68a4feab95ef4ad60.1794987679.git.tze.yee.ng@altera.com>
Content-Language: en-US
In-Reply-To: <3c1bb384cb9cd5bb35b3c7e68a4feab95ef4ad60.1794987679.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Post: <mailto:linux-fpga@vger.kernel.org>
List-Help: <mailto:linux-fpga+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fpga+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|DSVPR03MB989565:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b166db-4283-4e2f-615b-08df4b629bff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261102123227099003|56012099006|11063799006|10067099003|261022105027099003|261021135927099003|261022075727099003|261022115727099003|261021133027099003|261022113327099003|261026135527099003|261021123027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261026130827099003|261021130227099003|18002099003|261009223027099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TsgDadd+ulKrGRaBXtg3lLoGttEk0GdTe5Xm5+Rr/ZcRm5Ak2SpPXq398b7wVaNSGH746IVLLRHHryCFNh47QPbyluIJ95tk7CykxqnahTXFosfmeVo6DpxM/y8nQtn9CYmmWxTH1j2F0vTB9MX+enWLY1oCZ2p6Iq7+iclknkRS8/yTBBjIF3y2K/e+NhMSgtYxrl85nDcj2keQYA9KJ59nuQ9S7cHxnAsg48ihCFvo0Q9EwEfbtPA2ACiZ/snTwHMkiZ/Vs5F8zASwGjmJghBB9c0DijPEsSXheDfgr1Y+gu1gPA4q2oOvHt+DLQ/4J+kQPPLN2Q+4WQ05/chJMkj+Mtplo4zDohxn4DoyGNyrDSABOiJO8WyDaltw2LYTPNttTw1dUddJEmnweCxA/XwpRRf49D9lRDFwFpS0MqWMkiZz45ewirdgb/PwBDZrFwfG7IA4K1m+a2evgqLv28apKynReGddR2YmAbQVeKE4YckTsC79JJWIiu+OzqGGt3TSS1jzSIzqQZs0IcWTCk7u1b9YeKXolQsM3XG5uxNhBwBf0fYTHc2KUNZG7C0M0se9DpdvbTVWitHRX844Kg1XwdTkMzg8X8f3ahC5DYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261102123227099003)(56012099006)(11063799006)(10067099003)(261022105027099003)(261021135927099003)(261022075727099003)(261022115727099003)(261021133027099003)(261022113327099003)(261026135527099003)(261021123027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261026130827099003)(261021130227099003)(18002099003)(261009223027099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3FmRkljTG15RWloNUFpNDZNYVZBVnI1WmdDZ0FXeWcwK0ovVWJWTzJEd1dI?=
 =?utf-8?B?MVE1NlQ0UFowUzJiNUtYRU1QL3lFcmN4VGJMSWxIa0dqSEszdTBpMlBtQkRu?=
 =?utf-8?B?THVuckFlMUl0YWp1SVZ1dXNPMWgvdDYzWUc3cGZnWVo4VU5LWUtMUEEwVEMv?=
 =?utf-8?B?SlJaMFJHSndRNVMvMGdwYVZkTHVKeTFXdkhCQnZHTE1qWEJoTGF0MzFaRU5l?=
 =?utf-8?B?K2VtZG9rSTgxRG5rZXZ5YnVHZjFXbWl1NHEwRlFaRTdMVC9MdVEzVUxkamFH?=
 =?utf-8?B?Y0thQldRMkJLbkltNmZ2SU5GRE9LVk9VVXBXNDB6YTBPS040S2tpZGRRaGxI?=
 =?utf-8?B?Ti9GMENiWWtnUW5EUXdTS1JMRm5NTWJkMVlsc2dMTGtYL3U1ZTZEaU9IVm5u?=
 =?utf-8?B?Qjl6b2ZaQ1NBRjVsZlhMN0UyRG9FQUVmc0lCT2JzTTBKSjFxMUlDb2ROOWF0?=
 =?utf-8?B?SlNuTTFtUVJVcU5NRFk0MXp1a2xycGxmQTBYenBOQUNocEdXMmRBK0huTFBi?=
 =?utf-8?B?Rk80cU5xanRGYnhsZVpRZE1mVjZkQloxZXM5K0NkTjV4ZFBFdVFrclZCZFE1?=
 =?utf-8?B?S1dlSFhSSWR0VGtCKzdraTFSd3pWdFZTLzFyTE5MQUwraVNpTTFoTS9hN2Yr?=
 =?utf-8?B?YkcrazErUEw3QWFLRGIxQ0ZjQWJQUGVONWwvd2VKT0NuMCtvclhwYXU4UG1C?=
 =?utf-8?B?Ynl5amRTL0ZVQk5HWjdMb3hXeE9wUEpGbU4yRWRCSGVmeWt3VmxOV2ZwQXdT?=
 =?utf-8?B?UGk5ejl4YzVjeWNzMTNyNUVIK1h1ZS9US0EvelF1NE1sM0phK0NWblRuVnVS?=
 =?utf-8?B?QUZZQ24raERKdlZrK1dOZDVudU04TkkwUVdzMVl3OXhkSFkzbWV4SDNSTHBp?=
 =?utf-8?B?a3h4NnQ2Q2RGeGMveitmTWQ0RUFQa2MxNDk3cVpsQ2dOejljRy9HRE5WMkhK?=
 =?utf-8?B?c0s1QTNnSWk5aEJHcUNlL1dmRG4yRVpzTjJrUHcrMk1ZaDE5cXhUMXdvYUFQ?=
 =?utf-8?B?UEN0VXRqUjVXVmNYNVU2dm1uOHVsMm01Y0tTZkVUajBteWFGNkI3WDFWc2RP?=
 =?utf-8?B?RFBhTkRYWm5ETlZpU2IvTmpJVk1ZY0U2TFJadzNxOXB6L0NJNURHYmlua0xh?=
 =?utf-8?B?SDRqZGNTakRUdlJQdytYa0wzdTZ0dzk3aENmN2FOelprYThTSWNFK1JsdTRH?=
 =?utf-8?B?d0JvdnYwcjhGVWZ4a2pHellxdU5uNFpCNFd0ZUgyelhCbXNlQVptZ3dWbnpJ?=
 =?utf-8?B?WWloT2U2ZzJpZGlEYmpGVXNudENHQTJlQ21Ccm9xWktJU3crKzIzZXUrOHV0?=
 =?utf-8?B?K2k3TitZNFR3TE1NcXd4VlQrOUxrR3lzdFVwZThrblJyY2t2dnJleHVsOGNh?=
 =?utf-8?B?TzFOdTZROEE2b25xbGkxREpNNTh4d3VOTEpxbkpsVm1oWXNhenM1NVB6OGxX?=
 =?utf-8?B?SEJpeTkrOGlnd2xiTHhGVmJHK2xxbmpZUS9ER1FIUk1uU1pyR0MxODFuQlM5?=
 =?utf-8?B?b2k3bElIUjVCdVdNT0pQYTIxbjdhTWIyNGEyeGdBbjY3VzlBdVJvQnVTNngy?=
 =?utf-8?B?eGprVVdFdk5SaGhnaHAyT3ZXenNSYlBsUG1venF4L29lazFtbmI2VTVGby92?=
 =?utf-8?B?VHkrWEhtOVpGcGM4SUQ1Q3phb0xEQ3haWWlkcndHcDhIS0hjM3VNWnJlUk9E?=
 =?utf-8?B?VjR6UFlIazNidkVVKytNN29hd2UxTE81ZFJZUWhZUWdMRWlTVmJ4NXoxWnNU?=
 =?utf-8?B?NUFnYU1zdmNzZTlobFhlcXpGNWQ0dTMzUHZZWUx4aFF6Z2htREgwVHEwdGNp?=
 =?utf-8?B?ZjBRRDFGcTNPZWhUMWZPOURWL09wWjV2WWhiSncwSkJZM0RHK0NVUzR2Uy9m?=
 =?utf-8?B?ajhiNThoaS9Ia21nM0ZNMnZ0RzcwVVBGRTJmUEtldjFieE12MVpqU0o4Y3R6?=
 =?utf-8?B?NlI2VHBNcSs4TVRYck0ybzdUZDFucmpXMjB6QXlrN3M2c3NRMUlDd3hDRDVR?=
 =?utf-8?B?TURNQUtCcFBwam9ZUndYZVA2VGdpRFExdG5IMUdMcmdQS1hLM2tSWGVJVkhM?=
 =?utf-8?B?aVJJSE9oRmJIUkFEdUMxUG1PaTkwRm84bTVBNlZRQ3cyd0hLVko1WlNWeW41?=
 =?utf-8?B?WDBWeGo2T1NQVThIY2p1QnFCL0F3S0YxalE3MXRmYUNzQWg0ZTZ0TnI1MHM1?=
 =?utf-8?B?dmtCZWNWbEkwWXhmU1R2QVd1OVBSZ2owUEk0ZzhyWGRvbVE5SWxuaFFhTU1w?=
 =?utf-8?B?T0M5cG41dHZTQWNvWG9tbEZnVVNoZGIza1ljL2xSd1A5ZmExTVp4ek03bW9R?=
 =?utf-8?B?cGxzRWtjc1h4V0t1YUJBUjQ2cENNZ1ZJZ1Y1MW1VVFZMcjFkOXlFdz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b166db-4283-4e2f-615b-08df4b629bff
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 02:11:41.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0GorRfoVu4ivnDI5Xk5ZbF/J6BRQHQzeFav93lO39Aqs1cMrWTwNF/MoN0YPI80KTNKW0jdCtWmD7n4aZm/Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989565


Hi,

Gentle ping on this patch. Any chance for a review when you have time?

Thanks,
Tze Yee

On 18/11/2026 3:43 pm, tze.yee.ng@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> The AIB CvP firmware requires a minimum transfer size of 4096 bytes.
> When a bitstream smaller than this is sent, the firmware DMA engine
> stalls waiting for the remaining data, causing a hang.
> 
> Allocate a 4096-byte send_buf at probe time and copy host data into
> it before each block transfer, ensuring the full block size is always
> sent regardless of the actual data length. Also improve error
> detection in write_complete() by checking VSE_CVP_STATUS_CFG_ERR
> instead of VSE_UNCOR_ERR_CVP_CFG_ERR to catch truncated or
> mismatched bitstream errors.
> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Note: I am taking over this patch from Nazim Amirul, who is no longer
> working on it. Nazim is kept as the author.
> 
> Changes in v2:
> - Rebase from linux-fpga/for-next without code changes.
> 
> v1: https://lore.kernel.org/all/20260619040811.20038-1-muhammad.nazim.amirul.nazle.asmade@altera.com/
> ---
>   drivers/fpga/altera-cvp.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 103446465e0c..c9357cbe7fc0 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -82,6 +82,7 @@ struct altera_cvp_conf {
>   	u8			numclks;
>   	u32			sent_packets;
>   	u32			vsec_offset;
> +	u8			*send_buf;
>   	const struct cvp_priv	*priv;
>   };
>   
> @@ -518,7 +519,9 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>   		}
>   
>   		len = min(conf->priv->block_size, remaining);
> -		altera_cvp_send_block(conf, data, len);
> +		memcpy(conf->send_buf, data, len);
> +		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
> +				      conf->priv->block_size);
>   		data += len / sizeof(u32);
>   		done += len;
>   		remaining -= len;
> @@ -557,10 +560,10 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
>   	if (ret)
>   		return ret;
>   
> -	/* STEP 16 - check CVP_CONFIG_ERROR_LATCHED bit */
> -	altera_read_config_dword(conf, VSE_UNCOR_ERR_STATUS, &val);
> -	if (val & VSE_UNCOR_ERR_CVP_CFG_ERR) {
> -		dev_err(&mgr->dev, "detected CVP_CONFIG_ERROR_LATCHED!\n");
> +	/* STEP 16 - check CVP_CONFIG_ERROR bit */
> +	ret = altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
> +	if (ret || (val & VSE_CVP_STATUS_CFG_ERR)) {
> +		dev_err(&mgr->dev, "CVP_CONFIG_ERROR!\n");
>   		return -EPROTO;
>   	}
>   
> @@ -729,6 +732,11 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>   
>   	pci_set_drvdata(pdev, mgr);
>   
> +	conf->send_buf = devm_kzalloc(&pdev->dev, conf->priv->block_size, GFP_KERNEL);
> +	if (!conf->send_buf) {
> +		ret = -ENOMEM;
> +		goto err_unmap;
> +	}
>   	return 0;
>   
>   err_unmap:

