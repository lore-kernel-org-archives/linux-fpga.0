Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013050.outbound.protection.outlook.com [40.107.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA892EB84E;
	Fri, 14 Nov 2025 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763101676; cv=fail; b=gDMawCz1YEjRoCd8+c93ZGeudrh7hz0iZyM/gcc1Vz9WbJXXTvv6ael2EDun0R60wA2hiDXlydXUNZ6hBzYuwM44xW64nrO6D/YMNGR/641uQHTjvuqqfafcwuYomBi/OGIoOCf0KjTm3MX3q0AYA9GKxhgrLqz+ybRAOdINPvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763101676; c=relaxed/simple;
	bh=4hgo6JyVasca31mTBI7zZTiEgb7NtRgLTZo+2VDvJJ8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fTAk0ZlaJl1pzntuYtcTTfxUJaPBPKyaA2BJ2R1CL4Xqvna8dkMVu+exAa9E6iUs3zeDe1zUFMwHSixF4qs3v07kswFwaqOBpqnVr3TpSx2hDveLeb0PXoAyq6BSLPQqrs99eI4i0P8Zl84PeX+Ud/umJOeNN1GJGI7/xHdxB3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=KB7pnVvh; arc=fail smtp.client-ip=40.107.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="KB7pnVvh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWtraJIxVJ8Dc7VA6eSxp3iMeUMBLlYH+Xc7CPKePpLJWDUkDzliXR+fJMcMcGVoO2T0vnXqJt5pUvedL6n2PwC8CV3JlQFf91zPHayGjIMi8PjXMfkP6ICQpT5Si/d7xO9xeC4YWL4V+fdCvInH75pVZx+N6X2ZjB+c/gT1D1Ecpmk0m7mu4qVOtb6Rr71cFGNQ+aA+SFootRjd3yZ44/boIr2dlr41lJj3uBUndI6aeVAo5BmSiEDTKYwCaOI/qOVzh9rlGmIwvsG7DepETYMZCEAEtAf8dFolfczPkIhIlZu9yRLiHfPc3CKkMZ6EbPuMZxc4RMVphELIQJ8qTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxsdAtZgkvlMFIwXYff1aSzZXHjONltqCpMvK3iD9kQ=;
 b=NSEXLkrugKKeRLWrq9ILhFprjQwxxfkM3d9EgTb3PWNez65ProsA5SkrKy74pj4jIUzNCg9fnm1Q7LfunpwUA/5GKRfcPD6ZY2MfflFrhCYiw5P90YL8jpi/qgaQmYWdD6/JQeb80+XmBcYQs5y5qEaWqHVejqGQ22k3g0KlEcPUmFDC8XRwVk0dpCK7/dNRagver4UgzGYnKwufDVAkL/i8KzGzxP0MpFzx2xnHH8tZ8Cd9Rne8yiZUSH+zd0pRgPhkl8UbPIFqP2xEaiKo9iMKBs36Eo3jSZeaJZry0Kq5gZuQGADeuVpmeh55rWLUsL8fJyYxcz7pwirNu0mMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxsdAtZgkvlMFIwXYff1aSzZXHjONltqCpMvK3iD9kQ=;
 b=KB7pnVvhEDx0KTrtec31D8j7B+BYnXVjH+eENOLHkeLePdt4nRDLsIxFqPvlMOP8JIqpaT2hGt/VEW+uB+E9dOk2gnvuZvcz4or6cYPP7mh+HMoGZ0Ciga/snkWqTkX8N9SP5OfvQDGHTEakksnfgLf8KtU5YmCJW7H1+QDAnwcKC110trGPKg47LXxJmIRsIj+KnyK0iGG+BFMMkgTVSRQqXmoLbGLqxUlRYylmS2eZH71+XoRjBX7bzPzgLc0Z+FnZ1hxm0BxyIdlVHyNnu5QHbqfoD+Bz+6Jw4ccGcbOCm6a6p9li5Hg6CVdG5nl1SSp9V2URgdX9cDbdSBLXHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB4916.namprd03.prod.outlook.com (2603:10b6:408:7a::18)
 by PH0PR03MB6573.namprd03.prod.outlook.com (2603:10b6:510:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 06:27:50 +0000
Received: from BN8PR03MB4916.namprd03.prod.outlook.com
 ([fe80::73a:ddca:6d01:4adc]) by BN8PR03MB4916.namprd03.prod.outlook.com
 ([fe80::73a:ddca:6d01:4adc%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:27:50 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 0/2] Enable FPGA Manager support for Agilex5
Date: Fri, 14 Nov 2025 14:27:40 +0800
Message-ID: <cover.1763100984.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:217::29) To BN8PR03MB4916.namprd03.prod.outlook.com
 (2603:10b6:408:7a::18)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR03MB4916:EE_|PH0PR03MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: b00cc0dc-0626-4fc2-4108-08de2346ef3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zFi7bgaRSJhZBFsoKgRhGgD0hIbq+sDpFKkgrYOCLjU634W32/7o0DBIXqyS?=
 =?us-ascii?Q?w6xLCqTZipkl9C/Ern7Xuf9s60DA79RKw5QGeszi23Z4PeiqDOqiujOz/v7E?=
 =?us-ascii?Q?bwqNzmkvbPjGzI9ntsX/mlLtyLsB1MlJ4HaFDqNqIVV1Z3Fbk7VV+LsC/iTw?=
 =?us-ascii?Q?BVlqj/lfHjHTduONIOpmFNmuNCBEo+gRn4MK4Uevcq7BCACeptUpdZWZO/JT?=
 =?us-ascii?Q?doiLRWThHcF/yZlKNaotQ/LPVHQqsxH9mADVsmOuflUubvXaiBPTznyn1QRx?=
 =?us-ascii?Q?te4MDzSH28erNKR3oy2TXRiAqoBHYSQpk2G/Hsgnd4Ulf9EG2fhOMUu2f6Cr?=
 =?us-ascii?Q?H99po3S2B2+dfotxidqRDZSMwvu1LuYksH5FXjouLN+lAWZ7KmfWpfQMvkUC?=
 =?us-ascii?Q?0/yz/RRt1C4eOYUVDcCEPCou9IeOFwxqWNuCcrBnUaxoG6DJAK8e31+n3mPa?=
 =?us-ascii?Q?OR2e7QL9//bK6fLFIUQvAOhs3c6bbH+jAGFiMmOdJsMb7W3zVDzaxJPUYNYt?=
 =?us-ascii?Q?xf6zTUwFRuPa0zKa4DfDrpLTUnA/7+uB5IgjkEVtEArv59cPOpf7dsf4gdl+?=
 =?us-ascii?Q?0DVDiOWOplL4mWu0dvHcgCnMXZARXgERfs063za8F3ia8NlYaEL02FFg+i/9?=
 =?us-ascii?Q?5JIArxr9CqoJzO/2+Ly3nQHCfA3BEgJhD2XhWglFmtl8lEk1KPDHPO7GIRaV?=
 =?us-ascii?Q?eV0A/9J0OgS+p22CSo9XlP45qCs7czl4z9Me3tKxBakVzLmar2PH3ejXbUcf?=
 =?us-ascii?Q?5ztFjsO3HPoKoFGmYE8xwD5LIXYMVwbwKUW9Cg+isVuSB1ZME/5KAwXxMjV+?=
 =?us-ascii?Q?ljlqiDgzftvFu+c3Sy1xTyunljXbMCUEIAd0iEtYIr/1x2rgHy1hQspLY1Kp?=
 =?us-ascii?Q?AJLK9F3s6RHJ72frDmPFkHLR/ZI9kDreFGDBSynUV9knFE3stn+7haAoFeLt?=
 =?us-ascii?Q?RVIzPkLvQw3uAzLUYvtqUXGflStIbrTsF4RgDt6TwtRIDjTas5bxzlRL/WzR?=
 =?us-ascii?Q?aCliDkWQmfGS3PjuNDg6sXzPta9QvgHANMEKG3BPC20I/PhRiEe56KSPV8gO?=
 =?us-ascii?Q?PZ+ih9C+kM/dKBGm4SLbahG8d6l979oO6KerWJvzbes9AuubGjIUys27NaDm?=
 =?us-ascii?Q?YVjdd61eh7p3GOZ3byRcYpC6egVFFCIvPyPyqzFGo2uejA+ubBM2u7HVOEaG?=
 =?us-ascii?Q?35ex+kRINC/rOOaAstIKtVzWQ6maUkYhKmYhvwqIErs+YPTt3Ol7YWKSA9wo?=
 =?us-ascii?Q?fx+pL7Qxnj8w+vRXC3TnAUdPy3xgXgQhubnIZ7LIaWk659RZU+nYPmdls/FY?=
 =?us-ascii?Q?21ZWyKG99e5gyNulIYdafetmmA96t5tX0YyFkZAxsp1UrYh4KXSB+LYjrxaU?=
 =?us-ascii?Q?KnXExfzqunBhPk+34vOem/GA3mpzVun/cD6/zwLqiNXUqeXERNiUA8/MND8o?=
 =?us-ascii?Q?14tOSAF5G7mOorYHWyqNj18GErj968Ji0vy4HvwHJbWXZdRLJDK4D/A7o7bd?=
 =?us-ascii?Q?uAtRtjC1DSUp/n5fTgUncd1Z3w3wx0l5RKuL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4916.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIZDSXKt+ZgYKyyiRHVGLG1K7QK0tOtNKJHnpMXFw+PtJxaEUcxaCNO6QKZ9?=
 =?us-ascii?Q?IrLT+sAidHjXc2TFXOPkMF6Y4P2fOinwZYYU2jGeqdjMq8wwxlxQWvb+3JiO?=
 =?us-ascii?Q?nhn/W0m1dBUwQ5uobH34Dvqp8xESQ6vBIeucyuFgYPkHQMOm8taofiucuw/e?=
 =?us-ascii?Q?0C2jXMDFN2cFvXQ/cMV+6pPVsjbjGlTS4WSFifNL3KHQUVwBfNuvv5vR4mWQ?=
 =?us-ascii?Q?G4zzl25mIzx2yZz9l549nr83QjuDVWC5pjoe5TT8pKaMfNHEa4mstQC6LcQe?=
 =?us-ascii?Q?QLBOg+cRoHcRQ1a1TtG7qG3J89aO45mv7OKyV4hYBvTSuasLIMwPXLeBDWi7?=
 =?us-ascii?Q?avq+AxCNVHCls2dBShD3v0D5Dfkt0Suu46c/MlQYwht0Cc4tzT1NPO8W6VsH?=
 =?us-ascii?Q?dVhpcGgtqEbadWTKKVb5ELZnvolkDmZAZhr2ZW6KSlaShhR5Yk5/ZXCglYJl?=
 =?us-ascii?Q?cvNv3umBFhwl58snYrJE4KCid+kYQ4AmAlSuNX5N4UTvChe2yrXzxB3D5z5+?=
 =?us-ascii?Q?6MATVS/RkCMvnmtHCCu7yQiB6D8CKPE2wSEmOO+xLnX6ocZCNGmLlJxfORSs?=
 =?us-ascii?Q?LEtunLznvabt2qbxKLkGLTjsk0RzIO9TGccEAnf9IS8kh9dr5XorfO+LEskh?=
 =?us-ascii?Q?8Y7vfBe4rqy/FNOlopKZdJXRb+//Yq8/L1dJIuKTyWX1PWGkJaBIQ2o2UA3q?=
 =?us-ascii?Q?ENrzsDPd7ngyFpQMiKioVIu4grkA+3XGg9JfuRx8XtHfNMNTcEjAeqyW8kOp?=
 =?us-ascii?Q?K9V3wnFGTM1QJZJLE0P1qn6hM71vT2Pkd4EawRB0i6n6C2Q6h58dTVoatjYp?=
 =?us-ascii?Q?SPA4XBEBqjL7FnCoW9/4WLT2Dj+VlPqVORbOcGywmhzpz/tjGBULW4Xn4whQ?=
 =?us-ascii?Q?CcuFaDlfYb0Hljg/nVJcRjXpOZbg50jL1bcQwVRSXA4W0Zs/B7KjtkFGdjhi?=
 =?us-ascii?Q?apCN9bWhLP3IjENkYaGinrvO2sg8R7gNnkt/B2txvRSZex+9BnHF0pSCTajl?=
 =?us-ascii?Q?tZJOcBajkJCQIHAwsUUkxOgNLv+Xz1c2b6WDcqXtkCPjgGO0jUP43ILBwNKq?=
 =?us-ascii?Q?QtaOrscrIQCD+6lRfrb+a+xBTTKlUxRccxqV9ZRA3fdzOYSoXhUl4ME1UBH6?=
 =?us-ascii?Q?LlFlmL+oZ8AxohWxrD8jNDPo1zeSQxb0S0WXZzjuT6mHl+md7RXRexKiPQAv?=
 =?us-ascii?Q?0LE3MF5j9zlLQb3i2bVVylX92C7Z56mJaJ9GBE9Jxka+hbdVGio8FHUZDTER?=
 =?us-ascii?Q?pP4R4vf05dhipPClB8Z2X+gZ2U4PlMHWZXWRkITXSVYXwPFLiQ4udXez/7hw?=
 =?us-ascii?Q?6Qcj5TOJGnpBQ1bUclcPdLcm6P8dscMIuSXd/YQuTwevCd8aNdHGYyTkGyJ8?=
 =?us-ascii?Q?PxawXWYaCoNPGze9cDseRvkSu4JQvNaGALUQUKCuAiltaSwn6bfMuUb3Jmkp?=
 =?us-ascii?Q?FX5e6esdAfnIHxJ38za65f4oKXK/NKVBTB3oliUzcjs9PBvNWAgiSjzDlIF9?=
 =?us-ascii?Q?JwlKFf/ipJiLOEF05YmmQrt0cfV2Ct9ekDPYpXyiG1Q6wmcHsyJOTAzEjVb9?=
 =?us-ascii?Q?t0l0b4Vc9NWIELdV+biFZlq3cDq7bVfID08t13OinMovt598+zKMbVKLXiL9?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00cc0dc-0626-4fc2-4108-08de2346ef3a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4916.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:27:50.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5XzG6bFjgF+D4i+WAbPjcNh/b4nkrMS4RFE9eP0wAjgsBNCtk2ECYbxSQfxFDFDWJnAtT57+5flkIukIAHw0QrvEn5Wi7rFz0jcrM/1aWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6573

This patch series adds device tree bindings, driver and DTS updates to
enable FPGA Manager functionality for Intel Agilex5 SoC.

These changes are intended to enable FPGA programming and FPGA management
capabilities on Agilex5-based platforms.

---
Notes:
Patch #2 depends on  "arm64: dts: intel: Add Agilex5 SVC node with memory
region" from
https://lore.kernel.org/all/3381ef56c1ff34a0b54cf76010889b5523ead825.1762387665.git.khairul.anuar.romli@altera.com/

This patch series is applied on socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

Changes in v3:
	- Add fallback in altera's soc fpga manager compatible properties.
	- Validate with make CHECK_DBTS=y on:
	  - intel/socfpga_agilex5_socdk.dtb (fallback)
          - intel/socfpga_agilex_socdk.dtb (non-fallback)
          - altera/socfpga_stratix10_socdk.dtb (non-fallback)

Changes in v2:
	- Drop "fpga: stratix10-soc: Add support for Agilex5"
	- Add fallback compatible in DT
---
Khairul Anuar Romli (2):
  dt-bindings: fpga: stratix10: add support for Agilex5
  arm64: dts: agilex5: add fpga-region and fpga-mgr nodes

 .../fpga/intel,stratix10-soc-fpga-mgr.yaml         | 14 +++++++++++---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi     | 12 ++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.43.7

