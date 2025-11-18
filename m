Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526021F463E;
	Tue, 18 Nov 2025 23:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508874; cv=fail; b=AVqStSPOukwPRpCIMfa6mOpEcdVYHY80UrAIDK4P+x+jlRZsGTzXfQIIquBmObA2NzNRieByI0MHvhQYpIKKiU57nCh2SnbJ1YT92Hu2KnbLSk/NC3QQTb/AvhL+Mye9ZE7ti+7esNjjbAsn/R+DppJRePBvDfkHb2HKkwOWTNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508874; c=relaxed/simple;
	bh=yKMZemTQeNAKgz7t05H9KHBUkp3WF+qNOgyEJ5gLFJM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MqFUuJ5/nsKek4RWnCllmoXlOHjIbVzj+ca7wUN3meM2vTUR7X4dhPx1ayRsCzbCTqAGYBc+UBZWmyVE1Qq6Upf31MjhT9qEuas61jzMJocesKCmAQdCKiHdGXt9cEaGzthq09PyLLQBI3MDYOfCLpw04Db6lpnD6QpaPPX5Bbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=WZbgbuFW; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="WZbgbuFW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vd75iPqVxue4VM1nupono32C0DwkY3W5VGQUsnO95m8FsTOOGeO/s05KnvfyhCA+eggansYHLdubNjSjAwJfAxYNDUweWe73LV3qilKlPXr+EEQiDhqVIeA6CdUFqxlNsUpn9QCWAvsY0hr3xABXfYVS4376dalO4a7e/cIzTjJd/Ex2tK9KycWzJ6/k0LehJuhAqqknla99f6T86HW0t+dNwSWDedadvRHKxgpRgr04Wzlk1tAM2YhcfAjw94kY1b+rYI/z8JHtuNAgVlP1C6iKaLFoq6lHpYPmjiWbj8xOykVK0T51hpAic/PMbN6Dxx51PbFGpS3B7fMQrWgr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4EefSkGVx4a9L7SONNsf9oqTyl16c5hhjHRJaQZEbg=;
 b=tg50jLcyOMUx/aUtYjC5KaeKbJBYf66azrJXjRc6POa49HEuSNE83FzDA/gskM5NbLj3clKUIiZPDia4eA67snmUzNN6w5NQdQOVfQgIHTWWIuJvHL5Wst93Wzf/TvcrUCGG5biS5+5shz1alPNuPntbOTuFVy0dIfPaMNNUOurRSDTNWUYTk8NjiLYrQ1av1G6zW1tUmn0maP5MTDocFHvcRW5G+L8ElJBUpoq5JWF2L6TXMDZDlqBFdTy6g1OJal4DFLekO31514589GjA0jzL699HA2kc2NM4YM9wjGBu+3nqN+6WtfJk197MZtF7uKrEoi5m3LFE5VxPuU/K9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4EefSkGVx4a9L7SONNsf9oqTyl16c5hhjHRJaQZEbg=;
 b=WZbgbuFWesx7sbvasJC2fhGHUF4DzAzjioZS9HdPzdWLQ0sfFoyDQBbIRhTO4sxV60hyNBW80Xtt0k+whRt374rKEn8TOp5LDfwOg0wux/zKg6TNtSceHucmCFkaw9aZkiQOPJ1TEVm0Dt0wpyRAvw93Z8pXSVz1L03bebgvTkb49YnboCWsr7VjPlaIUE/GouxwIDZLi9//5KG3DU6O6DpqJ1VZz7uMfaSLglMIku3a6+mdMj93tMHpwcGK2qWhqlHy/G5JsnUGjrVSMqYnium7WnVgL3pzmx7tp8PNxaczInrwvqx9eBFQKlECQ+6bhoDhwFaWU9wfO5wkQ1G3EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by MW4PR03MB6474.namprd03.prod.outlook.com (2603:10b6:303:121::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 23:34:28 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 23:34:27 +0000
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
Subject: [PATCH v5 0/2] Enable FPGA Manager support for Agilex5
Date: Wed, 19 Nov 2025 07:34:17 +0800
Message-ID: <cover.1763508492.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0367.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::12) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|MW4PR03MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: f25491b6-f475-4a50-db5b-08de26fb03b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ymvS/+2qjppzKTsXwJp7hb/NmNN5NoDyVOhQSc0dMfBTodiXk9HoKUMulAzc?=
 =?us-ascii?Q?+Nv2YjF8g02yMuuLmeiEKP9H3XZz2eIcJ3GsuergfKTKEk+fPB0P8cGWGbey?=
 =?us-ascii?Q?c3Z6HD/o8RDwvby1bvkCGyt8TzeZkSAy0fScy2agRrAfmFp28KH2xsLec3bs?=
 =?us-ascii?Q?R8bmN/IEiVxosQIkObMGSNLpNG7/xBv/xxczzBKoVdofxUtO2afkHVUDtGvk?=
 =?us-ascii?Q?Vu2LcVK37spiuIZ9M/UrREZZlssxzGryXbltGv6JCjlmGGNCySmcsxL4Xqec?=
 =?us-ascii?Q?8XwiS/BQ1VMGcSZUAC5IESmhVoDiXCIzRpwFVbiCeOuWiqIFaggJ8snzCzaO?=
 =?us-ascii?Q?RkHkAfob871KBNed8GcsB7UCrFi5ZH//xR4oljMG/L+/NCd9cxgrIwepq8Vl?=
 =?us-ascii?Q?WZr0wOklRW72snr1uoOL4kdRgh9IujWiKzK8nkvtyq9evNQuklOp9txCXzyA?=
 =?us-ascii?Q?IyFTYec/nTjg4qTbSDtempJ/++LhwYfR6c5BkKjGf1BqIvhUnNEG8PO0GyIB?=
 =?us-ascii?Q?H0uUFx3KZ3nxaCbbnH344noll+ywvoTFQ1z+1v8BC+PUHxATUtYY6Q8cyoZT?=
 =?us-ascii?Q?vLcvQQDcJiJi0WYOVp+ptD1Fe26mDc8blhZ09AfVcTyIAmHn8M+JycxWfglW?=
 =?us-ascii?Q?DaD5ke0gYdWV+b/634J8HoyGlc2hi3llfZ5pqZMA2nc5c7z2jJ4661x8c6Lh?=
 =?us-ascii?Q?+qbUL/cQgkorQCw7yRHrV/16x2Phiihc3pCcQcCqLj79n2h4xzYEcdPVliTX?=
 =?us-ascii?Q?zcF0+/Vx7vXDjZaV34sSwAMUDH0YUjdQaOzyep9Q9fa3Ji3JFcZsnvJ7ulEL?=
 =?us-ascii?Q?K0E+e/tmck54yjFdVWPp7eH/G602SFOmRgp6NsxYwqRmtR5Rk6bQJBv4vExr?=
 =?us-ascii?Q?ZQcH8hxeV8GWruwLTlm8t7/3IYjn3+eb09T0w66bSWgO7gNHbTCTl6ewAmyo?=
 =?us-ascii?Q?775+UosdBgZoTor7He6AuCHQN38DBV9lA1jWD9u/NxrukmPWx5qMJ+5C7bYC?=
 =?us-ascii?Q?U0Cyi8OjGftGcc3h7JNiJLLAF2U2Dso9iciE7zCaJdh0sTt6PqHycZtbjkch?=
 =?us-ascii?Q?OT9aQ/aeGtx1ltrns925PjGrMwSOiHujwjrn2HTvqWv+rCD20oWdK/I+0pmJ?=
 =?us-ascii?Q?i7TSWyo83dvNQMgN+acEsMuTFfVej0tVEOivFSxGp8GfPXr8tlQi62jIjZ6i?=
 =?us-ascii?Q?nOEItoFgsDCaUgPTxPSBKLHQvjEdlocsegE0kENI5qVXMemzeFgRlKh1D5gF?=
 =?us-ascii?Q?l74xi/8/01fKfmse772PmZvwlhSAA7iP1Lv6EWtmhSCuFh+cfLCRzpkKLQix?=
 =?us-ascii?Q?XhyGdbQziQEAkbZrhHwqsgHproKbTN6ihTlqiP3RkzvBOmUkgm+59JBdAw/g?=
 =?us-ascii?Q?dUmFtrzQgrkS1Bj50F/iK2zptn9IISlVMbIyS5/v7fEpSk4FG6WwpujfdT42?=
 =?us-ascii?Q?IyugQgtrmTvpb2eb07Nd0oYEQxY6GPojkWlpmj6i+AiRPgUR+mIyxXpNzyPk?=
 =?us-ascii?Q?tEu6VYphY9phgVBi4VLq9VQ6pxrVcq5TfFHO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JpMXMCBWLpyw9zWF8GqR6kMLdh0p2FaHEFRTsK8/7rsCa4w9b+FRNTssqEvy?=
 =?us-ascii?Q?hO8qjI7rtQBQvTm5ub8akN8W39YF54ZVywBZHDNU+A1BkqxEkMuMAGhUExlx?=
 =?us-ascii?Q?D3duv1wqh76sLS9c4Naim6N64Sl2hU+MZhTAnhPm04Vq3kwv7MvNNLWw2EFS?=
 =?us-ascii?Q?SXIAR+rs0HeXdHVtEPq+awPxbbOLUxHkewlBP+cKYL6V+3KvhbzvX3fRbEeq?=
 =?us-ascii?Q?fQOAcFrq1s+U9mE4GcnhkWV1xuc/FoYT1havZCCU9ufIHHwUYixlG4uB/WSh?=
 =?us-ascii?Q?0SL0O0SOPDJVNFJiaGh2lGwpKPD6Qwu1FDu+eroShawhd6EyLbBQAxcMx0Ev?=
 =?us-ascii?Q?AK2eCRA+1SggjUqLSSjqt6RQih8NskyqxKeE5lXSns3691mW+qdP34qVLGZi?=
 =?us-ascii?Q?nLXQBlx/jJ9RN8WBSnZBKGItgs2qZFNJoOybDYuG+cpCr+V1a+GNdxXJCGP+?=
 =?us-ascii?Q?YX16iRrM7FatqNFioGGHTqa02fdSoxIOcMAY3t0I2aqj67q5KWSN3XnP4YHN?=
 =?us-ascii?Q?Mt0It2/+BMg9xBY5uB+M8EcRGFCa+328nTvtYu0ChEYKXqC3KG1szTCunUdx?=
 =?us-ascii?Q?Qia8qsDTVGTvjWF3+vt3mS+HM2C+f4HHv5v4Ywp4PO/QfUzB1atGT9JFzkVA?=
 =?us-ascii?Q?DRdPo78UddAm28gw4wRYxvcgueS76Jfw99aoSfLI0uO8+0tofmb7xdtM7/AY?=
 =?us-ascii?Q?+BBI6ieyJIQ9N+Kt8g1lzN0V6BZvazMyJVgnPys5AhDRyk4coB18thQzl5Lf?=
 =?us-ascii?Q?eL2Ey0CBu7qDgCaharM9+tiQNmB4YR5AqrELWHCmYtkVicNosoENPMU4OZhe?=
 =?us-ascii?Q?2NMqP1lzEd93D2xjlkdUH77ar4cL5HHP053+PbhmATSwmmbPkOC+5bqbEcWp?=
 =?us-ascii?Q?sHphc1G+TVTq0OmO0jVEhcZpUsPyf+BnM6pP7SFXf8IiMqzuocLLTbAZ6MjB?=
 =?us-ascii?Q?e3FsRSOn5HoFewp1D5pG7k0dfcknHOS5rgAUfZHKA425p3pCh7vmC8RMhNgV?=
 =?us-ascii?Q?1avXcXI/ZOPDjW1YtBbwoso65sWN99uq4C8hNEXad7JfGxg8UsmDShuiamRs?=
 =?us-ascii?Q?uJzggqvgeBk2nn+41vW7IIKShEYyHC1LdHco34c8gI1ufViSWMYc7I4YOq5G?=
 =?us-ascii?Q?WCeqtXZHYmEQjZfihSdOyvUZ99eopXtWNCGXLN1XErHH2sPLJWhgXjiIoV8/?=
 =?us-ascii?Q?r3veJig4UQnkioyETJnJHRh/Om2KmpqB/xcJywFF/kpQNRmtH2hbYS5SaYPm?=
 =?us-ascii?Q?Jr3Bmu6JmaDi31YYbSWQH8cEOMNqWq9aF/GRkyjSZUk7vm/E2w+oBSu2h/jN?=
 =?us-ascii?Q?uRRUJLJ8d4OQhQbzav6fcYsIKpDbeRaEYgJgk8MJfBNXf7JLOKygNYwMzXiC?=
 =?us-ascii?Q?vs9GvuoZRXLGTwQ34NpLTZ6CxCD3dUeIyeAjq6MiS74A8P0gWttjLO5ukYcC?=
 =?us-ascii?Q?0c6hdKf7Z/UaPbui2or4myFsQL0AYZVtSwzfRseJUlsXGcdBC9SaJfcsNjY2?=
 =?us-ascii?Q?9cTJVuCA22859DEp88AX9A5dC/oaPKcjUEGcwy2kgWQw7H5/4VhavRbjY43V?=
 =?us-ascii?Q?3vEem7vwqipI2O5yRzObhwGAtJzkF9779q1QWclNLSL6F+dUzfCNMtXyQm3P?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25491b6-f475-4a50-db5b-08de26fb03b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 23:34:27.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTz3w6hHgQvOeEOMWE+W0WP5145SBOGkBZWb2mrPxxU+/hPTRpsjpuYnksT1KHufaUQTgi63y/Ly+a5CHTWJTOWRM9GdOisQAAOrumpCAJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6474

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

