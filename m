Return-Path: <SRS0=Ciit=ND=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=Ciit=ND=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:42112
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbeJWTRB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 23 Oct 2018 15:17:01 -0400
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] zynq-fpga: Only route PR via PCAP when required
Date: Tue, 23 Oct 2018 10:53:50 +0000
Message-ID: <1781ed23-e03c-f70a-ea8c-3e9fa6eec9d4@topic.nl>
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
 <20181023090119.GA2205@archbook>
In-Reply-To: <20181023090119.GA2205@archbook>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <450E8440B1618648986F985171A6A78C@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Moritz Fischer <mdf@kernel.org>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "atull@kernel.org" <atull@kernel.org>

T24gMjMtMTAtMTggMTE6MDEsIE1vcml0eiBGaXNjaGVyIHdyb3RlOg0KPiBIaSBNaWtlLA0KPiAN
Cj4gc2VlbXMgbGlrZSBhIGdvb2QgdXNlY2FzZSAodGhvdWdoIHVuY29tbW9uKSwgcXVlc3Rpb24g
YmVsb3cNCg0KVXNlY2FzZXMgZm9yIElDQVA6DQotIEl0J3MgY29uc2lkZXJhYmx5IGZhc3RlciB0
aGFuIFBDQVANCi0gU2VsZi1yZXBhaXJpbmcgbG9naWMgKGUuZy4gc2luZ2xlLWV2ZW50IHVwc2V0
cykNCi0gQmVpbmcgcHJvZ3JhbW1lZCBmcm9tIGEgcmVtb3RlIEZQR0ENCi0gUHJvZ3JhbW1pbmcg
dGhyb3VnaCBhbm90aGVyIGJ1cyAoZS5nLiBQQ0llKQ0KDQoNCj4gDQo+IE9uIFR1ZSwgT2N0IDIz
LCAyMDE4IGF0IDA4OjMxOjE5QU0gKzAyMDAsIE1pa2UgTG9vaWptYW5zIHdyb3RlOg0KPj4gVGhl
IFhpbGlueCBaeW5xIEZQR0EgZHJpdmVyIHRha2VzIG93bmVyc2hpcCBvZiB0aGUgUFIgaW50ZXJm
YWNlLCBtYWtpbmcNCj4+IGl0IGltcG9zc2libGUgdG8gdXNlIHRoZSBJQ0FQIGludGVyZmFjZSBm
b3IgcGFydGlhbCByZWNvbmZpZ3VyYXRpb24uDQo+Pg0KPj4gVGhpcyBwYXRjaCBjaGFuZ2VzIHRo
ZSBkcml2ZXIgdG8gb25seSBhY3RpdmF0ZSBQUiBvdmVyIFBDQVAgd2hpbGUgdGhlDQo+PiBkZXZp
Y2UgaXMgYWN0aXZlbHkgYmVpbmcgYWNjZXNzZWQgYnkgdGhlIGRyaXZlciBmb3IgcHJvZ3JhbW1p
bmcuDQo+Pg0KPj4gVGhpcyBhbGxvd3MgYm90aCBQQ0FQIGFuZCBJQ0FQIGludGVyZmFjZXMgdG8g
YmUgdXNlZCBmb3IgUFIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWlrZSBMb29pam1hbnMgPG1p
a2UubG9vaWptYW5zQHRvcGljLm5sPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZnBnYS96eW5xLWZw
Z2EuYyB8IDQgKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS96eW5xLWZwZ2EuYyBiL2RyaXZlcnMvZnBnYS96
eW5xLWZwZ2EuYw0KPj4gaW5kZXggMzExMGUwMC4uZjZjMjA1YSAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvZnBnYS96eW5xLWZwZ2EuYw0KPj4gKysrIGIvZHJpdmVycy9mcGdhL3p5bnEtZnBnYS5j
DQo+PiBAQCAtNDk3LDYgKzQ5NywxMCBAQCBzdGF0aWMgaW50IHp5bnFfZnBnYV9vcHNfd3JpdGVf
Y29tcGxldGUoc3RydWN0IGZwZ2FfbWFuYWdlciAqbWdyLA0KPj4gICAJaW50IGVycjsNCj4+ICAg
CXUzMiBpbnRyX3N0YXR1czsNCj4+ICAgDQo+PiArCS8qIFJlbGVhc2UgJ1BSJyBjb250cm9sIGJh
Y2sgdG8gdGhlIElDQVAgKi8NCj4+ICsJenlucV9mcGdhX3dyaXRlKHByaXYsIENUUkxfT0ZGU0VU
LA0KPj4gKwkJenlucV9mcGdhX3JlYWQocHJpdiwgQ1RSTF9PRkZTRVQpICYgfkNUUkxfUENBUF9Q
Ul9NQVNLKTsNCj4+ICsNCj4gDQo+IFNob3VsZG4ndCB0aGF0IGJlIGFmdGVyIHRoZSBiZWxvdyBz
dGFuemEgdGhhdCBlbmFibGVzIHRoZSBjbG9jaz8NCg0KSSdtIGFjdHVhbGx5IG5vdCBzdXJlLCBh
bmQgSSBkaWQgbm90IGVuY291bnRlciBhbnkgcHJvYmxlbXMgd2hpbGUgdGVzdGluZyANCnRoaXMs
IGJ1dCBpdCdzIGVhc2llciB0byBqdXN0IG1vdmUgaXQgdGhhbiB0byBmaW5kIG91dCwgc28gSSds
bCBnbyBmb3IgInllcywgDQpsZXQncyBlbmFibGUgdGhlIGNsb2NrIGZpcnN0Ii4NCkknbGwgYXdh
aXQgYSBiaXQgbW9yZSBmZWVkYmFjayBhbmQgcG9zdCBhIHYyIGZvciB0aGF0Lg0KDQo+IA0KPj4g
ICAJZXJyID0gY2xrX2VuYWJsZShwcml2LT5jbGspOw0KPj4gICAJaWYgKGVycikNCj4+ICAgCQly
ZXR1cm4gZXJyOw0KPj4gLS0gDQo+PiAxLjkuMQ0KPj4NCj4gDQo+IENoZWVycywNCj4gDQo+IE1v
cml0eg0KPiANCg0K
