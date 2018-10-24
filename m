Return-Path: <SRS0=5rKg=NE=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=5rKg=NE=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr730082.outbound.protection.outlook.com ([40.107.73.82]:10784
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbeJXO7K (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Oct 2018 10:59:10 -0400
From: Nava kishore Manne <navam@xilinx.com>
Subject: RE: [PATCH 0/3] Add Bitstream configuration support for ZynqMP
Date: Wed, 24 Oct 2018 06:32:21 +0000
Message-ID: <BYAPR02MB4710AD8C0FD51D14A7A40395C2F60@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
 <CANk1AXTUu=qiko9_sLrxrNxBmX7p0OXVxNN13p1uBirNh+Ymtw@mail.gmail.com>
In-Reply-To: <CANk1AXTUu=qiko9_sLrxrNxBmX7p0OXVxNN13p1uBirNh+Ymtw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michal Simek <michals@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, kishore m <chinnikishore369@gmail.com>

SGkgQWxhbiwNCg0KVGhhbmtzIGZvciB0aGUgcmVwbHkuLi4NClBsZWFzZSBmaW5kIG15IHJlc3Bv
bnNlIGlubGluZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGFu
IFR1bGwgW21haWx0bzphdHVsbEBrZXJuZWwub3JnXQ0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIg
MjIsIDIwMTggOToyOSBQTQ0KPiBUbzogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZhbUB4aWxpbngu
Y29tPg0KPiBDYzogTW9yaXR6IEZpc2NoZXIgPG1kZkBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcg
PHJvYmgrZHRAa2VybmVsLm9yZz47DQo+IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5j
b20+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+IFJhamFuIFZhamEgPFJB
SkFOVkB4aWxpbnguY29tPjsgSm9sbHkgU2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+OyBsaW51eC0N
Cj4gZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IG9wZW4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORCBGTEFU
VEVORUQgREVWSUNFDQo+IFRSRUUgQklORElOR1MgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
PjsgbW9kZXJhdGVkDQo+IGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJNIEFSQ0hJVEVD
VFVSRSA8bGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IGxpbnV4LWtl
cm5lbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IGtpc2hvcmUgbSA8Y2hpbm5p
a2lzaG9yZTM2OUBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8zXSBBZGQgQml0
c3RyZWFtIGNvbmZpZ3VyYXRpb24gc3VwcG9ydCBmb3IgWnlucU1QDQo+IA0KPiBPbiBGcmksIE9j
dCAxOSwgMjAxOCBhdCAzOjQ5IEFNIE5hdmEga2lzaG9yZSBNYW5uZQ0KPiA8bmF2YS5tYW5uZUB4
aWxpbnguY29tPiB3cm90ZToNCj4gDQo+IEhpIE5hdmEsDQo+IA0KPiA+DQo+ID4gVGhpcyBzZXJp
ZXMgb2YgcGF0Y2hlcyBhcmUgY3JlYXRlZCBPbiB0b3Agb2YgdGhlIGJlbG93IHJlcG8uDQo+ID4g
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXJtL2FybS1zb2MuZ2l0
DQo+ID4gQlJBTkNIOiBuZXh0L2RyaXZlcnMuDQo+IA0KPiBJSVVDIHRoaXMgaXMgZGVwZW5kZW50
IG9uIHNvbWUgcGF0Y2hlcyB0aGF0IGFyZW4ndCByZWxlYXNlZCB5ZXQuDQo+IFBsZWFzZSBtYWtl
IHRoaXMgZXhwbGljaXQgYnkgc3BlY2lmeWluZyB3aGljaCBwYXRjaGVzIHRoaXMgaXMgZGVwZW5k
ZW50IG9uIGluDQo+IGVhY2ggZnV0dXJlIHN1Ym1pc3Npb24gb2YgbmV3IHZlcnNpb25zLiAgSXQg
d2lsbCBoZWxwIHNvIHRoYXQgSSBkb24ndCBzZW5kIHRoZXNlDQo+IHVwc3RyZWFtIHByZW1hdHVy
ZWx5IGFuZCBpbnRyb2R1Y2UgYnVpbGQgYnJlYWtzLiAgT2YgY291cnNlLCB3ZSBjYW4ga2VlcA0K
PiByZXZpZXdpbmchDQo+IA0KDQpUaGlzIGRyaXZlciBkZXBlbmRzIG9uIHRoZSBiZWxvdyBzZXJp
ZXMgb2YgcGF0Y2hlcw0KaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvOS8xMi85ODMgDQpXaGlj
aCBpcyBnb3QgaW50ZWdyYXRlZCBpbnRvIHRoZSBiZWxvdyB1cHN0cmVhbSByZXBvLg0KaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXJtL2FybS1zb2MuZ2l0
L3RyZWUvZHJpdmVycy9maXJtd2FyZS94aWxpbng/aD1mb3ItbmV4dCANCkkgaG9wZSBhcm0gbWFp
bnRhaW5lcnMgd2lsbCBzZW5kIHRoZSBwdWxsLXJlcXVlc3QgaW4gc29vbiB0byBpbnRlZ3JhdGUg
dGhlc2UgcGF0Y2hlcyB3aXRoIG1haW4gcmVwby4NCldpbGwgYWRkIHRoZSByZXF1aXJlZCBpbmZv
IGZvciB0aGUgZGVwZW5kZW50IHBhdGNoZXMgaW4gcy1vLWIgc2VjdGlvbiANCg0KUmVnYXJkcywN
Ck5hdmFraXNob3JlLg0K
