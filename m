Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840A82F261C;
	Tue, 30 Jun 2026 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800028; cv=fail; b=Y9NTLHmm4MMdmIM6eH1dQH7e10NS81Bny1/sV+bfm0Sisiszd3TgVtXZDvxv/YmpeAbGoOZIqyX5/JCOHWz/H7pCYBhbDlGR8dRhEpdxldDegZpjAn3/nYKh1FuAE//mTAzLGOVs0ZpVLDUeA8dDUe22cGPpKxOrOuzh0f/jUdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800028; c=relaxed/simple;
	bh=qLh6Pgcb3Td48Oaodi62WyUFVEoAytFkZdFinYn3bGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ia5OyvMNWzveCcIfnz7HaTGpQmHNapDkg81MsPx4QlYApIFobNItPx052Um6HKqo1dIhn3E3ZdPR3LRjuCyupCnT8M3NVfibuI4/Uy2onDpl69FCLA5RDLqtIUgQ6RP4ncFnaNKg/rpRZ/Dhh0S2lFvWBSkRtCT7hnvH7MHDMeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pK68a2AJ; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="pK68a2AJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9cA95aJGmvGPPkdNsk+HLgc01Ph057t4jgOWWUO1xCuNT88yDTz6h3GD81IYe9NlVNbTdwHPPQ1PExRYhgsYEo/epa5eUxHUDlaZSeVj50yDGqSINWL7LemGNDpUQnMTeubnWNgvzJ8/f4MOSBEPIeSdJF6dM/jfuQKsxvBL+zrU893H7ieyBHFSnnTwPIz1JBaEn7Ppn8QT7J5X/DSTlCDI6ySsLUF0fkmebWR2ZvyZqcdK3aKzqlpaEsktryPQR8YzJKSbZ59nUS+ovAE7fNQpWbPs25c46pzFElpAzMDpBRP7+kiIPJaUDr4dpI5tAJDANngzicvO6V11WdWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLh6Pgcb3Td48Oaodi62WyUFVEoAytFkZdFinYn3bGM=;
 b=a1ZX/qv8gYmuF9/auSnv4L/VibW3DVQ5SCqmuR9AYokxfODrMANAO6N+68Pw/pdeY53oCnONEtCPVx084S8oQTaanCXS6kDWTy1sXDVWqX88PRw1sTrwld73goJj0T9LBrMvg2DkpEmDVMx7uLRVnOpGrdZMrpWKah+WJDXdCQ7QAGurlf/yIm8oOKLLQLADkiQbRgrFc8qAV4R8FvrQaFHQf0kYWHOeT4xs2PzEU7Ks6lG/OFtg1a12Bun7slZEkEASN0DHvPrf+brKJFjXfKcHIt6Pp381D+q1oL6u9ldGrADZyXcWNSEgPTukEpj1okQ666oo/bzuAEWYewxmkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLh6Pgcb3Td48Oaodi62WyUFVEoAytFkZdFinYn3bGM=;
 b=pK68a2AJTYquO7gkgl4XAzhr7a7vB/Bh4Vo9C+zyZ9ZiIWHUlBYlNpgkSk+MyDLaiewjl937xc5+vMoQiYde1B41g70fEL8lfIrZCSf0cTW0nXzpysbX+fVN3naAQo7AmKPdDJy0rkUMf/RLxvNDSQWloAX7wa8eAa/mnaKlvcyx633T4cpe0fqdvjlZfJ+FMAO7o89ZV6MDDTqKG77J975kUa5Zg1SIH2PYtBM9SS7r7fJyHZ3JT3tvKpdO9ZwtCcicLO2G7iI6O0r69B6vFnV0tBoDRbDdoMoy3/4tj2pRJV0vwJ5F/SnqSy5SzNnbENd0zZvGDbsMSJCV85FoUQ==
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB989259.namprd03.prod.outlook.com (2603:10b6:510:3b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:13:44 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:13:44 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix
	<trix@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard
 Gong <richard.gong@intel.com>, Alan Tull <atull@kernel.org>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ang, Tien
 Sung" <tien.sung.ang@altera.com>
Subject: Re: [PATCH v3] fpga: stratix10-soc: Fix SVC mailbox handling during
 reconfiguration
Thread-Topic: [PATCH v3] fpga: stratix10-soc: Fix SVC mailbox handling during
 reconfiguration
Thread-Index: AQHdA8HjGYcmXMnxykmjp0nh5+T9hbZRFj8AgAWRcgA=
Date: Tue, 30 Jun 2026 06:13:44 +0000
Message-ID: <bb09519a-e2d0-4383-91b0-33fd32c23b1e@altera.com>
References:
 <0119f69b467e2b90240ebaa3aee3120f621ddee3.1782295811.git.tze.yee.ng@altera.com>
 <aj6y2CLYpdaQOGd4@yilunxu-OptiPlex-7050>
In-Reply-To: <aj6y2CLYpdaQOGd4@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5950:EE_|PH0PR03MB989259:EE_
x-ms-office365-filtering-correlation-id: 94c59c07-57e8-48a0-5535-08ded66ebd94
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|18002099003|11063799006|4143699003|22082099003|56012099006|55112099003;
x-microsoft-antispam-message-info:
 BVj6qtSX+1FKZqPBgB0WRVyrz7DPapleLyjSO2y57ErkYGPwP62w12PxqmHBbRUu5DDtHUsjR9E6/tf5RQfxSqCV78bUtV/Kl4UjQ1YACI8oW+v+sKn9/uWh4nMf48sq7Dddj+Mg3t3L+YmmBJ0pmiRg/oV4zAQP3j3SRQf4W5x9255aKsXetPc4/9O5za32EArtXoHKqVQ2eZKIZFmXVEWwP0C86UdzJ7kdddSOct/GbhvGVLAEKj4nrK9yJ1PtzQ1jFOWuRzRDxh/19kEvD7avZcmeS4bXd3/fBMxQaKT4+mGYI0ir8eDuIujN1tV5D3Uj+t6VslLE5KOiCjpp/Y//wKTltsCsIpen4Wh71pP0KNxqzBpTx0V948LYLjgGh9yIDHnaeIxN/4Etivrk7OLk2/5+QGRD63SzvDTUIpxEli9BE18J9VIBaijS3QgTJRDRDWRKuvbxrbUKizMWVxgh9r89RoVxAH2dwQzV6twH1loqiXKPF0ucIgtldCRcRmCOzFgZVr+H/ZeAU8OGTRs/PexaT7kyvgZKBgyrwpVNaRUhwMvzspzuhanBIKutpPHKMWtWOxq6MYtUxt5+hFpYsZ8G+e3xd/ncLaO21jAsqLX47AYtHqJPofNNT/ZTcSBlqATYTqsGqA0b6AEwjc5AspSn7rGqQpUfXpkGiE2rRRb/R6M+ATNppsd5/S6PG3eEGesSqNPlyMJh+BDsLA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(18002099003)(11063799006)(4143699003)(22082099003)(56012099006)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUZ4bXRGZkxmK0dMT0k1Umw4anZtWGlhZjZMSmZPYWd1ZUNqRzY2Ky9ZTjBY?=
 =?utf-8?B?WWVocHJ0VVZRS0l3RU8wZWRYNnN3b053YXlhdmZHemZsQWNBZG5HOVhMc25D?=
 =?utf-8?B?QjVIRTlxRDVmbTBvNHdiVGxKU090anhrR0lKbk9oZXUrSnd4Y3VTbnRnWnJM?=
 =?utf-8?B?ZlB3YmZZbVBIdHJ4T0trWHc0MExqNmtqeTRwOFpZd01KSFNDNGFQQ3ZxbFZ6?=
 =?utf-8?B?VUxmbGFieXJlSUhndVBWUXZDb0lRZ2lwc1ZSZEZqM1NRVktiYzZycTFpV3NQ?=
 =?utf-8?B?WkprVGM3NkV4dVFVMEo1SVZiVUgzem9helZFTmlzRVAzdEJuTHNyZmZXVkNB?=
 =?utf-8?B?TXQyeVBqOFpRQnJoWHF1Vm01ZEhrUktYSkFhZCtkQWRjME54VGc5NWZrSCtx?=
 =?utf-8?B?QTZFN1VUaWJuS3plaFJDekgwL3FHMDhmdE1OLzVhNFBIV2dPbzRXOEdpL0Ru?=
 =?utf-8?B?ZWEvUjZPTHZFb29iRHNWUEt3a1hUMlk5dUU1a2RQZkNpZDBiQitFWExianlu?=
 =?utf-8?B?VzZiYnk0a0hRUTNxeFdlWXcwRml1c1F2aStVMEZLQU1GRnVSOFVmVXFtVzhr?=
 =?utf-8?B?bmxHUGE2ekt3VkE0SHVnQmRUYmVuTE5VMmk1a3BEc2V4RlZvZ3RzamxncnF5?=
 =?utf-8?B?ZmM4Y0xKV0I2VTViY1VhL0V3ZmhRU0NzMVpqLzhjYjJqOFBLTjR5MTB4a1po?=
 =?utf-8?B?TmlNa2NCOFVkcnR4TnR6MXFLVEpIc1ovVWVLaDBUZXpJZzY3VCtrUDA0M1Ba?=
 =?utf-8?B?bFVDK3F4VDA1QVMvYUx5RUlJTEw4N0FRUWtCelVOTHlrNTRtcDJGQWk4enNU?=
 =?utf-8?B?RFpORHUydHZYYzhmemloelJ4blJtODFDVHpQTEhiN3BNWkRxSmYvRWEzaS9O?=
 =?utf-8?B?bDUyYks0Ujd5Uy9iYlJqOUY4RkxWU2tmeWlVejhYMG1ra1VIMU9ORUZ3V3hH?=
 =?utf-8?B?UlVORCt3Qm5WUHJmUGxEd2NHOU1NdHpSTGVYK3drbmxyZSs2MllHUGNha2Vq?=
 =?utf-8?B?dFdwejV0Rms3QXRaVkVCekp5d2pJQ3Q2YnRTNXRkU002elpUZk92enlEUElM?=
 =?utf-8?B?ZVhVUWJxMWM2YkpwYit6Uk5QWkpnUlRlVUJpUjN4cy9rMytwdnZuWEFDL05y?=
 =?utf-8?B?LzQzclBUamtIT1ViOXZPT0xlK0U4dDNScW1sSWxOMlZXazF1bUt4WFhDZDhT?=
 =?utf-8?B?UGdKNEJlMXVsVU5ibWpQQ0I0clNHWVhyV2p3QWFSYXpGUTVYM1RLMCtBemdI?=
 =?utf-8?B?L3VSMHVvRTNYK2xCMWlTM1UyWUJEQ0ZNOC9ReGRRSC9yVzJhTVl2a2MxcWU4?=
 =?utf-8?B?WlB0QnlwY054dFJ3N3k3enBQWkU2cWJjaVA2alVmU241MnhkNk5jREdzb2Rq?=
 =?utf-8?B?T0tHOHRhOHJva0hReEIvMVBmR1JlUFAxTUhsVWNYS2ZpM1ZPUmZiK2RQU0lB?=
 =?utf-8?B?ZFZPQk95NCtveEF3M3FkUzdiUjQ4b2VSNXpyeWlZejR2UlZkOTN2N2ZoeWo1?=
 =?utf-8?B?YkcvNC8yc3BXcjdYczdESDUrZnFhL1pnSDdiMG5lbkJCdWJBM0tTa1BHdTZB?=
 =?utf-8?B?NnRBaHlEcDJhL2NzSEpPTDZGb1JkODd0eW9DcHZVVkthYlVPRTZEN3BDTVNS?=
 =?utf-8?B?dUh3ZjdJVUxSaERoQTNGRUNhdWtkRHVlaDhLM2ZDRThRdXk0MFVFajM5V0tt?=
 =?utf-8?B?RTlTbVpJcmp4c1hvTlNDYlBwbkNNOEx5VHlROUNYM3FDSERsS0VPb2lmcVdY?=
 =?utf-8?B?WXZJSUZJSVI0OUxTUFQxMVdPSUErMEIvUVFqVVpyWXgzdnFIeXRpYUV4cGlP?=
 =?utf-8?B?SlVkQnFsdDI5bzFuMCtRdTZSZmpYWVIwbW50ZXhWc3F5STRuR3R2Zmh3WUoy?=
 =?utf-8?B?SndEV2dIMkRtSVhXMkxNUU1vQ3RiNzVGU2ZFS0ZFYUIzUGhqRnJMNVZUVmFZ?=
 =?utf-8?B?U1g5WlRhR1hCeHFvaUJkWEdvOGVQcHdkRkNqczBCVUE1SFdWcDBvRk5oUEVv?=
 =?utf-8?B?Ym1TMDJXb1UzcHE0L2dFM2tJWjRqMmVlQy9JdHM5VlhCYnBIQ3ZMYWszeGY2?=
 =?utf-8?B?ckFCQU14QWE0WE5HblFXaXpick9rTUZXTkorLzNOakExR2J1VzFXa2tKbE15?=
 =?utf-8?B?M0lCa29pcVAweTZNWmtDaFhscnJhT2FlcGpkbXRTOVJKU0xHdzlSL1c0ckZl?=
 =?utf-8?B?TmVsemlmS1VvMXFtcSszZzdPTzN4Y2I1SFBIRmNEeENGYmNVR1VWWVB3ZUJ2?=
 =?utf-8?B?bSttVk1EaFV0b3NhWDlrQjJaYXpReFN4czQxOGNxRUhON1YyTk9iOHJScmpC?=
 =?utf-8?B?WjlIaGtQeUFZMllEYi9CcVdqY25CYndaT2hLS2lWMVlzYjFQRlcwdG9hQ1lh?=
 =?utf-8?Q?jgbRKd6UdLChsvlI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BB704C625429249BA46BCB7FC0FFF43@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c59c07-57e8-48a0-5535-08ded66ebd94
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 06:13:44.8003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r865Y4Wf7uvNwVza1WauEP2Pr4ptCfqskXx+Oa9aj5kzsjcL492v1hht3BOPCyQD9qFnAktVMwaY7yu8sGFBTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989259

T24gMjcvNi8yMDI2IDE6MTEgYW0sIFh1IFlpbHVuIHdyb3RlOg0KPiBbWW91IGRvbid0IG9mdGVu
IGdldCBlbWFpbCBmcm9tIHlpbHVuLnh1QGxpbnV4LmludGVsLmNvbS4gTGVhcm4gd2h5IHRoaXMg
aXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNh
dGlvbiBdDQo+IA0KPj4gQEAgLTE5NSwyMCArMTk1LDIwIEBAIHN0YXRpYyBpbnQgczEwX29wc193
cml0ZV9pbml0KHN0cnVjdCBmcGdhX21hbmFnZXIgKm1nciwNCj4+ICAgICAgICByZXQgPSBzMTBf
c3ZjX3NlbmRfbXNnKHByaXYsIENPTU1BTkRfUkVDT05GSUcsDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmY3R5cGUsIHNpemVvZihjdHlwZSkpOw0KPj4gICAgICAgIGlmIChyZXQg
PCAwKQ0KPj4gLSAgICAgICAgICAgICBnb3RvIGluaXRfZG9uZTsNCj4+ICsgICAgICAgICAgICAg
Z290byBpbml0X2Vycm9yOw0KPj4NCj4+ICAgICAgICByZXQgPSB3YWl0X2Zvcl9jb21wbGV0aW9u
X3RpbWVvdXQoDQo+PiAgICAgICAgICAgICAgICAmcHJpdi0+c3RhdHVzX3JldHVybl9jb21wbGV0
aW9uLCBTMTBfUkVDT05GSUdfVElNRU9VVCk7DQo+PiAgICAgICAgaWYgKCFyZXQpIHsNCj4+ICAg
ICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAidGltZW91dCB3YWl0aW5nIGZvciBSRUNPTkZJR19S
RVFVRVNUXG4iKTsNCj4+ICAgICAgICAgICAgICAgIHJldCA9IC1FVElNRURPVVQ7DQo+PiAtICAg
ICAgICAgICAgIGdvdG8gaW5pdF9kb25lOw0KPj4gKyAgICAgICAgICAgICBnb3RvIGluaXRfZXJy
b3I7DQo+PiAgICAgICAgfQ0KPj4NCj4+ICAgICAgICByZXQgPSAwOw0KPiANCj4gV2h5IHJlLWlu
aXRpYWxpemUgcmV0IGhlcmU/DQo+IA0KDQpUaGF0IHdhcyBjbGVhcmluZyB0aGUgcmVtYWluaW5n
IGppZmZpZXMgbGVmdCBpbiByZXQgYnkgDQp3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoKS4g
SSdsbCBkcm9wIGl0IGJ5IG5vdCBhc3NpZ25pbmcgdGhlIHdhaXQgDQpyZXN1bHQgdG8gcmV0Lg0K
DQo+PiAgICAgICAgaWYgKCF0ZXN0X2FuZF9jbGVhcl9iaXQoU1ZDX1NUQVRVU19PSywgJnByaXYt
PnN0YXR1cykpIHsNCj4+ICAgICAgICAgICAgICAgIHJldCA9IC1FVElNRURPVVQ7DQo+PiAtICAg
ICAgICAgICAgIGdvdG8gaW5pdF9kb25lOw0KPj4gKyAgICAgICAgICAgICBnb3RvIGluaXRfZXJy
b3I7DQo+PiAgICAgICAgfQ0KPj4NCj4+ICAgICAgICAvKiBBbGxvY2F0ZSBidWZmZXJzIGZyb20g
dGhlIHNlcnZpY2UgbGF5ZXIncyBwb29sLiAqLw0KPj4gQEAgLTIxNiwxNiArMjE2LDE5IEBAIHN0
YXRpYyBpbnQgczEwX29wc193cml0ZV9pbml0KHN0cnVjdCBmcGdhX21hbmFnZXIgKm1nciwNCj4+
ICAgICAgICAgICAgICAgIGtidWYgPSBzdHJhdGl4MTBfc3ZjX2FsbG9jYXRlX21lbW9yeShwcml2
LT5jaGFuLCBTVkNfQlVGX1NJWkUpOw0KPj4gICAgICAgICAgICAgICAgaWYgKElTX0VSUihrYnVm
KSkgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICBzMTBfZnJlZV9idWZmZXJzKG1ncik7DQo+
PiAtICAgICAgICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihrYnVmKTsNCj4+IC0gICAgICAg
ICAgICAgICAgICAgICBnb3RvIGluaXRfZG9uZTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBy
ZXQgPSAtRU5PTUVNOw0KPiANCj4gV2h5IGNoYW5nZSB0aGUgcmV0Pw0KPiANCg0KVGhhdCB3YXMg
dW5yZWxhdGVkIGNodXJuLiAgSSdsbCByZXZlcnQgdG8gUFRSX0VSUihrYnVmKS4NCg0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gaW5pdF9lcnJvcjsNCj4+ICAgICAgICAgICAgICAgIH0N
Cj4+DQo+PiAgICAgICAgICAgICAgICBwcml2LT5zdmNfYnVmc1tpXS5idWYgPSBrYnVmOw0KPj4g
ICAgICAgICAgICAgICAgcHJpdi0+c3ZjX2J1ZnNbaV0ubG9jayA9IDA7DQo+PiAgICAgICAgfQ0K
Pj4NCj4+IC1pbml0X2RvbmU6DQo+PiArICAgICBnb3RvIGluaXRfZG9uZTsNCj4gDQo+IEhhcHB5
IHBhdGg/IHdoeSBub3QganVzdCByZXR1cm4gMDsgQW5kIHlvdSBkb24ndCBuZWVkIGluaXRfZG9u
ZSBhdCBhbGwuDQo+IA0KDQpBZ3JlZWQuIEknbGwgdXNlIHJldHVybiAwIG9uIHN1Y2Nlc3MgYW5k
IGtlZXAgb25seSBpbml0X2Vycm9yIGZvciANCnN0cmF0aXgxMF9zdmNfZG9uZSgpICsgcmV0dXJu
IHJldC4NCg0KPj4gKw0KPj4gK2luaXRfZXJyb3I6DQo+PiAgICAgICAgc3RyYXRpeDEwX3N2Y19k
b25lKHByaXYtPmNoYW4pOw0KPj4gK2luaXRfZG9uZToNCj4+ICAgICAgICByZXR1cm4gcmV0Ow0K
Pj4gICB9DQoNCg==
