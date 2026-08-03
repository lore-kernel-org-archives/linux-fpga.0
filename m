Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE240926A;
	Mon,  3 Aug 2026 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763432; cv=fail; b=WaJouMkZjO0wEO641hopgSs+jviZhC1kIcdfCUMvibhbT5RVycLWKv5AL9iHB/RfjqVERbLyh94kKGvYeal7eeI5/fxI9OV38i/PFh2bctTmPQXx5TppawXrQ6Q1o5Vm0Tz5HVxSVXcXtNa9UC4XkZTsjiRc2TsRABG5CmHzpkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763432; c=relaxed/simple;
	bh=T4tixaIk8iEArOyvmOIWAZ8fwghmprPECQviWiPKq8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=llxP+ymDX0OhJjbUwCSjtdl1A2eQst9SVSyUItbFm4fxXeTdnW1GtxBv3JJAOQoLrvoS0EQjuO0j1iertAkVNdAL1p/GPtrSlpP19dGRTqEp/2IEeG/OAEBnH4fEjXMZKQRyj9UNrjl2X601TAAhuVS4RkDjaERlAMC2DIu2CBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Fx/ieXEQ; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Fx/ieXEQ"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673C56qU1431383;
	Mon, 3 Aug 2026 13:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=58CskPwzO1yfh5wWF6sNQKvlNkrNuRWRiWfoaiLYyNg=; b=
	Fx/ieXEQq4s2awTP5TPmBvhjTUlH9dvk871Eqvy008XoLtcA4yUYQaDlxtctWhG3
	92KhlK0rsC6HlH31DzBmaAUcpgsNMHFSvDcJpysESV9//RBTVn0zKjzdriDQwryK
	gm+XquQyEi8sodBjzoKRPFY1RLg9nSwv1Gorw9TYcEthITo02yZ1i73Purd8plui
	kCIY+CPCOAOP8O+l8bLAKTqjwJUb0PBbdu7nnE6a0mhBR6qD8DQoRYujS4UUAbQC
	5b2oRNI8xpvrfspQIAfer0GadvseUK1COjNfXP6sdtEyfWH2+kC+/wYcaPpC23ax
	AqvgodrX8IybJfVmPHQ+sQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fs60x2e00-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 13:22:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2x0VsuKLsNfqLi2HVttNFoLevvtf2F0wM2Z0+t8aXJRyJpjIs5xAvC6hxx6HPaOUES3L3ptjOFiUcQ+YgZlm+SEUi2AkVPiPUv/pQxXHTtG6Va2KTnZNMilustiCaLdnPiBheKP3Jhxx2jXgwgbORsZDB3DH3qn3rmCZiWD9uzHROicspvfyDFu2RCpYObn4e13O1I440KIoorj5/gI1J9X9WjZXc5AeVzvsaBXkdpWN88rWnOAMV3X9HWnYV5/LC2pImMouGwWx9VXYbbA8ZL5FkPvSR+vDeHuTAazf9RQx0WjjsbzY66VRRx1Fp0Iv1ZhWx24C00kBKmVN5bZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58CskPwzO1yfh5wWF6sNQKvlNkrNuRWRiWfoaiLYyNg=;
 b=ru99RzR4s9+PK1Xzw+lzx1W58frVNKLTbIVthbuljyHHUMdaAcCyNU2m3LqY/vAMENpgYKLzmn6NbY1z+baPJutSEsR2WicJxSj1uFx8dCTjVdv+VKcd3FisLkr2Ue5Yd5os3PuhcgKghvbyvUiqc2Pz7l4aFYduQ2iZZCnbPt8Jxb8un8veMsp0nliAegL/PgueEQwZr+4KtyXDNxwjgPgzUI3yvbpWlV3ipgQnUxjBMb1HqaTsIbGimBSS/XWYSQAGdg1RIt7+lezUnIhF7ur5fa1thLmN2prAth7KBsg3o3HXhHS/NjHUT2jH+AdVdpZNAPoY0Cp6AsPi1ikKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 13:22:19 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 13:22:19 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: yilun.xu@linux.intel.com
Cc: yilun.xu@intel.com, trix@redhat.com, mdf@kernel.org, lee@kernel.org,
        linux-fpga@vger.kernel.org, mfd@lists.linux.dev,
        linux-kernel@vger.kernel.org, russell.h.weight@intel.com,
        tianfei.zhang@intel.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v2] fpga: m10bmc-sec: add image_load sysfs for N3000 and D5005
Date: Mon,  3 Aug 2026 16:22:09 +0300
Message-ID: <20260803132209.294554-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <am//znBXTh9eV5CC@yilunxu-OptiPlex-7050>
References: <am//znBXTh9eV5CC@yilunxu-OptiPlex-7050>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIVP296CA0087.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::17) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SN7PR11MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: c0190694-f8d8-487a-0f6b-08def1623dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|23010399003|366016|1800799024|38350700014|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0dWZMCQJvj+SmZbc8mQwiMH4G4ZEv2xqL3+SINLLHCmDB8aIVUuRgwUHHGMI+nMNLHr5CJOqZe00Ruxk450IQ1SLnv6MmcdLhnzlPBHoCif6zAaHRnbBGII7++X/Iv1GpWPPXKOfx2hDXHyAaMfsrkqCwD/hmv5swnOx+dwIAuz/lBijBIc4wQA5f7eVplCnhD46FZL3WSskjI/6wYHryJWyCs5dR+fyr+el8471dgf75yq7LwFW17gZ2XUKXS2gwHzAXw6+Gz+eiXDs/hB3wApTbDeiz1ki3coJ7WXHxEryjYf4ysgI+zguq2t4zW9zpAG2TCA8quvcQEpENmJMtWUCpsr3PrLAEgkB5DjRlb9NZFNZo2c5Wng9vkrMcsFBkc5e37O/wLAB4YZfOFmycitY9TQ/rk8tGevBxVdoVci3zLe5JVdGcabrle2bLqqGM3yebjy4fbwyWL1+vIayfwGgUSt6ULReEu+q5CMTPjlkfdgRyCWB/PNIjOpiocaJvXetjqaMqrPFiBjBydtI1kVdnMeh3W1WG3p/uiP/ytU/3tjzWNNzkqPQQml+Yl4GNDDs9K+JF2NFBMtwvoT/bBSUUFfmVC2pa7VI2YJVvSRKsBnlOi5HqIAEs9DXmCuMuGj2i5SS7aKBg69Fs+AXsSQmCvIcMjTx/mkYS30led1LRFiegsiV4DV64LWu8J7pkpWqnDoRwBPabGFEikNNZJgsy78j/q5Nib4hC0Cp0pw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(23010399003)(366016)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xo7X1rFqAhhsWyIb61uDhkg/MPsXcQHsjxcbL9AMrxqj9aRxI54LqVdCnYs6?=
 =?us-ascii?Q?tqyPAZ7OmWbVuTJGrft9oshcO+xC3nW+w4qBVKWqTyEAEt1AlDuZsw9WchL2?=
 =?us-ascii?Q?x5vp5D7Dm6wjd4YO4rMVU1BC8ELOJKUuKf3E8GkdiTfTKpOropOwjdW0G7pn?=
 =?us-ascii?Q?hEjkUSIXWHaR2grVdqYx1FxKXYBhU7jlMH/U/gqi8yaTAtxeczAUjX4DHRBd?=
 =?us-ascii?Q?MCSmjldmdRD5YIROIdF6/sXT8kINNiDl6wrJ/ZG6tffKfXWu0Mzu3fHNGCCq?=
 =?us-ascii?Q?QjwFPwu2estGE196VzuGzWU/UZNoeCsjeZU/hpqwRZQav0hFKzMbhoEaUuYm?=
 =?us-ascii?Q?KGt7b8frZbS2hfTvfeOo28T89FQAdQWw/VTrsZSX0cTnY0GHbX9S3vYVN32T?=
 =?us-ascii?Q?aNfdNhn18J8etJ+ChuiluDJDbDgZlGJD06q3hhYzdDHVROGEuIE73LRzHX9M?=
 =?us-ascii?Q?Z15wbYy3GK+21botb61HAPPTEXlXl4Pt2+PxYL9Q/ol570tGI032Y6ZsgoVV?=
 =?us-ascii?Q?Zo68pOQ6p9+lKM19xwpjlySD93Jx43OCqQAWezSsGK7q31HL/eBxZfyPzmOZ?=
 =?us-ascii?Q?FBdm2EFz9qYBPst+lg0n1VtzBT6BTl/R9LnPcisXrM4HbEMldT3L7qw1Zb9W?=
 =?us-ascii?Q?XWdapchEGtLao55MlNzulN7/4TWPZdirMFZa3w7hCKeBT1RoT3mjUbkpoxit?=
 =?us-ascii?Q?A1k1WejBiMOU6ijb5WyOPe4DAELO7Nlvxo7/siQ3mT6jCL57Jb8G+b+U47oN?=
 =?us-ascii?Q?yiBWDMiSHNzKzHfeFEa/WaPMIi1Tjt17RLpSxvwgS9Zr5jU/tQJ7BOkqDT7w?=
 =?us-ascii?Q?rJ3RMcqrD5Wdp9+ifxUNGiF5g1HG7AZkZE+sLiVMPUPLR86LgIU57BOlsK0J?=
 =?us-ascii?Q?FDA7jj91osZMARKPeAs8lKA1RzUrVYfJ5BdnYvhAvwrVvu+zOKU5G5XEoz+t?=
 =?us-ascii?Q?S24FRQllcbDHVL+l7NKxUUCQU2KEfdyou80kpKquiF195NVVjb8u5d2f3e9X?=
 =?us-ascii?Q?FDW7wY6w1UztGbYucw1ledz8103eevdKuDDW2CMpIG0NR4uva9TJisnaIduG?=
 =?us-ascii?Q?mvYr0EUT0VI0f5F/FROggSdzhPdOcToMR/qduksOPmxVjygmareZHhvOypcT?=
 =?us-ascii?Q?xe3SArv6leyc+uzj/hx4wzkCP7a5sOGnZkJP7V8WOZyHd5nWjXyGA6NTS8oO?=
 =?us-ascii?Q?4KWt7R0oK8W/2/42jJ4IynwzNaCj067PB5LQ1BXHD0tvx/MAEoXPB+7+yDz6?=
 =?us-ascii?Q?s3jsJV8UMvuXAil/BTzhi4zk+Fcu1tE9bsOtALHcRWI898oWIi29BLmFYw3f?=
 =?us-ascii?Q?bT4pZoNE2a1Rghzz4+ChWF79or1BeX6N47FqIFxrtWCW4fMxlJRYwZE/coU3?=
 =?us-ascii?Q?WgAlhlBKl3OFpD4xF+0l8p1ISlr4HY7QMVKohwuvk+1UnirBBFcIKJ76kZrf?=
 =?us-ascii?Q?bWCCFxl3Ch6NZZ65un/AKqM4jqr9oOELcUl7WTdXt/7x2Ug8b21Ktq5EGwUi?=
 =?us-ascii?Q?C3tRYMtljz2W0Xr57HgQo99m+it35zj0vWBoQPEJbtPjpzHusVxtH4SxX3JZ?=
 =?us-ascii?Q?H49qmbE4yo1q9U5vehIqyOp52LcPu/IVr8+/hRgA/XcTysJ19mlpQqRdnigN?=
 =?us-ascii?Q?ofv/WUkNWXMnBrFvX/PkoJSYAJHgDTpQYSyD1Au6sDBFlIJ5w4l+Usk5SeEY?=
 =?us-ascii?Q?U+GRTwl2Eua874uw+2ouVsOc9K7yG01xhVSXmoPDU9VnTKlts6h4G1buRS0F?=
 =?us-ascii?Q?I+FTD8gpaB3X7RPVLi05GCBYaeHf1JA=3D?=
X-Exchange-RoutingPolicyChecked:
	Tgo8dpTmduQBxjuqxKeBC/jicEaBBLwQfPrNEEec6UPr8MiJUywMPoVLCUitDocB7pKU4mFLU8doE8ssxSSNhkF/JM/0cI3UYinxBMa8ylyNNUAnKmCSbvJuTwPJ05CsEOHJ818WxfznaskYk2clF8xWspGaYYbFsBwy+8uZP2DSwxzOJsay/zDu+O4e8zxER2k88nhXN+4gQwqMUZzUnKSM/HoMI3G9xHYfTAlUOoOXcuBs9Hu78nP5aZAEp0jJeeQNn7xcHZ8/lgt1fRHEZVFCTat+gHt2fOnGEDjDKzmP/3VsHQ4zJ6nrL/JHYkxPqWY+A328ZRZ8yr04CcMrug==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0190694-f8d8-487a-0f6b-08def1623dce
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 13:22:18.9139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Nad9vMiaVdkPvGvgiI2RkWXznFoclhZcEUG8hfKFXYuRBOYDqRRCvWatrxMRLom/wtP0Sljj0dRL/7L11mwIxnryDXrJoV7+FX1IYUxDQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8283
X-Proofpoint-ORIG-GUID: rtO2PZf-E7ucRrlf-1xWVH37wNSxxb20
X-Authority-Analysis: v=2.4 cv=eL8jSnp1 c=1 sm=1 tr=0 ts=6a70960f cx=c_pps
 a=m/LAOfpIcXRJv0ug5Ru3ZQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=_nCZjsbEACQkaSwLiUsA:9
X-Proofpoint-GUID: rtO2PZf-E7ucRrlf-1xWVH37wNSxxb20
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEyMCBTYWx0ZWRfX8uwzMTH/BuZS
 Aq0dk1Pmv4n6Cyti8Zy5kKo9CzvYkCd38sjRAcoaNzoocCp56zk2M54N09gpGDzFFME/nqVve7w
 Vfg9xjvUKfRCTZr5Lq6QdI7uKsTi0poi+dHJUDLvKZiPl1H4WLnMdaygq+qmIHl3SWdgyzv7fRH
 bV4o+hmmsKpaHGuu9PCdYbl02kp0NWE0q2MwCwM2jCwFnLjqeDpoZKyUPP64ZWGe+OotLHqIBUH
 twrqf4KeDaBtbwVrVKQT4nK69RwXqOEv8oGj+071C/A2t/wq2wzQCpMi6oAVnA3OSAVoe5k757I
 vDN1FsNs6jlcsKuNP+l3uwUZ+PcRckZiD2ma7hrQvjjWe8G67Ua7dOjaY37YUTn3gUUvH1TUWsK
 gg1SOSumO+yLUOdTKxwXFrjhXSb+ot5qNqTH4AwXSNO6+dLzCyIKAealEEMBF8SQwGrWVGyBV0p
 Tg3IzetJY1J6e6BlVbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEyMCBTYWx0ZWRfX5znyyFQO4m37
 pnDPrbt9co6pAAth5Loy9dfYzfJ3i4z/uJnesHmGX0eh+XUxNYeQP7uWqj/8StoNOBoyUFqnFFu
 KJWFrTVxKH7t3RILv9r8eR7Z02F9M7RLDk5WKKBJeQdrEh1TVNcv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030120

On Mon, 3 Aug 2026 10:41:18 +0800, Xu Yilun wrote:
> We had quite a lot of discussions about the uAPI for fpga region
> reprogramming before and WIP. Although the reprograming from nvram
> doesn't require a user input binary blob, the main concern is the same
> - how to gracefully quiesce the affected devices, and how to
> re-enumerate the new programmed devices.

Thanks, that is exactly what I want to align with rather than duplicate.
Could you point me at those discussions and any WIP branch/series? I have
searched lore but I am not sure I have found the thread you mean - a
Message-ID, a lore link, or the name of the series/tree would be enough for
me to catch up before I propose anything.

I agree the two hard parts are the same whether the image comes from a user
blob or from nvram: gracefully quiescing the affected devices before the
reload, and re-enumerating whatever comes back. On N3000 the affected set
reaches past the FPGA to the other functions of the card (the i40e VFs
behind it), so it clearly cannot live in this driver.

Two things I would like your read on, once I have seen the prior work:

 - whether a per-slot "disruption" hint (none / device_reset / bus_reprobe)
   fits the direction you already have, or cuts across it;
 - where the quiesce/re-enumerate step is expected to sit - the bus/portdrv
   layer, or something the region core drives.

I am happy to do the generic work and to be the first user of whatever we
agree on, since the N3000 is the only such card I can actually test on. If
you would rather I hold this driver patch until that lands, tell me and I
will drop this upstream submission and carry it only in our tree until the
generic interface is in place.

Thanks,
Ionut
