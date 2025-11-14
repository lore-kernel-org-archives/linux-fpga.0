Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6702FB0A0;
	Fri, 14 Nov 2025 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763101680; cv=fail; b=h4P7Je40qGL77XKdZrrK7wJS6u27/Vg3gQ+8d/R5/BCy3n1gmLevBjia7GnkrytKsy6gJN9qtG5TW+qkVSWbxH96JLcJKJjZqeG5gnFViA7xyYFvI0sqo1auoffQVuKzI8Dmv9ZKNWtihYgvgoUd+IKRNAESznb2y9AmmdqERVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763101680; c=relaxed/simple;
	bh=/E6m1QT4X0z1JM/AOT0aEUhVH6WUeWSxGt0imzwV3RY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ifVCWm59dxpYQLUzUmEarvUGgG//7kfknD2QPsEG+8eeA5hLKlCfVlkEFPMVPIz2KHGbebfvBjTAsTNTkIceUbmuxUPQUI0CAsu6KWG6wT03nS7A8wJhkkLn0YLak50xDsK/iAdQMaoLy1PfEF4xfUFNQNDqEfnNH2m++2h7cU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=byxJUN9z; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="byxJUN9z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcUfI9Wb/SUKCrIZ/jfXnPTEjMddX2f6DCPsv/bo2zbnZpqbkmnzdI78ex11lYjEX4bRzcc7+cl5orn2w0hAxKNLJKrxFOmPn9jrDw4z/DfXAGd6BX9v2cqKxa3y6JsMP/6R44Lq7w2Ebkt7adbRzKIsr2mzh0LsWOJxQGeE6gQgF4A5m563BDc44kmO0bYRt9xEhjp/P7F8V17zPFvzNS+XjFhlYjDPTy63cZO4Cz9mxUYGxPJVIw11C0IScaD/l9TDyZTo3F2TjCKe+jxs7Ri0JpfoGuexm1mr7pSHG46oYZBFQ9DjXgehf5qU+W2yv5m7ueo5p1iHGjBkPpLniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8fosfB6zN74cOL/ZscVIrcKd9/2CyjO8eP8zIOgnJg=;
 b=beNtEynDoVlo0rd6bxs7lzmlTMFTOHRsDJvTeMBHMHa2zlw+T50pMXwbO4LCHdJjgerRGY2paZqZpXElpUeFEzHwPBMFRJRAsfS80vVYlFda+DgAi3fO6qtH3EM2tBnC4PgmTc+Y+kNXFFzDyO4d2utHjf035yi2eu4G6/g/rE2QkRHNeXQEAAephje2LanIt1OsDlFyXyU83CbqoN6mSFtUbngvv7cFmS1G4C3kSYh+i4sDA4YILuYL1zVEZPH4XbObrqh513dqmT2KHvAdvJOaFZB1zaYBxdkPrAZd0Q8MtnF42J7sQFMaA8Ktw7KUMyjpRTMQeo5yu6RqBsMB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8fosfB6zN74cOL/ZscVIrcKd9/2CyjO8eP8zIOgnJg=;
 b=byxJUN9zJBCTuuW2u2jZhf7zZyjPgmcMH9RCGrFLm5gZ1/7pjxkM/tqwoQYWAJlKZP6xRJLr8W8KYSibDhBOJ5pgkj8OnLMuqENrGXPy+DDkK1YbFj7PCUD/LX5z4LUYoYH8/WkdLJseisOhXRx2I3Sqf1RFn9OGEqHw1TzUrJHwfTl0/uTQl5EzQcnuvvGUsKkxvV2C3zKpR359fTiqQng2sbJDsKPpt8ADXEtteTukYvE5VAQNJ8ayBu6OdroC+ox7twb1bbBaxJews5PYt5m+IAuvxgY0E8gJak5SW4IVJXGwNrudDaVV6339AMcAhLHMguTqKk6lGHoCClEf/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB4916.namprd03.prod.outlook.com (2603:10b6:408:7a::18)
 by PH0PR03MB6573.namprd03.prod.outlook.com (2603:10b6:510:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 06:27:55 +0000
Received: from BN8PR03MB4916.namprd03.prod.outlook.com
 ([fe80::73a:ddca:6d01:4adc]) by BN8PR03MB4916.namprd03.prod.outlook.com
 ([fe80::73a:ddca:6d01:4adc%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:27:55 +0000
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
Subject: [PATCH v3 1/2] dt-bindings: fpga: stratix10: add support for Agilex5
Date: Fri, 14 Nov 2025 14:27:41 +0800
Message-ID: <c614925ffdc98b1faace3ec9bd7124161b0b60ca.1763100984.git.khairul.anuar.romli@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7b3e161-172a-4dca-cbe3-08de2346f22e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?njwFhZ0APGSHGybfOFN4Akwf8xttc1s4i3ASGEw/hSsmXpjSLgpkoYWiXONZ?=
 =?us-ascii?Q?UhkbSScvykQsKQ5W8+4NSgY/3WE54pqsB34xaQw6HRgsAMXeArJN5NBeKQeA?=
 =?us-ascii?Q?5BWLzzyKf8XqazXwE2DT9iQ3yXos0NLbYgFQHZ6DXeUoTONctaMDjEGKukHh?=
 =?us-ascii?Q?UPVHE13wQXNvycRWBztfVgmE4qtWhayN7a56zaBUV0gq884qkszf2R1R/Hbn?=
 =?us-ascii?Q?6AGPZ9+szr2YHOpc/rZ8APuggTSnqeKAH2iDZ9BwQXIg8tXZE3y8H9qbubye?=
 =?us-ascii?Q?gGaCPPGq250wv1tUwu9ffhlhCPx4SPkMs1n6nIl3MobcKpH3lFB/gwKA3Jsr?=
 =?us-ascii?Q?fI1r3wijGkBIfGFYOqwRDTNIlYLY58H5Xvbg5eVjZxZBTyIUX7MzWl1i5ecq?=
 =?us-ascii?Q?55CVf2OEZpcLfVx3nqFBnrxPcHWf6YEIZKqJnXf4Vipppc8P3DrzJ5drVRpF?=
 =?us-ascii?Q?nP5FZ9uixZRhiU1+Y4QlDlfAqyyvcWQPW7QyYrbfGxbqEMYLn9IeJTA9GJvs?=
 =?us-ascii?Q?EJ36v+aUUe035Z6R0DVE5YB4kLX9oLlV0hZasTXjjxpb+F9qtwozqBzzt7EZ?=
 =?us-ascii?Q?OducWpwz/k3sMvHZVmhtdY8WwZ/77mMPKjS2fwdGxjEs+k2RWsvFRiSicmbL?=
 =?us-ascii?Q?L9cPqjaEq+9VRwcjUynB+THslTRxm8TEG25OVekoQFbXiPQQwPkUOuLJeawe?=
 =?us-ascii?Q?ndvYUZtau9Kc7x05NoFnzB6yN+OupXAZtR+T1kCpn38giJO9Ejyz8qVqOGP3?=
 =?us-ascii?Q?70Bkg98JZ2/kYpgD6bnyqMvbMqiDTFny6A43gb49fOpnSfDU37SLeb56ToHL?=
 =?us-ascii?Q?tTaFA8MVrTwTGuWDb5BVGr4+DsDcCPcwO4fx1i4xqmTKj5wYzdx2JkCa5qCW?=
 =?us-ascii?Q?A11hedoYIBTcPE8MyPQZM0rToXuGP2/whp1T76fbCc59i1lP9SpCezqOgIFa?=
 =?us-ascii?Q?TX9naE0w7RqCJ27aBsptn8vYt1Bqrxfnol+hKat9uUfJDLD0S8E5PmLV7Z6t?=
 =?us-ascii?Q?YPtajphXsvZ/IF1Fxc69deNvGOQa6maKKfZfecpn6hk5zmF+10pR1/01Nxx9?=
 =?us-ascii?Q?KHrW3lJrcA39Ext23FH0DhyX9jEqapySO7QjFHVz467a6EEUoc4Atv6rmSAX?=
 =?us-ascii?Q?ndSJ+4rGNJKZDF+cQN7PeqbFtv/43VEqa2/ZCVYTSU2gNL0qBfWN12MnriNP?=
 =?us-ascii?Q?9i1WBInXHOaKb8cXG5eMVDCjR8nogszNyu3ufhvJ5TwIBttMSmQts6J/6Lc3?=
 =?us-ascii?Q?CUz+mrygRBLWSrx58u4CTZHMG02nH0dUh2dZTussLdB1Y899XcKM4dIaq/aH?=
 =?us-ascii?Q?9/zm3vj8LaBtd6iB3PiFaRGComB/L2VX+X/xr5MipVw/mQIUIXNkbTVDf57f?=
 =?us-ascii?Q?JIpIF9GNn9CqN7D+mGF8h/ul+5mBjLanTFn6lcu63XIBTElUtfPJkQHcyIji?=
 =?us-ascii?Q?JKF6lm+Fw99LkS12C+WZquMy9TH1aWhIb6pDT4YHbMTXLe6KnIRuU/JH0/m1?=
 =?us-ascii?Q?ml0oVLIhKsWv0wI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4916.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5pKdfWHCjGWGf1JxVyxbVkPAug9SYJ3QUUADvO+AizYrhjeGuNzAl2v/VK4T?=
 =?us-ascii?Q?UeiI3xw96ONY6y2Q0n40P88gkaDxpTibhJHrWX80uW2gryOTpLYJdTaJQcRW?=
 =?us-ascii?Q?c8wyFmA45loHm/CnhU41+AEyuR1245sduguhOe/vQ+sSBJhzQEW76S4tV5FE?=
 =?us-ascii?Q?kwjPqH2l2Bwrf8X+EY/s0hP6uN6FAcmJKqsylyH5wjIq82ZTfD3f2TCgy9qe?=
 =?us-ascii?Q?UMEUDMe1hWRXfQI5kc/cVJaoJJ5G+CoOuJ4UORzzobyCrs/tIlXas7HsKN/i?=
 =?us-ascii?Q?jCZS3H4x6yQ/bObVIwsNkSclDxp9GV1gIDPNTrvFa5VCE6ZlicfcxVPWNuOC?=
 =?us-ascii?Q?pA/IaDHLpsJXaqkjhH7u9ytzBawHNKTZ9uqDlHDsMSXzr+kP02FfbkvVdJDW?=
 =?us-ascii?Q?Qea5hx1ml6/Ob2ERVSsOb4BMzuySulJDM3wFn8/gQm4hSRjO5kt1B3+z1Q9Q?=
 =?us-ascii?Q?Sd6wzbYf/3l+ISesRXCpLg/zAzy2WgLZHDJWWiW3lQsIvYfQ3h7ppcUtrHLr?=
 =?us-ascii?Q?rs72CCb2j+9IPMmGvQaKSvO9v8QIAENYGUZcTSloISuNmQMGproiWWdWEnv8?=
 =?us-ascii?Q?CquRHCN6LO35V/6EHg14W/kpU8e/2JlSv0apHR09swxQsWuHnwNvdQWRimYb?=
 =?us-ascii?Q?I122dAJkdComJCLdxcStgaRwyUJSMDMJkEe02PueIAPjAs3cNQWxNb4jYu8I?=
 =?us-ascii?Q?HhCKMshwN5FUq0RhIV9MjKuQH2DTmYdsexNw2MGtk5iEfAK4ZxkcsSLy9VSN?=
 =?us-ascii?Q?dc7IInhDN89KROY7y1vdHZwmw4DGd5HdtwsoU+c1GN0zpLNRsxS5kodFpAP7?=
 =?us-ascii?Q?SG9EIfew3eaSKKLLCCg4gZ/qfSUEomhp/3mdd5WWZGu9AeZGdQQMfkP0bEzY?=
 =?us-ascii?Q?q0VcHJq4X36T1y6mwcGVZBv3Z6lowtrBlLy27wPgUImxmR3hScllOFcUDQJO?=
 =?us-ascii?Q?Ybri9VukLwIRgpW0PjU+z8t9312TzJKhh8kJ6qEJU5xEQrZ37CqrzQgu3ieU?=
 =?us-ascii?Q?hySGr7mYRFKVy42DgBbQ/JK9L+u5fLnyqHGjAU4RlkA8Z4bnbW0HRlwr+bem?=
 =?us-ascii?Q?Da34HaXIqFbWkIkbcQuWS+caCj+QfKIs+tWFZ8B179qIdXAMsbrXUwzjMxYO?=
 =?us-ascii?Q?QY5etimh+XUEa0BwRxjv0vSfIlY0Y1hCQrnDi1iU4S4bl3h/8bprYONd8gnz?=
 =?us-ascii?Q?pylDW48ORjanc/jCyRCYoXJcd3gCFwT/ZZCKWLLKQp3NY6cDmv6cL5kHpw6F?=
 =?us-ascii?Q?wbdQZ/1sb9H/SoutUf2A4P46pPhOpKzGBkORfWzj37cEgs+IR2QlX0LLlXEx?=
 =?us-ascii?Q?mZNN/zlKNkSB5f87oGiPbkZRc42cKd9EPqZTFEJY27bF7hkMi9BXcWx+ayYC?=
 =?us-ascii?Q?YT6uVKEf1Z7smEVh+NxTitPT9NkAxzu9EQ8mP0QD11KQ1hBwxoaDmxyOo/0A?=
 =?us-ascii?Q?OwBwnbdT47to3l5CrCnEf+G1EAg7DrCjOo6WuZnD/Ef1xCz4HOSWQLfMJKQt?=
 =?us-ascii?Q?CEsrxoQjdHufhh+ki2HFi7RK+foJrT7RN2GPJ79ghWgpyFFKTqgG7qCZKzLb?=
 =?us-ascii?Q?0ITs5UASj73REsYbIzkLBYKlrX2ekYmkJsy1dercD/f5vV+idQVLsw6Nbov6?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b3e161-172a-4dca-cbe3-08de2346f22e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4916.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:27:55.4564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFgV8gFZ300NtzVCxo9iovg1/p7cQVgal8NQt56oFqsNywIc2s+qN3r0El/taCTGEWYpcz9Flkg01HXVp79crpxXjERq9KSLDiSYP6HCz20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6573

Agilex5 introduces changes in how reserved memory is mapped and accessed
compared to previous SoC generations. Agilex5 compatible allows stratix10-
FPGA manager driver to handle these changes.

Fallback is added for driver probe and init that rely on matching of table
and DT node.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v3:
	- Add description for Agilex5 Device
	- Add and define fallback to "intel,agilex-soc-fpga-mgr"
	- Validate against Agilex and Stratix10 (non-fallback) and Agilex5
	  (fallback)
Changes in v2:
	- No changes in this patch
---
 .../fpga/intel,stratix10-soc-fpga-mgr.yaml         | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
index 6e536d6b28a9..8eb414163d08 100644
--- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
+++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
@@ -20,9 +20,17 @@ description:
 
 properties:
   compatible:
-    enum:
-      - intel,stratix10-soc-fpga-mgr
-      - intel,agilex-soc-fpga-mgr
+    oneOf:
+      - items:
+          - enum:
+              - intel,stratix10-soc-fpga-mgr
+              - intel,agilex-soc-fpga-mgr
+
+      - description: Agilex5 Device
+        items:
+          - enum:
+              - intel,agilex5-soc-fpga-mgr
+          - const: intel,agilex-soc-fpga-mgr
 
 required:
   - compatible
-- 
2.43.7

