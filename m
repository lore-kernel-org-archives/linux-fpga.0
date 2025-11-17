Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D942641C6;
	Mon, 17 Nov 2025 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348538; cv=fail; b=j9XS/cGq+JhtW69SL/hrYNhl3DPBlC05BNeqF7AuYCkVgdwMe+OVOAkbM/Pmd4rSO579ucJlQk8iIUc+978lLdi993cY3dlq8XJDru0Lpk3egXkupPbTEvvvPTnJ3y5kGF7L2hRSz4ocU9aukP1KHDpbrQnxGb1f21v14pJE+7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348538; c=relaxed/simple;
	bh=i6h8jUZ5ZSQXYHA/YX8wkto2F7/6h1fptoo8KTJ7v5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LaMPzKTWnTyaTSdSW6cqOIJsulBuqhWhkYp0PsLUecy28Nd9W+Lup5WJ85cIu6hMl7KPpOIq75TqNAkXEcKKLrec4aWGKERYr7vuQvW6SWdtvfxvkl8Ft0xXAeGS0LjACHKBRI7qWaS9XQNwk2weibSuwhWgSTQiAERRTJUp2RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=HYeL5Ote; arc=fail smtp.client-ip=40.93.194.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="HYeL5Ote"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIolGfv+idg4V+7PysKaxl/c0dLFUFrXrRiffDMy+be4isRA6fYvVJ8jhLKuIr0hzLTPS8YzAuf3uQCA0lEiWDeVo4Tk0JhB+7M0P2jwb1Sn8tvLL0iwuc0FmplcgwnfLzDoJzrkWgW6QDL1jAWCf97Bv7eMg8Qc0IA7lEJgY5i+ATiapLY442FHxfyfGnx3U6Fsez4lCamAtW446v7UlAbJskbnDN1e/6vwhS2q/7S4nSPgVnMDa3xBqveSLn2VLouILav4f6vp+//cWdf+DGz1Twy2K4y2N+hI+mAF98wLXiOlgtqp82kxxRV+VU8IHvg+wjYj9135BDN7MnsymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6h8jUZ5ZSQXYHA/YX8wkto2F7/6h1fptoo8KTJ7v5s=;
 b=a5tV2g6I+86QOlgzYPwlTgZZZ0uTQhYJntx0d+szw6+zsWH8nYq9AuKNm4ffP32J+5i+xl6lbjl9ywnsYhnkYoJ5vFRmwEaYj2jHU1uLDKe02M9lBTFSZAmg9o1oEyX6TjJiMIl9sLm9o388jBE4fe1xpyDEaTu1FFbkBhUxw2z/kW7/iLvULQ/L1F21iVCXzUVsPcavqD5fIjK61XBU/V94UWisOm/SiGOv9Z5LSeUq+aeCit1x2g9QAh+ZH3nZxh9IIQaAfDJMi4ZSA8Ut3z4tRxL49OKVHEKI8GtRX2ZcC1wSA0NLjWCvfLeSbK3KbO6Un7SGGfsM2P451u372A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6h8jUZ5ZSQXYHA/YX8wkto2F7/6h1fptoo8KTJ7v5s=;
 b=HYeL5OtehL1UYcoCmgHrMMPxzG9Rk+QWZzgftXxP8blZaavUx8714vB1fD5IDxdIXXOJ1B1DgCD4GpDmJhTDiajLqwiZ72ixPvdh64OKLTZQrl6d7FnzX1fMc4GQwCwHnQyD19X6baIfY+Jlo2zPUbdx+HCqBUYOPKC4HoVwZSGQ8dWFHy1UMTnu4ZP4Md5hFO6bcGZkk0gLAWMo52KdSZ542Kr9gUtaOqKqQsc8NqZTQT2i60j40XQEPu9PXsMyRJ3/u/LaYZ52OW4TCS9jhWK3pnMhU2/D6ipFp1MOnNYoHyGGJaWEXS2jkztAhtWvdwRWnziEFEd8YHGuEShMUg==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by MN2PR03MB5359.namprd03.prod.outlook.com (2603:10b6:208:19f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 03:02:12 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 03:02:12 +0000
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
Thread-Index: AQHcVS/PNhj0nHdyyk2ACquwqz/DPbTydniAgAO8SoA=
Date: Mon, 17 Nov 2025 03:02:11 +0000
Message-ID: <56a3a993-9e54-4468-8774-5ed350948ab5@altera.com>
References: <cover.1763100984.git.khairul.anuar.romli@altera.com>
 <c614925ffdc98b1faace3ec9bd7124161b0b60ca.1763100984.git.khairul.anuar.romli@altera.com>
 <20251114-countless-vantage-6e18528d2e31@spud>
In-Reply-To: <20251114-countless-vantage-6e18528d2e31@spud>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|MN2PR03MB5359:EE_
x-ms-office365-filtering-correlation-id: 6299ebc6-d6fd-40e2-d982-08de2585b45d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MCtvMDc3cG9UTmo2dU53UnFNMEZPai9OcUxmUjhKSWVkeXN4QzFyZmdUQ0M3?=
 =?utf-8?B?alBJYVpFS3VCdklyQmNGL09VVFpacWxTR1l1c21pdFUyWWVsYWp6ZlBVUzAw?=
 =?utf-8?B?S1BQcVhHTHREWFUwTzFMcFFxWHRrSDdsQTNtV3ZrMlVRcTAzSURwa1EwSnht?=
 =?utf-8?B?ckJmT0FHaFRrd1plSlpRakZxaC9UV0ZTN3hDSEdOVTVZQnA1Qmk4QzdvNmFQ?=
 =?utf-8?B?TTdJTVlPamZVc2poVGRoVE1qVklLK1c2NUs0T2V2dkVhSUlhM2hyYVd3b05D?=
 =?utf-8?B?b0dMb2pSbVpMajc1Nk1kb3IxZmxCUVh3dlFwMzBveFhiaWpEb1cxWFdxN2pD?=
 =?utf-8?B?a096cFZuRmZSazg1dDJGclo5RzMwcThRaWNnZ2EyWTJETkFCU3hhOTNHSkxF?=
 =?utf-8?B?aW5ZRjlvbGkvVTI2aWhHRE1JUlRQM2xTTktPa2RzZmE0WjV4YTh1dnJnYmNH?=
 =?utf-8?B?aERxc0ZTUHBZM2VKczNjb3hHbzd1Mmh6UjI1SmV3Qmd6L0EzUXhJVExrTWo4?=
 =?utf-8?B?YVJKWXJmTkpuZUdJaTAvZ2NLNnVmeVFWeGgvMmllOWJtL0RHUG91eHdpb04v?=
 =?utf-8?B?c2trOTAxZ2lXVmJXakdBRlVqNG94QXNkUkI3UFJVOFN3USttSkI3eDE4VE5E?=
 =?utf-8?B?MFhvK3kxZmhiUzRlUGNMdE5MbEhUeWZGYUgydEpvM3gvVHJGdXZQcjNMM1VI?=
 =?utf-8?B?RHd0MC9tYTJGbVZHRGUyY2JsUVJuOEhLRGRBWEN1dU9ydkV5UDlhY3hJdURq?=
 =?utf-8?B?MUs3MEZna0hhUm9jakNrY1RCQ08ydEtVVmJqejI2cXlHUnB4UXJQSlZCajl3?=
 =?utf-8?B?VDl6M2o2ajBZZ1d0OGxwVVRYVlpoT2txdGJzWndBS0pidlJaRmFGMlhzbDNG?=
 =?utf-8?B?aXRCNGJpcDlhK1R4KytueTFCOXd2cjRXVzd1b25xVDJBQVN1M0FVcXRiQ1pu?=
 =?utf-8?B?b1RXaStGRlVlVEJlVGZZMDMzTWhiQkZ3U0Z2T3JFNFpkZlI4VnN1UXZjSkJn?=
 =?utf-8?B?dks1ZzN2U05lS2NPUU9Eb3VWOCtGcWRuUG5lYmpLVWVSdGR0L1dOaGtNeElp?=
 =?utf-8?B?UFVTV1F2NFVNMnp4VUZWd3R1RVJWSGVaNnlaSWlGTVVvT0VrOW1CTk5kTWNE?=
 =?utf-8?B?Z0VlQlVhN2xlSFl2aWRvbjJZaXNqaEdRWVY3NDlyQzNnYndzdmhsZ2loZXZL?=
 =?utf-8?B?MUVPZGJPV2t4ZXVKOVlrMjA1aTNzbU5PcUpIUDV4bkpuckJIeFlWWnlTNlFI?=
 =?utf-8?B?VmJvcDhkbDFxbmZuQmFtaTZCaWhQMVkzMnROa0RyUzcvK3dwUXdXNGNHanBx?=
 =?utf-8?B?TG52cWFNQkYxNmtxbERNZ3NDU2p1WFFoMnZBNlZiTHhDS2Y0Ym5hWnZTTmF5?=
 =?utf-8?B?cWNpcGM5M3lwaVA4T0x3bnlyYmlzNkhxa0Y1TzVLRkZrcUgzUGlDWmhSSzFw?=
 =?utf-8?B?cnFZRmNpWnBIWURKY21WVWZ1aWJNZnFuT2xMcmI2L3J2RXRkWE5mcjdGdU5r?=
 =?utf-8?B?M3lGVjFrMmR6N3FPQ00yYzI0aWFweGZhTWZ2dE5naGhDMHZWSm9XU1VVSVBj?=
 =?utf-8?B?N1NNMVNwU3hDa2YvZnlENWRucElJdEc0c3lQOXNMUEJmVjd1cDB6bmU1aWtL?=
 =?utf-8?B?ZjZ4dGIxT2NJT0RNVmRRdGhUSFdJOURkdFVoRVRaZjRkNG9sQ0pCYXlyZGh5?=
 =?utf-8?B?WGtFSkc2cmZHUGZOVkxYanhkRzdyWnhzeXkrc3VNby96UXhJUjdOVG9FNkFk?=
 =?utf-8?B?ZTBOWXdpemt6dXlWc3cyWjNyWWxpTFYxR3lLM1hjTWVLekl1Y001aE9wME5Q?=
 =?utf-8?B?WXY2Tmdvcm5PN1Z1TWFJcThzWExRVjBJTUpIRlhkUmtMZzV1aWtXNHFzNTRW?=
 =?utf-8?B?WDlwb1FzTmc2dUFTVFNHZHpYaFI3djIwYnBSV3lHd0lrdStFWHNqWGZRbVpC?=
 =?utf-8?B?RGFEc1o2UkVGUndCTmhVcEdWRXNGbmovK3hqdkdNcXZJY1hXaitqQ2FZNTRv?=
 =?utf-8?B?OWlUUzVGakFTVzNxZkFpUjJJK0tGcm42TTg1a2p3L0dnQzk1OU1jUklJZk1w?=
 =?utf-8?Q?JR9538?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnE5Z1J3a2hhYkVOQ3JhOHczYlNOaUtEcjg5QklnazRycFo0NW80a3QvcThq?=
 =?utf-8?B?V3ZOeXIxSEJzOUpkbTg2YjI2Q3dNYTVGVTRsd3llVFlZTzZHbU9RVlJPdUtJ?=
 =?utf-8?B?dU9MUHZBWFEzRU4zZGVrL2tqbTB1aXArd08zRE9EbzJYU0l4blVtaFFlK0cv?=
 =?utf-8?B?VHJoRGJRQXVHckNBcVVRaWpwQjlMc0pXNlhMNTBVblhPRTVMc2crbVJHVTF5?=
 =?utf-8?B?bWRFMndtZGJRaU5rQStoUXhqMlMwN2JycWg4dEVMS0F1dktCeGJ5YzVjeTE5?=
 =?utf-8?B?V3dqby81QVdzY0FOYWRtOE12Uk81TTlqVFBFc05KeVNzRUNMSnZrYXNMN0Ro?=
 =?utf-8?B?Ukhqd1VHUnBrR1pTd0xLU21PbkpzTFg1dGJSV3lDdGE0ZlgwcDZ1T3ZTZUVE?=
 =?utf-8?B?bkNaUTRrYzF4bU5yc1dnUmkrS0tGNGxQUVFYRmlzRUZ5d0paa0ZtcC83TzVQ?=
 =?utf-8?B?YmR1MnpKV29HTlhxbEcyMDF1UGhmUEVFWmxPZWtkYW5FUjh0WGFETWpwa0gv?=
 =?utf-8?B?RFFqcUN5ejRiZUxPYWNad2ZVZ1oza2NwU05vd0VaaUYzSTdmcjBIajMrMUZw?=
 =?utf-8?B?b3doKzJ3TkpCQlQvTk0yaDh0VTl3dmxrWkU1MVRsVXQyMjBxZE5BN0swZ0tr?=
 =?utf-8?B?NUlQMmpKMzRnYUVtNmI1alBFaWJ4aDVlYXQ0K2gyKzkrYklobWRBc1FON3Jm?=
 =?utf-8?B?WGRyR0ZBU3E4alY5Sks5ZjJpMDVIZW95ckpPMzEwek1hM1I4T0NKN1BtM3Js?=
 =?utf-8?B?N3FIcjlDeURpY2JuWXFOeWRjWWJMK1JzTTFiRmV4cldiQkF2SFZITU5zWitX?=
 =?utf-8?B?eHliaDF3TmNrY25WOC9UeFhHRy9GTzE0Nkd2eEJmSGw3aW4rek41V2R2OEZt?=
 =?utf-8?B?Y2s0UXhGNWdGOGFyNmc1TUg0bXM3VWlLelY5MEVaZHA3aW9haHR1YmluZzZF?=
 =?utf-8?B?WFdSQUM3SlpxbDJoalpNYVZEa2M5ZkRST1RlYkRaR00wbGpteUFLRThCb3R4?=
 =?utf-8?B?b2NNU1M1eHRnTmZhYWttdlU2TjlMWVlVN21RWndSNHpBRjNLNVVCRXdlMXM2?=
 =?utf-8?B?Rm9lMUVHNzB2NUZBZ3NJTWRYWWtsV3hvcGZKQjV6dnhCc1pOSWZEdjNJcVI3?=
 =?utf-8?B?OU1QUmFaMWNpU3BHUTFBcDlEVUVzeDJrMlF5d2lMQTJFVDRjYU5nVlZGTUVP?=
 =?utf-8?B?SGlhN0FxNDdrVnE1eElaM05ueXMzYzFMcHRHWmZuWWY1UFdCS3ZmcTRSWEw0?=
 =?utf-8?B?Nnlxdm41NFpqc2MyaXd6VktoaGJ6U2pTUzNFWFBwZHlzK0c1QVhhQmhHUTZr?=
 =?utf-8?B?ZThxN0F3OWZpQXpGVnByNDRXcDZRdzNZVk0wMU80eThxL0dNYk5PSUpNZkti?=
 =?utf-8?B?QW9tZ0grK1dSbzFGUzdlQ1JrbVZKQ05BUEV4TVIwMmlORWZpbzhKQzZkK1Iw?=
 =?utf-8?B?c2IrWktTU0ZicTFSZFdXN1ZaWEhmcVVXUUhaTWpYcDd6bDZBY2VOZVoxODFM?=
 =?utf-8?B?Ukk2dFN0WkJGQ1V6bFArblFwOVlhUzlocGRuZU9EVlFUeUhHR1B4bndXbWMz?=
 =?utf-8?B?VUxGU1lYa3B1bWZjdGxuMFdlalJzSGZZTE90VkxZeGNFZHR5Q29tVDhvenor?=
 =?utf-8?B?K2VndTRzaE11Qjk1cndXM3FOS3NETDZ2dGZYeWI1TFN6WllnUVdFeG9WK3pW?=
 =?utf-8?B?ejNxcHN3cTlLeWxQNXYybkg1MDdJMkpTbE5mMzJXZ0JYVm5qWW8xeVdETzdz?=
 =?utf-8?B?ZjFKMUZRdHJESEVDQjl2MFNuU3VTT0lyMFU1WUdwZGlBWmJVOEYrbURHZkV5?=
 =?utf-8?B?RldpcTM4KzVPdUQvWXpXa3FMYXh5eTFaUHJaUW5JY00xOVArTUZuSUVSeGw0?=
 =?utf-8?B?WGNMYy9sNlN6MkVOc3pybFV2QmJjMGhmcXY5Z1dmTFVVWG44cXVaTnpzSVNE?=
 =?utf-8?B?UVdPYVNwZDB5bWlwOWQ1U3pDNVhwNzVybXNnSEhYZGRtbFFEWm03dlk2R0FK?=
 =?utf-8?B?L01nalBwdlVTV1JoZnU4K1l2a2Evc2xqeHpaUG9jdk4zYzJRYnI0eUpnTisw?=
 =?utf-8?B?cHIwMGFENEE1ZlpPa01FN1hKbFM3N3VHcjU4YXNFYmU2Z2hXUlVCL09TZk0y?=
 =?utf-8?B?MExKNXh5S2YveWVjcmE1ZHFmeW03bFEvMzd3ZFVHd0tnSTAveVhqZ0wyRVdF?=
 =?utf-8?Q?cGNSLCffH6VZV0D8xXamqgY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <220D474DFCF41548A412EF6838BE507C@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6299ebc6-d6fd-40e2-d982-08de2585b45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 03:02:12.0091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUQ5qgNSXLRgLDL6vj6piCTqHpMjOeAmvRS60PO61Y8G7hJ3XdBERB6uZVD7PC6KCn4+p2eigI15szp7Dq/TN8XP13PHig4vBT67COlTDZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5359

T24gMTUvMTEvMjAyNSAxOjU5IGFtLCBDb25vciBEb29sZXkgd3JvdGU6DQo+IE9uIEZyaSwgTm92
IDE0LCAyMDI1IGF0IDAyOjI3OjQxUE0gKzA4MDAsIEtoYWlydWwgQW51YXIgUm9tbGkgd3JvdGU6
DQo+PiBBZ2lsZXg1IGludHJvZHVjZXMgY2hhbmdlcyBpbiBob3cgcmVzZXJ2ZWQgbWVtb3J5IGlz
IG1hcHBlZCBhbmQgYWNjZXNzZWQNCj4+IGNvbXBhcmVkIHRvIHByZXZpb3VzIFNvQyBnZW5lcmF0
aW9ucy4gQWdpbGV4NSBjb21wYXRpYmxlIGFsbG93cyBzdHJhdGl4MTAtDQo+PiBGUEdBIG1hbmFn
ZXIgZHJpdmVyIHRvIGhhbmRsZSB0aGVzZSBjaGFuZ2VzLg0KPj4NCj4+IEZhbGxiYWNrIGlzIGFk
ZGVkIGZvciBkcml2ZXIgcHJvYmUgYW5kIGluaXQgdGhhdCByZWx5IG9uIG1hdGNoaW5nIG9mIHRh
YmxlDQo+PiBhbmQgRFQgbm9kZS4NCj4+DQo+PiBSZXZpZXdlZC1ieTogWHUgWWlsdW4gPHlpbHVu
Lnh1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEtoYWlydWwgQW51YXIgUm9tbGkgPGto
YWlydWwuYW51YXIucm9tbGlAYWx0ZXJhLmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2MzoN
Cj4+IAktIEFkZCBkZXNjcmlwdGlvbiBmb3IgQWdpbGV4NSBEZXZpY2UNCj4+IAktIEFkZCBhbmQg
ZGVmaW5lIGZhbGxiYWNrIHRvICJpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyIg0KPj4gCS0gVmFs
aWRhdGUgYWdhaW5zdCBBZ2lsZXggYW5kIFN0cmF0aXgxMCAobm9uLWZhbGxiYWNrKSBhbmQgQWdp
bGV4NQ0KPj4gCSAgKGZhbGxiYWNrKQ0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+IAktIE5vIGNoYW5n
ZXMgaW4gdGhpcyBwYXRjaA0KPj4gLS0tDQo+PiAgIC4uLi9mcGdhL2ludGVsLHN0cmF0aXgxMC1z
b2MtZnBnYS1tZ3IueWFtbCAgICAgICAgIHwgMTQgKysrKysrKysrKystLS0NCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ludGVsLHN0cmF0
aXgxMC1zb2MtZnBnYS1tZ3IueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9mcGdhL2ludGVsLHN0cmF0aXgxMC1zb2MtZnBnYS1tZ3IueWFtbA0KPj4gaW5kZXggNmU1MzZk
NmIyOGE5Li44ZWI0MTQxNjNkMDggMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZnBnYS9pbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyLnlhbWwNCj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ludGVsLHN0cmF0
aXgxMC1zb2MtZnBnYS1tZ3IueWFtbA0KPj4gQEAgLTIwLDkgKzIwLDE3IEBAIGRlc2NyaXB0aW9u
Og0KPj4gICANCj4+ICAgcHJvcGVydGllczoNCj4+ICAgICBjb21wYXRpYmxlOg0KPj4gLSAgICBl
bnVtOg0KPj4gLSAgICAgIC0gaW50ZWwsc3RyYXRpeDEwLXNvYy1mcGdhLW1ncg0KPj4gLSAgICAg
IC0gaW50ZWwsYWdpbGV4LXNvYy1mcGdhLW1ncg0KPj4gKyAgICBvbmVPZjoNCj4+ICsgICAgICAt
IGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGVudW06DQo+IA0KPiBUaGlzIGNvbnN0cnVjdCBpcyBy
ZWR1bmRhbnQsICJpdGVtczogLSBlbnVtIiBpcyB0aGUgc2FtZSBhcyBqdXN0IGhhdmluZw0KPiAi
ZW51bSIuDQo+IHB3LWJvdDogY2hhbmdlcy1yZXF1ZXN0ZWQNCj4gDQpJJ3ZlIHRyaWVkIHRvIGxv
b2sgZm9yIHNvbWUgb2YgdGhlIGFscmVhZHkgbWVyZ2VkIGJpbmRpbmdzIGkuZSANCmFybS9xY29t
LnlhbWwgKGFsdGhvdWdoIGFsbCB0aGUgcHJvcGVydGllcyBoYXMgZW51bSAtIGNvbnN0YW50IA0K
Y29tYmluYXRpb24pLCBpdCBpcyB1c2luZyBpdGVtcyB3aXRoIGVudW0uIEkgdHJpZWQgdG8ga2Vl
cCB0aGUgZW51bSB3aXRob3V0DQppdGVtcyBidXQgSSBrZWVwIGdldHRpbmcgZXJyb3Igd2hpbGUg
dmFsaWRhdGluZyB0aGUgY2hhbmdlcy4NCg0KQW5vdGhlciBvcHRpb24gdGhhdCBJJ3ZlIHZhbGlk
YXRlZCBpcyB1c2luZyB0aGUgZm9sbG93aW5nIGNoYW5nZXMuDQoNCi0gICAgZW51bToNCi0gICAg
ICAtIGludGVsLHN0cmF0aXgxMC1zb2MtZnBnYS1tZ3INCi0gICAgICAtIGludGVsLGFnaWxleC1z
b2MtZnBnYS1tZ3INCisgICAgb25lT2Y6DQorICAgICAgLSBkZXNjcmlwdGlvbjogSW50ZWwgU3Ry
YXRpeDEwIERldmljZXMNCisgICAgICAgIGl0ZW1zOg0KKyAgICAgICAgICAtIGNvbnN0OiBpbnRl
bCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyDQorICAgICAgLSBkZXNjcmlwdGlvbjogSW50ZWwgQWdp
bGV4IERldmljZXMNCisgICAgICAgIGl0ZW1zOg0KKyAgICAgICAgICAtIGNvbnN0OiBpbnRlbCxh
Z2lsZXgtc29jLWZwZ2EtbWdyDQorICAgICAgLSBkZXNjcmlwdGlvbjogSW50ZWwgQWdpbGV4NSBE
ZXZpY2VzDQorICAgICAgICBpdGVtczoNCisgICAgICAgICAgLSBjb25zdDogaW50ZWwsYWdpbGV4
NS1zb2MtZnBnYS1tZ3INCisgICAgICAgICAgLSBjb25zdDogaW50ZWwsYWdpbGV4LXNvYy1mcGdh
LW1ncg0KDQpUaGUgZHJhd2JhY2sgb2YgdGhpcyBpcyB3ZSB3aWxsIG5lZWQgdG8gaW1wbGVtZW50
IGVudW0gaW5zdGVhZCBvZiANCmNvbnN0YW50IGZvciBmaXJzdCBlbGVtZW50IGlmIHdlIG5lZWQg
dG8gYWRkIG5ldyBkZXZpY2VzIHVuZGVyICJJbnRlbCANCkFnaWxleDUgRGV2aWNlcyIgaW4gdGhl
IGZ1dHVyZS4NCg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQpLaGFpcnVsDQoNCj4+ICsgICAg
ICAgICAgICAgIC0gaW50ZWwsc3RyYXRpeDEwLXNvYy1mcGdhLW1ncg0KPj4gKyAgICAgICAgICAg
ICAgLSBpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyDQo+PiArDQo+PiArICAgICAgLSBkZXNjcmlw
dGlvbjogQWdpbGV4NSBEZXZpY2UNCj4+ICsgICAgICAgIGl0ZW1zOg0KPj4gKyAgICAgICAgICAt
IGVudW06DQo+PiArICAgICAgICAgICAgICAtIGludGVsLGFnaWxleDUtc29jLWZwZ2EtbWdyDQo+
PiArICAgICAgICAgIC0gY29uc3Q6IGludGVsLGFnaWxleC1zb2MtZnBnYS1tZ3INCj4+ICAgDQo+
PiAgIHJlcXVpcmVkOg0KPj4gICAgIC0gY29tcGF0aWJsZQ0KPj4gLS0gDQo+PiAyLjQzLjcNCj4+
DQoNCg==
