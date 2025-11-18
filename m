Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C026A09B;
	Tue, 18 Nov 2025 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428320; cv=fail; b=axSuQFO5ov72sLMbSN+zkv9W6gjLhzzTSa3+VKX0vABhkcDfzTk+ZNm6Jnh75Vx51TpAs+eEfN2UUQ9oG0ZULYuCCKnXvPfgJhKQEfXrFH2KdMEQ96ZxtH3prAm3VP2maIfrqTtkN8CSPztgbGtC9GOYY4QouJq123UUHjpdqNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428320; c=relaxed/simple;
	bh=bjM46G509pwIBMSSdWfnEVgdSLJ3CNUgsyJ7HDYBTSQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QigY8T3nFgk+DqoNeLmmRouzfK50q49pBoKvLOXZNe7zUcXAMBWZPe3znFtTJhjDFu5Lqm0pt08T0M7AL3HD4vTWDCKAbJuzScHNk7zRo6BwIx42DfheRYeTMsnUCHRJBT1UhpHh+6EyX5ii396uH03UHJDnduZVo8YLyN0qkws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=O52dKjsF; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="O52dKjsF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yo8Anq0nUAvS+NtctmpYCscqeiz1JufUGDzY2HnK3RlCPfxoLnjBy3+SX/akypXZl6G9GwlBd4XNeR9BTLzqdjKCTRzzaLTHzagS56LHtmaYokMTlpn9AEjHqnSW4FVu3F5sjIRbWt4Edp60/I+3Jppz+5NgfgC18DnEcPiDaZY02rT2hah6PvLTeING1n38Uv3tEp6EpOMZO8ejZ6ctCth16KYZGHp8aRB3b61zAJnZEPOhgBMcx5ePD88lRb7w91UBX9i65cDy6iSk9dvEoQCyIUHJYDS+qq7arpVMqkKEQmkUSfWh8Jo+nps8bNLUxjttLwJxCDSzP6i6bLjLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOsD3KPbaL/W5dG0kAuin/VLKnVSlvyRCwX1YytL4Qs=;
 b=fLccNwHttAoHdK3rFO9USHT90iKHuwZdLrFIdB5JUFEAUGIrzadmBnm31Os0ZAZN19iR8dshss4fauubJ6ZqwJT0VE7UhKmsXDNVkOAp4mkCCegRY2waImsuoqorQ7nGJCOIXRh7ZLAnf/+WE0TwngZIh57zvy74NU5qsHYssjpRsFv9mY6JXnBSUp0YV+J0QTkn0VDKO5Hiy4UUJtqvDwseS4D+bXzn6H6Lq0Q2N2eAk/NDc5Xb7kNERYqdgESSvqTvgPH10C9EqXPJJ3JjibjMCNWYzpdc9zKtpgRrFsbfYOfE6TZ5dxWbSvV4QFwfogs1yyBz8LCn+K9AlXJCVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOsD3KPbaL/W5dG0kAuin/VLKnVSlvyRCwX1YytL4Qs=;
 b=O52dKjsFiRojaDFssuGw3SSK6xvmFo11wi4iqiYIU4WnTPB2Km8e1g6FsVLhOo5HCJe2Lji0F6ukTkTJc02cSr0qGvvVvjj/EVr5d+X3MBc6DJTtu9x+ozyCfMKr59l7KGXMVomfzBRNzJsrHKaqzugAUVZb6rmvbKZhZtM3POlJZFAyTjSMEg7Ww9N4Ny6sM2hx1e714V11OuImIzHLmPBD7Y2FHd9j9EngTYQwwbfkCfa+g7vAL2TYc6YKRGWXkOLxYS/Kxc8ehAEUxuul4Au10wY7syPZ5LpDkm6nlspiED4WlbmoZCrojBhRCnpFeVfiNw3RqkInwTfXxXr6bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA6PR03MB7733.namprd03.prod.outlook.com (2603:10b6:806:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 01:11:55 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 01:11:55 +0000
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
Subject: [PATCH v4 1/2] dt-bindings: fpga: stratix10: add support for Agilex5
Date: Tue, 18 Nov 2025 09:11:42 +0800
Message-ID: <79a58f075488733cced8eadd566b0b740a59094f.1763427266.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1763427266.git.khairul.anuar.romli@altera.com>
References: <cover.1763427266.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: c53e396a-2d7e-4aa9-5d35-08de263f770d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XcR4p19b5o6smWq9oEXIaF4jpun3ksO3ufiZvmQWt5uwYHEIwPTuzMvb/Bgv?=
 =?us-ascii?Q?xGv2ORmAsa5RQhT3gvE2R0+AhrglMk8N1HLiS172hZl8UZXrtKN3RC/kGsWH?=
 =?us-ascii?Q?ngnO+Hzz3VEPP/CUaU4WRXbtsx2FZMqtfw4A7Tp5KbT1mI4fYrAESX8YpRUr?=
 =?us-ascii?Q?FYWgNruwWFybn0C27mv4MUKIDQDC29REYDEizPeko01fRJKhfIRwxZwfA8HL?=
 =?us-ascii?Q?pk+Hh/q7uCjGe+uBiJq395zwlPnodXTNNIvKYg9x6e5yYS0u5Bo+2l1D0YKz?=
 =?us-ascii?Q?mgXrOQ/WO0MymVdyJC5AbodmAYK9f3eK3+/6aIT7rfwgPHzdaP/7GxdMlg5z?=
 =?us-ascii?Q?v6oMxyIXaSdU6S3S7vrCd3RaOr0AOwCUY033DOh/WOt489rayV8kY0Bi/TnM?=
 =?us-ascii?Q?WXFPIoD6PxJDARCK/fv70I6rnZL0uNIgois+2GpQxS9veRPkvYI9jkhzpPdl?=
 =?us-ascii?Q?NWH80E71zgHvfmCWKC83nLA7rF6RTnDLVV4fxEFIMXBYW5c35BGlsxCyLoMS?=
 =?us-ascii?Q?VL0cQisZdJg9JxrgeUJfqqxA3mfqlAaXPlQA6konPIDubYjRizAKBgE/pLEd?=
 =?us-ascii?Q?17MTHBGdObQWWcsSxlcZmaCcmbi3gU5F1TArhGmBKv01+2IZP7SEMnbuHjrQ?=
 =?us-ascii?Q?FtkMosZpKnhIYtEm8qhQrWPjQzqdtCjQPm85i2iPD8l+sjZhplWFg96f6O3Z?=
 =?us-ascii?Q?YdkVbaqFCz+Qyh1J/DfvsHW0pCleQvo59oaquo3rqG6giz1itv4IKUUdUHbV?=
 =?us-ascii?Q?d67/aMZU7kUOZ4Ivz+pvIalNsFNXFm66MTI1jGPRon/GZP701wl6PtAoXmUR?=
 =?us-ascii?Q?/rhKU+sotzXqqQNTBfzgFCUZ/pmVFmV37FiPjLmkrAfePc7kXpzdvhRIh0uw?=
 =?us-ascii?Q?Qw2WNmvMCSIDxoqQNlByPlAXT/A43lLhGn5wtfrxBaDqvYj31A+XfLZIpnqU?=
 =?us-ascii?Q?A14bbmQW1domTozVs+PYYE1ijEqEevtN0mxWKagxxvaVLy1G7e5aBQljs45t?=
 =?us-ascii?Q?GILrUY5x07cIDHnAIjVRlSWWuo+7T/kTUxRW1ZRoKiz3khEebYa0rXYjUs55?=
 =?us-ascii?Q?9X8aydNzIkGHyXty4ATuae+DyhjqKRqC6J3EOUyj+8zVw5286UCQnjN5JIIc?=
 =?us-ascii?Q?1oMIUJS+da5QcPlRz+bxgVGdtMta8l6WgJBgKd6xNCawsNygdSOrKBqVk5GD?=
 =?us-ascii?Q?N/n5iFl7URtLUpPBYUL5K72AonG02lTiie5GFHOK1n40/1iwX/RPiLbiqpxk?=
 =?us-ascii?Q?970TrsJbKD6inGZ9ajZWPY5s1g2Jw7RvOOb1JEUfdwU3Ep5yROTj3Q+pSggo?=
 =?us-ascii?Q?jYXUISnNSA0Cbdc3zUK1EZ8fSstE/s1+xJoox75U+TIB3BAmk1TcbX7s2oeY?=
 =?us-ascii?Q?luUG7hZb3s+N2b2j6pfp/PZEzZQzMruYfqB2YnOm86oZbjPFIs9kq20/YEtZ?=
 =?us-ascii?Q?JbKGb5D5ldebKnDD+bEd7lfz6tOyPGrBjr6SnCRD3ZTqthkXRioaP72sR/ZM?=
 =?us-ascii?Q?y2DaQfqK9ffLmXQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zEg3T/CeQi7p5LC6PfE1pdpux5dw2RYuS3GctPZ4sGKWx5S+01dPOx0J4J34?=
 =?us-ascii?Q?RuXFMi7GrVLzmvkOKKWbopMc9D3CxjHEIDIwIWYig60HmZ9rIruJ+jImERck?=
 =?us-ascii?Q?hNMrjMSgezQ8gF7G45sHPyhGjU6Z5FSC4WwfavFyL26V5G+D03wGuRutlvuR?=
 =?us-ascii?Q?rygaWtXXI3GArOCvTcXVmao+/OCiq0bVo5gbmqGRGJvCyt/uHL8/raKnbQui?=
 =?us-ascii?Q?xRSvUWTIQ8EFoP/estGmJsR5ZQeGHgH15NiMVNZlPRvy8RaGf83d5tuw9MDj?=
 =?us-ascii?Q?yaS634kpwCup84VtLp2pHmc8FNQaNvS+F5DkFgrF8OiJ+Yi9YIS2+N+p0rlj?=
 =?us-ascii?Q?6I2SsQRr15g/q6/dkGhXWk01ilToSA8qDip2T4RH5RLllfzmeZaCr7djGPPK?=
 =?us-ascii?Q?Mfe1U/V4SgWGf09YVKPM7zInFCCMuBZqNW3fa9TiaW1Id1SjqtpvZSVFB9QV?=
 =?us-ascii?Q?CcwWPqhURQH4ZVpOPqzgh0c9qMdhZUqQgm53Q0Zjmn7Ja6XQvimUlSqiabpY?=
 =?us-ascii?Q?wIuYnevgAFritMubtm2HxdA32maLVSn+pN+TzjZqlp6D3alit3GmT4/Igx4H?=
 =?us-ascii?Q?/zFO8viPRmjtclWwy4ItLMtmwqY5WVXcPKTccTBBOYe+C6aIYcN3+/8kloiH?=
 =?us-ascii?Q?gk6mCSLtiQwvwuJSPVO3sqeJp/685MO52KZ9oeY196e4tRPRrDSNEGXByzGt?=
 =?us-ascii?Q?7yheFDGEvW6VGS7YLYnZxutU08SCSCaBO09I/XJZK05x6nhbxeXNFk2tG7s/?=
 =?us-ascii?Q?ypxSRbmW/sx1cpeeI4xPRN3WrRpr46p/RaMNe/ApqxNpieCIj2LSlUEND74/?=
 =?us-ascii?Q?+Vr2IU6nLM8lrdMecDpHzY9WUfLhuf3lGaomcUI6QC6WVd7dSJWupvSryzvC?=
 =?us-ascii?Q?7lPlDWUTI2R/wUL0EIVkT/ycEyrX4dSGN5/KsXG8bHSFP441YFR+aWvP86et?=
 =?us-ascii?Q?uFxWDy2oA44LuaXRywmMqO/Ej40o5b7YdbACVLmwsG0o2x34B8YvRf3LSbLa?=
 =?us-ascii?Q?TCjoziEIhcJ0EyIBjkuoJk21UhOs/ZNkvb5FNuoCuyVghQ1Pn/OkhF07Mcj0?=
 =?us-ascii?Q?kWyO4aEaodE+dfsVtlhxBPZdk8WdNUugVJWHt7gTolMqDmpcRwoGoAH0wxjd?=
 =?us-ascii?Q?1oRbx753Fejm16JM0Wzu+RZnqIOLyWj6e85R33vfPgFmtGRpbvEkBToJoIyT?=
 =?us-ascii?Q?RRKp13udIK9hADOYWLUc7OznmyIH5xq1O/EmbZVchCZf+3sELbUDV60YagE0?=
 =?us-ascii?Q?Phb8eQGimD2uSc3maoPOVhAeG56F6BvLKFY5D5teHhI8z4pYb5BAnwZxOe+3?=
 =?us-ascii?Q?5ClCDV/9g/pTyCmduDlnnLar27+9cBMO0J/Rwb+NT2vllFMuF7Fzv2gquoQR?=
 =?us-ascii?Q?7u503hiCLHAzKJAwncJ8Q0ByWYHUj4xJDDlmlwTi4eRC04Xm6Ki9r6VS1j2C?=
 =?us-ascii?Q?ejqMz3MmwCYqbIAFfL3IOWM7yMJO8KdxOefwGU8BVcUqqsEvfhgLr7L8S084?=
 =?us-ascii?Q?gYWwJ8wmWK/zRssF91QXyJyPqo/7qdAngbvwOJgriR2dg4gZl/IO84MLgiAT?=
 =?us-ascii?Q?C/tWKrU+RGhumdrbsaRGdcJLhW+d7TUWbnlA9mqrnCPPReUyuJq5M7MjquMb?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53e396a-2d7e-4aa9-5d35-08de263f770d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 01:11:55.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOwaZHdRK5BZelwm35RIvzr0oTeXIx28qScMlClg+H0zNfVhgE+IMkmd8EJ6QAsJ9W81V0XlazIdkHx+idppNamp5w6OQaxS89XRwfqavpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7733

Agilex5 introduces changes in how reserved memory is mapped and accessed
compared to previous SoC generations. Agilex5 compatible allows stratix10-
FPGA manager driver to handle these changes.

Fallback is added for driver probe and init that rely on matching of table
and DT node.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
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
 .../bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml       | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
index 6e536d6b28a9..65c737a4734c 100644
--- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
+++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
@@ -20,9 +20,11 @@ description:
 
 properties:
   compatible:
-    enum:
-      - intel,stratix10-soc-fpga-mgr
-      - intel,agilex-soc-fpga-mgr
+    contains:
+      enum:
+        - intel,stratix10-soc-fpga-mgr
+        - intel,agilex-soc-fpga-mgr
+        - intel,agilex5-soc-fpga-mgr
 
 required:
   - compatible
-- 
2.43.7

