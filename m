Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792482587;
	b=1d03q/cJJGI37XmiIzNbJCB5pDzrGjI7JxVCKj6GK3zIkt/yXpl4r219pYVk6thwwq/j
	 XbvTc8JP4EDy+zaS1gfq2m2rvfbTiCnEiMwtZM+wFIBNGTrgo+Ud9xKFqbWujYJhG1t0q
	 0Pge0LBlvJ/apO/wJTFyUU1qB1O+UpeRJ3BXxK281neg363MU6R0+wV9ObDe1TQ2BqKUM
	 FKf8SO31h6STF8Y/5+wJkjdyuIx9F6jmSYP4xG3Gxcy8j4RZpJXz5WRV0uhPadcrVKsXT
	 gB/ovFl5BO5+5tnuvRD+QwNAF+qJK0DAwMPR4XZk0EUDVmd+IRdLv1vdovxQhsGYzzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482587;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
	bh=6Im8NPxm4Vw43DIn846tDHeS+vF996MVVA4SvDqXYDI=;
	b=GalJvfmLLNaycnpv3vVdDbYgzkmDCFmpWKIqQtI7P5H2iAYiiOW/z+Dz17bq83bJ9XHN
	 0Ar6AI1jWCZPcXLZlTihwcLBcXzNmAnK9kXEH0aM/4Im7883mzpFB+JXWpq4Q8fI+GkRZ
	 iysqdKY0O7A7cRyOXw/XQZ/telkNcPwiX+VFXeJFztbRGABYARLAEK2pgO5H34xns1c5W
	 fUrfpWfXWoNHNNCQY/TXZE5t7/+uetDL1HxwuAHNJ/T8YnCxZ5LkRN+GdjEKKlUJwGj9u
	 NK7zj8IcLdhW69MiHvXCruDsRspqALeePtbtM7sfWvMh7V0R8+eKqv0SmS/IFNdBzSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=sWJ262Sl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.50
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C86606A31B;
	Tue, 20 Oct 2026 07:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2C86606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=sWJ262Sl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNcq6pPtPKjqIGgW73yF2qF6rUDVLUTag1fMUwDBcDBO4Q6/KDP8bkfOPb6e90tcuYbM1ww3THEbPpXB8S+hHYRpJHeZinihQtt6WU28JstgauM0hG3ePvwne5OdNwYBZZQZN3ARYzJ55paP+tU4NiME3ZDiTFnn//IsL2Rfk5CFJh3gmIJBmFd0+6djQeaZ48OtZgtuarRLQQ+hTvpdsYLB5kwAk7mbc2ddjE1PFrfihzsfQIGC+NMqak+k4BS+vQPEkusD1SHjvSSrko3EYfBIPNj5yfkmbss25wq+vlAg2Kaq13B9zyJcEoCbDsUO0stT1omrb1Sty6LbdofdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Im8NPxm4Vw43DIn846tDHeS+vF996MVVA4SvDqXYDI=;
 b=RO2MpxjVmlUuZqCRFhoAR8J5bH75Ll9Nh5+LbNsvz+kbEsH3zopVLzA7b6cfXDAT4eaQnQDgZPmVsDbC+DYbCtsbyPQXVhYLUHYf292ThoSRB2ma4nMxjtZBbGVO5A5AJKcOI0eN8mklGCFlsoXNBGAuAqstDKV2tDs6TSmRP/uFz5w+np9RWPKRxR//+3ydzjIj2/cGfnRO1T3XAS8MjqjSMSLQEdtwVpvH6D0Y3tTVvpwmy/DndGHUwB1meRUZ+Z8S9mgQO+3HjIrLTCgRfXHyUZ3scO9xaj0VRNgpLayweIybPMbn7aPWhl6B2ku9kCyJnF9nga7+h4XdEJ5yWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Im8NPxm4Vw43DIn846tDHeS+vF996MVVA4SvDqXYDI=;
 b=sWJ262SlxHcZznAnR1DeproIy3eWxlsAeS0V/nufxpoWyhGQVINtYGc2Xd2ym7LFzsRl06KCEc+qmkIoyax/wqfK5aoOnjjxRd0Cu0PTNJrRreKuLZXccnowexopsSjmw9tTEvhr41oEwIRiNbIcdzEuwf2YwI6nf8Hp8ePtgbOmukIKEqXJV777HmyvPYjFfoqQy3k9eNK3ELdGfL3aRnuv5B000hG933qg4+gjYB1OWclZC4ifAF5Na6Kv5LNT7uzJdA/l4D5Pbfoigs0E0i8f/QyDl5F1+fgY5qnArSzIcmD2aMYtm1WGga+cfeOyNdJXvDr4nZj+vk5mTevWcQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12)
 by DS7PR03MB5382.namprd03.prod.outlook.com (2603:10b6:5:2c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 07:49:44 +0000
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80]) by SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:49:44 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: mdf@kernel.org,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Subject: [PATCH v3 0/3] fpga: stratix10-soc: harden wait, ERROR order, and timeout
Date: Tue, 20 Oct 2026 15:49:29 +0800
Message-ID: <cover.1792480395.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1790090287.git.adrian.ho.yin.ng@altera.com>
References: <cover.1790090287.git.adrian.ho.yin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:295::11) To SJ0PR03MB6581.namprd03.prod.outlook.com
 (2603:10b6:a03:393::12)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6581:EE_|DS7PR03MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab1617a-3cd7-4737-c7af-08df2e7eb483
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ognXsiA4ciTxI1WTXNAYs0fzoySo2ogmvauvuxeveXKZN38MWK2E1Lg1VhUf5SVyKteBCue2HgMBO1tIMDkH6TRd3M57nmTaHfldFXU+HMPeu8xIun7nPYUsuy8/thnPW0SFySKU3L2P476ZcUplhMqD3Ld1ybu5go4epiKRyvoRu2rKSRUkWLAykd3amYOCDWRMEjSdf5RPd1ajpR+JNUEm+fbFzAVoISAA9R5lqAuax1ffRyZoYkZHJosY8+Q590oDAfl2DxhICer5ry0XCxubmVMTGhOOeYApRPpx3pe7SrXPEllIi7izselSdvG2/lD5YIt3A1HuPXV6Oi4RRtlkP07Bxv3gqvNk/1pShntLcnWrEtig1Z5Fu3B5oGa5mreCe2or50lNvxFPUijGyGIGpoO3+VpFMDE/XECrFIRn6uqAQ+MZj5z1eJl0qmXyJplqAlG73IYMe4uqF8Rxt5mKAcTJoGE0nYK0YY3VK7nVIEplLIigIGJPQcBap+dbqSH+CGbLKoeScsuDlC+KC22SBaF9FjNhZ3Wg8BRQNxqjPmomCZp/zyPB5PCZJDbycTeRa05CI2GpeDyW401v9JCfaN0xL3LUCCx1cQ6vZOV9Fvc3ME2cdqLgAVs+erYSi3r34EnAkSdY2x7yH8zzz/dNVH/JRU/A6g7gce6d+OA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6581.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6HBy4HAoLH2sX1rMAoW4s78ZYUhcqnO/vrlxcb6oLXDMQXc43jEudnC5ebj?=
 =?us-ascii?Q?1UpXxz1W0vmtYGSQswwjcAnI+yJrpJ+cfak8adf/xFrIeu74sA7W6nq/ceH5?=
 =?us-ascii?Q?lp/2Z2xE6JYA61zFInVIcqLSatQmI2PuDt1gi0EaPxeNtZ6U8a1L1Gnpi0Uk?=
 =?us-ascii?Q?gZHQVCQICT6qHMzilIaAzxtVUOH8d4VeG8EH0TEmOZFa4G2nqnbcMAYXmlIy?=
 =?us-ascii?Q?n7KpJALNzl1v1xDPM3ObkgDxjfxKPssfRF6jRZgXz4w9DD3dyqxCEJDCy1km?=
 =?us-ascii?Q?YDddHffRGvqeW2NqUckSmIkVp9+nqK+SN0teVU3NacWrX+/xasPn2bUgNd1w?=
 =?us-ascii?Q?XT/xj6/YaIimj9dqbgR3yOiPRIuHhww1Oc0Wh8VFKSLaomghvNixGH7mwRJ+?=
 =?us-ascii?Q?tFTyZmDcuhpl4NCwnj8ZKzd6MJH1pAOalE+Ji7fw0jrSpPHSxytUq7gAwl5a?=
 =?us-ascii?Q?hD69dwRnF1erXoK2wCpowI+YlCHg5+MZjQRhWFFcIqC1aOGplEkEWUEqTqHQ?=
 =?us-ascii?Q?ENVmGaBLbtryYgr0rw0cBXeTMbuKqMt+zwmCgYIm+a3m8S3oBYailBt41UIV?=
 =?us-ascii?Q?d0x88rEaKC4SVSO/jI7wjqkJETI21hx7+YC4LfOqIUi1HVp5DR0j0z/RmNci?=
 =?us-ascii?Q?e6m7c+wkxtJwkCvvi08P27RTBTjCiKwWJQXiOEr/OfGpM4x523Ujp6PRkWoR?=
 =?us-ascii?Q?cITz1ajhH4lKj8gpHd5W2l7WJW/f9KOT9htFYQLEz3nvCGo0lo3jdKO/YgNR?=
 =?us-ascii?Q?Fo+kor0G56uA213fkF9k3hiB68xMNYTAiO6jJT9MFa7lvpo3f6jdY2rbmR2F?=
 =?us-ascii?Q?Q0x33+3k4sZGQSKT9C54whISRYfTGiNiXp42M1kWxB6+7aUBy/fVEavFogqY?=
 =?us-ascii?Q?5dBhL2+gwOpMmNsV4lljgKOO7blrjWmlwfp87+9aUEuhSwNK5Lpn3dPoTbhw?=
 =?us-ascii?Q?Py17IxDsI74peOMJRRHSy+Zy5HJZj6M0yxxq++mCykc3yS7q6LUrJdOWmLCd?=
 =?us-ascii?Q?x49YccZNi0+ctSwoRXq3xemkO3EA0ZL2J12srRJ1uezzpBgCVWoHMF7myb/H?=
 =?us-ascii?Q?GnV5cf34qOG91WArmgaBrrCH4YPd3itV9o5WtCKaBli8chi7qwrm1NDTqV07?=
 =?us-ascii?Q?T6cOcyX8USs314Bb2WKagvcu01r0+AdXE3Xa/yVdIku7ISt7oJgI9STxCbfp?=
 =?us-ascii?Q?b5/aEIx28ULZrmK3Wb3/Bs2EdR5dfQ4akRWpuTouLFCwGdlbOJumOxmUz+Nv?=
 =?us-ascii?Q?zt1M5sl2MtXvk59ZTpeOXBJjp/c3ST3mnhQS7i3IyHCSkVUq+FOXq41I+XsY?=
 =?us-ascii?Q?TqAA6FNvUHfDq6g85P5sEm2OJhTOoaGI2HCvXifqZiklO1Yj89W6Pxd/1vNZ?=
 =?us-ascii?Q?uLB4oXntrBGpJQDNbLImkhfNYQIxLnDjL8DzSgF7f1oc56L13GCHzLXRbJmX?=
 =?us-ascii?Q?chqLiH+krbf99QnCf7tN6lTVFUTCkXPMQc5iC7iA4MN27R9yidPLYnWy8J7I?=
 =?us-ascii?Q?jwNKlEDRTyWU2TJWypjKBYXNlp/futyOLShnME8UI69nRjfS2WlCvSi2bI/c?=
 =?us-ascii?Q?vxzyby45krurGuEC+oems6kTkdLxXJ1wtI0I36s8PZyfDDGQTVABS9r0EYRY?=
 =?us-ascii?Q?hhz9lSYdb7Zabqdvqnkj9gk9GbdaJ7fjNB9KZWvepORbYRqxladGXt/iVGkZ?=
 =?us-ascii?Q?q/4KHdSgDWiAy62AJYEQalLxv9x91+hJ0gQJ+ExbtpOsr1BMeR2lA2OjB+N1?=
 =?us-ascii?Q?BKypmp7OntVunHK/qY2jJSSlxm0tIbY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab1617a-3cd7-4737-c7af-08df2e7eb483
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6581.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:49:44.0521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyWIOywrQapQvgi+NUMj1MX8QHIvtYuXXdhqv55F0OHJhKrxLYe3+K0oYQk05VnWGr0HoUDlZxopGO4u3Jpn9Zd45Snq72KWMIYvlgzqYDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5382

Stratix10 FPGA reconfiguration can fail or hang for three related
reasons in the FPGA manager. This series hardens s10_ops_write_init(),
s10_ops_write() and s10_ops_write_complete(). No dependency on the
stratix10-svc accumulate changes.

  1) always wait for svc buffer completion

     s10_ops_write() skips wait_for_completion_timeout() when
     priv->status is already set. Always call the wait; if complete()
     already ran, the done counter is raised and the wait returns
     immediately.

  2) use config_complete_timeout_us as a deadline

     config_complete_timeout_us was passed as the timeout of every wait
     for a service layer reply, so the value 0 that of-fpga-region
     leaves when the DT property is absent fails write_complete at once.
     Wait for each RECONFIG_STATUS reply with a driver timeout that
     covers the service layer's own polling window, and use
     config_complete_timeout_us only as the deadline for re-polling
     after a BUSY reply, as xilinx-core, efinix-spi and
     altera-pr-ip-core do. Because one reply can take up to the
     service layer polling window, the deadline is coarse.

  3) SVC wait helper; prefer ERROR over success bits

     Add s10_svc_wait() / s10_svc_send_and_wait(). write_init becomes
     one s10_svc_send_and_wait() call, write_complete uses it for each
     status request, and write() uses s10_svc_wait() after sending a
     data buffer or claim request. ERROR takes precedence over
     BUFFER_DONE, BUFFER_SUBMITTED, COMPLETED and OK in the accumulated
     status word.

Changes in v3:
  - Patch 2 replaces "floor config_complete_timeout_us": drop the max()
    floor, use config_complete_timeout_us as a re-poll deadline instead
    of the per-reply wait (Xu Yilun)
  - Patch 3 replaces "prefer ERROR over BUFFER_DONE": add the wait
    helpers and convert all three ops to them (Xu Yilun)
  - ERROR also wins over COMPLETED and OK (Xu Yilun)
  - Timeout patch moved before the helper patch so no intermediate
    commit can re-poll without a bound
  - write_complete ignores a stray wake-up from the last claim callback
    instead of counting it against the deadline
  - v2 was posted without a version tag as "[PATCH n/3]"

Adrian Ng Ho Yin (3):
  fpga: stratix10-soc: always wait for svc buffer completion
  fpga: stratix10-soc: use config_complete_timeout_us as a deadline
  fpga: stratix10-soc: add SVC wait helper and prefer ERROR

 drivers/fpga/stratix10-soc.c | 178 +++++++++++++++++++++--------------
 1 file changed, 106 insertions(+), 72 deletions(-)

-- 
2.49.GIT

