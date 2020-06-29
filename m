Return-Path: <SRS0=Izh2=AK=intel.com=hao.wu@kernel.org>
Return-Path: <SRS0=Izh2=AK=intel.com=hao.wu@kernel.org>
From: "Wu, Hao" <hao.wu@intel.com>
Subject: RE: [PATCH] fpga: dfl: improve configuration of dfl pci devices
Date: Mon, 29 Jun 2020 03:12:53 +0000
Message-ID: <DM6PR11MB38196ED29A3E0BBAD7B246C1856E0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20200628151813.7679-1-trix@redhat.com>
 <20200629021924.GB2620@yilunxu-OptiPlex-7050>
In-Reply-To: <20200629021924.GB2620@yilunxu-OptiPlex-7050>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "Xu, Yilun" <yilun.xu@intel.com>, "trix@redhat.com" <trix@redhat.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
List-ID: <linux-fpga@vger.kernel.org>

> -----Original Message-----
> From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
> On Behalf Of Xu Yilun
> Sent: Monday, June 29, 2020 10:19 AM
> To: trix@redhat.com
> Cc: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; Wu, Hao <hao.wu@intel.com>;
> matthew.gerlach@linux.intel.com
> Subject: Re: [PATCH] fpga: dfl: improve configuration of dfl pci devices
>=20
> I think maybe we don't have to select them all. It is now possible for
> FPGA DFL boards to work without FME or AFU, providing limited
> functionality. It is possible designers trim the bitstream for their
> purpose, and also need a smaller driver set.
>=20

Yes, we hope that this dfl-pci could be a common module shared by
different cards. Some device doesn't have FME, e.g. some VF device
with AFU only, some device has FME, but no PR support, and in the
future, it's possible to add new modules, or something replacing AFU
or FME, so we don't have to select all here.

> I think we may add "default FPGA_DFL" for FPGA_DFL_FME,
> FPGA_DFL_FME_MGR and others to make life easier.

It's hard to say it's easier for everybody, e.g. I am a user of N3000, but
I have to unselect the PR modules, as they are default Yes as proposed?
Maybe it's better to let user select what they want, unless we find
something really common needed under DFL framework.

Hao
