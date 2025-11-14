Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB07221FBA;
	Fri, 14 Nov 2025 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763083906; cv=fail; b=IPmzO5poTDk6+IgkuToKeGGjYzqXOG1JbhWeMnS8PoRiQ9ZPstei8hi5ikxwU75vOzMUPGdIwQUIygpiU8J9Pl+/G4OyrZVhoY29z8yerusm66owarNosKXnAlMsRcQbXpMAV9riP9wf0aK7mkUvZG3DebwzvZAZQlNtxadXDbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763083906; c=relaxed/simple;
	bh=SpqYm4vifItvpdrQvF5/DmfXHm44mRuPtDyxp+jfLkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oq5NWG+Vz9OjqsjciLR6H2zHQ3/5dCicaEP0H9SF3TipiyxUYBdE6sg3/uCREiyJOhbZRKHaZccrjCiW/cAbRnBTWnAhBnWw/eH7m+8M8mhFVzLiCtjouLC4OkdTcqbZT//dD5AyhXqpXNQ4T0u6aGFJzFAVIPYtSs+HzE/Wiiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cna4ke5l; arc=fail smtp.client-ip=40.107.200.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="cna4ke5l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGux5NoifiCvlC33Xrz0zZyQIh/8fYh6K3QfghfhYgQOwbpMr7L84LPu7yY6X4bcJg/IS6AvO+fU/SRc+UlsD+IaLuBOQeDpQLHSsSHqyOlCcJ28Bxwj872vFVnXmjiXIdazDlJbkGjblRs77ZxN2ZsB/R3XE5++66sK1MzORzC1w7lmqzmICDdL91cAYMGFwyvV38pN55zHytITIlw74eZY/qhZPhgIkAvd+gDsSIXA2QRgzeK6VuGm6Al+33rlFYU4gKilFyd7ZLhMXZU9xBv4TGk+HzhQtmnOnVoiTwfTORfGPlL4rmBo3FSgjgO9/FaI6q0NfB0CEOyFTCBPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpqYm4vifItvpdrQvF5/DmfXHm44mRuPtDyxp+jfLkA=;
 b=W8lTjlKGDKyY3vTKV/9ulk3ZaaO7FqjQZyDV7R/g3hqAPWQRYDM0yolgPnvR8cLuvPKhHS57rtlh1XciTpe+EwG92ShVx+hC527gJPJkeuugLUHXBmcDpHLwZMA5L8ZMQcam3rgiK2WDJ64l44ajKPcxSpSuCtoHhUYZ+uVFIiN+zS5A5RjntnKglCw0qIc9YO7YWeWyiZaTvVkZsX89vzdCv7LXEH9myeDgdv1cbPfonWC3CuFVbj25KA/VGI9ePhRY7NycNXon0kdEaUTOyq6kJ9H6uTtGHvfkjgl9vVJJviBb9qrEUmU/rtPNT1hF2g8OIkIe76AspZZVq31d6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpqYm4vifItvpdrQvF5/DmfXHm44mRuPtDyxp+jfLkA=;
 b=cna4ke5l9KdA6CG7HPIaTxSjP32xWXwXjm9W3Eben6AsUnN/JO+jrBrqL25koAIDKzq+laGTJVagrPGwazFH6muBQFwAejI21KT/877iyQ3S4GuQL643nTapJfCHe/7vvyBBf00FzFlyQ72R1LpQRNMVxSDzv8nBqeHblAYus14ZbMwEQBslc/RBPn7ZPi9aLhMD572bebaSnWumpB39Kl1T+8G5RvqTpEKEzh9x1jbvqXhh7dtA6I/SovhbRuAfr0dZ2PRME/IIBuQUU8PD3Y4oi1v7tG++HJ4Fnb5/0Uwy7q0pIqGAr0vEQJb1eMxGrta7jkiM6dY16NURDbfrjA==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH8PR03MB7173.namprd03.prod.outlook.com (2603:10b6:510:258::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 01:31:40 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 01:31:39 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Conor Dooley <conor@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>
CC: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix
	<trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "Rao, Mahesh" <mahesh.rao@altera.com>, "Ng, Adrian Ho
 Yin" <adrian.ho.yin.ng@altera.com>, "Rabara, Niravkumar Laxmidas"
	<nirav.rabara@altera.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Thread-Topic: [PATCH v2 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Thread-Index: AQHcVFgrIVhUrky/Q0+04B/7vneeGrTwGoGAgACePQCAAKtqgA==
Date: Fri, 14 Nov 2025 01:31:39 +0000
Message-ID: <bafd214e-b688-44ba-951c-b1fc2f6f461d@altera.com>
References: <cover.1763008269.git.khairul.anuar.romli@altera.com>
 <e342dc1626ae07d6b1773ad9fa5232d38af76bc2.1763008269.git.khairul.anuar.romli@altera.com>
 <aRVx85JJHDD4yygV@yilunxu-OptiPlex-7050>
 <20251113-buckshot-deeply-4654ba05b940@spud>
In-Reply-To: <20251113-buckshot-deeply-4654ba05b940@spud>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|PH8PR03MB7173:EE_
x-ms-office365-filtering-correlation-id: 333cc13a-ff1f-41b5-6d3b-08de231d8f16
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?azNqd21UbU9nU3pub3Npb01VbUxQS1czWkVSYlZCVzM5Rit1YXZPbmVQU3Ns?=
 =?utf-8?B?VkZnODdLL24xRk80VUxDdWFFMlBzZEVDNDBTdExFMlI5cytPSGJVVzg3amtl?=
 =?utf-8?B?MG5PdTZWcW9FT3NaeFhiVW90TUxPNlhWa2FyR2ZFc3ZKNGtScDFyVEhrRmI4?=
 =?utf-8?B?cXNIaGs4WC8wTEF0U1poN1dRbHlrcGkwcjZwOER6dUVrSGxiTmlmU1ZldWVU?=
 =?utf-8?B?L0ZtcTZLMDA0QnlGanFueDZvRVE1dm9ROFF1SDNKc2NRMlZDZDJsOU1aT3Na?=
 =?utf-8?B?Yytva0VlM1FyM2ZabzhoVVZlaXJPdHVFbjR0a0N6ckNjOG9CNm50bFpsTGpN?=
 =?utf-8?B?MDFCNXNqYlJjNXp2QkpCendSdWdQR2lJTk5kSWR2a1dmdDNSMjdmT0pVUzMx?=
 =?utf-8?B?dGtSUkoyVFpzK21TMmtPVHk3N2d1MDcwYkxIODRoWDNBZ2haK3pJbHlqQzFp?=
 =?utf-8?B?T0FnOFJ3bVB5OEUvUnNWRHpINzRQbmNYNXFBOTFqeFdBYys3TDFMeHc0WlI3?=
 =?utf-8?B?dm12bTNJQmpyTG54bGdZRTRoSThiTDlZTk0vb1FxRmZ2K2ZKZVdtUzdHSEs3?=
 =?utf-8?B?dHBPNlZQY3FtL0t5VUc1dDFTK1NUNlVzcVZ2RE9MaDZ0eTkrUmN1L3c0TzJE?=
 =?utf-8?B?T1gyakNNeGpTaE9BLzc4SXZueFpWUGZlVWVWbERlcmxoVlQvL2ZURUhvd1U3?=
 =?utf-8?B?anJtODlVMVdVWXgyQ25nd3kySDF6Z0dKQzNRKzZoNzMwdmVNRFFmOXdNTHVL?=
 =?utf-8?B?KzE5RVc5dXBndzcwNVNaSjRWY1NjejRwTjBGK053diswQzd1TmZzU05IWHNQ?=
 =?utf-8?B?aUpvWVdRWWFNUmNrd3pYa0JRSjh1Y1BSazRIcm01ZUU0SFNhdFRPQTdxTncy?=
 =?utf-8?B?NHZyQnJhOG9aNjNoTzlTSVJIRGdKNno3TFFkemE3RDFLMjFMUGMzQTJNNDlD?=
 =?utf-8?B?T0xzVVlsWStRcVRYd1FHbEpMTlBBc2s0NVh5RkZ6SnF3NnBxVHBpdFlwdFJ1?=
 =?utf-8?B?VUNDNWh5by9FTGo4dGg4bjBUUXpmSS8vY05QRHEzcGg3diszbFBUTFhRVEp6?=
 =?utf-8?B?WUlCSmM5TTFaeUhZWThocmg1WTZtWWpuSVdMOUhDRVd4Z2N2QTRVUXppc0ZV?=
 =?utf-8?B?M1hSR04rczNEV3dQY2U4M1BFdy9ndEc0STVQZDQ5L01rOWRTMndYS2JyRmJh?=
 =?utf-8?B?c2cvRExWOTJ3YTRzaEJBamFaN0dkR1dMMThWakhOWnZ3OXNmNVlVZzA0VW1N?=
 =?utf-8?B?U21oSjFCSFpxRnlRd2JOMW5La3JGM05BUU1qenVValBjeHdGZTFROTRIRDR3?=
 =?utf-8?B?R3FZOE1FOXozSVFXZFBaNTF2bC9Ta0IzSEpCc1BtODUvNWljYnc3RE05RDM1?=
 =?utf-8?B?RTIvOGNKWDJJNXFmVUZpdUh5WmlSbitvM2NWZmtpMTNzc1d4NzRoTUZGSVdC?=
 =?utf-8?B?N1hkOVo3QUJnZFVla21tK2docEZwb0o3SktJdU1oMm1INHhyaUhJSXpvckFI?=
 =?utf-8?B?aitGQVFPdUxNQTRuU1NmeThVOFgwc09lM2IyYkVJYWhGM3dQM05uZVB5NlFj?=
 =?utf-8?B?emRmOUR1Nlc0emhNdDdISFVsVTBnTTk1aGJSaHNTSHAzK01CQ3ROYnZ0SkJJ?=
 =?utf-8?B?cUpTbkR5UWhMYzNWd2FGaGR6aktOZXg3bi9zbWZremN5R1h6VzFxTUJUMnl3?=
 =?utf-8?B?dUk0ZEJyUzkzVURlOGRQQ2k2K2xlU3llQTExUVlRSHNwYVFla3FoRUlNaFQ0?=
 =?utf-8?B?cEdCNFBuQXBINTlaR2FTcmJnbHd0OGRhZGtqaDMrRi9OSldUdnYwVmIvN2Rq?=
 =?utf-8?B?OXlMaU9odWlJcnJPM0FrMzZYbW5PZk9xd2JkZmJhRkhMb2ZtWW9CQXZFQnhR?=
 =?utf-8?B?aU8xTmJOTEl4djNxaXcwNTFXU3pwbFpHdjl4MHlORlVCRVA2S3h0YnFGcGph?=
 =?utf-8?B?Y0p4Ym1DM0NBRzMzdi9BalQveVRpWXBlOEJESTYzdzQ0L2IzTyt4RkRrNkFq?=
 =?utf-8?B?SEpSREZpUHZZMzkza2doZ1I3QytKWUZ3OWVxOTlwTUR0UHRaV2pFMWJ5SFBO?=
 =?utf-8?Q?sSU5C8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejAyZ1plMVJ1ZnJzYTNOL1NEM09vK2FuczIxS0RLVnhYUEN2WDlDeUdFdndV?=
 =?utf-8?B?UUVZM1JlWmo0RkZQQ0NVczdyV0NIUWhhbnRIZ0N1YldkVVpTaGw4VEdoS3lr?=
 =?utf-8?B?Z3h1eXNKUS9mZFgvODAzV0VUTCt4QW92dGd5UDlyM2wyaGtKVUV2dzN0Uzc5?=
 =?utf-8?B?S2ZYSjZVUndBaGdtR3RzZElkQ0x2ZnlSQmxORmludHRBckxFdjF0YkVYbFNY?=
 =?utf-8?B?Mk5qdmY0eXJkZ3dPaGF2T3RFNE95TE5IYlVQM3lLdHg0L3JEaGMvYXZkenJC?=
 =?utf-8?B?QnJTTDhtcmQyTHN2MEtqZ2VSTitMcEJXbXBIRGpRQlhRTHp6ZWU1dUtla0Jp?=
 =?utf-8?B?UnordVAwOEpWKytZVzVKVVZ1Y1ZlTjZ3eS9rQUgrR3Z5Z2dkL3NuVzNuOXgw?=
 =?utf-8?B?NUgzOGxCRUhmSmYzZ3p2cGRUMnY0QmxNZU9aNE5hNCthSndtdWxMUjlxdG84?=
 =?utf-8?B?T0FONyt3dks1QXVrMlJ3L3RhdlVBZS9Mc2V4Z3Vaa3ZNOTZwUndCeWtrenl2?=
 =?utf-8?B?aWRCdWVIR2NxY0EzWlRxUGdMa3BMT1IxeXg5VGQ1TytTM29yY25LWmdPa3JB?=
 =?utf-8?B?ZmNBREVLcFdLRG03b3ZMVks5SUVyZmVEVFVtYWQyeHEzLzVmVUsyWE1vY1V6?=
 =?utf-8?B?RlliZUptbGhNaGdGRU9yejVOaGFESXZjME1laW9OZHNTSTk0L2ozY1ltUUtX?=
 =?utf-8?B?UUhoOHQvVmNFU1JhcEtVUE5scDV5SmViZnM3UWdJWWE2M0Z6TTdFZmFKSXBD?=
 =?utf-8?B?TWxFT2tjT2dCY3B1dXozWUx3NitRanRQQkNudlVkWENHMXpiT3c1aU9sWXp6?=
 =?utf-8?B?bURCb05KVStPZWVlZ0c4cEVtSkdzeVZtbmMzdW1PcFA1WURJRURoNXErLysy?=
 =?utf-8?B?blAvZ2c5WGNqYmZYTGN0S2lnRFpGbmU5djNUejFhMjdHQTNFTnEraE5zWFB5?=
 =?utf-8?B?YU9hb1F3czNPdC9ENlg0TkJMWTMrdTgxdkNQSjRON0NCTGgxeFhYcklwQi9K?=
 =?utf-8?B?SnZZWkRwQ0xvczFVclNnRkxVUVZnMG5Ebk0vQ2tmY0s1MW00ZWdweUQzU3lm?=
 =?utf-8?B?SlI3M0F0Vk45N3p0SDErWXU0NWMrL1gzS2VLQ09EcExKMVNGY2V3UmZaMWRM?=
 =?utf-8?B?eGM4alB0UkNGVnZGYTRuS3Jjem9OQ0x5YUtQV0NRdjkwM2N6NUhJUThBTk42?=
 =?utf-8?B?Zm1sdGlnM0FvS1pZbzh4REtzdEF4MDZWVGNmU3JQQUcrUjhhZGp5QSt4WXVO?=
 =?utf-8?B?akJCZXA4WE1FRjRTa3VHcWxzMmI1TGZGOGpBZlhxaEZkaFFXNU56cDhLY0JG?=
 =?utf-8?B?aUpvYWZTMGcyQy9qZjBmLzJYTE9wQ296aklreGl6L0FrYkYyRmE2azVaM0tp?=
 =?utf-8?B?VGR6NEJxQ1VBQlV0RDd0dE52RnI0dldNZUNOZUEvK0lmL2VQUDI4cks4OHhY?=
 =?utf-8?B?bHRKSmVnWHh3NzJicitsazZHRVJ6S3cvb0M0a0lzMnhkeUJBNGhWZUUzVU9Q?=
 =?utf-8?B?OU5hSm1hYnllczNQVSttRVRUTkdZbXN2SWtqMGNHVlRXUm1VMnZNWSt6eHV6?=
 =?utf-8?B?TjRndis2bXZXSXNFWER4dTg5ZEVoY0ZvL01uMm1QaVRMdzRXa1ZYY0x5cTc3?=
 =?utf-8?B?TDJYcDFvdXZ6TTFxd0pYWWhwVEhnSjU4TjN3bTM4RllzQ2ZheSttVkVwQlhJ?=
 =?utf-8?B?NWkzZG03a3o5elR0WnBMRHJMREhnS1puZ2FRL3BkclRuZ1Y2UU5UaW95dFBO?=
 =?utf-8?B?cndURk5QSVN2a0g4THZESWh2N09RcDFvM2t6RkhPTC90cmJ4UFpFa3l1UmM3?=
 =?utf-8?B?Skpqd1QwZnJGQ2IvVDBmQjR5OFhRcVMxUDZzakJzWldQeTRIYXVwYmF0ZnJD?=
 =?utf-8?B?dmZ1YWJFQmY5eER4RVlQK0V0Z01aWFlGRUNtb0hnby9jWHNONGhTOUVmQVZt?=
 =?utf-8?B?RmFzTWdJWkJpOFVMb28xUnFmVEhudEErNWRWc2hrTGg3ZnZQTW5JWjZjRXdr?=
 =?utf-8?B?SHRNdW4yczhPRzZxdUVZSElWbFlDUnRDbkt1d2NlK090dkpzYnRQQzA3RTdm?=
 =?utf-8?B?YjFCVWc4a3ZVRFpTYU5NZkFPNTdEeUJzUlo4cloxVVNEQk41amlzeDBuazVB?=
 =?utf-8?B?T2x6Yk50Mm5DNWppaEhZdmhvM1NRWERYazEvUHpzcGp4aSs3RDVvaWl2dnV4?=
 =?utf-8?Q?zkMj+oybd6/7iy0POVv7AkU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9965554028FCD4C8006407485B066FA@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 333cc13a-ff1f-41b5-6d3b-08de231d8f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 01:31:39.4387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylZvBTTKZIvSFyGUXIQ1xgE1LE3QhOZzrLrAIW7aW8/qlMmcQlkFJ4TnojYUUDf6yjCOrgOZaO6p31uB6szLqbykfFw51+7FOcxK3DwlRkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7173

T24gMTMvMTEvMjAyNSAxMToxOCBwbSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBUaHUsIE5v
diAxMywgMjAyNSBhdCAwMTo1MTo0N1BNICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4+IE9uIFRo
dSwgTm92IDEzLCAyMDI1IGF0IDEyOjQzOjU1UE0gKzA4MDAsIEtoYWlydWwgQW51YXIgUm9tbGkg
d3JvdGU6DQo+Pj4gVGhlIEFnaWxleCA1IFNvQyBGUEdBIG1hbmFnZXIgaW50cm9kdWNlcyB1cGRh
dGVkIGhhcmR3YXJlIGZlYXR1cmVzIGFuZA0KPj4+IHJlZ2lzdGVyIG1hcHMgdGhhdCByZXF1aXJl
IGV4cGxpY2l0IGJpbmRpbmcgc3VwcG9ydCB0byBlbmFibGUgY29ycmVjdA0KPj4+IGluaXRpYWxp
emF0aW9uIGFuZCBjb250cm9sIHRocm91Z2ggdGhlIEZQR0EgbWFuYWdlciBzdWJzeXN0ZW0uDQo+
Pj4NCj4+PiBJdCBhbGxvd3MgRlBHQSBtYW5hZ2VyIGRyaXZlcnMgZGV0ZWN0IGFuZCBjb25maWd1
cmUgQWdpbGV4IDUgRlBHQSBtYW5hZ2Vycw0KPj4+IHByb3Blcmx5LiBUaGlzIGNoYW5nZXMgYWxz
byBrZWVwIGRldmljZSB0cmVlIGJpbmRpbmdzIHVwIHRvIGRhdGUgd2l0aA0KPj4+IGhhcmR3YXJl
IHBsYXRmb3JtcyBjaGFuZ2VzLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogS2hhaXJ1bCBBbnVh
ciBSb21saSA8a2hhaXJ1bC5hbnVhci5yb21saUBhbHRlcmEuY29tPg0KPj4+IC0tLQ0KPj4+IENo
YW5nZXMgaW4gdjI6DQo+Pj4gCS0gTm8gY2hhbmdlcyBpbiB0aGlzIHBhdGNoDQo+IA0KPiBTaG91
bGQgaGF2ZSBiZWVuIGNoYW5nZWQgdG8gcGVybWl0IHRoZSBmYWxsYmFjayBjb21wYXRpYmxlIGFz
IGRpc2N1c3NlZC4NCj4gcHctYm90OiBjaGFuZ2VzLXJlcXVlc3RlZA0KPiANCg0KV29ya2luZyBv
biBpdCByaWdodCBub3cuIFdpbGwgaW5jbHVkZSB0aGUgY2hhbmdlcyBpbiB0aGUgbmV4dCB2ZXJz
aW9uIA0KYWZ0ZXIgdGVzdCBpcyBkb25lLg0KDQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcywNCkto
YWlydWwNCiAgPg0KPj4+IC0tLQ0KPj4+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZnBnYS9p
bnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyLnlhbWwgICB8IDEgKw0KPj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvaW50ZWwsc3RyYXRpeDEwLXNvYy1mcGdhLW1nci55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvaW50ZWwsc3RyYXRp
eDEwLXNvYy1mcGdhLW1nci55YW1sDQo+Pj4gaW5kZXggNmU1MzZkNmIyOGE5Li5iNTMxNTIyY2Nh
MDcgMTAwNjQ0DQo+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Zw
Z2EvaW50ZWwsc3RyYXRpeDEwLXNvYy1mcGdhLW1nci55YW1sDQo+Pj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvaW50ZWwsc3RyYXRpeDEwLXNvYy1mcGdhLW1n
ci55YW1sDQo+Pj4gQEAgLTIzLDYgKzIzLDcgQEAgcHJvcGVydGllczoNCj4+PiAgICAgICBlbnVt
Og0KPj4+ICAgICAgICAgLSBpbnRlbCxzdHJhdGl4MTAtc29jLWZwZ2EtbWdyDQo+Pj4gICAgICAg
ICAtIGludGVsLGFnaWxleC1zb2MtZnBnYS1tZ3INCj4+PiArICAgICAgLSBpbnRlbCxhZ2lsZXg1
LXNvYy1mcGdhLW1ncg0KPj4NCj4+IFJldmlld2VkLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVAaW50
ZWwuY29tPg0KPj4NCj4+PiAgIA0KPj4+ICAgcmVxdWlyZWQ6DQo+Pj4gICAgIC0gY29tcGF0aWJs
ZQ0KPj4+IC0tIA0KPj4+IDIuNDMuNw0KPj4+DQo+Pj4NCg0K
