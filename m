Return-Path: <SRS0=p2be=SL=xilinx.com=navam@kernel.org>
Return-Path: <SRS0=p2be=SL=xilinx.com=navam@kernel.org>
From: Nava kishore Manne <navam@xilinx.com>
Subject: RE: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Date: Tue, 9 Apr 2019 06:50:04 +0000
Message-ID: 
 <BYAPR02MB4710E78DF9B6AD580CEA963EC22D0@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20190402123123.915-1-nava.manne@xilinx.com>
 <20190402123123.915-4-nava.manne@xilinx.com>
 <CANk1AXQEMLt5Vk9LhsmBg9U0Twknr1oy-myoL_0vZ4pqSu3DwQ@mail.gmail.com>
 <BYAPR02MB47101CD56BDF0B314BA37062C22C0@BYAPR02MB4710.namprd02.prod.outlook.com>
 <CANk1AXSXAfNky3adaWOrU3qn=JiEX=a25MFg6fimVjXPKvwOMg@mail.gmail.com>
 <d425bd61-238b-f085-f450-d052349878a8@xilinx.com>
 <20190408165109.GA6459@archbook>
 <CANk1AXQ5mHr0ZTuRoby3GomKbbQxv8z-O=o83VV=mXTh1aUZZA@mail.gmail.com>
In-Reply-To: 
 <CANk1AXQ5mHr0ZTuRoby3GomKbbQxv8z-O=o83VV=mXTh1aUZZA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc: Michal Simek <michals@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "ARM/FREESCALE IMX / MXC ARM ARCHITECTURE  <linux-arm-kernel@lists.infradead.org>, linux-kernel" <linux-kernel@vger.kernel.org>, kishore m <chinnikishore369@gmail.com>
List-ID: <linux-fpga@vger.kernel.org>

SGkgQWxhbiwNCg0KVGhhbmtzIGZvciB0aGUgcmVzcG9uc2UuDQpQbGVhc2UgZmluZCBteSByZXNw
b25zZSBpbmxpbmUuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxh
biBUdWxsIFttYWlsdG86YXR1bGxAa2VybmVsLm9yZ10NCj4gU2VudDogVHVlc2RheSwgQXByaWwg
OSwgMjAxOSAxOjU3IEFNDQo+IFRvOiBNb3JpdHogRmlzY2hlciA8bWRmQGtlcm5lbC5vcmc+DQo+
IENjOiBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IE5hdmEga2lzaG9yZSBNYW5u
ZQ0KPiA8bmF2YW1AeGlsaW54LmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+
OyBNYXJrIFJ1dGxhbmQNCj4gPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgUmFqYW4gVmFqYSA8UkFK
QU5WQHhpbGlueC5jb20+OyBKb2xseSBTaGFoDQo+IDxKT0xMWVNAeGlsaW54LmNvbT47IGxpbnV4
LWZwZ2FAdmdlci5rZXJuZWwub3JnOyBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRQ0KPiBBTkQgRkxB
VFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47
DQo+IG1vZGVyYXRlZCBsaXN0OkFSTS9GUkVFU0NBTEUgSU1YIC8gTVhDIEFSTSBBUkNISVRFQ1RV
UkUgPGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBsaW51eC1rZXJu
ZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBraXNob3JlIG0gPGNoaW5uaWtp
c2hvcmUzNjlAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDMvM10gZnBnYSBt
YW5hZ2VyOiBBZGRpbmcgRlBHQSBNYW5hZ2VyIHN1cHBvcnQgZm9yDQo+IFhpbGlueCB6eW5xbXAN
Cj4gDQo+IE9uIE1vbiwgQXByIDgsIDIwMTkgYXQgMTE6NTEgQU0gTW9yaXR6IEZpc2NoZXIgPG1k
ZkBrZXJuZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IEhpIE1pY2hhbCwNCj4gPg0KPiA+IE9uIE1v
biwgQXByIDA4LCAyMDE5IGF0IDA0OjM2OjE1UE0gKzAyMDAsIE1pY2hhbCBTaW1layB3cm90ZToN
Cj4gPiA+IE9uIDA4LiAwNC4gMTkgMTY6MTcsIEFsYW4gVHVsbCB3cm90ZToNCj4gPiA+ID4gT24g
TW9uLCBBcHIgOCwgMjAxOSBhdCA3OjM5IEFNIE5hdmEga2lzaG9yZSBNYW5uZQ0KPiA8bmF2YW1A
eGlsaW54LmNvbT4gd3JvdGU6DQo+ID4gPiA+Pg0KPiA+ID4gPj4gSGkgQWxhbiwNCj4gPiA+ID4+
DQo+ID4gPiA+PiBUaGFua3MgZm9yIGxvb2sgaW50byBpdCBhbmQgcHJvdmlkaW5nIHRoZSBBQ0su
DQo+ID4gPiA+PiBJIGdvdCBvbmUgbWlub3IgY29tbWVudHMgZnJvbSBNb3JpdHogRmlzY2hlciBk
byB5b3Ugd2FudCBtZSBmaXggdGhhdA0KPiBpc3N1ZSBub3cgb3IgSSBjYW4gZml4IGl0IGxhdGVy
IGFzIGl04oCZcyBhIG1pbm9yIGNvbW1lbnQ/DQo+ID4gPiA+DQo+ID4gPiA+IFBsZWFzZSBmaXgg
Zm9yIE1vcml0eiBjb21tZW50Lg0KV2lsbCBmaXggaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KUmVn
YXJkcywNCk5hdmFraXNob3JlLg0K
