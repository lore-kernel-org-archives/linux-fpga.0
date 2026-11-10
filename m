Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794282198;
	b=AWMURkdVO/LavfI0RHucnslxNrLRi1pVqDzKV4uhc3qfAmy8Ggtaa/Hqjaa+f6gvCXmy
	 VA445rMLiA3cY15/cLqgHjr1yJ9qJu4jSuTFn1vJRmQaDBM9SgVIWZT+G12H9NWN7VdD6
	 btv7d8e2XgQvyL+6G0ZpHjwlRBOSPdWP8zXK597ZzoaORixby6NOuk93/pcy53ipRZ5dH
	 P1t2EdKQgCA6HLjjf58eVb56X54xcvz2Wo/xazcib5LogpvtN7RzNwZbbVOorWKWP49dz
	 DD+hBEagEFXTrIEtLeEZk1eSI0dvr6XczX11OCN/Wpl/6l/bYCdXFPSEu6x7OmG7zKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282198;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=+nTTwzUma0Z5VamMUCu1DwTcHv5nhuW4FcuHJH96/TM=;
	b=e9YyjH8Qz9xeMwXN5QxkdhLw5NnS1v/epj5lCfHIIcfBCDIygM4NyjBM6aX2h8vvRJjq
	 r7jsp9ySnqsmZFgnr9L/hGT2FXEJ8OPyH3CdH9VnvVpko6khM7RFGFjufZ4aNckftm2gL
	 A2FZjUdQZqE6vJ4xk8Msyv5wbggTDpbfirPym7zt0pyVz2grEanxSKXkMvu+jeFhEskD9
	 +ZsThdf+6ZTYykWnG6ZdpOPsCqV9fF0yAmfhf0KBHEiLAWZ88zHwucRSD4ZPCn7cOWGLP
	 L01MbW6+9jbP1CnMo0bRnrqWPVmrpK81JfoyFpXWCNUAAexRFsC0St6kn/TymxcEHKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=eI0IEWUN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.6
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEE606A321;
	Tue, 10 Nov 2026 03:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DEE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=eI0IEWUN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIRCRaGHtm/7l4YeJlu6XUzVLaX/HIXAu3Zs1KkHijSIOv1g5IfjYOoAdmaqLFYCCzOhD0FGFZYVwJ2KKBZfoZk8RTbHsrry3M0IHwmX7FXzSSIENZTvGmU3EoEPZwP97kHaPlnIoB1VosEHpxlUljnLoaiFtKoM2WNL7/pA1GlCU+BdEnHdUL7jhOVhhDf+RBJk+0ZAU9IJ4wubtKbWhbT9GxpZAUDeYtxK57Sr96iVWzI2XLvCQzlj5/yudN5iSMbFWIsapWzlGa72hCCU/9IqrnxNbdwjXUCm/+GTY0psUHNX15txMYv4/4XyDN59vZ6uA+mGAqvtEvqtZuF5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nTTwzUma0Z5VamMUCu1DwTcHv5nhuW4FcuHJH96/TM=;
 b=a4OxTkBzyJLNMxY8FBoS/wMJDEwEOJx4oIpm3wIwd4y8b1SxHMWw+z//mB/fGk3z+zYDgUznRxqvgF4z33MdHfpBXOsRw9+/wp7A3QHsIWjFk2H8YhoLUnEtvAGE57/xlwghd8FvBvEyMxzlumAbzdDtiDNAFdHhGseNpwK8ZATmYn3YDeKxmbt4uhnrgmF5+WFFNYr6Ee/EKDGXUzb0tI2iccyKqVQsD5bRn81zGPEBP8qOtr7oMg1bcnBUWKK8wqaIKCkhQ3rt8i7djR3D954sLPWpwW+2xJB+2i+PNErgiePZpQV251VmIAKlpcPLFdp6MOd+pmI6wB9mkAh+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nTTwzUma0Z5VamMUCu1DwTcHv5nhuW4FcuHJH96/TM=;
 b=eI0IEWUNn80ESQVAAktTzGKxhSItdjJvW5Kn+k7Dugm+0sQGPr/iy7D4w2l35uM/uFamVj1ZH7HbSKGa/oQKJEZ43hPGgIIctZZlftlSGA/3OqGBf6j7v6aYJsI++gNjeS4H8GfFs03tc9OOuMHwFur0fl48bf2zpD79oukxllyboWO7HAbTjuzHaWYCzdP6d5U50X9vK9fXFctQhcDJdPMOXaPG3xC302e78EBU4tOE/mwJHHE78Q79bjXxV6GxTuZGt93Id7vCuq2NBl6LgAge4D6X5rtXuClyfbBuNmP20upgMf5DgN5xSLtAvAWa1nVawvRm92E97lDilQd+sQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ0PR03MB5632.namprd03.prod.outlook.com (2603:10b6:a03:28a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 03:43:14 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 03:43:13 +0000
Message-ID: <e1ff5c84-f63f-4ac4-8e6f-1d7026293228@altera.com>
Date: Tue, 10 Nov 2026 11:43:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fpga: altera-cvp: Add Agilex5 CVP credit register
 support
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, muhammad.nazim.amirul.nazle.asmade@altera.com
References: <20261028104019.21225-1-tze.yee.ng@altera.com>
 <au8en9qjdw7VfdAl@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <au8en9qjdw7VfdAl@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ0PR03MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4d6466-e6cd-4d14-564b-08df3edcbf7a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|11063799006|56012099006|261022105027099003|261022115727099003|261022075727099003|261102123227099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261021121427099003|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3Gc5OWfL8gIQoiVGUjpXcOLDLGno/DBuL7Wm9VAeCnw0UP2wNRf+MCzeeXr7Hnl+4/yJz5XM8alNgxoVouuAOvZHv+COoExBmehbO+oNKzFuDhbVaiBpncWZNwXbY7q8IDQJblBiIu6sVXTYTYffdlykptOIOzzYxrZrmFchwwwBZLWqdbZcs65y7z5AvwG2A6RAWkj+tc5sQ3RXJPb2d5MNgdXX0D1PSoyPjkvASGgChcjmr7b+kP0XE4xsKQqRBx2oPutnFuPKT+LOx3KFEWgfK/Kn4VambA0eqz1jhFa1czSzqjFQkNo9p0YkszrrlxucWUPycKggv2zlW4t3MFMGaAHgNspDrKZ2ypm+kK9TrqfKQNMrhRE04eX50+vFmGVCsm9IRBpRjvtsLqHC410tsHiwYfqEDuUGNtu+zrU+oFD158H0YnMiGW+XG4Ps1VGSJ/Xj6Omh0gf/KGAJClX4SWDttkEnCjksRI3N+2kJe04qmRW0gMqV5UWds2B11cXEwqNSzhXS4kpKIZA04gaS0yXpWFmrlKajY/uxwf/Ix77mhzRVhGTtVVmeTGmXn3ZsVCQAuB97TTPj0Kak7nX5q+cNktCyE3D8vpqYUYvOesAob38+e5ulmsKzblGeQVG2RuVhJCWkGLBXhuhxqrZ+dkw4H0lqg8abGg2X0mI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261022115727099003)(261022075727099003)(261102123227099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021121427099003)(10067099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzBtT25jeDdOUXpBWGhFKzY0Wnp1aXM1UTRBRUhHWUdRbTMzNFNleVF3czJC?=
 =?utf-8?B?UGcwRXdTOWk1cFNNZHU3SjFNcnhFbGtNNDR0UENCalVJUGd1emRRKzRyN1hw?=
 =?utf-8?B?d0xWTVFDT3oyZTRtZVg3YUFTdmtZREozMVRTY3hSeGtpTTJDUGxsM3ZZdHVQ?=
 =?utf-8?B?V0pqbkhTL2drSnpLNEVZM1hLdGhMaFNJdmhIQ2wwOEhTVmpJb2xmck9xWVpF?=
 =?utf-8?B?VmZhSk90QlkzWjdZM1V3ejNheGdVZTZlTzdUa29KeGdlOWdMa3JKUW5TRUNy?=
 =?utf-8?B?L2VaZnlMcHN4WWtZcldxczNOeTluQ0orT3Y1QkpUNXQvcTFBYkdpMFd2VkZm?=
 =?utf-8?B?MHUwNnVZUU1PaXRoVWRVQkdqV01BY3BscXRSKzV6Vzh6K0NmRHNpeUZWSEtN?=
 =?utf-8?B?RE51VGhCb243OXhNeW5WWEpOb3NpYUF5dGJOQ2hRUGs3cWw1anlkcTFwTTcx?=
 =?utf-8?B?b0owOGdEY3BzSHZ2STFwaWkwZXIrVHJtOG8vbTFCeUZvMFMvOEFZYng2SnZp?=
 =?utf-8?B?M2FkOURWMVJocXBzSUJVMDUxZjZNYzZZNnZEUFMyc2c4MmJNNUtaSGswWnFC?=
 =?utf-8?B?K0Y5NkUzbU43endEZ2hQS2MrUWVmd0xFdFNOSGlIN0RuTi90dVFPRFIzS1d4?=
 =?utf-8?B?ZXRPMmdIZUQwMXhZZ25vZ1NVUFNhaUZFbHJlR1lwUXdvUmFDWS9lQTJCNVY1?=
 =?utf-8?B?bS8xekRqb1hzbnFUOGZlRkxUSzBYNGhUR3FBRjNRZC9nMDVGemE1SWU1YklO?=
 =?utf-8?B?cldOVzE0VXliKzR5VUlmSlR6RVhIWGRaNGRxYSt1QnA3M3o2N2xySEQyK0RF?=
 =?utf-8?B?bUlqRkVNM09wejg4aWdxWUYwMHpWTmVNR2FZd2svVENMMkM5MlhvcTVBZmo4?=
 =?utf-8?B?MEEvQkpXYjhGVi9obGVUbURVRXVFYnVrOWNQWGVwclZhcWhSaWlRc2FuRnc4?=
 =?utf-8?B?S2FxZDFaclV5ZTFhMW1FSGM1V0VkOXRHY0F3UGZOckZ3RTY4ZUIwV011QkJW?=
 =?utf-8?B?aldyZXJVbTZ0WTlBWFVuZjBVem9ITCt6cG8wTjlJVWdsci9xNitTbzFoMTlT?=
 =?utf-8?B?MUlDSzNpVlB2RnVlV003V1g4Tk5lSmUrdmVYRUhXY08xZFUyNHZpYktJY3k0?=
 =?utf-8?B?L2d2Z2NvbGNPdkNGWkdsNjZIOFhIeEdNT0YxRTBpRnlIZVBLWGRTT2JkL2Vo?=
 =?utf-8?B?R29YYU1Nb0NDVFBUUkZXTmt4WG52RXkyUzlIcGJtTmJ2V3lVUC9YWW9nY0J0?=
 =?utf-8?B?YzBycU5wcjY2Uk9Ic2h5NVZkalZtYnE4c051bkxzUGdoN3pqd0xYZmhTbjRn?=
 =?utf-8?B?cklkY3hneDBPNURiTCtaQ05oUWJmd3Raa3J3WkRLUVFOTWRCU09jVVlyTWlr?=
 =?utf-8?B?UDRMZG56ZVRvdDlHa2dwSEFRRERpVUZJdVJUZGpiTkZaMWY0OGh6MjNGWVA5?=
 =?utf-8?B?NjZnK2o5YUkxczZ0ZVJCY054M1BKOUowSHpvWWw2M0p0NXBXaTVwK0V2Vk1H?=
 =?utf-8?B?U1A2bDc5SjYvRGI0UER6SzQ3VTlmWDZnZ1pBR1FQK2I3eWhVRzNESUwzQk1j?=
 =?utf-8?B?REoxa0hWS0xsZUsyUUVkWmVzZVhVWkxNSG1vWCtQMUVmUHhjWDVaRWxKQU5Y?=
 =?utf-8?B?WVJRaWpHNG1ZbFJUM1Z2eFFDQjN4WjJ1Wkt1cERjVU9ySEVyOEF6ZUR3Snl4?=
 =?utf-8?B?bktCWFlUeVdXcW9mRHA3VG0xa1Btb3dtTmQ5emNabjB6cmxaa3NrNkJ2bVJU?=
 =?utf-8?B?RUhmOWNLSDY4RWlLd0doVG4reWRhRWRURXRMSWYxRGhOWmlJTGt6M09ZWkkx?=
 =?utf-8?B?Z2RoekRFWWRkS1pPb0EwSklFZC9CdEd3R3ZjdzNBTGhuNTk5anNydHBDS0JP?=
 =?utf-8?B?bzUxb0Jxa3Q5WjkweFZOaW0xanZNeW9BZFJyWkc3RmRNSzAxNUY5T1BmaDBV?=
 =?utf-8?B?UlBjeGdwMEMxR1owMFc3MVhIQ3VlY25XRUd6MU1IcWE1NEg3aHh0Rnl1VnZC?=
 =?utf-8?B?bVBXV0UzWUkrM1kyczBSWnF5bDlmMTlLdjZ2dytnNEZYNGg1a2lSRjdjY0hD?=
 =?utf-8?B?Q1Nra1hDRW5NbEJsbFp4YWJ3UHhuTXRHMzF6WnpRQy8zV0FacnFiVWU5YkVj?=
 =?utf-8?B?N00wOFZkcW5oaUUwQmxlb0t1WENTb1l5ZlkyYk5UeXBKZ2llYUdMZXN0SUNZ?=
 =?utf-8?B?VGZPdEZGTmtkNHBsT0h4Z3I5M0JLMDF6Mzl3VFg0MUhMZkpuYTZPbTBlM2kv?=
 =?utf-8?B?am5DTzlYbk05VGpERG45enFkQmxubGtvcDgvL3p4VDg0V0lkaHJCMnU3aFlG?=
 =?utf-8?B?cHBSQkJmTFdHcXovUkJoN2F2NGJRL3VvcEd0alBDWkV2eVlLb3N0QT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4d6466-e6cd-4d14-564b-08df3edcbf7a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 03:43:13.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxgUu7ys3JmXRrwBcoSS9WBFBgEaxczcZauUKN+8bOWWAXBo6+Qds4e7EP+edg/WyyrWWLVK5O4ok6Uf/okNww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5632

Hi Yilun,

Thanks for the review. Please see my reply inline.

On 7/11/2026 8:50 pm, Xu Yilun wrote:
>> +static int altera_cvp_v2_read_credit(struct altera_cvp_conf *conf,
>> +				     u32 *credits)
>> +{
>> +	u8 val;
>> +	int ret;
>> +
>> +	ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
>> +	if (!ret)
>> +		*credits = val;
>> +
>> +	return ret;
>> +}
>> +
>> +static int altera_cvp_ag5_read_credit(struct altera_cvp_conf *conf,
>> +				      u32 *credits)
>> +{
>> +	return altera_read_config_dword(conf, VSE_CVP_AG5_TX_CREDITS, credits);
>> +}
>> +
>>   static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
>>   					 u32 blocks)
>>   {
>>   	u32 timeout = V2_CREDIT_TIMEOUT_US / V2_CHECK_CREDIT_US;
>>   	struct altera_cvp_conf *conf = mgr->priv;
>> +	u32 mask = conf->priv->credit_mask;
>>   	int ret;
>> -	u8 val;
>> +	u32 val;
>>   
>>   	do {
>> -		ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
>> +		ret = conf->priv->read_credit(conf, &val);
>>   		if (ret) {
>>   			dev_err(&conf->pci_dev->dev,
>>   				"Error reading CVP Credit Register\n");
>>   			return ret;
>>   		}
>>   
>> +		val &= mask;
> 
> How about including the masking inside .read_credit()?
> 

Good idea. I moved it into the per-variant callback. In this case, the 
callback will returns the number of credits left instead of the raw 
register value, so I plan to rename it to .avail_credit().

>> +
>>   		/* Return if there is space in FIFO */
>> -		if (val - (u8)conf->sent_packets)
>> +		if (val - (conf->sent_packets & mask))
> 
> Any reason to mask sent_packets here? The value would be bigger than the
> mask? If so, why is it safe to mask it?
> 
> I'm wondering if we could remove the mask in this function, then we
> don't need a .credit_mask in cvp_priv.
> 

Yes, sent_packets can be bigger than the mask. It is a free running u32
counting 4 KiB blocks, so it goes past 255 after 1 MiB (and past 4095
after 16 MiB), and images can be larger than 40 MiB. The hardware credit
counter wraps at its register width (8 bit, or 12 bit on Agilex5), so
the question is whether the two counters are equal modulo that width.
That is why the original code had the (u8) cast on sent_packets.

Reducing both sides to the counter width is safe for that comparison.
I agree the mask doesn't belong in the common path. In v3, the callbacks
compute (hw - sent_packets) & mask themselves and return the available
credits, so wait_for_credit() only checks whether it is non-zero and
.credit_mask is gone from cvp_priv. This gives the same result as the
old comparison.

>>   			return 0;
>>   
>>   		ret = altera_cvp_chk_error(mgr, blocks * ALTERA_CVP_V2_SIZE);
>> @@ -559,6 +587,18 @@ static const struct cvp_priv cvp_priv_v1 = {
>>   static const struct cvp_priv cvp_priv_v2 = {
>>   	.clear_state	= altera_cvp_v2_clear_state,
>>   	.wait_credit	= altera_cvp_v2_wait_for_credit,
>> +	.read_credit	= altera_cvp_v2_read_credit,
>> +	.credit_mask	= VSE_CVP_TX_CREDITS_MASK,
>> +	.block_size	= ALTERA_CVP_V2_SIZE,
>> +	.poll_time_us	= V2_POLL_TIMEOUT_US,
>> +	.user_time_us	= V2_USER_TIMEOUT_US,
>> +};
>> +
>> +static const struct cvp_priv cvp_priv_agilex5 = {
>> +	.clear_state	= altera_cvp_v2_clear_state,
>> +	.wait_credit	= altera_cvp_v2_wait_for_credit,
>> +	.read_credit	= altera_cvp_ag5_read_credit,
> 
> We have same .wait_credit across, so the only point of it is to indicate
> whether the credit can be read. The .read_credit can do the same job,
> is it?
> 
> I think we can remove .wait_credit
> 

Agreed. I will remove .wait_credit.

I will send v3 with these changes.

Thanks,
Tze Yee

>> +	.credit_mask	= VSE_CVP_AG5_TX_CREDITS_MASK,
>>   	.block_size	= ALTERA_CVP_V2_SIZE,
>>   	.poll_time_us	= V2_POLL_TIMEOUT_US,
>>   	.user_time_us	= V2_USER_TIMEOUT_US,
>> @@ -658,10 +698,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>>   	conf->pci_dev = pdev;
>>   	conf->write_data = altera_cvp_write_data_iomem;
>>   
>> -	if (conf->vsec_offset == V1_VSEC_OFFSET)
>> +	if (conf->vsec_offset == V1_VSEC_OFFSET) {
>>   		conf->priv = &cvp_priv_v1;
>> -	else
>> -		conf->priv = &cvp_priv_v2;
>> +	} else {
>> +		pci_read_config_dword(pdev, offset + PCI_VNDR_HEADER, &regval);
>> +		if (PCI_VNDR_HEADER_LEN(regval) == AGILEX5_VSEC_LENGTH)
>> +			conf->priv = &cvp_priv_agilex5;
>> +		else
>> +			conf->priv = &cvp_priv_v2;
>> +	}
>>   
>>   	conf->map = pci_iomap(pdev, CVP_BAR, 0);
>>   	if (!conf->map) {
>> -- 
>> 2.43.7
>>
>>

