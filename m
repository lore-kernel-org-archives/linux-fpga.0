Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677948;
	b=gJ269nEZZ3Wr8NlNb7FRbeIE49pVRmMC0ZJOFDPOwlZLbmUwKwlF8WOetGkAqZPI6n03
	 WLTFo4DU+45oX7WLPOUyOLAG9eI19L7GYcVIFcWt5zSu83yg8qAM7FXdm0+t2moA7W5IN
	 DPriCAgX/FdSpQwE4WSJBYpXMrQ4KjOPrgNOtC4w1jiSUy/o7+M31BkyabZsrDdwvz65H
	 N41KKJIHLZArevvnsFjYG1Ld3lT+wGmFHP/MZDodYDfqPS0cT5tnfOGf7l0kwG/d9QH36
	 vrpYx1JTvu5LFekgNEcgMMLFragWDf9fk7h0ckk8TBLBLtRWdp3f0XzEhO43mkzibzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677948;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
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
	bh=f04WY1XrwQLSNMaf7kMfyYWobLtalQA+6dr+ASd9PX4=;
	b=GdEtWTe5ZaGMoldbW0vFdBkVJV+r+nWPLtBOvWmMSjzaaoKtBQqMFyYrF/tcY+JoltLS
	 Tnm9LbWXNcZww7GP7D5pgs/3t+wMdw8PqyqNCCe+x0D2wkjgBKYYoC2OGmCqWnCUrWmvI
	 lu4S3Qtb8hkanRigJTXoW62Mnaoctfb0SCyb7z0S3RbhTgJCDcYhNcEG81ITFfD40H+/a
	 OiyG76hkYfy+Bq97jLKg2bkTYJxaqQwpulCX59EkCZBQWb5cJiySnroauDNg4emfw5hz6
	 XttL8L8emUPfEuznuVQ5MmwJxU/DNU6hDXcwWJZmCpZSKp4kNoRJlIG2vU7tajSlVyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=pUI0wgVy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.33
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1AF606A32E;
	Tue,  3 Nov 2026 03:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F1AF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=pUI0wgVy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFBo0S3St2ZIub205KRv765Nz7DNkzKzZsvk3OnncyEeUr9fsfW0479C9FwF9hA/YwBtaw04TEiTgAEdtq/MHAqqcUXLM3iiUjrgBqBcpucTUyGizctJj6inmkDYtfcMT/uKBsdUHC6PMoJlri1pce/xEJ6s8TX5GinmhHAB/4HScpuL1FVQK8YpOW5Z/8g4j86+ZUwwKbo0Rd+8UXcl1mUusaVG0skVTAoZmZt2VRbBFyY42zH0zicQgA4ivgw6l1YVlDLauOCHSrx+55VUJ0NumyPtdV6swFVCwVd1aG2u1JuCnWhjVolDp/87YlSDKhvakM1pdzv1BIhkUMDtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f04WY1XrwQLSNMaf7kMfyYWobLtalQA+6dr+ASd9PX4=;
 b=rmvGIuLX4+eMnWhta9fkxj3Kt2BJgYPiXiN7cnogWahy72nAEDcgp66hgK5QNS74Oly/67Kr0Y7tgalqmQzhD7hX4lyBak5nPuUJml1n0Kg2ONHSVCGYqfxNhrLNma1+/rAFPNi6x50QW9QlRY15PW4w7cPEO8u2A6DFrsah9E/vwaYY4fLwfrDr//lnZmBs9Y96ePm5UabrjSZ1qpHNsRDKwoggmPW0VsmMQCHKqNfAtCnzbY5HinYSJWe5yJwaSFDO0C/Rk81+Pn95U+8DYghE528bR3Fcw21JOuT3EfhEA0+dblyDxrb3/O6TnuRMu625y/ugAf4FF8Gi/1tczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f04WY1XrwQLSNMaf7kMfyYWobLtalQA+6dr+ASd9PX4=;
 b=pUI0wgVyv8IK5PWB/exR54zRhW/kacldkf/QwgVPb50YYZtSes/fF+tiBWx7W/CcshG3EWMtyb28vu8ftGCgmW9wfs556mQRVKZn6qXxJDZ3lDnfIc+4+J2IUnnTBDQs6NkengBPjkLu0YCovTCmXdv5EMUVjS+3QDb9/lOeV+satkwRP31Y+PNl10NiyMaBhtktwlo+d1XpT4wpbnEdTcU++wm4bJEbOF9xhDMrRY5/ATBSeetwV7fv8I6paTX23w1iDZEnqxgps83YxmJDd67hoNqX6CN8wuyb9p2LftMkyQKaUw4OxZ7LKltB7WVbvNpwxZRg1Gn8v7TAfe99tg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB5718.namprd03.prod.outlook.com (2603:10b6:510:40::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 03:52:18 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0522.017; Tue, 3 Nov 2026
 03:52:18 +0000
Message-ID: <7e450658-cb51-4809-87b4-3416c85c0a32@altera.com>
Date: Tue, 3 Nov 2026 11:52:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Fw: [PATCH v3] fpga: altera-freeze-bridge: clear all illegal
 request bits
To: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Alan Tull <atull@opensource.altera.com>,
 Matthew Gerlach <mgerlach@opensource.altera.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <13856736bdb808b64826aab337d9919abeb3ea5c.1791253862.git.tze.yee.ng@altera.com>
 <SJ0PR03MB5950BD525AC77A017084D298A1692@SJ0PR03MB5950.namprd03.prod.outlook.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <SJ0PR03MB5950BD525AC77A017084D298A1692@SJ0PR03MB5950.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH0PR03MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 36528194-027b-4547-d37c-08df395ddb2e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|6133799003|10067099003|55112099003|261102123227099003|22082099003|4133799003|261021130227099003|56012099006|4143699003|11063799006|261021123027099003|261021121427099003|261026121527099003|261022113327099003|261022105027099003|261021133027099003|261026130827099003|261026140227099003|261026135527099003|261022075727099003|261009223027099003|261028144727099003|261022115727099003|260925021911599003|261021135927099003|260925021311599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	VtKZFKwKEY2LX6ePiBJH+XI+WZqe3BH1eVxq7fqJ3qrDweSQMm2eqExV16bdYiCyIL9IJDvPm2PhGhKD6LMAiertv7TdMgigIEF/e4BLxUXksqed1TZGP0w8+ReOLs+CXl5oUr7wgBpUlFs019JOkTLugYjoPDI/Xakq3k4RNR+gxyocoNBkviql8PI2RpYk5KfIjhCMkJgdZJU13dPhAVh+G+QhgzII7x0ReKxbP/6LMjruEQveRkICrzgKpiOcw2DBeGltbT2jbq/QKPrQohC2Ym2YaytZH0CdiOwdelLfB+fj3tT7GP+c+KxazhOQMo9WCnD0BD9xCsZk0D8xCBjEcp9eshKNvQzOA/CWI3/QdbGww+SDNkHtJT7ND22KBhAMk4AKGE5EtLKl4bPknheBaJAOp5pOfA4Eq9/RCEIlWMH18VqlI0VZSDqVW19uSnO+ByARS+ucajTHD4642jF14ktg8IwtXQcBXsA1HzylFpgv0e1wm9JV37o4uBAnziz8jsD2rW2gUL5WD6Cu2OY9XBcrwptEZLGTJIr2f1J7XxBmFwMYYLwgEwuu+7L9g+ksWxQT3CFgAet5YWWUe+ICFCVZE/TnQHsvRaAtM1Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(6133799003)(10067099003)(55112099003)(261102123227099003)(22082099003)(4133799003)(261021130227099003)(56012099006)(4143699003)(11063799006)(261021123027099003)(261021121427099003)(261026121527099003)(261022113327099003)(261022105027099003)(261021133027099003)(261026130827099003)(261026140227099003)(261026135527099003)(261022075727099003)(261009223027099003)(261028144727099003)(261022115727099003)(260925021911599003)(261021135927099003)(260925021311599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGZEcDlXeU1kbVdyRk5nMDhZblVCczVQbHZlVVZjMGRjcFRSbGxSU1REWUJT?=
 =?utf-8?B?MEZLZXNWd2g5akVvZnNPRDgyWFM1N25UYjFTMW1jcjdmUW1aamVjemtYRm1L?=
 =?utf-8?B?ZGFYY0VGQjdxNndwaUdnZ3dVZDBjNjEzWlRvUkl2cVNuVkF0WEV5UXN1MEhO?=
 =?utf-8?B?VTdWOGNaRS9LdXlSZ0hyK2gwNGVkZ2pOYVNUUkpqM2NoMFQvSzBXUDNtUGZE?=
 =?utf-8?B?SHY4a0pvR1MvaXdiaDdIMFhmZkRqYVpFT2ZpbnFRQ2FYbE9RV2dCNFBoMzRJ?=
 =?utf-8?B?d1FkNDBid1dzNGNQNGJZMm81Y1I3OTNOaWRLZ1VpdkViVFJhUVM4TjRhUG5Y?=
 =?utf-8?B?NTY4RTFkcTFNMm92UXNJaGFlbDliMTBLLyt1SHRLTHdqK3VaeUxwcXJHSmlS?=
 =?utf-8?B?RTJydzlBb3Z5d1JUMG1FbDZETko5WFo4Sjh6di91WkpwdStBOFJwMjErZDRk?=
 =?utf-8?B?Vy9pelorcEppV2Z4MFRrbUd6Ym1sbFkxQ0h2R2w5UkxDOEE5WWdxRkNPNDFn?=
 =?utf-8?B?SnJRNDhsN210enZNbkNLS1pkRy8wczNIZ01zTU9OU2xwa2VmcWRLY3pidE1L?=
 =?utf-8?B?bW12RkxPcWNSc3I3Z1hGRXdIbC82aVJCUDlVNVEzcnJFSmVBZStpWXBoR3Q4?=
 =?utf-8?B?VTdmTThrQTBpa3hwS1ZmempMODlSakJaVHpvWldwVTdKRjdSRDhkTlkyblJk?=
 =?utf-8?B?OG5CWTQwVWxFeU4wUnpLclgwb0F6ZFJqWVQxaTBIRkdEZmpYM3VaWjlKYU9E?=
 =?utf-8?B?MXErTkRrUFV0YytmTktjRXpkOTVjcmFqZXQ2SEp5cnJSQXM0OUt1TmxXYzM3?=
 =?utf-8?B?dStqOEhoc09BRHZ4Y0NRK0x0UUpocEk4cjVubGQvK1BXVGNwVkRva256K2oz?=
 =?utf-8?B?Tzg3RTVsWll1emFCcm5zN3kvV3VKQkpnVHNCbzN2ZjhQM2RxU3hORGN3UUsr?=
 =?utf-8?B?SkVXRFlrOEFPejBMaTZ3TlgzdUYxS05idW54N3FtREJkbmp0U1BEc2FUQUw4?=
 =?utf-8?B?ZjBRZ3hWdWpvbDlJdkRmZEl0YXhpWEE3RmZzYjZiQXE4ZWRQcFc5UE1SWW1n?=
 =?utf-8?B?SFVVZ3c0SlpMRDIrWWZMamp1Y2s1dEtQK1FaRG9JbHVMMldzejN4Y3h0aFZI?=
 =?utf-8?B?NEJzYzRBZCtGWldUcHA5bzJPMW9aTk9xNFdvY0NtQ0s4STc3TFZBQ1IzMXZX?=
 =?utf-8?B?Zi9XUDFvWVlFUkE4bWh0WGhQUWZNOGdhMGtXRG4vVDRHb1FqK3MydTMzUEU1?=
 =?utf-8?B?M2ZhZjczMTMvUDJmSG1VV2hMdERKc1JpMElBOW8xaE4zSjZIbVprR2hFM3Jw?=
 =?utf-8?B?MWVoNE5ZdW4rRms0cE0zQUtWL3AvMS9FT2FTK2dacEllMFM0THlPNEFtMUlK?=
 =?utf-8?B?RXhaMjRLY0VTdHFqeElVMDYyNkNVSWRjc0dFb21FTjYrOE0xZml0NlpLckRQ?=
 =?utf-8?B?Slpwa2ZHNGpzd3NwUVBkbVNKNDRITTR2Q2pMVXVRRjkza3IwU01adWRia0Yr?=
 =?utf-8?B?SWx4RDk3QzNJbkx1UUJuNGJLWElqdVJIOXdFek5HVzd0L1hsdmU0RDVseXpl?=
 =?utf-8?B?RUdaSElTaEFlekNVT21LRTZYdnFRcHRIY2ZTTnhxL0o2UUt1QW9lTjJ4ZzRa?=
 =?utf-8?B?VGVjMS8zcUlPd0dub3p3WVdqeEdyTlB4S0hvWkNwSXlHMmQ0b3loTGQyaStJ?=
 =?utf-8?B?WVFPcDNHTHhmWUU1ajBKbzhiWVdJVHZRQTFWMHJaQ3ZXY0pUNDY1T3ZQZGlq?=
 =?utf-8?B?d09LeXgyak5uR0VzUm5WSGlza3VzZlFYQTlLc1EyY1FTSitIb2hmVUx6Z1Ux?=
 =?utf-8?B?T0sxazVXcU54YllGSkRoUmRtM1ZscmNoc1lMSHNUOTU4eTVwSWFTNlJ5OEwy?=
 =?utf-8?B?b1U5Qy9lNGMwN3UyYjJ1azMvL2dHT2h5bnExTWVObUlaejZtdkxiQWd0cGlO?=
 =?utf-8?B?TnpWVERUVGxXZSsvM1hTMWxKSFBKajZmVm1KaEVEQ3pRdDFBUlNtM3VyZnQ2?=
 =?utf-8?B?dVZwNFRBQ1NzMlFaeXk2KytjSFltNTNqZ3dRb0QvSnNQRVJaR25RbEhpTG9C?=
 =?utf-8?B?NDBlc3hhdm1WVEJ1YjhISXZRK2ZKR256V1drbUdlL0dHSFR5SUpmNi9yOUhF?=
 =?utf-8?B?a3Q3Wndra1hLYXVST1c2eDdtQy9PdXpJWnlleUxqQkRJUFZNMDhkTzl6MXVF?=
 =?utf-8?B?V21iRGlRYnJUc2h1cVFjYVY3OHdJa2pYS25PYVN4akU0OHdtelFsRlJzdmVU?=
 =?utf-8?B?QW5OUlZ4VGZTSDhUQVRrYzhJNVhQb2hOeVYrNFZpSUlhSHd3cWp4NnFoeFFq?=
 =?utf-8?B?eWk4dmdFdlFVWDJRSUpyOGpFQVZ5eG1UZ2tNQnpaMWpDeGRibFdoUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36528194-027b-4547-d37c-08df395ddb2e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:52:18.4378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBb9kq6bqdw2zbCszdlwJAlhrFvfoL0PxZcAoi1YkvYf35Ly6E13rkX+CvPgLy3HAZ2KbkuIiQJbWzkoZUmzSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5718



On 3/11/2026 10:31 am, NG, TZE YEE wrote:

Hi,

Gentle ping on this patch. Any chance for a review when you have time?

Thanks,
Tze Yee


> *From:* NG, TZE YEE
> *Sent:* Tuesday, October 6, 2026 10:34 AM
> *To:* Moritz Fischer <mdf@kernel.org>; Xu Yilun <yilun.xu@intel.com>; 
> Tom Rix <trix@redhat.com>; Alan Tull <atull@opensource.altera.com>; 
> Matthew Gerlach <mgerlach@opensource.altera.com>; Greg Kroah-Hartman 
> <gregkh@linuxfoundation.org>; linux-fpga@vger.kernel.org <linux- 
> fpga@vger.kernel.org>; linux-kernel@vger.kernel.org <linux- 
> kernel@vger.kernel.org>
> *Subject:* [PATCH v3] fpga: altera-freeze-bridge: clear all illegal 
> request bits
> From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> 
> The freeze_illegal_request register is write-1-to-clear with one bit per
> Freeze Bridge connected to the Partial Reconfiguration Region Controller;
> bit i is the bridge on freeze interface i. Unlike the status and control
> registers, which act on all bridges collectively, this register reports
> each bridge individually.
> 
> Writing a literal 1 clears only bit 0 and leaves the illegal request
> latched for every other bridge. Write back the value just read instead, so
> the set-to-clear applies to whichever Freeze Bridge reported the request.
> 
> Fixes: ca24a648f535 ("fpga: add altera freeze bridge support")
> Cc: stable@vger.kernel.org # v4.10+
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Changes in v3:
> - Reword the commit message in imperative mood (Xu Yilun).
> - Describe the freeze_illegal_request register layout: one write-1-to-clear
>    bit per Freeze Bridge via the Conduit Merger, versus the collective
>    status/ctrl registers (Xu Yilun).
> 
> Changes in v2:
> - Add "Cc: stable@vger.kernel.org # v4.10+" into the signoff area so the
>    stable-kernel rule is satisfied (reported by kernel test robot).
> - Remove Chiau Ee's signoff as he is no longer working on this patch.
> 
> Link v2:
> https://lore.kernel.org/ 
> all/2fe34c2dec61150a39d21e067521b0acc031247c.1789956938.git.tze.yee.ng@altera.com/ <https://lore.kernel.org/all/2fe34c2dec61150a39d21e067521b0acc031247c.1789956938.git.tze.yee.ng@altera.com/>
> ---
>   drivers/fpga/altera-freeze-bridge.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera- 
> freeze-bridge.c
> index c24c976117c8..2591dcc53d83 100644
> --- a/drivers/fpga/altera-freeze-bridge.c
> +++ b/drivers/fpga/altera-freeze-bridge.c
> @@ -51,7 +51,7 @@ static int altera_freeze_br_req_ack(struct 
> altera_freeze_br_data *priv,
>                   if (illegal) {
>                           dev_err(dev, "illegal request detected 0x%x", 
> illegal);
> 
> -                       writel(1, csr_illegal_req_addr);
> +                       writel(illegal, csr_illegal_req_addr);
> 
>                           illegal = readl(csr_illegal_req_addr);
>                           if (illegal)
> -- 
> 2.43.7
> 

