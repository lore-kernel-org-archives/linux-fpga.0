Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537425625E1;
	Tue, 22 Sep 2026 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092985; cv=fail; b=pDkaLPlUXl/hg4iL5HrwSAipfqPJsBfny6UfxEdJiikc82mWZCrwFQ3i1qVDvtTdlHQhozGC1gYtqHbeTSD6yaenOhKnBDHcecdjPqODkJsPA37Bx323hEA5HEVnmtLNLj6yommN/Iu8rbb55GgzxuHex7ZVi/GhiCw8lLnCksw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092985; c=relaxed/simple;
	bh=FCzy3lEkgrqipcULQOEoqHMP89frEnwDTHEXlCuIivE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gbAWcnC8lrOkObcrSJyR8Xvt3VdpKm/act+DiwkYXbE7tcIq8+cdPG7lbAJLGq2i+QSDptP4G5uEMVL4+3MjRFNFAzMmLCeWaiKLcgd2d4c8WL64iGFXB1phE2j9QWSZ4EIFGKFF3bwmt7nCVg8aO2dHuVYEJE+xH2S6HHAhjJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=iJuTeb6t; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="iJuTeb6t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrTEliND32IPIgpiExA3TqbQEx8en+cnuEhJlPZLfZCa5Pzenp21FuBuLdkYIcmS7fnbhZF2xM63IXuTKvi23SOaGnwemdMIf1/r+R6bIIky+m+lvnbvnfEAAg/gTRpZSIRe8tdAIn7mtcmunT5SE4tlm8oXHG1OvTtU6vussHDUi0C4FzthMyVB3Xxp9RqQeAhVjGCN7cCjMmPgX9rjAChE+NJQkg6mejcF8LYbGGZ+46hz5ttrWsa5syqKuMyjd0qmatejaqA1xwWigS96OVcKvACsru+XLPijfTeTmIaJv33Om4bOWvDVUAMgdAaMs2nOe/wHWxaE1fWjtCiX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCl0VUavwXFLG1aHUSbEeQxjXLVWwuGWbj+MeCKRXU8=;
 b=jZ9t7JKdGgv9AKUlDJT7Z3TLQgSPNm/Z9h6iIXYr57ObyQxt1RM9cgGIRqyDvT77KM1ktnc/xCH4i4dYScI9z9r1j42HekPMiElNv4QKnhFiZixH3cKameAWQxYj5RdSjS/nPm0S90voQR8MqpoIF9ShgAv7WeLtRpSN/1u8GUAnhWs8m5bgQAqkOsfike1tCc41b3j4lmROWcFHx3zdsH/J3MZqwqwUN2oelmVgnDiNPmbzyopysqYoVYl0gqh4vXaufIT5l/ginTdfN0n8algkuVlSpGgvnHXatl8bKc1hOqN/TZ2PFVtqglOb/iADzCbzckCAOY5SxZJ09qbzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCl0VUavwXFLG1aHUSbEeQxjXLVWwuGWbj+MeCKRXU8=;
 b=iJuTeb6t/Xm+itdmBh4DT8g47n3ItHX+ByJIefjBYEktBtqJuQWhv/a3DywFlsdn6Mnl6h+i6NqqCcX1Lfs4Zo0z0kCUk6BAkk8ucR9sqDrZiwz/5FbKIKOPuYX2z/479LOuEwCyBYwOM6ltMmII70E0RJOym615326RdkWhKdS0mKxqmde26WoaDQfUvCE+PsyQgxLAQMw+8I5B5Sux81gq82Nk1OBjSdaK4V3eO9yJm05yaCmaOMvuQ1n7kLdMxTjA+sZJfwdKUR3mmpN8/FXX5pgK3D2qWcFgJvXSmOzHv7WXqhY/P07LC6y0//xMh9xx2VfU258zlOUs7cPiNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12)
 by SJ0PR03MB5918.namprd03.prod.outlook.com (2603:10b6:a03:2da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 16:02:54 +0000
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80]) by SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80%3]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 16:02:54 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Subject: [PATCH 0/3] fpga: stratix10-soc: harden wait, ERROR order, and timeout
Date: Wed, 23 Sep 2026 00:02:40 +0800
Message-ID: <cover.1790090287.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To SJ0PR03MB6581.namprd03.prod.outlook.com
 (2603:10b6:a03:393::12)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6581:EE_|SJ0PR03MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd15ac7-710a-490d-ad68-08df18c2f636
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|55112099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lfSBXUPfYSe6VZ+sMZrGsgtmByjS+3PX7+c5D+OC77havLiFYZXi8P/zbDLP6n8rOymOeAgIEZ67TxshaM4fOrQyi6LZacir3K4ox+42qog7/lCmSq9y8hDauEHP4OnPdTC0QjSZcqBgqM9nSb3CYuAZZ8pvPaVAM+k3ftuMNMWu864Tcp84CI4DgrhU4YMOaJ6JFI777YGbsD+BgKqR0hZaNlAdRV4oiobbh5r9tbeVloFidJXrv6o0zAB7Go29b6XQJ53Sp4sJwYbEUAH50TGSa3Qt+tf3Fw9iZorhSLIyxrI9DsxBA8SlNTateTMJw+u6GGnMNzF5ULMw6r8nZiJARqNS1oftqcGFbw/PD9E82NRBODbcJuKuyZ/JQHFWtDhcAcVlpDcylfdyhyQ0nAI535P4P/HWtBbjfKg4wKNPde6e4JZPSUbNG2vEpVNuwMBpHaOmDfmlGuMt5EoEZt1k+wiZORYDMh2o+biraH8SO7xIf83jD/7DyM8A30q3YBcVP8NQsmk16hBP54uvIu1gxOdNkRq42QVOsRI/tEM1OcSHshXFOp+1GhQiELviHYcmVDUvL/kiiWGqV/ES+mU+TQi9N6c725b+cWvTkVAIrAEFW0+nTnJMLr1ILKfoZTP5vSga5p4Y/Zso8vR44Gb68drUCT2C0uTuRIOZpvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6581.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(55112099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V9zo9PXUXIyy6TFOfHZs+CwN+B6YQUPK1gGFpPXcLfxJhKIsVfFSVPJp0Uh5?=
 =?us-ascii?Q?4em3ipRCxYzz4OnpN8/WLHY4eO/1GDwVCNLClUOVEm1WKu6Um1pl3gJuDC8Y?=
 =?us-ascii?Q?fkDWS71wKm0wvwaHmmzllbP2Cihrg/+9o+YXdyVHeLlFAz+JY6adXfDv6p45?=
 =?us-ascii?Q?nF6X2Qe105KC3cxmh15m2s++SM0i0dG7xd6tNCW6xUWz69uCojHr1RGt9lIs?=
 =?us-ascii?Q?EvuyziPcWEyix2AqJWr5N1udFScDm+yWgYAsXAz49JdOexeWjifNuJluns4x?=
 =?us-ascii?Q?mT5PuAbUZBxUFX1k1Q+xO9BnCSFBHzG84agXmUpFbfi3ej/zcQB5wT+NfYbb?=
 =?us-ascii?Q?2egzeyyjPH06fNHFYP4nbw3DEsLdzyYW0ur6njMxD0waXyBv6IrIMdzqBUrT?=
 =?us-ascii?Q?tWPhIHejox4oTPLXXL5a9xG7bWyx7qmDF70uS0wUMtYDZsrgp8Fa3CQoNG0i?=
 =?us-ascii?Q?zQtF0nLAfbaZXouESXXbx3e4EKYGirsRA1atLb6swVlzEFhU16ty5mStVPRk?=
 =?us-ascii?Q?WLcNM14DNu+nUsMY8MawZumARzN3dW2LsIvViRb5mpZEAe/ufF5B81YugEXY?=
 =?us-ascii?Q?Nz0GuSdVF63pEILCyvN/X4+RQoxICj7AZxWjMYELnqmN8GmS+PLDW5Pg00rB?=
 =?us-ascii?Q?Y4mFj9Aa0Jp49X5/RlsVYRO85Qwy3hayURyR+Edhm7ctJ7jYlHSc2j38FgpY?=
 =?us-ascii?Q?HV8fBVknpflgx+FHjDG2xylEn0BdsY/IPqRt3Gmj8RD5uQFwZT5TaIaePo6g?=
 =?us-ascii?Q?8uQNpbWh8oC0lVf9/lDi+p7rYn6cebuT5SU6XfqfP8xYzcZ9TXMfv54zGXfU?=
 =?us-ascii?Q?aI8bswMA8KsfuTBVv7cEpZZN2laj+uGQuVo6CDXfw4hmKI82k1Ebx90tHrAA?=
 =?us-ascii?Q?0ItjTjy8O4f3/Pa/ZnJchTxJUUvVsB6hwS3Yx04go1mXR3NaY7mWRK802M8j?=
 =?us-ascii?Q?tELykH0z9mqPzA4OnL60zZwilc1cMUyqMVeHZJQR/p2DzIY07z/lZGDuQAMM?=
 =?us-ascii?Q?sVdBi8dJsN1CSMSiUqr4j9QgVp77fwBBG6AtHDfEvfvynZUHfFcuCT6i5Qlr?=
 =?us-ascii?Q?ymQGtVWt7hQqT+X8/o+XrQWnjYidatYYWRgz7ISKnCXvn9tW67aCJrM1EThf?=
 =?us-ascii?Q?tsEdxYtjFLVUkB+0Q0q6Iom96oHRm3XuSNZ2960QQbABEwSsJso0GsScaQqa?=
 =?us-ascii?Q?88M2tyem14gxE2BWSvs/zNbMbQy9fzqXMTxfmrdKZZXLqApFmjEz5M9kyy9f?=
 =?us-ascii?Q?TS3NmBo0wE9k7Z/Vvd3s4NmKIAMvayad/+q7EGrTBTRY4+0ymo/jNSqf0krK?=
 =?us-ascii?Q?lfMFGzwhF9wzOqd1Y/k+t082NBZpxoXFvbUSXrEH+q3EgpP1iP4/z/k9ibyK?=
 =?us-ascii?Q?GVCR11ZFZCymGzdurcw/31AZsbbBl/Ih38zD6/ttD5GtgOcAw821vcYsqZRn?=
 =?us-ascii?Q?g/nKwXjG0ycaekOVLiNPcTguFwqwov3SoK6E0xCPEuVVChMvlFgwM8rflVIz?=
 =?us-ascii?Q?uO9w/ALndicLOeQ9stTXZeDCZbPoygwZt7R+mkoke15pETNEA1LoLmoeM4b+?=
 =?us-ascii?Q?+idEJlM0+V5MPq93bBGZyzdDbNy9joHneTNV3V5MzuwfK9lhO/2PyflzT3NF?=
 =?us-ascii?Q?9JMFBSwpUEg8dB+HasAIBLQFFhdSGiHlpSj2pFyArNSkfb+8DUKd1YqeLGnD?=
 =?us-ascii?Q?N2R/Pd0C+7vAYL9lF/GtRGBQNEpLc519ISsliM0pFAQV1oXdxz5rN/RFIx6L?=
 =?us-ascii?Q?MBiKVboM3hF/zz12uuZD4+/P5FGS+/U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd15ac7-710a-490d-ad68-08df18c2f636
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6581.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:02:54.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFPCnhO8saTV9vCnUxJ7VGneERX4J1payVyXe6Y9oKhZeWlMKIF6MPgC0NlJcSIA4/+npclR/gfvyQ5sRNG4M9NeBJETzz/6/BmSM+EEsEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5918

Stratix10 FPGA reconfiguration can fail or hang for three related
reasons in the FPGA manager. This series hardens s10_ops_write() and
s10_ops_write_complete() so those paths cannot skip a completion wait,
treat BUFFER_DONE | ERROR as success, or return immediately when the
DT-supplied config_complete_timeout_us is left at 0. No dependency on
the stratix10-svc accumulate changes.

  1) always wait for svc buffer completion

     s10_ops_write() skips wait_for_completion_timeout() when
     priv->status is already set. That skip is unnecessary and unsafe:
     the callback may fire between the CLAIM/SUBMIT send and the wait
     check. Always call the wait; if complete() already ran, the done
     counter is raised and the wait returns immediately.

  2) prefer ERROR over BUFFER_DONE

     BUFFER_DONE is checked before ERROR, so a combined
     BUFFER_DONE | ERROR status is treated as success. Check ERROR
     first so that status aborts the write. Also clear priv->status at
     the start of write_init so stale bits from an aborted transfer
     cannot leak into the next reconfiguration.

  3) floor config_complete_timeout_us

     of-fpga-region leaves config_complete_timeout_us at 0 when the DT
     property is absent. usecs_to_jiffies(0) makes write_complete return
     immediately, while reconfiguration takes ~600ms in practice.
     Enforce S10_RECONFIG_TIMEOUT as a minimum floor while still
     honouring any larger caller-supplied value. Note this prevents a
     DT property from lowering the timeout below that floor.

Adrian Ng Ho Yin (3):
  fpga: stratix10-soc: always wait for svc buffer completion
  fpga: stratix10-soc: prefer ERROR over BUFFER_DONE
  fpga: stratix10-soc: floor config_complete_timeout_us

 drivers/fpga/stratix10-soc.c | 41 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 14 deletions(-)

-- 
2.49.GIT
