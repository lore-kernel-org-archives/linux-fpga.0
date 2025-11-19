Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9AE28489A;
	Wed, 19 Nov 2025 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519183; cv=fail; b=o2MmBAjJuFB2sXpgPxqmtxxdZltoZiOAb063wzZDQfkptBQ//0uhW5NOUnl1r7Q3Tq4dow64UUN9t6N7yPzJqenXJ0867UFhzguTPqpa3+01TfGiV9VI5gO9esiSzgpeQRKyB6nE/blU8WJW1pRLyme7kAZ2pj7KsJJAWYyaIvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519183; c=relaxed/simple;
	bh=ff67UPsuzkYayUkirfmzaO+NnOlI+dYfkryliV1npnU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CslybqZ5+n7nEpsrAyPrgM4RZhzk+zrZ74ExcC9RXBxA3BQI68EGgvLv3ugsJMSZ1qDaeeq7gDqY1oPPgtKGnwXto0fYQ9e5SX8B/9ND5bK01e7bPAGnY+8NCjMQfewcI3xvF+gPC+N8gVSYdHXm2jcVI4j6433zjQ/6lDc0328=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=aRhrgXjY; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="aRhrgXjY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXek2FviLCfsXKCkDDHCFnnqLOreQS2PAN5B+2DKGi7Lx81ery7YL7P0BoOTs3B5T9IdTxo7KfJ2z6hk9GOv1MnYZX8AR9hT8YMOBgheEgU0ZfL5mIt6Cdx/r/T3gcWOScQRKECDUMfV8guR2dmVpDDTpOCajfIbt9zpzmmdMXEfLkpSzAx7ofEI86b3cSSTFN0pC1b0N0h6XEP5Z1fGOzlMLIXF4fjCMQm51Os+t4pVDt2tmy4aSOJOKM8/RV1Zy3epurNJbxCZmpVCHy8GQHYUYz1e6APgIQUxNTFlyD9lnyS5GJkdAe+7nNYRi+Ah6S3MpWuvAQHQUIg8EKrR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvzXaiYFjA3OBGMcidEqWlwtfVG1nYONlFn+LbJSWdI=;
 b=k4EwPBE7ldW/2UUld9+MWoeZ6Ggp6CpX+1fWzGCfCYGItu5zeAIYpfp5WpmHSxRW4e7Fwt3++UwLli1lWyfFlCGKKhpz1lNxIwa8KRV0/QI+o+Mirhcbf8zUgQYukt4yLVLv2lvX+W29Ist+HgqGMCBYmTX5SRwP1J9j4nsaOofmJ1sRKM+OI8MJUIEWPjm9mYMuZpwxQQzZH28+9aaMR3ZRBE7w+sv+d5atXpxc3nNGEon/ZKW1kMPYaARt+JXEH2q2FjIbQPNy9VIJvwuO1P0c4Q83muMaVblTtssUP8WVE/nmQDAsFtTS6dt+7d7kL9EVlf8jgDl8t7YU64mDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvzXaiYFjA3OBGMcidEqWlwtfVG1nYONlFn+LbJSWdI=;
 b=aRhrgXjYRLGtcm7bKp+Xu9CjTdfZ5FZciSfskovMeJEokb1PwhDBFf7vjJxd5dq1yziKtaIwc78F0JIGl8b1Bb+qilHGBswOoDfHvJXgDd9UKiX0lfmchmLbcw086pZiI4I6b4GLEmejjyjRSzNfI1sLoZZCI+uRXzr//7dt0TqaXVVgZXiXPsWPwOa+bc5d+LegWLvqIWyJRPkvB+c+f/zeSuqwKyF56F6fF59pz9Q3YfZmyYWWm0ILI1ts+SygBWhNrK3fkg1v0sNO+42ywWTcDUYZ6HZ3ZIMqOJ41M3HAV1qExQXkha2NlrOs1lHJlInxlzxptUYWAd0j9WZfPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA1PR03MB8068.namprd03.prod.outlook.com (2603:10b6:806:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 02:26:19 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 02:26:18 +0000
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
Subject: [PATCH v6 1/2] dt-bindings: fpga: stratix10: add support for Agilex5
Date: Wed, 19 Nov 2025 10:26:05 +0800
Message-ID: <2092d4572e9772a30e8f50cb39d066c1c2b2cad9.1763518321.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1763518321.git.khairul.anuar.romli@altera.com>
References: <cover.1763518321.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e9e8096-eaa0-4ae5-1f43-08de27130597
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2h3+4+Vh1C5a+zsa87NtaUNbWYTVyPSrNiSIADdtjdYg6jE3cQfeNuOqz72p?=
 =?us-ascii?Q?xMw68QgflM4OmzGxLZeFtSkySGIyvzQahcNTg+ObJYaIP5weAsZYLKCSZkHp?=
 =?us-ascii?Q?ryB2xElPOMIkKrk7N9a5ckhKsvP7GCE1WZkHy4aqnAotQKxHnn8RDZQYhD/Q?=
 =?us-ascii?Q?UCeUI65s0BmIeBc7Mp4O7ruNGbF5qrhlHa6fp2cqJDFDrFl5mtbxskjydcrq?=
 =?us-ascii?Q?5qrUkeqSoAobg0dvr0WBEAIz8aOqrNxCojqiaRA0qhzJ5VvdJoLWqyR7/qYe?=
 =?us-ascii?Q?brx+Edl5W2Iz8AOpcCbY5rGzZi9IV8vQZ8hP9ht+ZOBqZPMGyPU2E3JRd9v/?=
 =?us-ascii?Q?/l9w0zViKAJ3VK1NHap3GPtjW1eCeBNCgQiqIxHbUsr3qjCpF8Xrmdg7OaPH?=
 =?us-ascii?Q?1XX7AWKZ16oF+5TKpeaFdavqc1RCgqCgtJiKvBpwt2xvww1Pm9ir4YPjHcVW?=
 =?us-ascii?Q?PwAMu8NAlQ3fviU5SjdSRPw3TyN/jjDlvgqj74HM6ZJLlfh3/J61xQwvAfs8?=
 =?us-ascii?Q?wDa6TIQi4HNOAy5zCNT9FADg8EBjm+E9cSj96bC4Y4sImx3UI8w/1DDllkOC?=
 =?us-ascii?Q?g/IpYBfxPG1VXV6Ty7rXacQr6BMh3tlgoOvo+4KdWHTVPFhWx8EupGJ1WkBp?=
 =?us-ascii?Q?qjZBHaQih2aLkyMowFuWcAOlyebLVjQvQNc3tFGkTiyj9VK4NekMfKg6mjKk?=
 =?us-ascii?Q?fGlUKNF6CHr2H67rL11e9q4WFcwbpzPSQ44zfXLV+0pwujsFdB5UHANbmvmC?=
 =?us-ascii?Q?+2AIhUIVVNMppJd+uva7SGootfAJkpstubaFxrgd0GODVUmP/9Y69LVVp0r6?=
 =?us-ascii?Q?CDDTPSX447IsQzPdhdvH4Fic16AwTjnGqfd+mpAaYD4xdn0mc52D3+ctFVAt?=
 =?us-ascii?Q?Z7T5GLmqbwKbL5k6o7rvFsuKcQvjHq/AMaStiMRpktjaAVAH2LX5EiyWUCqx?=
 =?us-ascii?Q?lqAEhgwlhkl8jusTg+/h662eGx6amdf7Owzugtm8rtX2jHu9WhcK++ARq0p1?=
 =?us-ascii?Q?z6ijUblXpgftD7YnhR9m7we8CecK6QgOwKx4o+KLayhT9yvpu+9JghkdZ/+I?=
 =?us-ascii?Q?G7BVKTUt05XQIzn6tnjm2VhQ06tDR+ibHHlvH7vDkDNot1qdkYC1Z/ALHI2a?=
 =?us-ascii?Q?Da4A+j4+MoH7SGoXZm6e4AvrG2kqjGnHTOERlhwQkx4f7uFpxKEy93BJTng4?=
 =?us-ascii?Q?dKc5mhjU/zQ2ImALsS+MtKdpEfM1Ilho7smMl02cBFono0yhfY4t/zpJSz5Y?=
 =?us-ascii?Q?Sxiy/Ca/VmrC5I2mRIUcErOWoemxOc0+FgW58ziKckhiuFWwf8fxlsmO9TFB?=
 =?us-ascii?Q?BfMECh184iGI814k1s3CYcWXDIuYaYZWGz2c7xglSNoGEVpI/PDU3bP0cFLC?=
 =?us-ascii?Q?v9eQuP6k6h/osCun/eeqWCt3Dic1h2GBd5aqqUELpzFy55GCG0OEPaxIE364?=
 =?us-ascii?Q?8vYCrxCjNQ8Q8NvFAA9x8pvrF0RiDx68R3LtPu0oJQHD9lm/X6zshDUQOEfi?=
 =?us-ascii?Q?TCF/DVDFzrytK9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J0x/yvcY3ZNFyNqFytf2c2nkq8wha0/kWYzwYJjj9suYMhsUhA6t9DZI9SRF?=
 =?us-ascii?Q?4vQXZ/6Contaw8obbS9Nd0V9dO2IHVpsgM+P1k3qUX40XLAH2jltuErFlAQa?=
 =?us-ascii?Q?tDgAsLEThDx9mOXBtYwjoSWzpFfwEnvvTHt1JpRri0RupfVLNS02z8NLlubQ?=
 =?us-ascii?Q?umIcNG7At7HD20luKOYCdi5Nkczl6nD94d6Y6XC4XO8xm9QndUyCX5BkYGlw?=
 =?us-ascii?Q?ic6bQUt3ZUC8eB18IptptF62QjpaIfPv0qA6y7bTMn9IxTNIDmmAOx0Wt79O?=
 =?us-ascii?Q?G50la4UNOjsVcVh0czAewSHp//yMPyaExFneBY0mhbXxt0Sq+YTMMxNxO83w?=
 =?us-ascii?Q?zgQOpKip5nXGGaT7OBqeqyJXfQmdb4QI4JddhFKqE1Kh7OOn7WhnwZy8ixuo?=
 =?us-ascii?Q?XqvEXaZtjT0C9WZZ28ieG7AUQT+BxI0y4F/3z31QJvXHYWutXUgkOJ4kyjHP?=
 =?us-ascii?Q?E9dwueVH9zMqtcC5z7WzMmgVIj1jWrEZcmvhcgVIvglkXv3gyUOTQktPPcmd?=
 =?us-ascii?Q?0M7Z6Y5AqbprrwT5DlrRagoFJmRKiGWqbe1llEDhkC8fhcEnYWuXeK1ff2pl?=
 =?us-ascii?Q?eYuJjfeyr/vo5eVGB+CpwaKe9eQ4ufBegoJKsP8RYPv+rgybG3nqjaM5i/GN?=
 =?us-ascii?Q?u6B6KGrfhGlBxogf13YKCA8UYudtIzW6arldXEWL15QWtS6mBnJPGOspQeGg?=
 =?us-ascii?Q?GAxfodDpHaOCvL+kXMhikWifTuhqmrM2/U5oWKwg4Y/vYGH3dxJGU6wYtoas?=
 =?us-ascii?Q?iIl9TJk59MsgkTQjAs612sSQgyZf+7XOTDepqGn14TrD9GGoAV81j37paFxj?=
 =?us-ascii?Q?GeTvSi3zVTHee6QCLIlBsUyS/DAjcYnC6UPQqY4E1y2MW185SfVrcXj91h/E?=
 =?us-ascii?Q?Y27frvkGZ6I0+gtw/RmhNvoji6rWJ5Y7wkWRwQwxS0msxvKD1YE5eITgltO9?=
 =?us-ascii?Q?P6J4NmBtc6Fmn0pUwr0bzMDgim3iAb1t4c9CSKWyxanbXnpwVQhaoDNFnCZr?=
 =?us-ascii?Q?nm8aJgqa8mTvot4wAnhRXW/YSd+0Je2czXd+GWkhpphkdaLpnBNsC/JYKzcu?=
 =?us-ascii?Q?cycNBMGXyHXD2Jg5/Lvlqgs2+Y4MRhTt+FA3TdCfgJXoRWFlfgL26KVjCBq+?=
 =?us-ascii?Q?XiugzO3u2dEx+jw32T1u5YSRa59EjnuWGjQKrpxyhw6DDDrgUJMzos64yakI?=
 =?us-ascii?Q?Dgy1oXNC1fIC6iaC0mXKIqneIXxvPOzQzV3toBmTKZGfZxgNccj64v6VisTx?=
 =?us-ascii?Q?XXJmB9dQuLKZnTsl3hy3oje5ROFBWrnDz4eHCrhJdnjSWtCREsiqXstHDNu6?=
 =?us-ascii?Q?YWJYh3eRtHOFuyz9bFuMddpqaVTDd0KVuiLtlREMHiNP2fLJaCF4Cj3dzbrD?=
 =?us-ascii?Q?tv3tJm/X8jZ1WdEue7I+XtZjvLhpaX50IY944t+xm4e8BHV8ZIA9Aw7EgsKr?=
 =?us-ascii?Q?TU3iRujW32QiIIxdN/TCviK/d8uRgEXloc/fLooBAWjp5dAk03j7wKt6qf1M?=
 =?us-ascii?Q?FefPLfzbBkfSQ5yuYxbcAkySWgtHEQh+kHD+EAtCiGjLKmIILNinU5pyP32k?=
 =?us-ascii?Q?TSO7EWNWee4Oo+G0uZ/YCqUqe1xa++OP5FnC+Mubwf4QL/r3bFZlTQXizhVh?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9e8096-eaa0-4ae5-1f43-08de27130597
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 02:26:18.8916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrJ7NPbCSBLt/KqPyYFeXSouqY6EOlQ9UL0v4dd67p1KLf25fuoPaBktkcfUHY16uBgKmhTdj/mp7Nfi8HRaIsMK8mJKbgnIY4bijB4lFlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8068

Agilex5 introduces changes in how reserved memory is mapped and accessed
compared to previous SoC generations. Agilex5 compatible allows stratix10-
FPGA manager driver to handle these changes.

Fallback is added for driver probe and init that rely on matching of table
and DT node.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v6:
	- Use items - const for Agilex5 to support fallback.
	- Validate bindings with dt-schema by itself and against fallback
	  and non-fallback.
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
index 6e536d6b28a9..fff88c8e5e03 100644
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
+      - items:
+          - const: intel,agilex5-soc-fpga-mgr
+          - const: intel,agilex-soc-fpga-mgr
 
 required:
   - compatible
-- 
2.43.7

