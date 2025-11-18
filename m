Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D51FCFEF;
	Tue, 18 Nov 2025 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428318; cv=fail; b=N1atwFDCHubkyJjG2ZWE2MwJAu6S3qGQnqKsGiL75FJZ1DaTRHKchMBQYYvXrHO2FITLLSlVHi5k4/JeCpacYZV1oF+JYdLXqMQaCSK68kuc5qhrk93lhs6+Y2YzgJ6J4qGFuVq8F/YzCCQHx6Vspd0tiwvW8btalO0zuacE8Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428318; c=relaxed/simple;
	bh=c6AJt2gNKK4jOiWhkBBqV6Q75DCSERIuYlatKCxdYMw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rgj40SybT8HjiKVlb+BY5C3cmizSIbEIo1VrpYp+JAfP9rIg5lFuaheuqoxoig2reJ5hsaxMwABwNlKEAlyrBgmulX/P87yGm1Bj7rEO+agIxUxnBP0xuPTMxhEiuF9C77n4Yr+Iz60C9fUNtimMs9xpTnB9stGvCHJd2fGd2q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=df1wkxrB; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="df1wkxrB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Un6ADWBAeKTfBikYVx7ioaPf/TN6p/Ishz46p0IoyBTsfi+fA3OQU85LsBi5MrxxMcSxm5DgKj0UJb4f02I8l4edk4+DDlDv0pSjTJ/rus1PHToL5yAGVLxGkv6QEAO/fN5HsLKaHOqpcM1ibJ6z6cI3j/j8d0RYVNIS3jVqlku6zKfw3TTtGJDn15iprO8tol5Yti6YME7l5pLUn22/ZIhvujjuE+dM75jb5lad1k/O0lNELG1ubtTnhN6bAY7IPMCMYx/wY/JaglgUUFJXak/EqgRLqMXTF44B/SqAMerFAtsNwRa4z+m4578mRnxEAYz0UFreLDFLzY6PtXSTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5wIDz7+4lMca57c3ufFJ+xN3rAQVHtAVu6i7OcmvXQ=;
 b=nYQHhHBzkT02c7vX3Y0IIO4RZ4xRlFKw3febgGpD+yNmv4gX4tzJhtC0BemYS+zaYUNpRRtrXsCshBXo1awZtWaXSA8dXrRSiKpsIwt7RTRrIapTX9pGZ3FxWAz48r57AB7FbHCtGRAjOoG6RI8NHJ6eNybF4NiwI0cCD60NRdy/Q6hoDWgRzZBdKg+Goms5WD5ms3U4NFJQyVdXt74v6Fm8U2ufKEy0wj3fBpQH5ytvSkypOgH3DwNvQ76CrDQLwIo6RdfIuC3XVc5QTILLSSySm9z6efmI50fkKRuB7+B0AyVoQVW1iha0wtZ2Z3KbzcajLnlsr2zLLSDEwhSPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5wIDz7+4lMca57c3ufFJ+xN3rAQVHtAVu6i7OcmvXQ=;
 b=df1wkxrBz7FlIA7l4snDaxtSVIo3LSzw4MSSaPSwXVmvrxuzaHJGz6CGTpMYvIccyBQ8+nlaHyzZczCpq50qSi3+4jLJ2mlco4S/2YggFd0FajHrRDDrw8Aka08LFjajVlsA8HlFvPMVm2hDQmJx8hyiUkEaZJoLeBMWuOKWPjcabKxJmjcCByZx3/+VVTj2ODArP0ta4TV0UZazoLQBTTsjBWeAFuNTMoCyWmoYLvT3lTiQGNnohniildFFogi3zb95LVZVgkWe1HLkzgP8DsFxDjRE/EUMx/lao8pHihc2VSSuFF1L2S79P/2RqA8MpjO9TG+7oX5JQivQlnh6Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA6PR03MB7733.namprd03.prod.outlook.com (2603:10b6:806:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 01:11:52 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 01:11:51 +0000
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
Subject: [PATCH v4 0/2] Enable FPGA Manager support for Agilex5
Date: Tue, 18 Nov 2025 09:11:41 +0800
Message-ID: <cover.1763427266.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::33) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SA6PR03MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9e667a-6964-4efe-b2d3-08de263f7409
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W6PNUHEb3CR/uZzeUE58NycMh0Qlw/HmcfuVFE1CIi406yAP1U3bUP8qLNW/?=
 =?us-ascii?Q?N1qNu4gjXc0epjDZFZEaMIPb6lKBf5G2rQztGKgV2g59ZcDDEv0wfwLNOJX3?=
 =?us-ascii?Q?7vhQ1WzAgwHGbHOx5nktFfbe9annWw2kX+jNeQGvm8el2EfviwJfL2/nG3S7?=
 =?us-ascii?Q?aXWHgzaBV6+JDYyy1/XVXuf2sV4yZ5QSJaYzusH97cjfS8+tHL+LNx9hg+l7?=
 =?us-ascii?Q?3aXZcAA/pj5MWxmwkyiH7rB4fNwUORP07r3MrHollnQCcB/jk8PyLWfpSa+A?=
 =?us-ascii?Q?JP/Aea2FIvc6Z3b07mSPRrmVlJjftLRXURgtY0tanc76ESTeF2CvEG+VRkJX?=
 =?us-ascii?Q?505n2sHomvkOSk9UlmQ9BmL97N5z4rHmp5MKEsT2KsleqaRlJyxY5oJK96Ty?=
 =?us-ascii?Q?X/823o6MQ14gjC3DjZwXdEb7g+CJWuR2NnfdsBwOLjOlM63TTVjFi/d8ZSpe?=
 =?us-ascii?Q?osNPrKvBzXmBM3DfPpWtsQOSE6mc9uJIeHtTzAqu+DKbm3LZzOkKk2yt5s2O?=
 =?us-ascii?Q?QSPyZoztyZ5Gs6SdjoC0lumMI+k3Ey1tIdEebBWbkMJm8ttOzacaI8feXmyF?=
 =?us-ascii?Q?gUl0l0WVgpj9Rt/NKfvrRwc1gn4/637NkTZVosokuHTHsn27iphdMwjsopeu?=
 =?us-ascii?Q?X8GH2gQ2U4cXZWSgBlj5ssU81PAyvqlW/h13CiUhkTilO7t+7jdgF3AuKr54?=
 =?us-ascii?Q?8vA+qRy5Ydf/ZyQPtjotUWbT8y0Og2j0Yd/UNZX7BfoeBKMenMGlUoADottS?=
 =?us-ascii?Q?e249fP/k2n6S4yHwqpAWAAXHEL0e9Ig4+4wuTxTJCoSnWKOSnnKRBzSdfFjm?=
 =?us-ascii?Q?nWESVG80zN3iCWy9mHIDyg6zb7QabwsFxhm7cPMipzgZQ2LNwrCDqTK+L/e9?=
 =?us-ascii?Q?/lqbIvWZhdxGy0QwGfy6LJX6Evme3QEPjOFTHYMTaauRLLOZgSnPmiH8mJIg?=
 =?us-ascii?Q?FAxE/7thcJnIIBA0o17rAqLXs5UWBGZS8Y+eeGDlEdIlxLvIdonQNelahLxB?=
 =?us-ascii?Q?jj6ZLF6x0lfrFKb1tYlWen79B9vzY3qMsTjQO7+PYPKvVsK9p/TXUQtpPVAK?=
 =?us-ascii?Q?v/IE/A4M9yr1s8JHeXjwLONfU18nYAnT/Czmu4edzoq+JImOu2mNLijg0VsF?=
 =?us-ascii?Q?ydTdYiumkMT6vkU2Br0e7yMzshv2lkMaGsyLFX8qY6rTejyDMuqbZt2bhkQd?=
 =?us-ascii?Q?Ho3P+TScsy8lxSSRYJEySTftuYCc0srUyZZHvLEdnqIkoLBwqCoxxrKPtfTn?=
 =?us-ascii?Q?hYzQjvYlJLueIgHqrPTzvTOSfpa/7hMaSZjqjZNcIMpdAh/dTh8BDOJaz+PX?=
 =?us-ascii?Q?D6bGcPLRnA0H123oz4yajfCtLTQsFzVHQ2OEgZgU0mBXKPxQ7BVHe+ygBs/b?=
 =?us-ascii?Q?q8E5gcb0ZpouRv8oZ4JBtfRIq1Dtvc6Ggn050WZSOG7haJfJ8No/jzfjA9m1?=
 =?us-ascii?Q?zIJE8bVUxs88BMVS3p3Zbrvz6NmlOtmgKElEAqx21ApVC3PiTBgakrKg6o+V?=
 =?us-ascii?Q?80WPeTtjqFbEU+oIy+IqqR32E61vLQB6JU8Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G9PhYpRX7TXOuGleRHMmgwwjIX5JdWo44V5P3XUGgYpxg9XIz52yaO4wyuIp?=
 =?us-ascii?Q?877N2SApRYMKxfzuklgbJXJ8qmvn0PSAIkJ0QNnfvfGImOLE275CNiemzxLE?=
 =?us-ascii?Q?1RzN+kNDzTX5Vi/iitD1esq+kZSC8ESKpaOrsjVFqo2L4bSa3JpiPVPRv1hU?=
 =?us-ascii?Q?Hw+sgNxnMcFGCyK8lI1D8MvYYTKgjUVZlq1HhNFEaQ2YD4N9gc5JcfkQ58Cw?=
 =?us-ascii?Q?HY9QQd2gqe+6GSLYPQYaZx/jSMrTMMZckXmeWyh6RPf3uZtXcO7qt9E7ychf?=
 =?us-ascii?Q?hYy3Fyw3m61t6rMdQwymk9Fen9Vecaim3X5W3dedkRPKV6G8fbLyhIe5Yr43?=
 =?us-ascii?Q?J3ge3tinj36WjZsUyo1XbNLMEksVUFE/eyWvtT5/HSv1LB0w7/HaunCNQcBN?=
 =?us-ascii?Q?8GlhWWESVTBKaGFlBC2BZFytP7EHKqD6/vj3CAhu1Rs/JXKH5ug0DCH2jqJY?=
 =?us-ascii?Q?jm4lx6NJYi3jV3X5dz6m8vAwORq/hpRld1rT/XpClPNWViFYR/STs+b9ogqW?=
 =?us-ascii?Q?q3o7jMDy8+2bkQ7KBucjKbfMaxiEMcGwmcoBpwrbHAvHYQucKhOzWH4Fjoy/?=
 =?us-ascii?Q?PRZf/1wc0pP+CVAPox+YhXiQ5Mi6AVKjQc5KQPD3b66Fg+dRTwjfFLGRrbna?=
 =?us-ascii?Q?bfOi+rdpPfYJs8aPb0dtRNQ7s1K3f0dLryE/O4eZH3jOILtCFCr/TNbgcSb5?=
 =?us-ascii?Q?zIabceLv0g71gLeHsdTQq4qt/YSTIH8IPTkjYAVBb/W4qqEzGbl/UKBZ+CSC?=
 =?us-ascii?Q?+DWbRx6j6RZDjYAtrHLHHx2XcT5RM1xOvk6kXvuONawnBSl1NvTF4mh+TiM6?=
 =?us-ascii?Q?o2Pvwe6IswQYFhd0l0ytXzw4MYvhV3DPnlffBVsRiO0ZZt45eGgi8XTzwQaH?=
 =?us-ascii?Q?y0fIYCMt5rV3r7LExtS1deYl7O5KYbtjfegqVOkKsj5OroEAzWb3M4qFkA7H?=
 =?us-ascii?Q?lhccTrCdD/kxt2XIMRqyLp6Ssv+e3RVBTTlwZPde2pcHoSxhuZwCYWG9hrnb?=
 =?us-ascii?Q?feaw8Rp9GYP5UxFkDkziGlPDzu3jhT1ct3/ZXXEMltZAu0sD/i1sIS1BWSgr?=
 =?us-ascii?Q?njNvs65lKpbffpLPA2BSCWs8CeUxcnW9DYf6XKAnqBx8uYj47Q5gBgq3/XKn?=
 =?us-ascii?Q?4OB1Cp4l5HkmJzymWCCqzZ7xymDsOKZYvHqAA6289HBcP/QxmtDm1uLcFbjp?=
 =?us-ascii?Q?R5ulChA0LZNw85JE3AOvF37iiwCsTeVwBU6+iCFlPRpJVf9fVvA49BoehEJ8?=
 =?us-ascii?Q?qt9rr6i/Nfma7lXhAzE9auYu+pcfuJnxYhu+neBxPPV/WvRAJJaj/nL2t00p?=
 =?us-ascii?Q?4+Svqv48o3QawF794Q/j3YWVT2v3RGfB6Z0Zff2AEjDsHbH0uphjAB81+6Pf?=
 =?us-ascii?Q?WeypppD2UvGmfrvD/ff8AYO335eRDQCJkj6T9sY+U0KQvEMTtlNEzPQj8rM2?=
 =?us-ascii?Q?3Oj13cWXuGIksrcl1d+bATPvHri+YKbr5VnUNdZHedZrhXm6xLjm+3Rm8Nkh?=
 =?us-ascii?Q?u6EzcnU3Vv6N8cReJjS1PIe6UTSBrBJLVREIHBzNIYILJlpUZu3XgPVtMGSF?=
 =?us-ascii?Q?gXQJgQ+ungJk6fDGhk356xRxcdu1J5T23dTougQerUlFm2yBbGsn7XhTbIRv?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9e667a-6964-4efe-b2d3-08de263f7409
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 01:11:50.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /b3a2MVKmsIeqr3n5O6i5naASHX9/hXLyLTsFy5hHb3hibd7A6tRHZWL9K6egDnSRU7UIEUwHUtvCAU4khqD1ORF6MKV7Hz7Gvb9QTrH3Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7733

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

 .../bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml  |  8 +++++---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi       | 12 ++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.43.7

