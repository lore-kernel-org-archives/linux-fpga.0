Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC6B30F539;
	Tue, 18 Nov 2025 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508878; cv=fail; b=FZFmb50/WbT4voaNREXZJtfRx98wZhe09Ts/9TmxUASzkxtlIjWfh7Lx1Dbv473q9TNrSM9XswQxbivGpzt75vc5MtgIt6NorSIqzU3eOEL091BILN+QiJ195OGAkDi9vc4k76MqPqzMy3CCaYcWHpIgl2omAHGqUqOSLfuEH6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508878; c=relaxed/simple;
	bh=yRGP/ZqhxPpbMxQbhmovCyskwVUhbuc9Ui9epdWQCoA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t99n+cZnObQvkMwW9xtdI8ubuibDntvxMbvhqew6Vmxai0uPh6hrvVxAz+h0C2SiTFfU5rXSmefH/9oW0/yf+Yx5Y6STCLWlE6EQ+y+qQD9UGD7zXouJZuxCqeO6ZNCFjefUgtboezLMhjPCbzEHfdFhu+gJyA1T2dG5lLyIlF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=RPD9mHEM; arc=fail smtp.client-ip=52.101.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="RPD9mHEM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5TcUThE73jYfLKy4HdWO9Lz10dR9Lur5TI8HIXLrISbpKO1OMJT4+VV6UlolZMdC1aKlxaZw+fECmgT3I68LAsnmOmNb867tUMiim4m2Ma84b47CWLEBrDsSE22t/00TvMyRb/VQGo1PHgtfmsv3VkvZDwDPOQkbTz9AqrRBvyRNKYDM2PyG7f+czl5+qAY9Ffwma0GI3XlMz20D0It3m9W4p9DYG/c/6eUdQTzPLMqnwwsyjZl+oqKXE69gVu+tl2uDBQPuFrJ98Huo77cFmsTCEh60/DAz1Kusike8lG+XxS+2HIAIo4b046riP0dmni/TYB18DwyIdM8DP4Liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BT8z32cCiumUoQuPGDG9IgxD5hJ5z0V9XWMnl4Aqd4=;
 b=aAerW4CCl0TLbvKv6BeQa87GquymFV0DBHZo8fDXx44JYHN4+f8Tf3Q999mPaNqa/5kepb8BqAJ9ayMgWIcd0Id5o1xGSG8BbLmSptLvqqpGba1TsffVvOSWskP/cEgUD9M/RA4c8Nfqk7HGcjiZDVjXSvTM1MRgweg0CjzQOoAw6Tf+NNA3F6fWSNu62fH+Sa2s3Q3vwbpqAjuZ+ORIQbK4lm1WRdwk4fvN5smNvpnZH9exDAQ9ASmAZgl1LjBQqF3yuUYBw+JW/OqgnrJp7XNx+c+bPC1Dxib1SFUIR9BlwZhE+Kgzps2C+XiRUxvD6/w1ELB8HQuj7w1l1xUUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BT8z32cCiumUoQuPGDG9IgxD5hJ5z0V9XWMnl4Aqd4=;
 b=RPD9mHEMR3eRfkQrD4YIlqm7uT1UCgPmsxRVpQcFFH4ctOfFvrriRVtsGBfBzZp57UJWVVXCVGRvXBCffLN4HfsJ1Xj5s2Vi6tXDCVnqIL3v/GKGVk31dHB8sKu5G67KPBFyJD5/MbKcy7nDCbR5bbEW0FJ7LtZH9NeE2+PujT7j1vbbruFp1AGHsYvJCKEFPPCbAbKOOT6pzw2G1ou3qg3h3pvMAG83y/lDQRV3neNZ0mGrUYt2Erhs/d2736o9KMGMc2zWysFfImA7hSYRrEMfJSwd83JBcjY6y1L0PDsCfwbT2amtX+nXYlDziS0LAfNuIr8JFfEVgHIliBPuHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by MW4PR03MB6474.namprd03.prod.outlook.com (2603:10b6:303:121::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 23:34:33 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 23:34:33 +0000
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
Subject: [PATCH v5 1/2] dt-bindings: fpga: stratix10: add support for Agilex5
Date: Wed, 19 Nov 2025 07:34:18 +0800
Message-ID: <e013899786a6a199627bc56c9766672d215a4e23.1763508492.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1763508492.git.khairul.anuar.romli@altera.com>
References: <cover.1763508492.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5be2a2d6-4efc-4b94-6d1d-08de26fb06e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dt4lJvNKCchWPr9FygIDBW3+kNrCnnEdrXfDgpNf+In8Kbtk184BbzgGozSh?=
 =?us-ascii?Q?NXcMGTYPfE1wWEVniDbR36NEu3KuD5AjRbHQ4yCFLnQqWy7FIdzW6E1zJOkP?=
 =?us-ascii?Q?x09ZbTXuLVA2jtGKqr0/W/JJduMIpoDHG2YpE6Fky7Ar/ClMHXIPDlS38D3J?=
 =?us-ascii?Q?HYKk/oPJ5HR/KmrTzA08k3qosSQIQVbIKMkjolBIMgjCo1FhfLoycZs8QvJl?=
 =?us-ascii?Q?EsULWufLSmguYEhqnJzgao+LA38Ye+u+8tHREjwuFzfUg4A9u8N+BF+y4/0s?=
 =?us-ascii?Q?zerTwhxMt67T6xjjE7amHhVFYoQrGByeqkePX3iJMrX1kXnV8v+vt0U5fwSZ?=
 =?us-ascii?Q?S+VBEqRQiu2n3eZt048Guxll9Z+tmiOhZ132kze53XrWXfg9k3fZQZm37chP?=
 =?us-ascii?Q?LAdmXEFnF7OXKYwZBXbDkqyHoNUZII9bgUqfw34S1zAgsBfpPa1+9Mh+s2gj?=
 =?us-ascii?Q?BrSvgRGnY78fopqNyq2IAEMhLll//AAZO/d2SKtIwmSbIcCBdAQqwDWgstBM?=
 =?us-ascii?Q?jpRK45IKB78x13+sDg9+j6WZ0PFGsB6lY29sjCAQKLjlp0sR6sipJqKxBpH6?=
 =?us-ascii?Q?Ce3W7RyTBqWtx6ko5z/xyIBgNvxiYBeoKOk9OzgKXSt6Jmkqcx03QJ/iMNFh?=
 =?us-ascii?Q?8WoyeG/umV3I9l8GqIJXxUNzwPq+sEWaR1tchN77byL56XVBPGaEQcz/j13v?=
 =?us-ascii?Q?yiZwqY+VdHKB+NiR2RQPp6R0iGGJ4lAjUW9DFnoD57NEnveJXU1GPuGtW0W1?=
 =?us-ascii?Q?+gzNMWLFDZXRsaxj1tF5wRJhK6WFhFXw1ruM2cFeel+4QW23W46QHZg9InDM?=
 =?us-ascii?Q?RrEWnvv55VCJKrM06ruw6GJL+wP5JOytZu5vN0+CuTYDjBZvzDfnVCxvvXTO?=
 =?us-ascii?Q?Ardmo89Ks1L4O2FlxY/8m49KtP7y50JS+TOwNjxHGz0FnH9+Xbsf9fk6qj7s?=
 =?us-ascii?Q?qDD5eKpoupKuo8diVspXOk77LMSZPFO2HpE5D23nXN1DiAosLPW277foQ+xv?=
 =?us-ascii?Q?A8q+rcjAp7lDOIo6LpTyxMwRXDUvjRJovSBLHdvXjBWtMrlMA3MPjyRGm+7k?=
 =?us-ascii?Q?t4DimWgbmEqBbBuUgXykEPzOeBZyzyXNKDBdumaPBSATP2J5GLnbViHgmsK9?=
 =?us-ascii?Q?e/FrJE73xfOdFPV480pzD6o9FbeQ/25eZg0+h7J4FW67Ok0FF5ceH6AlJXYB?=
 =?us-ascii?Q?3LJHeeozSKooMO0JRzc5tUvBPW3M6t24KDUMULefpxbNYFmAen5818tQ9fNH?=
 =?us-ascii?Q?QyyDF7fb914tM9El7jRIBQnmmngVMmGPsWB8cIUa0ly207cX+5oZfaIDNPTu?=
 =?us-ascii?Q?UI0zbo2IbzfluZRsxQKxPz43Fw2kyhxLXVdOgSrW6LTXWIsi83/Pylzx5cN6?=
 =?us-ascii?Q?8pTZ3WvSkENAQ9O/qqsSPxX1fQVeoQGccT7mTa3qilAZNFfbHcNyRHqnWt9N?=
 =?us-ascii?Q?3xggKUeuV4n5pVQ7eL8exyUeEjY7HVsYwSg+LVzE1CdcK3+3k7p66F+N7EF0?=
 =?us-ascii?Q?y30ziU0CabYiwW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o4WIP1mNc2Zz4SGxaNE3oss6ReK6pKyzHpOkTBNTHPDqnLV9hdtxrpm+sj0h?=
 =?us-ascii?Q?HyuU8URMFruMDrPR4DUhVBNVEGGIlVhuF+AB4RnsOynG608XEKE1GC0kWeA4?=
 =?us-ascii?Q?N3H9pYClMOgIfMDDUJ+aenWFqsxhUF+AZwmcxjLZfPk2V6EGJgS2q2sg9rot?=
 =?us-ascii?Q?wq3LH8lKfmTKgtDjuTCuPE1ja7EdBOacQqW6VTNNg0LG6z6DEwfFnsgFhOM8?=
 =?us-ascii?Q?iNoq76Uqo/bqyQ2Ah4qUEJfIsYkii7Gx3ejjciKkdVS882siXuDpcFgUlarg?=
 =?us-ascii?Q?+WyWs8RlbqtcJihfcqut8kOxODuxkVu2nPt0Tv9d4vmHm8e22Eqid3WeXLyo?=
 =?us-ascii?Q?30b41cnphKdxnFViQ5Go5CA1ukhUdBa4PgCKjHE8uWpfa+7NKc/AoiBcdMpc?=
 =?us-ascii?Q?VRS4YzGNmD+5uzJe1HcZHmBT6T79duGZ5ouAiiGx0mHy6/Vu3kYNI+zEwClQ?=
 =?us-ascii?Q?LAcUZXCflZ1VZVytJj4XugbBSKtT2Ss5vRUcNw9Ztx2nHFegPvE88hNPBdz3?=
 =?us-ascii?Q?Sq9OJPriTc3wIljXQLsCYyrSP9MWna8Kh2JOB5TrkmQcQz+FPcGMMYNnDlzP?=
 =?us-ascii?Q?WmahYGR297LkCTUlPABZboYpmrkq4iHRlxfVy04Hw7cAgHSHzJCRxqdIi6hS?=
 =?us-ascii?Q?cOJd9nLNJDBj6alFEpmxpRZFrmbzukTIf6S7y2+oaNf2JrTcYrourxjGQwif?=
 =?us-ascii?Q?6n9Hm8AlU8G6OrgA5nYnfxBsD/dynS4Xk0f7DDMf9ZbaJlJxhvpSPrqbSxo1?=
 =?us-ascii?Q?XkNQj+uEpI7j4jcF1JHPkQQhgT51UtwC+jbEk8xJ79gaNk5uc3hfieurXnXF?=
 =?us-ascii?Q?1yt1hDhnnsmBChdl8OJIuSeraiO5Sgv7xhd+bwoaUe8K9wNyPQj5mUBdwxdC?=
 =?us-ascii?Q?wS+kwAYrpP286U1St2HOGP2yV0LGoQfMTgAljeoqS2HSmOork0ZwlaTpQlRE?=
 =?us-ascii?Q?GLiIZyExlTS8KT7EKm+/Ft2u+eDR24looD8zAGK4ZOuRc6GtzxBf+gAdlLR6?=
 =?us-ascii?Q?76vs079k6wzw1UCwgjIDKTvJA1Yn4VGiXKUJn6qWzJyuDMa+0FcEbazTf0Up?=
 =?us-ascii?Q?uCiPCK9h1GSL2auTEFcLgvZhpt9MBk5h+JXDhWHKem9ii1iLhQVa02cGIxi4?=
 =?us-ascii?Q?WylFoay20qNaPu68DniQLYjQKz2djE8u6oZur8TKlhpiKnlFIvfGYTlpmZQH?=
 =?us-ascii?Q?5filXpJ76RQeP+4SHOOdMcUOAAeeIPyecoLhppEImxGzNyjcf+J5+Rzz3VEN?=
 =?us-ascii?Q?FERGUO+CMiv1DSc0LJcSpTO/ZeeJKDEuV4kGmxrsaFfAYq7LcPpRXNYcKp92?=
 =?us-ascii?Q?F/JRyF4qErV2FEYGFxDgnQFaOwFnlRZqsKvU4vlCPAo7DKBUOyg8Yn68hOsR?=
 =?us-ascii?Q?NYErml9J85dpU9s8MvRDWXZsOqjtM6M7DeTvfYaqczNHB1MGmqj4SBiKH0oa?=
 =?us-ascii?Q?slNI99UzCyzXlHkZQpAsI0AuLci1y6mw6dOQLn5Ps9dVdALOm/aBW3PUTzjz?=
 =?us-ascii?Q?QsxwxoMIGd+bK/3eyd1ueX1ZOvyvANDt652ukM0NMME4/kVADSJmje+ax8nC?=
 =?us-ascii?Q?+fM8STIU2TODkbToXdAYY5Fnd9fuASlvCz9zCoUYpWjnvP5ImZA8KL+VJD3s?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be2a2d6-4efc-4b94-6d1d-08de26fb06e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 23:34:33.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZ6hQE/usWHZPYb79Vi5Byqr0WfbK23bA/ma1yB7RmmLpFs/PJSi6oe0VOeJDQe4S9ZPqhF2jylrsJlOZt/dGEkKBM9UxW2Ayh9yu87Qtog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6474

Agilex5 introduces changes in how reserved memory is mapped and accessed
compared to previous SoC generations. Agilex5 compatible allows stratix10-
FPGA manager driver to handle these changes.

Fallback is added for driver probe and init that rely on matching of table
and DT node.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v5:
	- Revert to oneOf and use enum without items.
Changes in v4:
	- Remove redundant "items - enum" as suggested in v3.
	- Simplify compatible property to use contains instead of oneOf.
	- Validate fallback and non-fallback DT. Also validate binding with
          dt_binding_check.
Changes in v3:
	- Add description for Agilex5 Device
	- Add and define fallback to "intel,agilex-soc-fpga-mgr"
	- Validate against Agilex and Stratix10 (non-fallback) and Agilex5
	  (fallback)
Changes in v2:
	- No changes in this patch
---
 .../bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
index 6e536d6b28a9..14437dfc47a4 100644
--- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
+++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
@@ -20,9 +20,13 @@ description:
 
 properties:
   compatible:
-    enum:
-      - intel,stratix10-soc-fpga-mgr
-      - intel,agilex-soc-fpga-mgr
+    oneOf:
+      - enum:
+          - intel,stratix10-soc-fpga-mgr
+          - intel,agilex-soc-fpga-mgr
+      - enum:
+          - intel,agilex5-soc-fpga-mgr
+        const: intel,agilex-soc-fpga-mgr
 
 required:
   - compatible
-- 
2.43.7

