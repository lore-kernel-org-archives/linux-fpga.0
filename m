Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F73C09F8;
	Wed, 15 Jul 2026 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101183; cv=fail; b=ZRGBSpHHoiOC5mH8IT2+UzjzCw3RPFXEeuWtd4kNgI4au/5sXofmo30u7X8CetJeaPoOo8E8F8v0ugtfwmA8ZnyWVvwpBTHOxtcWaBFIfyDjsSFv7gpeKG3WTg94quSP3ZeSXKkWqAOtmi3Ko36zt06WAOykwzJKSpSNp6RAiTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101183; c=relaxed/simple;
	bh=1pKmctQ5C3MmskPKz+jH6DZd5OsGJQLuPFi97IbjFXs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hbLPRiCrNDTrzc4tauxAc3BahZr9GWbcSX0sY+LzL/sZ1N9hIeEskSqAp656TBZGtqNZsq6Xh4AofB2gQbgnwrUZfGuOCwvhhBEwPFdlsvvL5OQbksG++IpMw2u8NH7UJ6FuANbbX5WsTt3i2872TKk8WrI2w+pdCgNSUoIlyUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=YpPhLacR; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="YpPhLacR"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F75leA3833204;
	Wed, 15 Jul 2026 00:39:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=s+6Vrfchc
	dgFIaCAOgLp6mDePlEkjy+0/qH9ISdjTaU=; b=YpPhLacRWnOGyEUZm1QbSeNRP
	XT9aAwjO2vuPeaDCaS47TD3V+D/lsFVK3S591vQ369P2dOQBIzCDHykUOytm0zmW
	hjPx6JCaxsZzoy0cTTEF+HQyCB/6pK8M6gjxIJw4nmg49DvtJdqf5q5b+ioF5472
	n4fFH/nO18cWGGPvdaQsKjXb006Ngrilcl9RF9WIRiT4GWTLAjvBJwQI65WFbxjE
	RyPtqpY+fCN7sGhCOljsagU+ZaVjOXxetaCCFpUSSxh7z8PJMl/ZGWS+VcW7sseL
	gagLY0a1MlA8j+yp9JrgEYm+glu9+qwlKiPTuQIND1UuC7mhLPh56t443cdvw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fbnbdnd1y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 00:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTjIDDYb54AP/DihMrwgRB49cPm2fpEfuRG2Pgo85W2iVFbij1oiaprpLMONtEc06raTK551D3MGm6gV6bDrG3Rxz6Sr+644+SEmkhzxMRFVLkAI3yR6jD6tXX2Ev39kcUhbBDzWgcjU7ErBsQ8Il7EjC2FZaXTATEXdjs5e5SqSYSTN7sZKL/u0tvXilK3zzpzgPMC0vicLBtBx3f6TxsT5UCCV+u4KUPI3fdQ4E3rOTdYkp2a6M8RDsE5YeeDjHjl/8Ux5iRe7E3W3d0cDcRH+mo9zNSbO7Wsi8LFicJPdTu5URoEwgJ2AuSVgc2Ca2xeXq2CJnAlynz+tvxMNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+6VrfchcdgFIaCAOgLp6mDePlEkjy+0/qH9ISdjTaU=;
 b=MXWliWQNFAn315/wEldf75qR5gv9tUPXiyYtiBbfh6LdhOXDh9BczLmR3YYxaE6TUYowfxxBBUnMnuBHa1s1DBirLpl4/53hTCvZuxL5ljteXNrRIwi3ZNifAX46owvE+EK0xrtnnXpRjc+Q4mzIOyosKOr4t3QB+hp63go+zHBWmCaAvgvhpBP6crPAqeuFGYSs0otmI8hh5dhaGex5ehpltkzhCvyZd60aLjko1B9dsCzoNey5koUAYVgA5h6JM44Yqjg0DDE68WgQDe/DcRAnjd0MMHzDUGDdfNuAa+cUdOJO5MFyQQo+8FYAkFhkYJs4NgQSfFykeuDFSe4dJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW4PR11MB6571.namprd11.prod.outlook.com (2603:10b6:303:1e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Wed, 15 Jul
 2026 07:39:10 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 07:39:10 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        linux-fpga@vger.kernel.org, mfd@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] fpga: m10bmc-sec: add image_load sysfs for N3000/D5005
Date: Wed, 15 Jul 2026 10:38:53 +0300
Message-ID: <20260715073854.26117-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0253.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::20) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MW4PR11MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e35eff-6a9d-4c13-8453-08dee24428d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|10070799003|23010399003|366016|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	K/OEsKw9LnOHfBaAS/TGKjlvd0ytWc5227QHcz7CCHRxCtG+5xQOhgxcaF/yRe3qOdMaxNwtnhFLSDCwiWwAAi0LJpQbbnenwep1ujQiVZnCDRueP3vbGpalqPPToifL9Inrfv+iFCfp4vL/kyrbhQKO9ko4LWIGoBQhy6f0soxavKKbU4FAQf1bC3EVTbT/ht3uAtHTiwMAbGsPRBvYyut6BZrs0GGPnl3dQYZAjm+93H3hV279QYk1s8HBIQq7WnWqRPNSCm99QET3mnepbqduyeesXPwkVDQrZCIVEGVSfhbwV9BqWbhGQkY70nr6e0/1qnenlzl8pgYDs1Fiw55dCS+A0oS520UqjgtI9979AXzErFyUxfezN7tKme4GSrL3rVjurK5JxxVzZRSvd+cuYm1dn5jvI6/C5QnWU32peqQvf/IVzq8WvXclRjUISXlEneZNA2/lAIpVSCTbP6jRNrBJy6GHk+26ZaXhwBWx7k59b9Dsu5TAOZoIdARKaPjz757pPUcbpyFE+ywPLGnd/fqZaysShTjQXmEYphR4VGpYk5+yJUBWLDWwHgMWymG1osYzf5k5gJhWWT3pvV8B8fJNJM8QAToozB8nrkT1ZLQe/M3f36RsV16elN95tqKdRPt2gPh4b/d8iAJlTvovH2kzJL9myySEdmiue0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(10070799003)(23010399003)(366016)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckxFcEhkcWcvaWM3dDBSMnlFNVdIRGtYODN5b1VjZG5iK2lUc2ZHVGtpZ2Uy?=
 =?utf-8?B?SkQ0a3UyMkRFaHBOY1lCSm9Jb1R1d0YxMGxtd1l4Qk9UY2RPUFBvWWppbzht?=
 =?utf-8?B?UWVYWk01VEtuQ1lzcm9rR2VUYUFKeW5IK1p2Z3B5ZkZIdzFBV2cxMC9ZRHlI?=
 =?utf-8?B?WXBNUjM0cEVLZ3YyWTlwVkpDZFFKS1I5azA3YVh3b0t2UzRsMHROV21lWkhS?=
 =?utf-8?B?M2N1UnFmNXZqZ1ptSzdjdEF3VXhQY1k0RGFyeVdubnY3YjZFcXlSZDZOaU4x?=
 =?utf-8?B?MTNReXNEbkpORFdLNTNWQ1BQcFZIYnVQb0dTVFZpRjlYVFVjNENkZUdOb01w?=
 =?utf-8?B?WkMyUmhaTVVUdVRoVTl5aEpXajFjN3pSRUIzR1V6S0NMT0x3QmNscDk5K0p6?=
 =?utf-8?B?RVRIZUhSMU5rbEhlNURDaVFSdTNMV1FpRDZJb291dUtTUE1uNFVYSGtXTlA1?=
 =?utf-8?B?eFpLMVhZaGhVUVhYQUtUWEIxcFlDZEhJTE1CWXBOVTVSb1VZMno4QVM1Z20v?=
 =?utf-8?B?VjlNTVZMNC9QY2k3YzkvbDU1V3BEWUZWOGZoWGQ1UHFHaCtUZEVHVzJTV1dZ?=
 =?utf-8?B?b1BZNERVVlRzTkI4VDhlVjJzQlJrSlE1N1MzNFhJbXF6MFJGa2lpR3ZIN3ZX?=
 =?utf-8?B?NkxKNjNjUGNqb3lUeDUyVG1ORzErK3NQcmFNWjlEZVVNT3IvM21uUXZiY0pK?=
 =?utf-8?B?WlNneDBKbXVFR2JoWWlkaXFZQ0JEaVdlSFJHVC9JcVYwZGFnK01zZ0lIcDY5?=
 =?utf-8?B?RDRxRGJjbUxIV3gvZ0FrUzliaG0vU0RaamVBdklJdFc4a3d2REx4aGNPWHNS?=
 =?utf-8?B?YTRHOG9QYWpJWnlQdkwwL0c3RzlzVkhpa1lpMHVCZk1aVTRaaGdDa1Fib21u?=
 =?utf-8?B?ZklKM0pQOTRTdWtuZkk1WVQvYi9iUGlZMWw2RzRmTUgybGlWcHVrazlkWStT?=
 =?utf-8?B?VHk2TGJUcUR3eXdWTklTMVEvT3Z5ZjFBcHAxZFRuUmNHVnJOYmExcVRGRlcx?=
 =?utf-8?B?L1VMQ01WSGtpa3NLR1R1OUdRWnhkMHZKcUIwTTBjY0piVTVpVk50N3RvcSsy?=
 =?utf-8?B?QVZzV3RQNEFxclJwNWhsb1laWmpsZFBUendEVTdKY0dqYWtpK0ljQ1dtZXZC?=
 =?utf-8?B?YmxPTXY3T05IZzIvYlZXcW40R24vcnZTaHorejJpc1U3aXQvRk9VdzJ0ZjdU?=
 =?utf-8?B?TWJQd0l5UW1xdytScE50UVZhM1ZpeWowQXhPSjA1clBrczlmOW9HVGVKM0ZJ?=
 =?utf-8?B?NUZxR2xNaXg2d3NSaWtSV0c5MEZGc2lsUWF6dEtqR1lkTjR5NmFGd3Rkckpk?=
 =?utf-8?B?dllZUVBlYlA3cTNpUklINDV4b3Y4eEsxblZZSmlvM0pqbm5ZcDZDK3RCdEZC?=
 =?utf-8?B?RTFnWU4ySG1KMndRU3lib3ZaTlFqWDAzUkFIbTRhOGJOcHZ5SVFYOWhPQ2V2?=
 =?utf-8?B?Nk5sQjlzVWtSUnhTZFRRWXFQTEhlOElZZWRQSHRNNkpTK1cxa2Q0M1N3blBm?=
 =?utf-8?B?Zm9UQTRHQ0hIVFZyWDBSaDhobEpXU3dDbmFEQWpoOERyb0RXOEVYMUtPMDdy?=
 =?utf-8?B?YWU2VUltcnRYbm1tOGkrRU5xS3BtUEJONkFmUms1aC9nQ1VmbkRhVHJqTndx?=
 =?utf-8?B?U29kRjVnMXhnRTF0a1ZBRS9JRVJ5UHNGR1p3azNLTFFiQjBMdE9CR1M5UlhF?=
 =?utf-8?B?Q1RNZnZXMkxWd0NrM3N6OUg0bWhYTEhWZ0NWS0FmMHNqdmlhVVlHQzV0YUp4?=
 =?utf-8?B?ZkE3WVdWQzUyTElPQ0EwTEcxMi9LYi83ZElaMVRpNDZsLzV3ZTVrTGw5c01V?=
 =?utf-8?B?ejFDcW9yK3NvUHBiZTFCcmRaYUZwSzdGZTIzbDFrRXN2RklFSllJbXE1SWhz?=
 =?utf-8?B?K0VpS1hPRDltT0FLSnVOT3JaRE9WOTVTelVWWWc3SHZuejZKQ3dzVlZzM2E1?=
 =?utf-8?B?SjRISm43RXdGV0Z0Y1BoWklBRm1mRUNJN0QxTWRycXJOcHpJTXNqTzhmM1U4?=
 =?utf-8?B?YlR1WGRxWmJJeUd2N0Y5U1NxU0c4ekFCM29DYW9rNk1KVTRjN3dqakxVTnBq?=
 =?utf-8?B?cW03eU1JaTVxUk1HRjk3U0ZUM2FXTUllWWFxbXdjRUl6YXJiTXVLTWlHL01o?=
 =?utf-8?B?bTZJeEdRSVpHdVo0eGl2U0tpTHFOekp6NUN2L0lPZVl3cmJFaGU4U3V2WEZn?=
 =?utf-8?B?Q0Q1b1R2dFFad2dIVlVENWY1alVQZXBKTzUvT08rak80M2tkNFl5ZVdBVWN4?=
 =?utf-8?B?c3NZa2hrcmQ4K3E3TmhFa1pQZllvRnV6aGIwdzNqeDFkcTRYeXFIbUNMQmQz?=
 =?utf-8?B?S3Bpd3RSV25ZNW9zczVsc3lXeDRJUDVXdzhNaTc2blpmM3NDbSt6cnpsUHRY?=
 =?utf-8?Q?ZlmzzOLWgZQjHmk6dS7hz4ogFhhEzpOQNq8Bh2uxZINZG?=
X-MS-Exchange-AntiSpam-MessageData-1: Hcye833Dwd/mgE+NkfwLVG2X2yX9ig49lH0=
X-Exchange-RoutingPolicyChecked:
	fr3PuSLB3OzwuXBlQia+CQWji2WVMveoPS0t5nG6ocwssN1ffFkvnUjQKxYUWahRv3G3Wb2yz3cn3USrWL5QKWqoNN8fb1wntH0144csRzBx8iXIdi6CmOPoc/czA+TyxJ/VF0tu8wVzz8G30Mx05g9fRNzKaEvdpG5+OzpeCSjRG/WQ1Rz3PCLRrP1J4nDMvkZoHvJ40zRPrEK+xeSCZfX4HVg74TflGqOYM3L3tY9kjZQa9kGz2dsg9ieLynV9+/nwRyOCF60dBaB1vVhsiUlAFJDhvrw7YR7nFtv/ZjK9ANXV03A8EObGum29D1Vzwo85d0eB7tgmp16m5vQN8Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e35eff-6a9d-4c13-8453-08dee24428d8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:39:10.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iWo+36n4/8dSvI+2dkuBQCF7rRu1vKyYLMlc1dUacLAaWN+mjEEMwPHGrxnooF5kxByj7Me1Z2SQeD7U5lneWr/3G1QLSaA/9bH7psi2xQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6571
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA3MiBTYWx0ZWRfX9P9KoJLlB2S5
 hL9x2bn/0taiWcFyqD0W0+/cHz2CZnQFcLAohMbAL/FYsyPyuElgDFrFs410NxxppzR3pgwNHTb
 mFWLsPS1PBbQ5YIE8cyHpcirnASc2y62jMjniv1vRKUoC8npbhZnuLGV8e23oG+XMWQ5Wy3kwFM
 setAs6aB7AZMN1pAhL+jaaPXVpwwXtd/+eqcrdyvSv0xRaisTzSd0qgYo/47m8j6El80FUXNs5/
 nfCp/L3b0wTqlQPa4w8YWw8eveaD/0kWSS8pOOYNSZwauu5YeRfWx9R7cKQYBtuTveQ7pZD/dWH
 tIHvFVEB+i2D6xzaDXnW8N2bI1mWYqdplzG7kO52TjtLgwZe5G1b8WdXr5DO7JqCT9DmNBfqx8P
 nArgLYEw22MSi2loHFgjEOTdZbpbTcDdEDjtTlN5TF6VqNu9mkRhCFsa4Eu0CgOg54qEUYH2Wj1
 IkIMYfd5jDzAQpvHExQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA3MiBTYWx0ZWRfX89WgckEk9bw5
 xvGZicziMd5ghZ/UIcwVeVdm9V0krju8bytAkFdrULHykBhpBq27RhwpEE7TmK1MK/YnSkCwVK4
 jBOdj7apeGfw0+o5t5D7uJuseZrP2hs0VnauTvWtclfW1w2oJXjR
X-Authority-Analysis: v=2.4 cv=VI/tWdPX c=1 sm=1 tr=0 ts=6a573922 cx=c_pps
 a=eLvx4Fye0krSvKD/jKlmuw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=t7CeM3EgAAAA:8 a=zm2AowqA1dUcHJJgSJgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: Flket_aXHfU3Yi8QgNoHKvPmFAvNv-dh
X-Proofpoint-GUID: Flket_aXHfU3Yi8QgNoHKvPmFAvNv-dh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150072

From: Ionut Nechita <ionut.nechita@windriver.com>

The mainline Intel MAX10 BMC secure-update driver can stage and flash a
new image through the firmware-upload ABI, but it has no way to trigger a
reload of an image that is already resident in FLASH or EEPROM. OPAE
userspace needs that trigger to switch between the BMC factory/user
images and to reload the PKVL retimer firmware without running a full
firmware-upload cycle.

This series adds the control/available_images and control/image_load
sysfs attributes for the N3000 and D5005 cards, restoring image-reload
parity with linux-dfl for those two boards:

  - N3000: bmc_factory, bmc_user, retimer_fw
  - D5005: bmc_factory, bmc_user (config-select polarity inverted vs
    N3000, hence a separate ops/handler table)

The control group is only visible when the device ops provide an
image_load table, so N6000 (.image_load = NULL) is unaffected. The N6000
PMCI and SDM image-load handlers are deliberately not included here; they
depend on the wider PMCI stack that has not been upstreamed yet.

The code is derived from the linux-dfl commits 604ad4f48cee and
e1b885714f68 by Russ Weight, Tianfei Zhang, Xu Yilun and Ilpo Järvinen,
adapted to the current mainline driver structure. New sysfs attributes
are documented under Documentation/ABI/testing/.

No functional change for N6000/PMCI/SDM devices. checkpatch --strict is
clean and the driver builds as a module on x86_64.

Ionut Nechita (1):
  fpga: m10bmc-sec: add image_load sysfs for N3000 and D5005

 .../sysfs-driver-intel-m10-bmc-sec-update     |  23 ++
 drivers/fpga/intel-m10-bmc-sec-update.c       | 286 +++++++++++++++++-
 include/linux/mfd/intel-m10-bmc.h             |  31 ++
 3 files changed, 339 insertions(+), 1 deletion(-)


base-commit: cc2b5f627e8ccbae1188ef2d8be3e451d7f933a5
-- 
2.55.0

