Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C191A840A;
	Tue, 18 Nov 2025 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428325; cv=fail; b=dWDVM5K004EAF1chXbHPejsFjH/wh31bdPvL+ujpAGt9i/JAD/f8kOIZBCH17EmO+hxFO8Dk6XZBVLYdSDAUWtKXgZjJML9SwrJMFDDpBkGFcW6COT94OvwvbEJHvd7ggvb0c0DaRERDGoC7QVBbaNkQbFOtdZM1Xud2IVCDeEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428325; c=relaxed/simple;
	bh=7K162DmdmTrTeR4yptTZp+5fNfB6mOFuXx/9TUb1pJM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fRiGDaoi5uNU9a80UiWsiyZHPrEh+TAqu/3mN4c/niHTB71ynWcnLdt0GoN1yVpHl72mKjurlyxTmvs/CAHEvW04jTVM9ip+HscfD7iDOW2d5vjotf6iQDFZsI19ItkeY2eR8GrWsP4BBS3v5lOQtoH2yPrstEYzZM1azR6PaR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=X7dlc1wa; arc=fail smtp.client-ip=40.93.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="X7dlc1wa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHgvsJuFoz/z7C8rcmXvJ73qalFmJFYgmMl7bdXDenejUjrjIKd7bs77K0HOIXh1eRJno44j0VQM39XgVCNghl5nvemJ27rMm89AtaQWPMKOMnyf9UMDWDFbNUrx/NmgfQrESFkoonI12e8zncMZD8WudtGywsUEAASF7KbWvBSkfGxTROac9fmoZ9SDQOWFfh+8spt/H/OZLxUNYeAoXd6hHGFvQ7R7V18KUS3enNlgq7V17JIjrQo01BBXiYAN4Y78Tf1A48E7Kcoasthys91fdm8+hZAiJ/ubOJEHCq22xaRZRdVAHXFYmv/NXYC8jiD5LuAj22f0snfoPqd8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7xF1SPogYHXfN64I1iBRf4inICYFTgOvxx1Z4u4iJE=;
 b=lDOQFY/uXYRiIFnPGy0fE1g3/DkROYfIYAkgB0TvwTexm111c88+CB1WnSKNHyOi0IoKFlBx/ldpPeRIwBvSu9ZpWjMYgm+Q3EZJ7IL7ShgwPEELQS7vRuLfED98xduEuEmPgVTV7nyoQBNx7D+pUESqzMHzef1Jt+abdaTae+LokzmzxL5dTqudltLIhRiieIzY8ZWnRBnmLE032PdBT5AKb8M+7sl0kBSMA3EhjQbCC2Co8Q7du03/WK+pGW6C+AJMIFJB0Q5A12bp1mM8P1ribb9is1Y8GFSHvcRASFN3SptKODnX1iuDvvUSDNF4Wi3rK65wTZytZBkK7j6zWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7xF1SPogYHXfN64I1iBRf4inICYFTgOvxx1Z4u4iJE=;
 b=X7dlc1wa7d9RaNnaPEc9VL8IU/1VyGhOBFC5lK6/vsWO27DDnLRsWlA2QLAubCxXuwVPFka3tz3TkewlCIcCTB6q0LMrIIwHphMg2B58vGv5gzoiy1eb8IfA5gdLHPq0q1e0+9apRR4SQCqT+GWZtfk8mWyLFDt8e+qufbQ+UCiHhQOdlXl1VXwqAhJicIT4X/HTNSGiIxRlDbpWflf360v+ntzarBWv5TCIMcrdUCDy+Du/VX3hDBAPJWQVi/EPwkTSYy/uaAOa/4dAk6b/aaSfDnfo512soxe9XnY+6eare/fM40ApYhAkVizTdn0Xvb3SEyjbP1Y6iQHphVDzVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA6PR03MB7733.namprd03.prod.outlook.com (2603:10b6:806:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 01:12:01 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 01:12:01 +0000
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
Subject: [PATCH v4 2/2] arm64: dts: agilex5: add fpga-region and fpga-mgr nodes
Date: Tue, 18 Nov 2025 09:11:43 +0800
Message-ID: <b0811595f766d3633d372ab910cabc053e673dd8.1763427266.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e7c612f-7c70-40e9-1f88-08de263f7a16
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JUVdc3AhEqxEFGYCYDvx46bvGOrd5r7Kqyontxo2bWfDCiNcvNOui5tEPE1x?=
 =?us-ascii?Q?nHAJ727P9bG03rB5Gf36gdbL+O365kaJkb2Ldtr8WixYARhDkVytiPs+PIr+?=
 =?us-ascii?Q?t1U2wWeezygCQgVpeWDFT40HQhmm3M12TYimT8fhscS0r1iOhyQBGsLI1GYO?=
 =?us-ascii?Q?W3AxgCOtqUCzj5Q+KrtQY0A4b2+U5w9MlbpwKIMCD9j07fC3tFht5cfUCu/m?=
 =?us-ascii?Q?6s1IK8d+JDjPeVrg8oJ5z+ne0BLxM4jdBftZI2MNTLUjIWhVwR2DC9kkusPN?=
 =?us-ascii?Q?ecAH2dvhTEAd99DnjjdZ3BbGCh4eGOv9jYKPYPmJLoEodtFnU5aan+ZXvk1I?=
 =?us-ascii?Q?OGILfbj9081/BFz2+NwXdNdgogUkS+9r4V5GKmfHUxHl1Sz6jDOy3s+T7Mrz?=
 =?us-ascii?Q?TqtGSnY6ZEdNQebb2prcvMqe6NZXgVUukHpCLJ2ien7wh9+53gJHVYzuvdJd?=
 =?us-ascii?Q?mnNPRrI5NLDy5k5S94xKap8L1NeYw09HMuAjBU/zj506wyqHOtUS8JJNfzs+?=
 =?us-ascii?Q?0hGin+ghGsg/Z9p1163AslqI9upC+HUnu2/QAU9qShWNtuLbDL7F9hNTduW+?=
 =?us-ascii?Q?m81rIpRnek62QNLj+2TVz4svUyROTqnKPh9D3pQ/p1J9y7vViaoLr3i8PK0w?=
 =?us-ascii?Q?W1uor2Tk8eGh/VyTHTcUbb4A/XSNmFQemJMzVDQBdFzM5qDkijOnXn5nJQnt?=
 =?us-ascii?Q?+gP5g15jiCONOxBG+GrBmjlxR8PjZG+D3ixjMEGbbcGteLJbwWGWC1Qu9H8j?=
 =?us-ascii?Q?xhS7USDFw+ggyDPPIB1DRjVcmrWgbGuDHxt/mRhaGpre2EtrNqrqzLxaG01D?=
 =?us-ascii?Q?DFnEBtDbBlZ8kC/MyGRYzyDGA5HxzQRPl5TaIsHiR6K5HYxG0WANAuWgQHjB?=
 =?us-ascii?Q?9iOuSpEMjhfK05384D84jIa5KfJt30Z0aFJuhH/y8URtshEaIWTmG46LAmJC?=
 =?us-ascii?Q?UPUUOADAr+jaciu+jg7gMlwgHkiZZbwZyEDAMxQ9GrFV9OW1wyUpk/ucFYLR?=
 =?us-ascii?Q?uyhnsgTJu3PFwhKbtMKXeZQfhAI6VCzQ/lfDjJGV/BPLh/B8BIcjr+V29DCF?=
 =?us-ascii?Q?DEHU2ABqG0Bw+cpJZPoLYQFK8yvxVt3NdH6CDo3JFpCCnJhD2PcLr3D0hpqS?=
 =?us-ascii?Q?hBxr6g78YH2ZqNZV8oC0Ms+1WaUACln8dTOeu0wEsf8NbJ/IJxXIFDUEIERu?=
 =?us-ascii?Q?pvypnp6QLGb+S2QJ3C3JbxSV3TlIVcoscvfW2WcUvUT8oELHaEsemoV+9vVv?=
 =?us-ascii?Q?cEMG5yQUVr9e887riGLFfdckM3n0AYucfE9tCpax3oovl70cLaf43DoH+baD?=
 =?us-ascii?Q?uP/08woEpGtZt0d5flDKXyt3cPmnwLNcReW5RWhyKlpNfEKseqkggQjqdEEU?=
 =?us-ascii?Q?6QOzmuILTTJHX8RrNFQe0xsSYQvlz03hqCzgx6XyqSR4t2hW5s9IAyzs52iJ?=
 =?us-ascii?Q?GnGCZNHgs3JzY0b1O+ehOVi/O4BAogcH6B4z2/BLtcRaMpdBBB8bkjD4JcOP?=
 =?us-ascii?Q?C0st8KhfKTQwQ1I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vR+siOihyjyJPPiLaH0vpp5ejETDG4Qd0OUlqJUFAnPnkxu1/wKqDep7qRsM?=
 =?us-ascii?Q?5bVnd3MkC6pZ9fL7vdlBlM1zcVZLnA6jLpc+bGLsT1UqgHCIWseMxF4yuHJi?=
 =?us-ascii?Q?TnbF3cGzXfxpwsxvvtjAeIP5lTIZ9Rm/I0q03W4zsR4MLHurpKXvsbwo+LM7?=
 =?us-ascii?Q?E+AgnbX0m6C4VyXhAuqU9zUkCUMuOAmkoaNuSvRcF/9tEX1PWn752dzPJrAQ?=
 =?us-ascii?Q?NyotvEf15BYolNmHIgTt9ppoFbAgN0XS/I7GuP1PcqwmNY8AMhy48XAddH9r?=
 =?us-ascii?Q?COKwUtkhcUnid1zoPDZ2oZ2WkBXF/pg/FR6pP+YOqx/0U+QU8eSwtM2rz514?=
 =?us-ascii?Q?fV7qcIbQp3YcqyQHi4MCgIqBvs5Tr8XB87X5dlE2+h3MBXdw3YkAvxQ54pxT?=
 =?us-ascii?Q?xa+Lnot0gc84lWtphFMZKu2SiMIOD+32JEqn42hfEzUNcF8Ee4YYEOrzMzdX?=
 =?us-ascii?Q?cChNevhNNWH+5qxfUMbBqrRsZCZkDeCCbZwGDPXa9fAMnyBsKegUhO7lm+3P?=
 =?us-ascii?Q?WGFtsZRG7euW4hbSKHhzTkyImWYSgX/9KfaxTNuqUbBEZ2Na0X8tZnFHCN9g?=
 =?us-ascii?Q?D4i8ymWNJY6EA5lun+HnkZtg9go/xYmxUo4USMvrZSPLl+mAHfhk3h/WRfbO?=
 =?us-ascii?Q?QjX51KqAWtDBSa8nXw/RwaqbbwiboBqf3fewGpGq03VO6yI2M50R1X03krWA?=
 =?us-ascii?Q?AnXLg7z3kEV4P12vv75O3x3nCvxDgKxwbQj79PeN1AfHT1t/J3PERZn9kFRL?=
 =?us-ascii?Q?aSxuYlwtdaQUJGZ3suZplj3kQSUcrG85K0x2VBWGrzin13pTseiQ8Gx47Hny?=
 =?us-ascii?Q?8ZW1qWjPYSY9VgPHXecyTB52uExu89s/E+jwgpPgPR3leBb0cdThsm9qgsIU?=
 =?us-ascii?Q?QEwS5lCOZKx/7qHTW7TngxPtgYp0+OCVQL/Nj5shww777D5yvvuzRzj3auHf?=
 =?us-ascii?Q?QQSrqWtnrA000TWsG4hXwoywOhE8KtQD1wOveX8eUcCEmY9idHudWYkB/mUC?=
 =?us-ascii?Q?71GOZfdUA+HqPMhQ3lLU0ETJsKCLe1HJBjdp34bHA2ruAgUzngLy7UYgY0QZ?=
 =?us-ascii?Q?XnQWi4IP5wRR56S9Kl4zjZi8MfrPdW3l0FTFbiqdcIaBBH23Y1wkDIasJlss?=
 =?us-ascii?Q?PW6tqSQBX2WuaQ2hTSXxPtLfiINsWGl03s3j2M3e/jViZxwwUfGvmWPxiJsj?=
 =?us-ascii?Q?LSmntzGkQbVhzDZe3xNRAvhXm2wzPgl2orETJktor9ONfQ11T9gxIM5XUlcM?=
 =?us-ascii?Q?JeUlPS6rTAjuLaIkagqkPih4Z5QDd5oBf7USnm6FkSeuwQ3ycLZg9lq1DY6F?=
 =?us-ascii?Q?Qbyw895k5rqjbXKuH3kC9rkzFiJZyeJSwlo7kuo6Pg9ilUUTnG1T8mhgMcAl?=
 =?us-ascii?Q?Lm4KZYol4axxqkc2s0egYvAU1VNW3p3FykIte+TJzm/RpkdlPO94fbmV5YA/?=
 =?us-ascii?Q?jt9vNW67aD/nQ5QVPOYZvV+98wdMBrQQWB41ypUBBjCAT0sBYumlr+Q8oC2K?=
 =?us-ascii?Q?J9oGiReultgLOM5jhLlOd9QuhQSi13WjnRR7tJaEY6r+4iT/466zrQ1u0iIv?=
 =?us-ascii?Q?XAQ3BiKaV9xiLHZvA2OHGxp7XbqR13fX4WfSXglZoPUoQ/AUI5cSr3+Sv9HC?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7c612f-7c70-40e9-1f88-08de263f7a16
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 01:12:00.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hC5t2PZskFf3k7VApD3gFqFkMEvXcqVhzK2SHrDYLRblY0eqajBxPo7HM6imnMDhfGTaNGjbUQ1k2P9fG5y94PmdjlZsOGOPnz4W3Qj92Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7733

The Intel Agilex 5 SoC contains a programmable FPGA region that requires
proper device tree description to enable FPGA manager support in the Linux
kernel.

The fpga-region node is introduced to support FPGA partial reconfiguration
through the FPGA Manager framework. This node defines a region in the
device tree that can be dynamically programmed at runtime.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
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

