Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE66C126F3B;
	Tue, 10 Feb 2026 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770707997; cv=fail; b=GavsBcW11iGcEgSFv7pOxVU2xtELVBbrcHip8OCH2Kmb9AxPcO4qQvsP+PW9UWVFALp9q5Ws8akykHqSUfzaj9JKLuimkxsF2aqcSdrdGMZSDPvkR/6Hb133PHYl9ecL56Cyxqcyi41bK6/jpesJZ5DPx98Z2AltGMPYbtsCUK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770707997; c=relaxed/simple;
	bh=QJdY78XRfF4Q87HfdSsi2u7u4uRJC6k7i8oBAYHCCMA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MYxS1X6x8L1f2++VnAwlDxz1jSaXqGfR3qht8r182t7JBpbpJpRk4qGwJ9x0q29y0bbjTvemXAeiHmcZVXvRTd8U7nswDJv5qGiBuA0qwb60OuD+ZmhDrCa4sznmQrrNE0rGV8pw1t+cUBAnnVH++UhwSqBF36pBDiA9bTujHqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qKRgmquZ; arc=fail smtp.client-ip=52.101.46.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qKRgmquZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irCxsTl0nncL45mkjcRxOYlnx/BoSa7ALuCUNSzdQTobhHjVmL/TXu7QmRa29gHDAkm57AJ0snZ7Ce0JCPKvGf1LRedfqQazDw2Y6NfA8eyg9gWrZ8ZbBgZckGIfMkQweljpHFuDJ0ay8bmOzSimuW6/Ajfrlb3KvR/vn6OTxXHhaKNNXePV3lmut50nnYjrQ0NihPhayEOmlig+82SRQAAtCYKTMeZf1W/gcW2a4TNDznuwRXeW3bT0yPhJ6mrCnGlQpF6MOj6n/2DyIT2wnNGJs+CkxkixyLk/gRkS3MWCR6+V7RfFy43P+EdzwzCPk5bEieTmlC1A1qclFdb2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ho0Rd8w1+wOYWWb3ClBK0zy2sCAZGFfcsFEjqEgfESY=;
 b=bwsXI4UvBBxjLt7mjJ2QCrLgFpv8isitwx5QX1fhiyA8edA38M8BH2HGBCFwpNuPA08taL4eWubthSMncruX5X+T7liPny+jM6Rdy1ihuq2n6xoFvR+NllwEet10Pf0iWwoJu1JiPE87AGtDaPZBaWT40cRoCtOjElRWiaO4y88cKSvqCwWo4Vxsbu/wsXsWkAb/h0F4inGdj4p0gWUF0aiIBcwICFU/4uC0YQrCHZcoIcSqGJJvmQIKWZZAOe5kAYoYD9EJu6HbJCCZw6f9pOTVjYXzWkASp5LnK3jwGMRue13B1EXk1a+4aLppkkfDzKlarFuflX9lIWJ0FJp67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho0Rd8w1+wOYWWb3ClBK0zy2sCAZGFfcsFEjqEgfESY=;
 b=qKRgmquZXS2+YV8hPAyxDQc/Lq17/p7CyMIpyUtnc2o0Fb7M1GzrTqyGY1o2TjR74kj8RzFre0l+t+mCugQde1CdzyrC8mqhj/ethJuIqtUJt22U4PFST2yhz07dSqfVTWADJKYY4qQuvo6loRl7//uR4JDi9Ar1hKezYszOQ7GIheudhPxUXvzJya9uY8c5wioEUZQVoiClH4IWuS3KTIUXjd/S0hritP+as/u5cg9DgUf97ccJ+qBSM7x7F/XF+pWwpkTwJ6iK5hU5SYfLtsC+oY+EIU6k284iOrlcQME40+7zfd1W1WEuKRFQiFvCVPVkOewn3l1wOh5cl5eyTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 BN9PR03MB6105.namprd03.prod.outlook.com (2603:10b6:408:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 07:19:52 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%4]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 07:19:51 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	mdf@kernel.org,
	yilun.xu@intel.com,
	trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com,
	Ang Tien Sung <tiensung.ang@altera.com>
Subject: [PATCH] firmware: stratix10-svc: support up to 4 buffer claims and extend timeout
Date: Tue, 10 Feb 2026 15:16:42 +0800
Message-ID: <b67ffe732654c7db86c4b5d987af92dcc12bf4f3.1770706895.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:820:f::23) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|BN9PR03MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4cd079-d609-4a0e-7795-08de6874c80f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTd1cVo4RHlUUDg3TFRLUldRcnFQa29Ra0xsdi9VU1oyMjBmMFNYVlZjaGZh?=
 =?utf-8?B?V0FpQnpWV0xIYjNhZ05oSkprcnc0WGpaSDZsRGxxKzZXM0hHSmlFUThWamFQ?=
 =?utf-8?B?Q2d5Z2Q2bHNyTGkyVzh6YldIK2U5aVJhTFlpMldvcnpVd3dWZFR2RW9aMTRB?=
 =?utf-8?B?bEFGaldQWEZHMDdRRXd1T3JpLzFROTBlZHV6SStsNExUc0tmODVjUkh2QkNh?=
 =?utf-8?B?MndBRm1wSEF4QVlEWnRMajdZMG54Q3gxdEdUdStNRzUvOW5OeDFxM1UxdmEy?=
 =?utf-8?B?cHMxV3p4by8wMngrUXpGN3hCUGl5c0tEWkxtdXJibFhGTE1OWjNDamp3WFIx?=
 =?utf-8?B?d2YzcWkwU0laMTAxTWg3RUR1TXNGcFFlUUlBdzJROEF2Q0h2NjJieFk2Lzg2?=
 =?utf-8?B?eXYwa21HbTZCMTFHSnFDaW9CSkN2bTNIcS80NEVienZJc2VvbjJKY2xYUFh4?=
 =?utf-8?B?Tm5SM1dTeTRVd0xERURlTkNvVTZZMVRrbEs2Mkd6VXBPWkZYbVgxaHE1SXIv?=
 =?utf-8?B?eXd4ZUlSY0krc29HdkpMaTlMWjNUWnFrWjlzY0NEV1FlOVBSRmY5YUNocXFu?=
 =?utf-8?B?eXg0Z0h4cHVEbmNrdlFldGQvLzJUaWVSd2ZxSmpFelJpdkVPeWNnMXk5T2c2?=
 =?utf-8?B?aHpuNm9abndaWitrSWFJbEdrTk1BaHdmaXI5TkJoQm5jOU9vYThRTUF2cDBJ?=
 =?utf-8?B?RkV3enA3UTVCbXhQdEVFVThzVEJhcmVPT2NwMHJHaEJmTEc5dHNjaFJZTHNH?=
 =?utf-8?B?V3lIWEgyV1c3bFRJQXhVVC9PcEpiMEVENEVkWllxSkVDeGN3YUJyUEwreHpD?=
 =?utf-8?B?cXYrTVBWMlhzYWF3OGhBeVEwUHVPWDlHTk9Dd0tkelNOTXBwRFZrZHpJci91?=
 =?utf-8?B?cmI1K0NoUWNjclo1MnZOSDEwM0ZCb2E5M1hpVURjU1d0UllHenM1RkMxa3BV?=
 =?utf-8?B?T1hOVGdDbXMrU1dvbXNRRHVIYmEwUmg5Y3dxOWc1akNGdnBjRUtlUUpZOTlQ?=
 =?utf-8?B?OWFYWFJNRzlkN3FoendyT0NRVXY4WWJ2L25Nd1JENFBiOUp3bm12VmV6UFdr?=
 =?utf-8?B?UEd2Ri8rdzVRQVhDb3VpREloRUxEeVNkdEtEczhaUDRGZ1lFZ1hxRWFZM0JE?=
 =?utf-8?B?SElHMUx0U1IwYWlZWXVnVzRiMGttcWdkaGtVVU84MkwvS0c5YVpRZldaeWkr?=
 =?utf-8?B?cnAzM3FxanNsNzhWOEFMNmpKYi9qTzZUeStYSDFQekMrQjQ5ejRuK0F6K3lE?=
 =?utf-8?B?MmVBamZrWEVieXZlRmhKNXkrdHgwYzFWRFpLUUJ5WXRCS1c4R3A3Yy9sdVlO?=
 =?utf-8?B?bHl0eU1Yc09oNmEwd2NJZ2FRNEh3ako3T3hXYkdnWkRMRFR5Q2p3KzFBcGdG?=
 =?utf-8?B?c2FoV1E2UEZaRjNEcEdFZjdzaVJmeU0zdElsMEErek1idFY4QzBzWk9ndm1J?=
 =?utf-8?B?N0wzRnM0R29ObEZ2Y3h1RDBzbGNlR1o0Z25GZDZLMWJ6SmZmT3lDUElHOG96?=
 =?utf-8?B?UXpXamtqSXVFdUZ3dVEvNUdJTWIzNEcrelhEb1JXWVBRU3d5ejhuRUowcWlR?=
 =?utf-8?B?cUV3VWM2WStud0tZSWMyZnVvaTJEcFRiM0kwUzFtcUtvS1NFMUJaekwyNEtB?=
 =?utf-8?B?NHZaV0s3QXh3enlacHJYaFErc1hET2dNZmk1RXNIajE2Lys1bFQ1aWNxaHpX?=
 =?utf-8?B?RTc5VENoQTU5ZGJzWC9vMFFIeWNUYkdReGVWUHIwcXFjeGJONjlKVW9OREJT?=
 =?utf-8?B?ZkZRWFJvMDV1UDZCME9LeGNuNHFyWWpxWEJadnducXJxNXRML3krTGtXZFd6?=
 =?utf-8?B?M3NLWjc0K2x0MHFDVU94bndEWFVXVHJ6cHRjM2N0V1k2Rm5JWHpXc0RVbzFH?=
 =?utf-8?B?MG9ZYTc5QTJsajJYcWt3WVh4OXQxa3l6cjNiZ0VKMTBMM09yRnVRSnVLdVo5?=
 =?utf-8?B?cHoxSEs3YlEzRDl2dTZxU3A4KzYzVXF6bkxaQmU4N1VEUGpLR0cxVUUyNFVC?=
 =?utf-8?B?V2gvSlVCb1pvNlA0YWlPOWNrOUlIdTdxaUlFSWtZM0dFd21ka0RKWmkrM25W?=
 =?utf-8?B?eEMzYmxtcWF1UUF6REV4Wks5VzBxS2tRQVhJMTdVdUNDeTVHKzA4R0dGUlF0?=
 =?utf-8?Q?Xr9o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm5YclFRYVRJVUVJMXNWUmFWM3hxbUM2eFpBNUJiSGpzY2ZETjZubGJBY0ps?=
 =?utf-8?B?K01mKzNYbTVXWHRaUUU0NkdoMVk3UXFiUlVKSkhkdkhOUEV3ZXczV2kzUTB3?=
 =?utf-8?B?bkZmTU81UEN5U3cwVVJNRE9WRmhBUk5EN3lvN2FPSEk5bmxtcXNTZXllMGNo?=
 =?utf-8?B?cTl1QXorRGQ2N3pkQy9leDBzS1BqNmdCdTVFUm1Qd2Q0U3Q1TWM3cmc0Zmh2?=
 =?utf-8?B?MkNKaW1uYi9XR3BsdU93R05reTNEQ21uV3dXRFh4RkNndU1ZT0JhcXVRS1VW?=
 =?utf-8?B?WXoxL3RkMjdibEQrZEZFVE1YQXB6SzZsUE1BekRQUDBhS2xwemRQL0NWR2pQ?=
 =?utf-8?B?VXozaVFKZUZWTlBuVVFCVHhUZGpzWmpzeVdReGJwTkdMczlwOUZPLzAwV1B4?=
 =?utf-8?B?MHl0UG1zekJUc1BEbmdCMnNYdDYvNytWUElDVHpQWFVZQTMxQVVLM0dJcFN0?=
 =?utf-8?B?NHI2WEUwajNxZGlWdGt2MFNMTGNLblFnU1BQVlYrVEtSd3ZvemxzTXJtMFo1?=
 =?utf-8?B?b2drd09CZDdDejRUVDVWM0FFeUpKMjNFNUNxdDNWRE5RSDVoakpqeTljTSsv?=
 =?utf-8?B?MkJWSVN4MkJYR1VRRXh5YVFUMHJzWTNRK3RoeXRyQnZaT0lZVDhSRkFwQjZB?=
 =?utf-8?B?M2p5MDBRWllFR2Y3RFJuMWhoSGhncXFXUVlxeU41dG4rNTYrNWgzMFZETzFM?=
 =?utf-8?B?RXgrbUVGV01TMmJIcCtiRStJWGtGUGtYdy9zQUlYSDhNYjRpYWJISXRWOE5n?=
 =?utf-8?B?d2xCQi9hVnRKRGRaWGZwTWJkM3pyUWJwdW1jWmdVLzFEaE1RM1lOZExVWkhD?=
 =?utf-8?B?VTR5UnFLMU5peUFINW9jM2hoaHl5cmJ3VEpRZmZLUGFwdDBYM25zSEVpRHBP?=
 =?utf-8?B?d3FNekJtbUlvdUdodEE3UFlGYXZEbzB6a1ZlTFhIYjRxYWRiTDQ5bzNuU1Fx?=
 =?utf-8?B?bTRIQ0lrakRGUzBHMVU4cU5xMG9RMlBuTWgwTjRaZmtFVlcyNTBtNmllRnpY?=
 =?utf-8?B?MG94UjU3TUpuTDdIWERXSnRscVZ1ZXhYZnhYWFlKMGE0RktpWC8rc2FjNXJB?=
 =?utf-8?B?TWwwbXNLejhWK3U2eFNxTDBWWEF1MXhRVTJ5VjFtRDBtV1d1aDVyRGpIWlh2?=
 =?utf-8?B?RDhBOEYyQTZ1QnlzSVJzUHdVTEdLTUZEVTdwY2xYWDlWZlNFUWZlOWZSalJV?=
 =?utf-8?B?a3RZTVBwbjB5WUtzZU9JTDJvU0dVdFp6Y0dOd2xlZDBUcTZoMUxuREZvL296?=
 =?utf-8?B?VW1EanpNMVpsNHhZMUFHZ0tOcXFpTG94OGpxWk1pQnlhZk92eXlSbVRHbWoy?=
 =?utf-8?B?UDJTV0VhRXV6dHlyU1VpcmdEMmovYVVncDZ0Vm9WRnJJemJHNHNvYjVCUGRZ?=
 =?utf-8?B?cnRlYndET3F1TlV6Q3dRcFc3aXk3bnFydDNXemk3YStjK1lQRlVwTUswdDdq?=
 =?utf-8?B?NG1YeS9wYVVjVjF5TDNqMkxUV3NCUXdmRHNqWjI3TUpQUVdwZ2FrUmpURWZN?=
 =?utf-8?B?dHBPa1dVbXpRNDlza05YNW5vMUkyb2c5UXc3UnIveHYzdkhvbmlGN08rTVJo?=
 =?utf-8?B?NXp3azc0bUxUTTNvdkNUU2lTc2VPcHFuaFkrWWdqQ2dDRklGS0FxRm5tdDhZ?=
 =?utf-8?B?b1p3WmI5TVRhU1ZQNmJycW1oYVloQmVBTEVRL3dvRzk4UUhCbWVJQWdNRjhQ?=
 =?utf-8?B?blhkc3FJVzRNeVhJblgzSzBxdE1KUlR5dk9GbGZHMG9aS2lURFhnUFh4dzhz?=
 =?utf-8?B?QjFZZXp5elhQbVRZZVh3dlg1M2xzN3R5UURmMUE2OXRFKzFCd3NEYmtVMXdr?=
 =?utf-8?B?Y3dWdDNrdlk2QWFxcGhsb2kxWEQ0R0RZWVk4Tnh1MmNrcGtuenZwbWh1WEVL?=
 =?utf-8?B?Z2U1SU85U0dJcW95Q0RQMmozR1hpVGoxY0x1UkxVNnh4ODM4RmQ0RS96N2t5?=
 =?utf-8?B?QUlxUU41QlRhQ2hVeVR5ODUyRm0vL2RHb0dXZm5PdmNoRjZPUDAzTUcwdHdx?=
 =?utf-8?B?UXk1NjBKYW9oenU0R3RmSlRHdVJIOFgwTFZPRVlrcUVuSnNqbWhldXR6SHpn?=
 =?utf-8?B?V1hDWENhYkhzSmpEbmNXdG0xaU1kUEVoa3UxdTdOSEVQRU1tUmR2ay9pcTNF?=
 =?utf-8?B?cHkxTXhNOXFDWFlhLzBBYm11VXVTTnlqbW4za01WSXVVWlJ3aVpYVTlPcGJH?=
 =?utf-8?B?WGxtSmY1YVBHd2Q0Nmd2bW1RYkRLcEJGLzF5WHpDbTd4YTV4SDZsMUFhY3J2?=
 =?utf-8?B?WFMzaHNoUWhaenRsRlV2QlhvS0hqZnF0TXFVTVFiUmV0UEpMenN4TjNlckpW?=
 =?utf-8?B?eDdmVGVzeGpyS0V4S3ZubWEvcVdLZ1ViSzVjL1dqRlZQVGhvZkNzREtXVWZN?=
 =?utf-8?Q?Unlbl1VPQpgt7tJ0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4cd079-d609-4a0e-7795-08de6874c80f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 07:19:51.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZn9SRyPlocOzsNWyFECYLaVll5C7PxasLodOY/Xh477XeZV+3GMZj4sAtl/DhjMbsCM4Jr1+ZIBY5H3tVqofVIPrabt4y5ZilSCboZmACw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6105

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

The service layer previously only returned up to three buffer addresses
per transaction. Extend the logic in svc_thread_cmd_data_claim() to
collect up to four buffer claims. A new field `kaddr4` is added to
struct stratix10_svc_cb_data, and the FPGA manager callback unlocks this
fourth buffer accordingly.

Timeout values for reconfiguration and buffer transactions are also
increased (from ~300–720ms to 5000ms), since real-world processing takes
significantly longer (~600ms or more). The reconfiguration complete
timeout is also replaced with S10_RECONFIG_TIMEOUT (>1s) to avoid
premature aborts.

Additional changes:
- Callbacks are updated to pass all claimed buffers to clients.
- Debug logging is added to trace received status values.
- Simplified buffer wait logic in s10_ops_write() by always using
  wait_for_completion_timeout().

These changes improve robustness of FPGA configuration on SoCFPGA
platforms by handling larger transactions and accommodating realistic
timing.

Signed-off-by: Ang Tien Sung <tiensung.ang@altera.com>
Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 drivers/firmware/stratix10-svc.c              | 36 +++++++++++++------
 drivers/fpga/stratix10-soc.c                  | 18 +++++-----
 .../firmware/intel/stratix10-svc-client.h     |  6 ++--
 3 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index dbed404a71fc..58cf68d9a384 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -342,6 +342,8 @@ static void svc_thread_cmd_data_claim(struct stratix10_svc_controller *ctrl,
 {
 	struct arm_smccc_res res;
 	unsigned long timeout;
+	void *buf_claim_addr[4] = {NULL};
+	int buf_claim_count = 0;
 
 	reinit_completion(&ctrl->complete_status);
 	timeout = msecs_to_jiffies(FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS);
@@ -353,20 +355,32 @@ static void svc_thread_cmd_data_claim(struct stratix10_svc_controller *ctrl,
 
 		if (res.a0 == INTEL_SIP_SMC_STATUS_OK) {
 			if (!res.a1) {
+				/* Transaction of 4 blocks are now done */
 				complete(&ctrl->complete_status);
+				cb_data->status = BIT(SVC_STATUS_BUFFER_DONE);
+				cb_data->kaddr1 = buf_claim_addr[0];
+				cb_data->kaddr2 = buf_claim_addr[1];
+				cb_data->kaddr3 = buf_claim_addr[2];
+				cb_data->kaddr4 = buf_claim_addr[3];
+				p_data->chan->scl->receive_cb(p_data->chan->scl,
+				cb_data);
 				break;
 			}
-			cb_data->status = BIT(SVC_STATUS_BUFFER_DONE);
-			cb_data->kaddr1 = svc_pa_to_va(res.a1);
-			cb_data->kaddr2 = (res.a2) ?
-					  svc_pa_to_va(res.a2) : NULL;
-			cb_data->kaddr3 = (res.a3) ?
-					  svc_pa_to_va(res.a3) : NULL;
-			p_data->chan->scl->receive_cb(p_data->chan->scl,
-						      cb_data);
-		} else {
-			pr_debug("%s: secure world busy, polling again\n",
-				 __func__);
+
+			if (buf_claim_count < 4) {
+				buf_claim_addr[buf_claim_count] = svc_pa_to_va(res.a1);
+				buf_claim_count++;
+			}
+
+			if (res.a2 && buf_claim_count < 4) {
+				buf_claim_addr[buf_claim_count] = svc_pa_to_va(res.a2);
+				buf_claim_count++;
+			}
+			if (res.a3 && buf_claim_count < 4) {
+				buf_claim_addr[buf_claim_count] = svc_pa_to_va(res.a3);
+				buf_claim_count++;
+			}
+
 		}
 	} while (res.a0 == INTEL_SIP_SMC_STATUS_OK ||
 		 res.a0 == INTEL_SIP_SMC_STATUS_BUSY ||
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 0a295ccf1644..4fea9458f92b 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -147,6 +147,7 @@ static void s10_receive_callback(struct stratix10_svc_client *client,
 	u32 status;
 	int i;
 
+	pr_debug("%s data %x\n", __func__, data->status);
 	WARN_ONCE(!data, "%s: stratix10_svc_rc_data = NULL", __func__);
 
 	status = data->status;
@@ -163,6 +164,7 @@ static void s10_receive_callback(struct stratix10_svc_client *client,
 		s10_unlock_bufs(priv, data->kaddr1);
 		s10_unlock_bufs(priv, data->kaddr2);
 		s10_unlock_bufs(priv, data->kaddr3);
+		s10_unlock_bufs(priv, data->kaddr4);
 	}
 
 	complete(&priv->status_return_completion);
@@ -309,15 +311,8 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 				break;
 		}
 
-		/*
-		 * If callback hasn't already happened, wait for buffers to be
-		 * returned from service layer
-		 */
-		wait_status = 1; /* not timed out */
-		if (!priv->status)
-			wait_status = wait_for_completion_timeout(
-				&priv->status_return_completion,
-				S10_BUFFER_TIMEOUT);
+		wait_status = wait_for_completion_timeout(&priv->status_return_completion,
+							  S10_BUFFER_TIMEOUT);
 
 		if (test_and_clear_bit(SVC_STATUS_BUFFER_DONE, &priv->status) ||
 		    test_and_clear_bit(SVC_STATUS_BUFFER_SUBMITTED,
@@ -353,7 +348,10 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 	unsigned long timeout;
 	int ret;
 
-	timeout = usecs_to_jiffies(info->config_complete_timeout_us);
+	/* The time taken to process this is close to 600ms
+	 * This MUST be increased over 1 second
+	 */
+	timeout = S10_RECONFIG_TIMEOUT;
 
 	do {
 		reinit_completion(&priv->status_return_completion);
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index d290060f4c73..abe04f4fad1d 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -68,8 +68,8 @@
  * timeout value used in Stratix10 FPGA manager driver.
  * timeout value used in RSU driver
  */
-#define SVC_RECONFIG_REQUEST_TIMEOUT_MS         300
-#define SVC_RECONFIG_BUFFER_TIMEOUT_MS          720
+#define SVC_RECONFIG_REQUEST_TIMEOUT_MS         5000
+#define SVC_RECONFIG_BUFFER_TIMEOUT_MS          5000
 #define SVC_RSU_REQUEST_TIMEOUT_MS              300
 #define SVC_FCS_REQUEST_TIMEOUT_MS		2000
 #define SVC_COMPLETED_TIMEOUT_MS		30000
@@ -222,12 +222,14 @@ struct stratix10_svc_command_config_type {
  * @kaddr1: address of 1st completed data block
  * @kaddr2: address of 2nd completed data block
  * @kaddr3: address of 3rd completed data block
+ * @kaddr4: address of 4th completed data block
  */
 struct stratix10_svc_cb_data {
 	u32 status;
 	void *kaddr1;
 	void *kaddr2;
 	void *kaddr3;
+	void *kaddr4;
 };
 
 /**
-- 
2.49.GIT

