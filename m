Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30662FBE0F;
	Fri, 14 Nov 2025 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763101685; cv=fail; b=lilQfQJd3Hxf7WP0+pk+oZo8UW1nMkENMqGHp3oS71sOzMPEiUEkuvGbDPys0SRz/i0gJ2Mnyl+N5Tz4Ka4z+3zJo11QjBVsHXGkAOamR1yBoGr9wTV8ge3DtZYSQNzx65HDt8WpAUaWA57pvTnN3IPLYrJk4e8PjonrzAfdGbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763101685; c=relaxed/simple;
	bh=tc+p64WEDQ20EqnlXQU73md2iH7YjDXQmqAURhFd720=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=golaShvOEKrx91F+SE6bJcNnbk49ZdIcTavkmA8E/rcgvmDiBfQJmJIKMRJICWKV7z+qVPSVtN4k9bKx7PdOc54V399OZXTEVTpTSQ/+hxZMeyP5vMpmnXjuvb5/mMXTHmUqtZcUX1nhKXrf7WIL6TYL9MRczP/IGr1DH5SCdXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=t6Duf5Qz; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="t6Duf5Qz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekEOzsmUTs3Hj9cRYtfRb32kXRlgxSEkca17aYy5UOviBtCtslJQRWqjMN2ZMJJnT0IY75FoZUNhi0kpiwtZ1ge/N0K7eBA9Wl4bsk6r+Z8KtudObbIpMuZodiMB25+E+/7hOJFggoKbYIAXT+O09B9cHRQwLQ0QgFThgA6Wk/Al8TlxFrjRI+RyMBd/LdeMgs8jps5s2+H/4xOWqsaA1FmvZAjF0v7cyqflW0Ebriq5gaz3U9znwfnqBaJkoRfA7NAClpx0apbaOHjRJQ440hb6NSzEH7msnOvRnhhRb7xE/Qlgzu2Lr5ZWn4wiNFdgfLuZ99Epz7j/jpYoaWFktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yectWHTRDYAXGc7HyAVhN4It+oqMzxwM6bUpN7p33J4=;
 b=vt7rapUeJLpJ8W9rOLN6jkDpSWhaRKnOfsV9uXp+5aiwsDz+vUmmcpkoGQyO3ZZHdK02tRsj+UUrmJzF81VQbbEdYSY04WM07Zq8WrVgPXHLBZvmDxaj8yz0ejjCIBfsh7jWh4X+vBIamgScoOmBDqckxAer7GmE7WwiQ6scoAHAQllXE4gwM4om1QmJN6cJCXN4Iu6t/g8wFZp8si2O/f0AY1ZOeaY4Si8Ru5d8o4OvO2XokcAhmkwjppjcFWkkUSJAKm8Ug/Zz5OF+mFyBqv4SH0f3+023EU4hwBrJBBuMOWFd+ZyHKYG70R7Dn9TtHqt5S3cVeA9dNRe4RuDmKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yectWHTRDYAXGc7HyAVhN4It+oqMzxwM6bUpN7p33J4=;
 b=t6Duf5Qz1jP3j36a7ntDbNP13GZDvVKY6wTXhBxqvOshWLEHs889nhIX7nO12k3o9aLWyntDienNqSufEFgXAz9pTnJp+MOorufrS4gK3cbzvEkxns2kXEuWYbozJppRlNnxJQv+wJNJUCgrzRCwHS923cpyMJ9qZ/8oPTIAy/WBlC7G6uiXZSlFbFuPfYGQN1vUhjAhhj459T3KdISLh4u2jZvBfy+XjTn5/rmvYIPKVq6Y8HOoxuKn2zyF0ZpXF17q21Vj3wsrIFI+L3dOLGJ9fiqjTuf72HafD5zeJsJmDDLALaXxWGWiA56DbfyK2O1DeSzZFx3VJX8OyXeqnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB4916.namprd03.prod.outlook.com (2603:10b6:408:7a::18)
 by PH0PR03MB6573.namprd03.prod.outlook.com (2603:10b6:510:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 06:28:00 +0000
Received: from BN8PR03MB4916.namprd03.prod.outlook.com
 ([fe80::73a:ddca:6d01:4adc]) by BN8PR03MB4916.namprd03.prod.outlook.com
 ([fe80::73a:ddca:6d01:4adc%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:28:00 +0000
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
Subject: [PATCH v3 2/2] arm64: dts: agilex5: add fpga-region and fpga-mgr nodes
Date: Fri, 14 Nov 2025 14:27:42 +0800
Message-ID: <a2b6f2ccb88169c9e9ff81c87bccb89b002e3e56.1763100984.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1763100984.git.khairul.anuar.romli@altera.com>
References: <cover.1763100984.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: f116d8a2-27aa-4ae5-8aee-08de2346f526
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YawXXeoF5H8NN4m9Biu0Eg+EqyIqpidrPUeVGxGpIuBecUIzMUib62i5eg6f?=
 =?us-ascii?Q?6IoLpQdISMyIKg9u/1JOR1HmHsqg32TP1DBYqpytP54Br8gOdFWXULq16582?=
 =?us-ascii?Q?1Hy6OMU+QuoiTfc7peNGqjvRJP8TBcmza/xV75/DxAx2GqBBs3JC1QiXFV7f?=
 =?us-ascii?Q?ObiNYmwEO7j0hwTEeZcKm+KH3XjojIEMwsPcY+Eu3yk5Pxe/V/XILIzSmVzk?=
 =?us-ascii?Q?x1dMUREhOsVds7HsfQTlyIRPhHzMfZBK+MmATypCYH9k804PDD+31RPA6djW?=
 =?us-ascii?Q?9R8X6oUJNiV6ESS//1wBZ9kjqx+wxmVU5tV0qfyIGIQlfnhE9AUhpKdWl/Tj?=
 =?us-ascii?Q?2xlpL6h/NQ1vCVtyV9HZMQ4cJjo2yHs0m8q9sqsyiAgRTPlNMEv5u7S2U/r+?=
 =?us-ascii?Q?JdC35pG//L59fQsk9EjKxujBkEup1Heo1WYlYER6MG0BDJ4GIiprSiXdPEFL?=
 =?us-ascii?Q?NLKO0kP+uWyBhSQ590QOwHqRilpiK/tHqUI9t97CK51DhZxOEzwDVeeTact4?=
 =?us-ascii?Q?6+c1se38iGTnM837puxpnVgnp3AfhlHwOvbKpgmtiEzD9hycKHQ6gSi8o1yE?=
 =?us-ascii?Q?WwxfyWUGY2AATApXgwWkoVkrUeF8Uuc9M4Wf613G1smagkmbPpZrVDubOehE?=
 =?us-ascii?Q?/wAYv3iz2Ptt2IOV/okTTvF2QNIYyjl8XGiA2wmW0pKnZTbCYiWJE0zKMNjr?=
 =?us-ascii?Q?rCvxRD/g/YPhmeKz+QVm8uPHUVQgyM8O1x7idLFTJvQCGu4hxiQPVAa/ckcv?=
 =?us-ascii?Q?cRB7UgbhEsY0re8RxZ8e9xkNrSfPo1/wwjv0zS6KEFGxqA3SnxcyvfFsvy26?=
 =?us-ascii?Q?+ftiOPYIqU9LM9N2DFJ4AkP90qxI939hse6z3HpPR9DSrUrCMk0KJZSbvxJm?=
 =?us-ascii?Q?s5Qs6nzFHw3AytEfjE5QiX44z4mx5CDT3EKxZkcGYQ007gZAldqGugM7iGUB?=
 =?us-ascii?Q?FZFWRNms3MMAex7/U65bzIHTj7ujrj4g7Q2yr5UcpDdk1TG5uQTUVz2wMN9L?=
 =?us-ascii?Q?j8L8v75TLW/jzHV9FvbREDLwSSCsWS9UCT8rp+c7xOp1UJeIDg5Wrn14GxYS?=
 =?us-ascii?Q?kHvUvvrA9ecX0ducCTk+j7BtkTzo+xZbu6/oKfd500EbFooi6jm5UwZvq+i5?=
 =?us-ascii?Q?bkkRBwAs7Lv28v/AiGTZQ2M6m7JRYAGNbVTr3FUecvgHopqteYNm9nkkMxgl?=
 =?us-ascii?Q?CoxqQfHxRmLVHA757UV2sEMGYMuO+SGvdzEc99kzPxmgIHwUk69cKA3gJ8RJ?=
 =?us-ascii?Q?88miGHZBDyVCmrz7uSohEk6WFGN3QX6Nnp7QpC0Ug709xFJgXBYzzosoOQEt?=
 =?us-ascii?Q?AsiR8zBmWCfFKA/PfviLQjIUHQAk1vFkIIYGbfMbLE9bS0sgF/DaWuf0wq/F?=
 =?us-ascii?Q?WncIQ0VtpRTKv3/EC+OlKyPXSwn0jPnamQ9wz2ffJPOl8Q7kAKv6AfqG80j6?=
 =?us-ascii?Q?MTKHWHIimvBonZpJzFeuuk4UplYIGSY86xHn5u/Pa5clkkIVu0fsNlYHHd++?=
 =?us-ascii?Q?+Hbj1KkmBbpm7E8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4916.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?53UeLwna2H7WpESVrhIdLqyQJPK7CaLUrJuqi6whmaobx1tYeramB9HFXxbm?=
 =?us-ascii?Q?HKzv0gWlhJwADnDe40JgGmLWKU4x5NYL7whoqcY6N26oPLmRQ1tStGjnLKnp?=
 =?us-ascii?Q?vHnBBanv+ZyoBYSWmA+rBoF+hPF6hxfgsAgZwaQBgrFoQKEv9+NWidfQJzOQ?=
 =?us-ascii?Q?pDQub82kJbEJ5lIc8EVRShbTNCYLXIATkLyxckCHBhX5GN4js2KKh6F8WirQ?=
 =?us-ascii?Q?Pfbpiq+M9VIUX7AKHCzSaKVSSoMWimyKP3WGbnxEfdztNrukR/6zFVkLauPf?=
 =?us-ascii?Q?IwemZQ6WyxyjzTVeMuCD+VS08+pKZFMH4gJmG0pBAVL6qyHGCXjI6GLfnE0C?=
 =?us-ascii?Q?4cbpSZuSfM58dE+CoAjAVteS/wbdyI3FSXZv3onGGymz5IAfFpka1bVOaumA?=
 =?us-ascii?Q?RyqpoojTY3/H6Gj6z3NCJ73UOqxJMa7GqQ0SB+ZL/qfTS3pqOmiJMjV/btb2?=
 =?us-ascii?Q?NFALFZFB5VtNlYBivgW7CwBhinWfL3XblR4YhD8mA0p3IU1WqBpkmZJG06LL?=
 =?us-ascii?Q?OvcppVtGIKyKxFEFb+WKq1jel8pAb1KoRkx1UWujCNPx3KYQ/GnS6Tk1yonw?=
 =?us-ascii?Q?hI2/Y9de5m2dSltOcr6aWy83Br3aN/C7/aqp3wxQo8Xb2wmEdadPLdM+N8hM?=
 =?us-ascii?Q?NUPfxzP342dBS01B6vBeg/Xc3ozJ2e3AGostGTGEzitKSJcSn1FMsv43bKbi?=
 =?us-ascii?Q?XQTWJ9v7SdIAZJcCxuRuc2qlmXTvZomwojwiUTF0o4BSNWRmmzwElV2gUaVf?=
 =?us-ascii?Q?3o8jhScAP96N2Xv94BSHlAeS2mq8Jrb6vwqts556eJZqPQ5vIg2vL+C/t2RA?=
 =?us-ascii?Q?TEGKQuQ3fRtV+JUUbeJFaktiCs15JHgVpq7ypp/2lyTRXYLsvb3cbW2VCeTl?=
 =?us-ascii?Q?L2/s2Ggh1oR8Ad/5H78lEgY9+1aKRcHmlGAky1hQIpR+9gKa62x+VAgmpXyG?=
 =?us-ascii?Q?WsW2uXDyGon/xCyo+Dx6BfmB5xN86Z2335vHrxXDOhSLJ+RwVvuq2m/PZc9b?=
 =?us-ascii?Q?eDjcnjgoK7FCYob2L9uk2LpYYYkkHyhna5ER0hdC5ur79/KbzAWL0qtadwI9?=
 =?us-ascii?Q?LpjmA0gs5a6W/P9qHMQs9CpgAA28jQummOuuCBB7MSduiwIESoncsTBurexG?=
 =?us-ascii?Q?Uxe7jolqZXfLKkcItLQUA/MnLSsornmduYuXL9LB2b7nOfdDIG6yOLNdEHRD?=
 =?us-ascii?Q?rZ953OPQCvhlLXgMC8C4d4fPmVL9mZZ6GHxZE8AfbcaEaiIlU+GRLmuNPzWk?=
 =?us-ascii?Q?wOL6i8OOiApp/whx7u43o2yv5dkcEPt4rO8ct57ARKyFEFnE5OoiwTdBp1fb?=
 =?us-ascii?Q?eyxnIdyr/EmIvKfL/NXcrFlk0h7ODavj9mk2Qejx7w1arJZY2g/ALyc0sWut?=
 =?us-ascii?Q?jb7Hc+wwc2f3sqM79xygT0nZEv1BYY+egV+8qlXFJFO3insxlsx58BLR5gcS?=
 =?us-ascii?Q?ALeAgoFXRJbFK+vqGEwttce4SMkf+UhBOA0Ab/VlQj//u1zGsG+RN76akoSZ?=
 =?us-ascii?Q?mCDyuRnXcA13zZSRvNXWQwkDOoRiDaY2MWgw+uoJ4J/B63zzUtWD8SDSy3pv?=
 =?us-ascii?Q?Vk0UAmUua97JiwsQWJzVUn/4OhJWQgGlgW75eMiUBto3uREyjO9Xw6sqxh7D?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f116d8a2-27aa-4ae5-8aee-08de2346f526
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4916.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:28:00.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 215WW+OxnnnByNsheE5kFhax1t1QrXc/0HbtYQzVe6VDLDDq28e1VeUDkb3TzJ49uc0oBaPJMlBsrj3mAxtVl/WsIIUHIWQW0j5AhzXspLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6573

The Intel Agilex 5 SoC contains a programmable FPGA region that requires
proper device tree description to enable FPGA manager support in the Linux
kernel.

The fpga-region node is introduced to support FPGA partial reconfiguration
through the FPGA Manager framework. This node defines a region in the
device tree that can be dynamically programmed at runtime.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
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
index bf7128adddde..06be0b8671c0 100644
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

