Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA12FC876;
	Tue, 18 Nov 2025 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427079; cv=fail; b=aMKDaiX/jwhXFtoqUURW/UCA7Z3kD7wVN5QY1D+SDqtSkJGfVPM4Nf4lzv3ulSFJViiIDDeDN8icxiT5icCqTph3PnnrvHUhGlGljFBCoEU6Dki380j0K0qhpaNjSr5YV7LOeoQUk5AQqLQIRQVpBlJZlOwVVe3eTOPsjuwvKzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427079; c=relaxed/simple;
	bh=VXPA6LcEbyRQ6/j1gkCJ8rU9m8oN4rhf5RLdHIk91pE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bzsyqgdnRP/po0Re4j5+tq89dIFoOdGupGFhVQKqv/cQl5+hKxPNLw2hFsdUcdqbt2M4Ko582vveX8bFm+R/k4rGfrCkxEpUFywQm5Z4VGvjRumGqCiPv1Y+KLznSYkogD6Z+2+hu3LrJ8fD6LPg/FgzrBkVphQrpdCmOUzSWTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=KYSMS9Gd; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="KYSMS9Gd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHi0Y4cw8f04yoYmBqa9rBqaqvT8xDexvHGm3p73KEyoWsJQzowCz+x4VQmL5ZP3omg8/HwG1Adgv/F6JaxamGgl0btTVVdxssz2wOssIyHQAOMthq57j/SDcAIMq87rdrcP7Q9Ly59z/a7u61NHfRnPd32z+5oMppnDJoiTaTlY70yJAAN0M0ZFlasSNOQkG/okRViSQ4EbpiTWSXyyuUe6QGH8Vn2X3dbaWwsSi7jPkUnq+VVqX54O8dGaZ8X4OdekDTrkXZBXD+FGLbJOHr6gaAU+HcHRybDbWge2QUtPf7w2QngJmEH+Ta4fgKbfitedraKyBZ823HDkg6HdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXPA6LcEbyRQ6/j1gkCJ8rU9m8oN4rhf5RLdHIk91pE=;
 b=BjbTInaN0yo+nqQoXNQRQ0LWeGw4u1/aoi4VdT6Z12btEAz5oO6G3lXd5qva7fSVeL16/6k7xFHq2DeIk30DoCwalC8f46dEC/+iGf9unriIP+LwsIzlXqrlA80G4WThVgOSfnd+uvpao91YPCa1yRFOnyUA+srsjtKeKwS9Rv7cS/IWM8+CuYdQercrmqkSEA+iHuz7K12xY/eRHweou4lUxQWU/2ipTcN3Cx68L7CKUxcVCBM+Up3UmPcp9hk8DnVUosiQDUTgKZwZpQV0R4hisRi2gsyVZLFoJf8sm73rxhasC751ejn216a6AMdIsoaHdyaL7jAycUSQGoO8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXPA6LcEbyRQ6/j1gkCJ8rU9m8oN4rhf5RLdHIk91pE=;
 b=KYSMS9Gd6PyRhBoaao8vTzR5eB4IR/4BQpZSoHHnIH5ZZLy2M6Mn3jqKW/BiPI7jSuYKJXk+JxcCqwrJp/mMRT71NSr9vuvORgifvXungWMaGxLZaB5FffcmLAVtpYXK79+dqgwThwoKiKy9gICcU4RmV9K9aFThhqrs4ZxeZNCe80YGYIUiPeWcqXz0CPHoG0tFF7IiBqRwSuRuXA8vCwBadylNDg3SfSBwHDx4Fi96Sx5/90Wvgj08LBHmpZR5xJUFrUC6v34/XJ2o+o/xjAY1I8G0Yc7d6PhUpzrF6WZ1q7BAyS6fRzpFNimmRC7kvar5SjDAGotDNvahaTHXWQ==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by BN9PR03MB6201.namprd03.prod.outlook.com (2603:10b6:408:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 00:51:13 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 00:51:13 +0000
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
Thread-Index:
 AQHcVS/PNhj0nHdyyk2ACquwqz/DPbTydniAgAO8SoCAAMDPAIAAAIMAgACgVYCAAAwXgA==
Date: Tue, 18 Nov 2025 00:51:13 +0000
Message-ID: <02d6576b-f17a-41dd-ac71-c128bc1a4739@altera.com>
References: <cover.1763100984.git.khairul.anuar.romli@altera.com>
 <c614925ffdc98b1faace3ec9bd7124161b0b60ca.1763100984.git.khairul.anuar.romli@altera.com>
 <20251114-countless-vantage-6e18528d2e31@spud>
 <56a3a993-9e54-4468-8774-5ed350948ab5@altera.com>
 <20251117-imprison-upstream-5c80b3a55169@spud>
 <20251117-empty-skipping-a2c0c9aec1c7@spud>
 <d627de4c-1d9d-4348-b54f-55d1bd1f2c31@altera.com>
In-Reply-To: <d627de4c-1d9d-4348-b54f-55d1bd1f2c31@altera.com>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|BN9PR03MB6201:EE_
x-ms-office365-filtering-correlation-id: 3e5a4343-b8b4-48d5-107e-08de263c92a8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3R0dm1XVGl0M1d0YTgvY2JwOHI0Y25iZFVsZXNnSkl2ci9IT3BjSjFUYjhy?=
 =?utf-8?B?L284bGhNUkFVZG5vdTB1cjAxZFBRc0VZN0EycWs4Z0l4a0VoK3pYME1wRlBa?=
 =?utf-8?B?UVpHR21XdFl0YWN2MlVvQ25IWWptUndyMVFkcGtnQmQxMnA2V3h3MjVPM0RE?=
 =?utf-8?B?Ymg4OFZ2Q2x2MDJKNlRlZ1dKNE9wYVYxUXkzUW9LNDg5UWNzYlNCWi95MXl5?=
 =?utf-8?B?TEhzTlkyZFZJTFVaRnExM1NvYnRlR1puSkZxejk2RmNBN3ZEaVRzcVpaTVR3?=
 =?utf-8?B?Q3BCL0JtRldMTFQ3a01EN0tsQ2ZNSEZqTHFEamgwUytKbjU3ODBJWm41RFE4?=
 =?utf-8?B?cUcwbkE2dFVnZmc4NWo4Y1ZRdzNqZWZvekwvL2lSSzV1QlBSa09pQXBHOU9I?=
 =?utf-8?B?U1krL1d5MGdxRlgyczl5N0RnQzNuVlltRFExQVpacWw2VGRiWE5aSVBNNDlu?=
 =?utf-8?B?dnl4REhnWXFQLzlxSUoxT1hlL0xLZHZoZlFreVZuUVhGYVRBSHV3YlhUQWFM?=
 =?utf-8?B?VWN5VnRUUGhwNkJrZ1F4OFN6dTNjekpoajVVcENKVzNQdTd2Sk5TQUJmWnpz?=
 =?utf-8?B?b0JWNmJxWU9kODZ2M0NKSlRZWjJ3eFJaM3VyNlhVdzgzdVpWREVpNjZqVmJB?=
 =?utf-8?B?OW9tbFBDby9MZHgxM1I0bE91N0Erd09TMUlrTVI5TXB5dVg1RXY4bi9xRE16?=
 =?utf-8?B?QmF4QXRNZFVwdHpRbitSbW5iR3RPUmF3NEF4UzZVUU9nV2YrS1VmaUk1dkpK?=
 =?utf-8?B?bGdsaTQxaTVZVVptd0sva3g3ZmFCdFJoU2pKU0k3VVEwMTdST3BSYmIzS2FZ?=
 =?utf-8?B?dkRCdW5VRG4zWTgxOEFaMWFFYWxrRHR3WjlZQjlCdkIyYjlRcElOc3R3VlZY?=
 =?utf-8?B?QlptWUU3cTRnL0hqdFdqbkgwNVRQYkNpbDNUUDdsM1Z1V21ia1JIN2JHZXlK?=
 =?utf-8?B?RHpjRXNBODZPaUhveXFUdlp1bEJ1dmdvV1E5TzZiN1VUZGZhYkxlREdxRWgv?=
 =?utf-8?B?THNlZTQ3dE5HZHQ2RzNka1VuSEkzdmNwZlNRam9xRFAySEIwTExjNFk3NUYy?=
 =?utf-8?B?bHpVZm8yZG5CN0E0RU1xVXhqbUZ4SEg0eHVHMzRuS3lzVlgvU2xCZWxid3RQ?=
 =?utf-8?B?TXBuWUtMa1UyQmVnN0N5N01hcGdMdFQwQ2kzbTJEdGxIaDBEbHVYRnRpSkV4?=
 =?utf-8?B?UlRGMW0zeGlXRHlOVlo5YUR1NVh1YVlRVmxUY2NPeTdoOXhJY25xTmtXQ2VF?=
 =?utf-8?B?dlAwaGV0WStiVk1LSGt6YlFPc0VEbWV3NzhVU0luZCtEblJ5dzBXbTk1OENk?=
 =?utf-8?B?U0pLVkFqekJBVU9Hai9hY2lrdlNCRFVXM1BSQWI0QW16NC9UVUhLMUpiUDlY?=
 =?utf-8?B?Q1hCa2ZEV1U3bmhNR1pmaGFLZ2ZmMzRxSytFYlp1RjlZUzRkNkhqeGVZeDBv?=
 =?utf-8?B?WFpZaWdMck4zSUhGbkp4QmxvNndmckpwaGFWQWJiWDdxbnV0RlF3dFhpZUVP?=
 =?utf-8?B?WG5HRjVwbEV1UHp0YWRVckVXeUtWOEhRSlR6ZnNNRHA5aW84UkxQWFlMZVJ4?=
 =?utf-8?B?K0FHUCtMTWtTa3p4SjUrcEdNVE1VUUd5a2dFK09NanRTSUVuZUQ4TE9NbWtk?=
 =?utf-8?B?WURWSkEzZnRadHdUQURvZlA1OW43U0FXeHp5K0ZHaDhMSkcrMU5neDJjVVB1?=
 =?utf-8?B?dy81cU1BQVlaa2ZBS3E2U21hMVdrdGJzSlhLMGdaL0xJSUFQb0FuODhQOE5U?=
 =?utf-8?B?SXlZTDVHYThhTlYzbzZGcHNhQzBIVnNMaFlxZS9OVmt0cTZsNDlDVmFvdXVE?=
 =?utf-8?B?TGlUMlNoS1hzaXdUZ1pvYzZ5bTlFZGwvK292WlJ6cklyd29GcURQdGJGcFcw?=
 =?utf-8?B?YmdBbWJ2M3h1R1RKcWpwRkR6Q2JkeisxMHhIVkl6d0ZjNWZkVnhmeW1iT3B4?=
 =?utf-8?B?Q1VQK2ZiaWRiQnhOajh5UTlabk1vSWR0bHF3UlNsOEIyQ2YyUEsxdXNqcSs5?=
 =?utf-8?B?TVJwTWw4YzlsY1A2d3NVVStkMVRDV2lhNkh1MENhZVg4TTl4OStPTjNxcFNy?=
 =?utf-8?Q?oF2Wg4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUVNWHFBUzhaa1dCUGV0Wk0vZzJKREsrU3dmRk4yWjAwdlFBb2cwV3E5V3Ar?=
 =?utf-8?B?Rk10Q0hVQVZQdlhHdFBLWjQ3MTAvOEVUL0N4THk0Rjkxa1psTFF1TzF6U3dM?=
 =?utf-8?B?TnozZEdWeElnZlFvZyt5dEQwdHlxSXB0RW95a0UvU2RZVERBbmNaZ01uRVdS?=
 =?utf-8?B?eWtzdmQvS3FCb0p5cU9xNmlKTVpqVlVYR2hDVGlRMUlEZkFkQkVKd3BjdHZP?=
 =?utf-8?B?OTg2MUp1RG9xTGdSRkNkSW9hVTVUZ1k4NEcwdEwzZWEwOUwvRXpHcmRhcENS?=
 =?utf-8?B?NytsVGJBK0d3a09HakZLWnhGVkowWVU3SS94TURnNHhJMGkzc2xIQzZRdWxU?=
 =?utf-8?B?V0ZLdnhyTDh1cDdkY2Y4ZXhpbzNVbjI0NXR4dmhpSGd0Vjh4bUErbGNJVWpX?=
 =?utf-8?B?N2l5RldGd09STkJXWnpCcTYzdFVhUTFxVmhYZ1NjRG5OMFFkTEFteVBjNzZJ?=
 =?utf-8?B?Q3h6R3g1K0tvSlBmOHZORmZEZDNORTF0UnFZdHpJSUs5MlRKdklVbUlqSDVa?=
 =?utf-8?B?allUaW1ZZmRwM2Rld0hVVVYxMlNxTUpaZGxlUGJ3YW9QWENDaXV5RDVraWlk?=
 =?utf-8?B?K2lNYnEwYkhDWjl2THI0ZUtLRFlBTThyS3d6K1crRkJ6a1ZSRGI3eXlrY01S?=
 =?utf-8?B?ZHJBUzJMK3phUDg3L3ZIa2xsMlB5amtKb2hKZHc3Zlg1YzBqei9VTzRIckhs?=
 =?utf-8?B?ZTBobkF6Y25lOVEvdDZBejJrV2w5RDVXZWpDZ2tLc0tNTmhVdGZWZTUvclo0?=
 =?utf-8?B?OU0wTjhDVmswR1ZoQklzWmZJTDRJL0trclJGSURsN0RTV2JWOXNqUlJHS1FZ?=
 =?utf-8?B?TGdsUXlBSEF2dWRIM2hQYmhGSmVUOW5Ub0EvSGdPZjJsYW9KZk5jbUgwZHJ4?=
 =?utf-8?B?bURJRi9ETGEvK1IzLzJRSnNqWVN2ZHNiaFJocEhscmI3UEU5RnhUT3RZMnlR?=
 =?utf-8?B?YS83RWU3VHVYTVVoNmhJSjg3cDVVZHRqdE5YK3M3OWFxbk1OUU81aXR0T2c4?=
 =?utf-8?B?ZFQwOE5aZi9yRFZQSW5vTWMxS1dqRzF2U1ZTNXNSM2VHa1Z3VWxJMEhobmNw?=
 =?utf-8?B?N0NpNm1UNXNacjhmVG9iVkhLWitJSW1qZU1OUmJpRnR4MldZT3F2d2MvUGRJ?=
 =?utf-8?B?NkZYUGdIMGU1QTJza2lqdGJoT29wZ1haNmkzT3ZoazlnRW5RazJYYWozbHVv?=
 =?utf-8?B?cDJqaGVTRExPLzd4OGMxRXFUUHBIQ25OOXVuRGFaTUU0ZUZTN0NMS2ZTZ1NF?=
 =?utf-8?B?ZHhRZ2hPR0JtM3AzbGUwV3VJL0ZEQmd1SEFnWFBieU9maVBKcmY3UndneFFn?=
 =?utf-8?B?WDJ2dFYwcEtjTm5XalNwM0NqR2xkODBqSUFCaENaUEQza1VWdk4zcUdsU2dl?=
 =?utf-8?B?SGFsaWcwSWJLcTdOaExqaHJUUUFhZzV4MFBwallaUm9pNW9JNlRmRWhwaWxZ?=
 =?utf-8?B?NVBlbEZ5b0FtRjRVVVZCYWg1UzJROHZEYXRKcGZSVyt3WnJvMExFOXNEbnpx?=
 =?utf-8?B?Z0QzN1o2T3psRDZwMEtNZEdSZ2NiV05waUV6dzlpemRCMEk0MTdBZTJRaXlT?=
 =?utf-8?B?aVZxQ00wZlhKaE9mcCtpb2V5dHp3MXNqUE4zNGZEclE0NjBiOFlmUElQYzln?=
 =?utf-8?B?RE5KZzlaZ3hwTFo4ZDFtMXlBTnZwT1djb250NUhUajNoN1NhbkdXOFEwN0px?=
 =?utf-8?B?dmxGb2YvK2ZtZlR5WnhYYnhON3ZselVhRFU1VXBheXdqaGsxUS94SkM2V24w?=
 =?utf-8?B?UWdqZE1nQ3lCZnpWblJYd2tScnJJUHptcnJ6TVpSMWFsdFRrc3FzNnVvR1ls?=
 =?utf-8?B?djBwWXV5a2NrS05JK2xpbHRLWExVYy9uWXNqcEhCbVU2S05XVG5TbGMyeS9a?=
 =?utf-8?B?bEtxbWtrNm9lZ3pTVHRrWVc3ZUdLb1YyTmgra0ZFNGZmMEU2YStMRDYrdnIz?=
 =?utf-8?B?Z2U3YUQ5OTZqbWZaakxqNVZMSm9oL2dQZTE1ckx4NjJSVnA3TWtldDFNMHho?=
 =?utf-8?B?TFowSzFsdTVjMkRBUE9rNFdtN2FzbTNoUmxpYUdvZjZoSTlUSnR0eWRQQmpW?=
 =?utf-8?B?SEV5dlVFcVRVRTk1OHNyZlZaNkVnYzdwU0NOZFZKYkJnLzJ0L2Qydm1YcUY5?=
 =?utf-8?B?VVAwQXYxT3lzT2hzUXJsZHcrdXJheVVncVozMmpnQXBHM3NxNEppZDQ2UC9i?=
 =?utf-8?Q?kVhpANzlb4Y1OyRM1wFxrz8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CC48A91E5847B42BC3C55CC977814AA@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5a4343-b8b4-48d5-107e-08de263c92a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 00:51:13.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfIzcfLeIUAw87JP3uuvi3Iib+JSdIMcXwoXGyjpVp5EzgGay/BLl+IzL36siTjGEQ41FsxPGUqQONUuEuuK72Cv2+2v5eCJH9sQABbPyWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6201

T24gMTgvMTEvMjAyNSA4OjA3IGFtLCBDb25vciBEb29sZXkgd3JvdGU6DQo+IE9uIDE3LzExLzIw
MjUgMTA6MzQgcG0sIENvbm9yIERvb2xleSB3cm90ZToNCj4+IE9uIE1vbiwgTm92IDE3LCAyMDI1
IGF0IDAyOjMyOjE2UE0gKzAwMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+PiBPbiBNb24sIE5v
diAxNywgMjAyNSBhdCAwMzowMjoxMUFNICswMDAwLCBSb21saSwgS2hhaXJ1bCBBbnVhciB3cm90
ZToNCj4+Pj4gT24gMTUvMTEvMjAyNSAxOjU5IGFtLCBDb25vciBEb29sZXkgd3JvdGU6DQo+Pj4+
PiBPbiBGcmksIE5vdiAxNCwgMjAyNSBhdCAwMjoyNzo0MVBNICswODAwLCBLaGFpcnVsIEFudWFy
IFJvbWxpIHdyb3RlOg0KPj4+Pj4+IEFnaWxleDUgaW50cm9kdWNlcyBjaGFuZ2VzIGluIGhvdyBy
ZXNlcnZlZCBtZW1vcnkgaXMgbWFwcGVkIGFuZCANCj4+Pj4+PiBhY2Nlc3NlZA0KPj4+Pj4+IGNv
bXBhcmVkIHRvIHByZXZpb3VzIFNvQyBnZW5lcmF0aW9ucy4gQWdpbGV4NSBjb21wYXRpYmxlIGFs
bG93cyANCj4+Pj4+PiBzdHJhdGl4MTAtDQo+Pj4+Pj4gRlBHQSBtYW5hZ2VyIGRyaXZlciB0byBo
YW5kbGUgdGhlc2UgY2hhbmdlcy4NCj4+Pj4+Pg0KPj4+Pj4+IEZhbGxiYWNrIGlzIGFkZGVkIGZv
ciBkcml2ZXIgcHJvYmUgYW5kIGluaXQgdGhhdCByZWx5IG9uIG1hdGNoaW5nIA0KPj4+Pj4+IG9m
IHRhYmxlDQo+Pj4+Pj4gYW5kIERUIG5vZGUuDQo+Pj4+Pj4NCj4+Pj4+PiBSZXZpZXdlZC1ieTog
WHUgWWlsdW4gPHlpbHVuLnh1QGludGVsLmNvbT4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBLaGFp
cnVsIEFudWFyIFJvbWxpIDxraGFpcnVsLmFudWFyLnJvbWxpQGFsdGVyYS5jb20+DQo+Pj4+Pj4g
LS0tDQo+Pj4+Pj4gQ2hhbmdlcyBpbiB2MzoNCj4+Pj4+PiDCoMKgwqDCoC0gQWRkIGRlc2NyaXB0
aW9uIGZvciBBZ2lsZXg1IERldmljZQ0KPj4+Pj4+IMKgwqDCoMKgLSBBZGQgYW5kIGRlZmluZSBm
YWxsYmFjayB0byAiaW50ZWwsYWdpbGV4LXNvYy1mcGdhLW1nciINCj4+Pj4+PiDCoMKgwqDCoC0g
VmFsaWRhdGUgYWdhaW5zdCBBZ2lsZXggYW5kIFN0cmF0aXgxMCAobm9uLWZhbGxiYWNrKSBhbmQg
DQo+Pj4+Pj4gQWdpbGV4NQ0KPj4+Pj4+IMKgwqDCoMKgwqAgKGZhbGxiYWNrKQ0KPj4+Pj4+IENo
YW5nZXMgaW4gdjI6DQo+Pj4+Pj4gwqDCoMKgwqAtIE5vIGNoYW5nZXMgaW4gdGhpcyBwYXRjaA0K
Pj4+Pj4+IC0tLQ0KPj4+Pj4+IMKgwqAgLi4uL2ZwZ2EvaW50ZWwsc3RyYXRpeDEwLXNvYy1mcGdh
LW1nci55YW1swqDCoMKgwqDCoMKgwqDCoCB8IDE0ICsrKysrKysgDQo+Pj4+Pj4gKysrKy0tLQ0K
Pj4+Pj4+IMKgwqAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2ZwZ2EvIA0KPj4+Pj4+IGludGVsLHN0cmF0aXgxMC1zb2MtZnBnYS1tZ3IueWFt
bCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS8gDQo+Pj4+Pj4gYmluZGluZ3MvZnBnYS9pbnRl
bCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyLnlhbWwNCj4+Pj4+PiBpbmRleCA2ZTUzNmQ2YjI4YTku
LjhlYjQxNDE2M2QwOCAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZnBnYS9pbnRlbCxzdHJhdGl4MTAtc29jLSANCj4+Pj4+PiBmcGdhLW1nci55
YW1sDQo+Pj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2Ev
aW50ZWwsc3RyYXRpeDEwLXNvYy0gDQo+Pj4+Pj4gZnBnYS1tZ3IueWFtbA0KPj4+Pj4+IEBAIC0y
MCw5ICsyMCwxNyBAQCBkZXNjcmlwdGlvbjoNCj4+Pj4+PiDCoMKgIHByb3BlcnRpZXM6DQo+Pj4+
Pj4gwqDCoMKgwqAgY29tcGF0aWJsZToNCj4+Pj4+PiAtwqDCoMKgIGVudW06DQo+Pj4+Pj4gLcKg
wqDCoMKgwqAgLSBpbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyDQo+Pj4+Pj4gLcKgwqDCoMKg
wqAgLSBpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyDQo+Pj4+Pj4gK8KgwqDCoCBvbmVPZjoNCj4+
Pj4+PiArwqDCoMKgwqDCoCAtIGl0ZW1zOg0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqAgLSBl
bnVtOg0KPj4+Pj4NCj4+Pj4+IFRoaXMgY29uc3RydWN0IGlzIHJlZHVuZGFudCwgIml0ZW1zOiAt
IGVudW0iIGlzIHRoZSBzYW1lIGFzIGp1c3QgDQo+Pj4+PiBoYXZpbmcNCj4+Pj4+ICJlbnVtIi4N
Cj4+Pj4+IHB3LWJvdDogY2hhbmdlcy1yZXF1ZXN0ZWQNCj4+Pj4+DQo+Pj4+IEkndmUgdHJpZWQg
dG8gbG9vayBmb3Igc29tZSBvZiB0aGUgYWxyZWFkeSBtZXJnZWQgYmluZGluZ3MgaS5lDQo+Pj4+
IGFybS9xY29tLnlhbWwgKGFsdGhvdWdoIGFsbCB0aGUgcHJvcGVydGllcyBoYXMgZW51bSAtIGNv
bnN0YW50DQo+Pj4+IGNvbWJpbmF0aW9uKSwgaXQgaXMgdXNpbmcgaXRlbXMgd2l0aCBlbnVtLiBJ
IHRyaWVkIHRvIGtlZXAgdGhlIGVudW0gDQo+Pj4+IHdpdGhvdXQNCj4+Pj4gaXRlbXMgYnV0IEkg
a2VlcCBnZXR0aW5nIGVycm9yIHdoaWxlIHZhbGlkYXRpbmcgdGhlIGNoYW5nZXMuDQo+Pj4NCj4+
PiBJIGxpdGVyYWxseSB0b2xkIHlvdSB3aGF0IHRvIGNoYW5nZSwgc28gSSBkb24ndCBrbm93IHdo
eSB5b3UgZGlkbid0IGp1c3QNCj4+PiBkbyB0aGF0LiBSZXBsYWNpbmcgIml0ZW1zOiAtIGVudW0i
IHdpdGggImVudW0iIGlzIHdoYXQgeW91IG5lZWQgdG8gZG8uDQo+Pj4gWW91IGRpZG4ndCBldmVu
IGluY2x1ZGUgdGhlIGVycm9yIHlvdSBnb3QsIHNvIEkgY2Fubm90IGhlbHAgeW91IHdpdGgNCj4+
PiB0aGF0IGF0IGFsbCwgbm9yIGV2ZW4gaWYgeW91IGRpZCB3aGF0IEkgdG9sZCB5b3UgdG8gZG8u
DQo+Pg0KPj4gbm9yIGV2ZW4ga25vdyBpZiB5b3UgZGlkKg0KPj4NCj4gDQo+ICDCoHByb3BlcnRp
ZXM6DQo+ICDCoMKgIGNvbXBhdGlibGU6DQo+IC3CoMKgwqAgZW51bToNCj4gLcKgwqDCoMKgwqAg
LSBpbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyDQo+IC3CoMKgwqDCoMKgIC0gaW50ZWwsYWdp
bGV4LXNvYy1mcGdhLW1ncg0KPiArwqDCoMKgIG9uZU9mOg0KPiArwqDCoMKgwqDCoCAtIGVudW06
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqAgLSBpbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyDQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqAgLSBpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyDQo+ICvCoMKg
wqDCoMKgIC0gZW51bToNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoCAtIGludGVsLGFnaWxleDUtc29j
LWZwZ2EtbWdyDQo+ICvCoMKgwqDCoMKgwqDCoCBjb25zdDogaW50ZWwsYWdpbGV4LXNvYy1mcGdh
LW1ncg0KPiANCj4gJCBtYWtlIC1qMjQgQ0hFQ0tfRFRCUz15IGludGVsL3NvY2ZwZ2FfYWdpbGV4
NV9zb2Nkay5kdGINCj4gDQo+IC9saW51eC1zb2NmcGdhL2FyY2gvYXJtNjQvYm9vdC9kdHMvaW50
ZWwvc29jZnBnYV9hZ2lsZXg1X3NvY2RrLmR0YjogDQo+IGZwZ2EtbWdyIChpbnRlbCxhZ2lsZXg1
LXNvYy1mcGdhLW1ncik6IGNvbXBhdGlibGU6ICdvbmVPZicgY29uZGl0aW9uYWwgDQo+IGZhaWxl
ZCwgb25lIG11c3QgYmUgZml4ZWQ6DQo+ICDCoMKgwqDCoFsnaW50ZWwsYWdpbGV4NS1zb2MtZnBn
YS1tZ3InLCAnaW50ZWwsYWdpbGV4LXNvYy1mcGdhLW1nciddIGlzIHRvbyANCj4gbG9uZw0KPiAg
wqDCoMKgwqAnaW50ZWwsYWdpbGV4NS1zb2MtZnBnYS1tZ3InIGlzIG5vdCBvbmUgb2YgWydpbnRl
bCxzdHJhdGl4MTAtc29jLSANCj4gZnBnYS1tZ3InLCAnaW50ZWwsYWdpbGV4LXNvYy1mcGdhLW1n
ciddDQo+ICDCoMKgwqDCoCdpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyJyB3YXMgZXhwZWN0ZWQN
Cj4gIMKgwqDCoMKgZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1h
cy9mcGdhLyANCj4gaW50ZWwsc3RyYXRpeDEwLXNvYy1mcGdhLW1nci55YW1sIw0KPiANCj4gJCBt
YWtlIC1qMjQgQ0hFQ0tfRFRCUz15IERUX1NDSEVNQV9GSUxFUz1pbnRlbCxzdHJhdGl4MTAtc29j
LWZwZ2EtIA0KPiBtZ3IueWFtbCBpbnRlbC9zb2NmcGdhX2FnaWxleDVfc29jZGsuZHRiDQo+IA0K
PiAgwqAgRFRDIFtDXSBhcmNoL2FybTY0L2Jvb3QvZHRzL2ludGVsL3NvY2ZwZ2FfYWdpbGV4NV9z
b2Nkay5kdGINCj4gL2xpbnV4LXNvY2ZwZ2EvYXJjaC9hcm02NC9ib290L2R0cy9pbnRlbC9zb2Nm
cGdhX2FnaWxleDVfc29jZGsuZHRiOiANCj4gZnBnYS1tZ3IgKGludGVsLGFnaWxleDUtc29jLWZw
Z2EtbWdyKTogY29tcGF0aWJsZTogJ29uZU9mJyBjb25kaXRpb25hbCANCj4gZmFpbGVkLCBvbmUg
bXVzdCBiZSBmaXhlZDoNCj4gIMKgwqDCoMKgWydpbnRlbCxhZ2lsZXg1LXNvYy1mcGdhLW1ncics
ICdpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyJ10gaXMgdG9vIA0KPiBsb25nDQo+ICDCoMKgwqDC
oCdpbnRlbCxhZ2lsZXg1LXNvYy1mcGdhLW1ncicgaXMgbm90IG9uZSBvZiBbJ2ludGVsLHN0cmF0
aXgxMC1zb2MtIA0KPiBmcGdhLW1ncicsICdpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyJ10NCj4g
IMKgwqDCoMKgJ2ludGVsLGFnaWxleC1zb2MtZnBnYS1tZ3InIHdhcyBleHBlY3RlZA0KPiAgwqDC
oMKgwqBmcm9tIHNjaGVtYSAkaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2ZwZ2Ev
IA0KPiBpbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyLnlhbWwjDQo+IA0KPiBUaGlzIGVycm9y
IGlzIG5vdCBzZWVuIGlmIHdlIHVzZSB0aGUgInJlZHVuZGFudCIgaXRlbXMgLSBlbnVtLg0KPiAN
Cj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2V4YW1wbGUtc2NoZW1hLnlhbWwg
c3RpbGwgc2hvd3MNCj4gdGhlIHVzZSBvZiBpdGVtcyAtIGVudW0gdGhvdWdoLg0KPiANCj4gVGhh
bmtzLg0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiBLaGFpcnVsDQo+IA0KDQpVcG9uIGRvaW5nIHNv
bWUgbW9yZSByZWFkaW5nIHRocm91Z2ggb3RoZXIgZXhhbXBsZXMsIEkgYW0gYWJsZSB0byBnZXQg
dG8gDQptYWtlIGNoYW5nZXMgYXMgeW91IHN1Z2dlc3RlZCBhbmQgZ2V0IGl0IHZhbGlkYXRlZCB3
aXRob3V0IGFueSBlcnJvciBvbiANCnRoZSBmYWxsYmFjayBhbmQgbm9uLWZhbGxiYWNrIERULg0K
DQpJIHdpbGwgc2VudCB0aGF0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNClRoYW5rIHlvdSBzbyBt
dWNoIGZvciB0aGUgZmVlZGJhY2suDQoNCkJlc3QgUmVnYXJkcywNCktoYWlydWwNCg0KPj4+DQo+
Pj4+IEFub3RoZXIgb3B0aW9uIHRoYXQgSSd2ZSB2YWxpZGF0ZWQgaXMgdXNpbmcgdGhlIGZvbGxv
d2luZyBjaGFuZ2VzLg0KPj4+Pg0KPj4+PiAtwqDCoMKgIGVudW06DQo+Pj4+IC3CoMKgwqDCoMKg
IC0gaW50ZWwsc3RyYXRpeDEwLXNvYy1mcGdhLW1ncg0KPj4+PiAtwqDCoMKgwqDCoCAtIGludGVs
LGFnaWxleC1zb2MtZnBnYS1tZ3INCj4+Pj4gK8KgwqDCoCBvbmVPZjoNCj4+Pj4gK8KgwqDCoMKg
wqAgLSBkZXNjcmlwdGlvbjogSW50ZWwgU3RyYXRpeDEwIERldmljZXMNCj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIGl0ZW1zOg0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IGludGVsLHN0
cmF0aXgxMC1zb2MtZnBnYS1tZ3INCj4+Pg0KPj4+IFRoZXNlIGp1c3QgaGF2ZSB0aGUgc2FtZSBw
cm9ibGVtIGFzIHlvdXIgb3JpZ2luYWwgcGF0Y2guDQo+Pj4gIml0ZW1zOiAtIGNvbnN0IiBpcyBq
dXN0IHRoZSBzYW1lIGFzICJjb25zdCIuDQo+Pj4gU2luY2UgaXRlbSAiaXRlbXMiIHByb3BlcnRp
ZXMgZG8gbm90IGRvIGFueXRoaW5nIG90aGVyIHRoYW4gYmxvYXQgdGhlDQo+Pj4gc2NoZW1hLg0K
Pj4+DQo+Pj4+ICvCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IEludGVsIEFnaWxleCBEZXZpY2Vz
DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpdGVtczoNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoCAt
IGNvbnN0OiBpbnRlbCxhZ2lsZXgtc29jLWZwZ2EtbWdyDQo+Pj4+ICvCoMKgwqDCoMKgIC0gZGVz
Y3JpcHRpb246IEludGVsIEFnaWxleDUgRGV2aWNlcw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgaXRl
bXM6DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogaW50ZWwsYWdpbGV4NS1zb2Mt
ZnBnYS1tZ3INCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBpbnRlbCxhZ2lsZXgt
c29jLWZwZ2EtbWdyDQo+Pj4+DQo+Pj4+IFRoZSBkcmF3YmFjayBvZiB0aGlzIGlzIHdlIHdpbGwg
bmVlZCB0byBpbXBsZW1lbnQgZW51bSBpbnN0ZWFkIG9mDQo+Pj4+IGNvbnN0YW50IGZvciBmaXJz
dCBlbGVtZW50IGlmIHdlIG5lZWQgdG8gYWRkIG5ldyBkZXZpY2VzIHVuZGVyICJJbnRlbA0KPj4+
PiBBZ2lsZXg1IERldmljZXMiIGluIHRoZSBmdXR1cmUuDQo+Pj4+DQo+Pj4+IFRoYW5rcy4NCj4+
Pj4NCj4+Pj4gQmVzdCBSZWdhcmRzLA0KPj4+PiBLaGFpcnVsDQo+Pj4+DQo+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gaW50ZWwsc3RyYXRpeDEwLXNvYy1mcGdhLW1ncg0KPj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGludGVsLGFnaWxleC1zb2MtZnBnYS1t
Z3INCj4+Pj4+PiArDQo+Pj4+Pj4gK8KgwqDCoMKgwqAgLSBkZXNjcmlwdGlvbjogQWdpbGV4NSBE
ZXZpY2UNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaXRlbXM6DQo+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoCAtIGVudW06DQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gaW50
ZWwsYWdpbGV4NS1zb2MtZnBnYS1tZ3INCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29u
c3Q6IGludGVsLGFnaWxleC1zb2MtZnBnYS1tZ3INCj4+Pj4+PiDCoMKgIHJlcXVpcmVkOg0KPj4+
Pj4+IMKgwqDCoMKgIC0gY29tcGF0aWJsZQ0KPj4+Pj4+IC0tIA0KPj4+Pj4+IDIuNDMuNw0KPj4+
Pj4+DQo+Pj4+DQo+Pg0KPj4NCj4gDQoNCg==
