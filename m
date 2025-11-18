Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90876314D0B;
	Tue, 18 Nov 2025 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508882; cv=fail; b=gFnehQI1bdae08kj1mNTHeFaiQGYWw6/YsNH3wAkm/qq2aC4nhiijeXpaFwHo7Ymv53C6fAi4sSWMqL2RBhDXa9CzUAVy5EMhIAW5/7z9jfnIRyrWlP4rYvq6UJLuzKRA2lZbi0qVwiItfAN5UKKuAMv+Geze5bi6gTf/vv2ABA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508882; c=relaxed/simple;
	bh=y9A3tC0kHJAfkb9RNveBIEDQIrpQ7lzGTAxYsVCcLBQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a9mKetx2S38VN/5qWeT4HSGvRI3pD9TJiowykR1A5YRB2/pn6IbRLExldQrEmNQ5P9kU1GgMTzYkizRs1jwq1uZOcS5gIC7CSEYhJa74y6jCQaOuaxivt5/HWqlcPvtovNmTQouKLuowuJX6ITCMW/CtrjH/mcXNPAYcvppeyVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vk6DL8jE; arc=fail smtp.client-ip=52.101.56.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vk6DL8jE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAE3AYVV/hsAiywF41kVWVzKsvEsQftVloZEy7IT1dc7+pHwchwEk5GjX5Mf1fZHuhu1NNHR27f7oyWWKF6Q0AdsZq1jdqo7lGCinK+t5lkUqeSFhBRnhFXKwZGxexeWN79WIg7jMxuymv9iJydXvHpPsu4wCtEdvi2gW04ObQnm9+mAlJR28Gep4hk5ByEpYQLxyemDzR583Bc1KLorKjeFJnYjpMdh7iFRJAdWiGWjyQLd37m8Zx3mPBoxdf+fB1aFZsrLhgB4qgGytp4W0TxE2Qq3c85B4C9KAPYW2l2mr0CLX6u+9jY1sXod1knUiU1c3tyn87baRNpb8azNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yNwcS9a6QdYC5Iigf1fDEj9TyuUrcWi4UxVQ1e6f0E=;
 b=XcOSeY65eTREKbACCshU3YfWpRkb4ri7/T00N09wXxLOi4MXbpHlHIZUES2kbVb/wZ6haVq4oFuzmNsIQxl50WcyhKu1H8ieNIpHryDYxKrKtivQZUbXqbwRp6N5l1NRrUkV0kQtXpW3ZQGj1Jomi44uvtey/M+UnGhpLnIEFPpS1OVpQHbpRHtCZhUmDAnAlZlFz5stpqmjtW3+dVriex8MGgYX2iZdYW1rq67qHuf3bp2xQPatvZcruSSSdDVFc+VCsaBadUAmHPb92E6XqlgqzuvZxFaQCYKSdQGLszj0udw2jQk+YLsqhD0spfqe/30Ikvqa0w+xDqX8caYOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yNwcS9a6QdYC5Iigf1fDEj9TyuUrcWi4UxVQ1e6f0E=;
 b=vk6DL8jEhoIvIDMJvbqYR6Qr/h14JyBfh0/QxV1cKrLvopCo1VkzU5SCS49xoo2HM1ERER7M/xHYwqapioactdjkkzAH4w1IhfUWvrvONHEbaV46iBuXMRMfuuW8w4UQ0SPbq51ZkZ6jlfxK8QcOX+vKK28VEPuGYSgiL0/BrhWL831yp7EWKLBDLgashyAuUmNl4YsnXJ4U13lRyqWhhWiKFlrJffKBiKreGz9M4Fy/s3nSMPd0sm6ZPgG6oFCbjLP0NpcPVu7Ll1ptQmEkIy9tbFwtCDqObagNN+Ie0DHOoKy6qPLT6oTFrOQs2p6ZWWGtidjhDrow39eJkw3GXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by MW4PR03MB6474.namprd03.prod.outlook.com (2603:10b6:303:121::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 23:34:38 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 23:34:38 +0000
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
Subject: [PATCH v5 2/2] arm64: dts: agilex5: add fpga-region and fpga-mgr nodes
Date: Wed, 19 Nov 2025 07:34:19 +0800
Message-ID: <59a3bdbe9c11e8337fdd0e83306f770acf131670.1763508492.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 461fcef1-cf3c-4331-822a-08de26fb09e4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zp6nmTE0LiJTPu9YiAB6LLRsaioyAk23HKuTYzQbV1JxFD41y2chOAXnOqn5?=
 =?us-ascii?Q?RxjCY0jubXaBFhU/YLfZ1u6fbzdh9xk2QRU3+8ooI1Jox/bDhz8z6xyyOpuz?=
 =?us-ascii?Q?4ht4W4uogiSJ0CU3bi/vvj+l3UbNJoivFnCp1Gt+Bs+p0h9eY/Voq4BQCkrz?=
 =?us-ascii?Q?EtAFRHym5Cs1O42Dq+U/R5IjgoVeIanHF7pKDYktnYT7ZjRoLtO9n8VvYS9F?=
 =?us-ascii?Q?d9PQm35cKp24nOTfPoMQ3yIyiVWaIz1NCfC3Cee1435g4vQ+RRHyMH61qHnL?=
 =?us-ascii?Q?JLspTd9ElzyYgs0I74B6vlqnaq83sf5Dk9aqG+6y/IStDB7dkGmRh+72Lwkt?=
 =?us-ascii?Q?sWa99b1+MOkrNXvCNf8YRlV2PJ1OfoU4PzRK9qP6s3d8YbpMlIemBHMjfFId?=
 =?us-ascii?Q?KMf295TvvGeKdxLZWI9TCLjt4NvyIKLb6Jd4/du0pLv16ofLf06RqE8t7dGy?=
 =?us-ascii?Q?vnaXZO+AYKB+KRshIXVoeLqiuD75qdFFvA+ZyIo1o22N6o0dtLWj+8O7pTbo?=
 =?us-ascii?Q?gyWOhJHyP51q8YE7x0U75Y0PWFoPK4LBb/KnFBCq7jKmEZ0ipMZP4Vkuq6vE?=
 =?us-ascii?Q?VuOgM1Hr2flx4R3jI31fJx5mYUtT6RMyLprJZ++iirOf2j9L2btQaVipqjBS?=
 =?us-ascii?Q?pbLaq6K4VdgP7gjE85PYjT3KlO+Dvlv82lFJ7493Z1TE2ncsTPTtiHBpZ/dC?=
 =?us-ascii?Q?YdVtYGJPD8ZRa8U/Pu9CtQcMbWhojyOS99C/AUQ2Zd/ZKmLlVm6QES5CiHTl?=
 =?us-ascii?Q?XBdYieI3UY9Tpl4HJAV49zbpbugHgrOEPUTuATaEZjIsXS8+EhJccxyEU2/e?=
 =?us-ascii?Q?BZHf4KpKtlbzU3mrXZXc03uC/PYUYeFHt72QJT/kHZPFMMhHh3SEW/JnB8pe?=
 =?us-ascii?Q?DbPHxr1tL8uD/E5yJCE0F62UDugqhz3sR26VR2Ox37PvWm0SVAofsCG8xqTE?=
 =?us-ascii?Q?0IAkiZ2mBfOQb7aAVdtqDf85fuD3Khnw4wdohr0k2iqlcRcX3ASnGTwrX7eU?=
 =?us-ascii?Q?9b105b5b4vnZOvvsGLOgAqCpJxZ6QTAwaFvjN2WBvS0BVt5ZQ2YNzZ2UO0UR?=
 =?us-ascii?Q?b5zC4LsVQ8+RpD6PvB4PnR4wt/mCBtRRrJFkNH/lKEZeTZZSvBPzRDW564C8?=
 =?us-ascii?Q?Gr8gjaG1PhVOWcGoT3WE143J1vc9ACizRioI1KDyaWN0ku3c2HciEe89Fzc+?=
 =?us-ascii?Q?rXb8aS947pqWCnkQfCdWesYP8jk8srkHmkmlnxMLpSJvcmAa83BC2qzVqond?=
 =?us-ascii?Q?Xsd6CxSA4oSt+zHbJmOy2haX2Uhl1DWagqleV3mKC0Di3SwWZxPDH75rCoFb?=
 =?us-ascii?Q?LZ3aGMxL02WKsZBGoDtvS/WOQ9LlNvd+s0QqKnRo7XhXq/j1u74ejk6Snx65?=
 =?us-ascii?Q?8S9YfK6rIWTwz2UiOeZXWTOMvZAuCfq+SV/QO2Tuf80io8HsBeawTMi+H2+o?=
 =?us-ascii?Q?6f/EI5rDwvyVc7PgdzMdyt4uB9rLa8IeV0LiotL246WQHdnq4dl20ZSm9M2p?=
 =?us-ascii?Q?lz5apFuj1MqPdkk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YSY/468N1g8iZkpSQCUzNI6EjupUKl4gluGZCqgDF0+e8iLUNzYzwxJeA2XC?=
 =?us-ascii?Q?cyhWjb1VuKUBL9jYa935NnZASSGsC0Lt+Pis7LDpHT7RViW3NkqneWPZF0M2?=
 =?us-ascii?Q?wn+HZfZcrU3AK08b40wib+bte0lL5E+rf3y1BB2NOs6Hz/8+Mf5a1f9J/1Uu?=
 =?us-ascii?Q?+wgOuvUS8daVS45mo1APWWjAEft+pY//73PisputgW8Wy+hnCSxj7jLshuNk?=
 =?us-ascii?Q?8L8kRnWDSrZPfwGwi9joseXI7PJX4/pnssvRA171PqOjlJ6RFQnv5+k04qBS?=
 =?us-ascii?Q?nz71ABv1doL7Ny+IT4Sm8vsb9A7720Ov8e2iTUKY1H7J6pFrC5VgnBNb98EY?=
 =?us-ascii?Q?Zz+h8DlVExb7Xtr6BM4wxeih725xA+gednKY9L4u2qkhsLhHnVEX3m7s9SrK?=
 =?us-ascii?Q?0C4WeL/EwisG4bzvRvVT4wwdWpf6bv/kwlSlcXN4dw3G6QJp4Xz6ucH0625s?=
 =?us-ascii?Q?dflJQY3gWlt5URIsLkEN/8sO14bMyzLHx0UHxaRJ05vb2Gyb1UIhcXGaJP98?=
 =?us-ascii?Q?MhHDiVUlatesbNlQ2HurwMZ3WRVpdifKUMcW/uunCJyol1pnq/PiYy+H91EV?=
 =?us-ascii?Q?FW6eX2qZHZ5z0ShH3kIJk07f17reAECC8ie/0HCn2AGJParM7hodqRR6TOL8?=
 =?us-ascii?Q?aEDY5TcI44weS67VUFxI8JRpA3U9W7f4eP6pTRpjOStcbhwyHtx64sWWWS94?=
 =?us-ascii?Q?meMvXRlh/5ggWvzxy3LiY/nMf70FepReY0M7RquEmXKmp/EaiSl7uBKAvteU?=
 =?us-ascii?Q?8INfjriaDB4IwZnfJ3JsOXlJKH03sHexgWqecl4Wr3NmgMj6tMxpcosV7TXk?=
 =?us-ascii?Q?/sg3Xx1d5xfG9gp+nIQoJfBMjlnOGez2oMVDqecuHQGKbNz153f86MJcBArn?=
 =?us-ascii?Q?7ebPV3IAmJutvoBnPCS1gy8/nSYQjwLg1HDpTmtxsxBVb/xpo6ugdSVbXUxs?=
 =?us-ascii?Q?E4wrF5idYbCCG3793MCmUgm2mJfjA9Za1wk+sqtFmV+IisBlirBLmdoxiq6W?=
 =?us-ascii?Q?8mXQ+kmJJOHzNl1FSpotC6exl0n/ZDKrGqvXSOIsC2m3y3ir27S1U2vCGQCy?=
 =?us-ascii?Q?n7G+HbyeIAf7SotT5kMspgaSd7ijz36x2g4tUU3B3J0U/uGlaTxEPM7gmFYB?=
 =?us-ascii?Q?EsuWttbKFD6m8nwpYg9EedCPyGYEg2RCxaTvYqPg8mIQjVX6KA2Ds3LGWD8A?=
 =?us-ascii?Q?XaxI6+6CBFC+36Y0qkbdydms3VFwK6foR/neCuFJPGP10zb+bHpQhM74MfJN?=
 =?us-ascii?Q?qqck4Ekq74btp3jaAbGeRP0EqFm9WcpcdYQUvWyOJAHUAt5JQe7TlvXH6IcK?=
 =?us-ascii?Q?3cJv4TIFDJDOR6B+sQJnqgSnQ0P1pjZt2mmenfF7myL2XUxV8lTpw7o8D2UN?=
 =?us-ascii?Q?ke3ydZvYotwNwqu/Cd9hceDWYse+OaWGVNct9g96wVHTaOQU10wcpLQMbCb7?=
 =?us-ascii?Q?Mu37oYqz2zZaybLOr1i1yzjTD0j0KLH0W4bPsgTope6iECfyfWQ+vd5jV8S/?=
 =?us-ascii?Q?nt0dnEAMG/NhsovDgsKf8qi+nVxIjtXyuUm+0E7XLjgALEm1h9MQBBE2UiPp?=
 =?us-ascii?Q?WlMrd7q89xHSB5wapX6YZ+Ms3sYfVhA+2AQA7VGwtIe6qrbJNsIF2LiKQFah?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461fcef1-cf3c-4331-822a-08de26fb09e4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 23:34:38.0822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaHDjFpRZnwD6iTgiU2dLV30PBXcATjfb1ZzCzgd0QC+uzIVzQmuH894S1cJf+vT8SXxsknaeNJaVCtAhOR0l01T7iAZGtXAx7W6u9mbJ30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6474

The Intel Agilex 5 SoC contains a programmable FPGA region that requires
proper device tree description to enable FPGA manager support in the Linux
kernel.

The fpga-region node is introduced to support FPGA partial reconfiguration
through the FPGA Manager framework. This node defines a region in the
device tree that can be dynamically programmed at runtime.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v5:
	- No change.
Changes in v4:
	- No changes.
	- Validated with CHECK_DTBS=y as standalone and with
          intel,stratix10-soc-fpga-mgr.yaml
Changes in v3:
	- tested with intel,stratix10-soc-fpga-mgr.yaml
	- Rephrase commit message to make it more concise.
Changes in v2:
	- All fallback compatible string to ensure driver is still able to
	  initialize without new compatible string added in the driver.
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index a5c2025a616e..1f5d560f97b2 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -85,9 +85,21 @@ svc {
 			method = "smc";
 			memory-region = <&service_reserved>;
 			iommus = <&smmu 10>;
+
+			fpga_mgr: fpga-mgr {
+				compatible = "intel,agilex5-soc-fpga-mgr",
+					     "intel,agilex-soc-fpga-mgr";
+			};
 		};
 	};
 
+	fpga-region {
+		compatible = "fpga-region";
+		#address-cells = <0x2>;
+		#size-cells = <0x2>;
+		fpga-mgr = <&fpga_mgr>;
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
-- 
2.43.7

