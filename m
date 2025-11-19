Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC127F727;
	Wed, 19 Nov 2025 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519187; cv=fail; b=YOGHSZxQpkqkVr0TRjQwhirmrZNnfn2ctMztm1xlNSV0T7TbVDPc09gVLWIcGbSyGrYlUU9+E2qbcg7C3aXYMux0GGIBlasYL8wYkqUldVGDxn3UVYPOu/722DxWrAIJFSt/GthnKFWoYQZdPrCHmhSrjkMnFxmzvMqPctubgKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519187; c=relaxed/simple;
	bh=3t/Trn+KkntkWIYyVnAH8v689lixC6TVI1WE+/w0Iko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=grQegetYY/I4UTke6Pe88US0Tw9bPUyIrD7NMzMQm5bOopVSGsxanW57RXMNtvuqqugYAYUkjbd8XT/WtNEA4qPl8iVpusrqMGmtG69L9krXVswxHWTbsoZ2fOu9TMwHN7Pec6VftVZYTvQ6AQFf/KY3+RiLBlqm6pFbA+aYiC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=nLoUJj4g; arc=fail smtp.client-ip=40.93.195.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="nLoUJj4g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSMaNaNHRY8jUQS6tjIs3mPHtv2I3s5brXZTg9SkBqIe+Q8d0N3E7LNkjFg70o0LLhS/ggf4yOvMquXC24bEm5r4iVGTYDWyj3RLtcYn4Xo7vDNL0sYCUxq83E3hFs48oT7Y8o65C+fvk9rl1yCphgBHj00Yf63ztaZqJWKDklxprUPaZhKihmK3WEn8/E4oysPExqDlZuw+/sLUdkKj437EbIuJPg/qLF560wewTO8ERVrJAkcJ0AhD5FgxXLf/ELWN5/atDgnN5v5DwEBFQ0+EI7Hxc7hjTwbzUVwK6SNDLsri4Zz1cFQL/cKCPR2s9odKWQl66eLggKhhsqoL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4O4KjpfMs/mkWmenMuQaYB4MSI+uRQlVewKK0r1bwU=;
 b=MbML2PUxotpMb4BYHs+igx9CLSCfgKPwxZVLqnOHVP63GV1pEed/knCAPnk0bv27JLYzQdb66VXUQl5pB0umvTeON1TbHoWahiHdS6/TANn1P9O0HcaG/zWEF3Wn6zlkAJJPENMIbs+GshDd3HF4oVqXXjQXcJt/aMYvlXtLErOotmFkIcAWzBw6J4nnTSF6Bz4o7JFCE/mSnhbx/pecAf94C1xFNDhlxNZbKrvtCqESXO5FaO73s5In6N5/FTGkhD9E+E1wdNXi9tlfmxWqr+Ojt9iponmtAm2Smw/ZI4XNjTrf9nv9dPgk7Lheqn1tLVygaOXOy82YT6Bhe6OPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4O4KjpfMs/mkWmenMuQaYB4MSI+uRQlVewKK0r1bwU=;
 b=nLoUJj4gRcWVjxzrzVq0osFP/K9LWHqs0Tq+kb2k5TGTcZNxCM3qnnxU0ojnY+NPiUN1PmWvV1jcVThDLd0rOWrdqab9X6p9SW3+bL7Mq42LmnFTcra0YEC/JY0cHuupTdYsVC4mz7DAtZKjJuu7ZflfMi3rBr0OE85Z6TOqAp000/uJLne446Ise8jQ54aArAUAMq+Pu9KK2p9XCq1CcUIhSsaRLply0CpYvaCy8m1QL/aNZs92SsuSYtAd817netmlcs6weFB4XBNXxncXbpvHPYzeuXyhA2A4VISp9Lpg3NN1BPZQgjnT9SLvlqqjYW7TkhlHW4ozyXX50gUHyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA1PR03MB8068.namprd03.prod.outlook.com (2603:10b6:806:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 02:26:24 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 02:26:24 +0000
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
Subject: [PATCH v6 2/2] arm64: dts: agilex5: add fpga-region and fpga-mgr nodes
Date: Wed, 19 Nov 2025 10:26:06 +0800
Message-ID: <e50303bc73087499f1e51de8c679fd5414b5cfe8.1763518321.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2692a438-837f-4e09-709f-08de271308c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?he4/VMJUzP2zUu5GE5Gqumgk8iIm7gI+itO7C9v6Eweyqome7ylNHYdzEoPT?=
 =?us-ascii?Q?lV4xR40yQKNR+FxRhSTnwd3EHZNvUsXjxhh1Xfgv4ZU2Mi0Z00UxYPS7fvbg?=
 =?us-ascii?Q?ioC6sX8q9lxg2qFfYPmLpoOiQa8IywpuPfxWodiNPQllibJbLlRrpsFc1rC7?=
 =?us-ascii?Q?Aqq/+EQV0ilq17NP/0xWnUxHkM4K5NoIKBnefw8EfdhTOUTvm2Bvyb/hrCcl?=
 =?us-ascii?Q?ZbljFsayjbnVJkgEAnFO3nf1XpJgx+94lkKchpTT+12DX2QyMe+5OB4Gr+7k?=
 =?us-ascii?Q?2cSwsgzk9BDuC+WTj/j1uYseo6+/OfhB5pKgKK6H3PUfC5ukM3Nwj5gYz+xY?=
 =?us-ascii?Q?kDQn04aVgEG7G+t2B7Owsi281C3nEabhJIzqps/eNPjtRaIec6LnKLk2Rb0h?=
 =?us-ascii?Q?ru7zWf4ez0at1ID2OlgMM5beBAu/nb9EU/IuTr0oZsSv4O64uqtTNQzm6+re?=
 =?us-ascii?Q?tKs5UzjfuNOytbCalH/q/9KctLG5ZJS2SZWFeusR5KaYVgPE8gOa2EV/lzhS?=
 =?us-ascii?Q?RutiJ8mzxNxY8OQngEiQ3Kyv9gF989yi72vqsSB3TEpWehSFKBLXHTaIls5f?=
 =?us-ascii?Q?AlR6IVyUsju9QX1ye+R4LcjRslLz1ZiZsCxSibSlUIh6DzUyvDJmh+SrgVol?=
 =?us-ascii?Q?2h+WmWJ2AonT4hBc4Dm2fhOKvwhEp4LArG5sTLM1aOuS7PyiUskvStVfoWJA?=
 =?us-ascii?Q?TmrEp9c9w+HtS+Cr6dc8DnRV05NPqIZNHhPYQjjkhR1gQX6hCd8lIYvt3/i9?=
 =?us-ascii?Q?eDLgfhoIsm8FZW+ERJSNi9fFNGTrZ395kH6IDYAvAvf76/xHnB14MJE3Y6jJ?=
 =?us-ascii?Q?viYYLObjqvtChXMMI4xZrumRFAYFNN/0to/E44ElTui/DJpzS1byvHl4Yp4m?=
 =?us-ascii?Q?wVP3RvU4t27kk3wT49/odlmD3exph4M6WBy25HMo17ho9X67gjGW5PjAFTJP?=
 =?us-ascii?Q?x4NX4MTlcfZ3vpKpmO6Ol6d9nRBM4cOSUY1GBPXy3mJfQNg5jQMUoWzEoosP?=
 =?us-ascii?Q?jJ93S8k97yDE9ObUKCAuwprNKCcRs5/c5D2kUVqO4zZdjJOIg6YJDdIw9gLU?=
 =?us-ascii?Q?DQX1yzBpTmogBZ/RTSc1RXvTj5i+2E4pxYNAN9JDRxVpBKAedKUrRjMe1a0h?=
 =?us-ascii?Q?OMgQxHCTPEIz9qDPJy9nFPAWy2T9T5a5+zMLBqRbbmFy1dIr6roUraYsETWB?=
 =?us-ascii?Q?bpDk60K5oOLnr1DkSdJKCP8yhOJh4QudckD5f9bwPHCg2fVLx0QUvSIrSXY+?=
 =?us-ascii?Q?F6QL6izWEsll/9Z4nt/vpMTomXzo2vYJMgvL204emo+N+VMWiwX/hMG7vF8o?=
 =?us-ascii?Q?+dzaoxhqfRcLg6YqSIYGbZAzwdTxl5f+E9GQS39dDwyW8Fl1X+CZi7jLHPIc?=
 =?us-ascii?Q?OgpZC5+dQn/MhVZlov+FY3hkzyngmc7qQowasVRZFcJZJkAUXIrk6RlXn9Kj?=
 =?us-ascii?Q?Nl5dgohAFx0Rb/RJUrEV3Inh+gTAv+dTWWyOJkBQQZ/YBX7zuzUu4yXSg5ka?=
 =?us-ascii?Q?U1D+RoMA1Paxxbs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KtPzdmFvlXwQ/1SOFJ+2qDlwR52zLVoPQyZrf+9fR99b+mpLyAEQCRpSd1HN?=
 =?us-ascii?Q?CkCdnqyWF97xyEKAI/isHBskSfFN0KPLq9JGZ7RcoXgFANM5gtSRTxkBXeR9?=
 =?us-ascii?Q?/EHaxs1QtkHvOQlH9kc3LXmKFlMRzGNPO7g2hw3lF62bSBy4ivu54Hv0S+EA?=
 =?us-ascii?Q?nGl6DqeIA11ZeViu4DHP7GOH5hQTFeNbGgtyrLcdhi1LoJ2gLUb0zpVjEk9d?=
 =?us-ascii?Q?qgwDyvztjJnTRnTJBODBc4TwQ9UoCzUL7k9gIiZx0ojXYCMflHyAzEBj4KzF?=
 =?us-ascii?Q?NFKe2ec+7V/Sr2n1Uq/P7wDw90GvYx3b+Exz8q56KrpG1NysjO0hmbTwf1HO?=
 =?us-ascii?Q?GeVCdhtdQJG08fp6pGEKUO9uSGXRnVn7z1xglY1sU1sZfk2RQIbvwy06X/op?=
 =?us-ascii?Q?J6pTHgb4GArQLvpt18hAuOH9tgK49ySKIwYRY0ms6QnWoSWxcXGLCCLcgQ4C?=
 =?us-ascii?Q?EAZbVpmyv+ZxrIoBOFw4QPG8mNeP4m1CwDRxEKZihK22qXwslImC11gxJ8P1?=
 =?us-ascii?Q?IHEi+9dRwqZ6YmLrK7EtmSIN3zFsiSbZSvpF9VyA4MedT2JysnUJk1YxY9tp?=
 =?us-ascii?Q?lfNSDoBvnhNmkELLXhjT7b4UczlCl4TRkuPtXtxFcXz3jpG9X3XF/LkixWga?=
 =?us-ascii?Q?G37fXvQWn1bOQ+rQ64La14lKQ/S025/ciPwo//HB+LNSUvTh2zJnfToI8XGJ?=
 =?us-ascii?Q?kCZR78Mz6UWnyab7rjHpxwKRLcCPd/vFSGVjqxwRPfpGUZoBagztKyVofeCm?=
 =?us-ascii?Q?gRGgBa44ENirrSD2nNk1njHEXwvXROQPm1bdgS3vm3GNanRiYb4qMCykIp1d?=
 =?us-ascii?Q?9V+JQGfWVPzGy93069EiRv7ZRNrN3ETF3X/EO0ht2NfWpHqgysVlGGkhGNxz?=
 =?us-ascii?Q?sgT1qF0NqWS8bk6TfFF1x0ZvkYGnOUVHk92mJ8JMCFGlNFV7faM2hy85/a9e?=
 =?us-ascii?Q?QZniuEKKP6Hwoju+VBQCpm2mKxNyan8yjSNuFpV9ZJrwTr9gVC5Uk7S3mkLu?=
 =?us-ascii?Q?zaI5ObWxUuypWnLSsVpG0osqjAuFPdmUXnKu55kE4lozcW/rkS+XOYj4Lhxz?=
 =?us-ascii?Q?MMpRwwagQ+H4vt2btba898NTSey78kvE3nDWU2sCfwVOc8Ac3QVy5e3HUrBI?=
 =?us-ascii?Q?GUA9fcfYETiTFCB1LpFI7REuxbVnqUn1EKF2/uuNRdNA9GIZ8c9Rb0jqVkXI?=
 =?us-ascii?Q?BRH2ONc1aFQJ8orIAjfez0J4+Tq/4hq+yaSR35/qPBWkkJRCu4r0SXem8QpL?=
 =?us-ascii?Q?VFEKJOqYmdLC0pDbxDqc88juSoJ6FTDQltQ7AZl8fDtMA0o0NR5cQ1HcZ6iF?=
 =?us-ascii?Q?drfQuDhEVeV04HfygEJp9q13WQPtlGXzoAE4Iv7PkXzGpAgOicrs2cdy9WBO?=
 =?us-ascii?Q?MwaTm/ko57mMDaF97PKG4iGL0qHExG9ITphLeyn4f6MjZx9BgraszRIi5j6U?=
 =?us-ascii?Q?NiftTgNzfAJKcKXBk8P8II5OZV3oB9Ayu5PnbCF6WvnQ1Uy/9I4lQ9cQ3eOK?=
 =?us-ascii?Q?K1PeapgzxP796x9AiObr0IT5QWDlUltP5HCApPc78NoMVuAeLOoGUzZuEq2C?=
 =?us-ascii?Q?J9Xm7J4K/OfmwWyNb1PcttESi6KcPvXfXaGz1EjF8MIxPoBChM4HZgQsGrPm?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2692a438-837f-4e09-709f-08de271308c1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 02:26:24.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQR7cEuNBgsjR+uYtfXudGfDqlC5GpGCxXc8MkUDtz4ScihRJroLW+YJZN+l98CZfec9aQm3ZBpxiQpl/QeCnnQbf8rzYG881aLZWaObKM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8068

The Intel Agilex 5 SoC contains a programmable FPGA region that requires
proper device tree description to enable FPGA manager support in the Linux
kernel.

The fpga-region node is introduced to support FPGA partial reconfiguration
through the FPGA Manager framework. This node defines a region in the
device tree that can be dynamically programmed at runtime.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v6:
	- No change.
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

