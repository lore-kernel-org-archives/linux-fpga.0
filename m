Return-Path: <SRS0=9Rfz=KK=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=9Rfz=KK=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mail-eopbgr720079.outbound.protection.outlook.com ([40.107.72.79]:19642
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728737AbeGZGgD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 26 Jul 2018 02:36:03 -0400
From: Appana Durga Kedareswara Rao <appanad@xilinx.com>
Subject: RE: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
Date: Thu, 26 Jul 2018 05:20:45 +0000
Message-ID: <CY1PR02MB16924F2F3373AD7EB059A088DC2B0@CY1PR02MB1692.namprd02.prod.outlook.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
 <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
 <CAAtXAHeVXw4BT7XF+Mu=nR9U9nK=nR_+x+JKSQU1owwPbt_HPA@mail.gmail.com>
 <CY1PR02MB169273A09D4E675A7671375CDC550@CY1PR02MB1692.namprd02.prod.outlook.com>
 <CANk1AXRYX+7hkm93r0maHz1e1Uh-gTKzs==1xjd_CZPQqBLSyA@mail.gmail.com>
 <CY1PR02MB1692876485F0557FE798C2D9DC540@CY1PR02MB1692.namprd02.prod.outlook.com>
 <CANk1AXTvVQz5PpX_HqWQ2SKJePizbk6JmHyp3mOAZ0DZA=en5Q@mail.gmail.com>
In-Reply-To: <CANk1AXTvVQz5PpX_HqWQ2SKJePizbk6JmHyp3mOAZ0DZA=en5Q@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Nava kishore Manne <navam@xilinx.com>, Michal Simek <michals@xilinx.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

SGkgQWxhbiwNCg0KCVRoYW5rcyBmb3IgdGhlIHJldmlldy4uLg0KDQo8U25pcD4NCj4gPiBJbiBa
eW5xIENhc2UgaXQgc3VwcG9ydHMgdHdvIHR5cGVzIG9mIHRoZSByZWFkYmFjayAoQ29uZmlndXJh
dGlvbiByZWdpc3RlcnMsDQo+IENvbmZpZ3VyYXRpb24gZGF0YShmcGdhIGltYWdlKSkgIHdoaWNo
IG1heSBub3QgYmUgdGhlIHNhbWUgY2FzZSBmb3Igb3RoZXINCj4gdmVuZG9ycy4NCj4gPiBTaW5j
ZSBJIG5lZWQgdG8gc3VwcG9ydCBib3RoIHRoZSB1c2UgY2FzZXMgSSBoYXZlIGRpZmZlcmVudGlh
dGVkIHRoZW0gdXNpbmcNCj4gbW9kdWxlIHBhcmFtIGluIHRoZSB6eW5xLWZwZ2EgZHJpdmVyLg0K
PiA+DQo+ID4gQXMgeW91IHNhaWQgd2Ugc2hvdWxkbid0IGNoYW5nZSB0aGUgYXR0cmlidXRlJ3Mg
ZnVuY3Rpb24sIFNvIGluIHRoZQ0KPiA+IHp5bnEtZnBnYSBkcml2ZXIsIEkgYW0gcGxhbm5pbmcg
dG8gYWRkIGFub3RoZXIgZGVidWdmcyBhdHRyaWJ1dGUgZm9yDQo+IHJlYWRpbmcgYmFjayBvZiBj
b25maWd1cmF0aW9uIHJlZ2lzdGVycyBhcyBpdCBpcyB2ZW5kb3Igc3BlY2lmaWMgcmVhZGJhY2sg
dHlwZS4NCj4gPiAgKENvbmZpZ3VyYXRpb24gcmVnaXN0ZXJzICAgICAgICAgICAgICAgICAgIC0t
LS0gIFVzYWdlOg0KPiAvc3lzL2tlcm5lbC9kZWJ1Zy9mcGdhL3p5bnEtZnBnYS9jZmdyZWdfc3Vt
bWFyeSkNCj4gDQo+IElzIGl0IGNhbGxlZCAnLi4uc3VtbWFyeScgYmVjYXVzZSBpdCBpcyBub3Qg
YWxsIHRoZSByZWdpc3RlcnM/ICBDb3VsZCBqdXN0IGJlDQo+ICJjZmdfcmVncyI/DQoNClN1cmUg
d2lsbCBtYWtlIGl0IGNmZ19yZWdzLi4uDQpBcmUgeW91IG9rIHdpdGggdGhlIGFib3ZlIHByb3Bv
c2FsPz8gDQppZiB5b3UgYXJlIG9rIHdpbGwgbWFrZSBjaGFuZ2VzIGFjY29yZGluZ2x5IGFuZCB3
aWxsIHBvc3QgdjQuLi4NCg0KPiANCj4gPiAoQ29uZmlndXJhdGlvbiBkYXRhKGZwZ2EgaW1hZ2Up
ICAgIC0tLS0gICBVc2FnZToNCj4gL3N5cy9rZXJuZWwvZGVidWcvZnBnYS9mcGdhMC9pbWFnZSkN
Cj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cyBmb3IgdGhlIHNhbWUuLi4NCj4g
Pg0KPiA+Pg0KPiA+PiA+IE9uZSBvdGhlciBvcHRpb24gaXMgc3lzZnMuIERvIHlvdSB3YW50IG1l
IHRvIGltcGxlbWVudCBzeXNmcyBwYXRoPz8/DQo+ID4+ID4gQW55IG90aGVyIHN1Z2dlc3Rpb25z
Pz8/DQo+ID4+DQo+ID4+IFlvdSBjb3VsZCBpbXBsZW1lbnQgYW5vdGhlciBzeXNmcyBhdHRyaWJ1
dGUgZm9yIHJlYWRpbmcgRlBHQSByZWdpc3RlcnMNCj4gPj4gd2l0aCBhIHNlcGFyYXRlIG9wcyBj
YWxsYmFjay4gICBQbGVhc2UgY2xhcmlmeSB3aGF0IGl0IGlzIGRvaW5nIChub3QNCj4gPj4gYWxs
IEZQR0FzIGhhdmUgdGhpcyBmdW5jdGlvbikgYW5kIHdoYXQgdGhhdCB3aWxsIGxvb2sgbGlrZSB3
aGVuIHRoZQ0KPiA+PiB1c2VyIHJlYWRzIHRoZSBmcm9tIHRoZSBzeXNmcw0KPiA+DQo+ID4gQUZB
SUsgd2Ugc2hvdWxkbid0IGFkZCBhbm90aGVyIHN5c2ZzL2RlYnVnZnMgYXR0cmlidXRlIGZvciB2
ZW5kb3Itc3BlY2lmaWMNCj4gcmVhZGJhY2sgdHlwZSBpbiB0aGUgRlBHQSBtYW5hZ2VyIG9wcy4N
Cj4gPiBQbGVhc2UgY29ycmVjdCBtZSBpZiBteSB1bmRlcnN0YW5kaW5nIGlzIHdyb25nLg0KPiAN
Cj4gWW91IGFyZSBub3Qgd3JvbmcgOikNCg0KVGhhbmtzIPCfmIogDQoNClJlZ2FyZHMsDQpLZWRh
ci4NCg0KPiANCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gS2VkYXIuDQo+ID4NCj4gPj4NCj4gPj4g
QWxhbg0K
