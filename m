Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382C2749E0;
	Wed, 19 Nov 2025 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519178; cv=fail; b=FqDHTGtZDmNSB5HMNc2FwlDs+NgBvwsbR3O8UalI2v88qr5yQ6jGfixQtyLwzwF4qYFaioeEMZR/iqmHPv8UA0Mx+mdwgk0yQNUNyo96VHugAsNzylwQUjVTzuotLeNMkryF6zHHvMiOHsZf2Pcde3S8dJDdntpwXcNvZfvkJ+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519178; c=relaxed/simple;
	bh=MWD97iAdN9JTRvz0EkB8ko8fSq5R46IpMeTB+PwzcPQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ALVIBGbYyEKipWk9nd3TnfDHUe02eBYnbl4w22Ye64C93RRpqTiTciAzoG3saARutpdlIPKLWixyG5wxKNhrqd8pU9xSn5nv0qXv87KI43+OYdfkoS43LVewiUmC6SPSphfpTVotsgbVFUPEDEJH26B6+eojLD7AIjZE8rI4RGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=tHmBnfS6; arc=fail smtp.client-ip=40.93.195.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="tHmBnfS6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eul3BgADi1cU/qdosAcLwfnm1bRRnYYqORGFqwd5ir7MEKwp+HGala9mm3CNKLuiZToTr6VclAmGIgQY0pN7t4VOzPkZH05BTJxMT1WlA7uDJF+oO9Viu+F1hgEtuGbzw+k/3rMEkCTQOGQG6zfMSwF+GfWoFQNTj3Fk7FnMJgW1xKsUjNJ9agMqfMWYZPfXqofSuSlF0QpitH0uFUOmulJ59SgdX1dKQNSfT7w7knNi0LLgCqUVymi7hmPUFmQuGbYBxPjBKUkV2UNqJXwHa57b4VRF9yj71kAgoop1hidIKVJxhAj5N5EAxb/D5UvsrHC31flZlXcMbP/LUQTDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDepHHyIWTSb1OvhVL4O7Qga8d9NDUgFzO/mbHpS4xA=;
 b=L9Eh3tgRXhfHp99kniTB6L7HX+u34uFRKx3Yr8bR8MY8vuPZ2tnCKh73VD5Z6EPNu/8KDu0lWCQCndp8hdoFRaBxiZgIhy26cAvcQrvhoJFeC3pmvcojyX6XwnKdp+eNgwe2XgdS1PoHg9G6ct0nxAFvAeNBdXcTO+LFH6A737+gYHqBsguBeVI22C6k+5kBewvegOOai3ObfMGaKuN0/SuANDw+3oSfb1BqrTKLwmQFMBZmpXLR59gVZjmDMWBpdh9nDGGmU4PkY79UGRkSnlrQBfMbrXTWc9PJtIwYt4rigmMwcuvb50a0bwxWdRaxp7E8KqG+0qfjAoLtN+Pqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDepHHyIWTSb1OvhVL4O7Qga8d9NDUgFzO/mbHpS4xA=;
 b=tHmBnfS6k+8HHUzO/Ds3y4pq2KKFlwHMJ6BXoSe87b8xhvlywSFRazrYBJskcUg9zJUcHvud9u5AiVhYAkmTPcIqfdZbq6B312YIm9eNvdWMeadSPeHQDQ0syuYFPhbL6jv2nnRwB24l4wK/zYy0xnxeVZjyjzx1exqktjTEq1kewQbO1NR2fEbMDPXtgJ4mluY0/pPxUsoCBb6fEbGVOawoBPvBy+uJ2dDBNtB/YsDTvOXOPV9GbWjrhwgLf02+KhYFJ5NUuwMCo2nj2VQY96h+yghKpQM/Ig+haM6HSM6K9qf059P6LSMs4aJ+p0XAXclfzCPf55m7LOB0uDeRxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA1PR03MB8068.namprd03.prod.outlook.com (2603:10b6:806:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 02:26:14 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 02:26:13 +0000
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
Subject: [PATCH v6 0/2] Enable FPGA Manager support for Agilex5
Date: Wed, 19 Nov 2025 10:26:04 +0800
Message-ID: <cover.1763518321.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:334::9) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SA1PR03MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 432cba51-8c1e-46ed-40e8-08de2713029d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0DhQGyMDceNHoPPhauHLXE+nzXEqZ1VsbbsMADskIMTHREnBTkzzVhVFk1IE?=
 =?us-ascii?Q?bzIBl9ggxZ51Q4a4pgEtYOC6rprBlzas+gs9voHRJ5XQ5Vh0tVjuA1Euqn93?=
 =?us-ascii?Q?FwSUzRk1UODQKA1u+n8fzy1l1eoJbZHkZBGCAyApBLJfaOdadPfwBMj1hAB4?=
 =?us-ascii?Q?jasPr3YbuHZ1q4R1ENp5rlbNKEtRJd/VwyJ77MzuQ/NNCk+Q1thpqIPrO6AB?=
 =?us-ascii?Q?p21rycxVDcgEMxJCXRQR/KrpJlYki6kdS6g97rs0Vo78g9c2/wtP8Reiwi95?=
 =?us-ascii?Q?NVGqdSzfDxbpPBIHAW8tVK4dLxXFjUkJukc0novED1jfFCHaWOE54CRUpoSW?=
 =?us-ascii?Q?EU6UgQtxEUixAcEnuPVWvJ3Z+IzJuiHD09QOcnnTCXVPKHVIn80fxlfK5aA2?=
 =?us-ascii?Q?wMM64srtIJtjigmV7Hj9xJK4dv5McG5fZrJsAHLlDfjpOMCOBUilcGggnaMP?=
 =?us-ascii?Q?z0rG1aB5a3yuN8Ve/3wKcH95+MqYu503lsAZrCjvWcsoGzxERO7eQHC4MwWL?=
 =?us-ascii?Q?SztVrbAyr1u2x/KyieOgJYlZ3w9nUCvUuWsvATx8vritqzmz0xqvktlYP5pT?=
 =?us-ascii?Q?JkpbXCqATMP4p6WHYJD+fMFuQ/iHYPnIu+JVQKs5VYpYcmWZukGFUQ7SmagX?=
 =?us-ascii?Q?QonBbqOZjQXO20zljFOtyIHgGBpnADJ8bsSggSynIz9UVtnNyFjo/gczKJ+d?=
 =?us-ascii?Q?SSMLDkZ6wKWQYaQdJbBRjMrrmkGI6LFFQtwlOHjcopd8xbpSPXihzxs1jM2t?=
 =?us-ascii?Q?qyieWpWKpT9kFsc2moLNmlJC8Wf3cJkZnUxhsoPMkBS4YI/C4c3FVtJWK8OW?=
 =?us-ascii?Q?XfmAqjOI/wprcz2esd72k2dhn9/HtaxIrFFOt5RP2gXye6BZjn9JxU6QRLag?=
 =?us-ascii?Q?WHqCkxVAClolvO09UvyTcEh0oyIGvfs4IG4TCnm2NhSSi+oDZCmXn1sOlcuR?=
 =?us-ascii?Q?ANv/O+OK5wMT5hGpC5ZZoRvByqNfluCW6KjA8JkbKNMJpxw0xHPa22+AXwSv?=
 =?us-ascii?Q?cimY68L8QmYbqAn0Ay0s4G8I/f5wtqEXyxiW3tA/qtmGUxRv5W3teEgwxqYQ?=
 =?us-ascii?Q?yXwp7ZPf2WsLUWGQBE5PTAKUYJs9lYy+1jelPO8Abvp0ULrEverqOevrlBnl?=
 =?us-ascii?Q?wecuFc2NWQbGHQG/SAXfOo9jPRRcbxpnRj7aXZZXY36CQ9hkb96YfVQWCmb3?=
 =?us-ascii?Q?xluFBxZ0N5lLof3jjvzNZU3WG+wJMO6U+swTN2swVVNgPtg9RjQbq3NA7pmU?=
 =?us-ascii?Q?r2v+MwClERxzyIdKr2KLUUckL8zttvYGPEqWWhzBp0d16VoCT25++rvudqD4?=
 =?us-ascii?Q?LauPXFUmAqDmLwHaJM2G8Jy/Dg1PQh5pDMPhegLEO0Ew/p3mFsxGvzqmYzS8?=
 =?us-ascii?Q?vjQZ0HJgH0ToVaeaEwPFlSEhxQtQFgM0pEYC2VSFKSCCYJ7zw8CH6fyf4Mjo?=
 =?us-ascii?Q?jzRtjG5ZAwbNGlGmXQ1Mjh7I7IKno5+G8d+ljVfgJTEXEgl/eXHM0CMYEZH6?=
 =?us-ascii?Q?yoxxtFL2s4Yl5m1ns/wicLgi3yJAqxL4wcTV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6nJsMdF2xjAVBeiKlSUrwYvcEiZPyfZ3rOn6Cj1rDKb1YHce+j5NxqpKZgri?=
 =?us-ascii?Q?WVOKHQ5Rz7N+Qyn0AfOR7PZegWP/Ng6lSCDrn+9wKdjT2IO8RO9AA+5NO4gB?=
 =?us-ascii?Q?8BthnWFqk3ReayIFjTn9q8pRkr5InmfWpHWenEzLhnZ2kujS/qjfgFTQ0gpO?=
 =?us-ascii?Q?NMXx+LtDWMu4tf511gxEltQ+izrBezGC6oK2viRakGMnPhmiBl7vkcHxSol0?=
 =?us-ascii?Q?Pxs4tmPLIoXHpJ7aps3y7rpO5tbbPv0zU1iN9YMnglSusv4gt2aQ2hcF0njW?=
 =?us-ascii?Q?5nVdhcY0cz9uN8M8uvyibji2jNN7MlKKJIBzNRdyV3ZzRLDvD+ylANCMFzku?=
 =?us-ascii?Q?l/YqxJmo2WMRjtHJNWtGuazLbec350VqCgQsN7JbNdYH0U84loZj3oySlGQ/?=
 =?us-ascii?Q?eddBXA3F5qEcCrd05cJ1xhl/P2ylQwuFTxduv0apUejfe4o5Od/hR2adlJOr?=
 =?us-ascii?Q?2WztmQBZbADG5bLYJ/rHxp3EmBe8WSHIXpfWV+7BelZr104wI3jb3D5pSBUV?=
 =?us-ascii?Q?iEX/UoTzS8/msu3rouo28B43KfSOXV+GkRZEi9qI52loC02IzbJh05D+cxrN?=
 =?us-ascii?Q?w9U5UXFSd37FOrQj3Sx5DAaJ0SaAx5Ez70NV/D3hUAU6z+JSSk00kA+AUtpX?=
 =?us-ascii?Q?SMbBiExD1Wkf3OhnOym9+zCqMnAA6Gj6gDWXuOr7F34Lcv1TA4ZLZeUN+tJM?=
 =?us-ascii?Q?z/2gnEKX+orJQU/GyOFqLaKEU+I0tmDzcMIjQz2BSlKCF/7q7mx855zNFoEA?=
 =?us-ascii?Q?jNbQsnWf5xlnOaVJFWAG1N5+Pxf6iLTln8oF3VfmfjzxTqFmZl1S3qPeSr2D?=
 =?us-ascii?Q?d2nTv9uXoX5bzPhdHZTkYeELDA/fQ8Fsgl5XZOzwxtn2vmpUGHhu41G7khX2?=
 =?us-ascii?Q?UrrqaKqWB+3NQtPUYjBDWcctbhfCgEUSlXL6otjajDLjbQPfs/xDHc0TzLbV?=
 =?us-ascii?Q?0wUxgN73v1ig6dDhZ6VAKusKcxuqWcTB2lcmjCIszuY+sbBH/i6seSwSSTpl?=
 =?us-ascii?Q?lHQlSdsqLbbrfjqTQIf/MZMpdBu4EDF082CQYVuXcRN77JUXlSIJ09LFtI7L?=
 =?us-ascii?Q?7IoL2QTMeb+J0pHK5gY83B5HH0K3n4ABz+8QhZG94dAmWBH8Vn0Tb/7Lv7OG?=
 =?us-ascii?Q?41lWpSgPhTDesxClw8auW92guexTlGET43DwBzKMx16rRHFnkERF1c5LlZNK?=
 =?us-ascii?Q?aqJMVjbDwY6wobM7x+GMehf3L9lXzneAi2103ImNsshIGgTmeb2LkdKIiJIu?=
 =?us-ascii?Q?lk7rf5kiwQy3MdXpDBlOG10YE/Y8xlEK/2n4QZhvhNfzS1AJKpcB65es8+eD?=
 =?us-ascii?Q?sJ96AsdhTwhbccNmJmUPuPJ79JVcaTvC9c6RINmuL56JXoyCARM701zPukpQ?=
 =?us-ascii?Q?3qNKoXPFNJekx4LA31N+gbunAyXdhjePBgxroe6eys/3WDxe3SY4uuJQN2EO?=
 =?us-ascii?Q?90/RB6ouZPhWTTUZ8R5XCzhxsCPwvXZ0hygxSNSBEIUlthAlNZA3DrTrtqJ6?=
 =?us-ascii?Q?8NetfQgzYCIpqX+CKKCv7wzLzJCoSmHTM+k7sr33broJ8ML6xRGHPlrRVtxI?=
 =?us-ascii?Q?iBWrm5EEyjk4AxfI9hCruv5G/qrZFCvofIjlPfwFfbW78nEFGnpDhS9vuXlI?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432cba51-8c1e-46ed-40e8-08de2713029d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 02:26:13.8737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYNntx7D8Hp7+XHTd5PgwYCwj2vU2GPQGUy/1PlngcxLOeb+tedhVLxEQxxq4p/z0x7fvKazRjZATQXkKNSIpAoQzQLYZzPHeQWf4mZvMW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8068

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

Changes in v6:
	- use items - const for Agilex5 to support fallback
	- Validate bindings through DTBS_CHECK=y by itself and agaist
          non-fallback (stratix10, agilex) and fallback (agilex5).
Changes in v5:
	- Revert back to oneOf and use enum without items.
Changes in v4:
	- Simplify the compatible property to use enum without items.
	- Use contains instead of oneOf due to the use of enum without items.
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

 .../bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml  | 10 +++++++---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi       | 12 ++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.43.7

