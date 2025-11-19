Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768534F881;
	Wed, 19 Nov 2025 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763516709; cv=fail; b=o+j/60/swr/Lb8v8SCooaZ6oUZG50MTkO/6UY4IXbk95KKkyQxa/Ogj6deEt/eC1yee7Il873GbTymBnH4GPRGcFa4g/vdUgENdHBEoMVp91P89xhdYGsg+o2bW/JYO+8juUHEPUleMHSjgB99/uUGGdI6agsL7/uN1wYRiS1os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763516709; c=relaxed/simple;
	bh=7gEllZvdzGPTXH1XnaYlwHTIui6gO1MCWgvWkJSHsBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tQOrRfcPexc3m8yB9ZuQPFu8QPfskJmZmUVjJUmv6A6ud8vN20Jc2BLcKQghEgwcR4NpN+xcTUGmi5KN+koHmMcSw9T0JJ0nreNt8DFTCbDh2Sh4T2upoaZVGqoGyF4/jMO8+m9FHoubXCk90qZIJqST81cGDP8AsM6rUfmaoTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=llCzgbMZ; arc=fail smtp.client-ip=40.93.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="llCzgbMZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm+AAy0mmrEDeg5b08tH2JBh5VgNrc/9as8JR3ADbvjK4sbvO7HwBI9s8PuhGsV2h/EoIJCqhN9jadtayzm3gxOcWN/YRrfyE62CoRnQ1Or/+3fq+Owt+W5d3pW1++58HFORjmRB+Qo9crp2ZHap01ee8vsiH59Ov3t69s0eqhxEiMgp/U/IL1W+Nfk5xG9sFZzVfdQkSwy6bgyPmDTsaoJC7yoPn4QZqVuxTgxmMpLEhVL1S7RttjQEhaQXaj1QIwsvfculQfFaZWXzIgruRJDQ9sayc5B55z0DNdQ/twiWYk4sIWhe0Z2anyJyc59UTyrJQcTwriBVpy3FqZotKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gEllZvdzGPTXH1XnaYlwHTIui6gO1MCWgvWkJSHsBE=;
 b=pmbxVh0wBJEUMprfbBbXJKxb1bNpdhlJkLjFds3F2rGPpVYEDn+i61P+4CP4ayS2CA+mXQ6pUnq5VD46z32j3AO+vFxzRbtYpb4iHfTh0j2oTWldGggYoCBRvLYUZwXjDukwfWQwWonu39WodKSuCK1xm2TlXOYa7p/+9VyJYs4yEMsiqZpm14W6qoM0Rgbhw6E6UNDUHDep8aLTjjeSG2IVvRlB8AZBj+3OryMXv+OlgjZG9a1JPn5OpitIg0KDWI5Jr0hZ6QGb8atnsYsvUK63qONlVd/wv/CShpS9ZwFT4PW9ifTYQrSLUM3aZjkTPn3o0la84NNH+TRBdkyxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gEllZvdzGPTXH1XnaYlwHTIui6gO1MCWgvWkJSHsBE=;
 b=llCzgbMZGzxjfCUzaaU9uzHSmsUNTb0KOHBUkJoLIK92iR7VretnDk1FVifvLjvlfk72X3OkAAev08Af4Wqjpbmdv414mNCKq9ZgtIVk7hBknkBESwhmKn7ClMgmYse3TAKjxCw3yLcdDUqBpM3Jr1KUZMHTk/GXGdCVUYwqJF7ivF2VM9tP7O8JTqzrEd2xcF+XeBJskwwdczd2Z8gKa7ka2fr14uFIg09U/cxuuwVnoOH5NHQUR3WeathLH9verj+UHvvloLeBYZwBTDeioikmF6eZRIUy/za9bvCbdGytXHyxFecc2Vok4EpNQp8E+81DBhHmvswUDFiwYa7fNQ==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA1PR03MB8067.namprd03.prod.outlook.com (2603:10b6:806:45b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 01:45:03 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 01:45:03 +0000
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
Subject: Re: [PATCH v5 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Thread-Topic: [PATCH v5 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Thread-Index: AQHcWOPk/CHLEeNf4UGQpeAIq+TtdLT5M3uAgAAG/IA=
Date: Wed, 19 Nov 2025 01:45:03 +0000
Message-ID: <07575ce3-eab7-46dd-baad-8a909124a962@altera.com>
References: <cover.1763508492.git.khairul.anuar.romli@altera.com>
 <e013899786a6a199627bc56c9766672d215a4e23.1763508492.git.khairul.anuar.romli@altera.com>
 <20251119-switch-dubbed-84e2ae59d04c@spud>
In-Reply-To: <20251119-switch-dubbed-84e2ae59d04c@spud>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|SA1PR03MB8067:EE_
x-ms-office365-filtering-correlation-id: f7828643-b5e8-4fb6-1e56-08de270d4266
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bU52bUxESlpBVXM1Z1BXSzk1ajVIRmVtcGd0c1ZlbmFxZ0wzR21hNGR2VHBZ?=
 =?utf-8?B?U1pTYmFGa3pUSGxRRVp5VThoUTVSNlVqcTlIZHFyTEpJaUJMSjhlSGNDTmxx?=
 =?utf-8?B?YTBlYkRlZzh5bHdyMDVPZFpuSjRjeDU0V1FLbHRENk9IQy8rZlBKcklSME9k?=
 =?utf-8?B?RVFER1A4MkxEOU5Vcit0RUdDcTZzeU9IWmZ5QzA3ZnJKS0xkaURaZDZJYzcv?=
 =?utf-8?B?RnpCekQ1aDZwS1pweUZlK2dPcUM4NU1mVVJ1Z0t0dElEaDNmZEFnZ0tOc2hY?=
 =?utf-8?B?SGN0dTROamp2Z3ZmSGg5V0x3WWIrUXpybThYUXY1b3JGeTBzMVQ4SDYxWndH?=
 =?utf-8?B?T2xoUW1DWGU2NkNxRncwRVM1eVl5N2VWQmZzR3dycGJsNmF3OGtkd0puSU1m?=
 =?utf-8?B?TXNtTUxlUi8vOFBoK2lMYXRyN3BySU04Nks3bkw5VzlVczd5R1Q1T09CdWky?=
 =?utf-8?B?UWo3ZjcvNS93VkV1WU5oS2h0eWxmbnRhbGtiUy9qOGl5ZkJUOVczQ2k2TmhD?=
 =?utf-8?B?V0RDMXppUTN0REduWUhENmtzVjREYnJxNGJzRmJiNEtDMkU2a1J6UFlnWC84?=
 =?utf-8?B?ZVBycWFCMGROOHA4STJVL1FoU0ZIb3RxeXJ6MHNNZkFyRzMybUh6eFl2eElH?=
 =?utf-8?B?MDdmd25Sd2lKNE92TVQzeVQvQUNZWjZCWXkzYVk0UzBpOEZhQkpwNXpjQ1p4?=
 =?utf-8?B?cEllSThtOVVPbGpCTys2cFVhSmRIc0lzMFd6WlJkZmVCY1N0T1h5K2RSV2hK?=
 =?utf-8?B?VDlUN2VOUU8zU1ZQbFAxTk1pbXhWakhzV01ZaE1ZejlQejkxRFZOaU1KaCt2?=
 =?utf-8?B?eDlMQlBsL2o2RHZRR01MdCtLS3hWejRZUjV5UUpOQnlHeUJJYlk0ZEk1VnhG?=
 =?utf-8?B?UzU4cC9Ub0NmUjZHK0EvekdJRG1jWk81S2w4SlBjRjdLRmlBb0VXbDlTeURt?=
 =?utf-8?B?QUtDZXpiV2FEMFZVdjIyOVUvYlAwaGtodXhDZWVOOXFRMFhtNTdONXp2RlVl?=
 =?utf-8?B?WVd6NXprdkQvS05MR1ZsMjNRUVlqbXlUR29ZL0F4K1NENnFGZUVSQ2lBNTZz?=
 =?utf-8?B?S3NFeXRoS21KSTdJTmh5RUVsK3BXODRyd3VMR0NlaXF0TUFnaEhZcitGYmM5?=
 =?utf-8?B?ZExnNmhJQmF5eW9UUkJOUzlTKzhoc29LWXhlRUJwTFdRYXBJcVpFTytLblJ3?=
 =?utf-8?B?TlBhRmxJTkJPOGt6RVlMUjlhcmNtaTVYczNxbWxvSmMrUEtTdTJpb1lpV0ZI?=
 =?utf-8?B?dGZJNjJkNFZyRmF2eE9yNjVOeHEvZVo5TkFKdE00VTYxWVI4c0dldEo4ajZp?=
 =?utf-8?B?eExnK3hnUzJFcWRmMXNjNFhYSk5vTytWSUpBSWNNcjJETGFzUzBRSy9SUHlo?=
 =?utf-8?B?TGo3ZUpiU3BJSksxN3JyYlVaM1lMb0l2Y01HSFE1U21scWJXR1orRGtzTURY?=
 =?utf-8?B?OC80dWxDS1dkK1k0SEswd0M3WGdITVFFVW53SGt0QlNTbms0S1VtTXJUaXJM?=
 =?utf-8?B?WnIvSnhwa0F5NjM5bjFPazNPZHd4RXBjNjk0V203U0dkRXY5Q21rVGZoOTJU?=
 =?utf-8?B?T3RHdTNYMVJtYWNJSGZQQ3E5Ry83NUZDWXR3QTg0aWUzK2pqaHJPZk1ZQ2lw?=
 =?utf-8?B?a0EwMTNoZGkvVUxEUG4xSkxwbkdsU1ZuVU1NYWQ5VGdUSkhEWFBZc2IzTjF6?=
 =?utf-8?B?emVsYWxCZEplTGpvejZMMk1kalZCOW95azdRRytpTGhQR3BFMkozMnV3SGFB?=
 =?utf-8?B?bW9COWZDK2JRckU4QVRCVDdZMTFvNXVHUUloTEVZdU9hS29LVHZWNTZ6dUcx?=
 =?utf-8?B?cmpUK1JUL1hvKzVKTmRza1BzbXRxWVNiTTFNRk1hMGRNd1E3SStSc1V6d2pU?=
 =?utf-8?B?THpxV1R4bG5meWFOTHhERlNqeUNPUE5pcUMwb2ZDTGdDOE5UN2FRZ1FMWHNo?=
 =?utf-8?B?Z0Y5M3F4VzVmKzhwaVZOQllTOXhKNVRGaHpFNkJYb2w5cHhHZ2pnS2dGa29R?=
 =?utf-8?B?cFBQcnJweWxTVmpNWm5acGlPUEJXK05hU1BDMWpHeEswMVFaRU0xNENlSlln?=
 =?utf-8?Q?8ZjVY2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWs5L3NhQmV1Wkw5VVVWeTEzWkdmOEdoK3ZUa1JBNXJhT0F5ZFBHSDV2QjJu?=
 =?utf-8?B?OXQyZ0pxWUNNWTVjbjVqN01XUU9Lb0hLUXI3b0JpOTRGRi9CWnN3TmdoYS9k?=
 =?utf-8?B?ai9wUGlYK3psdEFleDI2a2RYek1xS3dLcDgwWkNzeFkxUUsxVTV1MlcrOFo0?=
 =?utf-8?B?V05DM0hoOXNQVlhwZkdzcVF0cGZNVGU3aGR4VnF4cnN4MS93cWt1ejR1cWVQ?=
 =?utf-8?B?czJ3Sk1qVWJCTDlPcXJIZnBCZVFFMHJkSm9RdGdkUm52N3dRVHluZUV0aDFn?=
 =?utf-8?B?amdDQ2gyb0pVRnd3ZkRlRDZqY09za0Y5N2x1dEZwZDlQZW9oQm1BVHpvSVNr?=
 =?utf-8?B?TFpJK0duYm5DOURzU24xMXpUUnEycm9YbG1kR2RwMVlxazU0bDZkK0pmTTN0?=
 =?utf-8?B?SlZ0UVFCWFBiRjcwZE1Ta3AreEhTTzJFTTFPd2hCRnIySGZjMjdqaURKNDRn?=
 =?utf-8?B?UVZXRnFaQmNhUUFtYUhvVW1SdkhmeVdsVUhZVHM0N3o5T2g4czc4OUFicmla?=
 =?utf-8?B?ZWNjamFOYUQ2L1orUUo3K1hEOVFqOHZMM1o4RzE0QzBZYTRuQVFVM09ZS2sy?=
 =?utf-8?B?ZzZVZDU2NEVZaVFpQ1NKUXNVOUt6dk1UMkVkT1dyck1ORWVqSjMyRnpRQzVR?=
 =?utf-8?B?bUM5djJySkZyS2JBSVNackszVjIzQzlYR0pJbmpERkpLQkNLUVdOV1ArSG44?=
 =?utf-8?B?R3ZpSnlFUWwvdzI4QWR3NW1zSWVhUkpwQU5TcGsyWWc3eldOSDdlRFEzb1JU?=
 =?utf-8?B?VEtzRXVFcG9WMUd2ZmhjZjRBejA0TG5weGJWbzBwY2NMbVdQV21ldjBpVFFn?=
 =?utf-8?B?Q01jZVBoU2RxZlJjYm1MbWtKWGdOUExlQmJSMkE5dmIydU01VHhjK3ZlMnli?=
 =?utf-8?B?dTRhSzFPK1VvRG9ESVBQUXF1QURITU5mSnJ6RTcxa2xCMUl2eUZ4QTRobENV?=
 =?utf-8?B?Tlg3SkpHa0NRZVg1dHkxKzl6MjhXZ2M4Vm81dk9OeXg4OXV3K0xxNWk3MUJw?=
 =?utf-8?B?OWdYdmpZT2Rzcy9tdlBuWXg4aUhOYkNOUWlsTGJZY2RiRFRVTWlqTitORGln?=
 =?utf-8?B?eEw2TmtVMUY3U21QL0pWaS84Yk5xTnZJUlFMSVp3UmpVY0pybGx4QlNlSWZ0?=
 =?utf-8?B?UVR0a1ZqL1BtM3k2NnhSTXI3K0U5cXRmR2Z5ek1NVDdmTmxyTzRnWlk4WUQv?=
 =?utf-8?B?bFFaODJmVVM3RzAxNFpKcHJ5S1NXa2VIZm5yVzhoaVV6djR2S0QwRDZWZ3d1?=
 =?utf-8?B?MjlnaUEzZGthR3U2VGI4aDBtdDJYZGJBYzFUUEZlb1AzQkVTb21GQlhwcEl4?=
 =?utf-8?B?RGsycng2aXkzckpZUUxpSXRaTUVOUnVNZVVHTGhxSEhDaklLNXpaV1ZVS3RO?=
 =?utf-8?B?VVVXUXBEZzk1eVNoSEtYSVBNQXBqK1ArRTBMSkNnS1EzY0Q3OFRjT0dzaGc2?=
 =?utf-8?B?cklPVlNobXYrWlpqZWJJOTFJTjM2WE5Rblp1Q24rNHhXbzBFQjdwanNJWmIx?=
 =?utf-8?B?Q3VQamRPVitkZ21zRms0emhTQ2dDWE9qdzkvMTk4VW93TURSK0Z6NVFwcElU?=
 =?utf-8?B?VEVyQUdVbXkycmI3QWwwSmVYcHpkNE9md1pEbFZOSmpFcHZaRTFiR1FLOFJX?=
 =?utf-8?B?RldsUGhjQmhBbVlLSndmbUsxK2xoWS9FRjQ1Sjl1RjFIWnN3ZG5jVW9iQ2Ur?=
 =?utf-8?B?Z0RwYjlDeTNpMHB3Q0FSUUFpSW40bFdSSmZobG1iTUh0bFIvYlZFL1NDcTl1?=
 =?utf-8?B?aHRCTWUva1BBMXQ3US9RdVRVVVdML1dhVVkzdXhVZHhwZCs4YXNwYnRPRHNG?=
 =?utf-8?B?SU1lYWFhemFaVUtSc0RERTlEOU9iQTFYS1pqTStGVTFJNk5VUVJZa09iMC9o?=
 =?utf-8?B?aE5lQjBSRmlIYzU4Tm5FQ2tqN0ludVVOalQ2MUIxWk0yRVdrY0wzU3ZLZStw?=
 =?utf-8?B?QlF0SHQzdlg5a3V5dGR0TUVVZ2czQ1ZjOXhFZzZYRW9XeGVROWlQdmRtQ1RW?=
 =?utf-8?B?cjk0czE2U3ozZWFJWHB4UlQvMGZyRERhQllYbE4rYVIxMVdjTVhWTlgvSnpD?=
 =?utf-8?B?bHhvSmhlN0JhSEJvbnpFbWwwcVljVHRKdnc2dHpDSDhrWEFnUmFJeHV1cGVn?=
 =?utf-8?B?YkR2dnFsS3d6Sitzd3dVdDM4MXNTUldsYm84Z1ZOeVg0RC96STBVRGdOZWUx?=
 =?utf-8?Q?uUUOnChXvmSorPBXOMA5fK4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C56AD8DF1EF8241A42CF94173E20E40@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7828643-b5e8-4fb6-1e56-08de270d4266
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 01:45:03.4563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLjOge5kfcsxcUsLYPQE4qGz2Nyl1hTAnDZk+S2TEVEqSgY5d/YKzfM29QNtoRWwZAUo9cJHUDJ4LuVKnntfL6sxfqUyVHK7BSOg/JNS1jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB8067

T24gMTkvMTEvMjAyNSA5OjIwIGFtLCBDb25vciBEb29sZXkgd3JvdGU6DQo+IE9uIFdlZCwgTm92
IDE5LCAyMDI1IGF0IDA3OjM0OjE4QU0gKzA4MDAsIEtoYWlydWwgQW51YXIgUm9tbGkgd3JvdGU6
DQo+PiBBZ2lsZXg1IGludHJvZHVjZXMgY2hhbmdlcyBpbiBob3cgcmVzZXJ2ZWQgbWVtb3J5IGlz
IG1hcHBlZCBhbmQgYWNjZXNzZWQNCj4+IGNvbXBhcmVkIHRvIHByZXZpb3VzIFNvQyBnZW5lcmF0
aW9ucy4gQWdpbGV4NSBjb21wYXRpYmxlIGFsbG93cyBzdHJhdGl4MTAtDQo+PiBGUEdBIG1hbmFn
ZXIgZHJpdmVyIHRvIGhhbmRsZSB0aGVzZSBjaGFuZ2VzLg0KPj4NCj4+IEZhbGxiYWNrIGlzIGFk
ZGVkIGZvciBkcml2ZXIgcHJvYmUgYW5kIGluaXQgdGhhdCByZWx5IG9uIG1hdGNoaW5nIG9mIHRh
YmxlDQo+PiBhbmQgRFQgbm9kZS4NCj4+DQo+PiBSZXZpZXdlZC1ieTogWHUgWWlsdW4gPHlpbHVu
Lnh1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEtoYWlydWwgQW51YXIgUm9tbGkgPGto
YWlydWwuYW51YXIucm9tbGlAYWx0ZXJhLmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2NToN
Cj4+IAktIFJldmVydCB0byBvbmVPZiBhbmQgdXNlIGVudW0gd2l0aG91dCBpdGVtcy4NCj4+IENo
YW5nZXMgaW4gdjQ6DQo+PiAJLSBSZW1vdmUgcmVkdW5kYW50ICJpdGVtcyAtIGVudW0iIGFzIHN1
Z2dlc3RlZCBpbiB2My4NCj4+IAktIFNpbXBsaWZ5IGNvbXBhdGlibGUgcHJvcGVydHkgdG8gdXNl
IGNvbnRhaW5zIGluc3RlYWQgb2Ygb25lT2YuDQo+PiAJLSBWYWxpZGF0ZSBmYWxsYmFjayBhbmQg
bm9uLWZhbGxiYWNrIERULiBBbHNvIHZhbGlkYXRlIGJpbmRpbmcgd2l0aA0KPj4gICAgICAgICAg
ICBkdF9iaW5kaW5nX2NoZWNrLg0KPj4gQ2hhbmdlcyBpbiB2MzoNCj4+IAktIEFkZCBkZXNjcmlw
dGlvbiBmb3IgQWdpbGV4NSBEZXZpY2UNCj4+IAktIEFkZCBhbmQgZGVmaW5lIGZhbGxiYWNrIHRv
ICJpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyIg0KPj4gCS0gVmFsaWRhdGUgYWdhaW5zdCBBZ2ls
ZXggYW5kIFN0cmF0aXgxMCAobm9uLWZhbGxiYWNrKSBhbmQgQWdpbGV4NQ0KPj4gCSAgKGZhbGxi
YWNrKQ0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+IAktIE5vIGNoYW5nZXMgaW4gdGhpcyBwYXRjaA0K
Pj4gLS0tDQo+PiAgIC4uLi9iaW5kaW5ncy9mcGdhL2ludGVsLHN0cmF0aXgxMC1zb2MtZnBnYS1t
Z3IueWFtbCAgICB8IDEwICsrKysrKystLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvaW50ZWwsc3RyYXRpeDEwLXNvYy1mcGdhLW1nci55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvaW50ZWwsc3RyYXRp
eDEwLXNvYy1mcGdhLW1nci55YW1sDQo+PiBpbmRleCA2ZTUzNmQ2YjI4YTkuLjE0NDM3ZGZjNDdh
NCAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdh
L2ludGVsLHN0cmF0aXgxMC1zb2MtZnBnYS1tZ3IueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvaW50ZWwsc3RyYXRpeDEwLXNvYy1mcGdhLW1nci55
YW1sDQo+PiBAQCAtMjAsOSArMjAsMTMgQEAgZGVzY3JpcHRpb246DQo+PiAgIA0KPj4gICBwcm9w
ZXJ0aWVzOg0KPj4gICAgIGNvbXBhdGlibGU6DQo+PiAtICAgIGVudW06DQo+PiAtICAgICAgLSBp
bnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyDQo+PiAtICAgICAgLSBpbnRlbCxhZ2lsZXgtc29j
LWZwZ2EtbWdyDQo+PiArICAgIG9uZU9mOg0KPj4gKyAgICAgIC0gZW51bToNCj4+ICsgICAgICAg
ICAgLSBpbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyDQo+PiArICAgICAgICAgIC0gaW50ZWws
YWdpbGV4LXNvYy1mcGdhLW1ncg0KPiANCj4gR3JlYXQsIHlvdSd2ZSBmaXhlZCB0aGlzIHBhcnQu
DQo+IA0KPj4gKyAgICAgIC0gZW51bToNCj4+ICsgICAgICAgICAgLSBpbnRlbCxhZ2lsZXg1LXNv
Yy1mcGdhLW1ncg0KPj4gKyAgICAgICAgY29uc3Q6IGludGVsLGFnaWxleC1zb2MtZnBnYS1tZ3IN
Cj4gDQo+IEJ1dCB1bmZvcnR1bmF0ZWx5IHRoaXMgaXMgd3JvbmcsIGFuZCB5b3Ugc2hvdWxkIGhh
dmUgbm90aWNlZCBpdA0KPiBiZWNhdXNlIHRoZSBkdHMgcGF0Y2ggeW91IGhhdmUgd2lsbCBwcm9k
dWNlIGEgd2FybmluZy4NCj4gVGhpcyBvbmUgYWN0dWFsbHkgZG9lcyBuZWVkIHRoZSBpdGVtcywg
eW91IGhhZCBpdCByaWdodCBpbiB2My4NCj4gWW91J2xsIG5vdGUgdGhhdCBteSB2MyBmZWVkYmFj
ayBzcGVjaWZpY2FsbHkgc2FpZCAidGhpcyBjb25zdHJ1Y3QiIGFuZA0KPiB3YXMgaW5zZXJ0ZWQg
YXQgdGhlIHBvaW50IG9mIHRoZSByZWR1bmRhbnQgc2luZ2xlIGl0ZW0gaXRlbXMgbGlzdDoNCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUxMTE0LWNvdW50bGVzcy12YW50YWdlLTZl
MTg1MjhkMmUzMUBzcHVkLw0KPiANCj4gcHctYm90OiBjaGFuZ2VzLXJlcXVlc3RlZA0KPiANCj4g
UGxlYXNlIHRha2Ugc29tZSB0aW1lIHRvIGJvdGggdGVzdCBhbmQgdW5kZXJzdGFuZCB0aGUgY2hh
bmdlIHlvdSBhcmUNCj4gbWFraW5nLg0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4NCj4gDQoNClll
YXAsIHRoaXMgaXMgdGhlIHBhcnQgdGhhdCBJIGFtIHNlZWluZyB3YXJuaW5nIGR1cmluZyB0aGUg
dGVzdCBhbmQgSSBhbSANCnRyeWluZyB0byByZXNvbHZlZCBpdCBub3cuDQoNCkkgd2lsbCBnbyB0
aHJvdWdoIG90aGVyIGJpbmRpbmdzIHdpdGggcmcgLS1tdWx0aWxpbmUgdGhhdCB5b3Ugc2hhcmVk
IGFuZCANCndpbGwgc2VuZCBuZXh0IHZlcnNpb24gYWZ0ZXIgYWxsIHRoZSB0ZXN0IGlzIGRvbmUu
DQoNClRoYW5rIFlvdS4NCg0KQmVzdCBSZWdhcmRzLA0KS2hhaXJ1bA0KDQo+PiAgIA0KPj4gICBy
ZXF1aXJlZDoNCj4+ICAgICAtIGNvbXBhdGlibGUNCj4+IC0tIA0KPj4gMi40My43DQo+Pg0KDQo=
