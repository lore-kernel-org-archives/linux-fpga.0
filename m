Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27490230BDB;
	Thu,  2 Apr 2026 00:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775091564; cv=fail; b=XaiS6Wn4MJJ7eBsziT5fhvM2sDTg6poaoKMHZxop0JEWuHv9yRZdzQGoHMfhQ4gE4NxvsOVcjKoWS6vT2QSXqWIHvTBRLCaEsHJpixHenePqQX+bJwVJLLutniYewlc5N/TFHeqs7GPBEC8d9OG+cwQ9dHxFnXyjo77sbCWy7pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775091564; c=relaxed/simple;
	bh=smsW+g6SlKziIL3qgbhQJ2bH7hHV4xyW03cqJnCCXwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i2eoCIzYL25iQN4+1v2bKlYRHfQOTMaBHUYzHwgZAFo4I8MLacw4Dl5yQ2dYsOOZNhka63hVV7RQ1J0lm/EQEgc9/0Jfcge38mHyY+Zcx8a8P56RBphfy6g98VgPREZ/u5GCehkU9h28v9Y0NXWSstNi7kdbhc5LMtzpmTAYf/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rg3uVTT2 reason="signature verification failed"; arc=fail smtp.client-ip=40.93.194.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rg3uVTT2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD0JxQTq5WxM3IpmbOJHxwTZfS4N5Xa0Rl5Eex5GvkeRRrrH9lw+LmTorjSfhLkHglcD0tm67/hLJH+lYh8YbK8dvsJZxqJi/u0lHcCIr9MDKRu5hlVhcQUbjJT8Es+NQPb2X2TzZ2LVxUB5Mkar5KrFdsBDS1oFR6i10CpHTAomjCaRolFKYUm98+0fHyTo6rADlLzmrRH+67L6nHI6o6v7hRGJeBuFnOB5JfnugBfVS90xZEqPZg5dRgsXjbFZfsdjpaySSi+s8SUhZbd1jG48Iph3T3w1JV4nkqWuO0RzI3S8VXXrZzY0LUBLXWmjvSAxNFLGdEVBIAtdTU+QWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ifn36VFfyzXSvTV7efGqmjR0xXkb9bUu8w+GaSSol28=;
 b=Of/39V7SReDMD9q0RkgdFUwBT6qomJL3otPrvt9uNvss9vxinpi8GdIgd/wtTPjzfERBJYPO5xXsydaICGr3LoRkNvsTzcUWXtM6Y1APVvEQUWvVVgJKzBYMtsMWlV5l1NwkuIAjUzwhZtj0lIsSmVWwUZ1ycAOrAiOPBlOCB81OR6nyopwBa/Aa8iB2AreCOR+BVOGrvr3ggT6WJxVA44U9SrzOAz6bGVNH7TyLUacp98A1EhhuLvDUYMuwpm2DPwX2sPIYO3AFUSOPuRCxEiNqc3ylEKXZms2xcPFQUIyilVp0WG67j5skCZA825f2LBp7UXv55lL98pOmba6CZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ifn36VFfyzXSvTV7efGqmjR0xXkb9bUu8w+GaSSol28=;
 b=rg3uVTT2GKR9dHQ5twLUudHh1QTUY30GbBy78ToS/94D2X9eYKAYJgBT2PIScVyGvAyRBbXvFM69BquX5EFblUCYuMxAZWOgJCWLD9Ww77zJVnkLWeSXwIMfuqkqtpo+1fLW4ADjVtwnHL+ptKV0OhN0eXr643HWoxEnTk1nyWB2tehmNIDBUThIWgsNqN2LX1BAfM7x10FH9jxLrGNTW1do5xz6ouKdGM+OrQAY8X/dDZDSmECtACPq3lwRHgy6eEdQuVyOSAVzeu3FvzVAoW+zO5MAz10/gqK01hqQ+fBCGGVyh9dR4hb7EoETZelycauCS6/izLOdL74x7Aza1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 00:57:58 +0000
Received: from CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9]) by CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9%4]) with mapi id 15.20.9769.011; Thu, 2 Apr 2026
 00:57:58 +0000
Date: Wed, 1 Apr 2026 20:57:55 -0400
From: Yury Norov <ynorov@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Suki K Poulose <suzuki.poulose@arm.com>, Tom Rix <trix@redhat.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Xu Yilun <yilun.xu@intel.com>, Yury Norov <yury.norov@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH RESEND 0/5] bitmap: cleanup bitmaps printing
Message-ID: <ac2_EzO-uCaLqTlg@yury>
References: <20260303200842.124996-1-ynorov@nvidia.com>
 <abxaIMi55N4X9JWz@yury>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abxaIMi55N4X9JWz@yury>
X-ClientProxiedBy: BN9PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:408:112::9) To CY8PR12MB7171.namprd12.prod.outlook.com
 (2603:10b6:930:5c::20)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7171:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: fc516c93-9f93-4211-e3ee-08de9052e1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cuGDWBX4a/9oiYAILesXGogd+8k5Lijg5XS/2H2TuDsFQVqDSpttZR6hU0yRUL02NqY53K1lDqSlBLG6if9fhuXvzUyJImsZIajBOVctOStZccDayzL1anxYuC5lxUmJ8VG0i/ApuT226bdFjHGX9u0XV9aymm3sMjjvHYmz1YiQpDxcmQPklld0a42VncZBmq8aoGMeshXcZfWafnvImOqFNkYeG57z/hlRPay5fn8Z6HFQz621pvgUVAIauDgANgYLSQ8kpUly9eqLanZq0iuugZAMBOzDFO/xNlpAAoeqL3i75U+YEa+FPUmUhEOjhxsBBu6reLtRz6MbAORLT1IO3ptP2aTR8wrKkcYJZ0IPZSfWOqEJH973ysIJNdNdKqTUOkL56Rqk8vIv0hedXKUJF8CjUXhNidFCAtQTKcGFH/A7X0puKrzgIEs0hcVKpVwW3Q2BNk7yDEs+D9O0x7ozVYR5GMLtHbuEC7gjNxabiBnwdTr/j69bqVa0Q3D6ZX130zNSDlttPMXoONHdS6X77a8pc247zLyFWvnuyTINrqE1Uykhei6YcMTnR8ti6QDEzCBZpqwMdWnXsiVSaqZnpx7urZ9wV6rRhg19mnEiMF0DyuTeiBzKW06LK4fssTWkw3ul+UjJ/DUEO08j80oWf+VJMy/vrSdsP/7/wXYZmXRmnsN0P5KPV1SGOs5fKk7VXrGuUtLH47X85JnLSabuKwglvCmpFnUp7ofaQUvD3cv9tcd/JpgWg+ZYn8+pUZRUJqyt0xs1Q752eRh/AqV+qP8thsvvO1L5sOPc3/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?7WjV3WGDb5+tvquAh5XrZW7Vc4EdNLVIJBTkSYGzuSxBH6XP22zj7gc2id?=
 =?iso-8859-1?Q?KcaanR9+4PjS44fMVX0WT2SV2O24lYlZtjOgCi1lIIV67eRYOQiSLjPwYH?=
 =?iso-8859-1?Q?0DTjhGyzm3OkICD3MgUk8AERW0r7wINI/rNaxxcJ3V0O4DcL/IoYIeIHT2?=
 =?iso-8859-1?Q?vXgHiTrvlnxO3FRPeFP8GgibNZz8M5fTpBPis3PrY+/yM2jRva1dZQJs5t?=
 =?iso-8859-1?Q?TAwQ95l3KKUkkDkDAlTus0HMO4RbvK3+CPp6pYCOye0nTkMOorTyQdVPVh?=
 =?iso-8859-1?Q?YarJH2tp3NU8DaAhDxoo0MmxyV2UD6E1eOW3pw7gUsaAL5W/P3kfPYJhdf?=
 =?iso-8859-1?Q?d7pUS4qhizCcmHz2OR0qYXV9KKPrioqljSmfCVJJx+2q/FTIe9TeSaiaSV?=
 =?iso-8859-1?Q?EicOH8IYraKOJ1WABD3V67a4pc9NWCPkHHVwmEOBhFMzWdVZ3jV3ZPn/jH?=
 =?iso-8859-1?Q?CIT6qjElCJpfDTHx99/ewT1WLx+fUni+r2t8+ZbwguY8rPD2WsCXnbVrci?=
 =?iso-8859-1?Q?udO6v6iEmCS22xgn7Z3B8tLSxn0KH0zozjJmdEmOByoOhsk0UAyTtQjqAt?=
 =?iso-8859-1?Q?UPokiyNd9aFC0w956atr3bnxueYG8LsMQGzoOgePCGif7I0l4SAIn6gIfi?=
 =?iso-8859-1?Q?PizfISwn9mulZRpXcC6K/vo3lU3GBOCT8kW7ieuMfxSiN7lM4KpyPsChdu?=
 =?iso-8859-1?Q?xR3gSWCbXNvee8pdpXR8oB5nmwqLGDI8oxPz0qL4Ij+C5zr2kl7s6fu//B?=
 =?iso-8859-1?Q?r4rFea2+x0PTjP8f45TO/tSfYFr/t7v0MkVO3Wb3byE2VbNyuPCwPsgOs6?=
 =?iso-8859-1?Q?Er4X+9MBt0gbiDM0sE7exDvDWi7MwnPczYnnPWBuzNLp+CDVgWYgRtKYPh?=
 =?iso-8859-1?Q?vQBsBJc5WTmibzbwB+cCsIt386TUUi+T/e4yR6JqX8LNZki3pTjKD8R+Bc?=
 =?iso-8859-1?Q?6wYda0CSWWYlzBjGP3D+Mj1OLGrZ6E7Oa1YNG0JYGdgbwe4Da6N+Z/LHpy?=
 =?iso-8859-1?Q?EoFjWpY3wMi9yS/axOqWEKnTS0BDhFIG7uX8d8sV7gqKU0I0Tx/C4PPr1D?=
 =?iso-8859-1?Q?g2keLrAh/y/JedY6WHhxsLl7VeerOEUskbwrQJbctpSGDT0bgWC+lYvcJ+?=
 =?iso-8859-1?Q?FdY/qRniePvo1Aw8i2/AtY7ArDT/tciRPQZGE7TVXdg+4J5cfyn+MnrQP+?=
 =?iso-8859-1?Q?Y3140dnJRm3o9gji/rxovqVYMZkog9jXzQ8jK4hY/VSaMTA+3BQomJ6ueB?=
 =?iso-8859-1?Q?JDTyih3P9Mc6BaMLyJboztoVN4QG1Brqi2Uhy0Vv+Hc21H0ApZMGDaNzoc?=
 =?iso-8859-1?Q?g9d0UjQPg+3ORDsVe4mLRCVH3Z8+I+i4WqXe+ATM5cZx0OinK93EVwhGLQ?=
 =?iso-8859-1?Q?fM736vBARJAPN9EsRVwJsYUQvTNWhcBM/gMSIVYyrXKiFl/QQQh5O4U2tW?=
 =?iso-8859-1?Q?ayICFN2/o5XiM4BhnolKWnbJ3J96N8ScX/hlQW3+MTs3HQdlaZCTUboqls?=
 =?iso-8859-1?Q?7HzH8y9CmbgJlllLldYYyRUmiPDUn7o4G3tRyQF0inbWKFlchyqdedbqz1?=
 =?iso-8859-1?Q?eQD5xWjrPg1mHXpChGq80bw3/aJlI0UdlwyXSIrumAVzhgnVuwo6CwGEDe?=
 =?iso-8859-1?Q?CRkcdQHk/3am4zZ7l2sgwUWayI4T7RQDftS8AAgX3mlS/R3lIF7GgvAxll?=
 =?iso-8859-1?Q?xsRWntLUDoeTsgfImB8im1Y+4/J/9MS/iXGUNqnEL8ecCKQmTfOiwUQUbW?=
 =?iso-8859-1?Q?nRjQgJNCnEyhJ4aylWwcahjG6G6hORApSXbAIXocBSiQCcxB4svNLIx0x/?=
 =?iso-8859-1?Q?/F767MYFm6TtIIJZbGmXbaOYvMBlUzADiAzEApiiDfuFTDPhru41?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc516c93-9f93-4211-e3ee-08de9052e1b4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 00:57:58.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoxwnWxCyFj098z1Yfy5myG4+lceVzdORUFKYLpK3IKTus2N6uO23cQpwIfzcGX0bKQD3TQJU2ZezuilsMukpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787

On Thu, Mar 19, 2026 at 04:18:40PM -0400, Yury Norov wrote:
> Ping?

OK, taking 1-4 in bitmap-for-next.

Thanks,
Yury
 
> On Tue, Mar 03, 2026 at 03:08:36PM -0500, Yury Norov wrote:
> > Bitmap API has a bitmap_print_to_pagebuf() function that is intended to
> > print bitmap into a human readable format, making sure that the output
> > string will not get big enough to cross the current page limit.
> > 
> > Some drivers use this function immediately before passing the result to
> > scnprintf() with no modification. This is useless because scnprintf(),
> > and helpers based on it like seq_pritf() and sysfs_emit(), take care of
> > not overflowing the buffer by itself, and perfectly print bitmaps with
> > "%*pb[l]".
> > 
> > This is a resend of non-networking part of [1]. Patches #3,5 switch from
> > plain scnprintf() to sysfs_emit(), as pointed out by Thomas Weißschuh.
> > 
> > [1] https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/
> > 
> > The networking part, for reference:
> > 
> > https://lore.kernel.org/all/20260303185507.111841-1-ynorov@nvidia.com/
> > 
> > Each patch can be applied individually per corresponding subsystem.
> > 
> > Yury Norov (5):
> >   powerpc/xive: simplify xive_spapr_debug_show()
> >   thermal: intel: switch cpumask_get() to using
> >     cpumask_print_to_pagebuf()
> >   coresight: don't use bitmap_print_to_pagebuf()
> >   lib/prime_numbers: drop temporary buffer in dump_primes()
> >   fpga: m10bmc-sec: switch show_canceled_csk() to using sysfs_emit()
> > 
> >  arch/powerpc/sysdev/xive/spapr.c              | 12 ++-----
> >  drivers/fpga/intel-m10-bmc-sec-update.c       |  3 +-
> >  .../hwtracing/coresight/coresight-cti-sysfs.c | 32 ++++++++-----------
> >  drivers/thermal/intel/intel_powerclamp.c      |  3 +-
> >  lib/math/tests/prime_numbers_kunit.c          |  6 ++--
> >  5 files changed, 21 insertions(+), 35 deletions(-)
> > 
> > -- 
> > 2.43.0
