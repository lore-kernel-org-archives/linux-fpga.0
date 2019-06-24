Return-Path: <SRS0=qFw+=UX=axentia.se=peda@kernel.org>
Return-Path: <SRS0=qFw+=UX=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 13/28] drivers: Introduce
 class_find_device_by_of_node() helper
Date: Mon, 24 Jun 2019 14:07:50 +0000
Message-ID: <528dcb2e-3611-00a7-abb2-cc18001f4f8f@axentia.se>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-14-git-send-email-suzuki.poulose@arm.com>
 <325e46fd-a480-78ed-81fd-55e993fbc06f@axentia.se>
 <5cf1a8e2-bb1e-b6bc-32fe-93db0a6b5efd@arm.com>
In-Reply-To: <5cf1a8e2-bb1e-b6bc-32fe-93db0a6b5efd@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <72F156B1EDA57447A18381C603F9D997@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: Suzuki K Poulose <suzuki.poulose@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "rafael@kernel.org" <rafael@kernel.org>, "atull@kernel.org" <atull@kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, "andrew@lunn.ch" <andrew@lunn.ch>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "jslaby@suse.com" <jslaby@suse.com>
List-ID: <linux-fpga@vger.kernel.org>

T24gMjAxOS0wNi0yNCAxMDozNCwgU3V6dWtpIEsgUG91bG9zZSB3cm90ZToNCj4gSGkgUGV0ZXIs
DQo+IA0KPiBPbiAyMi8wNi8yMDE5IDA2OjI1LCBQZXRlciBSb3NpbiB3cm90ZToNCj4+IE9uIDIw
MTktMDYtMTQgMTk6NTQsIFN1enVraSBLIFBvdWxvc2Ugd3JvdGU6DQo+Pj4gQWRkIGEgd3JhcHBl
ciB0byBjbGFzc19maW5kX2RldmljZSgpIHRvIHNlYXJjaCBmb3IgYSBkZXZpY2UNCj4+PiBieSB0
aGUgb2Zfbm9kZSBwb2ludGVyLCByZXVzaW5nIHRoZSBnZW5lcmljIG1hdGNoIGZ1bmN0aW9uLg0K
Pj4+IEFsc28gY29udmVydCB0aGUgZXhpc3RpbmcgdXNlcnMgdG8gbWFrZSB1c2Ugb2YgdGhlIG5l
dyBoZWxwZXIuDQo+Pj4NCj4+PiBDYzogQWxhbiBUdWxsIDxhdHVsbEBrZXJuZWwub3JnPg0KPj4+
IENjOiBNb3JpdHogRmlzY2hlciA8bWRmQGtlcm5lbC5vcmc+DQo+Pj4gQ2M6IGxpbnV4LWZwZ2FA
dmdlci5rZXJuZWwub3JnDQo+Pj4gQ2M6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQo+
Pj4gQ2M6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4+PiBDYzogRmxvcmlhbiBG
YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQo+Pj4gQ2M6IEhlaW5lciBLYWxsd2VpdCA8
aGthbGx3ZWl0MUBnbWFpbC5jb20+DQo+Pj4gQ2M6ICJEYXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBk
YXZlbWxvZnQubmV0Pg0KPj4+IENjOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+Pj4g
Q2M6IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+DQo+Pj4gQ2M6IEdyZWcgS3Jv
YWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+Pj4gQ2M6ICJSYWZhZWwg
Si4gV3lzb2NraSIgPHJhZmFlbEBrZXJuZWwub3JnPg0KPj4+IENjOiBKaXJpIFNsYWJ5IDxqc2xh
YnlAc3VzZS5jb20+DQo+Pj4gQWNrZWQtYnk6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9y
Zz4NCj4+PiBSZXZpZXdlZC1ieTogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPj4+IFJl
dmlld2VkLWJ5OiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KPj4NCj4+IFdob29vYSEg
SSByZXZpZXdlZCBvbmx5IHRoZSBkcml2ZXJzL211eC9jb3JlLmMgY2hhbmdlcyB3aGVuIHRoaXMg
d2FzIGRvbmUNCj4+IGluIGEgc2VyaWVzIG9mIG11Y2ggc21hbGxlciBwYXRjaGVzLiBUaGlzIHRh
ZyBtYWtlcyBpdCBzZWVtIGFzIGlmIEkgaGF2ZQ0KPj4gcmV2aWV3ZWQgdGhlIHdob2xlIHRoaW5n
LCB3aGljaCBJIGhhZCBub3QgZG9uZSB3aGVuIHlvdSBhZGRlZCB0aGlzIHRhZyBvdXQNCj4+IG9m
IHRoZSBibHVlLg0KPiANCj4gQXBvbG9naWVzIGZvciB0aGUgc3VycHJpc2UuIFRoZSBwYXRjaCB3
YXMgc2ltcGx5IHNxdWFzaGVkIHdpdGggdGhlIGNoYW5nZSB0aGF0DQo+IGludHJvZHVjZWQgdGhl
ICJoZWxwZXIiIHRvIGJldHRlciBhaWQgdGhlIHJldmlld2VycywgYmFzZWQgb24gc3VnZ2VzdGlv
bnMgb24gdGhlDQo+IGxpc3QuIEkga2VwdCB5b3VyIHRhZ3MsIG9ubHkgYmVjYXVzZSB0aGVyZSB3
ZXJlIG5vIGNoYW5nZXMsIGJ1dCBzb21lIGFkZGl0aW9uYWwNCj4gY29udGV4dCBvbiB0aGUgY29y
ZSBkcml2ZXIuDQoNCllvdSBjb3VsZCBlLmcuIGhhdmUgd3JpdHRlbjoNCg0KCS4uLg0KCVtGb3Ig
dGhlIGRyaXZlcnMvbXV4L2NvcmUuYyBwYXJ0XQ0KCVJldmlld2VkLWJ5OiBQZXRlciBSb3NpbiA8
cGVkYUBheGVudGlhLnNlPg0KCS4uLg0KDQo+Pg0KPj4gTm93LCB0aGlzIHN0dWZmIGlzIHRyaXZp
YWwgYW5kIGJ5IG5vdyBJIGhhdmUgbG9va2VkIGF0IHRoZSBvdGhlciBmaWxlcw0KPj4gYW5kIGl0
IGFsbCBzZWVtcyBzaW1wbGUgZW5vdWdoLiBTbywgeW91IGNhbiBrZWVwIHRoZSB0YWcsIGJ1dCBp
dCBpcyBOT1QNCj4+IG9rIHRvIGhhbmRsZSB0YWdzIGxpa2UgeW91IGhhdmUgZG9uZSBoZXJlLg0K
PiANCj4gU3VyZSwgSSB3aWxsIGtlZXAgdGhhdCBpbiBtaW5kLg0KDQpHcmVhdCENCg0KQ2hlZXJz
LA0KUGV0ZXINCg==
