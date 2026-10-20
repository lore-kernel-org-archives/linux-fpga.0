Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792482588;
	b=VhLH6X+nHGz2Be9fsl5hFek6zAeUdXYfsqmxEAut8Pavfn/wThlgxqrMBfKK4Tcm7y69
	 RYYJfdw4gC7NBga0Aqy02YBQ3I0igpq/hMxFsrNdRynWlp/18x0mzhLtCICYgnjCjpEvM
	 3Y0WFSQjkJcQy5lwIVTEv++TJLnnQilHlvajKk1R1wbsMqf3DQp8prVeyJiSUYlwxbE81
	 W7WcmZ2BpmRye76DTAx7SZXy+DwW0IEwBF3tabm6oo8lAwNDR7f8DnsMoFeBaGZpz4Juq
	 b1sxQoD0o50QaI2U2xVCtNMMPvovNp9/kc4Ov6XYCdP7UB9hkVLo5Y0+Ek/8K5Zv29w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482588;
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
	bh=uqMvUh8+TSVq+9wcUj7hQ4JyE2kyWHFdR8G8H5LAF6Q=;
	b=r1HvXdklKnrZODiU0Z/XU8e4hlLqFUIrr/jHjIlYC6bRKp+7Sl2Jhp90h/TnMasMAb3j
	 DxTU93cnPpADcw5s1wq+AmAqsp7sFexn1Aqp22JekxZziSnXeGvu21nQbBOlNC3SRm2BC
	 axttCd+D9XPgs3So7FY1mOSOIl2TjORnlMsYmvUZ0gkTxmB70l4sI27jsiHafhjeA/fhX
	 dbOI8fnVkM7g/axuPJmdE824Ta83XXhS+0WaonoPKk9loaa1CjgF0YQWErG2wXg+jzO4g
	 LSqvPbSMjaXfkDmxlQ59xLE96EyU51Uelc2/z9Z7HQTe0PFuCFbNsg3N7afjDBc2T9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b="Amu//EYn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.50
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78BA606A31D;
	Tue, 20 Oct 2026 07:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B78BA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Amu//EYn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9d7DGq1gPEShuG5aYzeCzJ52cugu3HhMiD/wdH08BcJQMNJfx1ITDgrJf8lL/J4ACiUpjb43JF/krpynNIRzdOk7Tyar0xYW3BMHE1MF6dhgzKF4WO9t5E7pzWiPzXwaA5q1yqyyZX2OP++C8FKs1pm0IulSbg7FRTm/arHVDWqPJr8GqeAToYGmXNC7WyeRrigCDNrD6cct3jr3NDSXxK4ZNgSZByJjxIOZrtnHkdMp6DK3cuxh/FCnGwo02x9BeQCaiDA8njs6xSxibNZpXp962SlFicE+SZfZwjNoIs43mWUN58K1PwSlBPsu7WKf4YBPb8+vMv8qMPmPsECrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqMvUh8+TSVq+9wcUj7hQ4JyE2kyWHFdR8G8H5LAF6Q=;
 b=yInFgzkkOsWiuAxv9zZsZ0pBgie6OENFgg8bEh/mFOujle13pggEZhRvE4GhG/kvqoz9pWKZ69VIqpUDvaVlcy8YsF20pwaPgBq8fYgAvb2DPxwU+y5HTzmQTJNpB1OuUILQe0OK5Pv4Gzlm34OjScESqsrl79I6NK2ckQ90vB0/pR3+cXx9oCx78wbbKPbDPoeo4BV4rVywoG+kC4jcImt6yDbRa0SOOHLaFa9DxSH7xU8uqaFRq0e2CnaTXuZ1B51TRWkG+HA4v9zbAFEeTUB6wRfViq6+ibms+kqyYjznBGvi9TKCF4LOqCaaUPPXDWU92fUhITLa3Qifjog3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqMvUh8+TSVq+9wcUj7hQ4JyE2kyWHFdR8G8H5LAF6Q=;
 b=Amu//EYnVqZa5A1yY3fXF2Oy3mmfJrkowRC4KBaeGI2SKW2vOz2dpBQPnpBWazIwh25t8xygFjcsOy2fdpr/gbI+tSFgHI29vFMAUsdX6lnmxJ20uVyn7g9tlgG8RO2AlrWt700axTbEQZ/f14F1yvYbIX4osU+0Ie38mi7rBCc2bcmfq+3ozVrapOnXrwFGS/5HtckCo63hX/KRmXm0bJdvTSlW18bOEwOZL1ywmauNjHpGOxsXOMK/j3ByRQr4CglvcCwA6SUlUAcjwW+NrXIIRizAbMLWbc7stP9p9kp9tkjrV13sBQOAT4b9wmcgcxG6MO3wq7TyDCdRmOGLBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12)
 by DS7PR03MB5382.namprd03.prod.outlook.com (2603:10b6:5:2c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 07:49:46 +0000
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80]) by SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:49:46 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: mdf@kernel.org,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	trix@redhat.com,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Subject: [PATCH v3 1/3] fpga: stratix10-soc: always wait for svc buffer completion
Date: Tue, 20 Oct 2026 15:49:30 +0800
Message-ID: <6bb663935fea8c3389aa3bc927dd7104e241fb8d.1792480395.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1792480395.git.adrian.ho.yin.ng@altera.com>
References: <cover.1790090287.git.adrian.ho.yin.ng@altera.com> <cover.1792480395.git.adrian.ho.yin.ng@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 666f9f13-e3eb-4b53-babf-08df2e7eb5c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	VLUyC4yjj3jo/Ov2BuMlX7VpimYqOVrAXkT8bdM4tjwY7pikri61LLvZTvoT5kJtKSNc9O6+sOyl2yDyY0S/9SrDMiU5CUf8papbtacFLSU5P4TdLXUA2ETHXmaGSiGTJvRrrSKWe8oyFofRcSawXC6iFeT8DAmhtuT/5pN1ENt1PxjEq1hSduZVjMqBe0M3OVgeMjB+xVeUclq1qBIF4QEosAITbEjguUBguFHb3z2fg5J0+ctjEFvudIwsWJ1EKDMTboJEyePMPTo1nRlZvZUQDElxULjOh8SieW2mVdYOiyqkmoI+AvZbNcRndDCXh1oqfIvSvg6a5XsKyDyxr/pou232xOXorrguM7KDZNK7GSlxfdyQDFlhVBXT7N9at2DfD10m9MTMUnY7NH1Ed4RPbB7Zjkt9F0A+ffbtI3QHADRdMoi7Iw65pDZSytz0nG7at3b1iMAiBTpOvO1b2Vx3v0NcaYN1uzR6szKvfO7wtAJ4G3t085zkDNiws2I3vg9JC7rI4CGAdi0Z6qA4LFz+/StbIzLejQvuPtnfraMjg46Z/nogpDjq+Trozf3U/3xPUhOzoQp2AR/FO53qCUcKUKWUG1AFH3YKHbD0igiEqkq3FkdeU+Vf/NjZM0jyNiDZhvgwAu/9YG4sCNLTsrC0vj1d6kA5eVBQPNwZDkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6581.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F3Q2nkQa9uCaTlgbH7i9veHjFpRcoGt444sQCKSWePGdBMFH0/o6SBfx8c2/?=
 =?us-ascii?Q?x5TeJC7CvWxAkGh7kEkLe0ZEO1KSTSuKLAK5/90Nw/JDedTwZT6voMyrwfaW?=
 =?us-ascii?Q?yvljLJWG0YuLoYfLQGVaFup65UMPkHei6704lbG9Veubb3Uxn8Gggq+oHqrZ?=
 =?us-ascii?Q?221JoL1npgLmhu284Dr4Xk7xe/THlhEE51Vcpa4RSyF8Rm6TCnN9w0K7T+Nc?=
 =?us-ascii?Q?VH3Nx3cwjF9mhTaKQWLwtVJ2AqoLfdM2PPj1ZYyecFAF4ib52IFFcQ6Etssd?=
 =?us-ascii?Q?QGeF2j8WKZwQo77A0oyllckLhTU+lHxCRC+m2d+t515sNXYgSDChft3xvPZB?=
 =?us-ascii?Q?XxfwmDNA59z07O3iNwOanJP3fIFwZmVw7K8s54WvdCsRbhN1DX9O3DQcBz6A?=
 =?us-ascii?Q?sipLyspwvQCMtaBH7s1Krb5jWNFJ+N8q63uUySzsrwr7BlLCkgOaZeFegGWU?=
 =?us-ascii?Q?BAkDRe2BB1STPig/2Bcaxk6PJ9ZP9N1wcsHu2kilJW6RVsxhSn+AshS2UhmY?=
 =?us-ascii?Q?FvVUVxKN8p4sJLyM6NOuPaRdz88gpSvdKe30LlrjqEWX47L3Oh5KV87n2WnR?=
 =?us-ascii?Q?Qmoy2CWRDUjCxI5ojEvueD9uCa3qcwgvvnFj157HrHQM/4Kt7BZJwVOEXRHz?=
 =?us-ascii?Q?enA5tKeD6hQ3Jf23VQJy6ESy2x9lTVNih5/+8YhysoOZsOU1b8vBUKxYdugX?=
 =?us-ascii?Q?lvKh16vKvxno9glqksVq/3dOFfZNFBDLXoD9oVLyCmmU+3lIvZKkRGQqn7CB?=
 =?us-ascii?Q?UF1qluaTAuBFIWW3FzjvejM1Bj33pZHxRKQ5iNS8FBeh+j5BetDkm2Ym7aFM?=
 =?us-ascii?Q?h9cI1MI5y/6s5adQGXJ6Y9JOr6O3Ytx0NQ2lW69TObLotLxyj7nsIa26XRAN?=
 =?us-ascii?Q?Z0g6HxHqmcEL6VeoIXKaVib/L+XO/gpn0trGe6Cq3Vo1zNOFkuiEE5c3puJa?=
 =?us-ascii?Q?PMXPdW00FCmiz1O7aWKsD0GqqEn/SdPLqPj4nM1Ag6ikXYrCaNInANtzteew?=
 =?us-ascii?Q?82dn9h39XmDfOoJx6dxV/7O3iHTZfd7py5yM1wxndGpffUDIjS4CU12c2UoZ?=
 =?us-ascii?Q?m1paPIE2VdQ4eU02xdvnSnZXVBuWyYZYEKVEYj/bOzZEB1m4oMM3kE1Tpk+F?=
 =?us-ascii?Q?hxbYyU+2ZF8ncOtYnv6zJJYTa+O7JhyNClJF4fkoZtUN4mih/NNToWkinEyx?=
 =?us-ascii?Q?/FHFwcmZTo7H5Hd1J62OQIaLBRDCDhqV5ABDkI0qm0/AQ44tgepbogkvwpSN?=
 =?us-ascii?Q?dLMsNsWga6ogTVKP60WsuMV8ICq73wPES8DT8jMoMgfiAaCWgutPd7j9XH2K?=
 =?us-ascii?Q?ih4ZsO/N1abFYeVE2VoSrPPdmqhaNvkKpX6f9B4q9XyqfKWB4pWbSKIY2foR?=
 =?us-ascii?Q?HOKPgVD6aWEgCq+hyGid2m+UjwdVq93CB+b6FKuGDpPq9OH/QKznbZYmYgPp?=
 =?us-ascii?Q?V/D+JIYY8uoWm7XHrsY2gTcH7RUggA37rT23ay0w7+RVKj/VWThCwdZ5box0?=
 =?us-ascii?Q?G8OK53zYH1TpAb632EJSmaECnI+5pl4ZIgNctZjJczgFdkki4O7ZxOSOlNfU?=
 =?us-ascii?Q?v71oi8RrHDCbQMzNrWGqcnfmP8x176e94Ef2zi2JxYLAJa1mD1Si8CYxzNLu?=
 =?us-ascii?Q?J8S5wLVQG7sgcMRe63X+eooCJc67qeC9S4xhPn/p4FbwVsd3/WJ4Eyg7qGzz?=
 =?us-ascii?Q?/FDYxx5MDOq6fnsvxvehYKe05hUSuqFMNDeIYJG5VIbDdx661SjILwWedXoi?=
 =?us-ascii?Q?kLVRPTdT/EuYjGEMFEE7Z7jqgdm5GAI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666f9f13-e3eb-4b53-babf-08df2e7eb5c9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6581.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:49:46.1875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZapXf/ReR/5WxgeUPJ9bN3EskzOYTa55twCYUcuTDhWuZkX98cjYJxSTVBCTsYA+fwAMKvrvX0VjLmyK3kSE/bRCCJOTUjuinopwJ1WwY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5382

Always call wait_for_completion_timeout() in s10_ops_write(). Skipping
the wait when priv->status is already set is unnecessary: if the
callback already ran, complete() raised the done counter and the wait
returns immediately.

Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---

Notes:
    Changes in v3:
    - None.

 drivers/fpga/stratix10-soc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index b8ec2e6f615f..3ba0ffa1d9e0 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -310,14 +310,14 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 		}
 
 		/*
-		 * If callback hasn't already happened, wait for buffers to be
-		 * returned from service layer
+		 * Always wait for the completion rather than skipping it when
+		 * priv->status is already set. The callback may have fired
+		 * between the CLAIM/SUBMIT send and here; if so, complete()
+		 * has already incremented the done counter and
+		 * wait_for_completion_timeout() returns immediately.
 		 */
-		wait_status = 1; /* not timed out */
-		if (!priv->status)
-			wait_status = wait_for_completion_timeout(
-				&priv->status_return_completion,
-				S10_BUFFER_TIMEOUT);
+		wait_status = wait_for_completion_timeout(
+			&priv->status_return_completion, S10_BUFFER_TIMEOUT);
 
 		if (test_and_clear_bit(SVC_STATUS_BUFFER_DONE, &priv->status) ||
 		    test_and_clear_bit(SVC_STATUS_BUFFER_SUBMITTED,
-- 
2.49.GIT

