Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79CA2836A0;
	Fri, 24 Jul 2026 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920996; cv=fail; b=fpOIiKjWDL2wf1xjwP3y+tBx3ZFyjq1VfBEgsu/zqt1tLL1i12K8J3a67n76yqaytL+/snXyfN1VgeChWmW70hL/7rdiou9RcVFAhmzbv09pwOpyZTCIovk7agW8iyfgK5dOOQgKwCV7Hh1oEzD0fIuDRjC3rReyIFJMsE7u3xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920996; c=relaxed/simple;
	bh=TNtdHFB5C/crEdszotF9+inLe4CayVZEViUsWVZNVnI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o3+MVPWYnmAmkfVmnYVACOMjosjpjbprnwCUVMh7hLttX6JHhZIH25XPtoBsMYwSnlSj48C3/ClEg44yUPvleEqYbopnlbb/C7FI/Z/a6zWbDc8HlqaQo/zWc5dTf96X8cMM+f0bNQCXMXzeTCHCxQonELbSs2ETuXDaQzcP/kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=EcGcNRMz; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="EcGcNRMz"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OGsN5Y2222015;
	Fri, 24 Jul 2026 12:22:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Xchp+PjkK
	cRY9njJ6hxTKWdZtaEy0r9LB7pzDPaQ4bk=; b=EcGcNRMz5Jm2lLyUn3T+vcoUL
	qOmcT34p8jnk8XIz74rF3X4duuFappKv4+hSU+bWa22lTj5Rd6ABzYmJulCSPQup
	HULng+xRdCGDLTpiR+Jp6bHEfvYOklPEapbKMehBr1Qbu+O7/0AsUH7j8LDWdF1G
	iTD/rOKgOyTwmXyd/zJC4CQO7R3mvg19Dl0/KfXWNgT8Ny1OlC8G0b2v+FK+bDEa
	JuxQ3Vab5iTE8v6/g9gFIZoQe2bqfkLweGRVyQ2cWaTE45zIcO0NZEPmZ4YiyXqQ
	HrMZPhqbOG4F4bsnxY9zMZtrR2060PIpaBaqiTkP6XDxifxXyfwib41tZxQpA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fm8ay0ngb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 12:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPLh8Sa7O02ihbIYSCt9flF3ejbyJfN3ZOPXUsJWUvciXY12V3gETVWJA31g6AtSd1OfngCnYYpGycjrpDC20TV3i5wmzC3ZzCu8a3pUqHdP4eA0IlrnDkpntF3rRBd7Vmff+tDq7x/4fam0joY+wNKwI1SHv9JnDe3pxO/2y4SAx99MApxkcdXPU2dIvIjIcZK9jTh80nc44KvuDo3C7YiOs6fEt5ApVbtHZcT1USIg0KiJuUaJOvZYD00MsLbhEBB/480Bdv3nszW2k8KCxrRRoMYAauiGWjLkrz0S5DzT5zjX34sRTyX/0QV8/nGDHvzedc8LDVe4oDeZ3xNDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xchp+PjkKcRY9njJ6hxTKWdZtaEy0r9LB7pzDPaQ4bk=;
 b=F0tIro0Tf/RtFcHnUezECV3qTqj24umoSbHC2nunwtkHckhk/Z0KhVIvbJqWxmW6xH8Xpyk833qPf5BLzrZ2g70Eu5YePrgAgj9QteCKjPggf1vVACW2y5mog2iBQ61NH0RI0rFO500DVR5gZyfNgREVAyhs8vTOZvz5Ih0U8ujcB5JBLtLxVIwm//PiXt3eQX54X622C3FqJtRYKxLNXn0ijNG6twjnNeUcx9VkIcB4p5DSkmpHn11IcHyJpXf8wMnZqPZ9WBu10aJoqwIdXBBmNuCtOHZApbeRyrcxtttIC0etFlMdv1j1uS4h/xT0VzngqOda8lwYdAiO5g+T8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 19:22:15 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 19:22:14 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-fpga@vger.kernel.org, mfd@lists.linux.dev,
        linux-kernel@vger.kernel.org, Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2] fpga: m10bmc-sec: add image_load sysfs for N3000 and D5005
Date: Fri, 24 Jul 2026 22:21:17 +0300
Message-ID: <20260724192117.60493-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0114.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:358::7) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SJ0PR11MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f248ba-439e-47fd-1cc4-08dee9b8ddff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|52116014|366016|1800799024|23010399003|6133799003|18002099003|3023799007|56012099006|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	0LWb/2d/BDWN96eHHtehsrHN73ZzXF1ZRe9HjaNK+/CxKvrcz92or7//TGNumfvp/mxPC6sxagJcgZFqKGxko4c2xF9TD7VN2qEe+/n6sVc3XbHlc3dmiMSRTB2OtqDLBrIDhWNf5cgoAjZwT2V/jeBLvcOgmKfMKeimAi6SJo/StgAPX8o1SbR6IZUzgEp5XncBtSe4/IpGgdLqYsM41t69Wkht0lZF2SJhc2pPLTz7+e8TwmycE1NVl/VFAMfCAmDFztEXS2PluW2SjzQJw5D5fv9aELLoa2k4EfkylMt71MKwmeRNSVTo3qhE5qDP4jAHHuI819/lalY3JsOn7Y5bnMhImT9fFexJGuND+CF1B/bTBjASIyqwSXekE9ZuNohDufMNZIhlA1kGB4TZUsud/dKsIfXqF+qSd2lXec6SQLeh67WYbYuALRLr2P2xVf9z4bNSlGkR3E5KVwduRZ4a4fInCOhwTaASgYJO9GB0TRGLMyfbpncDMYF+Geo9lhOVhq5pTv88hOH9mu8IEe/a5LmnOCt2J56cmrJ2ey3MMlHnjoKHUbGbKfvW7AXHZRbtmO2AZu+RCOgCk4DOjGXmsHnbyCxz8vhh2WAjc20=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(52116014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(3023799007)(56012099006)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmdJUkVsTy90MWRvTEN3bjVJYnl1TitqaEUraFBZWkJvWml4YTYrZTRjdU5R?=
 =?utf-8?B?cTRQMWltcW5IUm45bytOTjhEZk93QlB0NWJvVDlBTUwxQmxyT1k4ZDA3Umwz?=
 =?utf-8?B?VkhwbG83L2h3VksrZDdxTzNubjBVZEExSjdBd2lFSDA4TDhJaDFna0RvRlhC?=
 =?utf-8?B?RzNtNno1bVRrYjZQZXVjRGFjNUU0RlJWSVRtc1hUemVhOFJtVHc0MUtvaDgz?=
 =?utf-8?B?SDFTZGU2R3ZRR215T01jc1BBNEhsNThQbTlCelg1bjk3bHhqdmswZlVOSUtK?=
 =?utf-8?B?R2hlWTFjNEVIVWdwNWlnZzhMa0JReU1lWDdGaXJ6UERnbXpxUVcxTFBOZVB3?=
 =?utf-8?B?Unl2SWhJQUZkMms0WmtGQjc3LzFtSS9UbmNURVk2MVpCeXM4RHR2MFRRcDNN?=
 =?utf-8?B?NWFSU0RkQUd6TC92QVBybjNxVzNER3pBRkZnNHJRRkRsc3JHRytYOHU3RDIz?=
 =?utf-8?B?Yy9pN295ZmtaWmxIRXlnM0w4eU5LaEVZZUNGL1R5NnIwaEMzblc2TTRJR2NT?=
 =?utf-8?B?U2pZdzlqQjdBdC9XSStPaG9DZUI4VTgxWWxRTnBSTU9IQnE3dThBMGZPbkVW?=
 =?utf-8?B?UThwM0E5UmdTYVdIeFY3bk1WemxBVFZYb0NJcUpjUTdpcTI3TVNpdVl5ZVN0?=
 =?utf-8?B?aEVFUVBraENFT1dMMXpyMmxSMDBIQW5kTGtPaUovOXh3OFIwNlRrZkQ0MXd6?=
 =?utf-8?B?U0VvekxscFcrQ09hTE1ldUFQbEFZd0cwVUFXRE1BL3F4K20zSGp5ZS95ajMw?=
 =?utf-8?B?WlA4ODg0cTlaSUVEeHh0WU1SSDVFT2FSbGZMZ1pPTkRzaUdiVEsvUWRoMUx6?=
 =?utf-8?B?dUpLa040cDJFa0RPTVA2MWdjdFNIbnlISWtmK3pPclpwdW1McWdLLy9NTWYx?=
 =?utf-8?B?dzkxUHdvNFN3REtMV0srRm1sZFNub0xmRjhMdDVGTW1iTEtKZmkvQk9Db29u?=
 =?utf-8?B?N0NFa0ZzODZVM1Yzbm9aUHZudDF5WnlqUjd0NkpHL1Jsd0h3NEQ3MlFDTEg4?=
 =?utf-8?B?T250dmFJZGJWdzh4dGxQNGVxNWFlL1YvUDVSeGV5bmtKY0Q2NGdhNU1NMTdK?=
 =?utf-8?B?MHArM2RvWk9adnpMd3F0ekcyWkhuTWhzaU5BeVlUa0JMeExDYVRpdDNCRlA3?=
 =?utf-8?B?WUlZb0htL0N1azFYUDIyZnU1VDJMR2pXWGI4WUdHN0NXZkx2akdQeFRxVEho?=
 =?utf-8?B?ZThVbGc0L2hxenRNUGZtZVlZOHBVMHduc1RmSFJnUFZwRVNHWFpYRmpMdk4r?=
 =?utf-8?B?MXZ6dUN3VnlRcS80eld6RWphaXluRGZTYlNvV09sckd6RE1vazFmak5ETHQx?=
 =?utf-8?B?SzJhYTBqZ0w0aGhEc244M09lRXZQTjk4Y1hjcGhTN2swdXE2NXB3cWdSQ0RG?=
 =?utf-8?B?alpQbnJONFhVRFVHeVEyQlRwaXVERVRVNTMzUFYwdmt6YzBSR1dMOHM4V3A0?=
 =?utf-8?B?Z2l4dTlITXFVWEE1SWovR0RGZ3MwSERERGZJRHpmSjM1RXhnaE5aVC8zTHRh?=
 =?utf-8?B?MXFKODkyd3EvTjVWY1FiY0xXZElzVDVBbkRtb092OFZxbEZ6ZUwrMnBDNkQ4?=
 =?utf-8?B?QUhRUDcvaTdoYldPS1NHMzJqNDFzNWEyWW9oZ0s5SW1VMnJ6cjc3aXZDcEdC?=
 =?utf-8?B?UUpTeFk0WEdTWm1FelFKem16b2JOQ1JvMXJEZ08rL3pOdmlSWmNBamlIcEVX?=
 =?utf-8?B?MHRCZ0twVWJsc1MzaGZuMGJUcFNTTk9JV2tnb3FEZGV0WjdjbzhLTWt0RUR0?=
 =?utf-8?B?dEsrMFZRc0Y0WWE0aU84RWFWS0FoMWJtenhoeFo1OXFNbTdiS21jU2taOWR1?=
 =?utf-8?B?WUVpNGRVNVZOMExFdWp0eDNoM3FWYUZPbzBjQ1dIOCttOFZuWE5vbDUxTHBY?=
 =?utf-8?B?RlpHZ292REpQS0lRaWw3c1JlUURzOUhoRDRRbS96czExOFRzWmx5cVJBaTli?=
 =?utf-8?B?bGVWeDBTVW9ZT0w4dXk4Y2ducEtHRlFYRFBRQzN1eDJUbm5DWGhWT0RRSVht?=
 =?utf-8?B?OEdWY2tKL3NiZVNibFJldk02Wk5OLzVndmpCYWpub0VTejRqM0FXaXB6c0dy?=
 =?utf-8?B?b2owVW40U1ZMOXRGQVUxUWFRMWpDcE9hSjNwajI5dFlObkNLZlBNOUdlVXY4?=
 =?utf-8?B?QW5lM3R0Ujh6eTVtMnJyaEM5QmdRZWtwcCtnVlMzWEVtY1owZ3l5VkZtSFc5?=
 =?utf-8?B?VHAxNGg3V1VvbzdWaE9va0Z3TEh6ZTQ0OEhjZWdXbm9LUVJKUjMrNFdFdGw1?=
 =?utf-8?B?N0UvMVdDMCt2RklnVUU5aGJJK082V3pIeWloSmlMT0xwbmVxSVk3SGhweHRO?=
 =?utf-8?B?Ni9wNmNUTW0yWFdmSDh6aXpCTW9nTU9xWldncHcxTVFPSWdQdDZEYjlXOTh2?=
 =?utf-8?Q?KSuOpe988ZoIUNedn7Jo4IllYPF0QmETFCnUZrp5OpLE+?=
X-MS-Exchange-AntiSpam-MessageData-1: v+L5FsaQOFMUpf4ZlEiOoqiFXTmPL9jOWJY=
X-Exchange-RoutingPolicyChecked:
	UPuxJ4RWaBTcdxZeNuk1YxyBg8Q9cid4YSP/709bph15JVJuxtD2tEvH34v870YCRxoZ7pyUOpEiS8cAXgX+omm+iq1ZNg/YVVyoC3SclwFJjn3c/WwO+7QfkrP4Kr1PYymDGq/gVqEUpqaZxgBQ8HDp/guoCGUdFVKnMS9f9/8liNDJZtTPq+MembCLPgaaFq5QOD38ebjIjISRfGq5FsUUcg6Cz4FzuROSH69jUhFqGLlVXbL1y06WF9wnYZgIkr38hRUtbRh91T1285O2siMKa1iLZnAGaiOIbScOvpuo5WBLRJZYh9bWXjUx6/DS7RuewXxvSTemjj0xUEc7Gw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f248ba-439e-47fd-1cc4-08dee9b8ddff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:22:14.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCkeh7Rwk6ZqijSJRtuo2OZLIdJhclilw/ag9G5tgSy+QxJWBSmVf36n8Pwjvce/85rQ5TPcoFUU75EdN5DIerDMpFgo7fu4fy0BWJSCxLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
X-Proofpoint-ORIG-GUID: gP42aZhyejlgQDbbcDuLkjg5d2tAfihr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE3NCBTYWx0ZWRfX7N67HSmzfOCq
 WrBBzdZR6ED7zLpSPjuyq11JUx2DFk+Ygo2dIU9s2G1wrmcv68YII94Or/VPw76erxxKwvflF1z
 ZYp1dVTQdo9+j8Y8gWp1l02G/d8DLxBQZ6oca7u0gYA2Ot5sEt4x47g1NLWLMLUm03lZOMi8tgJ
 nf/aL9H6qo+lWl66i917MbBOMsdY7Cdk4cgjIYMY4QuwfNU6OZhnmYgpljTSyFru48P+HlVudqs
 rG95YIZPvr0oLAhdpDo/fvQelauoWfGRIty0vRt/gsFYDQn+inp7TcJyUW5pwTAh7vrCtTQRYwt
 Je8ZsQlBUqvuJziFEn/6ltyGjzA+MgpH1q9bMl1da4RpCxzcPw13R68af17MK7kEfbyF/tikAAI
 4RlfRxP1lF4rX0jtINXnJit05Aw2ziqwMYhb0SEJevzTSZewbJtwUIZ4XFPQNgSWLIT+O+m9Iqn
 PRP+29F1ZK3LOvjpH5Q==
X-Authority-Analysis: v=2.4 cv=LOFWhpW9 c=1 sm=1 tr=0 ts=6a63bb6a cx=c_pps
 a=MDD208LlbW4bdEb8q+7A1g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=yBYpec10AAAA:8
 a=9Oi_qOogKHwwW6j0JCUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22 a=zbxmTX4fiVD2UiCe4Dha:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE3NCBTYWx0ZWRfX+bUe6Xu/KVQQ
 7YjMChL6A5FuZmAAk0C4+fnxicYi4uhhYO7wgAGE/hSOoq/SzgHbxnOLSxl3UpWyCBl2xMqWxr1
 Vs9q9wXYmjRNGu3TaVa4prlfDVsdKC0N1PpNNFx6WYZkpH+Lh0KE
X-Proofpoint-GUID: gP42aZhyejlgQDbbcDuLkjg5d2tAfihr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240174

The Intel MAX10 BMC secure-update driver in mainline exposes only the
firmware-upload ABI (/sys/class/firmware/secure-updateN) for staging and
flashing a new image. It has no way to trigger a reload of an image that
is already present in FLASH or EEPROM, which OPAE userspace relies on to
switch between the BMC factory/user images or to reload the PKVL retimer
firmware without a full firmware-upload cycle.

Add the control/available_images and control/image_load sysfs attributes
for the N3000 and D5005 cards. available_images returns the space
separated list of image key words accepted by the device, and writing
one of those key words to image_load triggers the corresponding reload:

 - bmc_factory / bmc_user reload a BMC image by writing DRBL_CONFIG_SEL
   and DRBL_REBOOT_REQ to the doorbell register. The config-select
   polarity is inverted between N3000 and D5005, so the two cards use
   separate handler tables and a separate m10sec_d5005_ops.

 - retimer_fw (N3000 only) reloads the PKVL retimer EEPROM by asserting
   DRBL_PKVL_EEPROM_LOAD_SEC, waiting for RSU_PROG_PKVL_PROM_DONE (or a
   RSU_STAT_PKVL_REJECT for a duplicate image), then polling
   M10BMC_N3000_PKVL_POLL_CTRL for preload completion.

A reload and a secure update drive the same doorbell register, and the
doorbell is not part of the fw handshake register ranges, so it stays
accessible in every BMC firmware state - including
M10BMC_FW_STATE_SEC_UPDATE_PROGRAM, while the flash is being written.
Writing image_load at that point would reboot the BMC mid-write. Add a
mutex to struct m10bmc_sec, held from m10bmc_sec_prepare() through
m10bmc_sec_cleanup() for the duration of an upload, and taken with
mutex_trylock() by image_load_store() so that a reload attempt during an
update returns -EBUSY rather than blocking for minutes.
m10bmc_sec_cancel() deliberately does not take the lock; it runs
asynchronously against the upload that holds it and only sets a flag.

The doorbell RSU progress field is checked before either reload path
runs, which also rejects a reload when the BMC reports an operation this
driver did not start.

The control group is hidden via its is_visible() callback whenever the
device ops do not provide an image_load table, so N6000 (which keeps
.image_load = NULL) is unaffected.

The M10BMC_N3000_PKVL_* register and bit definitions are added to
intel-m10-bmc.h for the retimer path.

Reloading a BMC image reboots the BMC, and on N3000 that also resets the
FPGA and drops the PCIe link, so the card leaves the bus and userspace
owns re-enumeration. Nothing is quiesced on the kernel side first. This
is documented in the ABI file rather than handled, and is the main open
question for this interface.

This is a subset of the functionality carried in linux-dfl, ported to
the mainline driver structure. It is derived from the linux-dfl
commit 604ad4f48cee ("fpga: m10bmc-sec: add sysfs to load bmc images")
and commit e1b885714f68 ("fpga: m10bmc-sec: m10bmc_sec_retimer_load
callback") by Russ Weight, Tianfei Zhang, Xu Yilun and Ilpo Järvinen.
The N6000 PMCI and SDM image-load handlers are intentionally left out;
they depend on the wider PMCI stack that has not been upstreamed.

Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Tianfei Zhang <tianfei.zhang@intel.com>
Cc: Xu Yilun <yilun.xu@intel.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Assisted-by: Claude:claude-opus-4-8 checkpatch
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---

Changes since v1 [1]:
- Serialize an image reload against the firmware-upload path. The doorbell
  is not covered by the fw handshake register ranges, so it stayed writable
  in every BMC firmware state, including M10BMC_FW_STATE_SEC_UPDATE_PROGRAM
  while the flash is being written, and a reload issued at that point would
  have rebooted the BMC mid-write. Add a mutex to struct m10bmc_sec, held
  from m10bmc_sec_prepare() to m10bmc_sec_cleanup(), and take it with
  mutex_trylock() in image_load_store() so that a reload during an update
  returns -EBUSY instead of blocking for minutes. m10bmc_sec_cancel()
  deliberately does not take it, it runs against the upload that holds it.
- Check the RSU progress field on the BMC reload path as well. v1 tested
  only DRBL_REBOOT_DISABLED there, while the retimer path already checked
  rsu_prog(). retimer_check_idle() is renamed to image_load_check_idle(),
  is now used by both paths, and propagates the real errno instead of a
  fixed -EIO.
- Prefix the new register and bit definitions M10BMC_N3000_PKVL_* to match
  the neighbouring macros in intel-m10-bmc.h. The unprefixed names were
  inherited from linux-dfl, whose header predates that scheme.
- Use sysfs_emit_at() instead of scnprintf() in available_images_show().
- Make the image_load handler tables and the m10bmc_sec_ops member const.
- ABI documentation: KernelVersion 6.18 -> 7.3.
- Rebased on linux-next (next-20260723).

[1] Link to v1: https://lore.kernel.org/lkml/20260715073854.26117-1-ionut.nechita@windriver.com/

On the interface question raised on v1 [2]:

I agree that a reprogramming interface defined per device is not where this
should end up, and I am willing to do the generic work. What I would like to
avoid in the meantime is having no way at all to reload an image. Mainline
today can only push a new image through the fw_upload ABI; switching between
the factory and user BMC images, or reloading the retimer EEPROM, is not
expressible, even though the hardware supports it and OPAE userspace has been
driving exactly these operations through the linux-dfl ABI for years. This
patch is that same ABI, unchanged in shape, restricted to the two cards whose
handlers do not depend on the PMCI stack that is not upstream.

On the impact question: a bmc_factory or bmc_user reload reboots the BMC, and
on N3000 that reboot also resets the FPGA and drops the PCIe link, so the card
leaves the bus and re-enumeration is left to userspace. Nothing is quiesced on
the kernel side first. That is documented in the ABI file rather than handled,
because I do not think it can be handled meaningfully inside a single driver:
the blast radius reaches the other functions of the card, and where it has to
be dealt with is the bus layer, not here. Concretely, on a 6.18.y kernel the
i40e VFs behind our N3000 did not come back after a reload, failing with
-ENOMEM out of the PCI resource assignment on the rescan path. That turned out
to be a resource-assignment problem already fixed in mainline by:

  7e90360e6d45 ("PCI: Fix bridge window alignment with optional resources")
  2ecc1bf14e2f ("PCI: Don't claim disabled bridge windows")
  4bee4fc0f4ee ("PCI: Use res_to_dev_res() in reassign_resources_sorted()")
  1ee4716a5a28 ("PCI: Fix premature removal from realloc_head list during
                 resource assignment")
  8cb081667377 ("PCI: Fix alignment calculation for resource size larger
                 than align")

With those five in place, a bmc_user or bmc_factory reload driven through this
interface completes end to end on our N3000: the BMC reboots, the card
re-enumerates, the VFs are reallocated, and the host stays up. So the
disruption is real, but it is recoverable at the bus layer once the platform
side is correct. That is one more reason to describe it in a common interface
instead of trying to contain it in each driver.

The D5005 handlers are not tested on hardware here, I have no D5005 to test on.
They differ from the N3000 ones only in the DRBL_CONFIG_SEL polarity, which is
taken as-is from linux-dfl.

For the generic side I would propose, and can post as an RFC if you agree with
the direction, an fpga_image_slot class: one device per reloadable slot, with
the slot name and a "disruption" attribute reading none, device_reset or
bus_reprobe, so that userspace knows what it is about to trigger before it
triggers it, while drivers keep only their load callback. One detail worth
flagging early: a reload triggered from a sysfs store handler runs with the
kernfs active reference held, so any slot whose reset removes the device needs
sysfs_break_active_protection() or device_remove_file_self(), or the store
deadlocks against its own removal.

If you would rather see that RFC first and drop this patch entirely, tell me
and I will drop it. I would like these handlers to be the first user of
whatever we agree on, since the N3000 is the only such card I can test on.

[2] https://lore.kernel.org/linux-fpga/amGYhCKpesGH%2FyLB@yilunxu-OptiPlex-7050/

 .../sysfs-driver-intel-m10-bmc-sec-update     |  34 ++
 drivers/fpga/intel-m10-bmc-sec-update.c       | 346 +++++++++++++++++-
 include/linux/mfd/intel-m10-bmc.h             |  35 ++
 3 files changed, 412 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
index 3a6ca780c75c..e34aa739ecdf 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
@@ -59,3 +59,37 @@ Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
 Description:	Read only. Returns number of times the secure update
 		staging area has been flashed.
 		Format: "%u".
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../control/available_images
+Date:		Jul 2026
+KernelVersion:	7.3
+Contact:	Ionut Nechita <ionut.nechita@windriver.com>
+Description:	Read only. Returns a space separated list of key words
+		that may be written into the image_load file described
+		below. These key words describe a BMC or retimer firmware
+		image in FLASH or EEPROM storage that may be reloaded.
+		This file is only visible if the underlying device
+		supports image reload.
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../control/image_load
+Date:		Jul 2026
+KernelVersion:	7.3
+Contact:	Ionut Nechita <ionut.nechita@windriver.com>
+Description:	Write only. A key word may be written to this file to
+		trigger a reload of a BMC or retimer firmware image from
+		FLASH or EEPROM. Refer to the available_images file for
+		the list of key words supported by the underlying device.
+		Writing an unsupported string to this file results in
+		-EINVAL being returned. This file is only visible if the
+		underlying device supports image reload.
+
+		Returns -EBUSY if a secure update is in progress through
+		the firmware upload interface, or if the device reports
+		another operation already running.
+
+		Reloading a bmc_factory or bmc_user image reboots the BMC.
+		On cards where the BMC reboot also resets the FPGA and the
+		PCIe link, the device drops off the bus, and re-enumeration
+		is left to userspace. Nothing is quiesced on the kernel
+		side beforehand, so consumers of the other functions of the
+		card observe I/O failures until the device is restored.
diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 7d23d914df3f..06c9f9130c58 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -10,13 +10,20 @@
 #include <linux/firmware.h>
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
 struct m10bmc_sec;
 
+struct image_load {
+	const char *name;
+	int (*load_image)(struct m10bmc_sec *sec);
+};
+
 struct m10bmc_sec_ops {
 	int (*rsu_status)(struct m10bmc_sec *sec);
+	const struct image_load *image_load;	/* terminated with { } member */
 };
 
 struct m10bmc_sec {
@@ -27,6 +34,16 @@ struct m10bmc_sec {
 	u32 fw_name_id;
 	bool cancel_request;
 	const struct m10bmc_sec_ops *ops;
+	/*
+	 * Serializes a secure update against an image reload triggered
+	 * through the control/image_load attribute. Both drive the same
+	 * doorbell register, and a reload issued while an update is
+	 * programming the flash would reboot the BMC mid-write. Held from
+	 * m10bmc_sec_prepare() to m10bmc_sec_cleanup() for the duration of
+	 * an upload. m10bmc_sec_cancel() must not take it, see the comment
+	 * there.
+	 */
+	struct mutex lock;
 };
 
 static DEFINE_XARRAY_ALLOC(fw_upload_xa);
@@ -253,8 +270,295 @@ static struct attribute_group m10bmc_security_attr_group = {
 	.attrs = m10bmc_security_attrs,
 };
 
+/* Image reload control (N3000 / D5005) */
+
+/*
+ * The RSU state machine and the image reload paths share the doorbell
+ * register, and the doorbell is not covered by the fw handshake ranges, so
+ * it stays readable in every BMC firmware state. sec->lock keeps a reload
+ * from racing an in-flight secure update driven by this driver; this check
+ * additionally rejects a reload when the BMC reports an operation that this
+ * driver did not start (a previous driver instance, or OPAE talking to the
+ * card out of band).
+ */
+static int image_load_check_idle(struct m10bmc_sec *sec)
+{
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, &doorbell);
+	if (ret)
+		return ret;
+
+	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
+	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE &&
+	    rsu_prog(doorbell) != RSU_PROG_PKVL_PROM_DONE) {
+		dev_err(sec->dev, "Doorbell not idle: 0x%08x\n", doorbell);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int m10bmc_sec_bmc_image_load(struct m10bmc_sec *sec, unsigned int val)
+{
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
+	u32 doorbell;
+	int ret;
+
+	ret = image_load_check_idle(sec);
+	if (ret)
+		return ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, &doorbell);
+	if (ret)
+		return ret;
+
+	if (doorbell & DRBL_REBOOT_DISABLED)
+		return -EBUSY;
+
+	return m10bmc_sys_update_bits(sec->m10bmc, csr_map->doorbell,
+				      DRBL_CONFIG_SEL | DRBL_REBOOT_REQ,
+				      FIELD_PREP(DRBL_CONFIG_SEL, val) |
+				      DRBL_REBOOT_REQ);
+}
+
+static int m10bmc_sec_bmc_image_load_0(struct m10bmc_sec *sec)
+{
+	return m10bmc_sec_bmc_image_load(sec, 0);
+}
+
+static int m10bmc_sec_bmc_image_load_1(struct m10bmc_sec *sec)
+{
+	return m10bmc_sec_bmc_image_load(sec, 1);
+}
+
+static int trigger_retimer_eeprom_load(struct m10bmc_sec *sec)
+{
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
+	struct intel_m10bmc *m10bmc = sec->m10bmc;
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_update_bits(m10bmc, csr_map->doorbell,
+				     DRBL_PKVL_EEPROM_LOAD_SEC,
+				     DRBL_PKVL_EEPROM_LOAD_SEC);
+	if (ret)
+		return ret;
+
+	/*
+	 * If the current NIOS FW is not bootloader, then the retimer load
+	 * is expected to trigger a NIOS reboot, so the DRBL_PKVL_EEPROM_LOAD
+	 * bit is cleared by the reboot. Otherwise wait for it to be cleared
+	 * by the NIOS FW.
+	 */
+	ret = regmap_read_poll_timeout(m10bmc->regmap,
+				       csr_map->base + csr_map->doorbell,
+				       val,
+				       (!(val & DRBL_PKVL_EEPROM_LOAD_SEC)),
+				       M10BMC_N3000_PKVL_LOAD_INTERVAL_US,
+				       M10BMC_N3000_PKVL_LOAD_TIMEOUT_US);
+	if (ret == -ETIMEDOUT) {
+		dev_err(sec->dev, "PKVL_EEPROM_LOAD clear timedout\n");
+		m10bmc_sys_update_bits(m10bmc, csr_map->doorbell,
+				       DRBL_PKVL_EEPROM_LOAD_SEC, 0);
+		ret = -ENODEV;
+	} else if (ret) {
+		dev_err(sec->dev, "poll EEPROM_LOAD error %d\n", ret);
+	}
+
+	return ret;
+}
+
+static int poll_retimer_eeprom_load_done(struct m10bmc_sec *sec)
+{
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
+	struct intel_m10bmc *m10bmc = sec->m10bmc;
+	unsigned int doorbell_reg;
+	int ret;
+
+	/*
+	 * RSU_STAT_PKVL_REJECT indicates that the current image is
+	 * already programmed. RSU_PROG_PKVL_PROM_DONE that the firmware
+	 * update process has finished, but does not necessarily indicate
+	 * a successful update.
+	 */
+	ret = regmap_read_poll_timeout(m10bmc->regmap,
+				       csr_map->base + csr_map->doorbell,
+				       doorbell_reg,
+				       (rsu_prog(doorbell_reg) ==
+					RSU_PROG_PKVL_PROM_DONE ||
+					FIELD_GET(DRBL_RSU_STATUS, doorbell_reg) ==
+					RSU_STAT_PKVL_REJECT),
+				       M10BMC_N3000_PKVL_PRELOAD_INTERVAL_US,
+				       M10BMC_N3000_PKVL_PRELOAD_TIMEOUT_US);
+	if (ret == -ETIMEDOUT) {
+		dev_err(sec->dev, "Doorbell check timedout: 0x%08x\n",
+			doorbell_reg);
+		return ret;
+	} else if (ret) {
+		dev_err(sec->dev, "poll Doorbell error %d\n", ret);
+		return ret;
+	}
+
+	if (FIELD_GET(DRBL_RSU_STATUS, doorbell_reg) == RSU_STAT_PKVL_REJECT) {
+		dev_err(sec->dev, "duplicate image rejected\n");
+		return -ECANCELED;
+	}
+
+	return 0;
+}
+
+static int poll_retimer_preload_done(struct m10bmc_sec *sec)
+{
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
+	struct intel_m10bmc *m10bmc = sec->m10bmc;
+	unsigned int val;
+	int ret;
+
+	/*
+	 * Wait for the updated firmware to be loaded by the PKVL device
+	 * and confirm that the applied version matches the expected value.
+	 */
+	ret = regmap_read_poll_timeout(m10bmc->regmap,
+				       csr_map->base + M10BMC_N3000_PKVL_POLL_CTRL,
+				       val,
+				       ((val & M10BMC_N3000_PKVL_PRELOAD) ==
+					M10BMC_N3000_PKVL_PRELOAD),
+				       M10BMC_N3000_PKVL_PRELOAD_INTERVAL_US,
+				       M10BMC_N3000_PKVL_PRELOAD_TIMEOUT_US);
+	if (ret) {
+		dev_err(sec->dev, "poll M10BMC_N3000_PKVL_PRELOAD error %d\n", ret);
+		return ret;
+	}
+
+	if ((val & M10BMC_N3000_PKVL_UPG_STATUS_MASK) != M10BMC_N3000_PKVL_UPG_STATUS_GOOD) {
+		dev_err(sec->dev, "error during M10BMC PKVL upgrade\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int m10bmc_sec_retimer_eeprom_load(struct m10bmc_sec *sec)
+{
+	int ret;
+
+	ret = image_load_check_idle(sec);
+	if (ret)
+		return ret;
+
+	ret = trigger_retimer_eeprom_load(sec);
+	if (ret)
+		return ret;
+
+	ret = poll_retimer_eeprom_load_done(sec);
+	if (ret)
+		return ret;
+
+	return poll_retimer_preload_done(sec);
+}
+
+static const struct image_load n3000_image_load_hndlrs[] = {
+	{
+		.name = "bmc_factory",
+		.load_image = m10bmc_sec_bmc_image_load_1,
+	},
+	{
+		.name = "bmc_user",
+		.load_image = m10bmc_sec_bmc_image_load_0,
+	},
+	{
+		.name = "retimer_fw",
+		.load_image = m10bmc_sec_retimer_eeprom_load,
+	},
+	{}
+};
+
+static const struct image_load d5005_image_load_hndlrs[] = {
+	{
+		.name = "bmc_factory",
+		.load_image = m10bmc_sec_bmc_image_load_0,
+	},
+	{
+		.name = "bmc_user",
+		.load_image = m10bmc_sec_bmc_image_load_1,
+	},
+	{}
+};
+
+static ssize_t available_images_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	const struct image_load *hndlr;
+	ssize_t count = 0;
+
+	for (hndlr = sec->ops->image_load; hndlr->name; hndlr++)
+		count += sysfs_emit_at(buf, count, "%s%s", count ? " " : "",
+				       hndlr->name);
+
+	count += sysfs_emit_at(buf, count, "\n");
+
+	return count;
+}
+static DEVICE_ATTR_RO(available_images);
+
+static ssize_t image_load_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	const struct image_load *hndlr;
+	int ret = -EINVAL;
+
+	/*
+	 * Do not wait for an in-flight secure update to finish; it can take
+	 * minutes. Tell userspace to come back later instead.
+	 */
+	if (!mutex_trylock(&sec->lock))
+		return -EBUSY;
+
+	for (hndlr = sec->ops->image_load; hndlr->name; hndlr++) {
+		if (sysfs_streq(buf, hndlr->name)) {
+			ret = hndlr->load_image(sec);
+			break;
+		}
+	}
+
+	mutex_unlock(&sec->lock);
+
+	return ret ? : count;
+}
+static DEVICE_ATTR_WO(image_load);
+
+static umode_t
+m10bmc_control_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(kobj_to_dev(kobj));
+
+	if (!sec->ops->image_load)
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *m10bmc_control_attrs[] = {
+	&dev_attr_available_images.attr,
+	&dev_attr_image_load.attr,
+	NULL,
+};
+
+static struct attribute_group m10bmc_control_attr_group = {
+	.name = "control",
+	.attrs = m10bmc_control_attrs,
+	.is_visible = m10bmc_control_visible,
+};
+
 static const struct attribute_group *m10bmc_sec_attr_groups[] = {
 	&m10bmc_security_attr_group,
+	&m10bmc_control_attr_group,
 	NULL,
 };
 
@@ -524,8 +828,8 @@ static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
 	return FW_UPLOAD_ERR_CANCELED;
 }
 
-static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
-					     const u8 *data, u32 size)
+static enum fw_upload_err m10bmc_sec_do_prepare(struct fw_upload *fwl,
+						const u8 *data, u32 size)
 {
 	struct m10bmc_sec *sec = fwl->dd_handle;
 	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
@@ -572,6 +876,27 @@ static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
 	return ret;
 }
 
+/*
+ * The fw_upload core runs prepare(), write(), poll_complete() and cleanup()
+ * sequentially from a single work item, and only calls cleanup() once
+ * prepare() has succeeded. So take sec->lock here and drop it again on the
+ * failure path; on success it stays held until m10bmc_sec_cleanup().
+ */
+static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
+					     const u8 *data, u32 size)
+{
+	struct m10bmc_sec *sec = fwl->dd_handle;
+	enum fw_upload_err ret;
+
+	mutex_lock(&sec->lock);
+
+	ret = m10bmc_sec_do_prepare(fwl, data, size);
+	if (ret != FW_UPLOAD_ERR_NONE)
+		mutex_unlock(&sec->lock);
+
+	return ret;
+}
+
 #define WRITE_BLOCK_SIZE 0x4000	/* Default write-block size is 0x4000 bytes */
 
 static enum fw_upload_err m10bmc_sec_fw_write(struct fw_upload *fwl, const u8 *data,
@@ -645,6 +970,9 @@ static enum fw_upload_err m10bmc_sec_poll_complete(struct fw_upload *fwl)
  * contention on register accesses, m10bmc_sec_cancel() must only update
  * the cancel_request flag. Other functions will check this flag and handle
  * the cancel request synchronously.
+ *
+ * For the same reason it must not take sec->lock: that lock is held by the
+ * upload it is being asked to cancel.
  */
 static void m10bmc_sec_cancel(struct fw_upload *fwl)
 {
@@ -663,6 +991,8 @@ static void m10bmc_sec_cleanup(struct fw_upload *fwl)
 
 	if (sec->m10bmc->flash_bulk_ops)
 		sec->m10bmc->flash_bulk_ops->unlock_write(sec->m10bmc);
+
+	mutex_unlock(&sec->lock);
 }
 
 static const struct fw_upload_ops m10bmc_ops = {
@@ -675,6 +1005,12 @@ static const struct fw_upload_ops m10bmc_ops = {
 
 static const struct m10bmc_sec_ops m10sec_n3000_ops = {
 	.rsu_status = m10bmc_sec_n3000_rsu_status,
+	.image_load = n3000_image_load_hndlrs,
+};
+
+static const struct m10bmc_sec_ops m10sec_d5005_ops = {
+	.rsu_status = m10bmc_sec_n3000_rsu_status,
+	.image_load = d5005_image_load_hndlrs,
 };
 
 static const struct m10bmc_sec_ops m10sec_n6000_ops = {
@@ -699,6 +1035,10 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
 	sec->ops = (struct m10bmc_sec_ops *)platform_get_device_id(pdev)->driver_data;
 	dev_set_drvdata(&pdev->dev, sec);
 
+	ret = devm_mutex_init(&pdev->dev, &sec->lock);
+	if (ret)
+		return ret;
+
 	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
 		       xa_limit_32b, GFP_KERNEL);
 	if (ret)
@@ -746,7 +1086,7 @@ static const struct platform_device_id intel_m10bmc_sec_ids[] = {
 	},
 	{
 		.name = "d5005bmc-sec-update",
-		.driver_data = (kernel_ulong_t)&m10sec_n3000_ops,
+		.driver_data = (kernel_ulong_t)&m10sec_d5005_ops,
 	},
 	{
 		.name = "n6000bmc-sec-update",
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 988f1cd90032..56ca0aba673b 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -40,6 +40,41 @@
 #define M10BMC_N3000_VER_PCB_INFO_MSK	GENMASK(31, 24)
 #define M10BMC_N3000_VER_LEGACY_INVALID	0xffffffff
 
+/* PKVL (retimer) preload poll control register, in system register region */
+#define M10BMC_N3000_PKVL_POLL_CTRL		0x80
+#define M10BMC_N3000_PKVL_A_PRELOAD		BIT(16)
+#define M10BMC_N3000_PKVL_A_PRELOAD_TO	BIT(17)
+#define M10BMC_N3000_PKVL_A_DATA_TOO_BIG	BIT(18)
+#define M10BMC_N3000_PKVL_A_HDR_CKSUM		BIT(20)
+#define M10BMC_N3000_PKVL_B_PRELOAD		BIT(24)
+#define M10BMC_N3000_PKVL_B_PRELOAD_TO	BIT(25)
+#define M10BMC_N3000_PKVL_B_DATA_TOO_BIG	BIT(26)
+#define M10BMC_N3000_PKVL_B_HDR_CKSUM		BIT(28)
+
+#define M10BMC_N3000_PKVL_PRELOAD	(M10BMC_N3000_PKVL_A_PRELOAD | \
+					 M10BMC_N3000_PKVL_B_PRELOAD)
+#define M10BMC_N3000_PKVL_PRELOAD_TIMEOUT	(M10BMC_N3000_PKVL_A_PRELOAD_TO | \
+					 M10BMC_N3000_PKVL_B_PRELOAD_TO)
+#define M10BMC_N3000_PKVL_DATA_TOO_BIG	(M10BMC_N3000_PKVL_A_DATA_TOO_BIG | \
+					 M10BMC_N3000_PKVL_B_DATA_TOO_BIG)
+#define M10BMC_N3000_PKVL_HDR_CHECKSUM	(M10BMC_N3000_PKVL_A_HDR_CKSUM | \
+					 M10BMC_N3000_PKVL_B_HDR_CKSUM)
+
+#define M10BMC_N3000_PKVL_UPG_STATUS_MASK	(M10BMC_N3000_PKVL_PRELOAD | \
+					 M10BMC_N3000_PKVL_PRELOAD_TIMEOUT | \
+					 M10BMC_N3000_PKVL_DATA_TOO_BIG | \
+					 M10BMC_N3000_PKVL_HDR_CHECKSUM)
+#define M10BMC_N3000_PKVL_UPG_STATUS_GOOD	(M10BMC_N3000_PKVL_PRELOAD | \
+					 M10BMC_N3000_PKVL_HDR_CHECKSUM)
+
+/* interval 100ms, timeout 2s to trigger the PKVL EEPROM load */
+#define M10BMC_N3000_PKVL_LOAD_INTERVAL_US	(100 * 1000)
+#define M10BMC_N3000_PKVL_LOAD_TIMEOUT_US	(2 * 1000 * 1000)
+
+/* interval 100ms, timeout 30s for the PKVL preload to complete */
+#define M10BMC_N3000_PKVL_PRELOAD_INTERVAL_US	(100 * 1000)
+#define M10BMC_N3000_PKVL_PRELOAD_TIMEOUT_US	(30 * 1000 * 1000)
+
 /* Telemetry registers */
 #define M10BMC_N3000_TELEM_START	0x100
 #define M10BMC_N3000_TELEM_END		0x250
-- 
2.55.0

