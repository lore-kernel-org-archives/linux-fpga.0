Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B7308F26;
	Wed, 24 Jun 2026 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271260; cv=fail; b=pPJLYWLxLBGMDT1GtfM4gEtUC5a+wcR4qETYIl+CpW5uEWzOkogRXo+eM3fNDaL4Rn4+8+PHgY/r4A7w3GelbqMbX+4ZwI5XYK8G1vonvZFG2AImRIpSY6r9XTvIo2wlaHqW/VqM3I/Z3z0aXLrENOkbESqa9SIDtjC7+UDviUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271260; c=relaxed/simple;
	bh=6iRyE75AMGSWh9Yof0S7Nl22O6tuT0Eti2fCJRgqynE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fwBNV1ZMMe1rk31NEgAtOQKaVJx4/IjrEHKc7ElHGHWRVf43frCFeN1lRx/1ExVi2DrgLL+Me0Y7CGbav20V9EMXnWl58lvxD8ErhgP1WSt7rYZ0uA+lvyYN6b29vHW/3D+9zzoDAPdas31wKRQR8Spx5l6lroVts84TjrF4luE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=L6Ki1K1x; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="L6Ki1K1x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKJaGMyygCPlm7EZ+97SUt4gMKSZZIBd2QYDaTklZ+NX781G40jN0MEpWlnGRnf0gzDfvhr1cE862DlX10FuE0bNKquXvFQ2wc0h4+kqfVDAMtbTWHj1ZerSTeEgXhAz+cEhcI6PU8JNXwhxBEq5TNoKhrajD2xLDH/7PMlhgFD0HMlQ4z2rZGI3c3yQr73evHICwh5I4iYsmlPhEBNZYkfJYWRsJlDrKCdQvgJPAHeD0D/qx96uPYADA+SmSsttPl3RbO/259eTSog6jecZdJ8tay19y1Xe5vkU2tq1Ylkhj1qEOF3Z7H4rb7fibi7h7FyIvHS1XL9e5b7jOBf9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iRyE75AMGSWh9Yof0S7Nl22O6tuT0Eti2fCJRgqynE=;
 b=rMIrgLdlduMD0L51fnrB9T7M4jTuyecwcksxZgS/STRY/6XaO73cWaPheZ1h6xvJDbGF8ry7uDmoVDonzEr4nyZXl35cON21M3BheeG9XLJPdgEiKMubidNtSP9htyQwfo6eD78OrfqLGApTBxyIi98bnQ3UTWw4FZmOAxQmKZbqmqK4MkSpguOEnJ6adxjKkSz+R8yy9tlAiA+LRmrCwcXa4VFxpaayt5RAJuu6WJ5UpolR1SkNFb0aJTSWOgedx9wKzd8vdEaHwnLqrUZlIqVDnOUM+QOykYGtaZa+trlVbRFOFZr+sLky/keKPvptrEyIuOPpY0CT7TeICB0F8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iRyE75AMGSWh9Yof0S7Nl22O6tuT0Eti2fCJRgqynE=;
 b=L6Ki1K1xjLuUUACRYGyOeEiFbUfR1oCRwO8I6ZUpT7fd1Lv8smIZc8bXzD8v9K6BVeQdZmEj6R/eMmckNvcZ9XmXLEdEPF7cBwu4xEBSdDQshBpTaJI/Hblt8KPvi3bG/e68i/RGfLPzsO6uetMt96Bz8wzJiyllcJ2G1R1PIZHAxHTaNBtMDRaAi3uyrNNNN2WChGRqr8D6sBqL5flBL62/aPgegDJ24pjaq8uDHgwQIxkkzCp2t52qV3WSqY7bFZ4V1d5sojGyRhOTPFDBb+Crkkxz5UNrCBOx7DN6lhOj19TFn8gE3BhBvi+j4XBjAyWAkNbIiTZwGpPptNuNAA==
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by LV0PR03MB989322.namprd03.prod.outlook.com (2603:10b6:408:393::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 03:20:57 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 03:20:56 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>
CC: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix
	<trix@redhat.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fpga: stratix10-soc: Fix SVC mailbox handling during
 reconfiguration
Thread-Topic: [PATCH] fpga: stratix10-soc: Fix SVC mailbox handling during
 reconfiguration
Thread-Index: AQHdAvVVetzF/rH2pEqxcT27AYhh9rZMT1AAgAC7tIA=
Date: Wed, 24 Jun 2026 03:20:56 +0000
Message-ID: <8d978dfd-08ed-4003-a744-458a82345756@altera.com>
References:
 <3fb9ad8196d00860f7d4aa2e0394a271f5ad0cec.1782208001.git.tze.yee.ng@altera.com>
 <da50ce16-f1a8-4d2e-8abd-ee9900644752@kernel.org>
In-Reply-To: <da50ce16-f1a8-4d2e-8abd-ee9900644752@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5950:EE_|LV0PR03MB989322:EE_
x-ms-office365-filtering-correlation-id: 0b5a163f-909c-4d32-070a-08ded19f9b30
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|18002099003|55112099003|6133799003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info:
 JkpaLsN5UIZ8/yqrwRMF0yUSpbVLFIP6qTpdHSPINvILS1gfzbl2l5SjlmcmWzCWM16Vfkw2zKNEHbyTZ155IYW/DCixWySXCfFWI8rteHIWY0+6luhh5MB6D9vlTCdLqL2EJUxNGx8JsN8JbP46N/AzNVDsfuLN1YkIhdmlSmUmnps6dilgCFTzLBUcQu3GrujVQ4w9ZJhTmYxExFcAEehNPWKd00zf/GOtw9qcSvxUACCHZ6+nAxwRpto7ZYWfR/upGNnSLu7zHUmTXCx2CdKIkCP5SS08yBCVsNnMBCE7vFECfZ3HEXwCq13H0b7QQKogc3XyGeIn5ECc2WrFpHAuDSS5OKSK3JyIVdb0DusxqryvWGze2MrDruChsuX5JcTKyToO1lqLx+34okLWgXMBKmKB5qvcXmeubweUemgwvyyE6hRa8PPYQigUUKs3zzD8+2hg6eZ/Yx1uwI+0e4IgYjzte1EQQLYIWXkyGBD/OVHdba/ufP6b8J6E7jtrGBXpo4ZM5rSo8ZPDG+20hc74Ol0wjaYWTxnZPa14lXeXFrY1yb08haIOw7DsRbYttxOUvYlcxPTqalnIiH+uXzcH4iOhmuAu0d815fODKEXixExha8c2FL924l7JnefsqKBp32jnEV7PvC8fx81oijatnVixjPftpxCJb0gXUZTRoD94AUMNge7x/YasslC36vLaQ58JyRqqF2PJhEj1utbjo+/IKX9TV4B9hgo/XuA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(18002099003)(55112099003)(6133799003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEZtQ09OZ3UwRUdXVE5RbE80Q2M2cjV3QXp0ZXNYbDhJeHo0SG5McndPQ3gv?=
 =?utf-8?B?NTdHMUREcWVCeGlUblZtYWhYSWdZa1ArS1NXSXpGSXJzU0ExVlhXaEcyaUkw?=
 =?utf-8?B?YUYzcE01eDlQTzFZT2FhVE9Ud09QZTByUG5jQ2NQZEdMaHFiWVlUZUNMaXZC?=
 =?utf-8?B?dzBycWxZT2xLc2ZTMmRpMFM4QlduZWhNeUlieFhYQlRnQkJ5QTZOWGhYUmtF?=
 =?utf-8?B?dG0yNkd1MnJXREtSQ0ZVSGd3dXEzQ3ZVRFUvWEx5aWZsYVZrSkpiUS9TMDFF?=
 =?utf-8?B?NDB6NFNTbzJLM0ZnblB1N3FBZmo4czZaYXQwbjFYa3hmOGVHNG5yU2lIcFQx?=
 =?utf-8?B?bjQ1TkQ4WFQ1R0VreVQ1VzE2Sm9tZ0RCSDhPaGlaUHVNKy93dEg5MnpxcCth?=
 =?utf-8?B?a1F0cnd4Q1lEN2s2NWNUSjNBcFlkV210RUR4c2drRGNvYm9leGxUS0U1WlRk?=
 =?utf-8?B?S2ExQjh5VFlGaEQyVjJoV29jYXpjU1RkdUhQVkZVK2tHU3ZmN00yaGFYaUV0?=
 =?utf-8?B?dFFiUnRZNHVpeFZhN1NwVzU4RnorNTd2cjFJOXJzWFRpOXJtVDZCRFB1bm1N?=
 =?utf-8?B?SjRaWWQvR1ZsMS9UbGw4MWEwUUEzSXlFU3ZkbTdEMkpxMkloSVM1UlBUUVha?=
 =?utf-8?B?YzVpQXMwcW91SlE2NHkyK0NWckNoVXd4Z0hBQlJ4MDZYNTduVEFCSzhrdkc0?=
 =?utf-8?B?TkR3TEFUQjdWN3AxOVNlR0lGVjJ6NEhRWFNSNGdabkJuN2luOUlFaEI2MXN5?=
 =?utf-8?B?VlVjK2IrTlhFTEJWdUdNVkhNbFJnWHJRUDNtREx0MVcrajZxai95a01hSWtz?=
 =?utf-8?B?U1U3cXhrbE1UZUY1OUN2YlpnWGVpV1ZNTEQxT1dWU2FRdXNHbVB0Q2t1cEN1?=
 =?utf-8?B?U0gxT05vdnhtQWVqQXpMOG84ZGhSYVRWc1NmenRsQXZ4OHRuN0tkUVFWNlhH?=
 =?utf-8?B?N0FsbFNuMm5uZ2xlVytYTUJOem1IbmNWK2lKUUNYTG01RW8zejBoNE1FTDBk?=
 =?utf-8?B?eFUxTmZMbnkwb0dSTDd3dlAvV3hERGMzUjBESFluR0dFbFRCRUZTMnY0eExv?=
 =?utf-8?B?Um03bXdHQmhYWDkrVmR1R2ZXNEFMRTF2RzNGRGpvWWp4MUo2WG45SmpYM09o?=
 =?utf-8?B?TmxCb3VJSzl2QS9kWURyQ1hZeGtRMjhsN24vRWk2VmJiK0E1VVo4MFZ2VGpU?=
 =?utf-8?B?MnVJTlFuaDhxL0VweUZhQlBzWGVjVHk5ZkVJczVrYzdZenF1Z3FaL1IzaXRB?=
 =?utf-8?B?a29VbnVFOU0xZ1A2ZEkvWW1CTStiZURWUlUyK2lIV0FuVlFXZjRwQktFM1l6?=
 =?utf-8?B?dU5PSkhJNWJCbmlYaVhraWNadm96WVBLVWFxSnNOQi90OGw2Qi9oWWZDamZJ?=
 =?utf-8?B?bjN0VSs4MEtSbjk5OHlqemYzaWppcG10RXliYXJLejBhb2JRRTRoeTBHYi9m?=
 =?utf-8?B?RElBQThBbkhmcS84amVsQmYxdS9hNk1Xc3JjdEtHMHEzMGpNSFZGNmoxMnRB?=
 =?utf-8?B?YWpJSnBUK0FrNHZacVlsL000cmtXMGJ0K1VWSERJK0duakRwTkd3M25SUmhv?=
 =?utf-8?B?d1A3ZE5OMUdJWHFCaDd3ay9OdWJkNmZtU0dPbDFwdDVzR05ySmxySnhZZDRh?=
 =?utf-8?B?V2NWeFBPR0VHMDB2OC9XWEUxWm5PYTFtVjBvaDh0MGU2UkpFcGxTZVFwcm5F?=
 =?utf-8?B?RThjSE1kNzF6ZTVSU25NejFVNHRLK0NUMnJoN3NiWEpPSG11dkhNR043NXd3?=
 =?utf-8?B?eXpYVmFRcllNbjdRUjRvL2JTc1F6TzJNeXU0Ry9wK3YrWFR2OU9taEViV0xY?=
 =?utf-8?B?R09VTk85R3IvMTRzb3ZacFU0ZHV3aVBCUHpJVkQ5bUhRd2t3UXh3RUQxeGo4?=
 =?utf-8?B?RlJhaXdIRXBuTlFGZllCOE4xSmRoVGwxaFFGM0l5Snh6T0Q0cnRobkJwQjIw?=
 =?utf-8?B?VXNBMCtvSlY2anJOK1dkSnN3VDFNTTk2bEE3cU9NZkRpTmNGTnBKWkpQSzdp?=
 =?utf-8?B?bDZxZDhSTzZDWGtqNFNtQ1hvOURVNnZ5L0dJWHJwNXphZDJZc3ViZWVvMTBM?=
 =?utf-8?B?SnNOMTBlNk5LVGx4MFJHdEVrd0lyOTFyc054Sjh4TUF5NUREY0pwWktvQkFv?=
 =?utf-8?B?SWpyOWd0L0t3TGx2YzFheUJWMmFLZ1o1RWxSM3BreDNWN1EyVVdFcVdMelVQ?=
 =?utf-8?B?Yjd4cUdkdDYrOGc3Z1lJaEpwZGIrZUd3NUxVUytVTit5aXJaZHE0dmtwd1ps?=
 =?utf-8?B?a0FmYm92L3k3MXMzTXpIM2pMcWJuSVVrTE4wd1J6dFJoU2RzUHVaMjFwaXpq?=
 =?utf-8?B?aUduRTl2eHhFTThNWk5jZUJyUHB1QVhXUkRVTWRQUWZ6cHNnQkVXcHBTR1g4?=
 =?utf-8?Q?J787A9tWeB/y8fB4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F2A7E876EE4064AB2774A82879378C2@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5a163f-909c-4d32-070a-08ded19f9b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 03:20:56.6416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rY8CZd6M+NkfbJCnzIycSoIMxeZH6FBZdKX2crmvFLGpIhQfJr/Eryb2GmnRUt7jGwyfQxHOz0nuTwH+ungH8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR03MB989322

T24gMjQvNi8yMDI2IDEyOjA5IGFtLCBEaW5oIE5ndXllbiB3cm90ZToNCj4gDQo+IA0KPiBPbiA2
LzIzLzI2IDA0OjQ3LCB0emUueWVlLm5nQGFsdGVyYS5jb20gd3JvdGU6DQo+PiBGcm9tOiBUaWVu
IFN1bmcgQW5nIDx0aWVuLnN1bmcuYW5nQGFsdGVyYS5jb20+DQo+Pg0KPj4gRml4IGluY29ycmVj
dCBzdHJhdGl4MTBfc3ZjX2RvbmUoKSB1c2FnZSBkdXJpbmcgRlBHQSByZWNvbmZpZ3VyYXRpb24u
DQo+IA0KPiBEbyB5b3UgbmVlZCBhIEZpeGVzIHRhZyBhbmQgQ2M6IHN0YWJsZSB0aGVuPw0KPiAN
Clllcy4gVGhlIGluY29ycmVjdCBzdHJhdGl4MTBfc3ZjX2RvbmUoKSBjYWxsIGluIHdyaXRlX2lu
aXQoKSBoYXMgYmVlbiANCnRoZXJlIHNpbmNlIHRoZSBkcml2ZXIgd2FzIGZpcnN0IGFkZGVkLiBJ
J2xsIGFkZCB0aGUgZm9sbG93aW5nIGZpeGVzIHRhZyANCmluIHYyOg0KDQpGaXhlczogZTdlZWYx
ZDc2MzNhICgiZnBnYTogYWRkIGludGVsIHN0cmF0aXgxMCBzb2MgZnBnYSBtYW5hZ2VyIGRyaXZl
ciIpDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDUuMSsNCj4+DQo+PiBEbyBub3QgY2Fs
bCBzdHJhdGl4MTBfc3ZjX2RvbmUoKSBhdCB0aGUgZW5kIG9mIHdyaXRlX2luaXQoKSBvbiANCj4+
IHN1Y2Nlc3MsIHNvDQo+PiB0aGUgU1ZDIHNlc3Npb24gcmVtYWlucyBhY3RpdmUgdGhyb3VnaCB3
cml0ZSgpIGFuZCB3cml0ZV9jb21wbGV0ZSgpLiBDYWxsDQo+PiBzdHJhdGl4MTBfc3ZjX2RvbmUo
KSBvbiBmYWlsdXJlIGluIHdyaXRlX2luaXQoKSBhbmQgd3JpdGUoKSBzbyB0aGUgc2hhcmVkDQo+
PiBTVkMgbWFpbGJveCBpcyByZWxlYXNlZCB3aGVuIHJlY29uZmlndXJhdGlvbiBhYm9ydHMsIGFs
bG93aW5nIGNvZXhpc3RlbmNlDQo+PiB3aXRoIG90aGVyIFNWQyBjbGllbnRzIHN1Y2ggYXMgc29j
NjQtaHdtb24uDQo+Pg0KPiANCg0K
