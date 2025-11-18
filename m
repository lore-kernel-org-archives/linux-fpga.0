Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25186A41;
	Tue, 18 Nov 2025 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763424483; cv=fail; b=A1xKBiQCmvag1t/s/KnthQ/j/7Pk3vw9pZaDJDXgBZawwl2PXg9e6xMTv/6YNFFkorOgbZaQSF8YhQmQlpvPC8szMqDNIzJPVvcfEucTzI1Yxdw8EHclHM/ndwH5It0bps0w+JJfxyNf1AP3ieMc1XbE0ZoFp2Q5RFBdL8HnYMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763424483; c=relaxed/simple;
	bh=UFF/LYBjbEST/x7qAiPkKrXz801219JsOmJqQK3Drts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CPLaiXOL4BGweYIcb/CmwaNIFTqDJTuL0HRlyrPoPl14+k2fp3y82o7paCNhAjjIBZRteRtW76E/5TE+eHvnpXctmxKUOo7kKr4qAfXVfwLWaEo7qLstAGfi+fIxdHK4QMWItDDUxijlj1TWmHzQcacSEsBVFX3zgDhyU6NNEd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=uAXqsU5a; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="uAXqsU5a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNcSkyt7aaMBn2Id9hhGYg10UZ/2YuKUBiKWfrN9xwsFeuJ52Z41hbq2/8KaXjdJTiGLb5EQz/0LfJKhGQ0236+eWBIs2ka3LTPsoeYn9n7BxKTVkc/8PdRtqKd/zN0E3ppYJp2BB9PaDPV9loLChPMSlNgAoAJwo6LI7PTd5bCKjlCzer8n41WQh756yUwmDXWm5ruDb+KutssgekjE501bPVlG2X13r3XxQrr12Z4FK7YpZ+n68A+8GCfIz3qN64A5X13SYwNLaK8Yz4+Zdt5IKN1Sg0iY5wdOxRbOCK3ePs8BnCEdug0YT1vO6OoGUx8s9id52IBvDcDErFBGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFF/LYBjbEST/x7qAiPkKrXz801219JsOmJqQK3Drts=;
 b=pcfe7EDmwG9XVOmDScY5iLV9raDtK4oJZaIzcOiYx8oxRXzzqPGcVjsTg6xMFZBEb6G0OWtDx3jGkA0XT9WD9w3iUQ2vTLzFp1birfL1D0wRQi6Gk1hR8/eM3b5jGF+PC4igsptsGZanhy3PeuhZOMk+m1lmV8bTecETGSnzH7Paj6G7lgpY40Gj2693W9xsDc3Ii1kZ2+4PpqBuTL3Hhu0RThc8PBHxHwtBTAa6YzMmaLQjEJonbW1QTB+UxqbSlBWYFZIczqaeB5OO0cAZFo6FFH5ODLa+DdcjMZK8xmgX6s01/OIYKhjNtyrQIs9MdUF/MYDkMH9V7hscS+hh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFF/LYBjbEST/x7qAiPkKrXz801219JsOmJqQK3Drts=;
 b=uAXqsU5ajnhcgGzfuQBWPvRnhNyWR4F6R35pl5b8dQA4aGMS6kA7hqTNJIKrD0skqrEZNt8vjD6ZwrQ957D6WNxGBpdq9/iCxYrV7y7V10XlnqzjrxnjEnIngAu3Ilic6lIHKrL7TJryZGcjSI3qynPgCXAoSZfmAXdBzt+ut463pDLinPHm6Xz3Ghrj2OqLBPQHIsEFIpc7zJa5TjvblJUTD2+fzxCHuHcAdhB+pVwXcJe6y2gDVGbnbTY90cc9iyQH7kAwKfYYnwc/Yg2F5nKZfPZBBgGcgfuq2380R8uUHPb8aD0/GYteQjBELrrzL8PofvGvCuANfEyO8nKJVg==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by MW5PR03MB6908.namprd03.prod.outlook.com (2603:10b6:303:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 00:07:58 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 00:07:57 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Conor Dooley <conor@kernel.org>
CC: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix
	<trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "Rao, Mahesh" <mahesh.rao@altera.com>, "Ng, Adrian Ho
 Yin" <adrian.ho.yin.ng@altera.com>, "Rabara, Niravkumar Laxmidas"
	<nirav.rabara@altera.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Thread-Topic: [PATCH v3 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Thread-Index: AQHcVS/PNhj0nHdyyk2ACquwqz/DPbTydniAgAO8SoCAAMDPAIAAAIMAgACgVYA=
Date: Tue, 18 Nov 2025 00:07:57 +0000
Message-ID: <d627de4c-1d9d-4348-b54f-55d1bd1f2c31@altera.com>
References: <cover.1763100984.git.khairul.anuar.romli@altera.com>
 <c614925ffdc98b1faace3ec9bd7124161b0b60ca.1763100984.git.khairul.anuar.romli@altera.com>
 <20251114-countless-vantage-6e18528d2e31@spud>
 <56a3a993-9e54-4468-8774-5ed350948ab5@altera.com>
 <20251117-imprison-upstream-5c80b3a55169@spud>
 <20251117-empty-skipping-a2c0c9aec1c7@spud>
In-Reply-To: <20251117-empty-skipping-a2c0c9aec1c7@spud>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|MW5PR03MB6908:EE_
x-ms-office365-filtering-correlation-id: aa5d497d-5643-4d65-ced1-08de26368798
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?NVdNaS81NnZZM1VweUpQM1V0VTQ4RTAzc3ZNTmhJZkJKbitSbHlpeElwdk9l?=
 =?utf-8?B?NEFLaGI2MkxqcGR3UmE5dy8yemVMWFAya0dGZmxxWjVOS1I2bW9VMlQwVElp?=
 =?utf-8?B?NmNma2VXMEZST3IxQ0RSTVlISEhFWklOTSthaUgvZVdrRHBDRHI3dXFDcjV1?=
 =?utf-8?B?eEh2cWhnM2F2WWZQOWp5elIzRzE0TGxyaHliR3lCQU9mSnBGWitvNHZOMUxF?=
 =?utf-8?B?aVZzQS92cWVkS1ZUSUVzMGp1cjl3RDJrdjBzYUtyVnEwQWlsSW1xbXlLaG5m?=
 =?utf-8?B?U1NNbWZqdW1NUytLMWFQV05TWUQxREYyWXlvR2toV1hlMXRDdTE1Sk02REhp?=
 =?utf-8?B?U3lyWE1lbVBxaFlydHhtUThVaEtCNGFJSTcwdzQ2M1AyUEFWc29zZDk2RkR1?=
 =?utf-8?B?d2RCL29RYm16elBNTS82aEFnRDdDQmtiRWNndmhpWFFrcFdybmJPQlZqbnB1?=
 =?utf-8?B?b0VMRG5jTkdiSE9pRGVVaHREQk5UcC9sOUJXaHpqd2dJckRsUW13dkFPR3ds?=
 =?utf-8?B?ek5Wd05YMU5CaEF6SFlRU0krRWhscW05dHFpN2NqUDVZRWtEQmhwY1o1c0Fw?=
 =?utf-8?B?ZGJhNnE4cm9xVkREQU1Oa1dNc2RNVTFhWU1ERTFCTVRRRDJvNjFUNXZqWVd6?=
 =?utf-8?B?ZlpndURtMmxnbG5CZFpDK201aFFpNFBKTHY2R3JXTm9zQ201STBXQTdmMlo4?=
 =?utf-8?B?TDNEdmh1Qlc0VUY3L3EzUGt1d3lsSnVyR0tDRndtUEU0YUc4ekF2dEkzTUtL?=
 =?utf-8?B?UHR6V0d1M1g2ejhzZkhUTVpBek1Rank3Q0ZIMXUyZEllZUtmay9JbGNCL1hk?=
 =?utf-8?B?ZHRsL0dZQ3hlNHBWNWtKeHF5eE5hcVNxUENIckh5VEcvOHlDYkEraTliOVVZ?=
 =?utf-8?B?c1V6enZRT1hKS3dWUEN1dXVUOEc0Z3h6ZjlTYzg3YjhPVGNGN0xxYWJHRlN6?=
 =?utf-8?B?dHcvOTRuL1A1Qzhoc3FBR0thNWFKM2x2WWpMeVhwVlRuMzBjaTNETzV6U0tB?=
 =?utf-8?B?ek9DcTh1RWZQTHc2UUNNRnQ5ZTJObldGdXhyREJldFFhRm9US1JhV09paDV2?=
 =?utf-8?B?SSthY0U3MWJ3dXNYajN4Rnl0Vzk3cGttRms3UXJlNDlvM280Qnp0Mmx2Y3I1?=
 =?utf-8?B?Zi9VZ0tqZXlqMjhvcVIwQ2UzeDlhN1JUcmwzMlEyZmlMUm4xd09XSE1wbnVV?=
 =?utf-8?B?Y0xKSGxPTVU3eWdBTm1PU1NHWnlvQ2tjYjU3OEllTXF3eUN3cXExbXNKOG9S?=
 =?utf-8?B?NnFZUzdobEtScEpWdll1cFdxUmd2anJjV3BXejVJM3IzeHlPUnZUdG15UEtB?=
 =?utf-8?B?NVlGaklQRTI3dHUyM24vQzRWWk9kc3p2aFJNL284MEhHcFVqZUtqN1VXQitt?=
 =?utf-8?B?Y2ttUk5YdHF1RnBxOGoveFM2ZCttbFFxZGtMQ2xidGliQnRxYkNWS1IrWVBO?=
 =?utf-8?B?d1A4MUJZQUVNVUVGNXdTM2JWSUlPUUtuYzRYTFVXQlJ5Y3gzdGFkNTBObHUy?=
 =?utf-8?B?RjVOZkk0ZTlYTVRMdnhQeFpwQVdLN3dpcEI1S2Q1Q2lhSWEvblBPeVNYTmRD?=
 =?utf-8?B?Wk9OcmVuQk9GRi9wQUZLQ3A4ZU9BZytTNUU2MnorZXNVbkFETXpBQWhQNGQv?=
 =?utf-8?B?QnFSa0l1dWtNc0srMEcyYVRMMFBGY2N2WGdFaUVDeWNLRklQK0lta0VOMnBU?=
 =?utf-8?B?VmxDRmcxN3R5WUZIa1AyQS95eWdya1VLNnE1ckVWTmFGRXFaVTFoalVlVVNB?=
 =?utf-8?B?bDFBdE4rZlZvUEtiNTMvcW14RkNwdm9vS290RjZTUkpiMURQVG9WV1BrakxP?=
 =?utf-8?B?d2JtWU1qSWxRRlgrR1R4akRJUlRpTlFJZGdDKzRLZkdiMkc3blpsTzErUmJ1?=
 =?utf-8?B?R0c2Ulk3Z2lIdDRaUkNkTFJVWTg2UUNjc3FFcXptSmRBdEpxSXFrdERGV2lu?=
 =?utf-8?Q?d1ekOxLzKMfi99xiUq9IF7iZB9fRG5Vi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z09PL0VuQWh1akxiY2tjSjV5S3hwS3hYeGRKWkRtZVVFYjBsTU9HcFJYcFZM?=
 =?utf-8?B?YkZ6blMweXR2aUtUUlYxeTVBd0JaOTlPVDZmUktHUFZZNFhaNnE1UURsbjN5?=
 =?utf-8?B?bEJwa0ZKMmhJOE1qYitRVllXaFdCaCtFZlEwUDhKeWlnSHpNeHFpdTlCYml0?=
 =?utf-8?B?Qm1WeXNpeDdlbUZZc2VaY0xTVHBqS0tTdEhBbHBzRlRUUXVBZVNoRmhVWjhK?=
 =?utf-8?B?Z3VFNmdDU0tKcUlhcFhTTjBuODRQU3p2TlN6eFRlUnFpejVkY3hFTURQUDVD?=
 =?utf-8?B?aW9YUG0zTHl5TWlwSGpkaEowdnQybGxUSUxBSnVRRi9BZWZabDhCeUpIRDNK?=
 =?utf-8?B?Wi9iR05rTXZCTUE2Yk1JMmJmR2NCMkRQQysrNW9hUWtvSWFuajdqdkFzOUlK?=
 =?utf-8?B?MVdBazV3a1JJNEdvMCtiWXVOQXdlYkVrQ1lnbXprRFhJZytNVG9LQ2I1NStO?=
 =?utf-8?B?ejFKSnkvNWhweEVwOUFhd1QzTU5sMWpVc1BCN3Mxa0tQRjBRTFI3WXpMVlhR?=
 =?utf-8?B?dGNsTitCNWU3VmVuWjk4c2JBTDJUbWNVb2VTZ051Ym5xUjBlcWlLYmV1WjNO?=
 =?utf-8?B?ZmZ1WDF5UFQwRnMxMkpBeUIrbkVDdm95aDh1ME0rUGVPRUJDVVI0UnVyZGdh?=
 =?utf-8?B?dE9qdlVCbTArSlJ3ZDdPWkc3OHI2UUpyd1hXVVgvZW1mSTlaTVlaNGMraWcw?=
 =?utf-8?B?Qm03cytpOTRVdEwraisrZ0w3OGwyVDFwOFJpdGUrdUpRVVd3ZE1DRXJRU0l5?=
 =?utf-8?B?VTQ0QkdMdHlQNFRlV2dpVVpxQ2hYT0RvdURkTi85WnhiRXpEWGx4ZjRaQi95?=
 =?utf-8?B?SSt0ZEFKdkxKbjZxa3R2Wm5CUWxVNVNSWVhvZ0s2WVBvQWxOQWFzVzJ5dWhz?=
 =?utf-8?B?WUFZZGZmVEhad0NlSGM4U1JzMUlCbXVyNERvakp2b3J5a09NSU1OMGNrdXA4?=
 =?utf-8?B?aDFzR2tKN3NBNU5vNzZmV29EcGZJR0FObUh1VWtjQVJGYVV0cW1wMDhnT05m?=
 =?utf-8?B?dTB0S1h5djNrWHNYSlE4blE1Q3FTS2dmYnVMQVY2YmYxUERUd2w2UE1DenEv?=
 =?utf-8?B?MkpFdVpERWVjRHU3cEdBcC85WksrMjN0SFIwSHFvSkpRREpsL2VFZXVHUlQy?=
 =?utf-8?B?dmt3WkpWZ2UrdUVxRlIrelZJZ21VSDRRVkQvTmxhZ3Bid29UQm1SOTU5L1Jr?=
 =?utf-8?B?d1RTUUdqTlpyRVpmUlBXR05pY01jaThVdDFGa044N0k4SERFN1g4RzlsYmVL?=
 =?utf-8?B?Q3dLOHR1WU9pWW1ydTBBVFQ1bXE2ZE0zN0JTR3A0VHZ6enlFOVZHQ2hSR1Fp?=
 =?utf-8?B?cW5DVkh4a1ZPUG5tQnlEM0xyb1dNWFhpWXRTRVpvOVJEcDhRUlFxNk5raTVF?=
 =?utf-8?B?VU15TEdOL0p3bTMwVk16bjdWT3BKOTVJeWExc1BBL0haWFFtQ0RpSTRPNWVB?=
 =?utf-8?B?VVhRblZUZmpyaGlxUzhNOWdjWUtmZm9ab2xLU0J3UXJOaDFzUzQ4aGlGb3ZH?=
 =?utf-8?B?Rm9LMms5Y3YwNDc0SnNyZzM3RVdBUHRMeXZQZnYwT2UvMi9lc0NKNDhOVk1X?=
 =?utf-8?B?eVRhdmUyME5XTWQ2L1p5ZXRxR2g2WlhpbElveXVYdWVhZjQxZitnejZKcHdP?=
 =?utf-8?B?VkU3MUwxcEN4bnc4dlpRWjk2emFqdGk3Q3FXQVA0aVhSekxQcVQralN4S3VF?=
 =?utf-8?B?d0xwdEhsWlVsRkJ3N2JxZWFMMTNEYmU1RUF0RVAveG40YkJCNFQrRWdIc0oz?=
 =?utf-8?B?dHFsL3AwSHZrQlpZcTEwTVkxOEQ5TEVzRVBwY2hkdUdMZUJyNGhlaCsxTU5V?=
 =?utf-8?B?bkxPb0tHKzg3MjJad0xMVWlRbVA2Nm9FdWJBQ3BIcWRRVkIxNHBiZmVpYlJk?=
 =?utf-8?B?cjlBc1MrR0V6QnBHanp3ZjFyd0VFdVc2dG9jMGlnNEZJY2dwbGdTY05RSFEx?=
 =?utf-8?B?L1orTjFrbXVnUjAvQ0l2djJ6WHhicUQvM1VjUzQ3SWhFZkpOSTZ3cU1VSUpt?=
 =?utf-8?B?V3c1U2RRTG5QdWEwbXZlU000d285VndvTnZ4OGViRVEyYTlyeEN1d2taenAx?=
 =?utf-8?B?cGI2QnJKWWdTMWt6VTd2WXJSVnkzdytEWlBscURqM2xmTUY0NUE1QlAweUUw?=
 =?utf-8?B?dm1seHp3UjFSKzMxK2U2dDZ1YUJrMVBscWZtL1FXbnkxM1B4M1V4V1Iya2ZR?=
 =?utf-8?Q?47a4J6v5N942MBKu5H17rxI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF319425CE3B2C4DA7C21E4938DB44D6@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5d497d-5643-4d65-ced1-08de26368798
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 00:07:57.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6E5/X1AkeNBenCO8hv793HeS30I2volLWeC3dKH0qnbmVYWXXB8ZnA3lWY9qDXHY1sZ0ZYYzEX8BQHZyQ3D4KJpxKbCoIsP6ksxkk62bow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6908

T24gMTcvMTEvMjAyNSAxMDozNCBwbSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBNb24sIE5v
diAxNywgMjAyNSBhdCAwMjozMjoxNlBNICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+PiBP
biBNb24sIE5vdiAxNywgMjAyNSBhdCAwMzowMjoxMUFNICswMDAwLCBSb21saSwgS2hhaXJ1bCBB
bnVhciB3cm90ZToNCj4+PiBPbiAxNS8xMS8yMDI1IDE6NTkgYW0sIENvbm9yIERvb2xleSB3cm90
ZToNCj4+Pj4gT24gRnJpLCBOb3YgMTQsIDIwMjUgYXQgMDI6Mjc6NDFQTSArMDgwMCwgS2hhaXJ1
bCBBbnVhciBSb21saSB3cm90ZToNCj4+Pj4+IEFnaWxleDUgaW50cm9kdWNlcyBjaGFuZ2VzIGlu
IGhvdyByZXNlcnZlZCBtZW1vcnkgaXMgbWFwcGVkIGFuZCBhY2Nlc3NlZA0KPj4+Pj4gY29tcGFy
ZWQgdG8gcHJldmlvdXMgU29DIGdlbmVyYXRpb25zLiBBZ2lsZXg1IGNvbXBhdGlibGUgYWxsb3dz
IHN0cmF0aXgxMC0NCj4+Pj4+IEZQR0EgbWFuYWdlciBkcml2ZXIgdG8gaGFuZGxlIHRoZXNlIGNo
YW5nZXMuDQo+Pj4+Pg0KPj4+Pj4gRmFsbGJhY2sgaXMgYWRkZWQgZm9yIGRyaXZlciBwcm9iZSBh
bmQgaW5pdCB0aGF0IHJlbHkgb24gbWF0Y2hpbmcgb2YgdGFibGUNCj4+Pj4+IGFuZCBEVCBub2Rl
Lg0KPj4+Pj4NCj4+Pj4+IFJldmlld2VkLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29t
Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogS2hhaXJ1bCBBbnVhciBSb21saSA8a2hhaXJ1bC5hbnVh
ci5yb21saUBhbHRlcmEuY29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiBDaGFuZ2VzIGluIHYzOg0KPj4+
Pj4gCS0gQWRkIGRlc2NyaXB0aW9uIGZvciBBZ2lsZXg1IERldmljZQ0KPj4+Pj4gCS0gQWRkIGFu
ZCBkZWZpbmUgZmFsbGJhY2sgdG8gImludGVsLGFnaWxleC1zb2MtZnBnYS1tZ3IiDQo+Pj4+PiAJ
LSBWYWxpZGF0ZSBhZ2FpbnN0IEFnaWxleCBhbmQgU3RyYXRpeDEwIChub24tZmFsbGJhY2spIGFu
ZCBBZ2lsZXg1DQo+Pj4+PiAJICAoZmFsbGJhY2spDQo+Pj4+PiBDaGFuZ2VzIGluIHYyOg0KPj4+
Pj4gCS0gTm8gY2hhbmdlcyBpbiB0aGlzIHBhdGNoDQo+Pj4+PiAtLS0NCj4+Pj4+ICAgIC4uLi9m
cGdhL2ludGVsLHN0cmF0aXgxMC1zb2MtZnBnYS1tZ3IueWFtbCAgICAgICAgIHwgMTQgKysrKysr
KysrKystLS0NCj4+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZnBnYS9pbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyLnlhbWwgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBnYS9pbnRlbCxzdHJhdGl4MTAtc29j
LWZwZ2EtbWdyLnlhbWwNCj4+Pj4+IGluZGV4IDZlNTM2ZDZiMjhhOS4uOGViNDE0MTYzZDA4IDEw
MDY0NA0KPj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2Ev
aW50ZWwsc3RyYXRpeDEwLXNvYy1mcGdhLW1nci55YW1sDQo+Pj4+PiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBnYS9pbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdy
LnlhbWwNCj4+Pj4+IEBAIC0yMCw5ICsyMCwxNyBAQCBkZXNjcmlwdGlvbjoNCj4+Pj4+ICAgIA0K
Pj4+Pj4gICAgcHJvcGVydGllczoNCj4+Pj4+ICAgICAgY29tcGF0aWJsZToNCj4+Pj4+IC0gICAg
ZW51bToNCj4+Pj4+IC0gICAgICAtIGludGVsLHN0cmF0aXgxMC1zb2MtZnBnYS1tZ3INCj4+Pj4+
IC0gICAgICAtIGludGVsLGFnaWxleC1zb2MtZnBnYS1tZ3INCj4+Pj4+ICsgICAgb25lT2Y6DQo+
Pj4+PiArICAgICAgLSBpdGVtczoNCj4+Pj4+ICsgICAgICAgICAgLSBlbnVtOg0KPj4+Pg0KPj4+
PiBUaGlzIGNvbnN0cnVjdCBpcyByZWR1bmRhbnQsICJpdGVtczogLSBlbnVtIiBpcyB0aGUgc2Ft
ZSBhcyBqdXN0IGhhdmluZw0KPj4+PiAiZW51bSIuDQo+Pj4+IHB3LWJvdDogY2hhbmdlcy1yZXF1
ZXN0ZWQNCj4+Pj4NCj4+PiBJJ3ZlIHRyaWVkIHRvIGxvb2sgZm9yIHNvbWUgb2YgdGhlIGFscmVh
ZHkgbWVyZ2VkIGJpbmRpbmdzIGkuZQ0KPj4+IGFybS9xY29tLnlhbWwgKGFsdGhvdWdoIGFsbCB0
aGUgcHJvcGVydGllcyBoYXMgZW51bSAtIGNvbnN0YW50DQo+Pj4gY29tYmluYXRpb24pLCBpdCBp
cyB1c2luZyBpdGVtcyB3aXRoIGVudW0uIEkgdHJpZWQgdG8ga2VlcCB0aGUgZW51bSB3aXRob3V0
DQo+Pj4gaXRlbXMgYnV0IEkga2VlcCBnZXR0aW5nIGVycm9yIHdoaWxlIHZhbGlkYXRpbmcgdGhl
IGNoYW5nZXMuDQo+Pg0KPj4gSSBsaXRlcmFsbHkgdG9sZCB5b3Ugd2hhdCB0byBjaGFuZ2UsIHNv
IEkgZG9uJ3Qga25vdyB3aHkgeW91IGRpZG4ndCBqdXN0DQo+PiBkbyB0aGF0LiBSZXBsYWNpbmcg
Iml0ZW1zOiAtIGVudW0iIHdpdGggImVudW0iIGlzIHdoYXQgeW91IG5lZWQgdG8gZG8uDQo+PiBZ
b3UgZGlkbid0IGV2ZW4gaW5jbHVkZSB0aGUgZXJyb3IgeW91IGdvdCwgc28gSSBjYW5ub3QgaGVs
cCB5b3Ugd2l0aA0KPj4gdGhhdCBhdCBhbGwsIG5vciBldmVuIGlmIHlvdSBkaWQgd2hhdCBJIHRv
bGQgeW91IHRvIGRvLg0KPiANCj4gbm9yIGV2ZW4ga25vdyBpZiB5b3UgZGlkKg0KPiANCg0KICBw
cm9wZXJ0aWVzOg0KICAgIGNvbXBhdGlibGU6DQotICAgIGVudW06DQotICAgICAgLSBpbnRlbCxz
dHJhdGl4MTAtc29jLWZwZ2EtbWdyDQotICAgICAgLSBpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdy
DQorICAgIG9uZU9mOg0KKyAgICAgIC0gZW51bToNCisgICAgICAgICAgLSBpbnRlbCxzdHJhdGl4
MTAtc29jLWZwZ2EtbWdyDQorICAgICAgICAgIC0gaW50ZWwsYWdpbGV4LXNvYy1mcGdhLW1ncg0K
KyAgICAgIC0gZW51bToNCisgICAgICAgICAgLSBpbnRlbCxhZ2lsZXg1LXNvYy1mcGdhLW1ncg0K
KyAgICAgICAgY29uc3Q6IGludGVsLGFnaWxleC1zb2MtZnBnYS1tZ3INCg0KJCBtYWtlIC1qMjQg
Q0hFQ0tfRFRCUz15IGludGVsL3NvY2ZwZ2FfYWdpbGV4NV9zb2Nkay5kdGINCg0KL2xpbnV4LXNv
Y2ZwZ2EvYXJjaC9hcm02NC9ib290L2R0cy9pbnRlbC9zb2NmcGdhX2FnaWxleDVfc29jZGsuZHRi
OiANCmZwZ2EtbWdyIChpbnRlbCxhZ2lsZXg1LXNvYy1mcGdhLW1ncik6IGNvbXBhdGlibGU6ICdv
bmVPZicgY29uZGl0aW9uYWwgDQpmYWlsZWQsIG9uZSBtdXN0IGJlIGZpeGVkOg0KCVsnaW50ZWws
YWdpbGV4NS1zb2MtZnBnYS1tZ3InLCAnaW50ZWwsYWdpbGV4LXNvYy1mcGdhLW1nciddIGlzIHRv
byBsb25nDQoJJ2ludGVsLGFnaWxleDUtc29jLWZwZ2EtbWdyJyBpcyBub3Qgb25lIG9mIA0KWydp
bnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyJywgJ2ludGVsLGFnaWxleC1zb2MtZnBnYS1tZ3In
XQ0KCSdpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyJyB3YXMgZXhwZWN0ZWQNCglmcm9tIHNjaGVt
YSAkaWQ6IA0KaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZnBnYS9pbnRlbCxzdHJhdGl4
MTAtc29jLWZwZ2EtbWdyLnlhbWwjDQoNCiQgbWFrZSAtajI0IENIRUNLX0RUQlM9eSANCkRUX1ND
SEVNQV9GSUxFUz1pbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyLnlhbWwgDQppbnRlbC9zb2Nm
cGdhX2FnaWxleDVfc29jZGsuZHRiDQoNCiAgIERUQyBbQ10gYXJjaC9hcm02NC9ib290L2R0cy9p
bnRlbC9zb2NmcGdhX2FnaWxleDVfc29jZGsuZHRiDQovbGludXgtc29jZnBnYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ludGVsL3NvY2ZwZ2FfYWdpbGV4NV9zb2Nkay5kdGI6IA0KZnBnYS1tZ3IgKGlu
dGVsLGFnaWxleDUtc29jLWZwZ2EtbWdyKTogY29tcGF0aWJsZTogJ29uZU9mJyBjb25kaXRpb25h
bCANCmZhaWxlZCwgb25lIG11c3QgYmUgZml4ZWQ6DQoJWydpbnRlbCxhZ2lsZXg1LXNvYy1mcGdh
LW1ncicsICdpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyJ10gaXMgdG9vIGxvbmcNCgknaW50ZWws
YWdpbGV4NS1zb2MtZnBnYS1tZ3InIGlzIG5vdCBvbmUgb2YgDQpbJ2ludGVsLHN0cmF0aXgxMC1z
b2MtZnBnYS1tZ3InLCAnaW50ZWwsYWdpbGV4LXNvYy1mcGdhLW1nciddDQoJJ2ludGVsLGFnaWxl
eC1zb2MtZnBnYS1tZ3InIHdhcyBleHBlY3RlZA0KCWZyb20gc2NoZW1hICRpZDogDQpodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9mcGdhL2ludGVsLHN0cmF0aXgxMC1zb2MtZnBnYS1tZ3Iu
eWFtbCMNCg0KVGhpcyBlcnJvciBpcyBub3Qgc2VlbiBpZiB3ZSB1c2UgdGhlICJyZWR1bmRhbnQi
IGl0ZW1zIC0gZW51bS4NCg0KRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2V4YW1w
bGUtc2NoZW1hLnlhbWwgc3RpbGwgc2hvd3MNCnRoZSB1c2Ugb2YgaXRlbXMgLSBlbnVtIHRob3Vn
aC4NCg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQpLaGFpcnVsDQoNCj4+DQo+Pj4gQW5vdGhl
ciBvcHRpb24gdGhhdCBJJ3ZlIHZhbGlkYXRlZCBpcyB1c2luZyB0aGUgZm9sbG93aW5nIGNoYW5n
ZXMuDQo+Pj4NCj4+PiAtICAgIGVudW06DQo+Pj4gLSAgICAgIC0gaW50ZWwsc3RyYXRpeDEwLXNv
Yy1mcGdhLW1ncg0KPj4+IC0gICAgICAtIGludGVsLGFnaWxleC1zb2MtZnBnYS1tZ3INCj4+PiAr
ICAgIG9uZU9mOg0KPj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBJbnRlbCBTdHJhdGl4MTAgRGV2
aWNlcw0KPj4+ICsgICAgICAgIGl0ZW1zOg0KPj4+ICsgICAgICAgICAgLSBjb25zdDogaW50ZWws
c3RyYXRpeDEwLXNvYy1mcGdhLW1ncg0KPj4NCj4+IFRoZXNlIGp1c3QgaGF2ZSB0aGUgc2FtZSBw
cm9ibGVtIGFzIHlvdXIgb3JpZ2luYWwgcGF0Y2guDQo+PiAiaXRlbXM6IC0gY29uc3QiIGlzIGp1
c3QgdGhlIHNhbWUgYXMgImNvbnN0Ii4NCj4+IFNpbmNlIGl0ZW0gIml0ZW1zIiBwcm9wZXJ0aWVz
IGRvIG5vdCBkbyBhbnl0aGluZyBvdGhlciB0aGFuIGJsb2F0IHRoZQ0KPj4gc2NoZW1hLg0KPj4N
Cj4+PiArICAgICAgLSBkZXNjcmlwdGlvbjogSW50ZWwgQWdpbGV4IERldmljZXMNCj4+PiArICAg
ICAgICBpdGVtczoNCj4+PiArICAgICAgICAgIC0gY29uc3Q6IGludGVsLGFnaWxleC1zb2MtZnBn
YS1tZ3INCj4+PiArICAgICAgLSBkZXNjcmlwdGlvbjogSW50ZWwgQWdpbGV4NSBEZXZpY2VzDQo+
Pj4gKyAgICAgICAgaXRlbXM6DQo+Pj4gKyAgICAgICAgICAtIGNvbnN0OiBpbnRlbCxhZ2lsZXg1
LXNvYy1mcGdhLW1ncg0KPj4+ICsgICAgICAgICAgLSBjb25zdDogaW50ZWwsYWdpbGV4LXNvYy1m
cGdhLW1ncg0KPj4+DQo+Pj4gVGhlIGRyYXdiYWNrIG9mIHRoaXMgaXMgd2Ugd2lsbCBuZWVkIHRv
IGltcGxlbWVudCBlbnVtIGluc3RlYWQgb2YNCj4+PiBjb25zdGFudCBmb3IgZmlyc3QgZWxlbWVu
dCBpZiB3ZSBuZWVkIHRvIGFkZCBuZXcgZGV2aWNlcyB1bmRlciAiSW50ZWwNCj4+PiBBZ2lsZXg1
IERldmljZXMiIGluIHRoZSBmdXR1cmUuDQo+Pj4NCj4+PiBUaGFua3MuDQo+Pj4NCj4+PiBCZXN0
IFJlZ2FyZHMsDQo+Pj4gS2hhaXJ1bA0KPj4+DQo+Pj4+PiArICAgICAgICAgICAgICAtIGludGVs
LHN0cmF0aXgxMC1zb2MtZnBnYS1tZ3INCj4+Pj4+ICsgICAgICAgICAgICAgIC0gaW50ZWwsYWdp
bGV4LXNvYy1mcGdhLW1ncg0KPj4+Pj4gKw0KPj4+Pj4gKyAgICAgIC0gZGVzY3JpcHRpb246IEFn
aWxleDUgRGV2aWNlDQo+Pj4+PiArICAgICAgICBpdGVtczoNCj4+Pj4+ICsgICAgICAgICAgLSBl
bnVtOg0KPj4+Pj4gKyAgICAgICAgICAgICAgLSBpbnRlbCxhZ2lsZXg1LXNvYy1mcGdhLW1ncg0K
Pj4+Pj4gKyAgICAgICAgICAtIGNvbnN0OiBpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyDQo+Pj4+
PiAgICANCj4+Pj4+ICAgIHJlcXVpcmVkOg0KPj4+Pj4gICAgICAtIGNvbXBhdGlibGUNCj4+Pj4+
IC0tIA0KPj4+Pj4gMi40My43DQo+Pj4+Pg0KPj4+DQo+IA0KPiANCg0K
