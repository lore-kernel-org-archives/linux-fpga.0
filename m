Return-Path: <SRS0=vZNt=XZ=analog.com=Nuno.Sa@kernel.org>
Return-Path: <SRS0=vZNt=XZ=analog.com=Nuno.Sa@kernel.org>
From: "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: Re: [PATCH 1/3] include: fpga: adi-axi-common: Define version macros
Date: Mon, 30 Sep 2019 10:46:38 +0000
Message-ID: <a9f4640768627fc17ff220996afd6d4b63de2505.camel@analog.com>
References: <20190926103925.194973-1-nuno.sa@analog.com>
	 <20190926103925.194973-2-nuno.sa@analog.com>
	 <20190927150114.GA2146@archbox>
In-Reply-To: <20190927150114.GA2146@archbox>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A5239448FFA24429C1EE1EBC1387637@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: "mdf@kernel.org" <mdf@kernel.org>
Cc: "linux@roeck-us.net" <linux@roeck-us.net>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "jdelvare@suse.com" <jdelvare@suse.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

SGkgTW9yaXR6LA0KDQpPbiBGcmksIDIwMTktMDktMjcgYXQgMDg6MDEgLTA3MDAsIE1vcml0eiBG
aXNjaGVyIHdyb3RlOg0KPiANCj4gSGkgTnVubywNCj4gDQo+IE9uIFRodSwgU2VwIDI2LCAyMDE5
IGF0IDEyOjM5OjIzUE0gKzAyMDAsIE51bm8gU8OhIHdyb3RlOg0KPiA+IEFkZCBjb21tb20gbWFj
cm9zIHRvICJwYXJzZSIgQURJIEhETCBjb3JlcyB2ZXJzaW9uLCBpbiB0ZXJtcyBvZg0KPiA+IG1h
am9yLCBtaW5vciBhbmQgcGF0Y2guDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6Eg
PG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9saW51eC9mcGdhL2Fk
aS1heGktY29tbW9uLmggfCA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZwZ2EvYWRpLWF4aS1j
b21tb24uaA0KPiA+IGIvaW5jbHVkZS9saW51eC9mcGdhL2FkaS1heGktY29tbW9uLmgNCj4gPiBp
bmRleCA3ZmM5NWQ1Yzk1YmIuLjViYzU2MDNlNmJjOCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L2ZwZ2EvYWRpLWF4aS1jb21tb24uaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvZnBn
YS9hZGktYXhpLWNvbW1vbi5oDQo+ID4gQEAgLTE2LDQgKzE2LDggQEANCj4gPiAgI2RlZmluZSBB
RElfQVhJX1BDT1JFX1ZFUihtYWpvciwgbWlub3IsIHBhdGNoKQlcDQo+ID4gIAkoKChtYWpvcikg
PDwgMTYpIHwgKChtaW5vcikgPDwgOCkgfCAocGF0Y2gpKQ0KPiA+ICANCj4gPiArI2RlZmluZSBB
RElfQVhJX1BDT1JFX1ZFUl9NQUpPUih2ZXJzaW9uKQkoKCh2ZXJzaW9uKSA+PiAxNikgJg0KPiA+
IDB4ZmYpDQo+ID4gKyNkZWZpbmUgQURJX0FYSV9QQ09SRV9WRVJfTUlOT1IodmVyc2lvbikJKCgo
dmVyc2lvbikgPj4gOCkgJg0KPiA+IDB4ZmYpDQo+ID4gKyNkZWZpbmUgQURJX0FYSV9QQ09SRV9W
RVJfUEFUQ0godmVyc2lvbikJKCh2ZXJzaW9uKSAmIDB4ZmYpDQo+ID4gKw0KPiA+ICAjZW5kaWYg
LyogQURJX0FYSV9DT01NT05fSF8gKi8NCj4gPiAtLSANCj4gPiAyLjIzLjANCj4gPiANCj4gDQo+
IFdoaWxlIGltcGxlbWVudGVkIGluIGFuIEZQR0EgSSdtIG5vdCBzdXJlIGlmIHRoaXMgbmVlZHMg
dG8gZ28gaW50bw0KPiBpbmNsdWRlbGludXgvZnBnYS8uDQo+IA0KPiBJJ2Qgc3VnZ2VzdCB0byBh
ZGQgdGhpcyB0byB0aGUgYWN0dWFsIGRyaXZlciBmb3Igbm93LCBhbmQgb25jZSB5b3UNCj4gaGF2
ZQ0KPiBtdWx0aXBsZSB1c2VycyB5b3UgY2FuIGZpbmQgYSBjb21tb24gbG9jYXRpb24uDQoNCldp
bGwgZG8gdGhhdC4NCg0KPiBDaGVlcnMsDQo+IE1vcml0eg0KDQpUaGFua3MhDQpOdW5vIFPDoQ0K
DQo=
