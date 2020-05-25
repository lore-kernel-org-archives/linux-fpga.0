Return-Path: <SRS0=MF9b=7H=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=MF9b=7H=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH v2] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
Date: Mon, 25 May 2020 02:25:18 +0000
Message-ID: <DM6PR11MB38194610D744865657EEB08385B30@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200519201449.3136033-1-jhubbard@nvidia.com>
 <64aa1494-7570-5319-b096-ea354ff20431@nvidia.com>
 <20200523205717.GA443638@epycbox.lan>
 <ccf86d21-2ecf-7873-1c30-fbea880b9081@nvidia.com>
In-Reply-To: <ccf86d21-2ecf-7873-1c30-fbea880b9081@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: John Hubbard <jhubbard@nvidia.com>, Moritz Fischer <mdf@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
List-ID: <linux-fpga@vger.kernel.org>

PiA+PiBIaSBNb3JpdHogYW5kIEZQR0EgZGV2ZWxvcGVycywNCj4gPj4NCj4gPj4gSXMgdGhpcyBP
Sz8gQW5kIGlmIHNvLCBpcyBpdCBnb2luZyBpbnRvIHlvdXIgZ2l0IHRyZWU/IE9yIHNob3VsZCBJ
DQo+ID4+IHNlbmQgaXQgdXAgdGhyb3VnaCBhIGRpZmZlcmVudCB0cmVlPyAoSSdtIG5ldyB0byB0
aGUgRlBHQSBkZXZlbG9wbWVudA0KPiA+PiBtb2RlbCkuDQo+ID4NCj4gPiBJIGNhbiB0YWtlIGl0
LCBzb3JyeSBmb3Igc2x1Z2dpc2ggcmVzcG9uc2UuDQo+ID4NCj4gDQo+IFRoYXQncyBncmVhdCBu
ZXdzLCB0aGFua3MgTW9yaXR6ISBTb3JyeSB0byBiZSBwdXNoeSwganVzdCBkaWRuJ3Qgd2FudCBp
dA0KPiB0byBnZXQgbG9zdC4gOikNCg0KVGhhbmtzIEpvaG4gZm9yIHRoaXMgcGF0Y2gsIGFuZCB0
aGFua3MgTW9yaXR6IGZvciB0YWtpbmcgY2FyZSBvZiB0aGlzLg0KU29ycnkgZm9yIGxhdGUgcmVz
cG9uc2UsIG9uZSB0aGluZyBoZXJlIHdlIG1heSBuZWVkIHRvIGJlIGNhcmVmdWwgaXMNCmEgcmVj
ZW50IGJ1ZyBmaXhpbmcgcGF0Y2gsIHRoYXQgZml4aW5nIHBhdGNoIGhhcyBiZWVuIG1lcmdlZCBi
eSBHcmVnDQppbiBjaGFyLW1pc2MtbmV4dCB0cmVlLCBhbmQgbWF5IGhhdmUgc29tZSBjb25mbGlj
dCB3aXRoIHRoaXMgb25lLg0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9ncmVna2gvY2hhci1taXNjLmdpdC9jb21taXQvP2g9Y2hhci1taXNjLW5leHQm
aWQ9YzlkN2UzZGExZjNjNGNmNWRkZGZjNWQ3Y2U0ZDc2ZDAxM2FiYTFjYw0KZnBnYTogZGZsOiBh
ZnU6IENvcnJlY3RlZCBlcnJvciBoYW5kbGluZyBsZXZlbHMNCg0KSSBndWVzcyB3ZSBuZWVkIHRv
IHJlYmFzZSB0aGlzIHBhdGNoIG9uIHRvcCBvZiBpdD8NCk1vcml0eiwgZG8geW91IGhhdmUgYW55
IHN1Z2dlc3Rpb24/DQoNClRoYW5rcw0KSGFvDQoNCj4gDQo+IHRoYW5rcywNCj4gLS0NCj4gSm9o
biBIdWJiYXJkDQo+IE5WSURJQQ0K
