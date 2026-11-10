Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794276392;
	b=BT1dAyQ/yLy8N8JKSFuW9Eb/Z38MJj9i7CXWCWG32XazQkj/RNdwb8FDjyvM8GEqPBFP
	 XtZJEAD7EL8/X71CKWBVxaY15crNYaYDfvFumBUFsnXrYMwZ3WkmDXLqDJkwPqZTfvco+
	 X7hM9WhGAZmb8X+mK1vHSOGB+k5hj1DHPcjKBQGcv9wgkObXFru/Amndm/DVNKAeekDGI
	 vhSW8dSZ688s9EIUnNGLb5q9m54e4BhYGpzyFis4MqtKnOvy88r18sWEbwdE33tu/jy0Y
	 2KiZPXrH8XJZOAZueRV8dTxmAioB352KMJU9EjYuV3x4po7CxnsUtCkAYUlYzdaaBgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276392;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=7utAzJmpaVXvgzL0PS5ORNv8EEn05qKQpzQC7lV4RMk=;
	b=Fgl30oGEEnWGyb00bCekd8ManWYUmRM24zZo06L2oRFh1R9vUs768zyF6ciyzsuoPGv/
	 mFVcL3dGh9WILwJVEAiCMiYg6bktbZGqf75GE2pWgkx17EPcjiQaV5p80yaMXzNBW6Vht
	 ktNpB3bMAhEFV6j0I/AP06frVRwr6d/KktHuof48Te3h9j+ApyeD1PHizdKTemz9xjztM
	 t3uZRDstgCSv7eUSBqQ1NUy5CGOInNd9tR6NijgrYA6uJJW2j8czVw8c6Rb566/NB/d5J
	 mHAp7lSIVKJ43WNoQ0IXebi9tDzzV9eI+WuuLOizmWYkJD2Pt/MNyaVrfJDXMi5nemg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=d9b83nqC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.34
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A901606A31C;
	Tue, 10 Nov 2026 02:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A901606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=d9b83nqC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snVyle2wGqQIcs+A7GpIwCJYAjEV35gnzKdsI8r7v5yQTcf/RM11gPVaYo6+LOjk6UvBkySYyCAV2R/NvLvDEDTxSsVwK2s1rmN6eo0Gt4VNfU2UKs9VMuHpxGQBRfroL/kGrFCIawfbY2JIMTmSwJs7y1Y5J7ttGsp5VM8T+nmC7rmyd3Jf0CiIQ/XUBdsHzmM+MS82wbpE+KTQG6OHMyVTQV5jU3XspNpBhUOJSFHl3DQInk6N/dkV5VRSNmz1heX+J2Aey9TwqQrhsLgeVkoCxVpQqUROr+iFRUNchKQ2wI4CdzYTMRrAs3UsJd33VRDThG5vpi+vvHxlqZ7unw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7utAzJmpaVXvgzL0PS5ORNv8EEn05qKQpzQC7lV4RMk=;
 b=RFQHQrYuuCZ6hf0Ry6qcbXCtF33yPYXJCSoOP7loFyUkb06g2DP8lkSSgSHN3h69RPcAy5Mx3PKK28X5VdgaMcoI5VbI9n6mbr5gMcqm8uuEjpjjKPiJjbn+8+8UHZb4gR0XLqyqko+aSxmpOCsJXHxhAUkc7AAIjCmVKo+HzvD3RrwS6edeVMsgMeuRpEACS34wCrXuromHe35E6BYe2JEWAGWWDBbfo3sxQaqPVkQYzpv7xo18+gMzSAhrJUACLtj7jEF0Se4qBbsCo3qg4ARjR11vH1TSl/XwsYerLM3kObxXHxLoZ9+7WF1TtW79wtBQZrYUJ45bhoKkScx0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7utAzJmpaVXvgzL0PS5ORNv8EEn05qKQpzQC7lV4RMk=;
 b=d9b83nqCbVR3AG7gcyUjk998+7nQ0BG/KMu5Ea47ZeYE5XTZRwLhVtwEPQDftBETnREJPCR/q1gRsUcjN6BJDkIH0wQVS7IEWhk0b5b/enpZSzqtZLsnR06+UDkrkXaHHHqHal9f278VrzD95BY5bPev5hVshHPMKxRuxCjYFevuPf9yrXP9y4Kk8KVdA/oijjkNYXqmSY2fOzrXX9e3XVGYqYUfHI6Kax+gdcHcHO6xV2knofYWAHThsYARSeZSbPFVnpVOK67qIP7Ze8/Wc3S79052NM6QaN7TnbF7m28I9GNnciKV8gra/Vquusr1a1XklalZF24n7DuKvXm8FQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SN4PR03MB989445.namprd03.prod.outlook.com (2603:10b6:806:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 02:06:16 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 02:06:14 +0000
Message-ID: <4f8e2884-efb7-4108-867e-68228fcfcc85@altera.com>
Date: Tue, 10 Nov 2026 10:06:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fpga: altera-freeze-bridge: clear all illegal request
 bits
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Alan Tull <atull@opensource.altera.com>,
 Matthew Gerlach <mgerlach@opensource.altera.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <13856736bdb808b64826aab337d9919abeb3ea5c.1791253862.git.tze.yee.ng@altera.com>
 <au77RfUe85UzN1ns@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <au77RfUe85UzN1ns@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SN4PR03MB989445:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ceef967-a5c4-473d-64b4-08df3ecf32f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|6133799003|10067099003|55112099003|4133799003|56012099006|4143699003|11063799006|261102123227099003|261028144727099003|261021135927099003|261026135527099003|261026140227099003|261022115727099003|261021123027099003|261021133027099003|261022113327099003|261021130227099003|261021121427099003|261026130827099003|261022105027099003|261009223027099003|261026121527099003|261022075727099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	+dq0jJsJgIj0IFYY8DOEmhCL56Jk6ttAqQgAEsfhjoFSFfKrQkxr8a7+kfIuaYoKUyu0DUVdjsF5BhwBdVTsWBLuxyUWt/uVtiCENQMn8tky2WdDlxlNdaAp5Rywdnf4AgCgNovpEev4XYR2uxokJn8VUbBDDIiOd5F8T7dEg/4FMOiTqs4/7yaaj8fIXegQZ7BYEIb0wQdzikmXLzs3jV7KLGNsyFb9+1fJ+SXPau0o2IJijBH59kMQ37sDeNOEGszW6LMLgo62B06a7y42/p8sVBZL6e11TDlEWUikOM/Ax1DGcssnbAONqQcTkano4C6IZ8h6lFZRXn2Q+H4Apl7xNRtWsPcqARjkgzme2BI2+2gveYWd2HRgqALAxGE56ZnC7Q+cglxsU6E+QzI7Jp6whylKMNgyKYvGM/YxXdkDd4kSS1hvCogrBdvXZSW6OWzpQN4ADigMAEFyKTq9LnHLfOZ/bsDuzzeGJ7WyJk9ehnpbhDPgYuwkZgevwKUWps+dQBMABdbjRp7NhWz3Hg+XJ6U3YdUBnRhkltYKTcRPeBWHSEewyV5Dn+I687keFj568emxSLDdXew4cYZJfc+64VmwjUFMtXZwXWDUMqUSXKAXYHXdBoScPtMC5EP8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(55112099003)(4133799003)(56012099006)(4143699003)(11063799006)(261102123227099003)(261028144727099003)(261021135927099003)(261026135527099003)(261026140227099003)(261022115727099003)(261021123027099003)(261021133027099003)(261022113327099003)(261021130227099003)(261021121427099003)(261026130827099003)(261022105027099003)(261009223027099003)(261026121527099003)(261022075727099003)(260925021311599003)(260925022911599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wkc5SVVxQXo0NmM0dTd2NG15ZWtxTHBxVEdSbXZaTHdvQ1dLZGsyZlFpc3N0?=
 =?utf-8?B?WXZlMkRyWGtrTmhyY0kvc2hPRk9MMFU3NG5BanJsUWtPcXZmdm9yZURPQURI?=
 =?utf-8?B?MFJadE90alNkWS8yK2REQlNmZWJhKy9TQ3M2Q2w5UnVYd0VySWVIek45V3Rw?=
 =?utf-8?B?YlpYZkVSU3FFV2FuSTdtRzlaa0pCTzJCTTkwQVdlelViVGFDQTNlbUY1bGtw?=
 =?utf-8?B?YUY2M1N1S01NK0poNS9HVnFFbzB2aDh1WkVLSDN3dTBYSGdaampoMy9wSE5M?=
 =?utf-8?B?VTZkeGo3QW5Pb0tEODR4b0ZmbjljcitSUm1wOHcwOC90NS9HR2YwYkNPZDRB?=
 =?utf-8?B?QXZPMTZBOU1TbnRJQytwWnZENUNPK1Q5ZjJiNzcxNVI4bVVkWlkrOXV4TUor?=
 =?utf-8?B?M3hobE9SVVZjS0VkbmZFZG9yd3QxQm1MTnE0QUxubUI3TUY2bXVySnZHM3RM?=
 =?utf-8?B?TGFzTS92a0N2cks1L0lLeUh4OU9BSTE1WU02L2d1WHE5N0hFUStWNnQrNjFw?=
 =?utf-8?B?WXJWTnBzZkVOWlZwL1ZMWUNNQVNoNkNKdVpqeVJwTXNraUNpVVhBd1I1TEVq?=
 =?utf-8?B?VFFFSjREdWRkMVZ2dktwZUxSeGRSMy90dnhMSEV0N3dRSlBseEN4ZTEyTTg0?=
 =?utf-8?B?ejZoRjZMWlB1SUtnVTR2U2lEcFovSFdUQTBDbHBpUjJIK0V0Tmx6VElRclZ3?=
 =?utf-8?B?Q2dRcU0wTWxrOXhraERrS0tHQkZYbmJZZ29ZSE5leGlPTnViRE05SVhINzFE?=
 =?utf-8?B?amcrb0pVaHZVTVNtMkRnZGhVVmlwbjVaMjU5Q282TzZ5aTVwbXl4RC83R21k?=
 =?utf-8?B?RE5QTjN0dmU1aE5ULzZveGNFbXhzcS9vT1dGbGdsUXFQY3pnWDJmVFFBTTRZ?=
 =?utf-8?B?R0NLOHBtS0xlUW1OODYwUmcwaGdORVh3MEI2cEpwOFQ2MXNMNnVjMzRkaVRl?=
 =?utf-8?B?Um82b21TUXZwOUtpZTRVaG5qdFg2LzVqMlo2VXBLd2R6a28rVDkvaVRWUDhI?=
 =?utf-8?B?Y0syVEVWTkNSOGhSYXVmQ0UrUmFYdkNjeDJ4T1R0QlFOZnB3QWdmYndUbUt3?=
 =?utf-8?B?bG1UWm5ZcVlaRnF6aytWbzhEbWx6cUlzMHdLVkMvWklFazdHcDRPSGN3emhD?=
 =?utf-8?B?bERTN1FjNG9aVHZpd3NNNmwrT2djQWtnL2toVmErdHgwbmFoSStkSjFPVDhO?=
 =?utf-8?B?NGtmT2VzdkVEalFLb3VwS2lXTVh1ZTlyVE1DY1c1QWtLVkFyaTMwWVdpTjlY?=
 =?utf-8?B?VERaMWhmaThrQ2E4M096Y3VlbWloWE9ObVdtTms3bUJHRmpxT3I4alhaNWhD?=
 =?utf-8?B?bEhNenc2MDdoTndlNFg3VjhlODBxQ1ZlZjJ0SjY3akFXOEx4WEc0V3JWLys1?=
 =?utf-8?B?ajVhemZtVkE1UlFpbVRlVzg4QmJGWE9oRkNRVnBzVDhodlZZN1BGVDEzbjBU?=
 =?utf-8?B?czRueXEza3hWSkFwaHpXV1JTVWZNc1phcTRKV05RekhuS3M0QnhUSDZCVTdT?=
 =?utf-8?B?M3NUUDB3Z2xuTFRCMVRuQ2l6cWhHbEszTGdxZXc4M3VYWmk5bThKdTRYckZm?=
 =?utf-8?B?OGpEZSt6Ni94bVBWRndYVFM2YVRPSStJQ0tEMnFON1lzaEd5RlVzMWRkWUxw?=
 =?utf-8?B?ZGFqRjFzelljY1N3ZFZ2UTlNWit0WFR5eERCUmpRUzFxMVdIa05IcjBaaFUz?=
 =?utf-8?B?S1o3amh6RFFVeTZQdFV6ZGNsRDB2Y01STzAxQmxWcytyQ3JCRFBRZVFkYTdx?=
 =?utf-8?B?RFkzSmFnUHNKTXpDa0pBM0hXZUxYcjlhQ2hoWnJLamdvaVI2a0Q5b05lRThB?=
 =?utf-8?B?S1ZSVDBNemRzdGRoWmVvanh4ZG5KUS9sS09Rb29hNTJRd1BlSHVlMGx6YXpL?=
 =?utf-8?B?TU1MNjh5YUNPWDE0QTNtTFhGY0V2U1BtWU15eEFpd01wVUpZaWd2VnJUT1Ny?=
 =?utf-8?B?M3RCQXlhVUphZHFtY3FTWlM3d1d3aDdRRHZmTE5tNWlsQVVDNXRyRzZ6dlkz?=
 =?utf-8?B?S2lnNnduWTJLSVpWeG1JWWQwRlByZXdrNUU5T1JLb0hHdzhlTldTUmFkdlJk?=
 =?utf-8?B?Nkhnb2cvcE11Wno1NnZPc2pTNTRxL2F3SHhwcUVhdXRHRkFzL3NuZnJaa3JG?=
 =?utf-8?B?cnVQdTJabzRleUgvRk01TGZIRkpCQmVabzFSRk14MC9MdXZzZE1nVXFLT1VX?=
 =?utf-8?B?T3RZZmpUQXJOY1BLUWtIMGV3anNvNmNKUFVNbFYxTElWdGpUQmxCbmJoQ1lP?=
 =?utf-8?B?YmJFOWFTaUR5K3pIOFk3Z2ZrQWZIQ1gyQ2VEVjdYUThOL2NXUVVWLzkyNWdj?=
 =?utf-8?B?MEIyMWYwK3Q4dVQ5UWZwckxqUDZXTXY1T0lObnpqQ2RsNUhOdzczQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceef967-a5c4-473d-64b4-08df3ecf32f2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 02:06:14.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjpWUT5eDRvAIF+Z9D0qylocDTnoXpk1ZiFa/RzkqMedsAvdyms4sRxlbSf6qGHRlnuLmX6iZYGFmrilwyXbJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB989445

Hi Yilun,

On 7/11/2026 6:19 pm, Xu Yilun wrote:
> On Tue, Oct 06, 2026 at 10:34:35AM +0800, tze.yee.ng@altera.com wrote:
>> From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>
>> The freeze_illegal_request register is write-1-to-clear with one bit per
>> Freeze Bridge connected to the Partial Reconfiguration Region Controller;
> 
> I still prefer the opening sentences in v2. Don't write like dense
> Hardware spec.
> 

Sure, I'll restore the v2 opening in v4:

   A Partial Reconfiguration Region Controller can be connected to one or
   more Freeze Bridge. Each Freeze Bridge has an illegal_request bit
   represented in the freeze_illegal_request register.

>> bit i is the bridge on freeze interface i. Unlike the status and control
>> registers, which act on all bridges collectively, this register reports
>> each bridge individually.
> 
> This clearly tells the hardware behavior, good.
> 

Thanks, I'll keep that sentence.

> But my real question is, why would the Partial Reconfiguration Region
> Controller connect to multiple bridges? To control multiple PR regions,
> or because a single PR region requires multiple bridges so we need to
> gate them all on its PR?
> 

The latter. One region controller drives a single PR region, but that
region usually crosses the static boundary through more than one bus
interface (e.g. an Avalon-MM slave to the region plus a master to a
transceiver reconfig interface), and each interface needs its own Freeze
Bridge. The controller gates them all together for that region's PR. Per
the Quartus Pro PR User Guide, the Freeze Bridge is instantiated "one
instance for each interface in each PR region". Separate PR regions 
would each have their own region controller and handshake.

If you have no further questions, I'll send out v4 later with the 
restored opening sentences.

Thanks,
Tze Yee

>>
>> Writing a literal 1 clears only bit 0 and leaves the illegal request
>> latched for every other bridge. Write back the value just read instead, so
>> the set-to-clear applies to whichever Freeze Bridge reported the request.
>>
>> Fixes: ca24a648f535 ("fpga: add altera freeze bridge support")
>> Cc: stable@vger.kernel.org # v4.10+
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>> ---
>> Changes in v3:
>> - Reword the commit message in imperative mood (Xu Yilun).
>> - Describe the freeze_illegal_request register layout: one write-1-to-clear
>>    bit per Freeze Bridge via the Conduit Merger, versus the collective
>>    status/ctrl registers (Xu Yilun).
>>
>> Changes in v2:
>> - Add "Cc: stable@vger.kernel.org # v4.10+" into the signoff area so the
>>    stable-kernel rule is satisfied (reported by kernel test robot).
>> - Remove Chiau Ee's signoff as he is no longer working on this patch.
>>
>> Link v2:
>> https://lore.kernel.org/all/2fe34c2dec61150a39d21e067521b0acc031247c.1789956938.git.tze.yee.ng@altera.com/
>> ---
>>   drivers/fpga/altera-freeze-bridge.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
>> index c24c976117c8..2591dcc53d83 100644
>> --- a/drivers/fpga/altera-freeze-bridge.c
>> +++ b/drivers/fpga/altera-freeze-bridge.c
>> @@ -51,7 +51,7 @@ static int altera_freeze_br_req_ack(struct altera_freeze_br_data *priv,
>>   		if (illegal) {
>>   			dev_err(dev, "illegal request detected 0x%x", illegal);
>>   
>> -			writel(1, csr_illegal_req_addr);
>> +			writel(illegal, csr_illegal_req_addr);
>>   
>>   			illegal = readl(csr_illegal_req_addr);
>>   			if (illegal)
>> -- 
>> 2.43.7
>>
>>

