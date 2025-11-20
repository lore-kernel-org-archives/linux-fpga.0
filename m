Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC5278E47;
	Thu, 20 Nov 2025 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608628; cv=fail; b=GLYUVSxIkLAytLY3cQntmzd68i0edfACL828jV0nuHCR2wrrk26TQ9dD71UvCeka72m5xKi/SrOqEidF6RjpDTR3zR6n3oy6almOYwqGgr6cwTYY5Gc/m/1xzf2/sFKOYIDAivTbGpIjRuGCiRqbQHfpchqt4pUUsoOytZD0JFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608628; c=relaxed/simple;
	bh=N+e9WJZAs3EvcU1YPzi8kVvIo3+JiTDO1mNU8awWZNE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PtNqwHDF9yU07yjAoYs8oK0wKz997n4roiQ8GlH0Bt5tn6CF0mLWgC4RpkIvzceWcC6ovKwoYNBPBIiet589SKUV1HXEoAXRaZLpDS8Q8uyScf3wKq0uN9SZblnBh1rq72OomBfoRIMUw7P8ZBOvY1R2TH2tU9DY99/NUD8J2gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pE8kjurn; arc=fail smtp.client-ip=40.93.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pE8kjurn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STer3YPEUCXFvKqBEzHa6iiFhJazzfYa2IxDm4rpw3Wp00CcvROncPADFd4VH8Di8/Id9mtI0R1WDJC92rJq1W6iDU+gVENW/rTpV1QF8ES5RKMAYflcghGrtsWUiucXfEW8UOwrzDF/at3KkS5eZ11qLz/sy4kpbR/JYVnTkBtPg+7wzI9HOxFFlhSFicXvUqTByoyL7BshwtmDXhhMispJLqG/D+e1RWWhqJm4m0Sa0B1KZF9exrbvPe1fN9Dtxk2xx58s0OqPbqxJ5pMNl2d70NmMZas/tCLjbawZkKZKatL5i1y8dM5eznxvyvA/YF7NbDAvr1EAK8LU9xiCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+e9WJZAs3EvcU1YPzi8kVvIo3+JiTDO1mNU8awWZNE=;
 b=GlWzhSzYWyVzvvJIip56kSIgat3GnVu/0iIJ1ZMfm0mI6zmS/uQoYSwxr9SGwBBiMZiacC0dp9f/4D4KV7mp4wLBRw4kM2SHsy/kAsqgFq9lXKfSYUZ3dfpx7C3c2wczlrJKh/kDxJAvKEQY8WATUl1y/kJiaYu7Q7WiWlx2x5oBPO1tMro2Vp/SlI0/2Lb4Vr9T8Y5V+L3IUD32yp36FGrfv3uWufpr8H6C2EnlmFDDZHb4Uy51y2AXfLg1f/aMMHmCrYuxs9LYS6gCtp3UNMsVdCRnlzb5u6TUds5QMA5Qz/wZk7TFV9qV+V/3lEMmLDPQh68mjw6s1WpKwNy6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+e9WJZAs3EvcU1YPzi8kVvIo3+JiTDO1mNU8awWZNE=;
 b=pE8kjurnliRPOyVpi3xUnin6M8S9gTU0FBlVhnDoceEAg0cwjIw+bv4z0UIwcXHpAE5olf5z4e88FAWjeDXTgFkQNg9Equ0p7/PU6Tg3E+0TB87z+xwgadeYAG82O0Fna8M4zi7LuqM9ciKK2nCPurM6D8xS3ZldVFj75sGT3AO/5IzVK0Dvhc6NKoidM4tQE1ZaGfbm8u2vNi43RGj7DW6O8tTJ3+aApq9vORrQKTBZfCL6U35wE9yz57QESq2JJDy9r4E8+rTg3lKIvXgJrb90qptnZwI7m8HXlFfJnR2+gV2OfgSLKk2foEHLSBnob64D9IjbU0t+Q1SkAtQzxg==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by LV8PR03MB7518.namprd03.prod.outlook.com (2603:10b6:408:190::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:17:04 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 03:17:04 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Moritz Fischer <mdf@kernel.org>, Xu
 Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "Rao, Mahesh" <mahesh.rao@altera.com>, "Ng, Adrian Ho
 Yin" <adrian.ho.yin.ng@altera.com>, "Rabara, Niravkumar Laxmidas"
	<nirav.rabara@altera.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] Enable FPGA Manager support for Agilex5
Thread-Topic: [PATCH v6 0/2] Enable FPGA Manager support for Agilex5
Thread-Index: AQHcWPvgUOqzoJUfSUyTZkM21Aj6Y7T64+6AgAACYoA=
Date: Thu, 20 Nov 2025 03:17:04 +0000
Message-ID: <ef313cee-76c2-4d48-a0ef-65be249aaa7d@altera.com>
References: <cover.1763518321.git.khairul.anuar.romli@altera.com>
 <ef29742c-834c-4f00-b6db-e9a0960b6d17@kernel.org>
In-Reply-To: <ef29742c-834c-4f00-b6db-e9a0960b6d17@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|LV8PR03MB7518:EE_
x-ms-office365-filtering-correlation-id: 182e6331-55d9-4406-4ca2-08de27e3477b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0NwR2ZTUWViVmpqS2xhOHlhNWc0WjFhMVo1MkJQdW5FczBQQkZDc0VLTi9l?=
 =?utf-8?B?WXgyVDdJU2VPWVo2ZTJuWVZNdS9RZjVLM1hOQUMzUW5OWk52T1dRdWYxTldX?=
 =?utf-8?B?N3Jsb3NnajBoTWc1WGdZdnh1UVpmc3BjblJMeUU3L0lxV3BzMGpVekNDbytJ?=
 =?utf-8?B?cE5NaitOUnBzQ2dndk5LZlEzTXdmVit2bTE2OVEybnVOdGFTSVpoR3JNR2NC?=
 =?utf-8?B?N2FPR1AxbE1sL2o2bzJwUDRZeGJHTXFDMTZrU0RFVkd4Z3RnN2VkeEF2R2Va?=
 =?utf-8?B?T1BzcWVENWZYL080M29wbms1cERmbUNPSk4wUUI2MlpOZk1DL1lJTndQVmky?=
 =?utf-8?B?K3VvZXRVZmlZYWZFUy9oU1ZuTi84YXdFL01LQk9TZTdSWTdsblF1R0hnR3lm?=
 =?utf-8?B?Qk5LUlI2ZUZCK2ZIOFk2RzlsWnIxdG5IdE5IbHFnSmRFeFhnR2xVbUEzV2tU?=
 =?utf-8?B?WEFpNG1BMkVvK0RIclF3VVRyUXkzV2FsUm1PVDU4L0svemF5Y3c2UTF1UkV4?=
 =?utf-8?B?ZFc5S01rdStiS0ludDJ2VHpYbzZQejR6anhwcHkzbU5UTDkyQUFvUTVya3pt?=
 =?utf-8?B?cXY3TzVSL05ZbHlucWRyM3VvZkVBOXhYUFg4YVdndTRtSmZZenZ6Sm4zRjk1?=
 =?utf-8?B?SG51MVVCaDhWN2RRU3RCcS9KVC9Kd09zRDY1WWpsV1FZTmI0a3NKQVl1M0JJ?=
 =?utf-8?B?QTlMTDRHUTNCYTVrbmVKN2cvS1lLYlVJalBBZ1RXZzhjM1NvanR1VFpib3VJ?=
 =?utf-8?B?ZUNyY3BSRklJUSt3SFlmdS95S1hKOGZFZHQyQXBxWVo4THBhQTRseVpNa25v?=
 =?utf-8?B?K0tBbkRhMG00ZllmY1VyeTZFT0txSFVXVXhBZ0QvV1RtWUphV3crOHhoZ1pj?=
 =?utf-8?B?Z1hlcE14OHZ0ZVYySFRoMldyZCtTYjJXOHgyczF6WHZ4MUFLWWQ0NkJhTXIv?=
 =?utf-8?B?Ti9vRlZMZDMxOVZkeHRVRW5hNGJ6VXJmOXIwbmFSUVc1WmxmL0F5TUZrY3B4?=
 =?utf-8?B?RmFXZlhmelJRUUdZbHd4RDZtYUJNTDlRSy9uY2hMUlBVeFBJaHBMWGxuMmJF?=
 =?utf-8?B?UmtIU3krc3YreWFQeWswOWlsK0dWb1c0aVhBYnQvWG1lRnVFOXNLMzRpMDZC?=
 =?utf-8?B?ZmFPZHNnb2V1c2svdlVkemNWZXljamZ2WVJyREVGbUhkRVhZVDhORDEvWk1Z?=
 =?utf-8?B?Q0lGOHlodm05NlpzSDBWemlLVXZKWVhNeHlEMG01anNTM0phdGh3SXZOd3dm?=
 =?utf-8?B?Zy9SeUsyK1liS0JTUjVzRUhwVktFZzJROHZWSGZYZmp1RTJmR01Jck11WVQ1?=
 =?utf-8?B?a3pMNHRxNDk5V0owNnI3ZVljdnI3WDZhVGNFT3BiRWR2ektoWlcrN1VSZDVN?=
 =?utf-8?B?d2tJZXdJZEdYeVVtZ0c2TkpXRVBNV1AxSEQ5Q1NmenpWeU95dlBnenBPaERX?=
 =?utf-8?B?RnhhV0grRHpsMmE3bU5FdWRWRk9oOVpUNEI2ek93RmpoL2ZOYzdVc241Z3lW?=
 =?utf-8?B?WGY5ZzdaYjN1RFRGTFZUcktSR2JkdVUwbzU4SmZ1NU1lenFjWGk0QWVWMHRJ?=
 =?utf-8?B?ck9oZjI2aklmYmN5bW9OYlpldy9QNlNqS0prd2Jra045UHZGY2JBd29TTjZa?=
 =?utf-8?B?Uyt1RUN0UDU3T2dvSGN6MVRqNTVPeEx0d3VLM2F6d2lOVGF4OGowUFBxbnFa?=
 =?utf-8?B?aFlta1RWUWZONEZtb1V0eDJxazdQbUxSRXZnaTUvRWhQcWs1VEEwQzNLckcr?=
 =?utf-8?B?WXI1Ykt6WlRDTUZlUURzMjFXSUE2UCtxNTFqT0ZYWmxXTVdDRW42Y3pRbVZj?=
 =?utf-8?B?dTh5QmJIY1RqOHA4eGRtcmttWitudW5VcmZ1b0NtYWZYV05hci9FRzhmWVp3?=
 =?utf-8?B?UVU5Z1FxWjZxem1ISVI4Rm15YjZsWXdsb2FKTXVCNDdXTCtDc1FYbDZhcEZu?=
 =?utf-8?B?VDlpTUJrdDNOaWppS3RYbWJxcS9FRFBpR1hCTTNud0hZZ3pVNDBvVFd6L0dK?=
 =?utf-8?B?Z1VIWUMwVytsQnU4NUhBdmp1aVU2S2RZWEhDdFNOOWF3QlFJazRDQVNmNUIw?=
 =?utf-8?B?bVkxM3Q3bDB6SElRd3JFQ3Y3a2RsYlZneVg3UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWJqUXdRaFp4ZW5QclpZRUo1UjVCdVpXOU9xd2lVVitBL05qUmZmQzRPVHpH?=
 =?utf-8?B?azNnUzFzdldocVFUNzg2c3JnQjJqREFrY0pQZHgvSk9OUGhTSnJDTk8wMU4v?=
 =?utf-8?B?dmtZYjQzTDZ4V01tYmFKZ1F1WkQ3QkFIMWgzOW5DblB3S0VQNUpkam9tclAw?=
 =?utf-8?B?RE01R2lOYWE3QXkvRlpBT0dxbm96a2NFSlpiY0dSaEI1Q1pOWTlZVUdGOThq?=
 =?utf-8?B?Y28yYXNrMG9sU05CMnA2MXYxaFBpcm12YWd1VUlLTzk1d2NvSVNaR0RWaFJx?=
 =?utf-8?B?UW50bE5rWWF4emo3dHY2eitmVUhwV2JOVExNREdJZlpzRDJ3QWExTlB3OWtn?=
 =?utf-8?B?ZHU2bkRPQXpYQ1E2ZkdNamhEMXVrdSttYlRPU1o2WXdHWWRQQm55RC9kS2NW?=
 =?utf-8?B?S1hyVUxReTNWMGtYbkdkQjZLMnZpS0dMLy9NZWJGQkNYSEE5Z2ZCT0RnOWJa?=
 =?utf-8?B?d0hKT3MwVkl5bW02TDRHTlo5bWVxdWhoVzAwU3Y4ZitPYm15NmRZTWN6eVlV?=
 =?utf-8?B?Q3pJL2Zyd0Z1a0VzblB4OXhGNHRQbTlIV0JmcUpHNk9UMHROeElSZERjOXNi?=
 =?utf-8?B?eTQyeUlrUnRCOEZ4a2dTQkRSUkY5MDRyR1p3OVp6V2FrMEZxUnpOVGpBVitl?=
 =?utf-8?B?cWg3UUNiNWdCemJEald0N2VEc0VJeXFHVHRHbi83SzJxLzlYbnA1TlVIMzR0?=
 =?utf-8?B?bGppR0dFUHdUL1d0Y0FFYnYvTXNLclB1NjIvczdKOU40QzloTTd4TzJvdytD?=
 =?utf-8?B?dERTUm5MTTR1ajFZdDBvNFE3QWVvcUlaVmI0RzhhQ2Q2TmZkSnpQeUxwZmZ4?=
 =?utf-8?B?dlJQdHFNNWlkNS8vR0QvaXJrR1Y4K2k3bitRN2xlU2pCTHNUa1NZZm9rM1ll?=
 =?utf-8?B?TXdLMUs1NUFqLys4UzBFTll2TlBRdllrN0prVXFlb1VmbXRjVjdRK0NuN1JM?=
 =?utf-8?B?ZEhFdnB3bkkwYnpCSkdQbm5nVmNrVlErTzB3R2Y3QmNkSEowbXNJNUpONXlR?=
 =?utf-8?B?OUF1VEJHRG9DNUs5V04rRlc2cWdZMG1SRjIvdGR0OS84c2trcVZJNUpzbEk1?=
 =?utf-8?B?ZlFzZVE0RFIvMXgvRFZRRTdBZk12RENicFVXcHBFR3hnS21yb3prY2pCaEli?=
 =?utf-8?B?MWdweVJFekJXd25GOXFYSS82bXlHeVFxSG8vVGpQKzh4L1dSVDBRTk45a1dO?=
 =?utf-8?B?SWFMNE5iVC80bksrbytuVjd4QXJ4VHo5TTIyQ3cvcHhpZjRTbms0WURRRnNn?=
 =?utf-8?B?a1hKejZFUnJzZ0lubW42TzB2Zkx1d3RHZTZ4eTBxT0JaSkJ0blhDQXRkZWlO?=
 =?utf-8?B?TGwxSnZSZFJKSzIwQU8vZkxpUXdiemYzTndYZ0szczlxWXM3RFpqVlpaVkc0?=
 =?utf-8?B?MnRqRllJdDVlSHBnWHNPeXg4aDJUejdyYWZWNEo0Qm5ZaGxkOThrUFk2S3E0?=
 =?utf-8?B?U0FkcnFTTzBxOCtRUnd0M0c5KzZTVVVkRXZWTzE1Q0g0UzE5bGlESDJEdG9z?=
 =?utf-8?B?UkRaeGNNcUNUTFFOYjVHRjljU1RlSXpLWEtCakh4QW4xeVdCZkh2U3dQM3lt?=
 =?utf-8?B?REFGVVVneTJKeXFWMTQ1UU1XL0p3UmQyNnVZdXpIRmhNUDgzUnR1SXlsOVV2?=
 =?utf-8?B?ZHNFbnh5K3Y1YTlKSnFqMWw1RXkrbzVCaE9DMTd5NTNnN1cydTJyMVRxbGVu?=
 =?utf-8?B?VkxjQmg1cEVrUmpBS1VjaDFpU1dxV1Rjdm1DOU1wUlBldmczRUVhWGVsK1Z2?=
 =?utf-8?B?S2QyVkJ4YUg0dWRIeU9SVjZPY1N1M0ZpeWk5VFY0MzdCRHZqVmRmY2pFNThq?=
 =?utf-8?B?SUU1Z0JoRms0UlFYaUt0MnJjN2xWbVhiN1ZpczJHbjRGa1pXbGc5UTk1VzJn?=
 =?utf-8?B?ZTNNNVVlN3F5cUdEcXZRcEJQekxXNlV3L3NxNlBJaDA1TGpobFhnZkdFS3NI?=
 =?utf-8?B?aXg2QmdJdnFoVk9FVmtjV0xkMXh6L01RZ1lsQU5LQTU1UlFhM3BqRWNJeTdQ?=
 =?utf-8?B?QzRaNkhNMU5SVFNnMDlKeUYzUnlXaHVZYlVTREV5V01hNllLRDQzb0JCYkhH?=
 =?utf-8?B?TXBFbVM3aDVkdThxMWNKVlZ3U1o0MFdtS1FHeHhKZjNaenhHOVJ6akpYUVgy?=
 =?utf-8?B?NUVpMTFqTG5nQ1V2cjJGblNtWVVqZTB0UzQycUZGU3V3QytqcXY4VWZHQ3hX?=
 =?utf-8?Q?TQeJJmrZHyv+fOgOMk6fPYw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AA7491698D28446A7757D2881CD2CFB@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 182e6331-55d9-4406-4ca2-08de27e3477b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 03:17:04.3192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtY+aJsuWtJDnWIwWwXzTEwP2hozjcvr4y2BNXPNttu27gKNJjQwFfHMceu8GNnt7D63BJNXFoKxvQwa/7pswjftd0LBymQBzMryjKTssk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7518

T24gMjAvMTEvMjAyNSAxMTowOCBhbSwgRGluaCBOZ3V5ZW4gd3JvdGU6DQo+IA0KPiANCj4gT24g
MTEvMTgvMjUgMjA6MjYsIEtoYWlydWwgQW51YXIgUm9tbGkgd3JvdGU6DQo+PiBUaGlzIHBhdGNo
IHNlcmllcyBhZGRzIGRldmljZSB0cmVlIGJpbmRpbmdzLCBkcml2ZXIgYW5kIERUUyB1cGRhdGVz
IHRvDQo+PiBlbmFibGUgRlBHQSBNYW5hZ2VyIGZ1bmN0aW9uYWxpdHkgZm9yIEludGVsIEFnaWxl
eDUgU29DLg0KPj4NCj4+IFRoZXNlIGNoYW5nZXMgYXJlIGludGVuZGVkIHRvIGVuYWJsZSBGUEdB
IHByb2dyYW1taW5nIGFuZCBGUEdBIG1hbmFnZW1lbnQNCj4+IGNhcGFiaWxpdGllcyBvbiBBZ2ls
ZXg1LWJhc2VkIHBsYXRmb3Jtcy4NCj4+DQo+IA0KPj4gLS0tDQo+PiBLaGFpcnVsIEFudWFyIFJv
bWxpICgyKToNCj4+IMKgwqAgZHQtYmluZGluZ3M6IGZwZ2E6IHN0cmF0aXgxMDogYWRkIHN1cHBv
cnQgZm9yIEFnaWxleDUNCj4+IMKgwqAgYXJtNjQ6IGR0czogYWdpbGV4NTogYWRkIGZwZ2EtcmVn
aW9uIGFuZCBmcGdhLW1nciBub2Rlcw0KPj4NCj4gDQo+IEFwcGxpZWQhDQo+IA0KPiBUaGFua3Ms
DQo+IERpbmgNCg0KVGhhbmsgWW91IHNvIG11Y2ggZXZlcnlvbmUgZm9yIHRoZSByZXZpZXdzIGFu
ZCBmZWVkYmFjay4gUmVhbGx5IA0KYXBwcmVjaWF0ZSBpdC4NCg0KQmVzdCBSZWdhcmRzLA0KS2hh
aXJ1bA0K
