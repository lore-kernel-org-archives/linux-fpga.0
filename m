Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333FD3B840E;
	Wed, 15 Jul 2026 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101191; cv=fail; b=MJndT6ywjoCyTBqoc4hrOBkEesY6cln8HX/c98VpLYQicXcRs0NNg+JN0diPc/Ro0tBvLjY0OtIZRd2tkM3aWAU7XfdWRaV/UBSUKNcB6L3e6iO6/xjwwykFwHmOpmO7iAh7BU2Woqt9GQLcdsUPr7wbWq2hN10gOYmgVgEgG6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101191; c=relaxed/simple;
	bh=tF3m6emNGDIzsUmH95a4TmMeV2TQw3Vd7w4/TzLL9oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GV7h6eHYMLFa8nLb9eSof8Lcd+4vitJ3cdzG4oALfJUCafNiK2mhtPBG4o1ysshmzvGufRxk8/9WQsMOIrhJrbSKHI2tZsuY7CIwp0bnDP7Z1prWQc92IsmgGYxuZlXl8vDGlfc26W2iyW/85H6RdKgw8iD+SxJfH7tufVMgxlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=jf7touuY; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="jf7touuY"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F5rTc73705935;
	Wed, 15 Jul 2026 00:39:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ow6zgQaAn2Qupwh6gHfMi7fcGlR+yEupHHTolAbbju0=; b=
	jf7touuYkA8qwqprDq/5rnzmJde9Kuak7hEvpxtXzVW/5Ka4SzmPP4CnjoYQz2g1
	YxiherODnssS0FGtqqUzyhKvN8Q7tGsDMek58hgR3CUygp52obTXK6kaM0UnnIEf
	mKNkoOOTF/1LETGGJAxQQyMrjSA8ezs+Q/+v2sj23vUGiV7fCDI0k03nPoQ4NQam
	ZHVancLLGJCHpBnpGNtjQdPsAYkPX+1l++SSYBHBLU2/jYvyJ0bKjDcdBYroYkil
	ndmshIZLVWFTubPMzjLf4ApH2XYWnTu9U5SGT38JIyqkRkpnlldP3Co1fz6p4Bj+
	F6D+by3Jd3/l8ZNTnWt8Hg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fbnbdnd22-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 00:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWrBg8rVLdxiYEujFHXcjUrj8ere1mRXHj2cIkJ2681ZRcB92HGfnIdVZ1fNV83CPdU1bjq+g6BawCMNeBGegcjYjdCfg90AdhKE4YnSz1+eUie2slbCv72IXMScmEXy3z9HvaVE3SKWu7OU8hCY7IF5iYkAiMDmOKqNTvjsmbr3yUX0UCAVke22bqG2LB/YH1WIwhGr0meGOQSvr4QZP4vNwLChNTcP9v7MdMSdicWU8BUCS47vKbXU1F3IP6YtReA9jjkpbrHwvwdoCcCbNmosVDFxonkaGa2/D1PTwD/iekhNsfmIFL/ZbMdoOuzFEmSUPhUUfk6qvIYnx6doCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow6zgQaAn2Qupwh6gHfMi7fcGlR+yEupHHTolAbbju0=;
 b=OC3zjVFp0fdJBwbFk7rTnXB6/5eyu2Iv/6KVGDYTDGaHzv6epQNkjiT/1iKBonwedz9iBEW2P0JFT5mrhbgUH7qjKqzGZgIz/Bfs4PFfHAi6E64gZ+pgqNle3G/KxaX0OvaN43xyQwt15QpU7OWNj4yC753iUsaIfNkkwVrPUl2zBtl+7NY3i/fCXwImfHiLlZL5L45gTPV2flMmsPfGyviBjvQIwzjAdNHDZVUhoXQVFE3hM1cVuJRWKfwwjo9Rf1Rtms+zZyEPqKck7dTR5ceYnRfdEx1qqVYv4GJf/ykQXQ63Fo6nsjiPB7MqKv4kEhegeG8A32kuL0lP7Q+CJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW4PR11MB6571.namprd11.prod.outlook.com (2603:10b6:303:1e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Wed, 15 Jul
 2026 07:39:14 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 07:39:13 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        linux-fpga@vger.kernel.org, mfd@lists.linux.dev,
        linux-kernel@vger.kernel.org, Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 1/1] fpga: m10bmc-sec: add image_load sysfs for N3000 and D5005
Date: Wed, 15 Jul 2026 10:38:54 +0300
Message-ID: <20260715073854.26117-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715073854.26117-1-ionut.nechita@windriver.com>
References: <20260715073854.26117-1-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 849cb63c-f802-443b-10d6-08dee2442ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|10070799003|23010399003|366016|22082099003|18002099003|6133799003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	4xIkhSfR7k3lWQ6pfje808VLprLSvoLrx8nF3ZNDzats54UHmdgkDA192TSIntd7Y+hzPwx2fHIwn8jqyItO2PFYq6iXx4aEG/OmqLg9EgA5TOz6wPoHOzVrDeQlOufBPwFxUNLDJWnxZEGWL20y4+3UeBKERUsBkNVCwoutGTaF2kLYXwDKVco363kiR7tb+1BqZN5Vqz/YXeRI2+I/9Lo0ZQd3aiLMGa2FDkTONk3cNO30vzYeW7QMSW+iczNhN5Oybw31/0snDYj+f3FiR+fZfkK7tiyn8YXPvgG0SlumZI8HRCaVGROP8ipc6LjmbDSc70XdrANvI7ssAEXReXU/yt/EziFYiqWu92jpgX2SuYK3fkx79+nJysNVtSBOQfytaj/OqRYBwXMXFdUSH7JEV9G0IURCd6H9KoIeRN0+Ea5FAMESdy15HolGKJrvpDJe5klRdnwc+7Sa/HiETTpNyOqiXifNv3Pl67xugOlR7bIWcpjMu+Pxj62fBk9/VthI+VfYYsTCZrqUkPBGxn5lkhakJm0fqR5EQfm8DXc9baCF6aIMbUeKsTkM3/by3q5pg1XhNmCes7ohQFjzRSXs/WKTdBNU1KvfJZhNA70KWgBggow5VReaOAgQKVkRLfmIT70dqxJA6fIHPUkpDjylNh3nav2hr8pfxQIaITk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(10070799003)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVJEano3UEZXWjFKZENrd3hqRGsvVHVmRVlwSThjSFJDc3cyZ3ZwUXJmWFZm?=
 =?utf-8?B?QlBxekJXSCtMR2ZpbHo3S28xOVdGdkQybTFNV2dzNGgxc1VxVFZJTHpkc2Jo?=
 =?utf-8?B?S2FNdy9HNVNML1kwUEZncDNJaCtrNy85SmVhaDBhclgydGpiTUxkU0ozREY3?=
 =?utf-8?B?Sy9acXA4T0xnd05pZ2ZIR2lvMm5qMHkvQUQ5b0ZPUDNNL2pjVXkvOUlNNUtm?=
 =?utf-8?B?ajdrQ0EyOXA0d1NaWDNrSGUxWVJXRkxjV0YzR3JwQnAveGtTRVJCM0xmVjRI?=
 =?utf-8?B?M1d2cDlodktqb2p6VW94SDdIbzlpOGJpZUZPMlZVejEzdml2NFNlUGFEUVR6?=
 =?utf-8?B?VHpUdmFheUVibW02WTJJQkhYYS9XR2FjYWU1N1ExckpobENRRC96KzlXZCtw?=
 =?utf-8?B?b1RoamdwbUpWYnlMaGIvenZmV25pRkVaN1lkZ214MkRWb1psai9NeVdRL0xC?=
 =?utf-8?B?WFNwSnNyYkJGS2trVE5DUGI5TDN4MGZ4aW42VHl3em12ODBTUWkvU2Z4TVJz?=
 =?utf-8?B?Q0FFZ2lDSWZGMHdBRXBBeGt4Y3U5b3dJMVptRE0zYjRiSDcwOVkvQTVha1lu?=
 =?utf-8?B?K1JUdUMycDBxQzByeTAwc0FROS9RNzdFSzFVdTVwL0hwaDlaNkExVm93VElH?=
 =?utf-8?B?ZXBPY0FSVVMyUDN5WSs0UVBtQ2lqU3lHRkRlcXA0QmduMGtWZEFvMjVySFdK?=
 =?utf-8?B?cDRvbXZkbjZ4UUpmd2VlQ0RpcmV4UzBvaFNFY2lIYW9tM1VSQWk2UWpVL1FG?=
 =?utf-8?B?bmdvVUtqK0diQ2kvd2I4NEVGeWFKSDZDb2tST3pQcGlUbWlLMGJ4WlZyY2tu?=
 =?utf-8?B?dHhsZEtmNGxpbUxLZ2tTME5MQnpOZko1VlVTU0l1aTVUeUFJbVVUL2pIRndV?=
 =?utf-8?B?U2MzV3kyZFNBQXhPN3Rkb05jaTMydGdVRkhyRVlSTVRWVnBSKzJuUTlaKzAx?=
 =?utf-8?B?ell2c0xZYjhQL1JiSFJHcHFhM3FFL3A4elRSWXE3UzBBVjh2QkwrdDliVS8x?=
 =?utf-8?B?bS9Pekc4c1NJb2VmOUVHUk9SRzBKaVpJdklmeitwUjlPZHFxV0V0TTlydnBS?=
 =?utf-8?B?ZytsVTVodGhBMWhlNlhPcTRsVWlQLzMyUFhEanV5U0RFSjNWTnVTSVV5b3Q2?=
 =?utf-8?B?RDBWSTFSQ0hIU0RKZ09kWVorNFZXRWp4MW0xWG5GZ1pWVzBwOEZ1dC9VSHhm?=
 =?utf-8?B?OWRpYzRvVU1sN1NtQUJ0QjZHdS9xNVdBT2YxRmhvZVo0OVBrYzVGandhdDFa?=
 =?utf-8?B?a3p4M3FFVS8rYzdHOTdxUHhqQ29IYnN5MkVrZTRTb2dmVnMvd0lGdi85SDR1?=
 =?utf-8?B?cnVwOWpXdDZFc3UrTzVpRmk3UmRHV004a0ZTNG51SEU1RzlPd0hHOG9PcTVY?=
 =?utf-8?B?WE9hYm5NeUIvaTFnTnpFVkFyWDBud2hrMDQyUEpJT1ROTkl0VlJSRU9iaU9C?=
 =?utf-8?B?b3ZtTmZpVUVsalM5bmV6RGxtdGtPSU5lVk5VYjR4TzVPaGNWQzFTYXEwZFhJ?=
 =?utf-8?B?LzlQUVl5NnRkSjdzbnA2U0F4b0xTRUdleXc2K2F1VHg4clpMaUVDR21aN0kv?=
 =?utf-8?B?dWZleUdqL1JGVDA1YmI4RDJWSGg2azg4WWJteHowWEthSG9hZTJLYk5na2Vz?=
 =?utf-8?B?UGlDSHB4WjBDYTFEMXNrWjFPOUtkNkM2cUwvOVcvaGtKUGIrcHVpTEF6VHBC?=
 =?utf-8?B?SC9HeXFBWEttYVh1bVJZRS93T0ZxTVdUNUxpYm5vUWY2MXE4MmdxenJPZzBq?=
 =?utf-8?B?TTVZRHVjaGNkaHhMZVBKT1QwcE15Qm5sSmVXNWFCWEU5ZndZQW11YWs4RzZv?=
 =?utf-8?B?TnVkbUpNUVdLVXJkZ2dNZ01xQUIzbDlFVUZRUUtxRDV4RFgrVXh4Yk1VWU45?=
 =?utf-8?B?RXZsSHBjQzB6MHo4SFdJbExWeC9SL2k4RVpTSDQ0cUlwZkF5S0dtc2dYakNj?=
 =?utf-8?B?dXlxVHZmaGc1QkNHckw2NjZzODlRbENXeGFHUFV1WTB6TTBJaWd4c1BIUjU5?=
 =?utf-8?B?V1JVL2g2ZjFCb25vY0crRkhGZ25oZzUvMzJjcFRPaVNHTktocjN0dzVZbnVV?=
 =?utf-8?B?bGlESnZXNFNWQXBmZEVCU2FtOTk5U3JUUGptL2ZkamxQQkNKRllTcHcwYVpm?=
 =?utf-8?B?NjBaU0Erb2R2clVVdFBoSm4yVmZNN0t4ZEtrUmk4Y1BKNG5uRmxqV2hwU1gx?=
 =?utf-8?B?ZXFmUTV3VUpwYmhzcE0xV1dzSDhnOFJsRHNWWmlydWs1b0VSY1FoWDN6TTlo?=
 =?utf-8?B?THo5R0RUUDR4K1BndGFlTW5SaFV3VXdMRDN3TVNQSW5xZ2FRK2RrVlh2dVJx?=
 =?utf-8?B?Yk9rTklzMDlHQXRqNzdMZndUVElCZDErWXdkUFZ3blFBaGQ1ZnliSnBabFNU?=
 =?utf-8?Q?XxyU5amiOuGo+lfbO2Hxbe/LYsgrSCIg+m/nlqa/CJAGI?=
X-MS-Exchange-AntiSpam-MessageData-1: tYVLot+co629om90UvSV4t20JAeTAftPAmo=
X-Exchange-RoutingPolicyChecked:
	nP4iqrZhYb7cK9lUlsnp7x+hyDdlLAj8pfSK+cQjlYaw/ddJeZ+i22dTtUIMYuAnNbkM9pn3r6uQhPTsW4sDAyVLg8B7zasvWaMANTzGTl7ToyNEuzg7EZJEcWcMPnzEbVAH9MhIWSoh5ogVgPwOptK5kkbzYOuZ9bpCs5MK7jZ80aCXw8wKEr49TwMwXLfaPRCjVqaabEGdaWCpDHmPro/6NEHVVjbh6oyWCfM6qtO/0+WIQ/iJ4ybmkuRAVxiKRGPJdlYgio8GksBmlADQHDddxo0ZI8aYyuMKY8yGzqfvqZ01LVTj3dakl9YLFp80er0NvVfi7FfZU6Gj/WCotw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849cb63c-f802-443b-10d6-08dee2442ac9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:39:13.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hc/gx2DMXDRupNNavjstZTitXaA8LnfAenu4w8rKWUUUZT/A6eLCFhde2nATQB3Acs4FSkBpCCvr1obzZqcdmieeH5rn75EZLpJz0957Lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6571
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA3MiBTYWx0ZWRfXzxng0dS4FLbF
 YJIrJp+6F8EZBdAV194fNcvMg2MM34U4luCEln2hKmT4bSCMI3Vbm5qxK6VPvF3rQzigA83etD3
 EAFkt04Eg1a7X5A8LF2XbI5U0vlQsMIy8cyYRw79YpiAEjzai5C9g918oyyBuVXIGei1myzkhOt
 yB4eZCsup3R7nRpBjBEivuHJoRiJFl7NYHK262z10UjH4CyGHmXEu/Z8xi7JhrQweyDPFoSc61u
 4pC/SPHq0e7Cy5PPjKHvHXul69GMBemNfHiNMjMNUTxS6S16w9U1/vIfTP1okdBKUNHLE9Oxun7
 rMImMCXOIAh65cf2OlVZWAUUdwHUBlld65HR+GSneahCCFZ2poD7/iVQXlE92Yq/2IHUp9EENlH
 G3KnCWtNHq9VPmyRhNiz/NCsb0IL+leEP8btYh9LWo7dIU43TKNHt6IBI9y2stGOOysk90V6KC4
 VMco+MA26+B8qpvDR5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA3MiBTYWx0ZWRfXyWsu7vOrM50g
 sFSBofWtE869uhbSH6cpqEVey53TDXRIjUeST+3ThGVmxQLGfuy7V7t4iGK4AGH2mEnjAmR/wcn
 GFz2oC/Ir017L66WXmeWopSg63nVUZPMEsCnsO5TXOoAu+SUpFr1
X-Authority-Analysis: v=2.4 cv=VI/tWdPX c=1 sm=1 tr=0 ts=6a573924 cx=c_pps
 a=sh1HRyDNv5RGx04/W1QObA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=yBYpec10AAAA:8 a=SxVVFosdX4Lv3ogFJXMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=zbxmTX4fiVD2UiCe4Dha:22
X-Proofpoint-ORIG-GUID: 2NShqL7VzWnQk98fCPeZ_FuUwX0bO-Mk
X-Proofpoint-GUID: 2NShqL7VzWnQk98fCPeZ_FuUwX0bO-Mk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150072

From: Ionut Nechita <ionut.nechita@windriver.com>

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
   M10BMC_PKVL_POLL_CTRL for preload completion.

The control group is hidden via its is_visible() callback whenever the
device ops do not provide an image_load table, so N6000 (which keeps
.image_load = NULL) is unaffected.

The M10BMC_PKVL_POLL_CTRL register and its bit definitions are added to
intel-m10-bmc.h for the retimer path.

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
 .../sysfs-driver-intel-m10-bmc-sec-update     |  23 ++
 drivers/fpga/intel-m10-bmc-sec-update.c       | 286 +++++++++++++++++-
 include/linux/mfd/intel-m10-bmc.h             |  31 ++
 3 files changed, 339 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
index 3a6ca780c75c..978ed68ff23e 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
@@ -59,3 +59,26 @@ Contact:	Matthew Gerlach <matthew.gerlach@altera.com>
 Description:	Read only. Returns number of times the secure update
 		staging area has been flashed.
 		Format: "%u".
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-sec-update/.../control/available_images
+Date:		Jul 2026
+KernelVersion:	6.18
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
+KernelVersion:	6.18
+Contact:	Ionut Nechita <ionut.nechita@windriver.com>
+Description:	Write only. A key word may be written to this file to
+		trigger a reload of a BMC or retimer firmware image from
+		FLASH or EEPROM. Refer to the available_images file for
+		the list of key words supported by the underlying device.
+		Writing an unsupported string to this file results in
+		-EINVAL being returned. This file is only visible if the
+		underlying device supports image reload.
diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 7d23d914df3f..7a390cd70516 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -15,8 +15,14 @@
 
 struct m10bmc_sec;
 
+struct image_load {
+	const char *name;
+	int (*load_image)(struct m10bmc_sec *sec);
+};
+
 struct m10bmc_sec_ops {
 	int (*rsu_status)(struct m10bmc_sec *sec);
+	struct image_load *image_load;		/* terminated with { } member */
 };
 
 struct m10bmc_sec {
@@ -253,8 +259,280 @@ static struct attribute_group m10bmc_security_attr_group = {
 	.attrs = m10bmc_security_attrs,
 };
 
+/* Image reload control (N3000 / D5005) */
+
+static int m10bmc_sec_bmc_image_load(struct m10bmc_sec *sec, unsigned int val)
+{
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
+	u32 doorbell;
+	int ret;
+
+	if (val > 1) {
+		dev_err(sec->dev, "%s invalid reload val = %d\n",
+			__func__, val);
+		return -EINVAL;
+	}
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
+static int retimer_check_idle(struct m10bmc_sec *sec)
+{
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, &doorbell);
+	if (ret)
+		return -EIO;
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
+				       M10BMC_PKVL_LOAD_INTERVAL_US,
+				       M10BMC_PKVL_LOAD_TIMEOUT_US);
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
+				       M10BMC_PKVL_PRELOAD_INTERVAL_US,
+				       M10BMC_PKVL_PRELOAD_TIMEOUT_US);
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
+				       csr_map->base + M10BMC_PKVL_POLL_CTRL,
+				       val,
+				       ((val & M10BMC_PKVL_PRELOAD) ==
+					M10BMC_PKVL_PRELOAD),
+				       M10BMC_PKVL_PRELOAD_INTERVAL_US,
+				       M10BMC_PKVL_PRELOAD_TIMEOUT_US);
+	if (ret) {
+		dev_err(sec->dev, "poll M10BMC_PKVL_PRELOAD error %d\n", ret);
+		return ret;
+	}
+
+	if ((val & M10BMC_PKVL_UPG_STATUS_MASK) != M10BMC_PKVL_UPG_STATUS_GOOD) {
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
+	ret = retimer_check_idle(sec);
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
+static struct image_load n3000_image_load_hndlrs[] = {
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
+static struct image_load d5005_image_load_hndlrs[] = {
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
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				   "%s ", hndlr->name);
+
+	if (count)
+		buf[count - 1] = '\n';
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
+	for (hndlr = sec->ops->image_load; hndlr->name; hndlr++) {
+		if (sysfs_streq(buf, hndlr->name)) {
+			ret = hndlr->load_image(sec);
+			break;
+		}
+	}
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
 
@@ -675,6 +953,12 @@ static const struct fw_upload_ops m10bmc_ops = {
 
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
@@ -746,7 +1030,7 @@ static const struct platform_device_id intel_m10bmc_sec_ids[] = {
 	},
 	{
 		.name = "d5005bmc-sec-update",
-		.driver_data = (kernel_ulong_t)&m10sec_n3000_ops,
+		.driver_data = (kernel_ulong_t)&m10sec_d5005_ops,
 	},
 	{
 		.name = "n6000bmc-sec-update",
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 988f1cd90032..bc9fafcbfe37 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -40,6 +40,37 @@
 #define M10BMC_N3000_VER_PCB_INFO_MSK	GENMASK(31, 24)
 #define M10BMC_N3000_VER_LEGACY_INVALID	0xffffffff
 
+/* PKVL (retimer) preload poll control register, in system register region */
+#define M10BMC_PKVL_POLL_CTRL		0x80
+#define M10BMC_PKVL_A_PRELOAD		BIT(16)
+#define M10BMC_PKVL_A_PRELOAD_TO	BIT(17)
+#define M10BMC_PKVL_A_DATA_TOO_BIG	BIT(18)
+#define M10BMC_PKVL_A_HDR_CKSUM		BIT(20)
+#define M10BMC_PKVL_B_PRELOAD		BIT(24)
+#define M10BMC_PKVL_B_PRELOAD_TO	BIT(25)
+#define M10BMC_PKVL_B_DATA_TOO_BIG	BIT(26)
+#define M10BMC_PKVL_B_HDR_CKSUM		BIT(28)
+
+#define M10BMC_PKVL_PRELOAD		(M10BMC_PKVL_A_PRELOAD | M10BMC_PKVL_B_PRELOAD)
+#define M10BMC_PKVL_PRELOAD_TIMEOUT	(M10BMC_PKVL_A_PRELOAD_TO | \
+					 M10BMC_PKVL_B_PRELOAD_TO)
+#define M10BMC_PKVL_DATA_TOO_BIG	(M10BMC_PKVL_A_DATA_TOO_BIG | \
+					 M10BMC_PKVL_B_DATA_TOO_BIG)
+#define M10BMC_PKVL_HDR_CHECKSUM	(M10BMC_PKVL_A_HDR_CKSUM | \
+					 M10BMC_PKVL_B_HDR_CKSUM)
+
+#define M10BMC_PKVL_UPG_STATUS_MASK	(M10BMC_PKVL_PRELOAD | M10BMC_PKVL_PRELOAD_TIMEOUT | \
+					 M10BMC_PKVL_DATA_TOO_BIG | M10BMC_PKVL_HDR_CHECKSUM)
+#define M10BMC_PKVL_UPG_STATUS_GOOD	(M10BMC_PKVL_PRELOAD | M10BMC_PKVL_HDR_CHECKSUM)
+
+/* interval 100ms, timeout 2s to trigger the PKVL EEPROM load */
+#define M10BMC_PKVL_LOAD_INTERVAL_US	(100 * 1000)
+#define M10BMC_PKVL_LOAD_TIMEOUT_US	(2 * 1000 * 1000)
+
+/* interval 100ms, timeout 30s for the PKVL preload to complete */
+#define M10BMC_PKVL_PRELOAD_INTERVAL_US	(100 * 1000)
+#define M10BMC_PKVL_PRELOAD_TIMEOUT_US	(30 * 1000 * 1000)
+
 /* Telemetry registers */
 #define M10BMC_N3000_TELEM_START	0x100
 #define M10BMC_N3000_TELEM_END		0x250
-- 
2.55.0

